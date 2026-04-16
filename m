Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DC6F8A144
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDI6Q-00026a-Lf; Thu, 16 Apr 2026 04:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDI6M-000261-Qi
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:29:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDI6K-0004Lq-Oa
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:29:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so7812533f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776328167; x=1776932967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i5TJizu3Mcgj00sssF1bKVqn2aMTeGrGx/WNoebfjVo=;
 b=sPS5zvCcVRnSQpc30CXarEOVYjm4rFN7WcNl6F5SwzWPFwZ3W2KdNrTKjP098mdSLv
 wv4SiWWoie7Al3S3mev96kCRwQq4DDH+g5LOkV0/vZe/1yTgKaxOv6XVTbblFG/Vy7Dq
 mcOMQrmON2OPiEfYGK92c66KqB2yytqB8tWHM+Z05wGBZrSdiuUZzfhhhMmt+r2U3g4n
 Tl1YNcs4Q7EHnkO581cV7DEzovQ2VQSvT4DqxlJZcdZsvM2VJdY5mndxUxjIPCYav/Sw
 LKjAlTNqiGxyRqiqtdmPda1Lv8UrihWIZAEk7MuA/ERVeu/jgM2LjG9YQuEDan2kouqB
 +Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776328167; x=1776932967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i5TJizu3Mcgj00sssF1bKVqn2aMTeGrGx/WNoebfjVo=;
 b=EIpBpGc14V7gOYpGsk3dfdMzTZis3Ytz2F79n1K8Uwon63IEsLkitJTrq4Ul4gkhWp
 IzkNjbl6W/vVqEKCJ4arlkR4Kt0hT9TSlLb2VkU3vcnTUwmNYBvtJodFO6ABP4mpWywB
 R1hIwz14Y4F3Ow8UVVI5OxXd1I3Pdt2OVKvbHhIgt6vxHf0V9FzaBCABHpACPwTf6zIg
 w2iqYGayJCR4qn89Q9fQgS4TWUxk/IhxA1gcrF9qM+lUCh/e9JvOyPX8hyCXTxv535Jl
 9MvaDTRGjCCI1ZqNG0cL44O9ogAmssseocycfaMdYgN5RHo8pKbAVHG2DZ0XNAhL/E8E
 jyXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+u01DxkldjmgHpsXy5uola/2DDxI/Ah624etiwaSQnt0misX2qPZ6I43tvlsoVH1fN2YRyBuUAeSC2@nongnu.org
X-Gm-Message-State: AOJu0Yw/579pDhEtSdJb3fPV1M8BcKzE5tLU4T6H3Fe8X3zITL3Ou0D4
 AZoWTl4HRkHwEJM7KObHKHXcnBPzlhTBLWedAfRlj4ntZAdOQMW60wUES/e+d/yPYi8=
X-Gm-Gg: AeBDietGI02yEkUCKRh8z82MJgpzwE4uVP4eLpDSFYAaib7W8MDMwvKqwab1tX4QvqK
 TbPxByZmnFM17WhlEfs1Mib24+n64rLk8C9H9qUonkOTyaIC+HeIAyCd4jNFEHgSTH5sGzgSkGS
 dj0kSu0WeDwOQim7znZIrBHNggQ+IdcLf92gumgIVKmX/3hD4Bh3VBetk/9zgQHnnaNKli1bHEF
 lxmmBB55YQfruG5LTHg7u3GLqaDEPnAjyHhYa0GMc5XoEInD+jpgHwq9aT+gDArDTjjTgt8tgwt
 +KKY3lfMkqEJtb0fJjePMsIAJkaYkE2GrbNPU1kfQeFhgnipgB+u28H11/sVzCH7JxdXgmJhgmW
 2ND822XczQ84rfVJo8rAdL0Pey7RJ5H8m431JgmRGxS6G4OnkddYNPL5dSFsO0aZx0bqsnvO4bi
 2q6qpiEUXXgjekTSeWWCpFDJ1ufEm/I5Gkg7A=
X-Received: by 2002:a05:6000:1ac5:b0:439:b60a:b400 with SMTP id
 ffacd0b85a97d-43d642c8697mr37626069f8f.31.1776328166713; 
 Thu, 16 Apr 2026 01:29:26 -0700 (PDT)
Received: from [192.168.69.228] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f06sm12162550f8f.17.2026.04.16.01.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 01:29:26 -0700 (PDT)
Message-ID: <183ce56e-cbd9-41a5-8d68-9281aa6ddd54@linaro.org>
Date: Thu, 16 Apr 2026 10:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Add support for pre-setting the
 authentication key
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
 <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
 <d68f975d-0450-4928-b758-bea1e657eae7@linaro.org>
 <60d47301-08f4-44e9-9cd6-2a12bb9e56de@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <60d47301-08f4-44e9-9cd6-2a12bb9e56de@siemens.com>
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

On 16/4/26 09:50, Jan Kiszka wrote:
> On 15.04.26 22:28, Philippe Mathieu-Daudé wrote:
>> Hi Jan,
>>
>> On 15/4/26 07:46, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> In contrast to real eMMCs, we are not (yet) persisting the full state
>>> of the device. This particularly includes the authentication key used
>>> for RPMB access, complicating testing of firmware images which do not
>>> support initial provisioning of the key.
>>>
>>> One way to address this would be, e.g., extending the eMMC disk image
>>> with a special sector to store further state. A simpler approach is used
>>> here: Add another device property that allows to specify the
>>> authentication key, bringing up the eMMC as if the key has already been
>>> provisioned before.
>>>
>>> This is how to tell qemu to use the OP-TEE test key:
>>>
>>> -device emmc,[...],auth-
>>> key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>>>
>>> Or use this for machine-configured eMMCs:
>>>
>>> -global emmc.auth-
>>> key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    hw/sd/sd.c | 23 +++++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>>
>> Do you mind mentioning it in docs/system/devices/emmc.rst?
> 
> Right, there was something... v2 our patch on top, what do you prefer?

If there is no need for v2, my preference is an inlined diff that I
can apply directly saving both of us time :)

> 
> Jan
> 
>>
>> Otherwise,
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


