Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE01CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbylo-00047Z-D3; Tue, 23 Jun 2026 06:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbylm-00047P-OP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:54:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbylk-0004gn-Q6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:54:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4921e4dd62dso7667315e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782212055; x=1782816855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCw9qulh7am9/yhvutit+gAtk0gU4tMU84WOELXqs18=;
 b=t8OPUiMLznzw+y8gkKBHug/mpmztBuloYXCgyF+CzobavI/s1pOVoukxX82ZzLEQoy
 JIghL6pF8Zrn4AXJNbVFyoA8NNhNU9p6X29/sW9rFrX6/Gxun2pwwY/DYe48Dmu86jaX
 1uMu8CZQn3pqS310GqPFv4FyYJpSrrlqlnW5HDe1mwx+Xs6/zSPBArIHq4JxPdLKhjqi
 tgF9sWz4WpIYyNOwnnBcizccgTat9F+dBFvcLbDFTOmZ3x14z6IS7B0lNvZX9H/fc1nH
 OBFIJg4UWkFdG9J5Jjya/HjPjCwfSRLy5ZhrpGyRvuVp56d40t25uRhnK1f27daGGu85
 oISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782212055; x=1782816855;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XCw9qulh7am9/yhvutit+gAtk0gU4tMU84WOELXqs18=;
 b=kXnf7nkBiEjtGNfvax+Ksk34eZrhGiKVbn/W6L9mMIHgOUhBB+L9RnhFCvr/GmjmsQ
 gs1Kt7i4tSIRNpPZ50q4Al5Wriem3NmdKjaqBQwA446oh4O5BgpAaZsEmVicXjAr1enM
 25I08oVNKDBG2vwXZKPg0iv1yLI7DibkZwBv2h92mOmlJnXFvuyKTeP58b0BPuPwgKYK
 adseso0Bpuew2wzCCruRQldURYuX207wc/jBPaiDQiPJZ/QzJlEaI3yLr9KDwKIMpK6D
 AJefD9yxz4xyLuQVf3ESbELblq1E8DG/5PlrpGNaGoAFqcmkIZk5NTLG50+H60xGb0OL
 e4Ew==
X-Gm-Message-State: AOJu0YxcS6IDGeP6RnJGpGbntopYWctu5/DrrFlg8QxqnSE0OpAT+UeE
 LOrMWxPGCQ8LqFhSdeNUeM1oV6EGexFSI6RxAHTGgCnNWfzYx41M6GdG0v5vpJpF+ocdPqFKtXr
 PKSmKjrg=
X-Gm-Gg: AfdE7cm0jeM9w6CJrWHWweZN67LyOPrFTHYRAwX/TFYQy2wTp7JL0A/OXCH5w8SpkXo
 bWEnWqybMUxnkgBePBVd9VcoE3zjkOKtJX2MBpialWc7eR2Dhy6+VavpP2bX/HWxSruUod01xcu
 QWFMU6ov5esC28pSoAaMtxPUKLQ4G/hlzZP7KusRFeD/u/gZ6NFXI2P4gQWSivLpYS/PsQvnEp/
 Gwx9p3vSfrjXtHipmhVDMQXrsegXjOLtMwdXrh8hZRW9qTS4TfRFkxfpI3o80+3ZKj913lT111X
 7l/SfV3nzbhdo6xjZJb5xS/spVzf5ssfLFyUYBqpf88TpMIfJ0OhHuLtf4jNvN3G4d8Fqze4M3n
 MgzjfCD4tYHj0x8vn/RrOlGooQcizxzxxxntevnvvI/2vayUl8dz9HZXeKWOgPRvdnsNA6w6Cbc
 GDfisFo+eY7nac
X-Received: by 2002:a05:600c:4689:b0:492:38c9:b265 with SMTP id
 5b1f17b1804b1-4925a0c5671mr43067215e9.15.1782212054837; 
 Tue, 23 Jun 2026 03:54:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f56aasm33985105f8f.6.2026.06.23.03.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:54:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F10175F80E;
 Tue, 23 Jun 2026 11:54:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] vga: implement text mode character blink
In-Reply-To: <20260525081944.1494798-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Mon, 25 May 2026 12:19:44 +0400")
References: <20260525081944.1494798-1-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Tue, 23 Jun 2026 11:54:12 +0100
Message-ID: <87fr2dmsrv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> When bit 3 of the VGA Attribute Mode Control register is set, attribute
> bit 7 switches from selecting bright background colors to enabling
> character blink.
>
> Implement this by tracking a separate blink phase timer that toggles
> every 32 frames (matching real VGA hardware frame counter bit 5 @60hz),
> and rendering blinking characters by replacing their foreground with
> background during the off phase.
>
> As with cursor, no VMState migration of the fields, as they are
> transient display-side states.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1585

I don't think this resolves all of 1585 because I think its asking for
the other text mode features as well.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/vga_int.h |  2 ++
>  hw/display/vga.c     | 24 +++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index 747b5cc6cf8..5664317ecd6 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -130,6 +130,8 @@ typedef struct VGACommonState {
>      uint8_t cursor_start, cursor_end;
>      bool cursor_visible_phase;
>      int64_t cursor_blink_time;
> +    bool blink_visible_phase;
> +    int64_t blink_time;
>      uint32_t cursor_offset;
>      const GraphicHwOps *hw_ops;
>      bool full_update_text;
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 0ac4bf37310..ea01a889f20 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -45,8 +45,10 @@
>=20=20
>  bool have_vga =3D true;
>=20=20
> -/* 16 state changes per vertical frame @60 Hz */
> +/* frame counter bit 4: cursor blink toggles every 16 frames @60 Hz */
>  #define VGA_TEXT_CURSOR_PERIOD_MS       (1000 * 2 * 16 / 60)
> +/* frame counter bit 5: character blink toggles every 32 frames @60 Hz */
> +#define VGA_TEXT_BLINK_PERIOD_MS        (1000 * 2 * 32 / 60)
>=20=20
>  /* Address mask for non-VESA modes.  */
>  #define VGA_VRAM_SIZE                   (256 * KiB)
> @@ -1286,6 +1288,13 @@ static void vga_draw_text(VGACommonState *s, int f=
ull_update)
>          s->cursor_blink_time =3D now + VGA_TEXT_CURSOR_PERIOD_MS / 2;
>          s->cursor_visible_phase =3D !s->cursor_visible_phase;
>      }
> +    if (now >=3D s->blink_time) {
> +        s->blink_time =3D now + VGA_TEXT_BLINK_PERIOD_MS / 2;
> +        s->blink_visible_phase =3D !s->blink_visible_phase;
> +        if (s->ar[VGA_ATC_MODE] & 0x08) {
> +            full_update =3D 1;
> +        }
> +    }

You should update the comment above vga_draw_text and remove "flashing"
as unimplemented.

>=20=20
>      dest =3D surface_data(surface);
>      linesize =3D surface_stride(surface);
> @@ -1317,8 +1326,17 @@ static void vga_draw_text(VGACommonState *s, int f=
ull_update)
>  #endif
>                  font_ptr =3D font_base[(cattr >> 3) & 1];
>                  font_ptr +=3D 32 * 4 * ch;
> -                bgcol =3D palette[cattr >> 4];
> -                fgcol =3D palette[cattr & 0x0f];
> +                if (s->ar[VGA_ATC_MODE] & 0x08) {
> +                    bgcol =3D palette[(cattr >> 4) & 0x07];
> +                    if ((cattr & 0x80) && !s->blink_visible_phase) {
> +                        fgcol =3D bgcol;
> +                    } else {
> +                        fgcol =3D palette[cattr & 0x0f];
> +                    }
> +                } else {
> +                    bgcol =3D palette[cattr >> 4];
> +                    fgcol =3D palette[cattr & 0x0f];
> +                }
>                  if (cw =3D=3D 16) {
>                      vga_draw_glyph16(d1, linesize,
>                                       font_ptr, cheight, fgcol, bgcol);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

