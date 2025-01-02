Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3809CE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSX2-0001zE-E3; Thu, 02 Jan 2025 16:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSX0-0001xT-Qg
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:15:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSWy-0000wY-Ur
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:15:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so29203295e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852498; x=1736457298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4HCXDK11QZHfZFelZZBENtIjbXX9yBencw7I+4qkJ+M=;
 b=U1FFVKPYgciYL0UG54sXeiGyZ7mTuL5qO8Bt4yGVW+1gdccMSOkqgs+cb54KK9iVbV
 nV4jPv76Nw0eBT+Fo+qaLAYA7pjAlBcPh0obkWhwX+I4S+/UZBF8iF1mnVg9smeO7Nu5
 gtjOjzYLF+3/FJgtB89WBEHlKOBR3ANfpokgWdB+OJBOnrSfmn5W0mUePzv0VFsc7Ded
 V6uBsO5qt8q6xtaGokQ8sCdjtKdfRNtsbLxInCOaJTbci049nfK9iiJboBRrK8DZ5VMQ
 7mW3KFbPR6RuR3j7wgvgiyHkbKF0h4dhA4GSqbvulD0LFFLl1HG6KteXLLE0/1FLumlo
 a/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852498; x=1736457298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4HCXDK11QZHfZFelZZBENtIjbXX9yBencw7I+4qkJ+M=;
 b=FbSqrZkeRfKZrP+t3jS3Togb/Z4oXM4EO+fml0sPdoazh2fZut3BuhoFEHeIsz8TyA
 QiTgm+UP+LjQXLBhblJisDlRJ79drqbJCgHbPQ1oRSkiUq2W+yeoN6Vlgyt8fZXGM7kL
 WCLAAHxnon/djfkkVC6C320VdUF2gToHQjE0fQTPNiHln6iQuh7FtYeh5mT/1mOcP8FB
 nIAb73TNesDht7xz+/xKKfraWl78eD+Q7qJiqQQxEwHDZF1TrsTNZF1HZs552QUSnQH6
 /dUBQn5H8DDM6RjgJaUBZbc7he0cXvlB3c9WkP6P1aY25MTOe83uEJoGEmSLZgUjpxcd
 CK8A==
X-Gm-Message-State: AOJu0Ywyoc/fVcJyogcoMWx+klWRHXMXlMFZb4Ku6d0SqCpt1YIEhL/Z
 q3bPiiaQ5zk22BaGcyceq0R+wwNXZbZGlx88Vu5UwlIVHoNxtZ+H+sWajCCZDl4=
X-Gm-Gg: ASbGncsgigvL/PW2etmYATKdi0Nhor0vjySISpTkrozWuBb8ukdFg0TMI22Kz6uc+9f
 ko1S24QvvsKZctv/MGqNxdYr2oqNLbLC2xTtL3apRRTG8MOXqVBlaIXVp9RQbWPwqeZ3R+S7Qxz
 4y7NzD7hsu2YdcwrTNdAjFBDzvPiESxNrP3G9q0nl3zCy4yIVyefnJQmbxVJh7GGdd1U8XY136o
 qAU4s0YlklcRnNtFexE1yYq5rU1ikEkn4yaJUGKFc7N838ShAkx8QiuAd0sMvY6iTviI8fsa/aq
 Dghi58Igpaq3YCNzDEIxGMhz
X-Google-Smtp-Source: AGHT+IFzD8emtXMSYgWkFo49HtU6GaccU7HCR7mWBCXp0TRnULYHqBwbo/rRFFMOaHp54Q9Y02ZpVQ==
X-Received: by 2002:a05:600c:154c:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-43668b49a47mr374460515e9.22.1735852498512; 
 Thu, 02 Jan 2025 13:14:58 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2f9sm40025559f8f.81.2025.01.02.13.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 13:14:57 -0800 (PST)
Message-ID: <1d1b4c5d-7226-41a9-a9e4-e05336d781d7@linaro.org>
Date: Thu, 2 Jan 2025 22:14:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] QOM: container_get() removal
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>
References: <20250102151244.59357-1-philmd@linaro.org> <Z3bNAUORnY7QHxYY@x1n>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z3bNAUORnY7QHxYY@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 2/1/25 18:29, Peter Xu wrote:
> On Thu, Jan 02, 2025 at 04:12:34PM +0100, Philippe Mathieu-Daudé wrote:
>> Philippe Mathieu-Daudé (4):
>>    qdev: Expose qemu_create_machine()
>>    qdev: Implement qemu_create_machine() for user emulation
>>    qdev: Call qemu_create_machine() on user emulation
>>    qdev: Inline machine_containers[] in qemu_create_machine_containers()
> 
> For these four, all look fine to me, feel free to take:
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 
> Said that, still one comment: maybe we don't need to make the function
> qemu_create_machine() to be an user+system API?  Instead we could have
> user_ss defines qemu_create_fake_machine() and invoke it iff USER_ONLY, the
> same as what patch 3 does.  Then we can drop patch 1, because exporting
> system's qemu_create_machine() isn't required, IIUC.

Good idea (not easy because -- again -- CONFIG_USER_ONLY isn't defined).

> We could add some comment above USER_ONLY's qemu_create_[fake_]machine() on
> why the fake machine is created (qdev_realize() of cpu devices relies on
> machine object, etc.).  It might still be helpful hint so that we know it
> can be dropped if qdev_realize() doesn't need to rely on machine one day.
> 
> Thanks,
> 


