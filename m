Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8780ECAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 06:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzUNE-0007n2-5V; Fri, 19 Sep 2025 02:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzUNA-0007lj-DJ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 02:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzUN8-0003JF-BX
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 02:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758262406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Atl1Vzq0LATJ4Vj7lg6vgqxrQHfhwC4/H5PyL9zEP5o=;
 b=AUkDowPlRIjPDx22TSliLYTlvUp6hwp1HvxEYjnBYQqneQVDCvera0E6x9TOdY6p9lSWr2
 fpi5YbQOXFz5a6vceC3a0JxUT5dIZhcpAu/YZSUr1sZ8avfauWUTgnIOFr30bop+Abn5qc
 GTRotDGMG3CEJkv0ZgpnASesHmo+XWc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-sbb_QMPnOLOjckKP9aw3Rg-1; Fri, 19 Sep 2025 02:13:25 -0400
X-MC-Unique: sbb_QMPnOLOjckKP9aw3Rg-1
X-Mimecast-MFC-AGG-ID: sbb_QMPnOLOjckKP9aw3Rg_1758262404
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45dd5c1b67dso8496285e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 23:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758262404; x=1758867204;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Atl1Vzq0LATJ4Vj7lg6vgqxrQHfhwC4/H5PyL9zEP5o=;
 b=aHU24kje36fJY7WU1fDlQBCXvasRARH7rgav3pzplUjsm85U33IRxsvFOtW/HAfanu
 10HHn3h1nrNElS3C+ShxE65uaNHa3/TwZ4I6qMpKCl7OGB9QIN0VRGHVsLtrC1CCHFAa
 qcPtJ+IOBZAJ3ZMPr4CNGcTiChm2NA3oi5+yiQbXcKzNkLPbBNjnmZemQLzcme4kirOn
 zMrWLumqd6aC4rV0YgGGORHPE0B89qKeFyxVBYCE7Dq6PYW4xTsTzdgI8Fyf6AD2HgSp
 80M7I+zyWtY05Y/5MPbQqaVBVQddSeerslyhWynbQzzEVFhnlM4ZGxR1ghjGRm0MTJwZ
 m7xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo486U2uu2ROJKdGLt5kZ3Bhrq9+X9dSf8+0SvAeiQtrt3k3GKA0GYKeYlJunar8OfyJmDTTe6cr4v@nongnu.org
X-Gm-Message-State: AOJu0YyKgliQXXGlT+/mFEWB8Zk605YtJA7Zzk+YC34+cxcoiGmni3YH
 h0f2R0S2mx6mGHKHD8MwdS6PuL5+w0xwhvWaSIN7hYfl7UZB1kpluyzqz7I6CIkPpypaDHU88qC
 1e7C11YS/AJStBN5hKkv7NyqwnaCCQhzf7ukCP83ytbM4QBwTqWYxtyYJ
X-Gm-Gg: ASbGncv7UfWDe6llReqyk8BsCxsgu6TEud67eJQOh6TyHaLRHAeLzLLodndjgy/bvxw
 ni1iYLaL4OGXMMDsEwxt1v9N1JKAxD9oZSv/PiI057JgdZA1JKXHWopoLaqSS7zwggfrwPnYTgR
 Rn9MFIIXWi4ooZfstPo6K4Uq0GwWXA+ZcpJ/hoG184QjVFP0AB4IHkqWBJEtradou0h/e2kRypP
 E/Onrr54rDKXyxi5KFVnYoBbximyD/KdLjqAz25l8t3sVAmMNeAK1qdkIZIJQ3l4d8YuqefFKtQ
 G3zHZNWEaJZnBYucdj01fm6Cua/FahSVl/VKrSt4pp1kP+bsrVJ6H8XWu7Ao0oZThOhuu9RyD+Z
 COB7KIw==
X-Received: by 2002:a05:600c:1f0e:b0:45b:8f11:8e00 with SMTP id
 5b1f17b1804b1-467f3840597mr13669815e9.37.1758262403854; 
 Thu, 18 Sep 2025 23:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMqmAQRTdzDvSR+QycXFpzexrhBgdgeFC2bPDY/TkVZxm4MRQanjQPzgPVxO3/ir8EIOvjzA==
X-Received: by 2002:a05:600c:1f0e:b0:45b:8f11:8e00 with SMTP id
 5b1f17b1804b1-467f3840597mr13669395e9.37.1758262403367; 
 Thu, 18 Sep 2025 23:13:23 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f527d6cdsm81369385e9.12.2025.09.18.23.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 23:13:22 -0700 (PDT)
Message-ID: <835bdd7f-3662-4fd0-be2c-1fc1bca030a9@redhat.com>
Date: Fri, 19 Sep 2025 08:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <CAFn=p-YTFYr-cxz0B8jay=-HVpjyo9To72DZAg5o45SRBR0wnA@mail.gmail.com>
 <f208a06d-2dfe-4cce-a848-938b3e3b6a31@redhat.com>
 <CAFn=p-aZA0_DhBEFohK6TS=xev459S2YGPm9N3X5w+QDi0noEA@mail.gmail.com>
 <147a8aaf-5895-435d-8394-ef6a5e03b638@redhat.com>
 <CAFn=p-Z_Du_xbOKg+2wMPzshgOT1MX+AKLNNE9FLpEp+gkQLhQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-Z_Du_xbOKg+2wMPzshgOT1MX+AKLNNE9FLpEp+gkQLhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/09/2025 21.54, John Snow wrote:
> On Tue, Sep 9, 2025 at 6:37 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 07/08/2025 23.46, John Snow wrote:
>>> On Thu, Jul 24, 2025 at 3:47 PM Thomas Huth <thuth@redhat.com> wrote:
...
>>>> Wouldn't it be possible to add the module as a wheel in python/wheels/ ?
>>>> That's maybe the easiest solution, isn't it?
>>>
>>> The qemu.qmp wheel, yes, because it's purepython. The part I am
>>> worried about is that by removing qemu.qmp from the tree, you cannot
>>> just use the PYTHONPATH hack anymore to use the remaining in-tree
>>> goodies, namely the machine module used extensively throughout
>>> testing, because they will now rely on an external dependency.
>>
>> Would it maybe be possible to add the machine part to the qemu.qmp module,
>> too? (Gerd also ask me at KVM forum about this, so there is certainly
>> interest for extending the qemu.qmp module with the machine part)
> 
> I could, can you explain a little why we want it?

I hope that Gerd can chime in, but basically he wanted to test another piece 
of software in a similar way we do it in QEMU with the functional framework. 
That means some function that manage the life-cycle of a QEMU VM would be handy.

> It would involve
> cleaning up the interfaces a good deal and while I don't think it is
> hard, it will be a lot of clerical work and shuffling for a little
> while. I have some drafts somewhere that add an asyncio VM appliance
> to replace the existing one in the same manner as for what I did for
> async QMP to help solve the complicated logging stack we have for VM
> console scripts.
> 
> Having a solid justification and guinea pigs^H^H^H^H^H^H^H^H^H^H^H^H
> beta users would push the project over the line for me.

I'm sure Gerd is happy to help if he can find some spare time, and I'm of 
course happy to help with regards to the QEMU functional testing framework - 
let me know when you've got something ready and we want to have a try to 
move the functional tests to that new VM management code.

  Thomas


