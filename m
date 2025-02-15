Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6437C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 22:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjQq0-0006Lo-GW; Sat, 15 Feb 2025 17:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjQpz-0006LK-9K
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 17:40:39 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjQpx-0006bB-LW
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 17:40:39 -0500
Received: from [192.168.1.8] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 51FMeV333796686
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sat, 15 Feb 2025 22:40:34 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=alEZUOfN header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1739659235;
 bh=/2hhOhZ1yzncjsnLPeiIX1Z/s8JyhNNcOSkopkaBJk0=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=alEZUOfN1TmMV5puUOuDmCuyMygKukvYQdUfm7hbmA74MpBNb0pxRxXf9DAEdZBC1
 FqUkwiJJeRieIRpnwvWBG2VLgrUh5fLUraU6r8uImPyaS78ga6OdXMHDYBacnBAUSW
 VRWMWOWcB9vv6hzCXEXMBJ6YjCPqUB+9WhnK68C23xmGo7YE4+qWJXpLjYBnlu9ouI
 e6go7UB6Suxslj1AYmtkklh12arrdE3Z7o+IVYrKbCagOFgiW1n5tVO/o8nqwGtHP3
 JW8CM64RrDMdgClDl3C+8/FKa9Fgdg1Uw7uEhIjVq5qhHGnd2IBXaKQvJQNB8B2OMn
 CcFlpnPCbmHRw==
Message-ID: <6b9d6600-d430-4bcc-9f37-8d8d96d31e06@anarch128.org>
Date: Sun, 16 Feb 2025 11:40:25 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
 <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
 <8f107cd4-f5a2-4d3e-b023-5e53225511d4@anarch128.org>
 <38bfbaac-329c-45c8-a672-68cad965201b@linaro.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <38bfbaac-329c-45c8-a672-68cad965201b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/16/25 10:50, Richard Henderson wrote:
> On 2/15/25 12:24, Michael Clark wrote:
>>> Why?  varargs generally produces horrible code.
>>> The split between alloc and insert was intentional to avoid this.
>>
>> it's pretty good code on SysV because it goes via registers except for 
>> perhaps new_pool_l8 which will spill to stack and get copied unless 
>> the inliner can eliminate the copies. maybe windows has bad varargs. 
>> but I like the style better than deeper layers of wrapper functions. 
>> they should fix the compiler so that it produces better code.
> 
> varargs will generally prevent inlining.
> 
> Indeed, just a quick look at aarch64 tcg_out_movi shows that without 
> your change, new_pool_label, new_pool_data and new_pool_insert are all 
> inlined.  With your change, new_pool_data is not inlined, all the 
> argument regs are dumped to the stack, etc.
> 
> I don't think this is a good change to make.

fixing varargs codegen in GCC/Clang would be a good change. count based 
varargs can be reasoned about statically relatively easily. what is it 
like with an explicit inline as opposed to just static? I will inspect 
anyhow. as varargs with the argument count moved and long as opposed to 
format strings is a reasonable pattern for generics in C given C is so 
bad at generics. saves lots of long form delegating functions.

I like the representation but understand if you don't take the patch.

