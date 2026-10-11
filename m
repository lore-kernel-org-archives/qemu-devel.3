Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552D7CA9EBD
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 06:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFmlz-0003px-O2; Sun, 11 Oct 2026 02:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xFmlu-0003pc-32
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 02:10:58 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xFmls-0005JJ-AK
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 02:10:57 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id AAF6A2787F;
 Sun, 11 Oct 2026 06:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1791699051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxHz8tJGx6/8bM7dC+fgx6JyW2dtKc0p4h7WKFvDLTs=;
 b=CeajS9aamjFe2VGIPZHbE7VegeHKoZOKPYUPSnP5Ajq3ehEMw3UkrEiBunuvRbizkwuJIY
 dGd7Q0LQYLXppfulQ0vW6EuVHyTfkV2ol141IGpdV2qldDMxx8s88kXTQNYUONbQSKnK+2
 iWf4R3o4EHf3lbcQ9KuZg4vRCPOn+9qSVB8uyZRCv1xuxd/cyPPodyTYPKvJ1WfQO89Spo
 OjWSZR7WZRHR92pLWrE0yJPlhMj2U/cJ9GiX1otB+T5EdJEOOucOiJc1CP2XIILlYM9uHn
 qGtmTqvWWMPWpPZ2sVhsVKoofm1KKjatwvAhKnzl4ECT17UsQENBMGMDcqcwdw==
Received: from [192.168.1.131] (OPNsense.thinking.duckdns.org [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id 03E4C1106;
 Sat, 10 Oct 2026 23:10:50 -0700 (PDT)
Message-ID: <094898a9-b3fe-43f8-b335-c149ed8b0a96@sloservers.com>
Date: Sat, 10 Oct 2026 23:10:50 -0700
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] common-user: Skip the identity map when qemu is loaded low
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 imp@bsdimp.com, kevans@freebsd.org
References: <605bc800-4263-40af-b8d9-18305d25f3cf@sloservers.com>
 <cfeb85d4-57af-4aa5-a265-a6ac46cf1f22@linaro.org>
Content-Language: en-US
From: Rick Richard <rick@sloservers.com>
In-Reply-To: <cfeb85d4-57af-4aa5-a265-a6ac46cf1f22@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.109.61.218; envelope-from=rick@sloservers.com;
 helo=vps.sloservers.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/10/2026 1:50 AM, Richard Henderson wrote:
> On 10/2/26 12:52, Rick Richard wrote:
>> A non-PIE qemu is loaded below 4 GiB. That includes every static
>> build on FreeBSD and Linux builds configured with --disable-pie.
>> With the identity map (guest_base 0), a non-PIE guest program can
>> be mapped over qemu.
>>
>> Only use the identity map when qemu is loaded at 4 GiB or higher.
>> Non-PIE programs are normally linked below 4 GiB, and PIE programs
>> are loaded at or above it (ppc64 Linux loads them at exactly 4 GiB).
>>
>> Signed-off-by: Rick Richard <rick@sloservers.com>
>> ---
>> On FreeBSD a static qemu can't be PIE, so bsd-user is always loaded
>> at 0x200000. pgb_dynamic() picks guest_base 0 because the initial
>> image doesn't overlap qemu, but rtld later maps a non-PIE executable
>> at its link address on top of qemu's own text.
>>
>> This isn't BSD specific, I was able to reproduce on Linux as well by
>> disabling PIE.
>>
>> I tested the fix on Linux with static-pie and --disable-pie builds,
>> and on FreeBSD with aarch64, riscv64 and x86_64 guests. When qemu is
>> loaded high it still uses the identity map. When it's loaded low it
>> picks a non-zero guest_base and the guest runs normally.
>>
>> I couldn't find an existing way in qemu to get its own load address,
>> so I used __executable_start, which both GNU ld and lld provide. If
>> there's a better way I'm happy to change it.
> 
> There should be no need for this at all.  The probe sequence should notice conflicting addresses and adjust.
> 
> What's your failure case?
> 
> 
> r~

You're right about that, but there's a less obvious case that falls
through the cracks: programs loaded through ld.so. qemu only loads
ld.so, so that's all the probe sees, and it picks guest_base 0. Then
ld.so maps the real program at its fixed address, right on top of qemu.

An easy way to hit it is ldd on FreeBSD. In an aarch64 jail with the
stock perl package:

  # ldd /usr/local/bin/perl
  /usr/local/bin/perl:
  ld-elf.so.1: /usr/local/bin/perl: mmap of entire address space failed: Cannot allocate memory

Same for most other programs in FreeBSD packages.

FreeBSD can't link static PIE, so qemu-*-static is always linked at
0x200000. Ports aren't built PIE unless WITH_PIE is set, and non-PIE
programs on FreeBSD are linked at 0x200000 by default, the same address
as qemu. FreeBSD's ldd runs a program as "ld-elf.so.1 -- prog", so ld.so
is all qemu ever loads. The ports QA check runs ldd on every staged
binary, and gobject-introspection runs it during its build, which is
where I first ran into this.

Linux distros ship static-pie, so it mostly hits FreeBSD, but a static
--disable-pie build fails the same way on Linux too.


