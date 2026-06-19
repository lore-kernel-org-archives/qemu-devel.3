Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BB0CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZIw-0006aM-FZ; Fri, 19 Jun 2026 09:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZIu-0006a5-JF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:30:40 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZIs-0003QO-JS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:30:40 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-662c360aa73so2332892d50.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781875837; cv=none;
 d=google.com; s=arc-20240605;
 b=LoJuOlLyelFhlrJeUdAVE4IHSa1vu2K9URudIEHAXhVEgIhoP9Zx8AbcG3D0SPPG1Z
 9o+ZOtsi56hzgXoi9vuzaLvu7lEQdAxsn8S6TaR/8nTQFyMI+egU0u5qlVlB1HK9fWkI
 UDpYsTUkOhd5/OVZKCrvCDoU5gEJL3aYf3YZ66bmMtrsTBktzIrsC4vPn4/R+2/xSzYH
 bwHi0VvMCibiMQH7A0pZvyGieC2JYZVEvWLYbeO895fCaFfD6B/YPHL/xugn5vwAbbXZ
 0kaOMesVtWa3asS5m2l0X/4kMN1NBEMvD0u51kqQjk91jxlicfzaLXQMbFPqWRmT3opv
 BKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NkkXr0ihJ/n7wB4GrrxauqFJjA/S9UTsGCjRKYb2MIM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=DDOe2lGSgWAom0c2fs4AV2sw99NLLa9hHUjdA74knq6vELdTIiWb8OEktjiA/a7Ei3
 WKySlerb4RNeZDGknrrhs2C5uekQQuW62covXaI6OUMkMuFmeM2IFzNPfKxogUb8g8w7
 y4sdXmrmz9UAda90LuxERaNuCn8dy97rwSCKBUEMPUOkZCDzZBABd+mipG9VIT11/m3A
 VQjshwWAA36itIla+78mrA9zIYqjqXgYnPmrDMoQ7umQOfojSB5R1pYq8clN9pFz904P
 DRmxckvGoYwxa5sHhaleuquaLmKMryrKXb5Yo1y32AH+I/osryOXFn3KKemcpXbz6W4q
 iW1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781875837; x=1782480637; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NkkXr0ihJ/n7wB4GrrxauqFJjA/S9UTsGCjRKYb2MIM=;
 b=jaowNpA7hE0PS+XZ9C9FIybWOlkLc+xx96kGmXbmSjAuQjSXH+5V7lD/d0xUTxBRm7
 LMZ9SmURUMrUrsT6t34Q8n7CLBdU/fNQR+L0tw2Ym2SPPW8hmvUM5PNvXSAo6eDsgBOw
 lGCB2VsDPdvbTtNfG0y88pBcfTaKE5dQ1U/Qm2ITPZPgdKk2pWi8mup/ygc4ppdWnIJJ
 RAy4JDQKwhRFpSttHq5yiZ0H+Ore2cJNTd9GSjdbZkOqtR9g+jE8U6CNu4XgFcZCPOcM
 PBmoN5bE15i23F/vcWlVSDigsTfe98C7R9rcmlucHEc4kub0WvwoS2444IWIec/BIsaI
 AJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781875837; x=1782480637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkkXr0ihJ/n7wB4GrrxauqFJjA/S9UTsGCjRKYb2MIM=;
 b=nkAfg8xPy98SecR5VuMB0r/cgkZnH6SjOwcCZKo7sPleFAvaba7+KiyJVxCo3pTnUY
 8B9vZZTinaGlxWlbRBajVhJq/wDBMPn1ssNaLfLZlotgJsRbkUG/cNOSjI1IXA5kBJHo
 dzkV8ZhVwlMR0vqpEg8lMnCxpAJsOeks3eK5YjqZmVsDrIj0TtC/V4BPlJueVJnga3K+
 awSFv1qyVoTy9kOnuIZr2M0mnXgplYqnUaGEDeoSN/vHtRQ1MS2V+OwUaHZa4bcSJPC3
 09X/GaI+ARhZixuFSCBIE5/ACEMivMZrCikcQYOT90uA+RpnhKjUbxpNTz2Tz+XwXF/5
 oucQ==
X-Gm-Message-State: AOJu0Yzvc/gQHZ6a2Ox3+Vv2n2kZpfaKyp6tU0LGtsVoEyW2h9/txJp6
 2lsWc7E5s2TCYyeH7h3/tNRHosBiFlp7JN47D6o9jFES+XUMpejkit34GPkM31nTnmKSIorfzPK
 YFEu6O8wibe0OgxYqSrDhJX6I6bonWJu2ksHVFNsJ1dV9KNViT6Qy
X-Gm-Gg: AfdE7cn2iep3SfrJXyRGYCU20GVgpqsg8NgK5ywC7zmULkHIJxJvyAF2p0JF+yNJyyj
 AnekXOEkKfNilrPcTYcfDPBt9+xQV0+hIRCOVNn8AAc9XGUgGjsCXy+buhaTicEpdPMiuBem1ss
 8cmymn9GbpQphqQNpapkHZQ76WADYtfjGuERi2eUBcdNPnD91L6V2dFJo8MSCOX4CAFJT99ekyp
 4zhKUeTNjeN2H8IIxMn/kfymIVYlFGznVP+v7JFABdEdUTebPqNpbp+eJgjMxhFK+9xhBpPr0Ba
 g9fY09g/0BGxpp7yT8t92+SsnWt8+I5cXd+KVUgg6oyQGMWuxBqbDg6FcSxPG4sdSNk=
X-Received: by 2002:a05:690e:b4c:b0:661:1307:3d40 with SMTP id
 956f58d0204a3-662ffdc4b2emr2763702d50.46.1781875836949; Fri, 19 Jun 2026
 06:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-4-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:30:25 +0100
X-Gm-Features: AVVi8CeweLmOxVHz2rCy6IijYa7zLfXThNMcdb3dglrGxssSZdb-DCgwnh3QmZ0
Message-ID: <CAFEAcA9+j-oc16xV6zaFRnrEuyiyr_CUj9utZiemOgQP22hFkw@mail.gmail.com>
Subject: Re: [PATCH 03/10] target/arm: Implement FMLALL (multiple and single
 vector)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 18 Jun 2026 at 05:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 49 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      |  4 +++
>  2 files changed, 53 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

