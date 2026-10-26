Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CB606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jn3Y1Pdn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLEpY-00038C-8E; Mon, 26 Oct 2026 03:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpG-00033v-PX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xLEpE-0000bS-TU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792998536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psq09B+ggswfei2F8VXGZ0tE83Z+zGqLMGP6NpZ7kis=;
 b=Jn3Y1Pdn+NRQ2zjdvtB7q3O/sAaa8NV/hI9cTf6TOs2hOaO1DHrCqIjrPro3OF72wOMPAw
 rBI2UbSAoue4rqp2uneR2e9ZbCxnxZ69MQOTw9kvYA7Iz4s93ULSxDG/LfKh6+VaL8oYRe
 kX2VbNBrsHunt9hok6FPFgtdd8sLFRk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-8RqTIGQRPy6HqthE5M1R4Q-1; Mon,
 26 Oct 2026 03:08:50 -0400
X-MC-Unique: 8RqTIGQRPy6HqthE5M1R4Q-1
X-Mimecast-MFC-AGG-ID: 8RqTIGQRPy6HqthE5M1R4Q_1792998528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5EEA1956058; Mon, 26 Oct 2026 07:08:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6A3B1956086; Mon, 26 Oct 2026 07:08:46 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 4/8] hw/display/sm501: validate framebuffer and cursor
 addresses
From: marcandre.lureau@redhat.com
To: Tristan Madani <tristmd@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, hpoussin@reactos.org, arikalo@gmail.com, 
 balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de, pbonzini@redhat.com, 
 fam@euphon.net, mark.cave-ayland@ilande.co.uk, kraxel@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261025173625.3372689-5-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
 <20261025173625.3372689-5-tristan@talencesecurity.com>
Date: Mon, 26 Oct 2026 11:08:30 +0400
Message-Id: <179299851012.907607.16459336965079639776.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2921;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Un9I92RmqRCNARhgFmplMmPdmwJZZq8CQkuEFyOKm+8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3vxwGTNK/D9kRQ0+IuJTsLd1f6OMcClNjjqv6
 FZx3wPnY6aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCat78cAAKCRDa6OEJdZac
 5UgqD/40ApQYcU/JZBH0KdVU109rAtvgbAdz5Y+WaGupDUYHWfMAUIo+IzkHSvS/ThKh6WJzquD
 mLAbs8JNqKdEKekvBZJT9bBEdGbTSV+8bfxE4Tswy3h5l1EgcVZvajyvAGL5yP8A9I39du9RC4I
 2GVSEAcNWHt9mUYYwBHmCSSKxCI177H9qs+9CBABV/e4oTLB369gEb7CwSeLwlafHOF/SLchQwe
 LMEv5R8VpAXv/+2PJxj7Mq+OnTyrEcMZ109gzDr4TynTXZ3GsItSm0IsBv5Cm8bW3NWXAo7tZex
 BiWHlhuYnOlT/q6CgcXg2xSBdA2IIMqqIWKrhFKL4C/3LA5sBg0rHIZk68dbGb/i5DP+Erwvppp
 joYRpUB4NvajieL0bPyI+dKlGujkyZP0h5t8N4FqaPzJjc/5BVZxsS805Mwmw5PkI2Nu6ePFhpp
 N/5xi1cXtRRIAUc0XMSL570WbP/skWfL9BxdfYb4BJ/imVa9W8mnRbnNRRrLE4q2I0VxJtpgKb/
 Uk17ZjvOVv0kV7mjvv4/m40lceWs4H4FHHxwsG4RHKFdy8H7BHwMI1JjP/ghL0t3X9+HG5HpgRS
 ZCrW4s2fBLQ8xLVcmZfdYrAsV//mLdlgxehA40Q8cccpGpMsLUzCO8SFZtqakBdc5Ndu4k9O2tq
 xM8hqGtdTYDBQLw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

> The SM501 display controller allows a guest to set the CRT/Panel
> framebuffer base address and hardware cursor address to values up
> to ~64 MB via the 0x3FFFFF0 mask. With VRAM sizes as small as
> 2-8 MB, these addresses exceed the actual VRAM allocation.
> 
> sm501_update_display() reads pixel data from local_mem + fb_addr
> without bounds checking, and the hardware cursor path reads cursor
> pattern data from the same unvalidated address.
> 
> The 2D engine path already validates VRAM bounds via
> sm501_rect_outside_vram(), but the display rendering path has no
> equivalent check.
> 
> Add bounds validation in get_fb_addr() and get_hwc_address() to
> clamp the returned address to within the local memory region.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4649
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> Message-ID: <20261025173625.3372689-5-tristan@talencesecurity.com>
> ---
>  hw/display/sm501.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index cacb6c87ec9b..b8e686a7d62a 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -592,7 +592,12 @@ static void set_new_local_mem_size_index(SM501State *s, uint32_t idx)
>  
>  static ram_addr_t get_fb_addr(SM501State *s, int crt)
>  {
> -    return (crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr) & 0x3FFFFF0;
> +    ram_addr_t addr = (crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr)
> +                      & 0x3FFFFF0;
> +    if (addr >= get_local_mem_size(s)) {

This checks only the start of the framebuffer. sm501_update_display() reads
width * height * src_bpp bytes from this address, so a base such as
local_mem_size - 16 still passes and the display path reads past the allocation.
The display path needs the same extent validation that sm501_rect_outside_vram()
performs for the 2D engine, preferably with 64-bit arithmetic, instead of
silently redirecting the base to 0.

> +        addr = 0;
> +    }
> +    return addr;
>  }
>  
>  static inline int get_width(SM501State *s, int crt)
> @@ -630,7 +635,12 @@ static inline int is_hwc_enabled(SM501State *state, int crt)
>  static inline uint8_t *get_hwc_address(SM501State *state, int crt)
>  {
>      uint32_t addr = crt ? state->dc_crt_hwc_addr : state->dc_panel_hwc_addr;
> -    return state->local_mem + (addr & 0x03FFFFF0);
> +    uint32_t offset = addr & 0x03FFFFF0;
> +
> +    if (offset >= get_local_mem_size(state)) {

The hardware cursor pattern is 64x64 2-bit pixels, i.e. SM501_HWC_WIDTH *
SM501_HWC_HEIGHT / 4 == 1024 bytes starting here. offset == local_mem_size - 1
passes this check and draw_hwc_line_32() still reads past local_mem. Require
offset + 1024 <= get_local_mem_size(state) as well.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


