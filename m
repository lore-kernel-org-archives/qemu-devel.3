Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96995C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIzW-0001lq-8b; Sat, 02 Aug 2025 16:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIzR-0001X5-VE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:38:01 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIzQ-0005Sp-GS
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:38:01 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71b4fc462ddso22459597b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167079; x=1754771879; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5nbYF1Y02iFkMweu30eVq0yND2zwAgkIOQKky8IXwTY=;
 b=XMald+5TRbKQBBZCD41HFk3sryjF8dv6WIszBzG04DoEO2t236D8Y+8J8hd7O2W90A
 QD6vxKBOC8CvraxHehyxPPcvi9Y5YJSR7iPEzVBTLgO9U6wZ9aAMeuDJd4RhqCA362pM
 7oYfSW6G74qdoUt/KZKtdRMIbCwxVcy1xNEfbDBr1DBdvx0g0yKBtYGl58WjO/2ClV2D
 /7wpulPRYiHAiP7uoPFN4tgPrBQr+qU1kW0vj+UdrN0dTnQ2y2RK4d3YQv/Ek2Q5FSvz
 2icRi+YB30YULbHon4qFx9fuIasC1wMInuVgDyTO6jRh8/Y1pptMedfG7ddecu/BxQrj
 kuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167079; x=1754771879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5nbYF1Y02iFkMweu30eVq0yND2zwAgkIOQKky8IXwTY=;
 b=OxesrPtkCnbs1md79ja5EHQ9lQTnXkb5HI4SNJar6dp/Iqge+KMJiI7S5e6IC+iYGN
 sOo63ZVumClgwOUiNWcadmvVyeL5B8U/98frhJs8IAJewPP+2/QxOQ6IEgK0/XrUCpy6
 KqB/hmSdFS4JFHM3taWElFja+N2j4FGApW5wokActw/otq7HwChelAOHNK/ylDrsYFwn
 Tz4kLU/qJpbxfJEijPNVseXI2M8DqQGLvyP0jUGP9/9UOZW7EqlENuXTBxihJSr/yaik
 UG5h0+wOVimJ6G9f0BVzg3MSYagE17nV1x8sziMzwZq3z96kK3GCRiwgBzL29JvTZSo/
 uvug==
X-Gm-Message-State: AOJu0YyzEGWd9P7q/Voa+jX2ppZezv+AyIbumAjhOmRVgJpGxVPty50l
 5TulIYfEvz3C4h9AXmEikSFvBdHrbrY+jHSghON0cE31/mda7yderK6iUmv2ffIi3luoqwcUtKf
 Dl0qx7qyI63hgCZwhldzPRg4V0ccZFD4IlKg8ESpTuA==
X-Gm-Gg: ASbGncuS+N2eaVl90UEKjS8i77DY8vUi+V8NqN06XHhpId0B+r4bWcfzs4j3dGwlLq4
 eiruQPG6fBebAS4AR8ov5SDk7fDHaLIXZYIzyxsYwJnUsC6NSpmU2ffUs/xejhlp6XBGEP7m1FJ
 wpJsO0uma7XkHfVBN6tz2MoJxDO00vwuv+i0qsIH57eddmcKl+C1f4OGfA62wzsBvDR6Xmp85Oi
 LfNSIF3ULZNEbZ9FRM=
X-Google-Smtp-Source: AGHT+IEP4ytCjajP1MA+YzKZZBtLITjMQ8a8tEkK03n+3x2A5cPgVJwqzgDI+5CyMablPRUmz/dHxoAe+/B0uC1bFQ8=
X-Received: by 2002:a05:690c:6704:b0:70e:1771:c165 with SMTP id
 00721157ae682-71b7ef73f44mr57599157b3.29.1754167079348; Sat, 02 Aug 2025
 13:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-82-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-82-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:37:48 +0100
X-Gm-Features: Ac12FXxiEHS7CnkxsypNTZWc0cjlGpMRtdK-2tqkTUc7U7ndswFTLIq2zyjHC7g
Message-ID: <CAFEAcA8wa4DNXwv4cRm5FNHzYcBPnxCnUuo+jZFZuEXdq8Bgsg@mail.gmail.com>
Subject: Re: [PATCH 81/89] linux-user: Remove ELIBBAD from elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 30 Jul 2025 at 01:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The last use of this fallback was removed in 8e62a71738bc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 5185c84e58..6eb4e31bdb 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -110,11 +110,6 @@ int info_is_fdpic(struct image_info *info)
>  #define MAP_DENYWRITE 0
>  #endif
>
> -/* should probably go in elf.h */
> -#ifndef ELIBBAD
> -#define ELIBBAD 80
> -#endif

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(The existence of an unguarded "E(ELIBBAD)" in errnos.c.inc suggests
that all our supported hosts define ELIBBAD in the system headers
anyway.)

thanks
-- PMM

