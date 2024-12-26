Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB05E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwev-0003mB-J4; Thu, 26 Dec 2024 17:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwet-0003lz-M6
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:48:47 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwes-0004oR-7c
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:48:47 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso6575772f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735253324; x=1735858124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4RqubyrmHrIB9rMo/V6yzRsLVguO/PQL6S5ocRQF6dM=;
 b=UiRRwKaP5xWb7kwbf6pCJ+rax2y0QP9hKF+X7MOvWlF5J0L8AuYy2xYnNfRm4vm/3o
 5GyLpbzto5MtjlZOog4qbOlFTs1vjUC8SDHjrUUhOW6GAzujNUvF2HRztkD2wW+8v3xX
 FFOCI8nql3yqZKAgofFe3MAwYh80hsMe1TeoYp7kUL3dbgTUphpk0GIvkdSMdXvLERHu
 5sISVkCjb2pYtwfZnRlSJxHvPHHaNge6MDAeC6DgF6jPLM74DA9xDDWUui39YCN1GyHg
 +P8nsC5mjRyuIXhqOJFvjqg+4p6iDHddOpacQfRRVsy3jLL2N3M2kmyiFck68LfGzKIf
 e1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735253324; x=1735858124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4RqubyrmHrIB9rMo/V6yzRsLVguO/PQL6S5ocRQF6dM=;
 b=P9UBrEyvmia8vBdUPuP/8PYBx8FA3QLr5rGEmihVvDELnPh/0WbLONIYkMgYSATgen
 kCKEKR/xEBvXlIBXH5Qia975B85IjXlBztWkLGZVjGEDb0VKmHeBgNMSTnAZ/430qd9S
 TVUflM3HT0JNrO7l89sAlmow4H80w4djal7G7dp5U8J32XwAhbrh4040/d867/KKIvZ/
 YkrC/KV8EgWt5rfVq++PPQTJ2hhqxQCT0Tuoea/Thp2yb3vV8HtzqEKh+Sy8dlnnZb8S
 zeOFCR2pKP4kWwAiL8uYPPinyhmNFt3sUSwSCAQkrCQs1qOIZSKa5J0u+QQiG5aCqVcO
 0QoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAexSwHiJKb6SbZRsjSyW816hRiQ9V3/zfvKZWa54HXsaRrI9Wo0vUPNAs7bPjgDqDOJwIVyFt4Hkb@nongnu.org
X-Gm-Message-State: AOJu0YwdO+psQHNWRWTGRPjYOjS3LtOWlyXk5ipc625fi+AVNV8jPwIZ
 CudJArQL+ciUWyQ4m85Mh1MqKqDFrQza7u8ANkEAJQI6zEMWC4mJBNY++e7s80Q=
X-Gm-Gg: ASbGncu25bLpC8/E1HAMOLUz+jBdxLDEkOJ93OyYnMSBo/gFT1GmPMCB4HgMuZacYUL
 yjhARsTWn/QG3iZPFykIY/bIr+ylg9Z5m+c9YONr3eLR4/XVdZF0WULIt2GM6oZpka21jfbv3Da
 nufzw+WimxB3gxEQpniNygPNGoTfrKvGJlFKSl3DSppFmmRGMpxHY5FuzOpyv0YB+KiWhrd1GJG
 DrvyHXLgcm4BnZM0Tgy7KiEhAMBcsl9V4P3U4czXsr+O5l+ubmjqB06Tts5++ISCxW6iJMkUZVQ
 ytDt48+8jkE6mwTBrShxyQ==
X-Google-Smtp-Source: AGHT+IGilcDTWBH8jLHaEbU5ynEmIRueLkAFsZw31QQPeBDpX8mIcO0dhGMaQgzb7B20oeiEKTg/WA==
X-Received: by 2002:a5d:5f4f:0:b0:386:375a:8322 with SMTP id
 ffacd0b85a97d-38a221ea68cmr21309010f8f.13.1735253324623; 
 Thu, 26 Dec 2024 14:48:44 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b41904sm278851035e9.37.2024.12.26.14.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:48:44 -0800 (PST)
Message-ID: <1f72e77a-5da9-4119-8e92-a707552f856f@linaro.org>
Date: Thu, 26 Dec 2024 23:48:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/23] target/loongarch: Store some uint64_t values as
 target_ulong
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-6-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-6-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 26/12/24 22:19, Jiaxun Yang wrote:
> Store internal registers including GPRs, CSRs, and LBT scratchs
> as target_ulong, as per architecture specification.
> 
> The only exception here is tlb_misc, as it's only used by QEMU
> internally and need keep to be 64bit to store all required fields.
> 
> There is no migration ABI change, as target_ulong is uint64_t on
> existing loongarch64 builds anyway.

I'm working on a prototype series where target_ulong becomes uint64_t
under TCG. This patch is going the opposite direction. Not sure what
to say at this point (I'm not rejecting it, just wondering).

> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/cpu.c     |  34 ++++++------
>   target/loongarch/cpu.h     | 132 ++++++++++++++++++++++-----------------------
>   target/loongarch/machine.c | 120 ++++++++++++++++++++---------------------
>   3 files changed, 143 insertions(+), 143 deletions(-)


