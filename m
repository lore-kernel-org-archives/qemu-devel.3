Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E160CC6B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHDdW-00033O-D8; Thu, 15 Oct 2026 01:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xHDdU-00033D-Ft
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:04:12 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xHDdS-0007d1-OC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:04:12 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id 0039394C7;
 Thu, 15 Oct 2026 05:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1792040647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M68i/OP4/Wz0w435qEj2szCXEPlqPmyot5dwVrReU7c=;
 b=TJDUmPCDOqh1Vk+Q4P383ppPNUfsEW7VN0xnTQ1OOyVTi3b1mR1MbjuUur/xc4ch9qbDLH
 bLNqPeH87GL4repVhD9Tpj4xy4/VuOWE/4a6CcpCJOfGolE90C5p5rKJPAks8USHhnAUfU
 zO/msudgSUykcKlCUo7Ui66BEz5C63m/21lSMgBRSHD6SoWZiPV3H+Sha+l5TF+EHUKzsV
 eoZ1Q5ZZe+bfKJRcUEUwAYKoQ469SPEoUwsF5maZI6A8/OyTs2BlQzlD30ZRBAZQoBymtk
 abPARvxUi55J2VhVJHf5FQRlSuJsTza1fiVvTTqZD35Jri+bEctH94BebmGy9g==
Received: from [192.168.1.131] (OPNsense.thinking.duckdns.org [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id 42E04121B;
 Wed, 14 Oct 2026 22:04:06 -0700 (PDT)
Message-ID: <9dd7ae30-b1fd-4dae-9e62-594af39a77d2@sloservers.com>
Date: Wed, 14 Oct 2026 22:04:05 -0700
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] common-user: Skip the identity map when qemu is loaded low
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 imp@bsdimp.com, kevans@freebsd.org
References: <605bc800-4263-40af-b8d9-18305d25f3cf@sloservers.com>
 <cfeb85d4-57af-4aa5-a265-a6ac46cf1f22@linaro.org>
 <094898a9-b3fe-43f8-b335-c149ed8b0a96@sloservers.com>
 <1f1af018-8720-467e-8c8b-b4c19a0b9c5b@linaro.org>
Content-Language: en-US
From: Rick Richard <rick@sloservers.com>
In-Reply-To: <1f1af018-8720-467e-8c8b-b4c19a0b9c5b@linaro.org>
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

On 10/13/2026 7:53 AM, Richard Henderson wrote:
>
>> FreeBSD can't link static PIE, so qemu-*-static is always linked at
>> 0x200000.
>
> That's unfortunate.  We could explicitly link somewhere high in the address space, perhaps.  E.g.
>
>   -Wl,--image-base,0x80000000000
>
I tried that, but on FreeBSD amd64 it won't link above 2G.

The static libc and crtbeginT.o aren't PIC, so they're full of
R_X86_64_32 and R_X86_64_32S relocations:

  ld: error: /usr/lib/crtbeginT.o:(function __do_global_dtors_aux: .text+0x8):
    relocation R_X86_64_32 out of range: 8796093721768 is not in [0, 4294967295]

  ld: error: /usr/lib/libc.a(libc_start1.o):(function __libc_start1: .text+0xb7):
    relocation R_X86_64_32S out of range: 2415920304 is not in [-2147483648, 2147483647]

0x70000000 works though. I linked qemu-aarch64 there with no other
changes, and guest_base stays 0. ldd on perl and the other packaged
programs I tried work fine with this.

It's not really safe though, it just moves qemu out of the way. A
guest MAP_FIXED can still land on qemu's memory and crash it, even
with a non-zero guest_base, since the heap and code buffer are still
in reach. Maybe target_mmap should refuse that and give the guest an
error instead?

If you want to go with the link address, I can add it to qemu's
meson.build for static non-PIE builds.

