Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14261C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc4Y-0007eP-FI; Tue, 15 Jul 2025 05:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc3g-0005H2-N6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:34:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubc3e-00069Q-OL
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:34:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso5028708f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572081; x=1753176881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=awFLybBLZuWieb9XS2tr2flBf5L0SERFOrKuBtfoTzA=;
 b=NcdO/wKtHGhtxklkihXaEyvjLCSXxmzNLmgOGH6xGXX2I9lsoDfwpA3aK2tmLDbE6Q
 +QwiwuNnULjWZjtPdAvbgyKGmmcTdKi53rWcWgtWJgtMj88D0ZTdMMcxzjRyD3EYtmC3
 0FzKRGXC10BQYcDRIcKDXr+libWu+jUNPNaTugxJwHMMASjAzWqY1VQ0fB2oL+bdMzeC
 7ddk6U6CBO2kjl+Lakf2wNbqx9NyaYy2yPePy/4uWUjWFoGFDzgWi5g7WrrTCtTIr+9T
 G6AVTH9chv8ZQLcqovznjXaPA0zAi2BXJ7XFuYC3WEGOZtSndm7bDpMz9/jb9UmiKcOF
 WOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572081; x=1753176881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=awFLybBLZuWieb9XS2tr2flBf5L0SERFOrKuBtfoTzA=;
 b=clCfeLjBR6PNO2pHQ4CyN9q3O/YaonSW04lmpDnwb+PUg1pg7tOrfxwZOGCfnfoZeV
 gHI3sFslxTyyg5N+PrOmJ5XmNFZxpuXG4L3bWsXghnrtIi6ytpa+EbfgvUAlVOFQWad/
 NZb6ivq/p/YkPmXD0a49UVgyWeUutupR0OVcvPwi4TFxs0k0qij437ZuGdrYV/zjLzD1
 ebU5YnekwYhAv+zrifWLU1XNQJxCm7YiacicG6iMWx7KVolQvv6jwnkhNB2vh7I5BhxC
 VxXYCP8HnSmqWwIpUs+UxbDthBjdqpz/Z3/Pr9jt5zcnIZJdl37j9/uQP5fcF3UhGvdj
 6ikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3/Ol/KuohVriGmR+7HuykljLbyN3e/hQ+krK8E9hXQeJc9K5wAkXzO4u20+8lerk4AM5/uCh2eUeJ@nongnu.org
X-Gm-Message-State: AOJu0YwiU2VHRQ1WzLbTSD586x8F4/cAhh7fXl5SxIdZocg+XYZTDatv
 sJY6+Km27NrEdZ6Zq65xp6DyVIY21rlJtU1qlcoHWGYb79JlgQwRTF+q1PaStzVo2dA=
X-Gm-Gg: ASbGncuY0IkD61xMckyitDlZQjhHjFmfOC80CEfZq6wyzHjnJPjr36yegC7XvyNbPuR
 LERw38IgZgjqaWQrApseCQJDfG3SbEa5jAZiER9Mwl1dQxaj0ctIPpwvpdh/XQXTrq6mSqnHr7G
 DcwXVoKhuNUSNi1BX2IM0hJ5fMSFFz5gEt9vulFqnATXPH12w0FIWu4MRsbw7IvhSFRPYj3P22v
 6QdiZcqGh5C/UA/oLwfNPYIc7SssgFUATrEujLwRjX6bGt8jc+Q+IRjccW+VQbUT4yqJrhotOix
 txfb3LMKgtsuI103HgSSmbvfAecnNl8Wr4XdvWCrWlXtkAgsM33GpLgYmoeCtGuOTKSqx0O7YBY
 l6VCPbwwhkF8m4gJm0GJswRUJzxu7YS+vQgs9XzZKCgKjJuPXdepmjzZbRA9ubVMPKWghO/0=
X-Google-Smtp-Source: AGHT+IFSXby/xuDQYR2aRC9j+ugEs+E0byGaNbeFsENQ8YKEh3HxZGdxCqzDD+djbMKimO65DhdQ7w==
X-Received: by 2002:a05:6000:288f:b0:3b3:a6b2:9cd3 with SMTP id
 ffacd0b85a97d-3b60a1ac2d6mr1659558f8f.48.1752572080934; 
 Tue, 15 Jul 2025 02:34:40 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d70csm14905575f8f.62.2025.07.15.02.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:34:40 -0700 (PDT)
Message-ID: <7acc0a84-96f1-482b-9b3d-ecff16944ec7@linaro.org>
Date: Tue, 15 Jul 2025 11:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 2/2] hw/core/machine: Display CPU model name
 in 'info cpus' command
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eric Blake
 <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250715090624.52377-1-philmd@linaro.org>
 <20250715090624.52377-3-philmd@linaro.org>
 <f08283bd-51b7-44a0-821c-544107f46dfa@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f08283bd-51b7-44a0-821c-544107f46dfa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 15/7/25 11:30, Xiaoyao Li wrote:
> On 7/15/2025 5:06 PM, Philippe Mathieu-Daudé wrote:
>> Display the CPU model in 'info cpus'. Example before:
>>
>>   $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>>   QEMU 10.0.0 monitor - type 'help' for more information
>>   (qemu) info cpus
>>   * CPU #0: thread_id=42924
>>     CPU #1: thread_id=42924
>>     CPU #2: thread_id=42924
>>     CPU #3: thread_id=42924
>>   (qemu) q
>>
>> and after:
>>
>>   $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>>   QEMU 10.0.50 monitor - type 'help' for more information
>>   (qemu) info cpus
>>   * CPU #0: thread_id=42916 model=cortex-a72
>>     CPU #1: thread_id=42916 model=cortex-a72
>>     CPU #2: thread_id=42916 model=cortex-r5f
>>     CPU #3: thread_id=42916 model=cortex-r5f
>>   (qemu)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> IIRC, I gave r-b tag before. Anyway,
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Sorry I missed it and thank you :)


