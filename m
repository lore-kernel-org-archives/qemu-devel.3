Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A512D1358C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 05:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ImO-0007n8-31; Mon, 28 Oct 2024 01:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t5ImJ-0007m7-N7
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 01:58:59 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t5ImF-0003uX-Ft
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 01:58:57 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e5fef69f2eso2336312b6e.3
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730095134; x=1730699934;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iC9F97pgsWAl0wQds06f7+VMZUFxzY9T8D9j2TbtRLA=;
 b=H412Il1P2vLRMrCcH9OWpbiHWAetGoQ7n2BEVINuhwTaaw5vwr7+7t10M8YaYBeMbu
 hIsgEsFlmU7je6pwUTSkNG+s4ODtk+YqbYPkhmM1zTbmSSnvdSaKtalX01PPkngUohbd
 hdm0zFepJm1aqGF+aBIEiw3E2KVnlzJoAIOvtuGTxh+Dgf4Q3QUVYEUE6OapCrkqnmFZ
 3M5G9Wt3VcSMjQfmVER8zqKqHjb8qQSpmAvOfd0jA3QiWJg9B5LpPFDveOejuyUeEeQn
 tFvYpgoMnBiH+gFElwQX9S8b84/y5Ddi5rkioR+erIXDtr+3zP1QQBJmuVmmANIVOny0
 /HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730095134; x=1730699934;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iC9F97pgsWAl0wQds06f7+VMZUFxzY9T8D9j2TbtRLA=;
 b=DfaNKb3L+qlOQo3UUeVMzi37ieAepN6m90jSJsZtyC4woJJXk4mG5CNynkTV86936Z
 +SWIQ0q/8AsTUoxZ7ikUTGHm/PZGwO786rueeba6w5Sp8Xb2JoKrVWvJvorasshKUh1F
 beRtIKvtr5xnsBPUsncmOF7FinO/BJZtl6/GnlOFRJOtVyrXGB1qOcIqefjLmhMEHJi+
 NZlol3FTWEck+/uIk6HkUT0oRethMNxd6HhfnGvFcAaUgww5zrJxEIVx6R3BqGYd9PaU
 2Yy62kQNzeGOOxhnfXe6g+2lkPYCWAUNhaOxYES38gmdliEbLCH+q/hxJr/NBCTZMpUH
 AMRg==
X-Gm-Message-State: AOJu0Yw7nMk71CPYXA12iPHPuri7Tb825EEoOiV/baA7a4mBqA83j6pN
 Xky+5ehSKKN9NNVJ51SOKa2J+kaLzkyMUw9TSzwNdkpqDVAb4kv8TU0eMcUqyv8=
X-Google-Smtp-Source: AGHT+IEaL4l36XaObegwTi9BTFwY7XZo1xSkwG6k8214ujzvNllfJcqwV3epC7hXwm6R/p7Ef2RbeA==
X-Received: by 2002:a05:6830:2c07:b0:718:6da0:72b with SMTP id
 46e09a7af769-7186da00966mr3568742a34.7.1730095133977; 
 Sun, 27 Oct 2024 22:58:53 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a0b687sm4919022b3a.104.2024.10.27.22.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2024 22:58:53 -0700 (PDT)
Message-ID: <c1565bd8-a8a5-4cfb-905b-0f852562500d@daynix.com>
Date: Mon, 28 Oct 2024 14:58:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/14] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
 <20241022-reuse-v17-2-bd7c133237e4@daynix.com>
 <50194bd5-cef8-484c-b8c3-bd616414f280@linux.ibm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <50194bd5-cef8-484c-b8c3-bd616414f280@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/10/28 12:08, Shivaprasad G Bhat wrote:
> 
> On 10/22/24 2:06 PM, Akihiko Odaki wrote:
>> Disabled means it is a disabled SR-IOV VF and hidden from the guest.
>> Do not create DT when starting the system and also keep the disabled PCI
>> device not linked to DRC, which generates DT in case of hotplug.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/ppc/spapr_pci.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 5c0024bef9c4..679a22fe4e79 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1291,8 +1291,7 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, 
>> PCIDevice *pdev,
>>       PciWalkFdt *p = opaque;
>>       int err;
>> -    if (p->err) {
>> -        /* Something's already broken, don't keep going */
>> +    if (p->err || !pdev->enabled) {
>>           return;
>>       }
>> @@ -1592,10 +1591,10 @@ static void spapr_pci_plug(HotplugHandler 
>> *plug_handler,
>>       uint32_t slotnr = PCI_SLOT(pdev->devfn);
>>       /*
>> -     * If DR is disabled we don't need to do anything in the case of
>> -     * hotplug or coldplug callbacks.
>> +     * If DR or the PCI device is disabled we don't need to do anything
>> +     * in the case of hotplug or coldplug callbacks.
>>        */
>> -    if (!phb->dr_enabled) {
>> +    if (!phb->dr_enabled || !pdev->enabled) {
>>           return;
>>       }
> 
> Thank you. This is the right place to be called from the hotplug handler
> 
> instead of the spapr_pci_dt_populate() unlike I mentioned before..
> 
> 
>> @@ -1680,6 +1679,11 @@ static void 
>> spapr_pci_unplug_request(HotplugHandler *plug_handler,
>>       }
>>       g_assert(drc);
>> +
>> +    if (!drc->dev) {
>> +        return;
> 
> I agree with the change here, but were you able to get to this path? I 
> don't see
> 
>   this if condition being entered with,
> 
> qemu-system-ppc64 -nographic  -serial none -device spapr-pci-host- 
> bridge,index=4,id=pci.1  -device igb,id=igb0 <<< 'device_del igb0'

No. VFs bypass the hotplug path when unplugging. For context, see 
unparent_vfs() in "[PATCH v17 09/14] pcie_sriov: Reuse SR-IOV VF device 
instances.

Regards,
Akihiko Odaki

> 
> 
> Regards,
> 
> Shivaprasad
> 
>> +    }
>> +
>>       g_assert(drc->dev == plugged_dev);
>>       if (!spapr_drc_unplug_requested(drc)) {
>>


