Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA100EDA6BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTfp-00049W-3M; Tue, 03 Mar 2026 12:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxTfd-00047C-J9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:36:34 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxTfZ-0007hD-KE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:36:31 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-50698970941so72677981cf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 09:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772559388; cv=none;
 d=google.com; s=arc-20240605;
 b=T+jZJXIsq2rGs6dva96oUZrTvkrDWAKVhwu17JUFZTFx2puWvjT0vjGBSEQM3FyYVs
 d/5adDd9NJMM7DFG4kLHialJ+dsGZwxbh6vVXt3mgtVx9ZLav7rBpFcoUFVfVp3OFxTt
 MYLbd+w/3pcdBs5BNswAIJKRialHqposzl5BM34Q252s+ehdDF1WtZDesDOVYr0Cuuy4
 IQtdka65/1OZ9/QH5iDrTZLFKjOy7hKGAvo0ez3YiSXicH9bLjIeQGoV8usUqX8jlb4+
 P+to6UgbEGC+8AiqAolYObazUWCNVn2ykJfbWOlXf2B2YsD2hdSoG1pi+XsrJAI8eXyf
 YvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rK2pO6FkGs2679gVgms260TcmMISzLhxTpl84uprQ2o=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=c4OwKl7hWCQp+EZnRRUOdDpZSrzXdhaLW1GRBUs3IF3FNoc6vjYMa6+dAU2JxGdtfS
 eEGkAvck3s2ovK9PXJN6mvGHiKfef1Z+x/M6u0LcmKBPssno5XRa3wq1YCTJvAOV2FvR
 ND/cRlFtbpaA1m4fwZuyKOpGaqaEuIM1XG21zbgHJXK2fjelygd58ct2JxlmnSgyxNy0
 sPP5Xpr/xwqg+PEm2LkRC9LEiI6+FgUH8kaMBj4ta9Ed/+/cR/NNdSrzYONRJcCLTNG/
 APhW7VV+2Sz2W30YmGLHJkj1yX9hqMK6OrGrA3cG5AUK42yULAX0utMAKnwff4TL9R2e
 QTjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772559388; x=1773164188; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rK2pO6FkGs2679gVgms260TcmMISzLhxTpl84uprQ2o=;
 b=iVEwe1sZ/nGupdGj5nbeWkYl79Ap8f3ctj1fSc+MdqXJFWSRkxnXuHYGzDqYF4Mv6P
 ZdfrSDuAfOpCIrOaq7UGqahfqVqFhkS+j69IdUOyinrkODS7txg2CJ9+bU6ufc3eVXIM
 ZSKqQusxoTyxABzG1t19RII0Wiq/mZj83qbP3X7zsme4JB3xBpUTEzuLBpO3ZjICcpFN
 roD2bdVQTfTo0kKpg2+ukCPIOL02V6+OfrLTH+yzJ+EUVFkInXfsWoI9tF+XtuOAqoO2
 VsWSSkrqnJoishfNCvVRwJtjdQWr71LANQw3LGSyzL1z0q+idTtCF4rASnH6A5t+adUc
 G7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772559388; x=1773164188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rK2pO6FkGs2679gVgms260TcmMISzLhxTpl84uprQ2o=;
 b=OZUWmziyjQm5wJm+XOvllCc0VZjcptWz276e8ijd2Aq10zlnZKMLjKACwJm9O5I7Q0
 kQTLKzdpJmkZ99rsBSEW2aP7u6ZLdApn2+5t/hRI2mdYKuD/VMg0PWxljOFsMyW25PNt
 GDDLPjtmA1rwQwE336TIScVk4sQj2SUpEpsXgdA9n4kjjG1HZDi0/oCL6Jdx/e6TZpHE
 0TnEPIE1ixrCHilleS9qYPKOgB079cXzWj4PFKqSkruYn/mogccRd6qIoUR+FHMyMUb3
 faLD4coiu+b6ODfoD9SQ9i5169dOmz73Yb8Y2NbgHpNuJN8kw5i6XnyZru8m9GkbS6d0
 qXeg==
X-Gm-Message-State: AOJu0YzPKNx2I3HGmsepshh63o/t0bmxKx3woHHz2rjo7+66Gtfu8a3F
 L5Am72EmBA3Fjq4QFsJ6evkQJ8tsELPZwYMcN53w+jngqRQGu5p6ywRuoXuVVt+zB+NCY4KPclW
 GOas//J9LTrUf8dVwXYzIRSHqCfC10Ls=
X-Gm-Gg: ATEYQzxgNkOVNV7ZDyZqmRQtQotDZUBwpoIPZPu2SQ/ZliU6yPv8YJXwogcdas0b+Md
 YugawonCGCUnOoE0ck/ksKciZA/dgQ7XxpnruEnfiTAga9pWG9TKpEsyOD82jprkY4N6v8pK3ZG
 JKfO0V8sHGN3GcT53brPhylEaqm0oDjmw2cPg8z+trLDv7ruSvQ+iGleAoym5/hKX+ywsUzePrq
 JtqH7p9VfpU3PDkPXz+zJ049A2BuzdJmvuMv3FWG0ngVWi8VV+0aF8rRedJa3HkIIeU6AUaKbWI
 j8zBVa7lrozQUsEk2eHyZUDf2xaVXwySSu/2eKLk
X-Received: by 2002:a05:622a:553:b0:501:13b1:14cd with SMTP id
 d75a77b69052e-50752726534mr218382931cf.3.1772559388148; Tue, 03 Mar 2026
 09:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20260303011151.1925827-1-dongwon.kim@intel.com>
In-Reply-To: <20260303011151.1925827-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Mar 2026 18:36:17 +0100
X-Gm-Features: AaiRm53cA-wDq5K9uCuHNjI4ps0WI1nvG-aWtV0XMw004BjGsN_VvbdwD2m480M
Message-ID: <CAJ+F1C+mV7Qag=U10UbkNms8reFHc9LwVG2L7+sr3bxgRfyLLw@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk-egl: Ensure EGL surface is available before drawing
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Mar 3, 2026 at 2:17=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> The EGL surface and context are destroyed when a new GTK window is
> created. We must ensure these are recreated and initialized before
> any rendering happens in gd_egl_refresh.
>
> Currently, the check for a pending draw is performed before the
> surface initialization block. This can result in an attempt to
> draw when the EGL surface (vc->gfx.esurface) is not yet available.
>
> This patch moves the drawing check after the surface initialization
> to ensure a valid surface exists before rendering in gd_egl_refresh.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk-egl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index ae9239999c..52d187c482 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -152,12 +152,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>      gd_update_monitor_refresh_rate(
>              vc, vc->window ? vc->window : vc->gfx.drawing_area);
>
> -    if (vc->gfx.guest_fb.dmabuf &&
> -        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        gd_egl_draw(vc);
> -        return;
> -    }
> -
>      if (!vc->gfx.esurface) {
>          gd_egl_init(vc);
>          if (!vc->gfx.esurface) {
> @@ -176,6 +170,12 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>  #endif
>      }
>
> +    if (vc->gfx.guest_fb.dmabuf &&
> +        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> +        gd_egl_draw(vc);
> +        return;
> +    }
> +
>      graphic_hw_update(dcl->con);
>
>      if (vc->gfx.glupdates) {
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

