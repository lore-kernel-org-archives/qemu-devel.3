Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086E1C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4Sm-0001wS-1r; Wed, 14 Oct 2026 15:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1xH4Sk-0001w7-4e; Wed, 14 Oct 2026 15:16:30 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1xH4Si-0006xq-2W; Wed, 14 Oct 2026 15:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792005374; x=1792610174; i=deller@gmx.de;
 bh=vUWQ8j3y4RDXbTQGrxwkwRJexsVaedyio5iXnFeQV+c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ritKrwp7NhmxWQ/6cNu7iozSEYkgDvPjG2foEmp10c8zdFtd32LITo7l+gQn4v8Z
 VHaZEXl2GodtghXSOnEuD8cwXtxoUOLg4uzvltfL4NckFlDcWiXuoVOA+ZvLfGQIx
 74Wt0KHzCTPqxfNojwDZeRdva/atE+jFCB2H52Msinu0laaONwtAz0w0sLyDgEJpA
 RjW1QWjGpSRlzc7Sw5WCUb3T6XN3XYbEOe/bxDABJIq3Pn9q8RMCmhNM9VONuOCKh
 1Jk+TRjc7n4NPRK4+SznFbjozjZPFrTt0vT3EwppKdKZade/Nnuu5BbzjooKnX9cL
 CFE2ps2NacsGVGiSbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1x6rI843xl-00P4Ro; Wed, 14
 Oct 2026 21:16:14 +0200
Message-ID: <b498ad7c-99aa-4aa0-bb18-a09646cbfe70@gmx.de>
Date: Wed, 14 Oct 2026 21:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/riscv: preserve rs1 address for cbo.zero fault
 reporting
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com
References: <20261014181559.1567-1-wangyang25@otcaix.iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261014181559.1567-1-wangyang25@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zSjhgvAnmry6Epsqp2cZ/DVzFVvj23ofoAk9Ub+jSd9vGbPHKmj
 G7fvtCIW4T0x3AKvfyH+QUkRr0Sxzx7k4VDvwBm2X4dlSXLQzqBoIHUo4GRvu1hssnSyKtM
 hSocjiKxw7fAm8OXzHuWsFYp5cTh6J01Fydt4Wi513EI5AFpIG0GVxfZg5eBpmGtkviuuNf
 lZ6MoP9t/t8ShHsaaZfsQ==
UI-OutboundReport: notjunk:1;M01:P0:ACAVwrI5i+k=;3uwONS0rSRZ+MGrSh9THVFqwIPx
 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
 =
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/14/26 20:15, wangyang wrote:
> helper_cbo_zero() aligns the address down to the cache-block size before
> probe_write(), and accel/tcg/user-exec.c:probe_access_internal() reports
> that aligned address to cpu_loop_exit_sigsegv(), so a store fault from a
> legal cbo.zero (e.g. on a read-only page) reports the aligned block base
> as si_addr instead of the rs1 value supplied by the program. Native
> RISC-V Linux reports the exact rs1 address. Keep the original address in
> CPUState and use it when the fault is reported.
>=20
> The saved address must not outlive the instruction that produced it. The
> helper alone cannot guarantee that, because a store trigger or
> breakpoint on the cbo.zero access leaves through the debug path instead
> of one of the four fault consumers, and a later unrelated fault would
> then report the stale cbo.zero address. Also drop the pending override
> on every trap delivery: at the top of riscv_cpu_do_interrupt() and in
> riscv_cpu_debug_excp_handler() for system mode, and right after
> cpu_exec() returns in the linux-user cpu loop.
>=20
> Tested: the read-only-page reproducer reports rs1 for offsets 1, 65 and
> 129; an mcontrol store-trigger reproducer reports the follow-up load's
> own access-fault address instead of the earlier cbo.zero rs1.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4151
> Suggested-by: David Harris <david.harris@gitlab.com>
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
> ---
>   accel/tcg/user-exec.c         |  7 ++++++-
>   include/hw/core/cpu.h         |  2 ++
>   linux-user/riscv/cpu_loop.c   |  3 +++
>   target/riscv/tcg/cpu_helper.c | 27 ++++++++++++++++++++++++---
>   target/riscv/tcg/debug.c      |  3 +++
>   target/riscv/tcg/op_helper.c  |  5 +++++
>   6 files changed, 43 insertions(+), 4 deletions(-)
queued up in linux-user-next.
I'm happy to include upcoming R-b or A-b tags.

Helge

