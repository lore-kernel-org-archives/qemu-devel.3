Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93F4C7114A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 06:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRQ9g-0006RP-A6; Tue, 17 Jun 2025 02:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1uRQ9a-0006QL-TM
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 02:50:43 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1uRQ9X-0005Fo-1E
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 02:50:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D50006105D;
 Tue, 17 Jun 2025 09:50:30 +0300 (MSK)
Received: from smtpclient.apple (unknown [2a02:6bf:8080:441::1:d])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ToFnfY0Fda60-AwbcKzaL; Tue, 17 Jun 2025 09:50:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1750143030;
 bh=v/4rBN0yUepd3+AXXrnJdGClhUWqkeWTZKRJQuZbZY4=;
 h=Message-Id:To:Date:References:Cc:In-Reply-To:From:Subject;
 b=YW6xYZriZXWc/BgGaFGw6sTtrgQjbgE0G2+hVMRaI/KDkjUH5iIwyd/8mxGnc/6JN
 LF8BlFbo2uhZ+ZuNnvSVSNb5qkEZDOAVZHBNsI399fQloPNEqmY0C4bUzJZ9rkDMmI
 uH0UWvNzsIB2DiQa69TXlCXHhzPYZXzZ89xaYAGY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
In-Reply-To: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
Date: Tue, 17 Jun 2025 09:50:19 +0300
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <673A5394-1E5A-4A08-86AD-7B5DF812E46A@yandex-team.ru>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=stdcalllevi@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello there, would you be so kind to give some feedback on this patch?

> On 23 May 2025, at 18:44, Kirill Martynov <stdcalllevi@yandex-team.ru> =
wrote:
>=20
> Certain error conditions can trigger x86_cpu_dump_state() to output =
CPU state
> debug information e.g. KVM emulation failure due to misbehaving guest.
> However, if the CPU is in System Management Mode (SMM) when the =
assertion
> in cpu_asidx_from_attrs failure happens because:
>=20
> 1. In SMM mode (smm=3D1), the CPU must use multiple address spaces
>   with a dedicated SMM address space
> 2. On machine types with softmmu, address spaces are hardcoded to 1
>   (no multiple address spaces available)
>=20
> The assertion occurs in cpu_asidx_from_attrs() when trying to
> access memory in SMM mode with insufficient address spaces.
>=20
> Fix this by:
> 1. If number of address spaces is 1 always use index 0
> 2. In other cases use attr.secure for identified proper index
>=20
> This prevents the assertion while still providing useful debug
> output during VM shutdown errors.
>=20
> Stack trace of the original issue:
> #0  ... in raise () from /lib/x86_64-linux-gnu/libc.so.6
> #1  ... in abort () from /lib/x86_64-linux-gnu/libc.so.6
> #2  ... in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #3  ... in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
> #4  ... in cpu_asidx_from_attrs (cpu=3Dcpu@entry=3D0x5578ca2eb340, =
attrs=3D...)
>   at ../hw/core/cpu-sysemu.c:76
> #5  ... in cpu_memory_rw_debug (cpu=3Dcpu@entry=3D0x5578ca2eb340,
>   addr=3Daddr@entry=3D2147258348, ptr=3Dptr@entry=3D0x7f5341ca373c, =
len=3Dlen@entry=3D1,
>    is_write=3Dis_write@entry=3Dfalse) at ../softmmu/physmem.c:3529
> #6  ... in x86_cpu_dump_state (cs=3D0x5578ca2eb340,
>   f=3D0x7f53434065c0 <_IO_2_1_stderr_>, flags=3D<optimized out>)
>   at ../target/i386/cpu-dump.c:560
> #7  ... in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x5578ca2eb340)
>   at ../accel/kvm/kvm-all.c:3000
> #8  ... in kvm_vcpu_thread_fn (arg=3Darg@entry=3D0x5578ca2eb340)
>   at ../accel/kvm/kvm-accel-ops.c:51
> #9  ... in qemu_thread_start (args=3D<optimized out>)
>   at ../util/qemu-thread-posix.c:505
> #10 ... in start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
> #11 ... in clone () from /lib/x86_64-linux-gnu/libc.so.6
>=20
> Signed-off-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
> ---
> target/i386/cpu.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c51e0a43d0..2616a61c87 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2507,7 +2507,7 @@ void cpu_sync_avx_hflag(CPUX86State *env);
> #ifndef CONFIG_USER_ONLY
> static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
> {
> -    return !!attrs.secure;
> +    return cs->num_ases =3D=3D 1 ? 0 : (!!attrs.secure);
> }
>=20
> static inline AddressSpace *cpu_addressspace(CPUState *cs, MemTxAttrs =
attrs)
> --=20
> 2.43.0
>=20


