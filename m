Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B194CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGalc-00044m-9h; Tue, 13 Oct 2026 07:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGala-00044e-TH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGalZ-0005Ft-MB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791891236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9Gc9h/5UkM7rB0PruF6lTJR+XH9wWtuhOWnt3DR++M=;
 b=fERgmfm5wNX6PhoyY6/MYcaPc+6NLkBO1DLsw+5BwtE7GuNtRQZL8U93pO2tTN3vVeRkC0
 EUwrjitBm5bSq4asRDr0kIiGfBHdZ1+w4SvgUyapV5UvOsGvqvWennmmDToga7brSF0ffl
 rNcxK1eCn1VBpj1+C6kUGlmDR03XxVE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-3fFTwlmfNeqzXOmzwfoQ3Q-1; Tue,
 13 Oct 2026 11:33:53 +0000
X-MC-Unique: 3fFTwlmfNeqzXOmzwfoQ3Q-1
X-Mimecast-MFC-AGG-ID: 3fFTwlmfNeqzXOmzwfoQ3Q_1791891232
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67EB91954B3B; Tue, 13 Oct 2026 11:33:51 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2750E3001D21; Tue, 13 Oct 2026 11:33:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] virtio-gpu: fix memory leaks in virgl and rutabaga
From: marcandre.lureau@redhat.com
To: Tom Desnoyers <tom.ds1@gmx.com>
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com, mst@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, qemu-devel@nongnu.org
In-Reply-To: <20261012165754.11891-1-tom.ds1@gmx.com>
References: <20261006135504.416083-1-tom.ds1@gmx.com>
 <20261012165754.11891-1-tom.ds1@gmx.com>
Date: Tue, 13 Oct 2026 15:33:44 +0400
Message-Id: <179189122487.2643111.17470296223260784506.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=582;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GsZYPyq8pbITdrl93xuOrJYlGSe9aNkT/ViQb4qf3UE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzhcagGl2SELclpIIo7ClrsaOoIbekdwFdPb8a
 oY/ksDsPSSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4XGgAKCRDa6OEJdZac
 5UhVD/oDlb2lBZUBkPr93kD/HRHgMdtORCgm3OdEoxEN5/M3UlewdE9C9kRgwwJL6BuPOwSNSQb
 DHMjnHdSJUGXzvZnNFXblS1jQJ73vhtZClbYczQKjEVosQoA5DUTXO8hQfey0ujxdpqzoS0zicI
 Bs4hgIGWXynklCqsoYiExXqGt2tvSkbGcQ+WeOcrAQPrUEd9Ve8CCIdJJBruvA3uXkoKzKxJOje
 mjs6fYaC+iPllDl6p/pd/aR0AFI0zKvEQnjPAHneKiKxjDSDfXoZkWvyGonxwGfjECIBnZ0xp9a
 kPFc+eoA8c/g/6PDWZy63XkHv2REbmfxX/WEeSa8opbQ+Pfg2vdBqno7taNAopJjOCIPTN2HS+V
 WhCDt8FFmaPJvBvn+A0mAvE3bDFyBZTv0LQ1+yNk0kSolCdG6biWc1EXPZ2Q1szT4h/PfCQMmhJ
 UGc44HFTbvteNsntr47G4HdfUObXJUEFQxXun2wvImt9g/yziIwOFKvlaP+dYx+2A/p6lKZcSTb
 MWOJNsbP1b4rebNhm4N4tplYSiB9ciiQ36CaR9Y/CAUZEvZE7q8SUZBIETnKsvYvuiodtntNmpj
 +ZKT8evXDVcIie3dalF/wbO+9F2QkfwVl8nruQin4svWz7kaMxQSvPaKMzXgvSj4ccDlhVnpHEP
 7JT17Ba7HH9onGA==
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

On Mon, 12 Oct 2026 18:57:54 +0200, Tom Desnoyers <tom.ds1@gmx.com> wrote:
> When a gpu buffer backed by a guest-memory blob is unreferenced, virgl
> and rutabaga free the resource but not its addrs field, leaking memory
> on every unref.
> 
> In virtio-gpu-virgl.c, call virtio_gpu_cleanup_mapping() instead of
> virtio_gpu_cleanup_mapping_iov(). In virtio-gpu-rutabaga.c, call
> virtio_gpu_cleanup_mapping() before freeing the resource.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


