Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56A6606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=I/IKKVJG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKC48-000562-VW; Fri, 23 Oct 2026 06:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xKC47-00055T-42; Fri, 23 Oct 2026 05:59:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xKC44-0001XK-MG; Fri, 23 Oct 2026 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792749586; bh=OxYX5V2xfthplOOMri2zUPiTdpQT4VeCmm4NMmFLOwc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=I/IKKVJGwWCv8y19cITU42iyAC5nPKiKHpdxeOY2iynq9QMlokzleb/jRsLY2UdCJ
 b6MUXm8QBTUSIa7nwrFE0Tpa3An0j0NbOIUYEz6mmDlFYoy9DYKhJb0aghznGbjGzU
 fHm/VqXT517WNTJINSWQQlbGNPkfs2PeGUmj4ZLax3yexg/BdIASrLy1RdkCAc3/VY
 B0YMwKPTx0E3OZDfwDt6NIjtGIY182pM0GBBYWfo1NefOQQxiI3vQmS6grP5Vda98h
 rePFISeaqVBnPg9i4O3yqMZGBtkW7t+WIL7Mmh/E0EmJPvY20I+VdsLUcAmofmIdjw
 QozMRZaTT0egg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 427BC1E0256;
 Fri, 23 Oct 2026 12:59:46 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 396494493E0;
 Fri, 23 Oct 2026 12:59:45 +0300 (MSK)
Message-ID: <f036efe9-6bd8-4785-b19c-e5027e25a091@tls.msk.ru>
Date: Fri, 23 Oct 2026 12:59:45 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/i386: ELF endianness fixes
To: Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20261019185600.2031729-1-farman@linux.ibm.com>
 <20261019185600.2031729-2-farman@linux.ibm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261019185600.2031729-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 21:55, Eric Farman wrote:
> Running make check-tcg-x86_64 on a big-endian host (e.g., s390x) fails due
> to problems reading/parsing the ELF data:
> 
>    qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note
> 
> There already exists logic in include/hw/elf_ops.h.inc to handle byte-swaps
> where necessary, but it does not perform this logic for ELF notes itself.
> 
> Fixing that improves matters, but yields other errors: most of the tests
> timeout while some generate confusing assertions. Both appear to be related
> to the data addresses in those notes, which are incorrect when running on a
> big-endian host.
> 
> Adding tswap wrappers, which will conditionally swap if the host and target
> endianness don't match, fixes that such that check-tcg-x86_64 runs cleanly
> on an s390 host.
> 
> Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/i386/x86-common.c     |  6 ++++--
>   include/hw/elf_ops.h.inc | 20 ++++++++++++++++++--
>   2 files changed, 22 insertions(+), 4 deletions(-)

Hi!

This looks like a good addition for the stable series, if it actually
fixed the issue mentioned.

I'm queuing this change for the stable series, but not picking for any
release just yet, - if a follow-up fix will come, I'll include both.

And please let me know if I shouldn't :)

Thanks,

/mjt

