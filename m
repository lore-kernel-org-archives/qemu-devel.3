Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719A4D3CC92
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgBE1-0006as-CY; Wed, 14 Jan 2026 19:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgBDz-0006aO-RI
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:28:31 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgBDy-0005d2-AL
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:28:31 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso2549665ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 16:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768436908; x=1769041708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77Ug7NzpzfWjfWyAtp2VZ4twNiWzFxWy0atfRlqnuhI=;
 b=pB1eX4YYLMoiZzPp74IACwABCYju4R/tqCw5HN+yN3rNe84WiZK45RhSfMmKrj/A0n
 Vp8ODvV7PY8qGXpxJ24nxv1PtZdsp0BSHYRNU/iLQowssHsLn3PLQn/rEOpGVnrus8u1
 q8EYG2ZpYs1QAGTRfhRJO0eWp/D3GMVCTjfleNdyicGIHKTO7bpCiRb46YpYiFCxah2a
 5QB8/dK+JRzqy6Q6TumLvx1FBkSOpNxDueSBTANX9J47WvSIH8bU7BhCfUL2fIgKijl3
 nUWgFluUVm+4L7S1mjvM5tL+8MDXB2PjOL7lOIpYETEGsdrkFEz2cQbPfHmCjI0AwQh1
 8Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768436908; x=1769041708;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77Ug7NzpzfWjfWyAtp2VZ4twNiWzFxWy0atfRlqnuhI=;
 b=wMLocSU4c/f+Azxsd8FVPnM4zdn7beCZCrx6vAvamF+8pXSpKk/XVwsMMZ+d40LEhs
 oAbsAoBOEwYHgm6xQExSjtl3lYCDeP66tzSCF94CW40qIt28SBSZ40rNquK0igZQJN+v
 DU4l9PjEfU2V0lS4byts50mc9tS+/KA9xrjUQF/PSHn6NE1c9p95SOEl5L+nT7LqFV5t
 wxP548pUHFy2VQVAytdMgq/d4eIHQaDcT9j7LsZlXawxFT+j3qHG72UidWeN9/Mjx/2s
 kZfP44c5O0zCQsWnp/nL+kJVDaDa6EwoKrBho51bb2jtRndLy1sns0g/YcoNs2bwIugH
 RT2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMpEGQIPOKFoS5Zcrtg0cn2c82XJHROHi4FO5dGRNbCxA+ce6BcocBMUL2xs8Ed7V6o46XtdUYKKz6@nongnu.org
X-Gm-Message-State: AOJu0YzfXMxYZUKBrO7VQHedrqur+Id5DxLQ8qW3HpenGg9wTkg4SNmZ
 bo6q9EdNOoeXj+WalGqJ7t5NAehJZzsucQ6dndJn5dNYx9LfnzotfuJxtpy5cWXbd1Y=
X-Gm-Gg: AY/fxX4vBI1Zp62nLQ9+7cHr/kEvV3RT3U68DEIVKRjZ35HbBtdEZd0MoQotkIZj4T8
 3Abr3LyqIE0lm0N7JS+6erQoQqY/nTJqryf1kqEtf2XlaRD57BpGi14whnjC0X4dXPGOp+agkOh
 OnvBfXb25zv5KGFtJCcxAYanHQtflZb20DxpqFjyfwQ9t6CbfITMu5l7i661MJpphl+fYglZF7d
 yfdazowGM24FAtWfK3eYek3mLIGNA39mYd/XeXmSYvLWmJRiDcuaOzpGZQ3/E7HXAgTVZS0VG76
 86Gx7pDRWVsEkKeqsXgP8an2WIXaPlHePddw+ShQISKHhodzsvGeTWqpxAGRcaN7c5CCHPUHaMZ
 iv4KNL2wbHUl+NV1Hzf0y60cDv9R6raG1HsEX3p3cHjeN18KrUDMmX4g8g8FXFim/aqnfT/Xfhm
 yJ86L5fvPNJZRjkWOwNyTG/E6yHmtMYpdSJbHYQ/bvilEJ1j2kU9YFcE1g3ZGskw==
X-Received: by 2002:a17:903:2305:b0:298:5fde:5a93 with SMTP id
 d9443c01a7336-2a59bc0ca29mr35667645ad.32.1768436907945; 
 Wed, 14 Jan 2026 16:28:27 -0800 (PST)
Received: from [10.244.221.227] (27-32-111-122.static.tpgi.com.au.
 [27.32.111.122]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm236423835ad.9.2026.01.14.16.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 16:28:27 -0800 (PST)
Message-ID: <7d33d835-fcb5-41f0-893c-617a224ac894@linaro.org>
Date: Thu, 15 Jan 2026 11:28:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/41] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260113093637.1549214-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/13/26 20:35, Cédric Le Goater wrote:
> The following changes since commit cf3e71d8fc8ba681266759bb6cb2e45a45983e3e:
> 
>    Merge tag 'single-binary-20260112' ofhttps://github.com/philmd/qemu into staging (2026-01-13 11:51:18 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20260113
> 
> for you to fetch changes up to 7a05be8c70bb789c23076b1ca2563ed7d87c6fb8:
> 
>    tests/rcutorture: Fix build error (2026-01-13 08:29:59 +0100)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Resolves build errors with gcc 16
> * Adjusts the Linux headers for s390x and mshv
> * Fixes endianness issue in the VFIO helper functions
> * Adds support for live migration with vIOMMU when using IOMMU
>    dirty tracking
> * Implements a migration blocker to prevent failures when VM
>    memory is too large
> * Corrects an unmap_bitmap failure in the legacy VFIO backend
> * Addresses a workaround for an Intel IOMMU errata.
> * Implements Intel IOMMU first stage translation for passthrough
>    device. Also a prerequisite work for vSVA.
> * Updates documentation

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

