Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B82CC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbS2-0006JC-P8; Mon, 10 Feb 2025 16:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbS1-0006Ik-Cd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:36:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbRz-0003UI-MA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:36:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso10720475e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739223378; x=1739828178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0bXKvWEB4q1JVIMNuCqFHn0+WyAgIOVoVYhdJ72e3k=;
 b=V5UIYsIoUG6ib6+0PRDF0/3frwDjtqIg6uLS8T4+lPuc84HtcPJxxEWHQn7vVFtOWn
 /SON1412JFyuwVzW5oQXkRYJ3c/y2OZ0oX3ieT/TkDkAVX080kMEhDVeQSG53IFqyKHo
 zb38YEzJtQSe+QjMOdwslYU2tpwauc39gkAOFAys+T6qCZD0ZMXnjyhxc38B6X74iq1J
 vXr9YyHmjOkKbAcCrxUIgreqc4dh4SO7kUjqI9dJtLEIJ701gajKt5FgTL9PquMspTfx
 x87du8POia0QgJtjEZIZYO+HBK5fyMeJjPoSDHLm/KMGVScTHEJjF3U2++XazTmBjyZs
 qQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739223378; x=1739828178;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0bXKvWEB4q1JVIMNuCqFHn0+WyAgIOVoVYhdJ72e3k=;
 b=czTy7AfS1OXyIhyujBJ7KaBEx+ugHlNkZ/V6TQqeGQ5ZfSOeRWNSxjkaBHbzTf632G
 352HeiX2ENHMIRIa9Q5adp/ODmB5RoFDxBxdvkrmZWBPZNtjoT73VIQir13GmAZtbPYi
 LhnSZ2AHo8WZR9uy63X4ROrpM4Gejk/dAxSGVEETqGYUhjvN3KOgzWysLWP2eEWfHgn+
 VZWepyxf4vq2GOKXVL7pWBKFchjqp+gvM0wD/cvMBeZGQGEPqKWjlw4KV2o0JzgvM7ED
 Xjkhv9K4/2QAOpE3fMHKc41b29Q3xjhZYnJ5pP8UZyB+7SDcA65vL9xdOCmqKJZzoKKG
 S5VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUecNqQl+671/70rUYJ2J3BSoyfJ+j4PNWXX8/qDiTiow+ZcQasJehiKpzxFFfoEFe5Oh0/91mnJ82u@nongnu.org
X-Gm-Message-State: AOJu0YzcXC3UfDGJOQyXZ6qSO1OlXXPuag8hVsqUpSvb9LCSjDA6/x4i
 dGeVSm13qTdbe+6NiLl1chh4aPq/iLFuNXfWDZY+DzM6uT6AYRq7dO2yVgRQwuU=
X-Gm-Gg: ASbGncvyHBDiLyn6HGiCUIP00T0dQxfZ31WPXCYn55TNUaC4WNcRJcNnQ00Jk/4h3dq
 6jcC0vEZui+WODAarVxcj8zXa8dxBVvOXYQoFLvP7bj8YKsCYy+DsE+TB0o1Q/MhX8bI+95+EjG
 3LUsn+1d6Tzxoih54CPWBxIzmDHofGdFYepv4ycA1VWkR1O4PFFGXNzjrrbkszXWOCfItjyrsSF
 FjgZDqzv0baBEulzOABqLZkKpD4QZ0eil1reYsH8/pZaYH9RSdIDxwqwuFqe6x0Zx0+TTH8C8lA
 KJveRLZBfRiVNqRoAQJcy8VAw+cTo2Fh7KCOZ3f8PRevdpLIIg78d3IhBTo=
X-Google-Smtp-Source: AGHT+IF9gVdjNCZ6G1QHTJIpZEt3paYAUsj3vtC0cUV6eLb7AlTfV75uOPdN6cN/ZUvgF/K9e6wBhg==
X-Received: by 2002:a05:600c:1c9b:b0:439:4bcb:9631 with SMTP id
 5b1f17b1804b1-4394bcb97b4mr19358265e9.19.1739223378118; 
 Mon, 10 Feb 2025 13:36:18 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc98844f6sm10663419f8f.42.2025.02.10.13.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 13:36:17 -0800 (PST)
Message-ID: <256e36c4-d0d7-4d2b-96a1-888e516f917a@linaro.org>
Date: Mon, 10 Feb 2025 22:36:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] cpus: Remove CPUClass::has_work() handler
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250125170125.32855-1-philmd@linaro.org>
 <20250125170125.32855-25-philmd@linaro.org>
 <cbd78ef0-c06e-4a6a-8c17-1072fc58c777@linaro.org>
 <8da57d8a-a42a-446e-ad5b-a6ab07c65647@linaro.org>
Content-Language: en-US
In-Reply-To: <8da57d8a-a42a-446e-ad5b-a6ab07c65647@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 27/1/25 08:50, Philippe Mathieu-Daudé wrote:
> On 26/1/25 13:31, Richard Henderson wrote:
>> On 1/25/25 09:01, Philippe Mathieu-Daudé wrote:
>>> diff --git a/cpu-target.c b/cpu-target.c
>>> index 98e9e7cc4a1..778f622b07a 100644
>>> --- a/cpu-target.c
>>> +++ b/cpu-target.c
>>> @@ -230,6 +230,14 @@ void cpu_class_init_props(DeviceClass *dc)
>>>       device_class_set_props(dc, cpu_common_props);
>>>   }
>>> +void cpu_exec_class_post_init(CPUClass *cc, void *data)
>>> +{
>>> +#ifndef CONFIG_USER_ONLY
>>> +    /* Check mandatory SysemuCPUOps handlers */
>>> +    g_assert(cc->sysemu_ops->has_work);
>>> +#endif
>>> +}
>>> +
>>
>> Does this really need to be split from...
>>
> 
>  > diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>  >
>>> @@ -319,6 +313,11 @@ static void cpu_common_class_init(ObjectClass 
>>> *klass, void *data)
>>>       dc->user_creatable = false;
>>>   }
>>> +static void cpu_common_post_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    cpu_exec_class_post_init(CPU_CLASS(klass), data);
>>> +}
>>
>> ... here?
> 
> cpu-target.c is in specific_ss[], cpu-common.c in common_ss[]
> where CONFIG_USER_ONLY is not available thus defined.
> 
> We could define cpu_common_post_class_init() in cpu-target.c,
> which is odd because not common; or name it differently 
> (cpu_exec_post_class_init?) and have it registered as common
> post_init handler but again it seems a dirty API mismatch, so
> I went this way, hoping that eventually cpu-common.c ends
> better abstracted and cpu-target.c disappearing...

I'll amend to the description:

---
Note, since cpu-common.c is in meson's common_ss[] source set, we
must define cpu_exec_class_post_init() in cpu-target.c (which is
in the specific_ss[] source set) to have CONFIG_USER_ONLY defined.
---

