Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6BBE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLl52-0003si-Br; Thu, 12 Dec 2024 10:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl50-0003sF-Ii
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:26:18 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl4z-0007GN-2I
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:26:18 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f2dcfc426bso177351eaf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734017175; x=1734621975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TJPNbAD7DjmSrg0vrWlJm/LQ741Z39+F3YcawoCDfGw=;
 b=k75IWEJkEwlZ0MZmk5jKYBUq+CEe2h9cQR3mAZpu0OHfR9GjyFr7jv92NkGes/r1lV
 AJ3YgmZ4YeE0YD6RZRciFKWEAb49CxZ1H3Qz+WbNuREO4VgA7sgemX5vhZ1yeIgDO0Ws
 VILXabAhUm2Ib7IKFDTooQShDQswWAaE+tbV+QsuoL9WQfteo5+R99WZ3ro6Me+ayD8c
 nEx+Ms4vRjBU3WNuxnMMPqHX//rLyoVprDL/ApEFalEyj0l0AnQpcPDcLyAyExfOZIzg
 7/Y59lXoflnVVuqNPcsZ89oepKp1NomY0l+xxmOTMKm+QpDHbUzBUDe3qt01Z5NTN9W6
 IagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734017175; x=1734621975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TJPNbAD7DjmSrg0vrWlJm/LQ741Z39+F3YcawoCDfGw=;
 b=ruIuv8LmX+Uk+om8WXs1ThB9/9n2d4Idk2q+uKnPPSOSdx+ks2ExkcOU8bTFUo2X9h
 OOXZEVN/L6VWv7cRv/WkvZjwDVx81lY98AEirCnSXcANlCnrYIv0ea0rLpK99CS4G5De
 CdG2WTOPk/0RqfRTETBWLQ7Y58AwaoXeHOe1ARKW7CEv3lsh540f+KPhAPqL2H8AufTK
 D2jb+Bc4lPAY2w4Mbfm1CRXaVfkKjyCPQrG58ZGggEMzuK6xGyhaPDtgRjQ+QeYBQNqU
 TMjsFy6XjiEGysfPBx3Esy8TBPPzp2xdtR0BU2Lv/ym62ooz4TKYMlQUASWNFOJ+cYYb
 H/5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe6n8pA8WbXn1Bry/WXRCvqSrzHEM68NRgYmZkhGgIg2IHva8Nfi0Cj5nmM8WMgpoaJbTi/G8kkbTo@nongnu.org
X-Gm-Message-State: AOJu0Yx+jmo+FOyFb352A0NmfaGlrV50XwMzgAZHRwW6RCyJ23kSiXP1
 wG5BbEpN2HLOZjUmHAa/twO/PHlZFvyRVQvdswY4vcnzTPrI/iUIipfbF1eizPE=
X-Gm-Gg: ASbGncswubygvYX6ubN6lk8Mnjy9Y1Y+ElXUcH4R7Gl/DZGSvQmU0W0jjEaUmvUQQD9
 bSykP5MWGS0Ty12vCovk7MM2mbXgJkcW0ud9cltTigfFctUHFIbYqLLR6Gm5SpDUQttNOVNJRsm
 0CQtjbQ7hlF36bFf5ClvQdsgiyNUxpda2I8jOVFYqXgJyyk0pfm9AdK5+MOMJzFYzVeY8v2jMuQ
 VraVEGANTqSHOT6ml3EQtFPx7a3joydQhH7nkDeHaaG+xXjXW4a+YoL4ZKuXL1RBBV5nUxPpzYh
 u/k/2bWMo50kbUuncvKnYEasYboI11lVphc=
X-Google-Smtp-Source: AGHT+IEH/hfMEH1Wp2QmcazU7ySfHlimJc2jWS4CmOmhcM9BMbjO8ObrH59kyjXxzt+Dx7NuUdRjOg==
X-Received: by 2002:a05:6870:a413:b0:29e:80d8:31a9 with SMTP id
 586e51a60fabf-2a012b4f632mr3995585fac.2.1734017175621; 
 Thu, 12 Dec 2024 07:26:15 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e0677c4fesm1394985a34.43.2024.12.12.07.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:26:15 -0800 (PST)
Message-ID: <4ec426ff-7f21-43df-afc0-052749ea8dd0@linaro.org>
Date: Thu, 12 Dec 2024 09:26:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/11] target/ppc: replace tcg_gen_qemu_ld_tl() with
 gen_ld_tl()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, npiggin@gmail.com,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
 <20241212151412.570454-3-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212151412.570454-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 12/12/24 09:14, Mark Cave-Ayland wrote:
> To ensure that all memory loads are performed by gen_ld_tl(), convert all
> remaining users of tcg_gen_qemu_ld_tl() with gen_ld_tl().
> 
> Signed-off-by: Mark Cave-Ayland<mark.cave-ayland@ilande.co.uk>
> ---
>   target/ppc/translate.c                     | 14 +++++++-------
>   target/ppc/translate/fixedpoint-impl.c.inc |  2 +-
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

