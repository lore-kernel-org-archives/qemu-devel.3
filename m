Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A213DD6ACF3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGL3I-0000Ca-KU; Wed, 27 Nov 2024 11:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGL3G-0000CP-8z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:38:06 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGL3E-0008Kd-Nf
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:38:06 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ffc76368c6so57495981fa.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 08:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732725483; x=1733330283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yPg2zD9msiIP4UazWNmbMVsy3mypUIus3dfRFXxnZ/E=;
 b=VNzz396X0lrUxsOoql2C3udAKQT0CJkes4zgU8JjYIpRNYjhwZKg4bbEQSQ88YcSJ2
 4P1k9aYta8RCkhVxGxz6AN9UCr56jt2XFTqsWbgPfuCSLxApJuuDQg4r5U0xZZAW+Gyp
 xgL6WLJDRKuzy7Rdz920Xj1Eh64mtaoPf1L3V5bWxpdB+VvqqkGFKxdEErqDbdnCA2ZC
 ZGDxE/qKZW3/vB0cqWwoeeJA75KLp9etCepZ0G0af4tsycKxSo/dqPdrlXrkZ+5nDtrD
 fO+eSbFTG/wA77ut11LyRs/kWXDUMiEakzSlANM9r+yW4ekef9461bGb5bNF1tNteLIn
 scJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732725483; x=1733330283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPg2zD9msiIP4UazWNmbMVsy3mypUIus3dfRFXxnZ/E=;
 b=UAO86Fm9ixZvNhBH6zPZKSxgatdWWW0lpd+t0acbudWxcVP/6jMkryuqOJD3U3ypCK
 Kn6NgZxyb22asDayz2It6NsAH8SFVTuJyRFeNJSwigatYw+fnnLoBZL+rvOY5Lrkr87F
 OutU5ZGJqQ3rkOPelQ2aLHmPhoLzdsh6nOlLyoPyx0Yk/P/vu40UGs3Zxim6r41tY2Mn
 enAne58mVqV+aFlvplPsVRsfvTFHNPJkXeYYmGsnkedHcqZzGG1k/Nx10LFuCF//AkB9
 R5/nNXxROxKE+IJfL2cyXANcs4dAEuOvq0go63fE2Ml2FzGD6aHE0zbi2cx9taYApJ6+
 Fcpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlpp2jf2FffR57EU0DQhuPFsgRNdD7Tmoy82fkZTbSdNFKwtW2xZWNXF7aGvShEFFUSm9Gmk3YkqUk@nongnu.org
X-Gm-Message-State: AOJu0YzKSFOoaEI9rz8caWKTQuSkRMHZrT0Qd/3/QW1/sYGzd0TmfM7X
 IodnaCAE0CQjpuwgKHWkvdHB10Mzn9LUR2T9Rudhs/r+GYzELCBzMTFXxgcZNhE=
X-Gm-Gg: ASbGncvfp4hofKdv5ZhbpAgTlb80wgYuSGtRyIDPFxBgvIrTW88uhwchl1Btp+Ut7YC
 K7FzYjU3CuStio8ILzieFKdQgsBDPTgBnj9Ze8PqRRKJNp8DFwRYbbksVjeDYd9AUIqH0Ok/3Py
 4IW6p12Iffcnb6EwytNf3QI/CZa86Qzw2ZbPH0l99qesGtP/vnIaifft14vu0kixTE/912sOs2Y
 ZUGKHGBmwRTHVc+s+I9bwxGf2a9PYqFt0lrDHQGU8cal+Dwo20YZtaEYoEGUNJ1gzEr
X-Google-Smtp-Source: AGHT+IFRTN6b5k63THkjjbG/A9CCASBLRWdCYalSYsB5b7Qj5hy6apxYsL927dgLrpY+7K2lTqzwrQ==
X-Received: by 2002:a2e:9817:0:b0:2ff:d7e8:bbbc with SMTP id
 38308e7fff4ca-2ffd7e8bc54mr21128171fa.27.1732725482758; 
 Wed, 27 Nov 2024 08:38:02 -0800 (PST)
Received: from [192.168.170.227] ([91.223.100.71])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffa53a0729sm21019591fa.118.2024.11.27.08.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 08:38:01 -0800 (PST)
Message-ID: <1c051d59-ffc0-4c80-ba14-a31dfe6ddf18@linaro.org>
Date: Wed, 27 Nov 2024 10:37:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/6] target/ppc: Indent ppc_tcg_ops[] with 4
 spaces
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241127121658.88966-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22a.google.com
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

On 11/27/24 06:16, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu_init.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

