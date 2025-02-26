Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB096C19F2E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 16:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKMR-0004NQ-Jg; Wed, 26 Feb 2025 11:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnKMQ-0004MU-89
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnKMN-0001WE-M8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740587650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zm4osR/S6q5D86qhh4mkTPaX37QytX3pbKBJX1sKgVE=;
 b=jB3f/rDXWhcSLIPcWnYXGMaSxaHrZ+p3Z2HR8pHhG/etYqrpG02mejFHsUjzm81kDsZJJw
 59VVodkm7daVjvZZN3lkSdFk5f9jxNF3rKc/E6PnBev2a3RCFgTiB8dRxIVeLPtDoE83YH
 jIgWZMJwTASsyOc6MZoIFQAR7FdhrRc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-jCFrcvqoOriy_fMeoiCE0g-1; Wed, 26 Feb 2025 11:34:09 -0500
X-MC-Unique: jCFrcvqoOriy_fMeoiCE0g-1
X-Mimecast-MFC-AGG-ID: jCFrcvqoOriy_fMeoiCE0g_1740587648
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso371135e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587647; x=1741192447;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zm4osR/S6q5D86qhh4mkTPaX37QytX3pbKBJX1sKgVE=;
 b=bY95wiGTxim7e7PjX8K1sFNDcIuSGoJDUWGkO0FXJ6a61VaHhJa09LJ4uVlcIsfQ2z
 ciQbyOaqVMP2WiuwYWldIQI8ELBd0fPGnLAXOuHP9D02UAaYejIxnMPl899N7+6OC/yv
 M6pSfghFBXXn0jE+rEslDYJ+Zj4LwNKQGaeDiBHeDnYK06gQBj84WDI01ZRbIFM07HIR
 GzBDP0Fzh/IM0vaD5BMl9VUh/dPcrIgJVeC6q47MSWAHhL6zIAJNDg4Cr0Af/V3iq5ew
 BzkrvdU7381kHTSkc20pW+uchPmUZ0wm0I225dnAB6pk2I3OAhEH5ZN6dSls9Nckqa7c
 hZeg==
X-Gm-Message-State: AOJu0YzZbtVr5WUZZCH8dVurmpmP3+vPisAHKcDzILhTyFulBlkkOZwA
 nb4n2i9e+SWp0ESvjCVzY3KLUwdrn4uc+QVjXwezkd7NAMWB6WHpdwZlcx6M1sDFxkV+PAxVhKI
 fj/+A8WdsxYN6kzApUJPcgBZofI22K/K+tl6iSn1PNAtK+FiSNwjYA+227ZnV4RA=
X-Gm-Gg: ASbGnctxSnQruirpz8ME+1RiXu9wZU3LzjUr9h2jhRbkDGyOI4/4olka8yfYfIEQxx6
 IPOxC3cpjcUCGUbb769SydZifliN0iHb7vURHnvYLYpF5Y44s4VxmWdvUF2q1PjN9dQskw1qU3T
 gDMKWVS3CW1Y6prLP1c0mihN6p873ug0EOLTl0YQdEOl/wnfPIcpVLlBEGA8jP1ANh5arF+Q/K7
 6AouAXD4z/694X04ytjDFj26WlFBqskg2RpBlxAyX3LWqwMgZY+EeeeIi1VexVWBjSVmm6JlpnX
 kPPyNdoKcNpAmAxCkm1Rr7wA3+qZP7QD4uUfvXP0UcJ/6//zEA9h3IUqRMk=
X-Received: by 2002:a05:600c:3114:b0:439:9b80:ca6f with SMTP id
 5b1f17b1804b1-43ab0f255a3mr93698495e9.5.1740587647601; 
 Wed, 26 Feb 2025 08:34:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH932Xe92t7ukcIOscs48+Wyq1W1F4IL/FxqkoeW4Rr4eVnwoQUWz0kriw3jAUtNqZrV9yqw==
X-Received: by 2002:a05:600c:3114:b0:439:9b80:ca6f with SMTP id
 5b1f17b1804b1-43ab0f255a3mr93697895e9.5.1740587647135; 
 Wed, 26 Feb 2025 08:34:07 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b7ecsm27078405e9.3.2025.02.26.08.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 08:34:06 -0800 (PST)
Message-ID: <d1aaf224-ab54-4deb-b97b-65e807e88e1e@redhat.com>
Date: Wed, 26 Feb 2025 17:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Update the ppc64 pseries and pnv tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250226065401.197915-1-clg@redhat.com>
 <d61872e1-2eca-4af7-a135-96659ec5fb6e@redhat.com>
 <Z77ZLE8TAQvbfb5k@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z77ZLE8TAQvbfb5k@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

On 2/26/25 10:04, Daniel P. Berrangé wrote:
> On Wed, Feb 26, 2025 at 08:01:09AM +0100, Thomas Huth wrote:
>> On 26/02/2025 07.54, Cédric Le Goater wrote:
>>> The tests are using a now archived Fedora29 release. Switch to the
>>> most recent Fedora41 release.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>    tests/functional/test_ppc64_powernv.py | 6 +++---
>>>    tests/functional/test_ppc64_pseries.py | 6 +++---
>>>    2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
>>> index 685e2178ed78..a9da7905366e 100755
>>> --- a/tests/functional/test_ppc64_powernv.py
>>> +++ b/tests/functional/test_ppc64_powernv.py
>>> @@ -18,9 +18,9 @@ class powernvMachine(LinuxKernelTest):
>>>        good_message = 'VFS: Cannot open root device'
>>>        ASSET_KERNEL = Asset(
>>> -        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
>>> -         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
>>> -        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
>>> +        ('https://archives.fedoraproject.org/pub/fedora-secondary/'
>>> +         'releases/41/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
>>> +        'eca627adbe42437cacea169beeb4c3c12a5cfbca1a6b1ba5218d28139d2143c4')
>>
>> I think we should rather avoid the very latest and greatest Fedora URLs
>> here... they will be invalid in a couple of months after Fedora 43 has been
>> released. And if we keep switching the test assets all the time, this will
>> make it more difficult to bisect regressions in the future.
> 
> Neither of the URLs here should change, as both are using the
> archives.fedoraproject.org server which carries all historic
> content.

Indeed but the files below :

   https://archives.fedoraproject.org/pub/fedora-secondary/<rel>/

are moved under

   https://archives.fedoraproject.org/pub/archive/fedora-secondary/<rel>/

every 2 releases and QEMU tests will break :/

In my tests, I prefer to use the latest FW/Linux images because
HW support should be better, which is always good to exercise a
bit more the QEMU models.

That said, older images (f29) should keep on working too on PPC.

Thanks,

C.



