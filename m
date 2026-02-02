Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C34DE7DF1F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzLY-00078D-0F; Mon, 02 Feb 2026 14:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmzLS-000770-Va
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 14:12:25 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmzLR-0005sA-Df
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 14:12:22 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c648bc954c6so1892495a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770059539; x=1770664339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=swEwytuanK3e9KMtcyuefNUeQNlL++JBFqKUT/OPaOU=;
 b=R7HSq57rqlmvA+NUPRRJYTTPI5R2xmwukeSx7fswC623E5uQ5LFrvUnZIRH6VtPUIo
 Q+K8FDleo+Qy5pPUUe2wzIKE3JxrEzMnq0t/+MT+U3EIiuWvYJKI4Uiy2s7+uRLppd0x
 nzRcb/BvXX7PIiZ60tiaAE9VRl1yXsEv4+e7hsSq9+eubzn/HN5VOHXRq1Jc055lH2GH
 QQ/0i2BHyvlsNHq007FnhfwZYqVquArq6514+rYbQExSeU2IHWxyiXJrOq+6TpHVVEXi
 e74OnUAaJ3eXCQUw2vjB9tXtWeMa6SEOArQcWY6Os7/i+KMj5qOKqHOCwKIMMixXGkYy
 n5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770059539; x=1770664339;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=swEwytuanK3e9KMtcyuefNUeQNlL++JBFqKUT/OPaOU=;
 b=lcbm4xQrC4AbiSMGqBRSwlQasxD13IUDC4zdLDKtd/10Q10obEyYRBNoTcPJe84S5E
 8xyE8MeMqbCDUInx5YZgrRzTTFvIwp5Pia0eF+g5vkWSBZYPONenDL5KaxmbKvSRbI/I
 OSFOJLnDnr137uhESVZtpfNkI+pw8Rv0J5f2KjzNzL3tksVlefvLBGfVh0cUfhfbfxNq
 Yz4P14EWDuEieJok6HatcjG6v9VaPh0GI5rbST9Zs5BbLw0vcnccVo7/lFShhULn0cgd
 RdU7UGPsVt8CwqEFDqsMCmHBYvrPZn2n8a00EeuO18/OB2cFFKSAjwvQ3p8CyL5iKvdS
 /U3Q==
X-Gm-Message-State: AOJu0Yznm2hxG2aaPLcGqyMGwUTIxmaDqwH2u6d9Z9ifXYC5w7LGcMnj
 tchUU61isCOu+XTUrKpNPtDu6qigfFuP6VBvW1AzNkoxT9XJBuA0eRmGp8F3WwC2q04=
X-Gm-Gg: AZuq6aI4zYQ9Cd8JYPCJ9IFGKNi9d3ByE4y3Yr8nL7HPKEWunLD6ysKzN0FkQATDSt5
 W400lcih+66YrjRUPasx0npQpE6RWg4gZFcKJKUsZlyoCb8BP7FW7MRnhzDO8sdPzW2zFaepuT5
 vaQWtaq07DajFLFmI8JKSLM2XR09iMRfV54OXnEhWJCA830H+dv4tHKRAzQ3oDauhv+OGSJxSj7
 NZSyLqeNotgHW/O6h2/ZI03efkHW7Bb65boMG3S01j79ExCm3WFHbpZFwZ7rBDge4zXb01WzGBl
 FaWmq+sp9JD1ibxmqJ5s6YTy3Nz/zEifhitRHBRI0TU7dHJGSN20xCNUl7y2/94x8bWXrdMCIE7
 4i7iwmLeffxn/axbVoQgoGY5F63WCwbgC9SryRX6s8y7jP50LBkCgEbBPgslY+dQohLAomuP+q8
 I1PcjCgMU5R5Mzoh2rj6mC18vJNqWoN6OsTnkJpSDyemV3wm9brvYMsTgv
X-Received: by 2002:a17:903:2ca:b0:295:20b8:e104 with SMTP id
 d9443c01a7336-2a8d9a73ed9mr128871735ad.58.1770059539354; 
 Mon, 02 Feb 2026 11:12:19 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a8b47f4717sm145801895ad.18.2026.02.02.11.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 11:12:18 -0800 (PST)
Message-ID: <b609f633-6821-47bf-8345-c1d36c34ffda@linaro.org>
Date: Mon, 2 Feb 2026 11:12:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
 <095a1def-1548-4764-84d2-87ffb642bb8e@linaro.org>
 <20260202024813-mutt-send-email-mst@kernel.org>
 <20260202180056.GB405548@fedora>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260202180056.GB405548@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 2/2/26 10:00 AM, Stefan Hajnoczi wrote:
> On Mon, Feb 02, 2026 at 02:50:28AM -0500, Michael S. Tsirkin wrote:
>> On Sun, Feb 01, 2026 at 05:24:03PM -0800, Pierrick Bouvier wrote:
>>> On 1/31/26 9:48 AM, Michael S. Tsirkin wrote:
>>>> On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>> Performance impact?
>>>>
>>>> the reason we have these is for performance ...
>>>>
>>>
>>> I would be very happy to run any benchmark that you might judge critical.
>>>
>>> Should we run a disk read/write sequence with a virtio disk, or a download
>>> with a virtio interface? Any other idea?
>>
>> block for sure, people who care about network perf go the vhost or
>> vhost user path.
>>
>> So I CC'd Stefan Hajnoczi. Stefan do you feel this needs a test and what
>> kind of test do you suggest as the most representative of I/O overhead?
> 
> This command-line lets you benchmark virtio-blk without actual I/O
> slowing down the request processing:
> 
>    qemu-system-x86_64 \
>        -M accel=kvm \
>        -cpu host \
>        -m 4G \
>        --blockdev file,node-name=drive0,filename=boot.img,cache.direct=on,aio=native \
>        --blockdev null-co,node-name=drive1,size=$((10 * 1024 * 1024 * 1024)) \
>        --object iothread,id=iothread0 \
>        --device virtio-blk-pci,drive=drive0,iothread=iothread0 \
>        --device virtio-blk-pci,drive=drive1,iothread=iothread0
> 
> Here is a fio command-line for 4 KiB random reads:
> 
>    fio \
>        --ioengine=libaio \
>        --direct=1 \
>        --runtime=30 \
>        --ramp_time=10 \
>        --rw=randread \
>        --bs=4k \
>        --iodepth=128 \
>        --filename=/dev/vdb \
>        --name=randread
> 
> This is just a single vCPU, but it should be enough to see if there is
> any difference in I/O Operations Per Second (IOPS) or efficiency
> (IOPS/CPU utilization).
> 
> Stefan

I'll reply on v3 to keep conversation there.

Thanks,
Pierrick

