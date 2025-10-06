Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31683CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 15:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5mv2-0001rf-7c; Mon, 06 Oct 2025 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5muu-0001rS-Hw
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 11:14:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5mul-0002oB-Fr
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 11:14:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e52279279so33640155e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759763647; x=1760368447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NkzsFlnEIZ6aWHV8z7vfrlidUNvMz/ENDqtv8YbKV4I=;
 b=DloLvbDeh8r7JvGoPTABru2gkhUgvLu+hgd6aORmZeekhUZacUT9iVMAGOo5tkvU1y
 Q6j/13ybvkr9l4bIXoME8jRMR2NavSSlOdJmkGb+U17THMmYFnoqr8BsGgVVXFr6SSnp
 jFgbamZJ9EZH2JGvjKciYucFuqsa89Dg4Ze1o5sLGqvkb28LkXpNKueDC1S+OZzrR5tu
 SjpaLQ1/4gfMQPIlgbaB+x/ZSkJYdDpM7UyODXz7T2NtYWpVB65bLrK76Dn678fE6tab
 m6QRRxGi4UYJuHwMOsowG9zVvBFsaUSWyns/2yoCgyaA1c5nXlSxm+O5Tma/r/6wbI1o
 AZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759763647; x=1760368447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NkzsFlnEIZ6aWHV8z7vfrlidUNvMz/ENDqtv8YbKV4I=;
 b=hPIM7vYOnESOtV2Lms2hagYiVfO8HdgWYOoAlgUdEJrHrfjhzf11FfUQQA6eac/MtW
 i90NhJ5O3QnrUjG4RcX7u6E2AQJwJUtNYt1Z3V62Cr4VOIgcKIa3JpVzjfeQxR1h/52n
 t1VCgmb2BA74dWngr8OQijqzkRIXIRbEZr6D+zQowhnF7Ct0HIbJzmfse2sGf5FUoDld
 f700PjTZ9CAZF7pADHsJ4vp8HsNj+LXcZh2Em0rSVZKLW5m5emUb9IC9Dau9A4RwWr8H
 HtxFEwB4bbAnIPHGXXhR+oITnycdL+5cjgRrOUC9159mnvFl7WAEpOjUWiHMWbRA+fq8
 JJTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6rSthGI5kFZT92bM50NHyl2XZPcKOyIagk2N28vb7iRdzUB5YwhYCGA8iMEDcwiGWGV9/DoxKsYDy@nongnu.org
X-Gm-Message-State: AOJu0Yw4HpKtRtVimf0vNnSQnVvg/W5dD90z7hsfmNxfbNbgI3Shl0fH
 Zh38yt39jXjBSSGLTHj/lNKibZFmnSx0ADUN0nCLCMHpBT6vwzsRAcr/e/oUuwNk4bo=
X-Gm-Gg: ASbGncvDkBYhNp4JXxu4hcXhQ0x161DRphukZNUiyY8+t/6J/Ic5850MF/qCzbRtFq4
 kcdohEGF7HyhOXFzd3KKyg6d0LnjAo6/KNjBduGU6izRqsc6dFz/3VsD4QkpFeE3NcqYA/yoUon
 VftSYI7pn6jyrvopwxj6d59omMmSvfiOog+i9cAcllWAUwrG9vy076wgF5NvZDkrbAN94CTUO5F
 20DFbsEwOJOAFiAA2KhQneoSqMvnViLhsRXKpKeyfZxT1dQOH0QtmRo9/RjqOSe5IopDvr1NmWP
 bknXfc5nI0MYNi+h+1eK6XiGqnuspOBsRjhZKm6IhLXwPLSk5Qk+gKGKkDQ/7yZFCm5oKMK9AgX
 sOpXv2X8BK350N4xCZY7FhkV0VdXcUoPVkXnpkOWlxKIJ3NZK//w8l0hnIEdHhYur45OKPlk8R+
 b/CRokKgIS5K0Auq5JTybiD+Y/yht5
X-Google-Smtp-Source: AGHT+IHsqTtu/nz4TrQupljwIK/Jnl0R6AC8dkChAQLHq7NV4Z1KP8uuuVsOqMu/UlgPY6Oopw7PFA==
X-Received: by 2002:a05:600c:4510:b0:46e:59bb:63cf with SMTP id
 5b1f17b1804b1-46e71140be1mr103691265e9.24.1759763647287; 
 Mon, 06 Oct 2025 08:14:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723591fcsm161818555e9.10.2025.10.06.08.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 08:14:06 -0700 (PDT)
Message-ID: <d140d66b-60c3-4a21-9c96-7fde767cf900@linaro.org>
Date: Mon, 6 Oct 2025 17:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/39] accel: Move cpus_are_resettable() declaration to
 AccelClass
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-14-philmd@linaro.org>
 <78f4e026-9abd-47eb-9540-656094b19762@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <78f4e026-9abd-47eb-9540-656094b19762@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/7/25 07:36, Xiaoyao Li wrote:
> On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
>> AccelOpsClass is for methods dealing with vCPUs.
>> When only dealing with AccelState, AccelClass is sufficient.
>>
>> Move cpus_are_resettable() declaration to accel/accel-system.c.
> 
> I don't think this is necessary unless a solid justfication provided.
> 
> One straightfroward question against it, is why don't move 
> gdb_supports_guest_debug() to accel/accel-system.c as well in the patch 12.

gdb_supports_guest_debug() is used in both user / system emulation.

> 
>> In order to have AccelClass methods instrospect their state,
>> we need to pass AccelState by argument.
> 
> Is this the essential preparation for split-accel work?

Yes, but also the aim is to better organize and clarify the APIs.

We have a set of generic handlers that work on the AccelState context,
regardless of vCPUs; and another set which works on vCPUs within Accel
and must get the vCPU context by argument.

> 
>> Adapt KVM handler.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/qemu/accel.h       |  1 +
>>   include/system/accel-ops.h |  1 -
>>   accel/accel-system.c       | 10 ++++++++++
>>   accel/kvm/kvm-accel-ops.c  |  6 ------
>>   accel/kvm/kvm-all.c        |  6 ++++++
>>   system/cpus.c              |  8 --------
>>   6 files changed, 17 insertions(+), 15 deletions(-)


