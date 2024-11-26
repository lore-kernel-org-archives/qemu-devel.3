Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD76D65543
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 18:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG0DM-0004QE-O2; Tue, 26 Nov 2024 13:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0DD-0004PI-LG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:23:00 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0DA-00021j-IV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:22:58 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-212583bd467so58635655ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732645373; x=1733250173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OZgxQDhUeybKqmALzUHizC2B8wdnW5VGeAhN+R/wmJM=;
 b=iAmKNeipDkKD62ILOTg62lZCLW1UQX70fpzD4zu+ZS6+uyYm611hOhaj0HsRhmTH7B
 RH73mEiDKsaaIVa1XwwUg91m584ZHVF/r0qYnAU1thRbPyFkECq4KPK25aWYCfWi4oX7
 xXmLCIta5mMX6TBSjo/pZjUVwcX4tYVSaRvhY8JLFsd5UJ1OIJ6qHjHPVjqKVYaLa0ot
 L37oGvfYZnWFjKjxRSN6n0qXIwdstXocQX6GCnEbNx/jDeowVgIWGQI51zJ0dGhkGk2I
 IQvapNlrECPnSw3/6AU0clk5OWXPltHzfbA21GbG0NTetfSfNjuToBDdpYrsxq0CQoo4
 0WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732645373; x=1733250173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OZgxQDhUeybKqmALzUHizC2B8wdnW5VGeAhN+R/wmJM=;
 b=KEG6lTo4abaMjXkplXbqfoHvRt8n7ba+ifhYJj/FU9JbAGRtVAh+d/vtPzEceY2AQH
 vl2vgDJ1zGXoD7NTctTAAOFS2v578m+G9hcveTfpJkqWHD+fD7fvNCt0O5NWfvqujQIm
 t0zOlzzJaVq2gsF78ZXnVQTBqKoZLknbGTN1Wro7GLAhKgzcwuCQja4wjclRCue9FiHC
 bZOdZPbUK9usADLH67BZh986VSNJ/SmUD8lBsbQr9KMcAFPUii1jRSLRBjbsKah3N2nR
 ZdjOSKew3wnyWtop/Lc+EthV+EGfqlr0IRlmPBtR9N7caZWQ0N4qKJnsBKZ01ot7PJMn
 yniA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJrCAn1GWDyN9dyqX8rYUsber9PXpy6k6tTYMJyQBl2+7ErrkUlOz1ZeJl5C0VhHC2ofqH2s7UJWaH@nongnu.org
X-Gm-Message-State: AOJu0YypCLkuHdcnOPYM6VMv7jjYoXGeDQ5CSMlMP1QIFiAkywD27FwB
 QoGiGyMAnKDGaLizbQgRsT40WCZb1sqBLGTeIZUCMjlyrIfzZ3yu9shGG8BtE9M=
X-Gm-Gg: ASbGnctc2g8AtfQCoImACtVyZwRjW+5+OIhtmEgi3eX5HR0QdOp1Pf/3Z1A/8VetlOm
 OrVmktspxGcru/ow6zBQwycbHuR5Z4RxOx+rIObXiC/oPNL+Etg9iW8X2n3KOEfVfgw1xF5WwYt
 /fYJqbL1xXc5LnaNwSopnTDf+jvAen0Ld+VyTQwUh/yAJMYct//J0S78M2ybIJfHYcyQbUGjHdT
 vLQZPO5nSJJCzZraRYNjJHXc8Dnihng6kcVfAWzueZkkStgtfk8RpLD7uH2TmFirPLgVj/2EJrD
 7v0x7isiiYA+WCvhYO18pw==
X-Google-Smtp-Source: AGHT+IGjTeQc1JQoS6VYb2NcEctgfQEiWBSspQy1P1fWnbuvtAn9u6AMAEDfvrVRIVyYGhvke+/plw==
X-Received: by 2002:a17:903:5ce:b0:212:583a:8542 with SMTP id
 d9443c01a7336-21501b590c8mr1511465ad.44.1732645373175; 
 Tue, 26 Nov 2024 10:22:53 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc21a50sm87303845ad.230.2024.11.26.10.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 10:22:52 -0800 (PST)
Message-ID: <7ae84446-9f8a-42f6-a125-c0a50eeddb10@linaro.org>
Date: Tue, 26 Nov 2024 10:22:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, Dmitry Frolov <frolov@swemel.ru>,
 lvivier@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20241113094342.282676-2-frolov@swemel.ru>
 <87bjyij0q2.fsf@suse.de> <8da5c689-3116-42c1-b215-fbb50f35f49c@linaro.org>
 <87v7w9n9px.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87v7w9n9px.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 11/26/24 10:14, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 11/13/24 13:13, Fabiano Rosas wrote:
>>> Dmitry Frolov <frolov@swemel.ru> writes:
>>>
>>>> Some tests need more time when qemu is built with
>>>> "--enable-asan --enable-ubsan"
>>>>
>>>> As was discussed here:
>>>> https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.ru/
>>>>
>>>> TIMEOUT_MULTIPLIER enviroment variable will be
>>>> a useful option, allowing non-invasive timeouts
>>>> increasing for a specific build.
>>>>
>>>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>>>
>>> Tested-by: Fabiano Rosas <farosas@suse.de>
>>>
>>> and queued for qtest.
>>>
>>
>> Hi Fabiano,
>>
>> will a PR be sent for 9.2 release, or later?
> 
> I queued this for 10.0, it doesn't actually fix anything (only allows
> testing to proceed when the variable is set in the cmdline), so it's too
> late for 9.2.

Ok thank you!
Just wanted to make sure it does not get lost.

Regards,
Pierrick

