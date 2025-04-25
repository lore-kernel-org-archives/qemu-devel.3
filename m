Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C538C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GV1-0003qX-Ad; Fri, 25 Apr 2025 06:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GUz-0003qG-6i
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:41:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GUx-0000MJ-KZ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:41:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39d83782ef6so2265984f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577694; x=1746182494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r02s/+95VEDbGM0QG+FBhPDlU1Rgutb22/lqHBanFq4=;
 b=vVBAii3uZbdcFJxzx0Nk6WUcK8E1gJbRTEISfZONQjetUpZw+cG38RnoNkAd5kaRv4
 POwAldg+xqYetCmufZgJov3WFsbtfPvLjt95cK+VjdxTVt6yImxNn2D7Slu2rDQWuAPD
 F0mj8joVrh6Ji/s7ePL450GAZ2Pe9b/dNB9bpYYR/u7J7mJ7s7YXq7aZnyA/viye8Be5
 d1YIKFGflVprIIJDCB3EQgLIXBwcJnbbMLxbRi0kiPE/xEfGXKAs8htvQRce1II0cqur
 VQ3uRtIqBPVBU6ooxLC3kZlcNu1Iy8z9YK78k/+SH1v38p+NkEzR8z4/OIq1+BVYUiBT
 Q/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577694; x=1746182494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r02s/+95VEDbGM0QG+FBhPDlU1Rgutb22/lqHBanFq4=;
 b=WnB6kABduiLyYxBe290TwiHOF4PNVLGMfBf+kHydCsej5L6wM8N/5CL8z15wlhX6jc
 i1QGWF1vEfOeBShQO+AAi5EpmJbH9iwx95jLGkyZwiTsstGrQjzmvYd+lshDU896rcNj
 +LXyrzBLLfxXTv52YitqnUcoGJWzCetY5FLkw0JELmgKBn2tSM4a7vEW3losM86ldAtc
 qO/8BwkPGfWus358HiAMnXnErjAMBs3lTlm+GTY9upqpxH0cJBG6fp2B4LdvBo7rL4qE
 MTRm8ghF5hIYhfIuTCuNpyaQ+k9IrbeE3U9rvxWHlgNUMVLUbs0RULV+k1b9UxBsJNic
 nVcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW11ZauD+9pwX31NaFHAXiDZGKTzo3a+Ng/fSDxgyL0ezpJpWxZfcbOl77Be3XlStOKkUREqWj+6/ZL@nongnu.org
X-Gm-Message-State: AOJu0YwpEbCjkZQp9h03gSRATgvLKP5WUZQ/vkVkeqk5rq0tfQ7WjGz6
 B6nH0UR5cUBASwU9y8PVf5Iij2wPxSYcDLzRcX42PT/4k080MOBGehannnWiaePTmyfshZXKp7u
 z
X-Gm-Gg: ASbGnctmg4JbjhKg58T+O4SAIgnOteUW0bMr2EX8xxD0yf8D8fRKVeF9UG5jMDzOKQS
 c3U45pyMRjCosT9k8cm3blM/Y/2d+xe7lrriZ/W/oq5QJCpNOpDrjOPkbKasy9CccMdnSK7w/9c
 eoumKinalb7WNElqt39qQsZ/n/fKl8c2e0xsXQ1BJVwa10E6UuXcJvIHkI8ZfQU7ZtE2MLwikR+
 aRaNaUONlFABriL+r9aW8oErRDbhS9sZcCvVgODprxTU2IjOCJivl+UQHZFylbYSkRGNgujg87u
 N5F9//eR5YQrQLFEfo1JB9JolNQpYpQzi4N1R5g8+RxdMssc6E1pEy+JVRUOx7PigxWhNalbzd/
 PEtrhr6le
X-Google-Smtp-Source: AGHT+IEwpvbA5OpHoE/6obwWtlTe6B7wDrxP2xCzODHMuPgQowdbnbfeF3sicIaA7sIEifSfW7YCPg==
X-Received: by 2002:a5d:64cf:0:b0:391:9b2:f496 with SMTP id
 ffacd0b85a97d-3a06d66d1d7mr5223194f8f.16.1745577693836; 
 Fri, 25 Apr 2025 03:41:33 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46976sm1962209f8f.63.2025.04.25.03.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:41:33 -0700 (PDT)
Message-ID: <892aa3e0-d5ac-4501-8e93-56b35514f163@linaro.org>
Date: Fri, 25 Apr 2025 12:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 0/9] target/arm: Remove TYPE_AARCH64_CPU class
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 17/3/25 15:28, Peter Maydell wrote:

> This patchseries removes TYPE_AARCH64_CPU so that all CPUs,
> both AArch32 and AArch64, directly inherit from TYPE_ARM_CPU.

> Peter Maydell (9):
>    core/cpu.h: gdb_arch_name string should not be freed
>    gdbstub: Allow gdb_core_xml_file to be set at runtime
>    target/arm: Handle AArch64 in TYPE_ARM_CPU gdb_arch_name
>    target/arm: Handle gdb_core_xml_file in TYPE_ARM_CPU
>    target/arm: Handle AArch64 gdb read/write regs in TYPE_ARM_CPU
>    target/arm: Present AArch64 gdbstub based on ARM_FEATURE_AARCH64
>    target/arm: Move aarch64 CPU property code to TYPE_ARM_CPU
>    target/arm/kvm: don't check TYPE_AARCH64_CPU
>    target/arm: Remove TYPE_AARCH64_CPU

Series queued, thanks!


