Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA25DC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Trl-0000WI-69; Mon, 28 Apr 2025 15:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9TrZ-0000Uc-2o
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:09:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9TrW-0005NK-Cu
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:09:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2279915e06eso59082075ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745867392; x=1746472192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3wwIzprcE9LITl3I4oKP7bXFb9XPjHpBWqlEZoAwQsk=;
 b=goCfhb3RJ3Xc6/ydIiRq+/NbfVIrcnFKtKELIcASDcowafadaUlG/N5oUoYHJGUY3v
 xs6yXVFs9mGzzsAlq8ydKDPFaTggXKNTq+EhUJK2MMft+3uvGCI2E/n4dk1X5TR3HKVv
 1AE/0wGY1A5bK7R0rhwsuXfICFBoX8PUhXhFi7LnUkK+CVANYJqYanNPvefQT0fzdIOS
 gtmCcu+89H77tMjDpvXcZcAxtrEHRs1wAf4Bb7IqfQZ1NbOcdoulwYMbwlYCKoJIEZur
 gqKBFS/cKvjWwjTuTiDBQ2v3OEYHDB3czUbR4PvJS+Uw0gCaC++Ldk6akW3Ky6fA9xj+
 loRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745867392; x=1746472192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3wwIzprcE9LITl3I4oKP7bXFb9XPjHpBWqlEZoAwQsk=;
 b=fRlT7icDUk3mFpdPCf7xf5LxMO+GL0ArqNkRTDJ+HBv+Ffjj3UeudntSIyqM+ldjg2
 vJrlreUgPuouyCroQEF4YogI7JK+4jb/vnTVCL+kumZCFnZRQmle/dlj2mOLomjx0fEx
 fTyxzgA41SQkhUU0MNs8nhAlhcqWb+6fqm7C4NuET5/c8cRZ1lEfYni0wDkK0sTMAR6J
 X25J2MJPepgMmwuhF0AhpBSCuk/Ql+BvKiBui8vmgDJb6Dmz5Df+bRpSsopTXlpEBsGH
 5FpF6Vm87EW8PJmYE9tDnWv1vAkkd60tjWFYvZdK8exhZi0qe5rHeLMHQCjWajggpL0R
 OngA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMtyz9ITGlHhaR+mobDrjqLbiTV8Oo6ufWR4uOm+Elxyv9+uryJFR5iINcOMaH6FNrkZcNsXtO4we/@nongnu.org
X-Gm-Message-State: AOJu0YxJZ06JcV0nGeWtoFExH2m3IbnbWTvpnX62V1tjl6jUEqV/mMGf
 W1VgPf6gGJc8jS/625T7dK3zP2NQI9KO75YTEjNr9rjo1NaLTe8/TDCZlfApaVLvT1ZjT8SBGBo
 u
X-Gm-Gg: ASbGncuirnTtI50JJay4lrMehuWd9DROBpIO6ckTsk0btWQ1ALow7x+uVYGMuhJAFFs
 oTD6Ka/ea3cqi0QnlYiWqu6Bi0GKcv9mUVHrgFXedGHO5/ZVDxpciR2fPltV5sfR6PfDgn43izd
 iM9TPZ9sk6IHp2IxZpkgIKxRrDbWgEpnnWiEDlo6qeBRbW4+7hLpmNdSk/YxQ/V/W3V2I0uR2YN
 HW0G6ScoHZT2ar8sQoQd3akCw4kAayUAebYA/LCslcKsjBaepRNOL6+OknljSyjlCyZvzNX6u5m
 LAr0wvxNwpF9xK5SAv7igSZpUPaClV4eH89fcZ3KjvvDkyaZNN1+P7uTzf+ryBBB
X-Google-Smtp-Source: AGHT+IEoIAiFFpydclwvHry9ZG1Vy26fhLiWhBXz3sWU+UQYty3IlILFketwo6cjvHm3ZW2SmzCpVQ==
X-Received: by 2002:a17:903:22c9:b0:21f:768:cced with SMTP id
 d9443c01a7336-22dc69f3eaamr123529845ad.8.1745867392397; 
 Mon, 28 Apr 2025 12:09:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5102721sm87177475ad.186.2025.04.28.12.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:09:51 -0700 (PDT)
Message-ID: <b711cddb-0a68-4dba-a492-4c51683eb116@linaro.org>
Date: Mon, 28 Apr 2025 12:09:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
 <1332b395-1e3e-2be7-83f2-15f2d89b0449@eik.bme.hu>
 <51f3a96b-9c7a-4242-a822-145d68e068d9@linaro.org>
 <f84a52af-aecf-5235-7971-689580ffb71f@eik.bme.hu>
 <29f67d66-9eef-493a-9d96-99240ca25a14@linaro.org>
 <75b7e110-9293-32b2-64c8-26eabaace8b7@eik.bme.hu>
 <033d94c7-ac74-4a44-87ae-aeac964afd10@linaro.org>
 <c4479348-00b2-4604-adad-e8d8911c75a6@linaro.org>
 <21e6cbae-54fe-2d11-307f-2fe36a08c97b@eik.bme.hu>
 <6d7f8b57-b8d4-49cd-b0fd-72e5428bc94a@linaro.org>
 <29bf183a-957b-6c03-be66-bee38f106fc5@eik.bme.hu>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <29bf183a-957b-6c03-be66-bee38f106fc5@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/28/25 11:44 AM, BALATON Zoltan wrote:
> On Mon, 28 Apr 2025, Pierrick Bouvier wrote:
>> On 4/28/25 3:31 AM, BALATON Zoltan wrote:
>>> Since you are touching the lines using DEFINE_MACHINE it's a good
>>> opportunity to change the macro to be more general to be able to keep
>>> using it instead of replacing it with the boiler plate it's supposed to
>>> hide. Adding one or two more parameters to the macro is not a big change
>>> so I don't see why you don't want to do it. This could be addressed later
>>> to revert to use the macro again but in practice it will not be addressed
>>> because everybody will be busy doing other things and doing that now would
>>> prevent some churn. I too, don't like doing unrelated clean up which is
>>> not the main goal, but if it's not much more work then it's not
>>> unreasonable to do it. I only oppose to that if it's a lot of work so I
>>> would not ask such change but what I asked is not unrelated and quite
>>> simple change.
>>>
>>> That said, I can't stop you so if you still don't want to do it now then
>>> you can move on. I don't care that much as long as you stay within hw/arm,
>>> but will raise my concern again when you submit a similar patch that
>>> touches parts I care more about. If others don't think it's a problem and
>>> not bothered by the boiler plate code then it's not so important but
>>> otherwise I think I have a valid point. I remember when I started to get
>>> to know QEMU it was quite difficult to wade through all the QOM boiler
>>> plate just to see what is related to the actual functionality. These
>>> macros help to make code more readable and accessible for new people.
>>
>> Having been through that recently, I agree with you that it can be hard to
>> follow at first. Luckily, we have perfect compiler based completion for all
>> editors those days (I sincerely hope everyone spent 2 hours configuring this
>> on their own favorite one), and it's easy to see where things are defined and
>> used, even when code is cryptic.
> 
> It's not about typing but reading it. The verbose struct definitions are
> hard to follow and makes board code look more complex than it should be.
> 
>> That said, pushing to someone adding a new field the responsibility of
>> cleaning up the whole thing is not a fair request. You can't expect your
>> friends to clean your shared house because they brought a cake for dinner.
> 
> I tend to get such requests to clean up unrelated things whenever I try to
> change anything in PPC Mac emulation which I also complain about and think
> is not reasonable to ask. But I did not ask for unrelated cleanup here and
> changing the patch so you don't do this:
> 
> -DEFINE_MACHINE("none", machine_none_machine_init)
> +static const TypeInfo null_machine_types[] = {
> +    {
> +        .name           = MACHINE_TYPE_NAME("none"),
> +        .parent         = TYPE_MACHINE,
> +        .class_init     = null_machine_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(null_machine_types)
> 
> but instead add the .interfaces field to a variant of DEFINE_MACHINE once
> and keep the one line definition is not something unreasonable to ask. I
> think you can ask your friends to not make a mess in the shared house
> while having a party or at least clean up after that. Adding one more
> parameter to the macro is also simple to do so I don't get why you're so
> opposed to this.
>

Maybe there is a misunderstanding on my side, but it seems that what you 
asked is exactly patch 7, which introduce DEFINE_MACHINE_WITH_INTERFACES.

That said, patch 4 ("hw/core/null-machine: Define machine as generic QOM 
type") could use it to define the null machine. Philippe, could you 
change patch 4 to use DEFINE_MACHINE_WITH_INTERFACES instead?

Thanks,
Pierrick

> Regards,
> BALATON Zoltan


