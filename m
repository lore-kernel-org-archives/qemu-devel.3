Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEFCD2ECF9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 06:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi578-0000r4-7u; Tue, 20 Jan 2026 01:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi575-0000pN-S0
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 01:21:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi574-0006BO-5Z
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 01:21:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so20804805e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 22:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768890072; x=1769494872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+RWZCAG5/qHPHjoyeofiaLHcthL/fCWc8N8CVtQdDwc=;
 b=Tl6dvBe2DnV0+j/C8haou5ti0L6PqMptQELjFsO+WaxWxu3rHhZ+EB/9Lj+QvBiSB9
 SzvQScTbF6Ufk1G5X0eZy5FXRTMMli9yBkI9ZxwoZjkGyukYZzqnMnRDq25d63aeAav8
 e0bHE5dQgqg/cJ0tAf7XFLXpguv1gCxhI5BAnDjVztCrHWvVAuza366JaLlc4nIIOLx9
 5JlrPupppefnQOislQxo9i2kyiZyVMiwsc9+SIC88mjJH6oz1a+XH1aI4NBTNi9mGqTd
 fJKEErO8lQV6CQVvtFfY3Dqu2xvoF0bfciTUSjKfmMLRSFUHmFWxG16FCaYYm27NkiRe
 Bkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768890072; x=1769494872;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+RWZCAG5/qHPHjoyeofiaLHcthL/fCWc8N8CVtQdDwc=;
 b=DNvD53TRlD42R9l9EVpNcrofDjPP27y0O6bySjvv37QhZmYKvA1f1jcWOJHYxa2CeU
 XfiTTg4BoAwOWWKRLc98lTSDcfSK4kD/9n7O9YUSATovmXhrBgxyesJTv5tQhS+JGiUU
 guV98/X7E2YYJh7hsDOSuKRrsWw3thRH7erk49y0hhnOP43AQWLRhjEFHyWi0EOs9Brc
 4lIzD6J1ei30nLGECr0Qu1o/pF9eiIasCIS06XJ9w9q0FIMzB9pxlZ/5zF18+94y8ZEK
 jimAzTkxn0DRAGK+sL41B4aJA0i9NUX4AcwgNe9cJhSKJIZilXgeaAPDv+dZ9uA08vuz
 Pevw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxJ4tNzMfUOjIwJ383V7tQ4ERhlMr1DeB5NGevNBTOZS6i9sKFycirHSF+2TOZR+12nb28zEENU+Na@nongnu.org
X-Gm-Message-State: AOJu0YxDVI5rqi1CwPTdYw72vHvMjccFkSlrJQuNLOoiRXOsOlEG9pHs
 TVlYjNw7tAow6NOe4HNXjInZDK8WXWWGwQWlIZ/YrF1EW/tcKu5Q/okg/QfExoxRWWI=
X-Gm-Gg: AY/fxX5uwHkR6b0Q+dz5VFs/+SATxF23kfuOfvGdsXLJUD9uGRJs4fxb8AKndm95gfF
 sXFe9N3LVn6KGRZOhd/oLOjhOZI75FQpLtvR80bpesFwjEbdI+M4s5fG0AAaMTqKHQsHIOD24/s
 zlwKSu1NT6N7khLMxGMS+2RwklVc0J43ONxZvt9gojWN8Rx4LvKDUprRz0cmOW75xPqgIq9qWcY
 Gy4B2gf8MzN4qp7LszPbDVL42RSwy07KhHaJ711N0mJYDVNXMetkzlrLXFnDMrVTsZfC17D8KOK
 XNEMNaQYS2upEbUl0tdLVDTd5FPFRjOLOpJOIRi1HyDoR+RwYOi6DKx1w8elQJpJLr/sjEeG+fV
 fxYKKN4cbSlxGBlQIU76VESx5FMx4pdKJLW4770CU8pEpHHJlrEImBFX+429sddgu30nqRHS7l+
 Ar6GSOKXx/b87Tx4YbPpjLkcaI/6GBcmhVCkB8JVh50ZlkZ5kIdfoc/w==
X-Received: by 2002:a05:600c:4e86:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-4801eac4779mr155004295e9.14.1768890072368; 
 Mon, 19 Jan 2026 22:21:12 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4802dc90068sm167340545e9.7.2026.01.19.22.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 22:21:11 -0800 (PST)
Message-ID: <af9dfc2f-7075-454f-bebb-d0fa4c584eeb@linaro.org>
Date: Tue, 20 Jan 2026 07:21:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
 <88cdd7fb-059b-4ce2-9db6-57700aad0571@redhat.com>
 <467c2bca-af39-4e00-b8ea-9e38c1f16e54@linaro.org>
 <dce4a763-d64a-4ef3-be05-9c24080c8003@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dce4a763-d64a-4ef3-be05-9c24080c8003@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 19/1/26 09:19, Thomas Huth wrote:
> On 16/01/2026 19.31, Pierrick Bouvier wrote:
>> On 1/15/26 11:17 PM, Thomas Huth wrote:
>>> On 15/01/2026 21.35, Pierrick Bouvier wrote:
>>>> I would like to help maintaining qemu documentation and I've been
>>>> invited by Alex to apply as maintainer.
>>>>
>>>> Files in docs/ that are already maintained will continue to be under
>>>> their respective maintainer. The goal here is to have someone that can
>>>> help on all other files that don't have an official maintainer.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    MAINTAINERS | 5 +++++
>>>>    1 file changed, 5 insertions(+)


> I don't think it is e.g. hard to filter for e-mails that have "docs/" in 
> the subject, so that's certainly not a problem. It's getting tricky for 
> huge series that e.g. have just one little change to the docs folder in 
> between. Some people will CC: the whole big series to you for that 
> little change in one of the patches - how do you filter for such series?
> 
> Having maintained a generic subsystem with a catch-all entry in the past 
> (I used to be the maintainer of the qtests, and we had a "F: tests/ 
> qtest/" entry in MAINTAINERS for this), I often got CC:-ed on big patch 
> series that should rather go through the architecture maintainer's tree, 
> and since only single patches affected the qtest subsystem, this was 
> hard to filter, so I always got lots of unrelated patches in my Inbox in 
> which I was not really interested in.

You can use lorelei, i.e.:

https://lore.kernel.org/qemu-devel/?q=dfn:/docs/+AND+-s:PULL

See how to integrate with your client workflow:
https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started#maildir-or-imap

> My mitigation was to add some "X:" lines to the qtest section in 
> MAINTAINERS ... but if someone has some better ideas how to deal with 
> such situations (e.g. if there are some clever ways to filter such 
> series out of your Inbox), I'd be grateful to hear about them!

Ditto i.e.:

https://lore.kernel.org/qemu-devel/?q=dfn:/docs/+AND+-s:PULL+AND+-dfn:/docs/devel

> 
> FWIW, for the functional testing framework, I organized the entry in 
> MAINTAINERS differently, there is no generic "F: tests/functional/" line 
> in the section, but rather only coverage for the shared files of the 
> framework ... the tests themselves should be covered by the individual 
> maintainers instead. This works much better for me there.
> 
> So I'm interested to know how the generic "F: docs/" entry will work out 
> for you once this patch got merged and some weeks have passed. Having a 
> BoF at the next KVM forum about this email workflow topic might be a 
> good idea, indeed.
> 
>   Thomas
> 


