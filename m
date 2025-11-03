Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230ECCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtZ2-0002jT-D4; Mon, 03 Nov 2025 07:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFtYz-0002f2-Hk
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFtYg-0005he-BF
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762172467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a+rESdqXckXkJhC7MD4T9QjaUX+1TCO0kMdktkdLWkE=;
 b=QlotQiW+TOv7MAvLo1xpzUMlYF/Hi1mfNQLZx5g+nmEUBsPL4eka0Hl9hCVECCGl0Im4Do
 KOV0qmWcY1jTJzVuhEp0j5HuDDVRe2yckL2DLiiKDqBxJA3qzbI8GCgYjxm7DWkW+N/k1m
 BQQry+cVIb9eqYCocWMBhhSv7jurUUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-dRxPG6C7ObqZER3_rkLePw-1; Mon, 03 Nov 2025 07:21:05 -0500
X-MC-Unique: dRxPG6C7ObqZER3_rkLePw-1
X-Mimecast-MFC-AGG-ID: dRxPG6C7ObqZER3_rkLePw_1762172464
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-475dabb63f2so20830385e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 04:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762172464; x=1762777264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=a+rESdqXckXkJhC7MD4T9QjaUX+1TCO0kMdktkdLWkE=;
 b=D/qrhnyaj7x7fyVCxGqPwCa9aFcikoxRSJ7EVjfnxmPQ4Ley3zxBPhntPHoJGGrceA
 HbgrP74r1ai09CtwBmpT/yhzngc+CubHv/Zg+vaIHkvrkIA43CEVGxUWXZI69u27JV4F
 Rv4kmKSRs+FqhLLMxhIVsnK1MpqgWPc8mhR9x2a8uuXelfuu2gwefLasxRtcaiqQRenR
 CFGG3kg7tth9ZXtG3l7qopA5j0gGfZBSfLBZeOXzl8TK+/VPmV4dku3fQ7tVvmSx8Itq
 8FT7+w+RNJdwHPKxSfh1LQefJrb23VdLZBpXkgUrWszqeCwqZCOG5ns0JKfhufefd+7z
 FNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762172464; x=1762777264;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+rESdqXckXkJhC7MD4T9QjaUX+1TCO0kMdktkdLWkE=;
 b=KEOP3QjxHsZFyeH2vejZqtRlFSBjugXOYv423X8tU1b6PT7csxAIMFCT/VJxXXCa1+
 NJo2QHS+nIsBVmhKeexvVfFZL/PyirMl1cg+1wjYS9CvnoUaaTmEAtxK0yY+36D2c3ON
 d7SCv0szOrp/USGwxsEIZXuyLbF2BAGmUAt9ZPQfJg8btDoyhx4jbvttPPBwKmQ3ozeX
 3oS2/kvmMQHFC6dsPQyWYclvCxOzQCGcZUNfHFvWIE4Wm52EQT81NVl9I4jaosQg7gQs
 +X4OUctxrBvbAuQLoW6xvSNX17tL/2Wtsi4tBXO3bEbYbafD4Z69r7LSSETAN2HDvrJK
 uQYg==
X-Gm-Message-State: AOJu0YzzedGXzjEnbv8XHqnfxV0JQqBMKu3gDDqAgMRxVfNS+hTwqIf0
 BMWa30NojM6Wh5HyGprnS1/ubriRpBOKlihMGDlg4pf2lec9m28LwXbXTyxn/qj1ianNQ3DpdGf
 adGrK6SstmwuVYOWZsm1y96XDWL19xzZPaySKioEA2wcQFPRMN4lSVvi9
X-Gm-Gg: ASbGncv3oIjfcAZlngpwlPJhDSZXugVd5OnkYERQ2RR+c+rscWAnFwsQYBZUuuwqE+T
 RB3Y+N42wLM4thu/C1dFAC8UIvPy85hwA0uti+jBS6L0Bu1ubKow4IQUmwEIz0PiCA2tmpO2Pa1
 xh2NRG+Q1UmZPaQNtj+53hsY4DB7EhJRBK2Pbhr37eCbv27poJ3tiskvbU6bpjyn3SaNi3Ah7hk
 /n/h1OWGtRVd+IUOvkZd+WqOAxXd42CJvDMk5oDxFKAQ4pVbAGvSL7Z/+jw0T+QRtFrIT3chkRW
 fnX68Pb83XzFED9Ga7EONdgxUVRPjAC6FGBi1Siw/Ehzn/wqhd0wVa9BzbpZ/CEA/DBBwCE=
X-Received: by 2002:a05:600c:19d1:b0:471:1b25:fa00 with SMTP id
 5b1f17b1804b1-477308a89admr112754755e9.36.1762172464373; 
 Mon, 03 Nov 2025 04:21:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF5WNUwK4KNoPNeIMk7NNo6ZTq4GFeUbp3AcZqwZhlRHhzKr1KwTB45U83jItt0AtWiyIeWA==
X-Received: by 2002:a05:600c:19d1:b0:471:1b25:fa00 with SMTP id
 5b1f17b1804b1-477308a89admr112754405e9.36.1762172463890; 
 Mon, 03 Nov 2025 04:21:03 -0800 (PST)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429cdd11467sm9933097f8f.26.2025.11.03.04.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 04:21:03 -0800 (PST)
Message-ID: <94f28445-5ffa-481f-8df8-a72f2a3ab637@redhat.com>
Date: Mon, 3 Nov 2025 13:21:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/10] python/mkvenv: add "tests" dependency group
To: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-7-jsnow@redhat.com>
 <652efa4c-8ee8-4fb0-bf89-09adfb53df2e@redhat.com>
 <CAFn=p-amC0xC9v1wnR+6heHOgu+-igeZeWmgKcuPjnPrVS=gPg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-amC0xC9v1wnR+6heHOgu+-igeZeWmgKcuPjnPrVS=gPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 30/10/2025 19.58, John Snow wrote:
> On Thu, Oct 30, 2025 at 4:40 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 28/10/2025 23.03, John Snow wrote:
>>> This group is intended for packages required to run "make check"
>>> successfully. Once qemu.qmp is fully divorced from the source tree, this
>>> will primarily mean the qemu.qmp package. It specifically excludes
>>> packages only needed to run the functional tests, which are not invoked
>>> by default for "make check".
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>    pythondeps.toml | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/pythondeps.toml b/pythondeps.toml
>>> index 3d6907af799..70e83320855 100644
>>> --- a/pythondeps.toml
>>> +++ b/pythondeps.toml
>>> @@ -31,6 +31,9 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
>>>    sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>>>    sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>>>
>>> +[tests]
>>> +qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
>>> +
>>>    [functests]
>>>    qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
>>>    pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
>>
>> Hmm, "tests" is a string that is very hard to grep for, since it's used all
>> over the place. Could we maybe continue to call this section "testdeps" or
>> something else that is more unique?
> 
> Sure, you got it. I think I did name it that at one point and then
> said "Well, these are all deps, that's kind of redundant", but
> greppability is a reasonable thing.
> 
> checktests?

Fine for me!

>> Also, could the qemu_qmp be removed from the [functests] section now? As
>> long as the python/qemu/qmp folder has not been removed yet, it should not
>> be necessary - and as soon as it has been removed, the generic venv from
>> "[tests]" should be in place, shouldn't it?
> 
> Sure, that's one way.
> 
> Pattern #1: each dependency group should contain everything it needs
> to run the tests/functionality associated with that dependency group
> Pattern #2: each dependency group should specify only the unique
> packages associated with that functionality
> 
> #1: dep groups are self-contained and easy to invoke, but dep groups
> could theoretically drift with conflicting package versions.
> #2: package deps are factored out and can't conflict, but those
> modifying the build system may need to remember that they need
> multiple dependency groups for certain classes of test.
> 
> I went with #1; if we go to #2, it just means that functests need to
> have a dependency on both tests/functests groups. That's fine too.
> Which is better? I don't really actually have enough insight to have a
> preference on this one. RFC?

Are we going to have different venv folders for each category? If so, #1 is 
likely the best approach. Otherwise I'd maybe rather go with #2 to avoid 
that we accidentally specify different qemu.qmp versions for the different 
categories.

> On the subject of "make check-venv": I wasn't able to figure out how
> to really specify the deps for functests yet, I am still kind of
> hammering away at it like a child with a squeaky toy hammer... "make
> check" will invoke (some) iotests; the deps I added to meson in this
> series will adequately detect and cover this when you run this
> high-level target. However, "make check" will also run some of the
> func+quick tests, and I *didn't* specify the dependency there,

Apart from pycotap and qemu.qmp, the func+quick tests should not have any 
further dependencies. Everything that needs additional dependencies should 
go into the thorough category.

> and if
> you run make check with -j#, those tests can actually fail. (Well,
> once the in-tree library is removed, that is.)

Oh, why that?

> Ideally I want to get rid of "make check-venv" entirely and use only
> meson targets that add dependency groups on demand, so I need to
> figure out the right places to inject these dependencies in the build
> system, and I've been having trouble figuring that out.

Sorry, I'm also still quite a meson ignorant so far ... maybe Paolo or 
Marc-André could help?

  Thomas


