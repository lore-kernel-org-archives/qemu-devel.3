Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDB1C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlnp-0002MK-A3; Thu, 13 Jun 2024 10:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHlnm-0002LH-QH
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:51:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHlnk-0001RB-BR
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:51:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70109d34a16so997675b3a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718290302; x=1718895102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xWrJEhfxn4YQIAWSaKMmZSgZCELihzkMZ7CIY7A7b4A=;
 b=kX6axHIvpnn01F7B1BHhjQBNMtjg02D/Ek5zR2Au1PpsG6nrUPjhOYsx0pthhS+1mL
 IyINPekAHAGpB7CVrYEQM4G3qCVFjk95cEelbG4M4PwKBmjfdiO978gYqgJiNFuZBTvS
 vPVqYMIHp3M8TAEi4bxFW9cEFtYZDflWPDMH40s/HNYuSx1GrrxsqprjJs6LNSlwrWQc
 PPC9PcxEsUxHKRE40MhoTFvcihsk6JnEtRMqO3uvoHOQMFcVFuVftSyQK7zpsspwvcIV
 FpC6/uyMpOXMG77v5Hob7jhCwXjulEob/JC2upTW13P12dI5R7UvkgksK7U7QDZMupJj
 YdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718290302; x=1718895102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xWrJEhfxn4YQIAWSaKMmZSgZCELihzkMZ7CIY7A7b4A=;
 b=cdpEYZnRhMFYWB5WA86AHDQEGfTcdihiXE8xoKD137uH3A2WS8ECuos0ZXJoqIMTKN
 ubU0Eto6nv3U7K6rUze+6oWhF/JJXarr8RoSb5QAF0lvjotnPLHQ4Gciz5IjS4Xvu7oB
 5MPy9lKgIPBN8tByeYId1wYOdWUqqi6coJU95eqRnjYdSoI6SQNuJlutoLJNJmZO4SGL
 l9HQ1oBYBLu2G5Vty6/RfyTo4iY6c40/MxdCprgcb1fkhwRkrZrn203SBg3G9qsr8JCK
 cFiQ+aKdBrZlaQX29q3bAYnhztOVtdN63qJ7pmA+A9HotF8NJZcvRRGXTKjyLtg2MC/+
 FyoA==
X-Gm-Message-State: AOJu0YznQKa60/VA8E5LRksXTpRWAAT2Np1E86XD14s6mQoKn1/GUl2m
 LKDib8gT8yYVG6m6EtXUDEbcu54vAJzNoCYmsBiLFvs2Pkp20jIBnqQIJD6SBjE=
X-Google-Smtp-Source: AGHT+IEkXWT04tV4uzfaQIzumLg0VxRFFbf+IUAPa+vSJUuCyyF2M4/OgPcn+SWCYIF0SrQ0FLgJuw==
X-Received: by 2002:a05:6a20:9189:b0:1b8:a2ca:3b6e with SMTP id
 adf61e73a8af0-1bae82428f0mr42496637.50.1718290302530; 
 Thu, 13 Jun 2024 07:51:42 -0700 (PDT)
Received: from [192.168.236.227] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705d38171a5sm506791b3a.190.2024.06.13.07.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 07:51:42 -0700 (PDT)
Message-ID: <8f7adb54-756d-49ed-89b6-5650f888f502@linaro.org>
Date: Thu, 13 Jun 2024 07:51:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240611173658.231831-1-kwolf@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240611173658.231831-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/11/24 10:36, Kevin Wolf wrote:
> The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:
> 
>    Merge tag 'bsd-user-misc-2024q2-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-06-09 11:21:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git  tags/for-upstream
> 
> for you to fetch changes up to 3ab0f063e58ed9224237d69c4211ca83335164c4:
> 
>    crypto/block: drop qcrypto_block_open() n_threads argument (2024-06-10 11:05:43 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - crypto: Fix crash when used with multiqueue devices
> - linux-aio: add IO_CMD_FDSYNC command support
> - copy-before-write: Avoid integer overflows for timeout > 4s
> - Fix crash with QMP block_resize and iothreads
> - qemu-io: add cvtnum() error handling for zone commands
> - Code cleanup

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~




