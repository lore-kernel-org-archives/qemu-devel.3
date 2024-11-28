Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E94D70DE8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGipB-0007Gs-Hi; Thu, 28 Nov 2024 13:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGipA-0007GX-Rh
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 13:01:08 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGip8-0000Al-Cg
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 13:01:08 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71d5984e56fso438590a34.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816865; x=1733421665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KmkZA6KgNVQz3pwIYP98e5o7gc7bTLHdjWUErsnrUN4=;
 b=rtXYZF5Ftr5lSzqkaumyS7YRuhMTGov5q6bvsy08I8exC40Z+EFxp5I+XMd+LqlNvA
 k2roorABeINgsXoXxQ+zk9MiNiMuWQOidnx3uVaiy/cMiSIKBnCEzhrkt+HE84pc08Nz
 pNgCOyLza/tpvvFgqEG37Kd13jGUPNFdGIBTm06prQC9+vibyEH/GRcCjsG7aQF8KuxT
 I+cp0uSK8QXNTI99q7MMfvGs4VXAwHQtSGnhdN7MF9FdHRwPQt58x4iny0mIEZ1XDaTf
 4kvqEeB/4yzYTi0d5NxjerMxg2Kecw4INPJCeBCxP98tSPuC9HEU/ovs11iX5CWm2kfs
 XGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816865; x=1733421665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KmkZA6KgNVQz3pwIYP98e5o7gc7bTLHdjWUErsnrUN4=;
 b=HIYLUGKw/jB6FGTuQoVwEZX9oYQ2xtL3/aGPXoZ7JmdZDyIA9/N5c4X5vBvNnKHD5v
 Vjfhi2wQM2cqUWD/pyI21I790CjKuECCqIUnb0QiMQVp1OA+KFViASMU3zG8QiM0VClw
 fZqH9FXPmwjejI0q4g26aerEAEhtA+HEKoSWLr+3Al3AXLvCVoUIy+h/v7/vwQ8fFO0i
 r3hAoAwHLOACOiSshTumnQdzHA40X0sY2ubDmHz3Qr/6lrltOZhJXH+CueB67+osH+7j
 zVBmGYAljCQfysmaGfzvzgPoK+A+YGmeN8Iz2f52ICv/p4MZgGjZIlhYJzWzKngUM6xf
 vcwg==
X-Gm-Message-State: AOJu0YzdFBx6ETwVt/NQ4+cnNRHGp/I3fFUXGTcPlLU7DJT7A9Irf06L
 lw6cM4Mpu2TMz405ucym5LnaOmwqk4YT20cLbV+GECYWtmfJU0Cx/VstwPoMXAX44i6S+YSt8w1
 2nE0=
X-Gm-Gg: ASbGncuMkkUVe4LATsfKxNPWLcBKrRutyt+euQOHT7r5Aq/1XINNZ8EPz56fPqksuqh
 //U/hEhH+LB2wu9DvVFszSc7ZOyIO+svXMQS8zH4xbLNLcdcc4xkmj/yh0AgagUp6/Yuz32xi8b
 yeF4rfDJYzyvqrgE4kPrFWZ13IWDRoyqMitHa+uvNbsiONtZfmT3GmiZsSTE310HbeyFbJnblqf
 3YrrnS7HloBgvIdzQ1v+x8Qt03MGNc1fW9dfxJIM0LMc7tkdZqkg8o51VYx0R8a2pE=
X-Google-Smtp-Source: AGHT+IEcPD5he/ezfMotK8DRS9i49IQNgVFe+R4c6qBXsWsnqQ8tvt+diSEGfDtm3te53Us9iiT+ew==
X-Received: by 2002:a05:6830:6a9a:b0:70f:3720:16bb with SMTP id
 46e09a7af769-71d65cf342dmr4662117a34.19.1732816864720; 
 Thu, 28 Nov 2024 10:01:04 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d900dsm402044a34.57.2024.11.28.10.01.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 10:01:03 -0800 (PST)
Message-ID: <eac37ef8-4df8-481c-badf-2fbcea447404@linaro.org>
Date: Thu, 28 Nov 2024 12:01:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
To: qemu-devel@nongnu.org
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8734jbh21e.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 08:21, Alex Bennée wrote:
> Yanfeng Liu <yfliu2008@qq.com> writes:
> 
>> This adds `virt` virtual register on debug interface so that users
>> can access current virtualization mode for debugging purposes.
>>
>> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
>> ---
>>   gdb-xml/riscv-32bit-virtual.xml |  1 +
>>   gdb-xml/riscv-64bit-virtual.xml |  1 +
>>   target/riscv/gdbstub.c          | 18 ++++++++++++------
>>   3 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-virtual.xml
>> index 905f1c555d..d44b6ca2dc 100644
>> --- a/gdb-xml/riscv-32bit-virtual.xml
>> +++ b/gdb-xml/riscv-32bit-virtual.xml
>> @@ -8,4 +8,5 @@
>>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>   <feature name="org.gnu.gdb.riscv.virtual">
>>     <reg name="priv" bitsize="32"/>
>> +  <reg name="virt" bitsize="32"/>
>>   </feature>
>> diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-virtual.xml
>> index 62d86c237b..7c9b63d5b6 100644
>> --- a/gdb-xml/riscv-64bit-virtual.xml
>> +++ b/gdb-xml/riscv-64bit-virtual.xml
>> @@ -8,4 +8,5 @@
>>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>   <feature name="org.gnu.gdb.riscv.virtual">
>>     <reg name="priv" bitsize="64"/>
>> +  <reg name="virt" bitsize="64"/>
>>   </feature>
> 
> I assume these are mirrored in gdb not a QEMU only extension?

No, we're making this up fresh.  This needs to go into a new feature, at minimum.
But buy-in from upstream gdb is always better.


r~

