Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C97AD3C919
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 15:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2BR8-0006pB-3v; Sat, 19 Oct 2024 11:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2BQv-0006ns-Uv
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 11:32:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2BQs-0003xa-V4
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 11:32:01 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e6f1a5a19so2221800b3a.3
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729351917; x=1729956717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ba3okV9umH8bhme3pbSWEvwPAhhpMBZBXu4jIw51l1c=;
 b=jhJupDR8JyB3DGdWwJFd/dPCQ3LADpJz1M0GGPAQRd+w1rgWnXVLkU5m+Vli2v1fdf
 BpGSsYse3dzbFwnZFPbdr84kGb8c4IiM39XYMzmJ4XdgrEWXX9mOMp55PdlOtfmPnANw
 IUR9S2iUV7PM0q1NvWELEtSwQ/S1fPFpIHh8LRU5/E7DttP1F7PGVs3nZaarkjcfSXPs
 awHzRo7aVAyob2Dpp7LVN93eIzATKTbn4NR/SN21hsKdy663Nd1oH1Y9CbxQDwvhsqGs
 WeYf5KLf+5JGtHcHpm2EBBPBDCXEPX83MhfYt5tod72tuCixJm9IN87Bcxl/Cb0aNDZa
 KB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351917; x=1729956717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ba3okV9umH8bhme3pbSWEvwPAhhpMBZBXu4jIw51l1c=;
 b=RBo6aQMjuZLGUcEkfxOxP9DJDzhOUuvISu1tmN5akKPNYM82G8HKnofzw3qI0hgjPH
 /rO6fA3DvnqRyC5N2QmH/5j9zXB8TYzgXwdtxxsZzT+GMSLrIEXF3gjcgWI/oZVCSIA4
 dcUjBEPezSap/2bq2iPqAsHk2AevK9ZM5sjVlouW11CPosd4HXOXQypZoRllQ/w2knwg
 x9SRtmPmPHnoZN6L4Lv6ll0uI4jlkcCnyVbsfwcLU7hC84QeZbe8VK45RaQCu3CVVp2l
 pAyAcvbU8OwxhIDtI0I1BODW+VTODcjN8xTi8EffmEUklU2v1KbWlII3xdT5+xT2eeFO
 E84Q==
X-Gm-Message-State: AOJu0YwQk34gPP/8hIyWWrJgRvsGle5UO8wuBJUNOl0dBMxswTwS+ijT
 DdijlADY/xkHH/6QX0gYXjhvhfjslSpIasaEymHHGrKqDNYg64rkae8t6Fn1cDw=
X-Google-Smtp-Source: AGHT+IGg9NRGX64iJcX6kMU15dadKvhP2Yku80ZUcTvtmhE5FF/5wh8YYya2XNK2k9HaNa6Y3Mk1QA==
X-Received: by 2002:a05:6a00:1803:b0:71e:688c:1edd with SMTP id
 d2e1a72fcca58-71ea3399affmr8921532b3a.27.1729351916737; 
 Sat, 19 Oct 2024 08:31:56 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ea34ac42bsm3213071b3a.197.2024.10.19.08.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Oct 2024 08:31:56 -0700 (PDT)
Message-ID: <25d30431-32d6-4729-bdac-3bce64fcda2c@linaro.org>
Date: Sat, 19 Oct 2024 12:31:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
To: Peter Maydell <peter.maydell@linaro.org>, Jan Luebbe <jlu@pengutronix.de>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20241015135649.4189256-1-jlu@pengutronix.de>
 <CAFEAcA9sjszCj=Fu-A-=qQV_jawnomJ-Nqnd=Vx2vLKmYZ1-nQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9sjszCj=Fu-A-=qQV_jawnomJ-Nqnd=Vx2vLKmYZ1-nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x431.google.com
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

On 18/10/24 12:42, Peter Maydell wrote:
> On Tue, 15 Oct 2024 at 14:57, Jan Luebbe <jlu@pengutronix.de> wrote:
>>
>> For testing eMMC-specific functionality (such as handling boot
>> partitions), it would be very useful to attach them to generic VMs such
>> as x86_64 via the sdhci-pci device:
>>   ...
>>   -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
>>   -device sdhci-pci \
>>   -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
>>   ...
>>
>> While most eMMCs are soldered to boards, they can also be connected to
>> SD controllers with just a passive adapter, such as:
>>   https://docs.radxa.com/en/accessories/emmc-to-usd
>>   https://github.com/voltlog/emmc-wfbga153-microsd
>>
>> The only change necessary to make the options above work is to avoid
>> disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
>> kernel already supports this just fine.
>>
>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> 
> Applied to target-arm.next, thanks (unless anybody would
> prefer it to go via some other route).

Thanks!


