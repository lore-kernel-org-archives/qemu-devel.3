Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37DBCCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI01M-0001fP-4M; Sat, 17 Oct 2026 04:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01K-0001eO-3g
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01I-0007CB-QZ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTfNtA0cMcFBvmJmHhpdQb1jobNfuBhHtBdvBGXXPDM=;
 b=FWchKoyOy896suMBKCxnauR/opewXVA6ISozJA4a1FvTkh2nXJtAPTqdBGt+qsPGpBsv/J
 W00OdLTYkPukWhWo8ygtbJZRMlv87SXvAyp8MV07/0kVIf50/w3kBemCe7sGc4551VYunV
 DrYxL34xBl6k8Fq4XSxG2H8LDxMKly8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-ERJ3qihoPhqaYocfnE8GcQ-1; Sat,
 17 Oct 2026 08:43:56 +0000
X-MC-Unique: ERJ3qihoPhqaYocfnE8GcQ-1
X-Mimecast-MFC-AGG-ID: ERJ3qihoPhqaYocfnE8GcQ_1792226635
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19ED01955D86; Sat, 17 Oct 2026 08:43:55 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4515B30000E7; Sat, 17 Oct 2026 08:43:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 17/23] target/i386: implement get_note_size sysemu
 op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-18-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-18-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656907.1619676.17101491087965409042.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=e/h06I4NyAH0mBC9++MLSBfn2VSwlvDl3Yiv5sIvHLM=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGrTNQ2hrELYdiO0v2Xh3na+Dy9/fq4Pz1ykmjl889UGzN/Le
 IkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJq0zUNAAoJENro4Ql1lpzlfBYQAKym
 jxmncqd0/7ImlUWZo0rA5LRaLycNZegT4GUy+w3VhnIIs0w1+05HaeqwMSc43lmZtFYYLWms8bQ
 e3wIuqwj/RC2wLHzJHVA6IFJSaFZzeWY2mVghnzCHu/u/YWonDbE16zQJLcPJqW9htCRvyF68at
 LGBfFn28uWHgHialopBDZcZ4NAcPoEk+Zp/270cVeJWgwU0NNGCaGhtnTuvIVKYukra/D/FxvHx
 lPqr4QxgKFOiBKzPLanMnYqZrZhdpMX0WB2BgZ8ZwKllebpL/gg/8N8lRX/yYCVvJzh/JEi1e8w
 UBiZTd9XEfEFIRbpzZyC7kOO+LGqGwKQrn8BJrv1L7Q6c7sOeHvEldwLM97vLdlr9Mtw2oVMoXh
 sY9UitJa+cCAD7ucPsDGfUcWzyMwvFocDpwp+jmf7sFYwXBLzzdCQc0R+Sk3JnxYv5Kt13iVXaA
 Wp876qQ0x7xISsQl8ELlXfeRF/W0zsNFDzcco/j9PyS8YYezP7e89wTnVQFECcRvBCuEMEzlNsU
 vP3jC5/lPPEK+3TUD8JWwt/7OLFs2Cveq/00AWqhlWmEYO5oHrIbGd4GihzVgNVt6pFLs+EW79B
 JrrQltaCWOpH9x0HMEV4IH4QyBXPzT3ILADH3o0dD3LEx6h+DQFTiWY46edV8DxWeNmJB2y1UWB
 HBx3q
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Fri, 16 Oct 2026 11:14:04 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


