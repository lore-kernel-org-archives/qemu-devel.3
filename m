Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39437C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qPz-0000bR-DX; Thu, 24 Sep 2026 16:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1x9qPw-0000ag-Og; Thu, 24 Sep 2026 16:51:44 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1x9qPu-0005KQ-SV; Thu, 24 Sep 2026 16:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790283099; x=1790887899; i=deller@gmx.de;
 bh=dSLAZ/DyMQs4pFdXdDzz8DwVz+5OwAEufpoAdf0f5CM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=epzzMjYU+2n5vBzVwutbsVjTVSlrxbFgcXnGw0JjyqpUD5dFeTCDqAG50wE6Ul88
 bLX709JleAeCrN0nJEaPEIY/lkj+Cn84X/vmhnG+2eNqpGc8HVI7AfTIHjjIAVOck
 BBM7RotU7YCZtXDJ3BOj9UNAblsVSiVfcMGwGWWmyIvIRMrLcw0nVCgj77Mf1Lytd
 Rhewnj7hA9a4mVoKvGYT/GDnblGNjpe0nOEl3DS77euafQorVvonjdGeMoCG3syWv
 X3aAskjWdghCv4NdoupT6Fdq+L+FcxY630seep5tUBuHkLuZAjGHBJgeCY4NfyAbZ
 w39WoHidtQr7dXweYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMobO-1xQPKZ0K84-00HxOj; Thu, 24
 Sep 2026 22:51:39 +0200
Message-ID: <1ec259e8-c91e-41ca-922d-ade1254ec15a@gmx.de>
Date: Thu, 24 Sep 2026 22:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user/sh4: use the kernel's sigreturn trampoline
 sequence in the vdso
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-stable@nongnu.org
References: <20260923013700.1505113-1-mattst88@gmail.com>
 <20260923013700.1505113-2-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260923013700.1505113-2-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WJu4Ihgx9UDMQ92LSol4gbJ8tVNdGibkYwTKx5PqlMEDSF0Ha8B
 dLhEVbtYWjH3CPQ6/QV6eAWQtK1M+eHVFyr+SeZOV7Br8UDcRyjGKsdkq5pghwvKIFX3ppn
 q99EqVR9t8iM/SXOFzp2jy7D6LhZggvC93TE5wCfPBpxpHBntM/r6vXehybb2kb9r5isD/L
 36Y5hymlTC7BhfNOd4vpg==
UI-OutboundReport: notjunk:1;M01:P0:QVtOSmCxYU4=;7Y2z1eE4uXPm6fv0juyaR0TdSJo
 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
 lEA4k6MCi/Ip0sPh7hMewYpecq6+o27hjIQ==
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 9/23/26 03:36, Matt Turner wrote:
> With the vdso, default_sigreturn and default_rt_sigreturn point at
> __kernel_sigreturn and __kernel_rt_sigreturn and setup_sigtramp() is no
> longer used. The vdso trampolines load the syscall number with mov.l
> instead of the kernel's mov.w/trapa/or r0,r0 sequence, which undoes
> commit 9ac5aa7227 ("linux-user/sh4: Fix setup_sigtramp to match Linux
> kernel trampoline pattern"): libunwind's unw_is_signal_frame() no longer
> recognizes the signal frame, so unwinding through a signal handler stops
> there.
>=20
> Use the sequence from the kernel's own vdso,
> arch/sh/kernel/vsyscall/vsyscall-sigreturn.S.
>=20
> Fixes: 975bd51a88 ("linux-user/sh4: add VDSO support for sh4 and sh4eb")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/sh4/vdso-be.so | Bin 2704 -> 2720 bytes
>   linux-user/sh4/vdso-le.so | Bin 2704 -> 2720 bytes
>   linux-user/sh4/vdso.S     |  26 ++++++++++++++++++--------
>   3 files changed, 18 insertions(+), 8 deletions(-)
For the whole series:
Reviewed-by: Helge Deller <deller@gmx.de>

Series applied to the linux-user-next git tree.

Thanks!
Helge

