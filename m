Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A2C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8P9-0004eM-U7; Mon, 03 Jun 2024 10:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE8P8-0004dn-58
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:11:18 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE8P6-0000ir-Fd
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:11:17 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6269885572so784644366b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717423874; x=1718028674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dRaDiAL64sssMvTWiBBzGvj163oLeurAnHe5X3Opa24=;
 b=EhKU00jEOuveSIKZrSc/rIhIUdlj4b9hfEvMyrFobcaHYJ+qtDaA/HoTqJvjGZg47V
 7OXiAwEMwKQjoFdj/BKvvnoasteFPhYYjlUkorc+F2XjHfZZisVyYGtQ4sQ3UOwZyeUv
 98e9JURnS735xC2/yK22qAg6v2Q0fAC7VAA+ZwdTiM0vRtCyWaYOiC8f57La9u2VwcKJ
 H5svNp//qm1xYC7eBXSAry0PfFdOPT72BIfl6wrYgTi4b9Sjohqd/97GJ/Leab7D/cOD
 MXTQxiwokGdo1pdrWmIvODbsw+r4V+AF38yM0Aob0NRkkplYpFLPqwPC4vaukQ8AXP/U
 G/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717423874; x=1718028674;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dRaDiAL64sssMvTWiBBzGvj163oLeurAnHe5X3Opa24=;
 b=renRUV5Tx7JtsnzvDPlyW2RKGwXtmherSYcGxdOAloy7Zjsf62DlcPLFWLZoB2sdWo
 RVtcvOGAzpymHDgymCh73ShAmzm41OOYqI0Pk2mjXhq69Nrh6Tzu8YSrtoafpyepazEK
 sScWNJA3qId3d2eyjaHX26nq6c4zTe5jU2JTk1EjPlsf5SPcWDiTyosEluzVw57yHuRB
 4gv5Sb3h2ebDY1E3dgQ6hwe8NHnb3QGqXwT5Tn1+xLggLykUXLYnCzgrq+GTkU/0s7NW
 zbYKRkDFtY+GgBGpPaQUNilDNi35o3SX36C+vxTAlk8Gvw02n2oPuCC3mIQUelFr0ynV
 t5eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEx07NcL+b3zt9LmnFAVcUtwIwUV6o6elqehuyIxsVOikR38+QBMba7frDCtSVGYWXBJ7y+4SH62aPe1QnbNOsla1rowY=
X-Gm-Message-State: AOJu0YxLoL9RoksXM3K32Vx85KWDbLr09NCfXMonMTtisUIPUFePT24s
 cwPFELWwV5+vXkePFmHyymurFpMimyTaSMuxLiV61Ion6GBSrDPE4c62AjR5QY8=
X-Google-Smtp-Source: AGHT+IEoRgPQWyBF9W1moLh8VT4BX2L5l2kefHO9O6pdlrBS8/sUQ5nmxIPLbYEDqFdEuHeLaWcadw==
X-Received: by 2002:a17:906:36cf:b0:a68:5fb6:1a7f with SMTP id
 a640c23a62f3a-a685fb61d23mr728743066b.21.1717423874419; 
 Mon, 03 Jun 2024 07:11:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eac7a340sm489040666b.159.2024.06.03.07.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:11:14 -0700 (PDT)
Message-ID: <329a02e4-724a-4579-ade2-99e3ad2688de@linaro.org>
Date: Mon, 3 Jun 2024 16:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cpus: a few tweaks to CPU realization
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <988e580d-6121-4f7f-b7b8-d12cee39be35@linaro.org>
Content-Language: en-US
In-Reply-To: <988e580d-6121-4f7f-b7b8-d12cee39be35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/6/24 14:47, Philippe Mathieu-Daudé wrote:
> On 30/5/24 21:42, Alex Bennée wrote:
>> The recent IPS plugin exposed a race condition between vcpu_init
>> callbacks and the other vcpu state callbacks. I originally thought
>> there was some wider re-factoring to be done to clean this up but it
>> turns out things are broadly where they should be. However some of the
>> stuff allocated in the vCPU threads can clearly be done earlier so
>> I've moved enough from cpu_common_realizefn to cpu_common_initfn to
>> allow plugins to queue work before the threads start solving the race.
>>
>> Please review.
>>
>> Alex Bennée (5):
>>    hw/core: expand on the alignment of CPUState
>>    cpu: move Qemu[Thread|Cond] setup into common code
>>    cpu-target: don't set cpu->thread_id to bogus value
>>    plugins: remove special casing for cpu->realized
> 
> Thanks, patches 1-4 queued so far.

Now patch 5 also queued ;)

