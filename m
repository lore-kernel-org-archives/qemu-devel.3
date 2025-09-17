Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECC6CAC592
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyhDN-0005qe-1X; Tue, 16 Sep 2025 21:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyhDL-0005qP-D8
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 21:44:07 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyhDF-00085j-U1
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 21:44:05 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b54a2ab01ffso4331562a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758073436; x=1758678236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mhIU5Tb4xySh3yw5zvF2qUa3LTXBeik8onwyz/igI9U=;
 b=gljilq/6diSIwuy+AXYZC2dfb0r+KXAyd+gYicE10th3e+xwxM9gyq4a8d8xByrkl/
 nELSqnvBjqcFaP+qpsZAtYSnEnKrYXE81pAfdDf/aVhJ+PGfElxEq1rudpBUiEB5LTDW
 CQdmoJJaOrS2BTRCV6xyKvWLqjdpPib2fwUrjGeFPDa5efei+VZ2NKJdfOo/35dY4CPN
 lDwQGxog+O3DhOBMy1zKRYcPI0mhenBkQLD61PFvrfTiVQNdDlJmII/hZ4Ncz9ov1rei
 D8zndeau7mPWnJKZ7fqgbnPT3sZq1uej24BQ5OFR0wzhuhCtp2rgoimGv0pCg0Byzmw9
 1gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758073436; x=1758678236;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mhIU5Tb4xySh3yw5zvF2qUa3LTXBeik8onwyz/igI9U=;
 b=tCqdeYxBCxsfBqHk8tDfKwcGO//W5+/NUTA5wyDOK2YBrDWzZ1jkhD7wa2wNxorwVU
 IOp0J3JgsQdZe9D8YfFIyvfFTDiT8tQzU+5C5TbPzT3ut8I76pQyYtB60m2ZSs2god9Z
 BAJ0GMZHJw0sFIvq+voGgWjXBnsXODd548EkUdcuezC8i6w0QFZDb5VNFi2iQuxeHrqw
 hMyIsUIOgQrVAyB8hI2nh50xGSdZTeMlo/2XeSAv7NLLVvsr7ZChKI9xG1l4IrhkfQXW
 dhzgQ+v3Q6yeaWlnagqWVOUR66vIP56NPZy4LgRTAbUqEVQM6PtO0I4CDpz6eMdHLtXa
 5Acg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQL0IatHT+2zomLVZO8ue8aR7eiuHSyLQDYQHk08/KPMoBJHjjPRGtHCDS2pIoWDdlF3BnKc9zYUjo@nongnu.org
X-Gm-Message-State: AOJu0Ywo6p1WBHeQkoPSRwyfxpF+ETHdqLBOZZ0WKOi2viwNNGYuZt9k
 qu/d9SFquQSbTAFOUsfhI0x8zVqs243HAoCOEX0xRLuGwA72byW7j7tw+R08HvyncGU=
X-Gm-Gg: ASbGncvYT9j9M0n5jWEHaMwWLmqMO3c2ew9MNM0RGUmYFWJ7w39Unnj/0xpI2Uw2BT9
 dzvwXhIE6sZIu6+2KVi0/BrnopbBZZqRs9KvXAUz+OZL9WjVWVKhMhzF7VR/NsQW6iuSwRRl7dp
 5ocOOqH7rKyeXMDwl2Go2dSTn2NxSQ0EvPtU2D4xOoeL7C6w8gAdZ/FyRjVmHqd1keXw7MI2Y2W
 H6CWSDc3zCJF2dhG2D+Thf5O13g8ngCeBoOwcB5HPZ7c9c9YaEp4BIY+GCBWT0SKK6tXGBZFJY0
 coH730cMnF7MpsYCo54ejfqQMFF6ggQTjAHSM2FRgXO4ks5/nVMDbDJYVz64yrlK3zFpJ00JT8G
 Y8rnff33bBCuGXbwEf9BRF0+XDOZyOqFyVl/66reFOYQMpuzTLywQNmQ=
X-Google-Smtp-Source: AGHT+IGsZpP/fYgEJJg/2aXJDs4Gqhi2oVb3BXQy1CAuy+NB84RnS4kR8tSgGISoqOB3Pad0JgR1zg==
X-Received: by 2002:a17:90b:270a:b0:329:e703:d00b with SMTP id
 98e67ed59e1d1-32ee3f2f5eamr618786a91.19.1758073435993; 
 Tue, 16 Sep 2025 18:43:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b54a398a7eesm15507630a12.38.2025.09.16.18.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 18:43:55 -0700 (PDT)
Message-ID: <ae07bd23-724a-4925-801c-d1f2b6d9abee@linaro.org>
Date: Tue, 16 Sep 2025 18:43:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/36] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 9/16/25 11:05, Peter Maydell wrote:
> Hi; here's an arm pullreq; various miscellaneous new features
> and bug fixes.
> 
> thanks
> -- PMM
> 
> The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:
> 
>    Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into staging (2025-09-05 09:51:27 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250916
> 
> for you to fetch changes up to aaf042299acf83919862c7d7dd5fc36acf4e0671:
> 
>    hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response (2025-09-16 17:32:06 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * tests, scripts: Don't import print_function from __future__
>   * Implement FEAT_ATS1A
>   * Remove deprecated pxa CPU family
>   * arm/kvm: report registers we failed to set
>   * Expose SME registers to GDB via gdbstub
>   * linux-user/aarch64: Generate ESR signal records
>   * hw/arm/raspi4b: remove redundant check in raspi_add_memory_node
>   * hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
>   * system: drop the -old-param option

I don't understand why, but this causes failure on s390x host for hppa guest:

https://gitlab.com/qemu-project/qemu/-/jobs/11379271029

...
# Testing device 'elroy-pcihost'
Broken pipe
../alt/tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 11 
(Segmentation fault) (core dumped)
Aborted (core dumped)

Even more bizzarely, the failure bisects to

Author: Nicolin Chen <nicolinc@nvidia.com>
Date:   Fri Aug 29 09:25:27 2025 +0100

     hw/arm/virt: Add an SMMU_IO_LEN macro

     This is useful as the subsequent support for new SMMUv3 dev will also
     use the same.

which makes no sense at all.  But it's repeatable, so...


r~

