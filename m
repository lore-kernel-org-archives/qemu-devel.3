Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B53C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wybWe-0007jR-0T; Mon, 24 Aug 2026 16:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wybWc-0007j3-DO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wybWa-0003qT-84
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787604247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnOCsJI8Jv6vpNmzJLrS3L20EABR40qbaOv87xE830g=;
 b=SYx1sE1xfPxHTyTWsojyEDNAm3ISTo3yBvCws5EHtTPg1/9nlUGsz3fbmLCVYfVLMJFZp1
 +lMQlfmfHUMx3wCiRoddlT+bhTjnLs+j+geb6WZWer0Us/3vDDssatPSTC5wAWv2nmwLUA
 ybDkrZx5EtGGTxQYEvnORKT+3U8Bo8E=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-27YKaCcONqOMjsWBpw-dEQ-1; Mon, 24 Aug 2026 16:44:04 -0400
X-MC-Unique: 27YKaCcONqOMjsWBpw-dEQ-1
X-Mimecast-MFC-AGG-ID: 27YKaCcONqOMjsWBpw-dEQ_1787604244
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbbb9c9bfc3so2829032a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787604244; cv=none;
 d=google.com; s=arc-20260327;
 b=XsqOzQrjxMDyhz9XYryhsLEmb4TL+Pg7SYHkcLcG5j3NyEw4Bmak3hR3VkmmYQyveU
 8EdwGZBd3fQTv/7jkqqqrw8NtNXErPk6rWzN5kFajKFY2vvPg6zyBNHmNeSajdjT0fDa
 x8f/tHZJEOEF/uXVXrgS6fBShpF3OlW8wby+yaqwACna5DAdy9iLhW1dlnajQsa7BjJI
 Ix68s83BnxI3FCJrokL0SyAxyu95dseml+IN1NkNyyPRkn4z/aUB9py0JvfcTLlBmrp6
 +l/kS1JNU6ortt+WF1uRytjfAAHv7oxFElbgBvOW5LihZRydlrfE1ue4Y82MUuGoTu3B
 YAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KnOCsJI8Jv6vpNmzJLrS3L20EABR40qbaOv87xE830g=;
 fh=ql45W2LQjIeaZ/xZ4+VidjmDW/ISdwhCg0IQSuz3z5Q=;
 b=YsT8ITEDthsiteBJCyloe8rc4IEVY7cb/iPZRQ4890WaHUckxT5KbsvqwcHXeqUSGn
 OSEvf7NsxwUiITqLpDSPMNubbA8h0SqEb4rw4xaGuJJJ2q5E07nSVHRUQ4qK4xAELPAa
 PwVMhEmIqazIVOClCd7vgg/SJnMzGqWhO9sPbedRPlc6ZklKCXw5ZU/P89/ToostjJ1O
 +60BSkrdn0+jLRh8blNOYmgE7jsmcI3gjYgU+lkbAAqDeBtBEeI0BLckhhm54iluxLW+
 LlTph+fJ+W4qt0Alr3XErrvm7Iv7Cy0LBfidnwU3+mGDF2KDaUan0ebwCIMC1KUNOqJ3
 MmCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787604244; x=1788209044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KnOCsJI8Jv6vpNmzJLrS3L20EABR40qbaOv87xE830g=;
 b=Mn1OaUZmrjoLHKjD2sD1dM6k32OVVPbGmTrdOVNmfQgLdNiTujmgO/bjmVqU6fxwHi
 2yGoN7tt1WldUUnNlYytziWXtCdeeLQ6X758PcBcRVOJSrmpGT1+K8tvPSoqRX41kHbV
 5/Qio0Da/G3UaUDr77Zuj5Emdp5eig5XD5WSvxOuBQmymQxUPYeyLJABCY8FzAuMXT/V
 Izebd1nctblOndV98HXZ7pT67j88R6EuEp0/fK0ubn1fxZk3QaIW2qrxftEwtCIO+sz1
 Vkrbg6TdOKjqBrGTbRFLz8l0M6t+Aeb18oUqpSaquyEhixvG5OmkO0j678JMo+rBy53l
 KY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787604244; x=1788209044;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KnOCsJI8Jv6vpNmzJLrS3L20EABR40qbaOv87xE830g=;
 b=Qwhjizyx/sVzsPUUTpeXLsk7Cz71YHJtIaABeZEvLWhv0/26QMin1GUHSOWbBTC5U6
 60asUeAWBjm8HGYdM7xWUuABORv+slo3XTpEaSE2fxeQ+mMGAHVMDtdHkIJSMaAENQZg
 qDOYYN2ZPYHsWjS3BnWDPth8SfLxnk0b5fS0IAD5nR3YCi7S4V6o32Aag1XZdZ/UQH0X
 TekfS4TsUTPiE+W0AT/Q0tcWUGZXya6jvEXpd695fIbbpXGNvx4DdsTXj7tg1IlTdg2V
 6PUQtvd/+AyWcMULVevv4W4w3eJ1DzT1RvFZHe4yBY33lXJOiO58ZradYgDOfvomXTew
 QoRw==
X-Gm-Message-State: AFuF++nnhbfLG7ZDmOX7PIvuv16DndnhvQlaniWmwjhu6+zbpEx+za0U
 54g5AJkAVM6uNWcs7UNIRRERaOPTuOQHcMu0xwRdjPGkvv5knxNasUOgpdZZwpkp0H7Lu4O2d8a
 HRee6DHVjfGWXNIo5qtAGr2piG0iJY1ya2dUkowZR84aar6q4ov9I4hwxbjDH8GzVKPJ8GRvPew
 avLn1UhlQUN1BdJVyzbDFVpdR5L5qLBVY=
X-Gm-Gg: AR+sD11jEzOQJQLXeu0YqXEmjBhAieHAyoVQf+Hmed1J9OrrA01gHnNI/fJaSb1Kydv
 7q2jxv4QofdZLr7HHFUB5onINsVeMhau2kVIoPjY89pFD/LdDoKDDQ8Kr3wXu+n7+NdUuTFCykU
 skJbvdl++1Q/sroO4lbHdaEtxWOx6mi024zNwJu7JveOt7mmp6uuXw1fJiMmXhHy0cVsxVkm4py
 BYVBTUD07CE0zB5fpx0QX8e6h5ar2fxZc8JnMREgOYwMUDwrjQzRE+zYrl/1k9k4mPaq1jeoBAv
 VA==
X-Received: by 2002:a05:6a20:cc9a:b0:3cd:f6c:6cdd with SMTP id
 adf61e73a8af0-3cd913262bemr2909073637.16.1787604243608; 
 Mon, 24 Aug 2026 13:44:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:cc9a:b0:3cd:f6c:6cdd with SMTP id
 adf61e73a8af0-3cd913262bemr2908969637.16.1787604243090; Mon, 24 Aug 2026
 13:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <vga-v3-20260824.sinxx198@gmail.com>
In-Reply-To: <vga-v3-20260824.sinxx198@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 00:43:51 +0400
X-Gm-Features: AcwNN1XqARXEHlhC2fBlPq6G_K2xZwcYsUlj6IcpjMjMIYcYoG1QN5_z9yReS7E
Message-ID: <CAMxuvaxj4utrBXpE8HGk7zX1TmnTB3iCz68CwSKK4+LgyD20fA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/display/vga: fix text-mode OOB write after a
 graphics surface switch
To: Warisjeet Singh <sinxx198@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 24, 2026 at 8:47=E2=80=AFPM Warisjeet Singh <sinxx198@gmail.com=
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
> Separate the geometry cache per renderer: text paths (vga_draw_text,
> vga_update_text, and the text handling in vga_invalidate_display /
> vga_common_reset) now only manipulate last_text_{width,height}, in
> characters; last_{width,height} become graphics-only, in pixels.
> Additionally, make the text path compare the pixel size it is about
> to paint against the console surface's actual dimensions.  The
> surface check is the load-bearing term: caches in either unit cannot
> see the other renderer swapping the surface, the surface can.
>
> Fixes: CVE-2026-77913
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4215
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
> ---
> Changes v2 -> v3:
> - Finish the gfx/text state separation, as requested: vga_update_text()
>   (predicate, cache stores, and the mode-message box) and the
>   last_width =3D=3D -1 invalidate handshake now use last_text_{width,heig=
ht}
>   too, so the text paths never touch the graphics cache fields.
>
> Changes v1 -> v2:
> - v1 (split caches only) did not fix the reported reproducer: after a
>   legacy graphics frame (depth 0) the text predicate still compared
>   equal, because nothing in it noticed the console surface had been
>   replaced.  Keep the split for clarity, and add the surface-size
>   check which actually catches it (verified with the qtest PoC and an
>   ASAN build; without this patch ASAN reports a heap-buffer-overflow
>   in vga_draw_glyph9(), with it the run is clean).
> ---
>  hw/display/vga.c     | 37 ++++++++++++++++++++++---------------
>  hw/display/vga_int.h |  3 ++-
>  2 files changed, 24 insertions(+), 16 deletions(-)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index da0c331486..cb0e28b79b 100644
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
> @@ -1938,8 +1945,8 @@ static void vga_update_text(void *opaque, uint32_t =
*chardata)
>          s->graphic_mode =3D graphic_mode;
>          full_update =3D 1;
>      }
> -    if (s->last_width =3D=3D -1) {
> -        s->last_width =3D 0;
> +    if (s->last_text_width =3D=3D -1) {
> +        s->last_text_width =3D 0;
>          full_update =3D 1;
>      }
>
> @@ -1978,15 +1985,15 @@ static void vga_update_text(void *opaque, uint32_=
t *chardata)
>              break;
>          }
>
> -        if (width !=3D s->last_width || height !=3D s->last_height ||
> +        if (width !=3D s->last_text_width || height !=3D s->last_text_he=
ight ||
>              cw !=3D s->last_cw || cheight !=3D s->last_ch) {
>              s->last_scr_width =3D width * cw;
>              s->last_scr_height =3D height * cheight;
>              qemu_console_resize(s->con, s->last_scr_width, s->last_scr_h=
eight);
>              qemu_console_text_resize(s->con, width, height);
>              s->last_depth =3D 0;
> -            s->last_width =3D width;
> -            s->last_height =3D height;
> +            s->last_text_width =3D width;
> +            s->last_text_height =3D height;
>              s->last_ch =3D cheight;
>              s->last_cw =3D cw;
>              full_update =3D 1;
> @@ -2071,22 +2078,22 @@ static void vga_update_text(void *opaque, uint32_=
t *chardata)
>      }
>
>      /* Display a message */
> -    s->last_width =3D 60;
> -    s->last_height =3D height =3D 3;
> +    s->last_text_width =3D 60;
> +    s->last_text_height =3D height =3D 3;
>      qemu_console_text_set_cursor(s->con, -1, -1);
> -    qemu_console_text_resize(s->con, s->last_width, height);
> +    qemu_console_text_resize(s->con, s->last_text_width, height);
>
> -    for (dst =3D chardata, i =3D 0; i < s->last_width * height; i ++)
> +    for (dst =3D chardata, i =3D 0; i < s->last_text_width * height; i +=
+)
>          *dst++ =3D ' ';
>
>      size =3D strlen(msg_buffer);
> -    width =3D (s->last_width - size) / 2;
> -    dst =3D chardata + s->last_width + width;
> +    width =3D (s->last_text_width - size) / 2;
> +    dst =3D chardata + s->last_text_width + width;
>      for (i =3D 0; i < size; i ++)
>          *dst++ =3D ATTR2CHTYPE(msg_buffer[i], QEMU_COLOR_BLUE,
>                               QEMU_COLOR_BLACK, 1);
>
> -    qemu_console_text_update(s->con, 0, 0, s->last_width, height);
> +    qemu_console_text_update(s->con, 0, 0, s->last_text_width, height);
>  }
>
>  static uint64_t vga_mem_read(void *opaque, hwaddr addr,
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
>      uint32_t last_scr_width, last_scr_height; /* in pixels */
>      uint32_t last_depth; /* in bits */
>      bool last_byteswap;
> --
> 2.47.3
>


