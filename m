Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF88C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trehv-0007ic-Tz; Mon, 10 Mar 2025 11:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trehr-0007fT-VC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:06:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trehp-0006NV-LF
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:06:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso13266555e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741619169; x=1742223969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tVsLM72gyPB5SrUlYGkCkGlspILo45o/4cQJSFs0z9I=;
 b=xDWCkoOJM5aEaemg2NwoLXkma9eRPVeWa3MQUvX5xlTv29TMSA1CTWvRhVrHPpYtN7
 UxoFX+QQ0+UmzOhEeZZ1hU7pAnlCWWa8KOZZaaalTwI0uhM4LuEnqeVLrWhg+5H8L4+B
 rWR1dAMzWHDYUZiZ3aoeUULOJphx2ZOwMxmXd0yo/IEidp2eeGRDG1aC+gkqExBSJNwl
 7cTqIxQxReOv5U6t0+AXSec6rbePBTHW3qNtbZXkz3qWEgSA9OfCUIRMdavPiZDZ/tbZ
 piI0bzEFTJEQer5OTaERktj13ZCLnRmrpo2uiPEz9wrA+1HBuj9BeNrbm7JeJuMBTByN
 YPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619169; x=1742223969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tVsLM72gyPB5SrUlYGkCkGlspILo45o/4cQJSFs0z9I=;
 b=Dk6BYQfz2SWc4Tf8PfEwrUvwE0SxBhsR79ah1enKqVnUPhHFx0tdRNST69kDB8WMdc
 /X9t2vopEqFvfQxK/1xdoJCAY6ah2XWv2azUT324IKRrP9SpWSjvlWdmk+wX2IPa0DVM
 6U8ov6RrpGiQzVMs3qyPyIYsy9ljPA95Qpg1VXTCBfh/TOTwJDiJ7ngSvmotUnEqLrc9
 jNZ+KzN0CON+2TL/D9n15vlIUpa6abY/dysfsmPbnkJpFb1unSoEgiQe5o5NEOLnhinV
 6AYmzFsRLAbiruJZBmROGOuXpisuwx3ValiQEUiHCw3RZUMd72LarrNK8ChkTUMxFpxH
 Gy4w==
X-Gm-Message-State: AOJu0YyqFccTFtbmQrj0QPPZOQMfm8v0YzJQmNMwW9L0QO7pB7kv613d
 nyeDy8woDhX0jnanxC/FNp4Pg2rpur3Zs6GhRtLYjRh+8Ygpiz7H2A/v2YsB1i4=
X-Gm-Gg: ASbGncsfUbggleaJwfHZOK0Bn1Zu5n1s5oqzc5yZDdeuONq5Un4hsLXRsOFzJ6o0B3+
 Q8t2vkKY+xBBIo7ZagrqoFErZCeekyKaC1691teYCUIsN05zWZNhKs49qXgnOlXzR2mzIMY93O/
 ArRlt7OgpfWYjvKiN8hMv4i8SaqvCJH0Am/PMtV9leCmCVwDiL8BiZEm4TkPwc5DHbA0FR/Hofm
 CXphWRJvYfijNYoQa+G43BIXQT3XFASGBaxetOy5P5dPH9xc6DW9eFYnnPswR/TOhgnuh5/zPL0
 17QKMzp90OvNb3q7SWVc+PzPiblzQ7GGPWiJIDrs15ZEZs5Zloyrj6IY2dqn93HKJU2C9gjQF9N
 TuDTpedzWvzt2
X-Google-Smtp-Source: AGHT+IHCVsB4+hK4M4JETFVszkZnO8yYMCS88WIPOq3Qklxz4Hq02PR53L/pkzbFiJFItkBg4PnPvg==
X-Received: by 2002:a5d:47c1:0:b0:391:2bcc:11f2 with SMTP id
 ffacd0b85a97d-39132d2ac45mr8116094f8f.1.1741619167118; 
 Mon, 10 Mar 2025 08:06:07 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e3099sm15631297f8f.69.2025.03.10.08.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 08:06:05 -0700 (PDT)
Message-ID: <7b7cdad8-a807-4c16-9498-1676f3d28b9b@linaro.org>
Date: Mon, 10 Mar 2025 16:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cpus: Introduce SysemuCPUOps::qmp_dump_skeys()
 callback
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250310133118.3881-1-philmd@linaro.org>
 <20250310133118.3881-3-philmd@linaro.org> <Z87s-Z0IM0613sbG@redhat.com>
 <b6988de5-42ed-4e3f-ab39-921912e9be0c@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b6988de5-42ed-4e3f-ab39-921912e9be0c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/3/25 14:48, Thomas Huth wrote:
> On 10/03/2025 14.45, Daniel P. Berrangé wrote:
>> On Mon, Mar 10, 2025 at 02:31:17PM +0100, Philippe Mathieu-Daudé wrote:
>>> Allow generic CPUs to dump the architecture storage keys.
>>>
>>> Being specific to s390x, it is only implemented there.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/hw/core/sysemu-cpu-ops.h | 6 ++++++
>>>   target/s390x/cpu-system.c        | 2 ++
>>>   2 files changed, 8 insertions(+)
>>>
>>> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/ 
>>> sysemu-cpu-ops.h
>>> index 877892373f9..d3534cba65c 100644
>>> --- a/include/hw/core/sysemu-cpu-ops.h
>>> +++ b/include/hw/core/sysemu-cpu-ops.h
>>> @@ -47,6 +47,12 @@ typedef struct SysemuCPUOps {
>>>        *       a memory access with the specified memory transaction 
>>> attributes.
>>>        */
>>>       int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
>>> +
>>> +    /**
>>> +     * @qmp_dump_skeys: Callback to dump guest's storage keys to 
>>> @filename.
>>> +     */
>>> +    void (*qmp_dump_skeys)(const char *filename, Error **errp);
>>
>> Is it right to hook this onto the CPU object ? In the next patch
>> the code arbitrarily picks the 1st CPU and adds a "FIXME" annotation,
>> but the actual impl of dump code doesn't seem to be tied to any CPU
>> object at all, it is getting what looks like a global singleton
>> object holding the keys.
>>
>> IOW, should this hook be against the machine type instead, if it
>> is dumping global state, not tied to a specific CPU ?

Great analysis!

> Hmm, you've got a point - the storage keys are part of the memory, not 
> of the CPU, so they might rather belong to the machine instead, indeed.
> 
>   Thomas
> 


