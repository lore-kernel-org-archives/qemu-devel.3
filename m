Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19199606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e5MV89eK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLEpE-00032d-Vx; Mon, 26 Oct 2026 03:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpA-00031e-TD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEp8-0000aL-GK
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792998529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvMkxIO2FhxeBso9iJG/tkF2QCPBSPqg8G8fwl2Xne4=;
 b=e5MV89eK7eQnR0nkxjdJMAWq/KI56+RmehZbYpLAQULU3JHhdGP3fd/saaiCqN5QFeXhQN
 s2gT4J6L++wCnLYD3LbYIP9TuzHNZ5Xjh+6VkiaGfYiWzEdKq6Rz25wkSUQJYfvTPbUTBR
 SmkMb2QfBMLC99kEagaVF52FDqYD/E4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-Qa65LJAqMXG0PujrEV6f5g-1; Mon,
 26 Oct 2026 03:08:46 -0400
X-MC-Unique: Qa65LJAqMXG0PujrEV6f5g-1
X-Mimecast-MFC-AGG-ID: Qa65LJAqMXG0PujrEV6f5g_1792998524
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 588731955F28; Mon, 26 Oct 2026 07:08:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B67C30001A4; Mon, 26 Oct 2026 07:08:42 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/8] hw/display/g364fb: validate top_of_screen against
 VRAM size
From: marcandre.lureau@redhat.com
To: Tristan Madani <tristmd@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, hpoussin@reactos.org, arikalo@gmail.com, 
 balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de, pbonzini@redhat.com, 
 fam@euphon.net, mark.cave-ayland@ilande.co.uk, kraxel@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261025173625.3372689-4-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
 <20261025173625.3372689-4-tristan@talencesecurity.com>
Date: Mon, 26 Oct 2026 11:08:30 +0400
Message-Id: <179299851011.907607.16200893827428899333.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V8NQERNtZTxc7SbUTKMmOH//REEKjxH0CBy9Wn/3ipY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3vxw4fuThnSuwxM4tday5S5Bi6vTHUMTFXjk1
 fA1QOmS7f6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCat78cAAKCRDa6OEJdZac
 5VZxEACo50h2sXl9P5LKrw53MvbPjZxT4t9AbGRvipsQIdUZjrrbQUl7abHFslxBcLqW+AGgiKa
 OZpIxHtRieFFUSudOkyanC7i8L4yQHxiMgnUGaL/6KpHP9elSZqs0YeInaVBKepweFulMsw9bOU
 JVgiGAikPGEi7Rzv0FhO9TqcKcgkTWJPWwcdyIS42SsG3BHU5WsgovysPd4z0O5CJMYxKwWtlzy
 C9HWYhtkcP6EsWLCKBBEUDDNVnnUb6Ypon3DhMe6kT7NDVbtmjqpY1/XkbFT/Gj0gpf4gJyD9Ro
 eNeJoyDo6zib75gdcLeaDtDpk3XskPdcinLy9+zGEkEtYJKhXGg1qI13DXYeRoRI+ofV+eEqSFq
 le+cZSJwgKS7kPEk9F90uU5jC8ho+MKMvlxc2fyqczk4x2//igXnoou1SnUZYiLN/0ZYxU/GxvQ
 PXx2htSXcZI9J8nn1wo9aenocJ/9cKZPu9NNk6EaAP6HZMp4/7kNukw51kFau+UDCK1WPncftKd
 am+phU1pw4CoU7/Eb07QY1DpMkHBhuzVVUH+MIAG8Mlh+86+qmoYaJeB2ypITMT9DHGv9lu0cDF
 876qhshNWDRVfWrJQQkOyaFmVozBStf31d0DFkzLDKk5W4hKul1QMwQTmivewHevhkI4Z8JSts9
 4FQWp/PFe4dufeQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> The G364 framebuffer allows a guest to set top_of_screen to any
> 32-bit value without validation against the VRAM size. The display
> update function g364fb_draw_graphic8() computes its read pointer as
> memory_region_get_ram_ptr() + top_of_screen, reading past the
> allocated VRAM buffer when top_of_screen >= vram_size.
> 
> The developers flagged this exact issue with an inline XXX comment
> ("XXX: out of range in vram?") but never added the check.
> 
> Clamp top_of_screen to vram_size at the register write handler.
> Also add a safety check in the draw function.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4648
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> Message-ID: <20261025173625.3372689-4-tristan@talencesecurity.com>
> ---
>  hw/display/g364fb.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
> index af54f1f90058..77e6646db53a 100644
> --- a/hw/display/g364fb.c
> +++ b/hw/display/g364fb.c
> @@ -126,7 +126,10 @@ static void g364fb_draw_graphic8(G364State *s)
>      }
>  
>      vram = memory_region_get_ram_ptr(&s->mem_vram) + s->top_of_screen;
> -    /* XXX: out of range in vram? */
> +    if (s->top_of_screen >= s->vram_size) {

This only validates the base address. The loop reads s->width * s->height bytes
from vram, so top_of_screen = vram_size - 1 still results in an out-of-bounds
read. Check the full window, using 64-bit arithmetic because width and height
are guest-controlled, e.g.:

    if ((uint64_t)s->top_of_screen +
        (uint64_t)s->width * s->height > s->vram_size) {
        return;
    }

Also consider doing the same validation when REG_DISPLAY/REG_VDISPLAY
change, since a previously valid top_of_screen can become invalid when
the resolution grows.

> +        return;
> +    }
> +
>      data_display = dd = surface_data(surface);
>      snap = memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0, s->vram_size,
>                                                    DIRTY_MEMORY_VGA);
> @@ -404,6 +407,9 @@ static void g364fb_ctrl_write(void *opaque,
>              break;
>          case REG_TOP:
>              s->top_of_screen = val;
> +            if (s->top_of_screen >= s->vram_size) {

Clamping the base alone does not prevent top_of_screen + width * height from
exceeding vram_size; a guest can simply write vram_size - 1 here and keep the
OOB read. Either reject the write or validate the complete window as suggested
earlier

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


