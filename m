Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFEEE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFZU-0001nl-5n; Thu, 05 Dec 2024 12:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFZS-0001nU-GM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:23:22 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFZQ-0007ZW-RQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:23:22 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725abf74334so717528b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733419399; x=1734024199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V+ACAUltZY8TyxtqOLZp94Q/iqMg6YovPqYKbtxgY3Y=;
 b=a+llCPHQeoyRS2s6uUGRSWeiKAvrKCn4OJoKohDsEWHpoG+dmkaauA0O2NzVdycFM1
 r78nt+PP8dSG7MtV//G+cwVTCePokEYa+dFU3sh2drLDe3GbaFiLPmEXx1Gy0VWgBtDM
 BJgPeoh667b9drSoaDFKW8pR9N4i8coaQeB2YCdo8FD00gq2PibmfIMP88wECE/A32VY
 hJasgMQe2uqQEtpAkDQIsMy1hTghDjTLNC9TunXQo+Nk32//eF8bzIfAyd3C8sWM+Xsh
 7mv4WqNiWcYSPqQRDJqaewzot+35oxq+firH0lIpqNgGYknnKc8VfI1g4mN7ScFotFEi
 bUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733419399; x=1734024199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+ACAUltZY8TyxtqOLZp94Q/iqMg6YovPqYKbtxgY3Y=;
 b=eKxBnph57ln7Qh2mtqiwtOt1PSmzFQYYAd8elUDTZobr9oAPEdgAEkRYiSC9I4ztIG
 KF3D+U9eGOI1uNq+qqGvu7in3E7yKiOG0iggwr0moTeEn+nwO9c+sK7mrxRWSJ3/Ceuj
 tk4TvUkL6U0opwScCe7zicpuM7L0tK8VJWwChdlEQmZ3P3otwv5R9wgkM5ntl0mG8Ulm
 fhAvaQvd+wSqXn73nLM9MQRxQigWZrKZwDKjXU9CkTFYPEtPoHJpF98bQ4U7P6vK4Y0c
 xoP/RIpvUxujz9tz3iKmKhCVcgxifUlcoo6GQVFjiaHSf7ESubDKspUJ+tjbEY29QW09
 xfmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSs0aJ0CjNLziUPu6LgfYWjYFYUMyDg7I3IFkQ0kqDCYciqUUbn2/DcGpxQ5l7fSUKEyPoUj68zcNJ@nongnu.org
X-Gm-Message-State: AOJu0YxSqhRAemLxGt5dhevd2k0gAM4P+CRoFy9AWmMDon/0e5en2psd
 PjqoeB6/+8+XFPQC1cVasG3IVvvb6+D3ctaxwibK1+v9FW/0nh/dL3DljHh/dr0qNnONBwS3bL2
 jiE4=
X-Gm-Gg: ASbGncu09LX9fuszZpivUxxvi2XNLcg9LV/eii5gQ/CGNFboGleFrY9fNC0B+nHwjGR
 bdh6i9mKoF9IXGVOCc9CpPerHBkRqCciEf94jL4WU8LYx/ubYVdHUBayCl9eSgFjpJbE4gHQdAF
 mQ0prfVH3HHbqZB4zW4izL3xhI0kWXrbbIgYX9wzsitID/wD7+O5K1NSUFUArW3u6WFNDMAv+aX
 f5onmFUYbuoEyKSCDtwCrZC4poeC3vWB0OIJyCqNxFeu3M6LQfAQbTYZN4KoHLQfm/+tZJvhVoq
 0eCSF9kGc+q1o3GvGvLAdA==
X-Google-Smtp-Source: AGHT+IHOK50dvq6/W+wAxl0nC8EDJRaTY1xlEi9lM4KENdFHsIjhDh9Q3OiBTPoH0cfw354hfImD/Q==
X-Received: by 2002:a05:6a00:4613:b0:725:a39e:ae1f with SMTP id
 d2e1a72fcca58-725b813e1d6mr15814b3a.12.1733419399276; 
 Thu, 05 Dec 2024 09:23:19 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a90323sm1482431b3a.114.2024.12.05.09.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 09:23:18 -0800 (PST)
Message-ID: <a28ba5ac-38f7-4aa7-80b9-994df65f0b51@linaro.org>
Date: Thu, 5 Dec 2024 09:23:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
 <76cbce17-0318-436c-b295-0a8ef12b24b9@linaro.org>
 <c30dd97f956725875d9454685692ce3a91155646@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c30dd97f956725875d9454685692ce3a91155646@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 12/5/24 05:00, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 5, 2024 at 12:14 AM, "Pierrick Bouvier" wrote:
>> On 12/2/24 11:26, Julian Ganz wrote:
>>>   +typedef struct {
>>>   + uint64_t interrupts;
>>>   + uint64_t exceptions;
>>>   + uint64_t hostcalls;
>>>   + bool active;
>>>
>> The active field can be removed, as you can query qemu_plugin_num_vcpus() to know (dynamically) how many vcpus were created.
> 
> Yes, if the ids of dynamically initialized VCPUs are contiguous. I
> wasn't sure they really are. And I distinctly remember we originally
> used some query function and ended up with the maximum number of VCPUs
> supported rather then those actually used. But that may have been
> another function, or some unfortunate result of me being too cautious
> and doing
> 

It's a valid concern, and the good news is that they are guaranteed to 
be contiguous.
In system mode, we initialize all vcpus *before* executing anything.
In user mode, they are spawned when new threads appear.

In reality, qemu_plugin_num_vcpus() returns the maximum number of vcpus 
we had at some point (vs the real number of vcpus running).
It was introduced with scoreboards, to ensure the user can know how many 
entries they contain, in a safe way.

Most of the usage we had for this was to allocate structures and collect 
information per vcpu, especially at the end of execution (where some 
vcpus will have exited already in user-mode). So choosing to return the 
max is a valid abstraction.

> | qemu_plugin_vcpu_for_each(id, vcpu_init);
> 
> in qemu_plugin_install.
> 

And indeed, qemu_plugin_vcpu_for_each(id, vcpu_init) will only iterate 
on active cpus.

>>>
>>> + break;
>>>   + }
>>>   +}
>>>   +
>>>   +static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>   +{
>>>   + g_autoptr(GString) report;
>>>   + report = g_string_new("VCPU, interrupts, exceptions, hostcalls\n");
>>>   + int vcpu;
>>>   +
>>>   + for (vcpu = 0; vcpu < max_vcpus; vcpu++) {
>>>
>> vcpu < qemu_plugin_num_vcpus()
> 
> Yes, max_vcpus was introduced as an optimization. If we can rely on all
> VCPUs with id < qemu_plugin_num_vcpus() having been active at some point
> this becomes unnecessary.
> 
>>>   + qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_TRAPS,
>>>   + vcpu_discon);
>>>   +
>>>
>> The change from QEMU_PLUGIN_DISCON_TRAPS to QEMU_PLUGIN_DISCON_ALL should be included in this patch, instead of next one.
> 
> Ah, thanks for pointing that out. I likely fumbled this at some point when rebasing.
> 
> Regards,
> Julian Ganz


