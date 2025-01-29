Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBB6C0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdBzZ-0001lM-Up; Wed, 29 Jan 2025 12:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdBzT-0001i9-TR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:36:41 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdBzS-0002rM-FL
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:36:39 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so49364625e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172196; x=1738776996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+R7CuqVDTi7g9LimLrlbzqUwR0cLugDjPfjJYSa69PM=;
 b=U9UtwzPnCMIk9k/4LK4tsK27DAfcuUkZb81KlUCAJ8rJrd5Um8d2vR7tZWODZrR5ov
 SBbg4D8KIHbTicCDA8SC0mJxQGellC23B7ZtGbOgFZtLzydhoMZVuPB61r/omSXXdqqJ
 yTsZGvenj7gZXUrMW6B35ifpmwCfXa1On5bJ94iL4lRgVx7H42+6bZDSfQeKmpB6Wi+v
 fIdBRtYNYQVKfSCGkI4+DreoCKjpk6CN1u5Jl+hk69gZ/1PabuvQod6xFxWcda/U316i
 e1WEg69YotXS3RumDK0Rw15igi4md28rKqaV2Pkokn7X4fsQXO9l3JfrW4/lj4dZn8tC
 4zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172196; x=1738776996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+R7CuqVDTi7g9LimLrlbzqUwR0cLugDjPfjJYSa69PM=;
 b=weg2hSQ1t5K9F4PJjbV7mU5zRXJaiEcu7nsTxUalZ6LBq0LSUtNdSHmmjVUXX6heyU
 9l+BR8HJ8SFQcubQlc7gl89YdQkud7O74wr/vqWkZGsK1NOWYv353CXcVtns9bEewuJj
 VuU4NGjxkJKQwmm0yoKSBU4i0qhVa75FsONoOjdVI2zTgeO3xAC/M2gj/zm0km+XXWgh
 gl+dDVPQ//fMn5ofsQ7EQq75rX2moitm0O/JcenydQTNs9tGdTs6zvdhpn10qz33lGvd
 utrRwpGjNoqxo4VgEL7BuqJj9lr3ekr85EC10oCZSLc4hngpXR113Phpkk1JYh9y+FRp
 i7Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK5eBTs7bBo2Q3w8516taDq931GD+NdNjiPcCldXl5P1JPlYyy80zhIsdXJPijJO7/P73vVwutPTTg@nongnu.org
X-Gm-Message-State: AOJu0Yxh8smCNkYKzo6IWEoPLDVYeLua+eFf1TE1VllqxtcRIO3l7noS
 Z4aL5qEpP0CpHakYb94AZzd60nmfy3rMD8hwGL7+DjmCB9005X2xzgnMXuX82Hw=
X-Gm-Gg: ASbGnctW9WrLHlWDHsEN8brvklJmD35qatpuxXZFd5iv94yFMpt7wp++vZfDCaknlvK
 pfeMwvhKsNEp34+QwTwGahSl0T2zqlCp2BmUcrmtB1rl64OYY6o1P4mxSJq54XvJhsisv+NrSFi
 qnLOBc+vGVDogGEzfeSrivbN6J+ENdsH4K+gVSKJTmdnh1JVH+yQil/tB8A1sGRzneIKhmAuCc4
 5p7V0OkqaLTzzv2bGUFY9zKlYEiURZ18Jvt7B/pmvESRDQMPv3gmqj2gwa7UQ0up0io3xvrzOKq
 9aKwH4bv6dqYXSHUnQb+l0J8fGMV+9oP94aRUmB+xc7IUBLCrIqdxH2Ia8s=
X-Google-Smtp-Source: AGHT+IFtt1B7uaKmwd7ZhCJ2hrLP3xuOeLJ4VAE9dLMLuC/YfE9zZAKhZ/GXQfKGjEy8E7pfzcm8xA==
X-Received: by 2002:a05:600c:501e:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-438dc3bd80cmr40179175e9.10.1738172195956; 
 Wed, 29 Jan 2025 09:36:35 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc51208sm29812665e9.35.2025.01.29.09.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:36:35 -0800 (PST)
Message-ID: <01c79bec-9106-4be4-b9eb-60f8a3d913b2@linaro.org>
Date: Wed, 29 Jan 2025 18:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/34] target/arm: Remove ah_fp_status_f16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Replace with fp_status[FPST_AH_F16].
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h        |  3 +--
>   target/arm/cpu.c        |  2 +-
>   target/arm/vfp_helper.c | 10 +++++-----
>   3 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


