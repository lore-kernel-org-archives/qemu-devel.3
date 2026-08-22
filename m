Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE559C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 13:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxlSF-0003nO-OO; Sat, 22 Aug 2026 09:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wxlSE-0003mu-34
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 09:08:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wxlSC-0005Nq-2k
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 09:08:09 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so22807655ad.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 06:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787404085; cv=none;
 d=google.com; s=arc-20260327;
 b=L2FUDq2a24KzGOvJ+8G06gUMvM2Vkf8oqc25YjAS4vxvMq1hYXs+Zrzu9jkeOUzsZ4
 6qr4XTVNdN15OtIgghZ2IKzfsQ0zYhskBIRR35PG7WIH8WcucKQ6hlo9Tsvahk8OwFmA
 2zq9enzxK9mPR7Srb0VyWh83cYTS9z/hcg8u9APiE+Y5L2CZlld/0pmh4YgzJbptJD4T
 fI9KYTrMoRqoZyGoOYA2RNgaaGpRDJQ4YWpHaL9y+3RMHgoGELth21cU/punjZtajcAR
 n32oJ/gMNA3AHsTrR8clkgZpGBbit7lPjpvlSZCPgmP0X4tSrgtSTjnJkfdm5sMc9fBE
 +Zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YlN5KGCsO9+eaH5laECVHF83tmYtx/2YG6DPdVYr9Q4=;
 fh=lTbmwAhMzVp0CxEkGhIQmEkSm45OVyKuyGUZKR1ealY=;
 b=EYr5iw3qWROSiN72/QPqd8IDmMPNRg0ZZ4BnIR9sbsTtwp570VVquzauyIHwITljHY
 CidVm3nN4IjLT+e3kiSFGHn19BG2r3l1xq9aMUUGXGI84n8uwg4jkkzdAgN9PZZYUCqa
 v0KZGSQx3OoET4Pm+Vp1+w1ux+ZhZxDuNSit49RenPJXVWLnLX/SQOcrfLvNliSdoAX9
 sx5yCuIPVnXIrGTMmNjSxxp4JhFjSOIbc0h8rHBVC5Nldw1Lb/YiNeKm52zzCIstVCzW
 axyFzEV6DKCDRnet0cSXI76kwNpkKyM8OptNGTTKbF87LjwXsFSX8O81zQhQI02M//ts
 N8Fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787404085; x=1788008885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YlN5KGCsO9+eaH5laECVHF83tmYtx/2YG6DPdVYr9Q4=;
 b=bxjheDV+KvAFkhKRHPPY9f3cc6d18lvK75EyVmZS94OtNHGs00wEJ0C6abbAIXJ3qz
 7Ow9Ay7lwdPVAoeGEyyMYizM6V0NZllHKeDedSstOEJSCUwnE5+LjcszRH8KwLuv+Wqg
 q45uuC+6KyMf+BSw9lLudYJCN+w0Uj5QWaBAKk0+q4zj23VwfdMeQbme0xw2N3GOqV8e
 a3ZQAyGgmVQpm35Gm+YYRro33RFF0x22+VwxpnEeLaTBqsJKtp9u3/ooY4ryitLp8XV+
 O1RDO7AykcTuCHgCFgfRZ710tgxieIDWl2CJMxjkGN84g3wiRgM+TVVtwecpLaGI9xTt
 qepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787404085; x=1788008885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YlN5KGCsO9+eaH5laECVHF83tmYtx/2YG6DPdVYr9Q4=;
 b=C5ThObRsvR1Pk5tcMY0PWMRdVdJ/yffls38iky4mFI5vxAxv1RUNLdGD/XanWME1MA
 Rn1Gnb15fR4HnFMEl0kMuuZ4E+xSmiHl+NmadQhOW3jLGJwWbzq8LgSUJmenOFY4Zht1
 cYhjMPDUhqlGWva8d7IvlkVniArd5Sn+cWwW3QiJEZ5/rKcYr8kLIqPhKfaetL4CwyB9
 scZYEWLIilT3xdfuA5yyBb4L8sz/AyUn2SaZhiuA6TqhvacbcwSKaksfRKfQUYb/o5ne
 igsgWmTZpQvN5022AzPTfrVi62V2yVtPmT0LOweXJ5PvQpqVVsfCiYLP7zBJwHhHWHk/
 q5hw==
X-Gm-Message-State: AFuF++lDDYNajyUtwZtUHWdwa09JOkOy/OMX+RQ3HSqxdHl0xOpykqBb
 +O9NYRMEXCKbUCMSwMmDjM+LgVhSbflAIZ7+b1w1xwwa+9Nq1zgzs12dnYNCWXijrsImmz/jNq1
 ++371Myi12PSBrImUZ3xzGAaIY0fKStM=
X-Gm-Gg: AR+sD12wsCemhemFk0L1Ngd6AglOWEweCqtKPa9SRbvE0qwNX+Kzz5lh4Lf0WcZ5JTy
 rCPjKRZziCHsoA1/0XfGFcTwRkIDgLWJbPm7FoDdNTBxMyELquh8JnNyaQQmkrRAXMm70ZIbryr
 QyZzT+ViiGKxrtEigolBo6iChrMkkITfWaIuOz3aSdJrsEZNyqVEGU1dd+TDuV5sNQi6SlKsr98
 fShqe3Knqk2FzoMvDctXeir7RGIzrCi1S7yDrhq93MMQzKAPQfDne9QGCqStegKiocWomEJGfSF
 sPk8ukTcciGdQ5VTS/LQJ3FJdD3wkqgFlUpK03fvSzgoV3aQl4ywtXOvT8AEej3ThlISmrMVZsV
 xeBcbnQ==
X-Received: by 2002:a17:903:2bcb:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2d64adaa1a2mr260812165ad.3.1787404084493; Sat, 22 Aug 2026
 06:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMX0No1tDwFE=XCDDOrE_n33fF-KKD5gqucOLfu8EBGXk6vFXw@mail.gmail.com>
In-Reply-To: <CAMX0No1tDwFE=XCDDOrE_n33fF-KKD5gqucOLfu8EBGXk6vFXw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 22 Aug 2026 17:07:51 +0400
X-Gm-Features: AcwNN1XJb4rcoGNtqPKRitma3ZcCr5vq4P0GrT0EW2R06mxp3jSgFXSkKrXUX_M
Message-ID: <CAJ+F1CK7TVCTrPsRHtHj3VYqa1vKnFGck5mrGqFdPib=tH0CNw@mail.gmail.com>
Subject: Re: [PATCH] vga: split text renderer geometry cache from graphics
 renderer
To: sin99xx <sinxx198@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Fri, Aug 21, 2026 at 11:28=E2=80=AFPM sin99xx <sinxx198@gmail.com> wrote=
:
>
> Resending with the correct [PATCH] subject prefix; please ignore
> the previous copy.  Sorry for the noise.

No worries, but drop it from the commit message, or use '---'
(three-dashes, see git-am(1)) section instead.

>
> vga_draw_text() and vga_draw_graphic() share last_width/last_height
> but store them in different units (chars vs pixels).  A graphics
> frame leaving values equal to a following text frame's char counts
> makes the text resize predicate compare equal, skipping the console
> resize; the glyph loop then paints out of bounds of the surface.
>
> Commit 95687639e6 (CVE-2026-17516) fixed the graphics-path consumer
> of this confusion but not the text path.  Give vga_draw_text() its
> own cache fields.
>
> Fixes: CVE-2026-77913

Also add
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4215

But the patch doesn't fix the test you reported though.. Can you
check? Compile qemu with ASAN. (I also patched
qemu_pixman_shareable_alloc()/free() to use g_malloc(), we may want to
make this an option to help tools..)


> Cc: qemu-stable@nongnu.org
> Signed-off-by: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
> ---
>  hw/display/vga.c     | 10 +++++++---
>  hw/display/vga_int.h |  3 ++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1241,7 +1241,7 @@
>          return;
>      }
>
> -    if (width !=3D s->last_width || height !=3D s->last_height ||
> +    if (width !=3D s->last_text_width || height !=3D s->last_text_height=
 ||
>          cw !=3D s->last_cw || cheight !=3D s->last_ch || s->last_depth) =
{
>          s->last_scr_width =3D width * cw;
>          s->last_scr_height =3D height * cheight;
> @@ -1249,8 +1249,8 @@
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
> @@ -1845,6 +1845,8 @@
>
>      s->last_width =3D -1;
>      s->last_height =3D -1;
> +    s->last_text_width =3D -1;
> +    s->last_text_height =3D -1;
>  }
>
>  void vga_common_reset(VGACommonState *s)
> @@ -1887,6 +1889,8 @@
>      s->last_ch =3D 0;
>      s->last_width =3D 0;
>      s->last_height =3D 0;
> +    s->last_text_width =3D 0;
> +    s->last_text_height =3D 0;
>      s->last_scr_width =3D 0;
>      s->last_scr_height =3D 0;
>      s->cursor_start =3D 0;
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -122,7 +122,8 @@
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
>

