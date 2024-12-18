Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7F2E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwjG-0003Ln-24; Wed, 18 Dec 2024 11:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwj0-0003K4-8R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:16:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwis-0003FQ-9s
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:16:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso46999425e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538588; x=1735143388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LgKPhFrfn+FSpszjwReu0WlKGkAYalZZQp3pOzgu1Nw=;
 b=jZTUei31ZbA88jucHMQs4YJBgVSqtIcZEdTPrGoQOJVY5Z42sqR6EFqR4h4xXNSOaO
 OWgxnDnRaLHZJaxtubYCIALRUh6CEGUgwTqn90dcmKr7cPp7a3iaZ97nxeYdGz1n94zH
 Z+Y6TvpROLnFrE0+gxLltt//KNoPneQARBvevrk6TXNdo0LK74GCqIt0xv4FMb7VVPM7
 0y6FhSy1Q6yPF5aQCv2Wbq4siZsvjjJZcc1AqH1BYMgXj0xpGQAPqa/TNPX1Ro0XGQGt
 MZeTCoZy2LCtWEgGuXIgGvSrFDB4so3rb9l0Kp4hI1iRWeKT8YpPy9ORX5exqH0b/UW0
 9+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538588; x=1735143388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LgKPhFrfn+FSpszjwReu0WlKGkAYalZZQp3pOzgu1Nw=;
 b=LjJ0qQfkfy8kUC4f97Ww+++bZMrHvgi72SDXGyktunivpJRR+aIf1G+f88dF4mvyD4
 PqQQCZXnWVFb6E7DfVGgYqoRYhlXknc2ELzzTZBmaKAqbzf6FzjfYQbra5vPRcKrm013
 ORqvPcQ2Gt8CZHwd2qqdHFxuR3hv2visMjVpOi8KMqYd5FU+YptdLwMiB8Stgs226Krk
 0DIF7P25CzJ2fMgI6xy0cDoWr0Wgrda8eUhoQbFX9ETUyz30UtVX9blp49jj1JWzVIe4
 gvE6qqvo3iNEXfqOcwkyixPHQW3GvD5WPFSSOhEVwcveQJBouFMzbhymLx5XdCPcbDgT
 L3aQ==
X-Gm-Message-State: AOJu0Yx+qEkB8xKnQpSpZfDD+mwOD0VG3dn9ypOZjqEOZo18siZOlvKN
 gmZCgzZwLkjWBlz/ewd0PKrx66oAmd5wywrQVfMrJZ/ObLzJh1ufRS8iIKXREjs=
X-Gm-Gg: ASbGncuPboZXIow0hNd1LsVZcq6vQ0spo9f2j8tl3S5R2v3ndxg8YSIiOpZjjBzVJlp
 FktwviEiyhGLUhOCxstprZbU9cKIzE4/62ZHDVs1nVa01COpSMs+srpe2HVc44c7WhHbzQRKjAL
 tGXKpaKsiucUFm28RajyHK9hkgpmLw7FD1naJWj5R5SOMuZLuEgcXfucwfg8MvHKTf5q6vxjhoy
 TP0YVaeMxlyyu/wqRfZ/9uOIPOyzcJkthN7cI8QVhFbtD48JfIjH6SYurFEp29fFyzkAG6G
X-Google-Smtp-Source: AGHT+IG3+PUCAO/8ELd7L3fpgTuG/KKzGhdHfkztmZ1kLBBJfKykC4ur7GBo+SwGLH+hKx0U79ssRA==
X-Received: by 2002:a05:600c:474d:b0:434:f131:1e6d with SMTP id
 5b1f17b1804b1-4365535fd93mr40310565e9.10.1734538588312; 
 Wed, 18 Dec 2024 08:16:28 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b01b73sm25160225e9.14.2024.12.18.08.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:16:27 -0800 (PST)
Message-ID: <4a746daa-74be-4abd-9583-47fcbab4dc35@linaro.org>
Date: Wed, 18 Dec 2024 17:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system: Move 'exec/confidential-guest-support.h' to
 system/
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20241218155913.72288-1-philmd@linaro.org>
 <20241218155913.72288-2-philmd@linaro.org> <Z2L4seQo7Z7LPpTh@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z2L4seQo7Z7LPpTh@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 18/12/24 17:30, Zhao Liu wrote:
> On Wed, Dec 18, 2024 at 04:59:12PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Wed, 18 Dec 2024 16:59:12 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH 1/2] system: Move 'exec/confidential-guest-support.h' to
>>   system/
>> X-Mailer: git-send-email 2.45.2
>>
>> "exec/confidential-guest-support.h" is specific to system
>> emulation, so move it under the system/ namespace.
>> Mechanical change doing:
>>
>>    $ sed -i \
>>      -e 's,exec/confidential-guest-support.h,sysemu/confidential-guest-support.h,' \
>>          $(git grep -l exec/confidential-guest-support.h)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/{exec => system}/confidential-guest-support.h | 6 +++---
>>   target/i386/confidential-guest.h                      | 2 +-
>>   target/i386/sev.h                                     | 2 +-
>>   backends/confidential-guest-support.c                 | 2 +-
>>   hw/core/machine.c                                     | 2 +-
>>   hw/ppc/pef.c                                          | 2 +-
>>   hw/ppc/spapr.c                                        | 2 +-
>>   hw/s390x/s390-virtio-ccw.c                            | 2 +-
>>   system/vl.c                                           | 2 +-
>>   target/s390x/kvm/pv.c                                 | 2 +-
>>   10 files changed, 12 insertions(+), 12 deletions(-)
>>   rename include/{exec => system}/confidential-guest-support.h (96%)
>>
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> (MAINTAINERS is missed to change? :-))

Yeah there is no entry for CGS in MAINTAINERS :(


