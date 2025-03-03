Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB20C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6su-0000ZL-Qn; Mon, 03 Mar 2025 09:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6sq-0000PX-8W
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:35:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6so-0003bw-6m
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:35:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43998deed24so43020475e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741012499; x=1741617299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IzKDBDTLXCzNXgfM4O2rLl0kbNH8YSEyAFAIIFHGzNE=;
 b=PKrE+NeIU1lUsLGOyv3mI9OcDPo+VvYYjHucCL+aqwFQKB7d80eU4UnEO3TXgzEKee
 mOMlQ74Dzaxm0/1Jp4lpo7GRNAhVpKKnKFYaLXcNlDNm4vsbURo8fqlzdH2Nkrq1ZR3p
 FeAkR9l4a33jigv2phQRsjvarAHJxamg8d2UNHoo/BkxPIsFwrV4/OAFgrcUEMquXDCg
 LaG65BDhq/XXtDFpNnmMGUIZFUAvD/WimDefNCUrZUB53E6Mr2Pfe3OePA/OmJZYb0Mb
 R/k6GLXWmoHYxiZpEeN6BdQGSo/DSVeGw23cfBONQ5uWqThlnawtYl7+y2KUV9j0gtq8
 j7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741012499; x=1741617299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IzKDBDTLXCzNXgfM4O2rLl0kbNH8YSEyAFAIIFHGzNE=;
 b=XJ+xWTfUIU/D0pekIwfEp8S5QLXKvby6jbXgnbIzXxaRxXB3SwJufYr73xlj+Axe3g
 vmJDkJEIvpZnZXxuvyC9m6NFstXSJtQiW8G+EYgzFMNmSuF5tQUCpiVCJ6STuRKlbwsi
 7lJ7O+Oyi5enjDc7mSrzu/cxjU+SPTH+lPLsDgQS+JJAXJzToCp6lSN5sKWl3mQSvXK0
 MDwAlWk5MRtLutwa4AXYOPI73Ju6lCytX/1GmQ27miK2NR+upujCj1UeTO3vwPGJPhpS
 2sZtoGVy1bzrFzr0+STgrIEun3834lKSaVLHXNE+sIHFXT4Wyon8A70V7YfrykSh1qEd
 v/7g==
X-Gm-Message-State: AOJu0YwpMgkfQvfdoYz1n4XWns8nrEBn1dDSnNe5bECefWUB4So9vjt3
 ht/CKSWbsAszjS2aZFPoo95asFNMcjyHxmpsWwUakzpJec+FwsQdXfHjELrqwy0=
X-Gm-Gg: ASbGncv8M2sVmNZhU90a3yYzDGmZOmWJxQkj91BFWGMvlPMSyIzFnAXBoH15N/mAhTu
 LasclvkokMaEJZT69b2QGQWMBrGzSicaaZdx+1VvlSnGeE9JeEoCJmul5+bl0h6OncJlFyRRAZz
 bj4IJYQEXoxelqOblioSNDbHmmJzi4g1qEzihueSygmtD959aSRDWqEHSDyKAthI182C1Ir9rl9
 69SOLuMdj1FckUAf8IZ11m3goOmXzQXzupg9gJob5aRzzDtMq2gq+3Wgv8kq9thh+WpAGMKDwvx
 qA+04rrXl7GKkELOUB5Zb5C8cgOdFG6I6ZVbb/+u+ZwuA2JCary+AmJ3WanqorIfg9D1CSpbBlK
 HGSwBEHujYg5Q
X-Google-Smtp-Source: AGHT+IF6yJu3cDqs+6I7+ETP51ZWeeh7xu8vMkZgwzsX1S1rLcvcD2xFEvU0t5ZwzZ7HHWJaBQRQpQ==
X-Received: by 2002:a05:600c:1c8c:b0:439:9ba1:5f7e with SMTP id
 5b1f17b1804b1-43ba675a843mr96809815e9.21.1741012499363; 
 Mon, 03 Mar 2025 06:34:59 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbed8b26asm51826365e9.22.2025.03.03.06.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:34:58 -0800 (PST)
Message-ID: <4b343a75-faf6-45a5-a3f6-1bf0ae758781@linaro.org>
Date: Mon, 3 Mar 2025 15:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] cpus: expose only realized vCPUs to global
 &cpus_queue
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-9-imammedo@redhat.com>
 <96b40129-072e-46c3-87c5-dd6a51dca1d6@linaro.org>
 <20250303140913.364af986@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250303140913.364af986@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/3/25 14:09, Igor Mammedov wrote:
> On Wed, 26 Feb 2025 08:16:52 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> On 7/2/25 17:20, Igor Mammedov wrote:
>>> cpu_list_add() was doing 2 distinct things:
>>> - assign some index to vCPU
>>> - add unrealized (thus in inconsistent state) vCPU to &cpus_queue
>>>
>>> Code using CPU_FOREACH() macro would iterate over possibly
>>> unrealized vCPUs, often dealt with special casing.
>>>
>>> Instead of working around of vCPU existence in cpus_queue,
>>> split out cpu_index assignment from cpu_list_add(),
>>
>> Better split 2 distinct changes in 2 patches for clarity.
> 
> 
> Will do it later, once folks decide how to fix broken TCG reset path.
> 
> do you mean:
>   #1 - introduce  cpu_auto_assign_cpu_index()
>   #2 - move cpu_list_add() to later stage but keep cpu_auto_assign_cpu_index()
>        where it's now?

Exactly, thanks!


