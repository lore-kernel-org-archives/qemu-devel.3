Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96445E87850
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 17:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnKF6-0002nX-11; Tue, 03 Feb 2026 12:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnKF4-0002mm-BD
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:31:10 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnKF2-00071D-7b
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:31:10 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c626bd75628so2200880a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770139866; x=1770744666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=akfZduGhNA7x7VhmlcMDP4rPypp308SEgS0Ti7+/2sU=;
 b=dzKHHFf0pl0/TIjwxbpryC+sPDAvzoAXJEvhmwAVA5uMXlPRXasTnmOPGCmufOIBhT
 VdnwJtEj/WjvtSI3V/4H/qULlU/UlzORRYTNiBkcRzYQk45+L5pC31/oAE440GL9yddR
 1UhaELDT+fSg60DqcHQMeu2LzeNBJ9JiLIRIHhYopaVDT4C9lnbw/tkfBLYyUFW0fE9V
 1cm19EjOQAngXzKmUu1+0GCRXRSX5UfYpLjmQlFcZRsLgQHBh7gYK1CgBCxej6pYDqDV
 Z76QtZ3mda/hWQYmnlOZ1V9HgUmocj9cVTjkU016Yu2fJ+JKwPJnBH92DpjO+cV77lJI
 /O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770139866; x=1770744666;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=akfZduGhNA7x7VhmlcMDP4rPypp308SEgS0Ti7+/2sU=;
 b=gBTJ6waEqsJ/HZSaBlLeulsPltr/Gj6GZIHrrldtdiQEtEafNkxiI9fw+D9seW2qMw
 dDWcisSs0NpeVY4ZF9ZInxcvutmCAKr9P3W50CG1y1QNm+bTEQGvDNklacSfO1EvkDtB
 1acJ/F7AJbTNCilqwwPlBdbjc1xsGKJ0i1jXQFtpVoIKa0jZ0hob/BlAg3DLm8fsxuOS
 xMnJsibunR4a1Z80E5/40OtbuYoaQeWwIuvMGBgACj5Wzz+dOQT6HgMoj0nDQITbNW/K
 1NnCnP+oMNkZg+TQtMI+y/2QAaN9P+ZDkpdafQ1g7QywvtzhCDUBX2H3+7I9YklDNbt/
 MAHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/voe3nNJjfgLxbtus7Ti6bJOC8YtpnOVriAxnYmzNhEJLF2p1ZUv0ovkE2bLbmCptsfz01KV0gi1R@nongnu.org
X-Gm-Message-State: AOJu0Yw9Co20Vo7aceWaHHhWV+jw2EuIXbtFrbyoc3Pkt7f2D2KV7Le8
 2XjbJMfrFv/dKo12gIKoIJbgooSVfQO2D4mXI62OYZ2VI4US3zOuSSx9CfVvS/1bZmg=
X-Gm-Gg: AZuq6aLG2RqMK8jTQ/MQMaL1rgTeVpL3ovahBfNqhRqJy0qc48OFDi7HNO2NhqlnOc9
 4I1qRZRzvutbwUXbR7fI1Q5uqF/JBWyQuWvf38YVj3OsYA0Q2vdmSkpktGd8Hoezy37h+qzoVVy
 mNpYcOMFbt2ptw+9tZ+OgrN45FGFYTfkU6KZ+O9jGyO17z/o0u3GK8FUdnNF4kG4r5DAqErCoNT
 A5UCUu2yNHQg98IYoh+o90xjL1jnl94eZL+Uo8PhjcSvroMGTx94O9nTT4sXkrs3ZqBdA//uxdn
 /PyYlLP1NN1szHFZDQZOCci9R7NMFsrbKLk9gJghlYD1qd36o3b1UtTs8J1xsulohD/StuVUSbC
 WI0Y6kGtFJxsuobYVysy8dC2klUY8oyXcrwc2I6d3d4pWUPoPeS9eZzekAdFz0l7BKLvShrXX9K
 n6pZRpZ8Mok0FCNjBPxjUElqX6BmSH9j7olmO6JbINtsWLd8AiptWVSfW0
X-Received: by 2002:a05:6a20:160f:b0:38e:676a:f3e with SMTP id
 adf61e73a8af0-3937210b935mr155677637.29.1770139866067; 
 Tue, 03 Feb 2026 09:31:06 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6428371715sm17778677a12.13.2026.02.03.09.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 09:31:05 -0800 (PST)
Message-ID: <2426d548-2c6f-4bef-9c30-efb97dcc69dd@linaro.org>
Date: Tue, 3 Feb 2026 09:31:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] hw/virtio: Use
 VirtIODevice::access_is_big_endian field
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20260201232924.93399-1-philmd@linaro.org>
 <20260201232924.93399-5-philmd@linaro.org>
 <20260202024316-mutt-send-email-mst@kernel.org>
 <87bji7pa2e.fsf@draig.linaro.org>
 <20260202105847-mutt-send-email-mst@kernel.org>
 <20260202185233.GC405548@fedora>
 <1c0fc67a-1ded-4200-b9d0-e20a06cb5b4b@linaro.org>
 <1804511f-a048-4eb8-9cf3-1c75bdf4b277@linaro.org>
 <20260203055247-mutt-send-email-mst@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260203055247-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/3/26 3:07 AM, Michael S. Tsirkin wrote:
> On Mon, Feb 02, 2026 at 07:22:16PM -0800, Pierrick Bouvier wrote:
>> On 2/2/26 11:25 AM, Pierrick Bouvier wrote:
>>> On 2/2/26 10:52 AM, Stefan Hajnoczi wrote:
>>>>
>>>> This command-line lets you benchmark virtio-blk without actual I/O
>>>> slowing down the request processing:
>>>>
>>>>      qemu-system-x86_64 \
>>>>          -M accel=kvm \
>>>>          -cpu host \
>>>>          -m 4G \
>>>>          --blockdev file,node-name=drive0,filename=boot.img,cache.direct=on,aio=native \
>>>>          --blockdev null-co,node-name=drive1,size=$((10 * 1024 * 1024 * 1024)) \
>>>>          --object iothread,id=iothread0 \
>>>>          --device virtio-blk-pci,drive=drive0,iothread=iothread0 \
>>>>          --device virtio-blk-pci,drive=drive1,iothread=iothread0
>>>>
>>>> Here is a fio command-line for 4 KiB random reads:
>>>>
>>>>      fio \
>>>>          --ioengine=libaio \
>>>>          --direct=1 \
>>>>          --runtime=30 \
>>>>          --ramp_time=10 \
>>>>          --rw=randread \
>>>>          --bs=4k \
>>>>          --iodepth=128 \
>>>>          --filename=/dev/vdb \
>>>>          --name=randread
>>>>
>>>> This is just a single vCPU, but it should be enough to see if there is
>>>> any difference in I/O Operations Per Second (IOPS) or efficiency
>>>> (IOPS/CPU utilization).
>>>>
>>> Thanks very much for the info Stefan. I didn't even know null-co
>>> blockdev, so it definitely would have taken some time to find all this.
>>>
>>> For what it's worth, I automated the benchmark here (need podman for
>>> build), so it can be reused for future changes:
>>> https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
>>>
>>> ./build.sh && ./run.sh path/to/qemu-system-x86_64
>>>
>>> My initial testing showed a 50% slow down, which was more than
>>> surprising. After profiling, the extra time is spent here:
>>> https://github.com/qemu/qemu/blob/587f4a1805c83a4e1d59dd43cb14e0a834843d1d/target-info.c#L30
>>>
>>> When we merged target-info, there have been several versions over a long
>>> time, and I was 100% sure we were updating the target_info structure,
>>> instead of reparsing the target_name every time. Unfortunately, that's
>>> not the case. I'll fix that.
>>>
>>> With that fix, there is no difference in performance (<1%).
>>>
>>> I'll respin a v4 with the target info fix, initial v1 changes and
>>> benchmark results.
>>>
>>> Thanks for pointing the performance issue, there was one for sure.
>>>
>>> Regards,
>>> Pierrick
>>
>> After proper benchmarking, I get those results (in kIOPS) over 20 runs, all
>> including target_arch fix I mentioned.
>>
>> reference: mean=239.2 var=12.16
>> v1: mean=232.2 var=37.06
>> v4-wip (optimized virtio_access_is_big_endian): mean=235.05 var=18.64
>>
>> So basically, we have a 1.7% performance hit on a torture benchmark.
>> Is that acceptable for you, or should we dig more?
>>
>> Regards,
>> Pierrick
> 
> Could we use some kind of linker trick?
> Split just the ring manipulation code from
> virtio.c and keep it target specific.
>

While it would allow to extract the common part, unfortunately, as long 
as we keep a target specific part, we still have a problem to solve.
Indeed, some symbols (may be ring manipulation code, or just functions 
mentioned below) will still be duplicated, and in the end, when we'll 
link two targets needing different versions, we'll have a conflict.
Since our goal for a single-binary is to have at least arm and another 
base architecture, we are in this situation now.

So the only solutions left are:
- accept the 1.7% regression, and we can provide more "real world" 
benchmarks to show that it gets absorbed in all existing layers
- compute virtio_access_is_big_endian once and reuse this everywhere: 
that's what Philippe implemented in his patches.

What would you prefer?

> 
> Or it could be that even just these two would be enough:
> 
> static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
>                                                 MemoryRegionCache *cache,
>                                                 hwaddr pa)
> {
>      if (virtio_access_is_big_endian(vdev)) {
>          return lduw_be_phys_cached(cache, pa);
>      }
>      return lduw_le_phys_cached(cache, pa);
> }
> 
> static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
>                                            MemoryRegionCache *cache,
>                                            hwaddr pa, uint16_t value)
> {
>      if (virtio_access_is_big_endian(vdev)) {
>          stw_be_phys_cached(cache, pa, value);
>      } else {
>          stw_le_phys_cached(cache, pa, value);
>      }
> }
> 
> 
> 
> 
> 
> 

Regards,
Pierrick

