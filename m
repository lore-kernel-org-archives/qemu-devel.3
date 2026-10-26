Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KO4EZ4/r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLEp6-000306-9D; Mon, 26 Oct 2026 03:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEp4-0002zh-AA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEp2-0000Zg-MP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792998523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2v9rtSRiCSNoaK+zBE8cRjsCd0mmerft0CFKMqNPP4=;
 b=KO4EZ4/rO+G5FjeJVFBmQCvw/A4D/rv78SZZyvM0nvor5wLYgO7kThlTsP2zW9FYG82KxX
 g1G8WT2Q2a0PUYK2LTkNGe2ssHciXvWtgKV0KcrArDKfEF+KWCosOdauK5BEWhflvNWkhA
 D1T7K6hjgPFmXfA7Lz0mZoGQn4BCO+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-WqnnDQleNOWnnI9SaZ6qjw-1; Mon,
 26 Oct 2026 03:08:39 -0400
X-MC-Unique: WqnnDQleNOWnnI9SaZ6qjw-1
X-Mimecast-MFC-AGG-ID: WqnnDQleNOWnnI9SaZ6qjw_1792998517
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C6931955E82; Mon, 26 Oct 2026 07:08:36 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 809FF7D5; Mon, 26 Oct 2026 07:08:34 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] hw/display/ati: fix integer overflow in Rage128 2D
 blit bounds check
From: marcandre.lureau@redhat.com
To: Tristan Madani <tristmd@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, hpoussin@reactos.org, arikalo@gmail.com, 
 balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de, pbonzini@redhat.com, 
 fam@euphon.net, mark.cave-ayland@ilande.co.uk, kraxel@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261025173625.3372689-2-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
 <20261025173625.3372689-2-tristan@talencesecurity.com>
Date: Mon, 26 Oct 2026 11:08:30 +0400
Message-Id: <179299851010.907607.286251028202128647.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VqjyBxU4iGYe+/J84gBvGfaBXmRGXXhmNodrWNmuxoE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3vxvSWOR8hw6Jlovn9O3QfqtnX+xglxBGGlVX
 LceZZEtRmWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCat78bwAKCRDa6OEJdZac
 5VG5D/9JB5jDiEc8+abC/9qbKsHKpi7QtYq5Bc8UQpTAoVoyqj2kWbYUUuwULSeP2IS5BiabQBy
 8vQJ4IftICwUTwEmjlDdy4INYF7YF5xhjaSrkvd8md5BHC+t2wLqsqDL8l2z8uI6NoZApqHlt+0
 qAsM8UGEP4UxZUrFw7IeoWt6VxfvJm2sLgj88adoabImptY8vqDMVs+JNT/vGxjCkvevV4apwSN
 XeJk82K3hDCHU+LTO9HCKCnILVyyaNug8i9J4BzW1QxLrWJhGRXlgbNfZ5i1bThMVQxAwkLpBAx
 Tt9w1whd8cmhCIQsjaGBsv+55B1LGaWMyHObJ8j3ZX9mjQby+KFFzTrsXIuDU3tu+CEJGLJVQsc
 2LRuy8bh/z06JFyfN8rv3s3HK+IlODOz7jp7bMv2ZlWwHoEIhYB6L5B52Yyk0U1JpqhTJw9O+jM
 xsowzXskq2ihus1wjn9WGcfhZR30Vc9zpdW/G1qbQ9HZc5Cz1J+fsWfKLSPi8+Barj8o3kaSzNA
 r+vkXSq/6sDkIceWjBSKQC1M/zqbf8DYtTb+Myu4vEGsrxT+BKt+EmoiFeQZnA8nHJvUI6vPzA4
 vbzTRLUo335OkICUluqgpnYmVpz742oqOJ1R8vX5/bdwcE4Xl9EIHDJx7a1p83TobtXqo6XZ0mI
 sDZjcCPqJ5+LaCw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The VRAM bounds check in ati_2d_do_blt() computes
> (dst.y + dst.height) * dst_stride using signed 32-bit arithmetic.
> On Rage128, setup_2d_blt_ctx() multiplies dst_stride by bpp (up to
> 32), producing strides up to 524,256 bytes/row. With large
> dst.y + dst.height values, the signed int multiplication overflows
> to a negative value, causing the bounds check to evaluate false
> when it should reject the operation.
> 
> The subsequent blit loop uses unsigned arithmetic for the same index
> computation, producing large positive offsets that write past the
> VRAM allocation into host process memory.
> 
> Fix by using uint64_t for the offset computation and comparing
> against the VRAM size (offset-based) instead of doing pointer
> arithmetic that can also overflow. Apply the same fix to the source
> bounds check in the SRCCOPY path.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4646
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> Message-ID: <20261025173625.3372689-2-tristan@talencesecurity.com>
> ---
>  hw/display/ati_2d.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 7a4a115aee22..b9933fe9c650 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -156,6 +156,8 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
>  {
>      QemuRect vis_src, vis_dst;
>      unsigned int x, y, i, j, bypp = ctx->bpp / 8;
> +    uint64_t dst_end, src_end;

src_end is never used.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


