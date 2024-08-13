Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60228C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 00:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdfRl-0008Pg-IU; Mon, 12 Aug 2024 20:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdfRf-0008Ne-OS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 20:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdfRc-00062t-Lh
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 20:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723509083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuHRyeLF1of60wxUQaWaVOHKJpi4cOmk6lj5+EoHmcc=;
 b=jCuTnHCR621C7BKSlnegppjv2VC9t8K8trzuKva2pL+C/fVh6hGMkurhMY402tH23Vltgu
 mfxMV0Ft3bbhAp9YknXfGZIYmw86ftuginHDwQZQDYlLRHfno/MDh/VO7dndG8vUjCo1Oh
 D7j9KmcTasRmvWFF/xZNsjIsR/sk91c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-KdQyEhLBPPyUS-7xSpRhhA-1; Mon, 12 Aug 2024 20:31:21 -0400
X-MC-Unique: KdQyEhLBPPyUS-7xSpRhhA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2d1bc2352e1so4405380a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 17:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723509080; x=1724113880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QuHRyeLF1of60wxUQaWaVOHKJpi4cOmk6lj5+EoHmcc=;
 b=AH4AjU7Aec+PuxtzGSDarINH0rw8yyG8z5/990opLu7DU+mrq/UKMbd3QOFRUBuTkX
 MllBKLbNhHjR4x1rMGVxXtUWWQbEo8y4lqHI1J0OMTaQ0Kl3wmmqPx0zEEmDkxSmdjdl
 zrjGzft3rmmRYgr76pzNNPxBsSZoNdEnDFQNICZPnqgorHqW+WtLtZxt3cNU3dRsCkWw
 1vNh5jM81BqXBs5vpUilUDNX0R/RDiXgLibpX6/r7ZVlfRqe1krrlrqyRLIJ5tCmdjH7
 QDpIjR5K4Pu0d9/o68bM0iFk+WQqyI8ubn4vigAe0Qtr3K4B9GLcqH9+mPYEpK6Me4Dm
 xOyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLl0R4i9T6UJ3/7S1EPX1WxcvbVAgZVKAB2m4kGUhh+hjK8TOPiUg+EW5P1TDcB3BHXBPbsiFLPAnQ@nongnu.org
X-Gm-Message-State: AOJu0YyZkbAiKusNBMmqDChQcbuZWoifVGLvgJuxewtBD9CI1RFSIFmY
 p7yHQ8GURPlzRahZmyB6OXl8BD5A2QHbzziNqq5SWo3vEtNjngXdlMFTDoc6AUZLNsg1xUf6J+E
 OSpn8ZfL/CXIkUN8b53y7ZnnHLtgNrC5EXv2Tv2BW/u13e9/Uqjci
X-Received: by 2002:a17:90a:1109:b0:2c9:6d45:8187 with SMTP id
 98e67ed59e1d1-2d3943115d4mr1806662a91.21.1723509079788; 
 Mon, 12 Aug 2024 17:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4kPxq4AQldEhCi0EZV3uCid7O0F0+djFz93sZn85JsI+3UFtcvNg6UIvvDPPWngfapWSYnw==
X-Received: by 2002:a17:90a:1109:b0:2c9:6d45:8187 with SMTP id
 98e67ed59e1d1-2d3943115d4mr1806611a91.21.1723509079239; 
 Mon, 12 Aug 2024 17:31:19 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9daf76dsm9029092a91.36.2024.08.12.17.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 17:31:18 -0700 (PDT)
Message-ID: <2f6408e2-c273-42a3-ad9f-035e4adc1260@redhat.com>
Date: Tue, 13 Aug 2024 10:31:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
To: Igor Mammedov <imammedo@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
 <20240812101556.1a395712@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240812101556.1a395712@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/12/24 6:15 PM, Igor Mammedov wrote:
> On Mon, 12 Aug 2024 14:35:56 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> On 6/14/24 9:36 AM, Salil Mehta wrote:
>>> This shall be used to store user specified topology{socket,cluster,core,thread}
>>> and shall be converted to a unique 'vcpu-id' which is used as slot-index during
>>> hot(un)plug of vCPU.
>>>
>>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> ---
>>>    hw/arm/virt.c         | 10 ++++++++++
>>>    include/hw/arm/virt.h | 28 ++++++++++++++++++++++++++++
>>>    target/arm/cpu.c      |  4 ++++
>>>    target/arm/cpu.h      |  4 ++++
>>>    4 files changed, 46 insertions(+)
>>>    
>>
>> Those 4 properties are introduced to determine the vCPU's slot, which is the index
>> to MachineState::possible_cpus::cpus[]. From there, the CPU object or instance is
>> referenced and then the CPU's state can be further determined. It sounds reasonable
>> to use the CPU's topology to determine the index. However, I'm wandering if this can
>> be simplified to use 'cpu-index' or 'index' for a couple of facts: (1) 'cpu-index'
> 
> Please, don't. We've spent a bunch of time to get rid of cpu-index in user
> visible interface (well, old NUMA CLI is still there along with 'new' topology
> based one, but that's the last one).
> 

Ok, thanks for the hints. It's a question I had from the beginning. I didn't dig into
the historic background. From the vCPU hotplug document (cpu-hotplug.rst), the CPU
topology is used to identify hot-added vCPU on x86 and it's reasonable for ARM to
follow this mechanism.

>> or 'index' is simplified. Users have to provide 4 parameters in order to determine
>> its index in the extreme case, for example "device_add host-arm-cpu, id=cpu7,socket-id=1,
>> cluster-id=1,core-id=1,thread-id=1". With 'cpu-index' or 'index', it can be simplified
>> to 'index=7'. (2) The cold-booted and hotpluggable CPUs are determined by their index
>> instead of their topology. For example, CPU0/1/2/3 are cold-booted CPUs while CPU4/5/6/7
>> are hotpluggable CPUs with command lines '-smp maxcpus=8,cpus=4'. So 'index' makes
>> more sense to identify a vCPU's slot.
> cpu-index have been used for hotplug with x86 machines as a starting point
> to implement hotplug as it was easy to hack and it has already existed in QEMU.
> 
> But that didn't scale as was desired and had its own issues.
> Hence the current interface that majority agreed upon.
> I don't remember exact arguments anymore (they could be found qemu-devel if needed)
> Here is a link to the talk that tried to explain why topo based was introduced.
>    http://events17.linuxfoundation.org/sites/events/files/slides/CPU%20Hot-plug%20support%20in%20QEMU.pdf
> 

Right, I overlooked the migration case where the source and destination vCPU have
to be strictly correlation. This strict correlation can become broken with 'index'
or 'cpu-index', but it's ensured with the CPU topology as stated on page-19.

Thanks,
Gavin


