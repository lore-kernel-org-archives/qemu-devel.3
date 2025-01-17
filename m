Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE8AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfhs-0002yJ-1o; Fri, 17 Jan 2025 01:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYfhq-0002xq-0U
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:19:46 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYfhl-0000nV-Ui
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:19:45 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21bc1512a63so34748485ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 22:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737094780; x=1737699580;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LeY7eco9Afg+zy7wh2x/Xi3q2aZLwxIhBN6CdFZHR9I=;
 b=T2iga8poWmn+PGbhb4SiMD9Uev0AY99EWVWrGLmYedtCTtLroIUG5LO0SFcpN6QjG1
 SG5Q3dgDskBGsK9yNbsAJrmd+X5Oy5EvNEmU9EXZqEK8bQ88y1V7ipTL0Xg1aNaTeTvZ
 yPrQwOcLX+9WFikWi7PWDE+s/PEBdm1bbEpOUARrCx89KbnHuYuPcyz6AML+CeDPD61e
 HR2F+99fm/drY/JcrhTJWYYEaMZTwprScb02zczRSBDU5nkH+SkqWDcq+sBRvO3sO1yD
 OIv2ICfLRroD0UFGbS/cCoGvHRxJ7ZEX9vJ3t5X2H8ZgjMUUgSe1zF1swSYzwKGg8X9c
 nkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737094780; x=1737699580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LeY7eco9Afg+zy7wh2x/Xi3q2aZLwxIhBN6CdFZHR9I=;
 b=ID3rqF3yKKLZxo0zYI88h9zDTjBjfYE2nbf/AN10tob7sseEIKHjZuoTif59+vkgbT
 6W2c2J6xroLA8ovnIR2sb5rf+tH5kJCvMJaTzsaxMo+RwS618dQKP9IjxUfkmO6erVLE
 1uQZac56Mce32lgaqJP6NlSws0ughUbLjqUIyDfBa35LDf/2Valn9YHDFdd7wijBN2gt
 TFVxTPHWivDKdoN+y/oriNP8dsVLge2mRmhesj9Qs/iRETJgqsmbIpOdri9v3JN+fcuk
 uhSi1NTdh9Q8GAySOVbXqu5QIOFsN8hlf49h84QRtav66weYEx4pStC7vS1eITZ8F1uu
 hkLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0ACRb6ptf1jDg3uVL9MNl6Z6qLbsMdU+gDzBrduxyXdgfBMFX2QC6x0GsBBXaWk+wE3BfvJyU3KA4@nongnu.org
X-Gm-Message-State: AOJu0YwJvtJrLI2inSYjP8XSTxLJbtNmk7ViQuaNpViyrtvGXn6vgt+V
 E7VN0IueXFClc8seT0CnrPAfvRWSfMov/ItFn5mW05XNzsgspzHSlI4jDzos9YM=
X-Gm-Gg: ASbGncsotQgJX9NXHy8Q9/Kn4o3N9sAS2mjAaVGqT9kPSlpnOlx8H+aGMCl8grpdYNP
 rvClmDWKm9zx61Nt5OnEXDQn1F/2MRF/hMKO82eyVG6nRblwHg8R9dAZfgFGFMjHgDSitlcXk0T
 P7gTcEWDZEPPYmyERijs7GaP9YiyvwqMC8T1tnRcoJfA5FjIg/oe1meWrF7JrhOkyqZoGWma8zD
 37J3WEqkSc5CnOMWPMMHLnHaE8WxAlpxxzMLWNvQlM2ntDyfGaNoCDeGyX94dT/F9w=
X-Google-Smtp-Source: AGHT+IFr33CPgJeImc6oCDrSElM9UnUK+ig5Lt9iMQseX3NyR/oGKnLGiaIhUkx6LjLgTwDL0PdP0Q==
X-Received: by 2002:a05:6a00:a38d:b0:725:eb85:f7f7 with SMTP id
 d2e1a72fcca58-72daf9be748mr2292365b3a.5.1737094779813; 
 Thu, 16 Jan 2025 22:19:39 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab81753fsm1087219b3a.60.2025.01.16.22.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 22:19:39 -0800 (PST)
Message-ID: <2fe8b128-dda1-40af-89ac-e86ba53138f5@daynix.com>
Date: Fri, 17 Jan 2025 15:19:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
References: <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n> <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com> <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com> <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com> <Z4aYpo0VEgaQedKp@x1n>
 <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
 <Z4a3GxEbz1jjCDc5@x1n>
 <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
 <d9acf231-829e-4a9c-7429-282fcc2ae756@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <d9acf231-829e-4a9c-7429-282fcc2ae756@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/17 1:13, BALATON Zoltan wrote:
> On Thu, 16 Jan 2025, Peter Maydell wrote:
>> On Tue, 14 Jan 2025 at 19:12, Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Tue, Jan 14, 2025 at 05:42:57PM +0000, Peter Maydell wrote:
>>>> There's at least one test in the arm qtests that will hit this.
>>>> I suspect that you'll find that most architectures except x86
>>>> (where we don't have models of complex SoCs and the few
>>>> machines we do have tend to be old code that is less QOMified)
>>>> will hit similar issues. I think there's a general issue here,
>>>> this isn't just "some particular ppc device is wrongly coded".
>>>
>>> I see.  Do you know how many of them would be important memory leaks 
>>> that
>>> we should fix immediately?
>>
>> None of these are important memory leaks, because the device is
>> almost always present for the lifetime of the simulation. The
>> only case you'd actually get a visible leak would be if you
>> could hot-unplug the device, and even then you'd have to
>> deliberately sit there doing hot-plug-then-unplug cycles to
>> leak an interesting amount of memory.
>>
>> The main reason to want to fix them is that it lets us run
>> "make check" under the sanitizer and catch other, more
>> interesting leaks.
>>
>>> I mean, we have known memory leaks in QEMU in many places I assume.  
>>> I am
>>> curious how important this problem is, and whether such would justify a
>>> memory API change that is not reaching a quorum state (and, imho, add
>>> complexity to memory core and of course that spreads to x86 too even 
>>> if it
>>> was not affected) to be merged.  Or perhaps we can fix the important 
>>> ones
>>> first from the device model directly instead.
>>
>> The problem is generic, and the problem is that we have not actually
>> nailed down how this is supposed to work, i.e:
>> * what are the reference counts counting?
> 
> It would be very unintuitive if ref counts not counted the number of 
> references to the object that contains this ref count. If I understood 
> correctly that's the reason for this discussion that in this case the 
> ref count of the owner is counting the MRs instead of its own references 
> and the MR's ref count is not used which is confusing.
> 
>> * if a device has this kind of memory region inside another,
>>   how is it supposed to be coded so as to not leak memory?
>>
>> If we can figure out how the lifecycle and memory management
>> is supposed to work, then yes, we can fix the relevant device
>> models so that they follow whatever the rules are. But it seems
> 
> If looking for rules to follow one proven and relatively simple set is 
> what Cocoa uses on macOS. There's a very short introduction here:
> https://www.peachpit.com/articles/article.aspx?p=377302&seqNum=2
> and a bit longer more complete here:
> https://www.tomdalling.com/blog/cocoa/an-in-depth-look-at-manual-memory- 
> management-in-objective-c/
> 
> I think this case is one which is shortly mentioned at the end of the 
> second link which is solved by not retaining the contained objects so 
> this is closer to what PeterX suggests just dropping the refcounting on 
> the owner and consider the MRs owned by the superregions once added 
> there. This means add subregion would pass the reference to the owner 
> and remove subregion passes it back to who called it so the MR's ref 
> count needs no change but then who added the MR should not use it after 
> passing it to the superregion and who called remove subregion should 
> release it. But I don't really understans the problem so maybe it's more 
> complex.

Let me explain my and Peter Xu's solutions by listing object references. 
It will abstract the details away and allow applying the analogy of 
other reference counting systems like Objective-C.

"Real" reference relationship
-----------------------------

First, I'll introduce one basic rule:

Rule 1. If A needs B, let A refer to B.

Now, There is an owner and a memory region. The owner needs the memory 
region to function. The memory region needs the owner to provide to 
allocate itself and e.g., to provide MemoryRegionOps for 
memory_region_init_io(). So we will make a bi-directional reference 
between the owner and the memory region.

O (Owner) -> MR (Memory Region)
MR -> O

Now, let's think the case where there is a container and subregion, and 
they are owned by different objects. The container needs the subregion 
to satisfy its accesses, and the subregion needs the container for 
memory_region_find(). So this relationship is also bi-directional.

CO (Container's Owner) -> C (Container)
C -> CO
SO (Subregions' Owner) -> S (Subregion)
S -> SO
C -> S
S -> C

Let's think someone took a reference to the container e.g., for DMA. 
This mean we add the following reference:

DMA Controller -> Container

This will ensure all of Container, Container's Owner, Subregion, 
Subregion's Owner are alive during the DMA.

"Weak" references
-----------------

Next, I'll impose the restriction that prevents circular references. To 
avoid circular references, we'll stop counting references for one 
direction. In other words, we'll make some references "weak". Weak 
references are prone to be dangling (in Objective-C or other platforms, 
such references will be usually replaced with nil-like values).

Rule 2. Make a reference from a memory region to its owner weak
Rule 3. Make a reference from a subregion to its container weak

CO -> C
C -> CO (weak)
SO -> S
S -> SO (weak)
C -> S
S -> C (weak)
D (DMA Controller) -> C

This will fix circular references, but unfortunately it will not work 
because DMA Controller requires weak references to reach to Container's 
Owner or Subregion's Owner with "strong" references; it means they can 
be dangling at any time.

To solve this problem, we'll introduce another rule:

Rule 4. Replace references to memory regions with references to their 
owners *except for the references from the owner to the memory region*.

CO -> C
C -> CO (weak)
SO -> S
S -> SO (weak)
C -> SO
S -> C (weak)
D -> CO

With this change, D can again reach all of CO, C, SO, and S.

Problem
-------

What if Container's Owner and Subregion's Owner are identical?

O -> C
C -> O (weak)
O -> S
S -> O (weak)
C -> O
S -> C (weak)
D -> O

Now there is a circular reference: O -> C -> O

My patch
--------

My patch amends rule 4:

Rule 4'. Replace references to memory regions with references to their 
owners *unless the reference originates from the owner*.

O -> C
C -> O (weak)
O -> S
S -> O (weak)
C -> S (this used to be C -> O)
S -> C (weak)
D -> O

Now the circular reference is gone.

Peter Xu's patch
----------------

Peter Xu's patch adds two new rules:

Rule 5. Make references from a container to its subregion weak if they 
are owned by the same object.

O -> C
C -> O (weak)
O -> S
S -> O (weak)
C -> O (weak [this used to be strong])
S -> C (weak)
D -> O

Now the circular reference is gone and D can still reach O, C, and S.

However, there is one problem: C requires a weak reference to reach to 
S. More concretely the pointer from C to S will be dangling when the 
reference O -> S gets dropped during the finalization of O.

Peter Xu's patch adds yet another rule to overcome this problem:

Rule 6. When a subregion gets finalized, drop the weak reference from 
its container to itself.

The dangling reference will be gone with this rule.

Comparison between the two patches
----------------------------------

I'll compare them by showing pros and cons of Peter Xu's patch.

Pro:
a. Will not add yet another direct reference to memory regions where 
currently there can be only one reference from the owner to each memory 
region.

Cons:
b. It requires two new rules.
c. C will see its reference to S to disappear at random timing due to a 
weak reference.

So, which is better do you think?

