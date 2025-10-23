Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6138CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC14C-0006WL-DH; Thu, 23 Oct 2025 15:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC14B-0006Vm-HH
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:33:43 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC147-0007Co-TP
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:33:42 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63d8788b18dso1412848d50.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761248019; x=1761852819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yMGQjLUT5iPpy67DeqCK0GlCMJQ8I8jQdtmtmQ500wc=;
 b=yI9v3l3X77mK7fC3FVjJGj8Iuyms+bnBOiv+fQzdtjnAEzSRuEivIRmOi44kumMSPZ
 KIVvcBalhl+HFoOuGCsTT8ba9ki9HSaqz7r1BE6q8ggxjvro9XtmgUvxxd37pmAOduEe
 qCfPi02bSabE1k9cpybE8Tp1qtPMIAGP+k+CmOc1psXrK1t9bsaHUuw5qfwHd3KXwsgo
 XHlyCQVnw72dW2reFOo7KJp4GXxo49vn/WN+b2HaH/qihS7ZsEeI31nq8UsRt21BIGsF
 mHRz3Yw8LYwjlg90eJqphCrNAwDrAKidKMsfsnoJNYgt7ZqKC4SmqDaE/xoesTcgKIEd
 LfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761248019; x=1761852819;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMGQjLUT5iPpy67DeqCK0GlCMJQ8I8jQdtmtmQ500wc=;
 b=sOG/9IW8h0PDDejg/TGFiYqRSThzkh4JMkRExTrsC+CORHZvo4ugG+KB/5tOYneEd6
 p1QdeYn1hP8bL2/egP7cYI4oaW66MV1mBX2Ko/fvresNxrtZfCx/9RHW0U5udYneF6H2
 kSj4yMdko07GltWOeg0iglLeNLYE6Z74ab6k5kgdTA7uA3bJ3NMsisDzXR/wzdz4dh2S
 cXESpaM58pWmCjWMdFYS/UfCXKiAZRJCms8NVdePrnvyMqmE6xv0DmlB/5J8fyKcIVb2
 txFVbC7I7Czr0aUzONl9P3aQUP68IsEDYzOo3BU7NBBmy/yFcd/+5ywvtiGxzGLikMuA
 ycDg==
X-Gm-Message-State: AOJu0YzTMdCAGeiI+sFmOH7B5Q48Dx/PBfP/BdMOOMKfxSPS60uBO7s7
 cxkbFukUoqnZMPjfsCTlcBZyygAQAzVM7nIQ7elhTQPwlxPS0BBzQTaeixsRwg/Jb04am1iAW9v
 lq9IQ
X-Gm-Gg: ASbGncv1g25dIePk+6cxOrCEllVm/dTWf1I43wfwUu70dNGFEuGB+pZs5AvvoQEQ6MO
 WUNBpMAphF1dZnHXBF12MZIy3t2ImwId8MEj62+RW444irO7fr07XUlkTohmr9DUlYt7ZOheGFH
 xk+DfPVKVurqKeijyASL3xiFhwc73mcEW3JrgEgFCqTCD+sMZaQusrTnTcSMMqIOedxm4QjauhQ
 gu7GJ2R5JiDDE+WdIHDhzTwgwYmWr4V4hApRewsFX4qGUvfKIsEBSIXB3RaTnE3ld07jadY8GL9
 7fKLAR1u5qa3dZ0Q6r6ZH33MiTZkL7am5aG6805EYC0sRID5ZQQoqgWSJ2XjKsZ6X/YnusbFXbj
 zcC1uQT2zoVaFSDE/LaK9lyn/+veYcqOIh24T0oRLjvsMEfH7an9t/9R89teNpIcjiQMpHcFDfy
 0ETGGVeldtTH873sDLse41GExoHpCqRcHul6KcY8H27B9hVL5QBkYfMR1jrV/5
X-Google-Smtp-Source: AGHT+IHBbxUtQ9rNJeVDqtAtDPrCLHW2JmshK0vTqta9KoL+R2ZgKxArmtBgoPjl4iTXPgrdrCDKRA==
X-Received: by 2002:a05:690e:11cc:b0:63e:1943:ce46 with SMTP id
 956f58d0204a3-63e1943d20cmr20920162d50.38.1761248018709; 
 Thu, 23 Oct 2025 12:33:38 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df?
 ([2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-785cd5b1c4bsm7990337b3.2.2025.10.23.12.33.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 12:33:38 -0700 (PDT)
Message-ID: <d0d27dda-72a4-40ed-b114-855f3cf03afb@linaro.org>
Date: Thu, 23 Oct 2025 14:33:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Uefi 20251023 patches
To: qemu-devel@nongnu.org
References: <20251023132825.338615-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023132825.338615-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb132.google.com
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

On 10/23/25 08:28, Gerd Hoffmann wrote:
> The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:
> 
>    Merge tag 'pull-vfio-20251022' ofhttps://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/uefi-20251023--pull-request
> 
> for you to fetch changes up to b6478122f059274b19805e14d12f76d2c0272ad4:
> 
>    hw/uefi/ovmf-log: Fix memory leak in hmp_info_firmware_log (2025-10-23 13:27:27 +0200)
> 
> ----------------------------------------------------------------
> hw/uefi: fix memory leak

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

