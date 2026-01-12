Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC12CF45CF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 21:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfPNL-0001r3-DZ; Mon, 12 Jan 2026 16:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfPNJ-0001qd-Sq
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:22:57 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfPNI-00072l-9t
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:22:57 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81f4f4d4822so723932b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 13:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768252974; x=1768857774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12n+tmcj7XLqa0lg6jLLPLE0+g4Hv37nJzfpcPX2fRw=;
 b=C/S6gUbJCFggq0FWCbn5hybWI/lr6Xopkb863SzYn4T9FAGHd2SQ9jkBXO14kZcFz5
 Q/qXjHwR4s6AASQAJdGI5Y+AiVqVJe3/9RIqdVPZZAT2aWrhK4d9k4sv/mLe50sp9YyM
 sVJlmUzLHleyaUZ0wm6Jv/qLhZC+kSGqds5+Zs7PJaOEvHRgvxStPpQMd17pTgqEk8+P
 UWFvSzsHaHK9ZPa5BSu7RdCIHJ4B9retOHj/U3zUsa4XbmvYB/2u2OqKO5fNyUolCON3
 0tfP6VujOeUgqvqEpL/Fpo5HaGORy4IYNpBE6a24zXsLk+OXTEmhXeNvvtMbnfiP3lKE
 lZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768252974; x=1768857774;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=12n+tmcj7XLqa0lg6jLLPLE0+g4Hv37nJzfpcPX2fRw=;
 b=fs3WtWWa8YdzRS0Tl+UqfaV7rGV9Z2A5p6hXzZEoMm0lQLWsH1S7EydV3Hnyc9Tx8P
 Vx/nantS5IfppXwMPM20daPK6QlG5lrKZgEzMigVqxDqKYPb/LqrP7enCSp03kWiSfKg
 ErDC5fd+k6EnNSksyF4Sp/FUt5+7OS0/LZXgQZ2f9UpCx3fxog1ZMB4d0ZsjmlmmSLvg
 us7Rm3IWkVG1HNw35T66DNQccg/zE4nCBlTYftDQLGZminSMpARJAXpZcn9pi9swFkmt
 0izh22AY55Ni7dh6bte7gNjhTZ1HgTD+z+uriXEqi2E+KIbNl3aaon+J5l3diUuN35Sl
 8crQ==
X-Gm-Message-State: AOJu0YzTBEiqB0NR+EbKTQuLEENpVHYUV+jSp9veogZpvpK+b+1eYOOq
 Q5iPKmMyiieKUEa5pd3Rup1RUtdo1fRPYWH0OCZak7DJHTxVSAcq0so8vmXyxAxw6fjG1I17ZNz
 qyjgNm+8=
X-Gm-Gg: AY/fxX6FUuDRL8ZP6TueAW5UWMRyUQr1we5V9D6+Dnt+z97gkYMvEkQTEG2WtCnAB7h
 zeBU+AysTDUqWmhqduOGOA7qgP0uKWgaxgsCHQX17sr/JR4DIXe7MameKryuJzKmS5aTVJk1h0j
 DjTP1fbhac8aDa6c3Z3xSNeWKmiy4uST0WPYC6xePzy657TFP+CA8QrLWqMMw9eYdjS1K2stBL8
 qHp1qffivF/WjOnBp8TAd6Qtr/TMCeU1+toNHWY179coVzilD8IfBjX3mzrDnvqmyNyVjPqW+25
 NO+KY9JVTXK6y+fZdVz00ClilehXiijj6tTS0ioJpUzJVT2HZdJGpR7sv0RSKAbV6+ZPHyjUH3r
 XP9mw4BnsfzOunNYr6C+iiEXFnErBgmXN+3UzLSy9+5/+jXZDCeieFSHQf0E5YIbiCYHiKa8Wkj
 6pgKIrrtPD3RoeFQkNoyWfV6p/WvcwmHvywMmDzQ==
X-Google-Smtp-Source: AGHT+IFYQssHEDw6E4j593apJYfecbMyMtj06pJ+f8R4LgTUpHU/hJf7ThlgJPHuXPWc70kM5c15Zw==
X-Received: by 2002:a05:6a00:4097:b0:81e:fb11:96d1 with SMTP id
 d2e1a72fcca58-81efb119a24mr8150197b3a.52.1768252973753; 
 Mon, 12 Jan 2026 13:22:53 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e4633957bsm3582598b3a.18.2026.01.12.13.22.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 13:22:53 -0800 (PST)
Message-ID: <cc117da3-2ab6-4e98-9d00-b5744bff7947@linaro.org>
Date: Tue, 13 Jan 2026 08:22:48 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] tcg/linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260111215819.569209-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 1/12/26 08:58, Richard Henderson wrote:
> The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:
> 
>    Merge tag 'pull-riscv-to-apply-20260109' ofhttps://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260112
> 
> for you to fetch changes up to 365a2248ae69f306fe7997fd966bcb1c16a08695:
> 
>    meson: disable libatomic with GCC >= 16 (2026-01-12 08:49:33 +1100)
> 
> ----------------------------------------------------------------
> tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
> tcg/optimize: Fixes for o_mask and a_mask
> linux-user: Correction to HWCAP2 accessor
> linux-user: Fixes for mremap
> linux-user: Implement epoll_pwait2 syscall
> meson: disable libatomic with GCC >= 16


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

