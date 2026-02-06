Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC5EE208C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voK84-0001ZR-S5; Fri, 06 Feb 2026 06:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voK84-0001Yu-0g
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voK82-0002TT-NK
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770377761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aqjAjc0/jOTJuXjL0kA0N7F//dz/GQ8It2uDtEhVSvU=;
 b=NshsT0gLK3HD0NBwWRAModSI6H+vTvZghhNQ6gGqIstSdpRIyxm6EV5+otho7LnxcJ7NR8
 0QK6NaBz7wuzXAO+fj6VljxcPi3J749nle4bS0UCOr/K41AaXRZHamVqHICEQGpGih+Dgm
 U1xdgTMFbS279F7fmlzSDCMHw3NYmgQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-u8mB0qQPMuWqTJ5ivrZ03g-1; Fri, 06 Feb 2026 06:36:00 -0500
X-MC-Unique: u8mB0qQPMuWqTJ5ivrZ03g-1
X-Mimecast-MFC-AGG-ID: u8mB0qQPMuWqTJ5ivrZ03g_1770377759
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso1764316f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 03:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770377759; x=1770982559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=aqjAjc0/jOTJuXjL0kA0N7F//dz/GQ8It2uDtEhVSvU=;
 b=ovTEQZOQ2IfXAQjq6sY0JqFx9cl+zbnGi5jrC/NHBZ3SRtLg6mc1PtLKQelxoN+4py
 tNefTaRjZzfuCPeIQzi1AR6nxsU6/7Sv/FBY0/+eBhhLmznTATWiN7KDNP5Xx4nBcMik
 sJCpwnn3+I1qVUBvPRf9/BDnnJLUwKOvvS/v1c3amzvzET/8+gdfs7hppFaYfynFQmmd
 aQnlnUXMI1wmjeMiZGsrglD/vyWmuJKIsUdbOoofq82Z4NLYv/8SpPi5wctTbWmXrKeb
 2NxOvSjEFWpT12g8p8zI2PqcD+jusf9TgZ07c2AybwlaTLr0M9RvgrUQDbF4wG+0codm
 ol5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770377759; x=1770982559;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqjAjc0/jOTJuXjL0kA0N7F//dz/GQ8It2uDtEhVSvU=;
 b=TmSPhcVi2WTuUrgL0igr6AGSbe5h8BUVKW341H303kdhmkW2aC+4KWeYdT1FsAW86+
 Y5l4BBl/Rl8LT5+QNYPyYSaDuF+u5/ZxoK2uc0TUFJIHYdVS+tCEaDcepZlbz8H94lcr
 Ol3SNn2pb8B7LVErbieKK6hd4HbW9ExHP0Z7/M+OwVwU3fO1JhKPtdpqKeaRDLXd8Qgh
 U9iRU0K09bdxI4CrqhWMyh2A3a484LrF83s8MImz4F6OOrBkxqfaXA663FCTLimTqor4
 JrJIv9brahKV88TIzVJAbrIYfMQci7sSBJ9lU/CEkF5UNhTDfZdEgM9020wkICDLVECJ
 CyYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCK/GrtewkyJztCTVGU7N/kBEzHDtxCFxK6+Mk4D+DFpnQa9z3sImZwhw9rXSWhpm1Ra4qHjmVICXv@nongnu.org
X-Gm-Message-State: AOJu0YxyDCIytU1BOH6zAWj4NqnSG3ERUNKAfOFN+uatJM0tGAe2s21n
 ORzxyhbqI/EXqKjVp8EZSe6Gh/zQwfnmZWIucpHDsMhWL39RDceShWI1cjyfjwWw8MQ/mVUYMsH
 Ih/k73+2R35DzD4kbdbE7YnNLxJoYC66vPVVqy2rA0dcjpmxnXJDM7Y6N
X-Gm-Gg: AZuq6aKIzu2N8w6YwTQsZsyAEu8mp3yWfeDUQvdJzHqqzmYr3fGX0isQGtWUUw3C/mp
 HHC1/20hQPNO3tw18S7zUmLmIPHYcY2NWbuL46N6vQGOP+ctln/PAsmU9GLmsK8wmLO/8+upky7
 Cc+IKpJEJIbPndv7UhcLjtbkg1ICa9BlOPbDbvzhPJ/ef5aGvl9DkKUR1wyuGP3y7qDBA9NLT2h
 VHebyze4oW2j0Av3mJtclfag0saJ/jz5J+kECgcI/1pAadRpAnkUZQj92ZMlINBgTHFz3uUX8Lb
 m6Da+jGdjyqhCr0Qz/MQI/ILVUEi6PqhwuM/AfdNd2sBElJbsQC/ID4CchVUZPbqvGW+2seEEVK
 jP/WD0mk=
X-Received: by 2002:a05:6000:2303:b0:435:9612:2d24 with SMTP id
 ffacd0b85a97d-4362937e1d7mr3686606f8f.53.1770377759007; 
 Fri, 06 Feb 2026 03:35:59 -0800 (PST)
X-Received: by 2002:a05:6000:2303:b0:435:9612:2d24 with SMTP id
 ffacd0b85a97d-4362937e1d7mr3686576f8f.53.1770377758572; 
 Fri, 06 Feb 2026 03:35:58 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362974b230sm5543749f8f.36.2026.02.06.03.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 03:35:58 -0800 (PST)
Message-ID: <61774393-0aaf-46bf-8bc7-cf79d5a98cfb@redhat.com>
Date: Fri, 6 Feb 2026 12:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700:
 Add AST2700 A2 EVB functional tests
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-10-jamin_lin@aspeedtech.com>
 <83d409cf-868c-4a2d-b1c9-5741d3e36adc@kaod.org>
 <a6757611-32d0-4451-be0e-724648e1654f@redhat.com>
 <CAFEAcA83c+ZHANxxKQBhCNvX1ObTp9hk+Wb0Yzb8ezx7HqDxpg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA83c+ZHANxxKQBhCNvX1ObTp9hk+Wb0Yzb8ezx7HqDxpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 06/02/2026 12.33, Peter Maydell wrote:
> On Fri, 6 Feb 2026 at 10:40, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 06/02/2026 11.11, Cédric Le Goater wrote:
>>> + Thomas
>>>
>>> On 2/6/26 06:33, Jamin Lin wrote:
>>>> Add functional coverage for the AST2700 A2 EVB machine by introducing
>>>> test cases that boot and validate an OpenBMC SDK v11.00 image on
>>>> "ast2700a2-evb".
>>>
>>> I wonder if we need to test both machines. The test is already quite long.
>>>
>>> On my test system :
>>>
>>>     qemu:func-aarch64-aspeed_ast2700             OK              119.68s   3
>>> subtests passed
>>>
>>> With both machines :
>>>
>>>     qemu:func-aarch64-aspeed_ast2700             OK              219.79s   6
>>> subtests passed
>>
>> If the machines are very similar, it's maybe better to mark one of the tests
>> with a decorator (skipSlowTest maybe), so we don't have to execute it by
>> default, but we still have the test around if we need it.
> 
> 
> It might also be nice to have them be a separate top level test,
> so that the tests can be run in parallel. AIUI having 1 test
> with 6 subtests forces all 6 to run in sequence, whereas with
> 2 tests and 3 subtests each you can at least use 2 host CPUs.
> Or does the qtest subtest handling include parallelism?

No, there is no parallel execution for subtests, in neither the qtest nor 
the functional testing framework. So yes, if you want to execute this in 
parallel, put it into separate files.

  Thomas


