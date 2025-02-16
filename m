Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB02C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjSqC-0000bQ-QN; Sat, 15 Feb 2025 19:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjSq4-0000bA-1L
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:48:53 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjSq1-00045u-Qv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:48:51 -0500
Received: from [192.168.1.5] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 51G0mh1K3803070
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sun, 16 Feb 2025 00:48:45 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=J6r7kKDs header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1739666927;
 bh=LGeBEfmEXXAc6/1O/een5ohfK467K2NaIv88ONr8cP4=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=J6r7kKDsvOtCObKrUrRMZOh+CVKECjTozxWwO/kwSnnIYeUyVE+BzlCUFD82ARvyH
 kB4lA7pe/BgTosbXi6MVpOZVJJfqjK8YjmIZ4BHAuDOGMpKpvj+/CHwHZN1BtijhOs
 b6P8TH2iCSiWYR2IGfMURIGWNh55nB+03L387C9QACGMs8BrnVzn8sLgkb/4d0EK0v
 2FHXKb0A5Ayybz9K0i3iFQK70K1ggf1JgpzrwMx18m/9bWYRd3ZdPFFf6CbXPqA0zP
 dazBxCuNTcRiyp/9sHiH7i64OHPC22T2owBOlPbuz6IsjjPuil09QLMFROdh7vWH9+
 JMDvKAPSpBwNA==
Message-ID: <cc1d4961-286d-4478-aa3b-344ad970ae99@anarch128.org>
Date: Sun, 16 Feb 2025 13:48:37 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
 <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
 <8f107cd4-f5a2-4d3e-b023-5e53225511d4@anarch128.org>
 <38bfbaac-329c-45c8-a672-68cad965201b@linaro.org>
 <6b9d6600-d430-4bcc-9f37-8d8d96d31e06@anarch128.org>
 <0ec10457-0461-46e7-95df-a5d1552ab722@linaro.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <0ec10457-0461-46e7-95df-a5d1552ab722@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
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

On 2/16/25 12:41, Richard Henderson wrote:
>>> I don't think this is a good change to make.
>>
>> fixing varargs codegen in GCC/Clang would be a good change. count 
>> based varargs can be reasoned about statically relatively easily. what 
>> is it like with an explicit inline as opposed to just static?
> 
> Inline will still be rejected.

oh wow. fair enough. I didn't know varargs was so broken. Clang even 
appears to be emitting weird extern functions with inline varargs that 
change when another invocation is added. taking away inline fixes it. 
this is unusual and I think this is a Clang compiler bug. flip the #if. 
code seems to be conforming or is it a bug? might post to Clang folks.

https://godbolt.org/z/WsEPfdfbE

