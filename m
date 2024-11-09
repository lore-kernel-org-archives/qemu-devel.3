Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801D5D5E365
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 10:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9iun-0004RO-Ab; Sat, 09 Nov 2024 05:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t9iuk-0004R1-VT
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 05:41:59 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t9iui-0002fb-Q2
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 05:41:58 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so32528145ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731148915; x=1731753715;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yKOAbEW6cY1alGmhwAhp1sWmPftiS+bR5h7hUFupp8Y=;
 b=N7vl84hJHYK1j8wy0yxEQE3fkGHA1bmG/Ez58Bvec2bROaEaxnxXYuQ6DwUGfplIXK
 Jvt98JF5Ya/IL5fXhIuKjwilxePEpVmks+TopqKWhocP17VFANwCDqfuZFcUwZjw7/Nr
 H9ysqIjr1lI6lzmmv6EKULoMrMjvZr+gepXwjMVRjBXC1wY8V7s/xsOktsaZj7S4JA/H
 tfzHORuhydLV3RkkKwlnk6BVNlMrolKJmllZqlgAUp9B+e9Yr5jYkICYoep5CWs2cMaI
 dWcsxDvm6Wc0QGlOi5wEh6xKqW3ao+q3vd4qQvUHe4b2WhTWkmT/OTgvr4Ct3657K8+h
 Cqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731148915; x=1731753715;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKOAbEW6cY1alGmhwAhp1sWmPftiS+bR5h7hUFupp8Y=;
 b=wzVUmwupQiq6HzbjTvSRJCcr0BzzU5r+pfJ5hpDvc8+ojhymNmZco6PkMlRVZuus18
 XSZLYicdoq5BHUNxLsnXE6s0v+LC+CKs/6v6e21tM0kMC5Tf0X5g7YHf6xO/Tt3i4gz9
 zZlKdgCjGf/lJzENfywhlrooud4/ZQOKGxgc4smHr5+s5E0HIdLTHWZzsqTfcx4LD35C
 L0SdLtv7CDpvrn91QUWA5H/dW52rHEwPUVZvvKmAev1v7XU/JLv5I1hqsFovyGsvTS8K
 vIHN2c4ghq9P+mIAWwMBncLG84eYYxqVEaxgoObSmDR3Whxvz/vaaIv7+ZaCpDfdMZDg
 5FZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUazk/5P9Zw4pV/76BIQpWf6iDlRHIcwOppmol8B/FlbeR4msQHO+C26neJKairunv9btEhP1v/Vdbx@nongnu.org
X-Gm-Message-State: AOJu0YzXpYMX78jFHfogVkpUCkkdILsuMB43eGg9P4krnCaujV3R2mlc
 cL18LOMqtphJQkvVZgtjX774HgZ0FTimOVcb6ZFd8Db+hC/pSZcvzWTEHnjc/dA=
X-Google-Smtp-Source: AGHT+IGm+ANEaQbzC7uUcOYsD2nQxxM0Qb//G6Fr82uAQCnCu3DBsH9hZfWTXQWBcL2SPMW656+EzA==
X-Received: by 2002:a17:902:f70a:b0:20c:7509:d948 with SMTP id
 d9443c01a7336-21183517852mr79263655ad.17.1731148915010; 
 Sat, 09 Nov 2024 02:41:55 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8c35sm44400845ad.56.2024.11.09.02.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 02:41:54 -0800 (PST)
Message-ID: <d4f53c8b-4267-4386-bfa6-40ee2b1bbb49@daynix.com>
Date: Sat, 9 Nov 2024 19:41:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 2/3] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
 <20241022-virtio-v2-2-b2394236e053@daynix.com> <Zx_AuOl7l5b2UIjG@redhat.com>
 <fcff076c-5616-46f3-aaa1-45d3ad1bbb44@daynix.com>
 <ZyS_FHG1WDncSidt@redhat.com>
Content-Language: en-US
In-Reply-To: <ZyS_FHG1WDncSidt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/11/01 20:44, Daniel P. Berrangé wrote:
> On Thu, Oct 31, 2024 at 04:21:53PM +0900, Akihiko Odaki wrote:
>> On 2024/10/29 1:50, Daniel P. Berrangé wrote:
>>> On Tue, Oct 22, 2024 at 01:50:39PM +0900, Akihiko Odaki wrote:
>>>> DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
>>>> as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
>>>> is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
>>>> bool.
>>>
>>> Again, same feedback as last time.
>>>
>>> With this design, existing users of DEFINE_PROP_BIT64 that
>>> get converted to DEFINE_PROP_ON_OFF_AUTO_BIT64, in addition
>>> to gaining the desired "auto" value, also gain redundant
>>> 'on' and 'off' values as side-effects.
>>>
>>> In the next patch, the stated problem is that virtio code
>>> needs to distinguish between bits that are user set, and
>>> bits that are set based on available host backend features.
>>>
>>> That doesn't seem to require us to accept any new values
>>> from the user. It should be sufficient to track user
>>> specified features, separately from user specified values.
>>> ie when parsing user input for bitfields, we need to parse
>>> into a pair of fields
>>>
>>>     uint64_t has_user_features;  /* which bits were specified */
>>>     uint64_t user_features;      /* values of specified bits*/
>>
>> Properties also have getters. We don't know what to return with them without
>> the new value.
> 
> The virtio changes in the next patch are just accessing the bitsets
> directly. A getter could just be made to return false for unset
> values, on the assumption that any caller should be checking the
> has_user_features bits beforehand.

It means this construct is specialized for the case when the getter will 
never be called for the default value. I think it is difficult to 
convince others to introduce such a new mechanism when we already have 
OnOffAuto as a generic solution. There is even DEFINE_PROP_ON_OFF_AUTO() 
for qdev properties.

The question is: when we have BOOL, BIT64, and ON_OFF_AUTO, shouldn't we 
have ON_OFF_AUTO_BIT64? Whether OnOffAuto is good or not is not a 
problem here unless we are going to deprecate DEFINE_PROP_ON_OFF_AUTO().

Regards,
Akihiko Odaki

