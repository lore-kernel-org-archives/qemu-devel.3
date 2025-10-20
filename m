Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF46CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArR8-0007u7-Af; Mon, 20 Oct 2025 11:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vArR3-0007iv-Nd
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:04:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vArR1-0006iG-46
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:04:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4710ff3ae81so15898255e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760972668; x=1761577468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GRqGKjjgAyNU6lKRLhi230wkV5Q1mP8l1fqpq1PRTK8=;
 b=tqmkC1cKeuS510tjhjsNjkunBNTjIEsY69YGDeWke4QiVeTneSBzfsR7Uc/eBGTbYA
 lsNwxZIqBnmFdgUXhVIs3ZV7oBbaK+2oG1K4abH5Ys6lKzALaq3Cw7HbnS1/KDhDswSP
 YgNzeKFu1U7YVMOMGewoSu2c0gzIcws35OBpsww+AKybHL1sTaANAAQOTG4QR28EPoCv
 odx6RQbXO7mDfdBD7n3VABjEotnucCM0tbEtWx1BGSseoZdf9AJ4X2yxthvxzGMm82rm
 H3WmfJ7yXMQT8cYC/kUeZAV5N5172QX/KpvLS7yhkkbd7b+Zzmn6SHwjjnixjm/fmLTz
 HJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760972668; x=1761577468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GRqGKjjgAyNU6lKRLhi230wkV5Q1mP8l1fqpq1PRTK8=;
 b=w92itCezEebRsEOuc8oGthlc12f+0mCSBujTMWB+l02x7sNyOvSeXBXmal8uS+kftq
 ryvkHllxm+Z/ya0TjD+fzjtCeBJa0a22+KY4gnBWEpf/O9kg2TzQYoJbEwHsDhwT8TiP
 0g/iwN5mU0VXFl0Czr1cmADqOAB4AlFxZ5JEzOad45BvP1isbuBpGDGPQzDOnnEb/cDh
 1c46jNNHg8z9lJYAS3+KKu1k9fC3nmg7x9R/e6CGhaYXHQROeUdPzIfYq+u1wzneMv3d
 073WWNwmjsIncqboxM7JRW1818PV8YKye/Xm0X5WJoNQ9e0CyET7hNs4pzsL2a5fvjxh
 nqiw==
X-Gm-Message-State: AOJu0YzRmOiEXPgd4pVMaZW6E5bNOxIRSm/MkdGONkpjvjHceG3dM7JQ
 ky3OxHU3348Sd3CKEdBajQes9gL6oFXdxRASGaYI3veSAwuY1bV45UdK9jkhH1b17FE=
X-Gm-Gg: ASbGncs1tvfBKLn9WePoC+RtczAcq9N1/ynE2vTq8U0GZKPXz0ZlBxNgoPd7cwrCfxh
 XNoWg7OniEplgl2M546ZqQ3cwYRR3LXSWjbmdx04eC5EIYH8RoA1aNERnl/JihP5RLVT0b7XlbP
 Gx8fQJtOSQbyTcdkeLzDfElOTSrXnowAJ9retVLf7UkUxxM90tWGoFfYok2IdMyjhp3GpF0tP2H
 582EHudH81e45pU/eumHiKVtZVjWTKbvLojjipg3XdcmcIMyp7MnEp9un0ioMXlyQwrJQa8W71/
 d0jGRzFKX3OvOl9FjwBPlguBPWgIAANCzDBW2BFgTt2XEs0ejKHHnojHGAxcktTvdPnGlbPRpuN
 j8dwHzuSZg9fLNMjfmlxmkuvJEKrn+/2UZBkFLLAuuODJt4S42olTNukfKHQ5EWwF+rVj0B/7DR
 4LSfXake0czk+IndAjwsqFRN/ihKl/hNpNgTd/Xu0BXQv1AxM6JXu9Hg==
X-Google-Smtp-Source: AGHT+IGDmgKSqud6lURTQMvIB/SvVGJoEGvjZApS+hZfaGNIo5roLghJvbu2BSwUa0eoqrCPE8D+YA==
X-Received: by 2002:a05:6000:18a5:b0:428:bb7:1740 with SMTP id
 ffacd0b85a97d-4280bb71efemr5518613f8f.57.1760972668472; 
 Mon, 20 Oct 2025 08:04:28 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce56csm15608722f8f.50.2025.10.20.08.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 08:04:27 -0700 (PDT)
Message-ID: <2eb6a945-cc98-42a8-81d5-830f3fc75fb6@linaro.org>
Date: Mon, 20 Oct 2025 17:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] hw/ppc/pegasos2: Change device tree generation
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <f52d9cc6af5249e306ba7a9472ef781b8e1260aa.1760798392.git.balaton@eik.bme.hu>
 <7673cd4a-3617-48eb-979e-e2b4767c315e@linaro.org>
 <32159874-8735-8443-7842-9b667b1d33d9@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <32159874-8735-8443-7842-9b667b1d33d9@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 20/10/25 15:06, BALATON Zoltan wrote:
> On Mon, 20 Oct 2025, Philippe Mathieu-Daudé wrote:
>> On 18/10/25 17:11, BALATON Zoltan wrote:
>>> We generate a flattened device tree programmatically for VOF. Change
>>> this to load the static parts from a device tree blob and only
>>> generate the parts that depend on run time conditions such as CPU
>>> type, memory size and PCI devices. Moving the static parts in a dts
>>> makes the board code simpler and more generic.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ppc/pegasos2.c        | 292 +++++++--------------------------------
>>>   pc-bios/dtb/meson.build  |   1 +
>>>   pc-bios/dtb/pegasos2.dtb | Bin 0 -> 1701 bytes
>>>   pc-bios/dtb/pegasos2.dts | 167 ++++++++++++++++++++++
>>>   4 files changed, 220 insertions(+), 240 deletions(-)
>>>   create mode 100644 pc-bios/dtb/pegasos2.dtb
>>>   create mode 100644 pc-bios/dtb/pegasos2.dts
>>
>>
>>>   #define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
>>>   OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, 
>>> PEGASOS2_MACHINE)
>>> @@ -411,7 +403,11 @@ static void pegasos2_machine_reset(MachineState 
>>> *machine, ResetType type)
>>>           error_report("Memory for initrd is in use");
>>>           exit(1);
>>>       }
>>> +
>>>       fdt = build_fdt(machine, &sz);
>>> +    if (!fdt) {
>>> +        exit(1);
>>
>> To avoid confusing users, either report an error or abort.
> 
> Errors are reported by build_fdt so no need to report again here.

I'll defer to Markus for error style.

> 
>>> +    }
>>>       /* FIXME: VOF assumes entry is same as load address */
>>>       d[0] = cpu_to_be64(pm->kernel_entry);
>>>       d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm- 
>>> >kernel_addr));
>>
>>
>>> +static void *load_dtb(const char *filename, int *fdt_size)
>>> +{
>>> +    void *fdt;
>>> +    char *name = qemu_find_file(QEMU_FILE_TYPE_DTB, filename);
>>
>> g_autofree? Otherwise,
> 
> This function is simple enough to not need autofree but maybe it would 
> be better to ensure it's not forgotten. I may change that if need to 
> respin for some other reason.
> 
> Regards,
> BALATON Zoltan
> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>> +
>>> +    if (!name) {
>>> +        error_report("Could not find dtb file '%s'", filename);
>>> +        return NULL;
>>> +    }
>>> +    fdt = load_device_tree(name, fdt_size);
>>> +    if (!fdt) {
>>> +        error_report("Could not load dtb file '%s'", name);
>>> +    }
>>> +    g_free(name);
>>> +    return fdt;
>>> +}
>>
>>


