Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB1DEC1427
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNUp-0007H1-AE; Tue, 03 Mar 2026 06:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNUm-0007Fs-Oz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:00:57 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNUl-0007ln-Cp
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:00:56 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso5251254d50.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:00:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772535654; cv=none;
 d=google.com; s=arc-20240605;
 b=gRoc+XAM8uavFVc+0sGWoxguTPY8ASm2jHf6NPsUfNrg6KtBLW3ZKIdkDH79fsqgR4
 QRRDTY9Gt2WDAxpzYtEJvcAG3lLKcJL+HPe0Jd9+nGIvGDnM3VY83wstr9B+7zf+dErS
 BboPyBMOXyLFhanKIFHZJp0vYEQesNcvImnub5V0wz7y8oyB7zeoMbZjP8kV0nfhy2NW
 XplT8KjL0CvGyQLR1hFx+AuNJX0nfmjzhXMgxMKzh8+4QKXLzgGX1lq8gIRj+O+hN3+R
 QWQCOAuMK3v+a9HYM7vTlTtDxYCe+5NL3iO5zYGKo0rMqzlq1cc4F1ZXV5D0mM7I/Zj/
 79dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KRXX5KuiBMSHmvFdQ0zCdhWkb2TUDqhzUrzVLgt0l9s=;
 fh=Uah2ZLT1W6G12Kqkm4J8Gp6AsEQddGnqXYHk61xMgOc=;
 b=etkHl0WAiABawkgNhZYv8tI97b6Lm6vmme7uYGTbBGIKJDckhr4iI2RCdDVlTAOsIP
 vfk44QmkhnWm509djq8ts4kYb/XaJE0W4VdpAW1ptRZGJR5PX/HaKZz5n5M3VT99adVF
 HTbGy4UgvpmgWix2sqy3t99pLlF9rZa+pM6oZMu9MzFj+84+ija7T0wv8oV/OuPxiaIi
 YAR6zn/rt2wJ7RiP6pNSUfo5zMsS0xHIxan+GT6gXeatevMF9gLJe9Nlt2K66sScf5My
 eZSsQkjCARODFkOa+R9gm2Y+0OuQ1EeCJlvJRfoSWHXgl+VtYQBiqZ2FyiV7xKEBPj00
 1lNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772535654; x=1773140454; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KRXX5KuiBMSHmvFdQ0zCdhWkb2TUDqhzUrzVLgt0l9s=;
 b=BRuwnSJbqTUqwrUBXhhPoXIWBnqGluwidYDwqAZElSwxsVESjKQVLSrdrGuRjMGrk1
 JGjH1Pwl28Q7YFfzEAn7oJtFq0gbXXAyWScNn97BSOCPY+U2fpBlfqdBjRXcClE4qIt1
 HFlrf4J5AYTWZqbVqJxS9Qzws7UND4qHfTPByQ+zagUkASgZQKs04lCJtjQOocx+ON7r
 FDkU6HmgCA2sLgbSdv81EgyNWaI7/cjeZQl3I8o9t3Txds5PL/FF2M4E25AdQJ6wfDMR
 +51SQ25BpbuxVUtW8u8DqIKjbhLeNMiMLWSskiB4uLICGlVial5z+KHYh6qw/i4cS+O1
 Tjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772535654; x=1773140454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRXX5KuiBMSHmvFdQ0zCdhWkb2TUDqhzUrzVLgt0l9s=;
 b=rFNgx5HjarZcJce2p4MKdNloVsjLkhv4istHrAwkaekSQy+NgvatsfgW/HhEQHKENd
 SnxtpXxgBc5nEn2zbYHgf0H6kiMdvOftDC2W3JIKCIV2dz6v4vRnO4bTclQ6f4qDK4/V
 rZPFLEXxGLJL3+9CNggwc/tnjvyTnz2sm2QrbFP0NnqNMT82CssQiFTxe3Z8tSfEZjJO
 Iv5TIqfzMvbttiUjtsLwz31O+R3XlkUYvsFQLT/dp9ansXqnCwxeLAw+oBek/5Y/Rs1z
 SWQYNH+jUBQHy2fGVo5J9+72wJ6b43H3DFtx1fu4Il3ZWJQ8sqUNozkZ7aO9s0RqlZY9
 B/lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5TbYUdxZIEb8TT9N1u3D9V8iMz4dH43I5eDaWL1LMzSBbL78BChsUEI+/rNky4nWzlYEU45jncm0Q@nongnu.org
X-Gm-Message-State: AOJu0YxeFpeX6hPH+XGWh6iXAFLcYaN+pyhdt+Ia85/0u5UICfYtqMTa
 /ufT5fy+SqgZFUV9g1NH7TUkjMopMTAZVSndJoMzSxU9UMZ5f5A/oqoj1mqatCtDGi9dpikPV8d
 IyPC/8E/NqBiXmemruWee8rpSc3dyMxK4kECzkjc4uw==
X-Gm-Gg: ATEYQzxFNlI/0ejfC3OZwqWvRffIaFywd96/wGGxKuVrgh0O+tgys2Vkwd+h73uWBbQ
 +V9KxVzo9/Dg8tYE/Uz9rNB3AZR5PkieysKuHfdjM1nnMwrcL5TTJuHY3dNyN6Mvhr0f7C92Vay
 m8OZu9DXNEyYc1X37gCfZzVz4w5CbD7+xw92kPVfgkx/4v/C0ZaqlSRLZRaA9+1IB5QuOBTmbw6
 QypWomLZdaeqP0+fzgCK1aLJU4Xw7dae4rDK7poXorVBSajyJIzvYL0jP/HzBXX31FZGN6pCqxa
 5q9kGU4W4eAxF8HWMayMsj5on9Rz6eEFjBSXiLB3cbejb0oBJsRCwENryMjCTT+cxV4=
X-Received: by 2002:a53:ac9c:0:b0:649:b851:4eb with SMTP id
 956f58d0204a3-64cc22100bdmr12924692d50.53.1772535650475; Tue, 03 Mar 2026
 03:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20260226100232.500781-1-eric.auger@redhat.com>
 <20260226100232.500781-6-eric.auger@redhat.com>
In-Reply-To: <20260226100232.500781-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:00:38 +0000
X-Gm-Features: AaiRm53-Cf_9FKRbMSruGVx57MVL97vcyiHugiaXKNH23S8nk3oXycZPMrAckII
Message-ID: <CAFEAcA-_AGZK6fKZLR4fEKMEMqkE_nwe4WPA02mqryxF5fz7qg@mail.gmail.com>
Subject: Re: [PATCH 5/5] target/arm/machine: Trace all register mismatches
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 26 Feb 2026 at 10:03, Eric Auger <eric.auger@redhat.com> wrote:
>
> At the moment, cpu_post_load() exists with error on the first
> catch of unexpected register in the incoming stream. Let the code
> go further and trace all the issues before exiting.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/machine.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

