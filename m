Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A27D75E21
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 10:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEQvi-0002nr-UH; Fri, 22 Nov 2024 05:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEQvh-0002nO-RN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:30:25 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEQvg-0007es-23
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:30:25 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53da22c5863so2313132e87.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 02:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732271420; x=1732876220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JJuSOnbv0I0x5ZCJYxfGG/RH+rlor1HAm3NxBXX6nmE=;
 b=T5n5st5cbt4Euxh4lh0nPqsST05LXRR7G78VoxbS7U3rAsyb+uehqSgGZhF0qq+Hnc
 pSHhbhRc4yk3OO7fcgEUkg5E/hB6O4gssPS3xGyAex4yvjwoc1uEfAQFs7uN9DUN5Om/
 LhQqmikS5K1y0YhaYaxbt06TICf6HE38vGFb5JniRBm9ILXd9oGcUB5UuDqI8L4x5eCx
 suhrb37LrBaBvryBczPdsj/P8xWg8WLu+UcbOulseJBYXy/iV/wIe/ZxJwJE2BxXP/Kn
 9+0h2a0oIPpnHAUDy/IDybXUC8a/GFSnUeIXnEE5CDdxWqoO0G+JOoHVPXI035u732a3
 AATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732271420; x=1732876220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JJuSOnbv0I0x5ZCJYxfGG/RH+rlor1HAm3NxBXX6nmE=;
 b=BxhJlWh0mlZAR05NmomgzGR+5HTh+R4/HIx3UeXDeBN7UsJGMv5TVHIF8rajMOkaFY
 7MqcBDqJ2VJL4rHth/px6k6rB6Y8u6/tYfkgulabb9OXEz95SKPAVK+G1Qlc3/ijBThH
 sAvXN0YsmrIhYw0W50+IHOg7EteKL3R1ghtCzM/nOAmyA/yUK3NY8X79eRguJtSbyCJo
 d5kQq4t/a1EXtE6nRCfMx8XHMGIrFDaW3jjjMy3Z7sfAWjd/ATB18rSs5hAIb8jOKQWB
 esShip/gKJEjObhCDjyxfSGJA52uYHX/31X9viEoZDScgKcUouSeRjlrccRIhiNHz1ff
 F9iw==
X-Gm-Message-State: AOJu0YwAea6YQre1vd/qNuw0yRQByLmJm7JtJMcqaFx4+LOib04o+dBu
 y1wHAWlbkuM01v1GBXtqm0dVywhq06GceWBaQNrbvMoAqgcj9d0aUc0JgBK4kAE=
X-Gm-Gg: ASbGnctKGx+rVDNeTFagVI+aHJ4R7DWpSq4FwUKqOfMD2McirDHXL6g5ORoU5Z/yYmu
 FsaRWfpFXgGCiH9XsgCJ/+cXMbHaABiTHxsQC6TkVEOfymkCS6Jx7fNrzX263rko4EuK8XjK+tG
 g56d/7H2n3tefg7hBoU2PmR4QXY0WnjdkolAhbcqd2Z42gayHDtD5F01WvMnE8ezGf02TFYh2wQ
 bbpuBEvlTwoaONuYj55CGuwJEB1xIv2149Y6SsdYdWHJfrDJFDQT9iUPXSG9QJSd6krFg==
X-Google-Smtp-Source: AGHT+IESntLJN3oIrlq7eQOldwTnk/Hn4ZTOTBIDsaLGEhjBu0QnGP8HC5Sa9USOFjHgVOyYtVSf2w==
X-Received: by 2002:a05:6512:23a2:b0:539:e58a:9704 with SMTP id
 2adb3069b0e04-53dd3993988mr980728e87.33.1732271420305; 
 Fri, 22 Nov 2024 02:30:20 -0800 (PST)
Received: from [192.168.69.146] ([176.187.211.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde16f11sm22618055e9.23.2024.11.22.02.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 02:30:19 -0800 (PST)
Message-ID: <fff34325-203e-4138-a795-27a45b20e6ab@linaro.org>
Date: Fri, 22 Nov 2024 11:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: add bindings for interrupt sources
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com, zhao1.liu@intel.com,
 qemu-rust@nongnu.org
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-3-pbonzini@redhat.com>
 <70f44731-6879-4adf-a71b-a781af48fe99@linaro.org>
 <CABgObfbOj8FCvjXOM_AF8=jyFMi1bs-gfsRu+_GH3802hLhM1A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfbOj8FCvjXOM_AF8=jyFMi1bs-gfsRu+_GH3802hLhM1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 22/11/24 09:32, Paolo Bonzini wrote:
>>> +/// Interrupt sources are used by devices to pass changes to a boolean value to
>>> +/// other devices (typically interrupt or GPIO controllers).  QEMU interrupt
>>> +/// sources are always active-high.
>>
>> So 'always active-high' = true below? (Wondering about pulsation, if the
>> true -> false transition is always correct).
> 
> Yeah, I mean that raise uses true (or 1 :)) and lower uses false.
> an example?

I was thinking of an active-low line where you want to pulse 1 -> 0.
Just chiming in, not to worry about.

> 
>> Is this deliberate to restrict the Rust binding to boolean? (Maybe you
>> envision a VectoredInterruptSource implementation for that).
> 
> No, I simply wasn't aware of that.  I'll adjust; do you have
> an example?

I am having hard time to find one, in particular because I
removed one in c264c074d8 ("hw/intc: Remove TYPE_ETRAX_FS_PIC device"):

-static void pic_update(struct etrax_pic *fs)
-{
-    uint32_t vector = 0;
-    int i;
-
-    fs->regs[R_R_MASKED_VECT] = fs->regs[R_R_VECT] & fs->regs[R_RW_MASK];
-
-    /* The ETRAX interrupt controller signals interrupts to the core
-       through an interrupt request wire and an irq vector bus. If
-       multiple interrupts are simultaneously active it chooses vector
-       0x30 and lets the sw choose the priorities.  */
-    if (fs->regs[R_R_MASKED_VECT]) {
-        uint32_t mv = fs->regs[R_R_MASKED_VECT];
-        for (i = 0; i < 31; i++) {
-            if (mv & 1) {
-                vector = 0x31 + i;
-                /* Check for multiple interrupts.  */
-                if (mv > 1)
-                    vector = 0x30;
-                break;
-            }
-            mv >>= 1;
-        }
-    }
-
-    qemu_set_irq(fs->parent_irq, vector);
-}

See Peter's comment in 
https://lore.kernel.org/qemu-devel/CAFEAcA9cObnb11cSS_StbSHdP0aB6sDeqSHfjb3-qRBfy7K9Kw@mail.gmail.com/

>>> +/// Interrupt sources can only be triggered under the Big QEMU Lock; they are
>>> +/// neither `Send` nor `Sync`.
> 
> Oops, this is incorrect.  BqlCell *is* Send/Sync, but checks the
> BQL state at run-time.
> 
> Paolo
> 


