Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A954C369CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5NyV-0008VT-Rz; Thu, 17 Apr 2025 08:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u5NyR-0008V3-TZ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:04:07 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u5NyP-0006rP-83
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:04:07 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E10C14E6027;
 Thu, 17 Apr 2025 14:02:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id nk96FnRK-mZg; Thu, 17 Apr 2025 14:02:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E72A74E6013; Thu, 17 Apr 2025 14:02:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E510D74577D;
 Thu, 17 Apr 2025 14:02:57 +0200 (CEST)
Date: Thu, 17 Apr 2025 14:02:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 000/163] tcg: Convert to TCGOutOp structures
In-Reply-To: <baa52414-03a5-4c86-9719-d6d5419cd798@linaro.org>
Message-ID: <14bf23c2-1623-9c52-5eb9-00a5e743205d@eik.bme.hu>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <a093de11-8901-4e1b-83eb-fd3b6a557249@linaro.org>
 <baa52414-03a5-4c86-9719-d6d5419cd798@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-567190824-1744891377=:63222"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-567190824-1744891377=:63222
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 16 Apr 2025, Richard Henderson wrote:
> On 4/16/25 16:38, Pierrick Bouvier wrote:
>> The only concern I have is that we could create silent "performance" 
>> related bugs, where a specific feature is deactivated because of a bad 
>> combination, but it's inherent to this approach and not a blocker.
>
> I think I know what you mean, and the way I see things it that the silent 
> performance bug was previously scattered across different sections of the 
> code, whereas now it is on the same page.  But underneath there is no real 
> change.
>
> Unless you mean something different?
>
>> As a more general question, how do you approach testing for a series like 
>> this one? I see two different challenges, as it touches the IR itself, and 
>> the various backends.
>> - For the IR, I don't know how extensive our complete test suite is 
>> (regarding coverage of all existing TCG ops), but I guess there are some 
>> holes there. It would be interesting to generate coverage data once we can 
>> get a single binary in the future.
>
> I don't use anything more than our testsuite.
> Coverage data would indeed be interesting; I've not attempted that.
>
>> - For the various backends:
>>    * Are you able to compile QEMU on all concerned hosts and run testing 
>> there?
>
> I have aarch64, arm, s390x via *.ci.qemu.org;
> loongarch64, riscv64, ppc64le via the gcc compile farm.
>
>>    * Or do you cross compile and run binaries emulated?
>
> This is my only option for mipsel, mips64el.
>
> I do not even have a cross-compile solution for ppc32, as there is no longer 
> any distro support. I have been ignoring that, waiting to remove it when all 
> 32-bit hosts get kicked.

Compiling for ppc32 is still possible with powerpc64-linux-gnu-gcc -m32 
-mbig-endian which should still be available in distros. As long as there 
are ppc32 hosts available keeping support for KVM may be interesting. And 
I hope you don't want to remove emulating ppc32 on 64 bit hosts at least.

Regards,
BALATON Zoltan
--3866299591-567190824-1744891377=:63222--

