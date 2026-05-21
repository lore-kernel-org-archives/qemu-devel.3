Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219C1CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ40f-0000gg-Oz; Thu, 21 May 2026 10:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ40e-0000fx-Gm
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:04:24 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ40c-00058s-PL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:04:24 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65eb1b25c77so665510d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779372261; cv=none;
 d=google.com; s=arc-20240605;
 b=dyghnNAaxF4xqb114+TryTa/wmSfCXWB72f2WLvZ0d9xFYj4VyMDGs+4/mwZwoAUo4
 OUo7wnzH1pOGkOZtDIxgDqI0oZqEfxpHUkp8QvVTSfHyQnK4eCjmhE3KgkitUzuDAVfa
 8njGDwtd2FaENM33286yxYpVvnfZqu7vCs7JRAXBMy7EXug+00Va4fBkwUY6NiKktQXj
 sjMjXV39hBIv8S9nXpvRco9ifZU2UaBxfKed7pxD8Yu3hMBle9p/oRxoumB4O0/oM2im
 VOv52/fz+rzt1m7LWRJ6aV4I336NAhxPpnwu022q2N04kOx33QANT14DKAlUTDNkCnwA
 x22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jkCKT/AC/dC7lUpr1/AfDWgiBCN/yo9Osm9aRvZhr6g=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=VPNwYU7i5zUmxfs5nq36OrlynXLa5xxe0Nlr8uJFfyZdCptadgilqitG6rWgo75Ex8
 06DKwtf6H804O2AowZ49LofOSfwkKeY0HeBvQZOvNXt3VkyYTgSLjKmxVPgLWIbQKpj1
 Ls+6vxs5fCjgxn0juIMTnrpfkwnF9a3o8k+onB4JpD4jGZ/mvRsCVy4ZutW8N6lxpBEc
 EYKDLpdT988LrKFF0TeMtNeTsuzNJGRH9+j403XXR7g1pI6NIE8xfBo8vNGqih9vuI17
 JXhPRy8Pph3vrA9VNMHtfbZEx8IKBi8j/I+0niFjNyUsOq/Q/AxKyJdmaXRbkO3fLKWH
 pL1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779372261; x=1779977061; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jkCKT/AC/dC7lUpr1/AfDWgiBCN/yo9Osm9aRvZhr6g=;
 b=I77xyavXkjxmJndRsbGzxCpTIeu2gxrcJjvZq7ASde4sSDBY7g7myA8tmxT7Hobwxn
 6S26tPF+LCDSh8toIFtJIcXy2gHGRYNNPo0YIBFtfPttO++i8KdWtxUWzvrwl7cSoX52
 XedC8KGZQu4CgMqywmhBhCGiWHNDFt+COuOSzJHCz44IWFe9BOCPVfjz/qPVLzWVqOhD
 IjEox63eWn34WUWwckofCIkbF5UY7WbydcnSQ1Ubb2wV6cf49AmsjPk+nT6iZzuHKrHB
 Agdd3N4gRnTmW9MA7G/6NuZosl/20igeIFTaa9f2gLv4vk+GKPwAtL0o2sI7V9u/Qne7
 vOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372261; x=1779977061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkCKT/AC/dC7lUpr1/AfDWgiBCN/yo9Osm9aRvZhr6g=;
 b=bQdhA3WrfvydiVG1W+36KSrY9RPNZBEA6pAb1qJsAYcEEE4XzlwHvqsjvh/+70nUMn
 tLX6M/SZgtLBTDv2TF1B0wRHXT2ubljussBkdKel4AOfZDwPJeBQb9wdHIfGzU/rpNmM
 9O7Im2PvLopVBqO+ojwuc/hIFw69h4e5h76+QIUN8w2j8ytPqIVQEqhuPd47tGry331d
 SSn0DQ6F2iXgTzi5YHUve0wsGQqxs58i0c88W+uTOf2zKpN8mxgQwUGiLm4XPGszXxBK
 t7dR21K/LHGq5BH3FW+6OmlARBSpJhsSZI9mtjRO4SgkaObyhDWXat+Pdi0uutoBUCGv
 jb5g==
X-Gm-Message-State: AOJu0YwhGZ/uYsGOynNvTURC8w832xKrarU7i2yjOXJRx72ZUvHCZlQz
 /cHzxP5zXpg8qXrePtP8RVYF2YHy00GXcJonf9pPhdSm+s+3W/sS1EmajyyiZuPcLs9Ui50wHnF
 0+1OocZPvVZuScZRCnkgBbX72GF7RwYeDlXKN6LImvwWRI+vyPV8J
X-Gm-Gg: Acq92OG5ARYwwKoLeS05YberQvx9oOjD4msCUEy7PxXjeC+qEEx/YUCOZbtrDq/Sr7E
 eKXUjdYe/z2eG7AlpL6G5n0eR5i99cvyze9p0tWvmdA1wLRBuLKc0spR3WktcTGEVkQlombfY3e
 aaxZCbv9oETTtYAzxDOK9AURQyL3gyhs9fzHUEl2Xc/dHwcOgR7/WStRVA4y5wvGx8oRG7R/rEz
 ZNrNfADvuK4oSFqxPeyjrqqqlZR6ez3/yhAC9EB32DlD36Esd79SRGtAsMel8NVQzNb2+9U3skr
 GWOyWMxYpmd7AugYn53P/DV0jQnuUvdCAVHAxVuE8g8JdWtr+t+PQ/plYTbSoSz2ak0=
X-Received: by 2002:a05:690e:14c1:b0:65e:b2fc:bc08 with SMTP id
 956f58d0204a3-65eb2fcbdd3mr1966884d50.6.1779372244802; Thu, 21 May 2026
 07:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-7-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:03:53 +0100
X-Gm-Features: AVHnY4K_qHnx-uIikVd_EdclqX5Uyx1keBUVSkvfo_7yJTHAz5P4mbcJYh5NRIw
Message-ID: <CAFEAcA_mtLpE9dYJOyvs==j8xdsrgys4nVv=_RewFPT8hqJN7w@mail.gmail.com>
Subject: Re: [PATCH v6 06/64] target/arm: Update SCR bits for Arm ARM M.a.a
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Wed, 20 May 2026 at 19:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 15a13b9292..0a11dd9002 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1820,6 +1820,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
>  #define SCR_AIEN              (1ULL << 46)
>  #define SCR_GPF               (1ULL << 48)
>  #define SCR_MECEN             (1ULL << 49)
> +#define SCR_ENFPM             (1ULL << 50)
> +#define SCR_TMEA              (1ULL << 51)
> +#define SCR_TWERR             (1ULL << 52)
> +#define SCR_PFAREN            (1ULL << 53)
> +#define SCR_SRMASKEN          (1ULL << 54)
> +#define SCR_ENIDCP128         (1ULL << 55)
> +#define SCR_DSE               (1ULL << 57)
> +#define SCR_ENDSE             (1ULL << 58)
> +#define SCR_FGTEN2            (1ULL << 59)
> +#define SCR_HDBSSEN           (1ULL << 60)
> +#define SCR_HACEBSEN          (1ULL << 61)

Typo: should be HACDBSEN.

(Hardware Accelerator for Cleaning Dirty ??Bit?? State ENable.
The Arm ARM doesn't say what the "B" is for but it's in the
FEAT_HACDBS feature name and all the register names. "Bit"
is my guess.)

>  #define SCR_NSE               (1ULL << 62)
>
>  /* GCSCR_ELx fields */
> --
> 2.43.0

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

