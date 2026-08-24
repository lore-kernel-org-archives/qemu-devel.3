Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6C7C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQlQ-0004ss-JE; Mon, 24 Aug 2026 05:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wyQlN-0004sW-Cx
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wyQlK-0004h7-RL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787562871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/ALitoBbFy8z4IezdOIagA907yJRPr1JzeDhq5Do8U=;
 b=AF35+/cxg1OVWkh0J/3McnIxv5SvPT0EvwbvdP0b0/XOBuDVsDsY+DcT66jA5TsFcobsrg
 dzJ6+e8kD3BnWg+xO/8w1XCapNWgOK90T6C+UsGSJqjSSNrpf9rVa7bk+xL2oWERL4TtWT
 AYbGGwqWUR6zmEAS7V+OHc+uH30UDwA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-IOoHxFCJN5ClOchiZsJteQ-1; Mon, 24 Aug 2026 05:14:28 -0400
X-MC-Unique: IOoHxFCJN5ClOchiZsJteQ-1
X-Mimecast-MFC-AGG-ID: IOoHxFCJN5ClOchiZsJteQ_1787562867
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbedb8673ceso2975293a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787562867; cv=none;
 d=google.com; s=arc-20260327;
 b=J+SX6T1Sks8eP/pC6on25vyk1ckfnQpSmmnRRfRVUZMkmgNNa47x9n8hnu4jUspc0C
 4o91lbXu/MgrAnwTzd8YthkKIzf05FWLUwtJ4aJItlSmsOXg+dRiXgJJNZVSFxCxYzSi
 hSgxAlxafwlWPR16Hfamyw1C3bI2QiGpePtjnMSHw/tioolQoHUC9ML2Z0YkXVOHmNEZ
 qeW+Qy49IWimDJHxM8q4tDhEQGGx+GWwRMgXBPteqlZ7I7hgu+/81tv6x8pmYELdYrx8
 r5u19CkuZcoENRXdPhsDrw6SEbeP6O+WxKaIcmbPH29GHlMhERiJgIrZcA5sDSezvg+T
 yvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T/ALitoBbFy8z4IezdOIagA907yJRPr1JzeDhq5Do8U=;
 fh=ql45W2LQjIeaZ/xZ4+VidjmDW/ISdwhCg0IQSuz3z5Q=;
 b=bZyk2QgrvF7cKG6rKx1XZqJIEOVa612bIOpa6e4UZVIB91xG5NvvdOGigVKcnfgGM8
 0Rt1s+UcSFHuLZFg8JJTQi22mxjsSSbJvMGC1C/LniCOeoFi5w3qYfJeiONUzJfNv9k8
 Of6Rpi/xz5mTQ47L/pQjoI+yV3agldpqq/wRCswDnRnFzuKTXkHyPrq5bopHflx1x8yG
 OTWwdKmREf7502XJpGOZCvG5XbTlItdnQDCSUwBovyBD9vF7uJ+nsByRR9bWs1WG4H0a
 6/Rwpx/CTxif2xqzbVOuecJRD8mUsYAYMH6YUnNXZ6LFabTeeZOuXbx/CVE+J/dZmltd
 hLSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787562867; x=1788167667; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T/ALitoBbFy8z4IezdOIagA907yJRPr1JzeDhq5Do8U=;
 b=S1a9Xx+6X+uQ25xeqz9x+C0wg+IlL+UxPfJ6CpsL7iP8spE6rupXh4yakDKJPR7xqQ
 B5dWPfnyXvT049Uu3/3cXlQzww+rcIIbkryL+TGqcG0L50FY3vVc28j9HIlBONyHPfRF
 Hnwz/3OLYIBRpnhBpi+HDTbcWhQHgGWfYwv4b+jSZs2VWao1ONYnq5aHar1Ek1tcPuxx
 HZg/xzpLeF9P8DbWHQq9w/BehGyVn6u5ahRi817nsxIwU1c/A1SW1AGbX4zzQOt2NWlT
 lEUoyyEp9RAYbsdDL2m2bMDs/byg8h40L5QDTb5t16wgsTsTMLjxLfAQeIEbHVKW02p7
 lzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787562867; x=1788167667;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T/ALitoBbFy8z4IezdOIagA907yJRPr1JzeDhq5Do8U=;
 b=QA257/CblncBLwboiPRw1KZg2AcqIPgEUcVv7L1P0ThO+fU23G6mdGR5gcz6sG80A8
 D2fW225BUOuvF792rTqg5AeHtkFzrc41yeDAMQHFLoQ7ZkKr5jNx5KZRo7VDVUqdxPtj
 gN14+NCEw87r0NtCWlMDfyv3plmOnd7GdtIsjSFiTQxBXa0jesqh6VR784wz4iiWv0bu
 tLVEIDTuAj75qPeuxKmMtB++7u2GjnMyGdzyg3i/XzNq8jxBaewRv73fKcLUQDtQZNdu
 ITsfe/zi9OW0DI1Fge1P43QhwSwMIVyC18AuTe353M9zAnIBExAP5oZl9e+y/KQRsqbK
 WYpw==
X-Gm-Message-State: AFuF++m+ora8c1U41m8+lvzIGKqUejCcQO4a7U1t0q1Ev1Y9qX5iKtxl
 mevNJj0Vkhet3BUNRfGdboDcvV2zsbZ0odFDlMr67Y6KSNc6hKJNRVybebvUOZ4w6uxcrmnPrn8
 Ymd9m/5lUXKv7XCsA3qvAC0/gjBjnHJWC6EugfEJC2Eb591om9Xu84t/N62YfBqqfUje9M/UR+B
 P6L46hQct2k5Tv73yfYpI7UmC29DZK0qbUFY9ryZc=
X-Gm-Gg: AR+sD10n+BphlE7WIlyPr79AdM22yl6qzuGZYDmm7ztMGnlRaQCq8cfCxdjxCvwYPK5
 bv7bnBDCnWi9uk3jQrvwkqngdQMYx1aTQc+SQYtgt2iMW8fuekiIUasnS21QgttopmC7caLTwh+
 4EZohRsVMfeMXOjjWpNkY9ecBvzcnGp+Xm9qG8uF16iP1eJSrSiqTxS5Lb3+P2BvPyia0ZmEW1t
 MJJEkAjkV/xgDYHmyn7UlL5O9w46o2ue0dYL6Ni6cwo66cNStSm2KF6Y0/2E2VKzyp+iNw317oj
 wA==
X-Received: by 2002:a05:6a21:e584:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3cd2fd4d78amr50711487637.2.1787562867358; 
 Mon, 24 Aug 2026 02:14:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:e584:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3cd2fd4d78amr50711405637.2.1787562866933; Mon, 24 Aug 2026
 02:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <vga-v2-20260823.sinxx198@gmail.com>
In-Reply-To: <vga-v2-20260823.sinxx198@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Aug 2026 13:14:14 +0400
X-Gm-Features: AcwNN1WBR4lL6GZ6aL35tVSVGjqVsW962dnjrVOXk8pafNKzHaiFqEH-dR8drPw
Message-ID: <CAMxuvaySFoRqkz2UpWNeooBaqouyMLaZy9N38UbykQ38j3NWgQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/display/vga: fix text-mode OOB write after a
 graphics surface switch
To: Warisjeet Singh <sinxx198@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi

On Sun, Aug 23, 2026 at 8:41=E2=80=AFPM Warisjeet Singh <sinxx198@gmail.com=
> wrote:
>
> vga_draw_text() decides whether the console surface needs a resize from
> its geometry cache, but none of the cache terms observe the graphics
> renderer having replaced the console surface in between:
>
> - last_width/last_height are shared with vga_draw_graphic(), which
>   stores them in pixels while the text path stores characters;
> - last_depth stays 0 for legacy (non-VBE) graphics modes, because
>   vga_get_bpp() only reports a depth when VBE is enabled, so the
>   "s->last_depth" term that normally forces a resize after a graphics
>   frame does not fire.
>
> So a graphics frame that shrinks the console surface (e.g. 80x25
> pixels) followed by a text frame with matching character geometry
> (80x25 chars) skips the resize, and the glyph loop then paints
> width*cw x height*cheight pixels into the smaller surface, out of
> bounds, with guest-controlled (DAC palette) values, on every display
> refresh.
>
> Split the geometry cache per renderer so the units are unambiguous,
> and additionally make the text path compare the pixel size it is
> about to paint against the console surface's actual dimensions.
> The surface check is the load-bearing term: caches in either unit
> cannot see the other renderer swapping the surface, the surface can.
>
> Fixes: CVE-2026-77913
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4215
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
> ---
> Changes v1 -> v2:
> - v1 (split caches only) did not fix the reported reproducer: after a
>   legacy graphics frame (depth 0) the text predicate still compared
>   equal, because nothing in it noticed the console surface had been
>   replaced.  Keep the split for clarity, and add the surface-size
>   check which actually catches it (verified with the qtest PoC and an
>   ASAN build; without this patch ASAN reports a heap-buffer-overflow
>   in vga_draw_glyph9(), with it the run is clean).
> ---
>  hw/display/vga.c     | 13 ++++++++++---
>  hw/display/vga_int.h |  3 ++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index da0c331486..7a349dc738 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1241,7 +1241,10 @@ static void vga_draw_text(VGACommonState *s, int f=
ull_update)
>          return;
>      }
>
> -    if (width !=3D s->last_width || height !=3D s->last_height ||
> +    if (surface =3D=3D NULL ||
> +        surface_width(surface) !=3D width * cw ||
> +        surface_height(surface) !=3D height * cheight ||
> +        width !=3D s->last_text_width || height !=3D s->last_text_height=
 ||
>          cw !=3D s->last_cw || cheight !=3D s->last_ch || s->last_depth) =
{
>          s->last_scr_width =3D width * cw;
>          s->last_scr_height =3D height * cheight;
> @@ -1249,8 +1252,8 @@ static void vga_draw_text(VGACommonState *s, int fu=
ll_update)
>          surface =3D qemu_console_surface(s->con);
>          qemu_console_text_resize(s->con, width, height);
>          s->last_depth =3D 0;
> -        s->last_width =3D width;
> -        s->last_height =3D height;
> +        s->last_text_width =3D width;
> +        s->last_text_height =3D height;
>          s->last_ch =3D cheight;
>          s->last_cw =3D cw;
>          full_update =3D 1;
> @@ -1845,6 +1848,8 @@ static void vga_invalidate_display(void *opaque)
>
>      s->last_width =3D -1;
>      s->last_height =3D -1;
> +    s->last_text_width =3D -1;
> +    s->last_text_height =3D -1;
>  }
>
>  void vga_common_reset(VGACommonState *s)
> @@ -1887,6 +1892,8 @@ void vga_common_reset(VGACommonState *s)
>      s->last_ch =3D 0;
>      s->last_width =3D 0;
>      s->last_height =3D 0;
> +    s->last_text_width =3D 0;
> +    s->last_text_height =3D 0;
>      s->last_scr_width =3D 0;
>      s->last_scr_height =3D 0;
>      s->cursor_start =3D 0;
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index 5664317ecd..ca69ae9815 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -122,7 +122,8 @@ typedef struct VGACommonState {
>      uint32_t plane_updated;
>      uint32_t last_line_offset;
>      uint8_t last_cw, last_ch;
> -    uint32_t last_width, last_height; /* in chars or pixels */
> +    uint32_t last_width, last_height; /* in pixels (graphics renderer) *=
/
> +    uint32_t last_text_width, last_text_height; /* in chars (text render=
er) */

We should finish separating gfx and text state.
The text functions and paths should only manipulate
last_text_{width,height} (in vga_draw_text/update_text, and text path
in invalidate_display/common_reset)

>      uint32_t last_scr_width, last_scr_height; /* in pixels */
>      uint32_t last_depth; /* in bits */
>      bool last_byteswap;
> --
> 2.47.3
>


