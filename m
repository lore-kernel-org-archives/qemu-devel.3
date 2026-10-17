Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA255CCF2CA
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00s-0001SE-Ah; Sat, 17 Oct 2026 04:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00q-0001Rf-2V
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00o-0007Ac-NM
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdS69NmmhdHm/58PK/bvZz4vwCHTliMtVfX5dxoiDCw=;
 b=brD01uaetgZVih1Jfsb8oEZYZ+VKbjKqxUnjxOLR/KhGGeKMA5lKzf8/QQsvEAE113I1TY
 6tp4lni1gYJ88ZK/oCAcjNqDv034eRrraJaAz02ySZnTyqS4DjQKpeuKbhA3U7hW5bG2xl
 vMhhqV5oaME4EH/Dqa3J25WOKhIzE4Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-uOW0jno9PPGs6aUQzUU4bw-1; Sat,
 17 Oct 2026 08:43:28 +0000
X-MC-Unique: uOW0jno9PPGs6aUQzUU4bw-1
X-Mimecast-MFC-AGG-ID: uOW0jno9PPGs6aUQzUU4bw_1792226607
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E77619560B4; Sat, 17 Oct 2026 08:43:27 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 801731800446; Sat, 17 Oct 2026 08:43:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 09/23] target/ppc: implement get_dump_info sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-10-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-10-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656901.1619676.7489977758207764749.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kg+b+chhY4xg+KqCY7B0Oxb3EY6B4RmGItl/LQkDK0w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUMCxGl/BDqGS060/J1+ic3Mi8bGmZeE8hXx
 p7LAG75GPKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5blGD/4pQXVWEnfbovBhY6Ylp6sUjRJnPZRDe/3Ah9NgNugtG2H9+8+JubaJ6aMaSHfDT8kjAOs
 TB5vq0FqCwssWZ1oXrS8LKegfB2J1j/zC7jD591wTCdARj7wrGyLFaG25k3RcQ3CoxzpiDhUTEh
 MLDtXqIp77lqheocLvmfyieFLtlT3LR/LYuneL5+mx4Rypv3AHW1eEJkeX9/wojTbNn/lUxZZvJ
 dZE16PnOzE8PZjzF53Gp4LMXusnbQl/EYKUxFO4bcwGp0GbtLKGMqcTJHWCP6BTlrBtv33lrGDx
 8Fug5wpcatVaTj7GGwAv4wIwmtdZSOYlEDmuBB1K36sCAeBHtaqIoFWpX+71rZlBUaDnLX3bJwk
 /YhFzbDaw+7Z8f0ZvyC7aP54IVcWybZPt9TzHzGos1AoFCyfOah34bnT5ERucqyQO31JeiHwhPa
 myO/NIUuFNrEF3uAgsJOXRux6EPr84uRUxtZw5OOzHdKUeUwsX6u6PNe4CjbO/wpYQ6SVpx7DSU
 2r5TE9JPuDWEoLWx4vROWqvrmDJMDKmyahufgHTF4HhM4m5oBDcmQ6f8/GKv079a8/jlwghOzzZ
 s9SM6bkNLVIu/RX5EfUvrxBFUACZUYnjir60t+qKCXYZQWHjm/CtJQJy6PYk+EHOhcjPaGQumMJ
 CTLslsYLmTeGm0g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 16 Oct 2026 11:13:56 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


