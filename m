Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF667CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDT1L-0000Lq-T9; Mon, 27 Oct 2025 15:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDT1H-0000LG-2j
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:36:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDT13-0007zr-HY
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:36:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso4569049f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761593781; x=1762198581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OtpSmA4lvHQw+qhD0+SC3+dTyDLm6Oqa94lJVIuGPpM=;
 b=LYr2Wx5AiPTzHBZ81qVdVLMsfJBgZb2h6vDK216ryJlzCCM6MDKhR3kJvCXm4k5zAq
 2t0UGpucSTxQxX+Cpy+EXTM8inn/jq2aW1wPtSZOiXXYWrtYi4lhYKkFrqiYsvGVXxFR
 /eCX2wfmUzbdQD80lfRJsY2YJppoK6aLGXq/PLdw47OXhNFXddmpt8ZgZILbxrSNhQiW
 7KKr2h9j1974a+W0kvnFbHgTAz/gJ7twZOoPe3GxPNmiv65MmNcgq8orc0Y7Y3EzX6uA
 tULCvptfPAOmBRng84WBQH61Bs/aExPhtidwNXgOF7mn5vC8bQwIu6ddLAGjegTfLqDK
 s3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761593781; x=1762198581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OtpSmA4lvHQw+qhD0+SC3+dTyDLm6Oqa94lJVIuGPpM=;
 b=lZK8ze5okjpnfPXDWsv9tz8zdBzRkAs0g9gkSlaShZNwYJaXQfzlrwbV6W+akCqyp2
 gerKIo5HJuwkqYenEnSr78VR9N8O+Wwy9gYtE3jiQh2GRIkDBRF138zAiC5S6sjqQ76q
 ufHWKqDXRerHwdJcpqLOzJHFZxQvRpGNAIL6qsarwU78I083QkYBGsAVMdVHF9Dl+nOM
 S+tgkw4+o0qxqSxYWrvUJX1gaj4AXHrdbydR/Cf8db5iswY36v9xA8nBYp8xngdF4XGW
 3mlTEIBVscmUazsezBXCjJsjuod6Mdu0nx+dZ/YVjkI/3ex/gCVm9TNx61OBzx9EN2oL
 0cjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfsxC8wYF9HL2kD3fewh1S8Ar0sDomfL8wXcNFl+Xyw3vSaelO3I/oSTvkie6YtvyxuVQ2lwQ8Ajaq@nongnu.org
X-Gm-Message-State: AOJu0YxBuVsh0Zu2Ag8Yod7XBko/C3oCRRq8QdtEdx8h650IAL3CZkAJ
 UiBsGVRoxJ+ApMs7SZUswEWJbaKa+YIwlWysXBt5jTHZt65YBXByPRJyBzTlqUxgM0Q=
X-Gm-Gg: ASbGncsHKyHBwYjseV5FqkV/EfuvLDMoJkzPD/UbG/qaPSYs62fR9TNqKky69VmnKLi
 n4ss7mSOJB+C+MdN54HM8C2z83SZJ0dqt5D1thNVvcs/aZGt74HJMiU6OY3S4jffjvqZTVnfsb8
 c9nvK1Ghm3GliMP9uHkRCY4WR+ACaScMo4CMJ7AaKyWqUmx77uAJQF+E708i7Evoi4j6d528CPi
 LPwOOicZSwnBrmzv7oM7ciogOcM6j2wqbPrB2t3nnuIYfbQfyGhT+NCbLTZUSYO/cAR3jO8tkyQ
 ZipfCA4wS4e/Ugmd6D6mJ2zBhYlUksqspI/t7AyVd8qWS7N3YbzevykdhnNUp5DZtiwxyHsH6IJ
 lI0tVmb6dFrdocPa/Kd4HdSm6nhRjcOYkdHJJpSYB5sqGKieCrLOi8XUhlPca2a0bQsR4ns7EpP
 YbFQv/iAYypR+7fLy9cL1y89LLNjXXK30kBvfTy3hiB/U=
X-Google-Smtp-Source: AGHT+IEI9qiAXaVSDgdW83emlATRVGvTG9rOvi8VYlsEa1g1YjFcsEwu4o3tV/cvGjsvf8ZqyrWUkw==
X-Received: by 2002:a05:6000:2c04:b0:427:83d:34b6 with SMTP id
 ffacd0b85a97d-429a7e7a47bmr872295f8f.42.1761593781071; 
 Mon, 27 Oct 2025 12:36:21 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d9e80sm15888096f8f.28.2025.10.27.12.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:36:20 -0700 (PDT)
Message-ID: <01099e6e-4234-477c-9df9-03ae332fec27@linaro.org>
Date: Mon, 27 Oct 2025 20:36:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/ppc/pegasos2: Rename to pegasos
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <275cd2d5074b76b4a504a01f658e85ed7994ea3e.1761346145.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <275cd2d5074b76b4a504a01f658e85ed7994ea3e.1761346145.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 25/10/25 01:31, BALATON Zoltan wrote:
> Now that we also emulate pegasos1 it is not only about pegasos2 so
> rename to a more generic name encompassing both.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   MAINTAINERS                             | 4 ++--
>   configs/devices/ppc-softmmu/default.mak | 7 +++----
>   hw/ppc/Kconfig                          | 2 +-
>   hw/ppc/meson.build                      | 4 ++--
>   hw/ppc/{pegasos2.c => pegasos.c}        | 0
>   5 files changed, 8 insertions(+), 9 deletions(-)
>   rename hw/ppc/{pegasos2.c => pegasos.c} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

