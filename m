Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EB1C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 18:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thBdv-0001cC-Nv; Sun, 09 Feb 2025 13:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thBdt-0001Zk-Ui
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 13:02:53 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thBds-0002WH-DJ
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 13:02:53 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dc660b56cso2580932f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739124170; x=1739728970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMwisbLTZPQf9B0UjycOC84zuSN1/wB/sdDRvv6Iq/k=;
 b=H/LHWhqngbp4SI4fSGCEoROxFo/N8qxVvyyfmJi5VJSsPtbKwGelB4gsL/yc3r+RUK
 yFrqTSmR2IvbcNE2n4vQIH5dDqM32t/neDr+Y1HHxp6ZZB/bTpu2UZ/12EB0cpCRE+cZ
 NEf70+n745MXqMYzks0lRUUG7pxctuJKoIA0r8aE/PZD4UFbBGZCBR9ngFU4pv30B5Vg
 FXPFzjPury5Syg8Q6TgqsmiZR5WfJ37B9EZY88VRPBscpPammA/wF6L5ZPKsseBEU/BH
 RsMpr3udq7qtXzyZT+pSHuQKHo4HKU0ggFW/MWS4GzA8WUFxB7XZQdmNgVwj3j2ifAQx
 IBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739124170; x=1739728970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMwisbLTZPQf9B0UjycOC84zuSN1/wB/sdDRvv6Iq/k=;
 b=hAYESLizkfX5mL0+gSh4CGSnYUW0c40h/2fCeGP9YbFMec6lh+iAQACKwv/sPdEJjx
 u1lXsvh4YsvTrhvdB0tEk5Wq31SZQrWYrhZbondiWHQ8gF5wQkL0LKjV/NmPdHr60urn
 xWuJVr+a3wIvS4mBMZeqZUwHuy3TEJVlJjkKX9Z0x/PpivqHPBkJSQQBbU8AySTC5IK6
 dnesQvgOM8R1qR5/C1qIOxrbBcunLcJnByVepOnD4+PUDwPy5088UdMzWGBUXf8lkA+g
 2vSGFZXF0/W2h7QbwRI0/Vi3SH9vS6UGPPaNh1AtY2ds/P8mVrew+F/j/IXurGIGqeKn
 nHWg==
X-Gm-Message-State: AOJu0Yw58k+ahL9Xyk/0FEEFpd8iqyVTCenqMgYjWu/oG26esrrLB//Z
 YxxDSilvW3JcHnRpJfgJINjWbrIZkDr4WJEzcOha+fcvvrqn+4vHSk8Vj9EL6Ek=
X-Gm-Gg: ASbGncuAqT13EiCJloxSIsKudtIex0ei6UBEcK3aSw+9TGc1+kCm7Qx0ehwupCpRKMr
 jq/JInhnmoFxu+0NMX9wtoBZin15okUw/OdrYW3+vzgHY8DX7g2WBD8IqF36pl/T0tWh7sP6I0X
 OOo1JjqtMYe5ecQ0WGG7xXKpwR80w8badj1rx7CfemwkrGKZFbfnHEwTW1POfmjrh8JJCXidncr
 CcJf4WYqjj1OKwi9jpgManhza3jd2BaCExVzAvQt5XakRxARonVfYbe6PqVRZWkq4iAUx1bfMgy
 5IAl2/4litNulCGXuLiIJZWSZ0CxHApxozksg0oa6b0KED2xvEmp2Eng3Co=
X-Google-Smtp-Source: AGHT+IGQAbR2qXKi7lBuL1ts9BW05beiKW59LHIBwlHBnwy0LTo/WOjbcF3qbr05V0K7c73uEWrw4g==
X-Received: by 2002:a05:6000:144d:b0:38d:df21:a51a with SMTP id
 ffacd0b85a97d-38ddf21a881mr718786f8f.16.1739124170374; 
 Sun, 09 Feb 2025 10:02:50 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2750829sm5198821f8f.7.2025.02.09.10.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 10:02:49 -0800 (PST)
Message-ID: <b75deca5-43e4-4b8e-878a-55e4a2373c80@linaro.org>
Date: Sun, 9 Feb 2025 19:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] accel: Only include qdev-realized vCPUs in global
 &cpus_queue
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250207164540.0f9ac1d7@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250207164540.0f9ac1d7@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 7/2/25 16:45, Igor Mammedov wrote:
> On Tue, 28 Jan 2025 15:21:43 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Hi,
>>
>> The goal of this series is to expose vCPUs in a stable state
>> to the accelerators, in particular the QDev 'REALIZED' step.
> 
> I'll take some of your patches (with Richard's feedback fixed),
> and respin series focusing mostly on realize part.

Great, thank you for helping!

> (and drop wire/unwire parts, reshuffling cpu code instead)
> 
>>
>> To do so we split the QTAILQ_INSERT/REMOVE calls from
>> cpu_list_add() / cpu_list_remove(), by moving them to the
>> DeviceClass::[un]wire() handlers, guaranty to be called just
>> before a vCPU is exposed to the guest, as "realized".
>>
>> First we have to modify how &first_cpu is used in TCG round
>> robin implementation, and ensure we invalidate the TB jmpcache
>> with &qemu_cpu_list locked.
>>
>> I'm really out of my comfort zone here, so posting as RFC. At
>> least all test suite is passing...
>>
>> I expect these changes to allow CPUState::cpu_index clarifications
>> and simplifications, but this will be addressed (and commented) in
>> a separate series.
>>
>> Regards,
>>
>> Phil.


