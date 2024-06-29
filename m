Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C48C3064D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 00:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNMIf-0000Y4-P4; Fri, 28 Jun 2024 20:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sNMIZ-0000UE-Fh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 20:50:39 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sNMIX-0000VA-9f
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 20:50:38 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4W9tyF1Vygz8PbP;
 Fri, 28 Jun 2024 20:50:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=QWOTMyDBlxLLx0N7xzi/1rXhKtENvw1UMkQmgCQLGFQ=; b=RKrP92iWy7ck
 dl2WwiiQCLsZ3fjpcJ3/QbE6rluHQnwg6jGb/XlFDAS2I3CZHupM4q8Vo1chnm3i
 2IVom0o3KRowF8+sAPKhMI7qV2d5t8z+KfZOh6Q+1UKU3a7Yb7BgACfqdX1A79yH
 0qF/il9gMjb6MFIwHI/d/ImWryiO3DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=Li6
 E6kUxE0LVncbSz9MlbtZKra+DyMxoDsbSjZQeM+uhWeag1Hf7OUXhgt5wcApSxeH
 +ELxkXTaMAOOvROMWuxFk1lKxms2kGQCbHVz6bE8XMORR0TRYzg7jYbz1rhscFWf
 GmUFvMkzC5+F71k9H+ugluvZj42icGB4TgJa2G/I=
Received: from [IPV6:2001:470:b050:6:6dcd:d541:499:92d2] (unknown
 [IPv6:2001:470:b050:6:6dcd:d541:499:92d2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4W9tyD5mQWz8PbN;
 Fri, 28 Jun 2024 20:50:28 -0400 (EDT)
Message-ID: <8ffa5c64-477f-4efb-92a0-5ca4864a5d8d@comstyle.com>
Date: Fri, 28 Jun 2024 20:50:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo-ppc: Add FreeBSD support
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>
References: <Zn4ZIYX0uxwHf3I-@humpty.home.comstyle.com>
 <352a9155-206e-400b-a907-50d275f90a05@linaro.org>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <352a9155-206e-400b-a907-50d275f90a05@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
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

On 2024-06-28 12:19 p.m., Richard Henderson wrote:
> On 6/27/24 19:00, Brad Smith wrote:
>> util/cpuinfo-ppc: Add FreeBSD support
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>> With corrected sign-off.
>>
>> Also this was based on the tcg-next branch.
>>
>> =C2=A0 util/cpuinfo-ppc.c | 7 ++++++-
>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
>> index 47af55aa0c..0ad634b46f 100644
>> --- a/util/cpuinfo-ppc.c
>> +++ b/util/cpuinfo-ppc.c
>> @@ -14,6 +14,11 @@
>> =C2=A0 #=C2=A0 include "elf.h"
>> =C2=A0 # endif
>> =C2=A0 #endif
>> +#ifdef __FreeBSD__
>> +# include <machine/cpu.h>
>> +# define PPC_FEATURE2_ARCH_3_1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
>
> I assume freebsd will eventually add this bit.

Possibly. The other flags are mostly in sync with the Linux flags.
There is no Power 10 support so far.

> Perhaps better with ifndef?
I'll do so just in case.
>
>
> r~
>
>> +# define PPC_FEATURE2_VEC_CRYPTO PPC_FEATURE2_HAS_VEC_CRYPTO
>> +#endif
>> =C2=A0 =C2=A0 unsigned cpuinfo;
>> =C2=A0 @@ -28,7 +33,7 @@ unsigned __attribute__((constructor))=20
>> cpuinfo_init(void)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info =3D CPUINFO_ALWAYS;
>> =C2=A0 -#ifdef CONFIG_LINUX
>> +#if defined(CONFIG_LINUX) || defined(__FreeBSD__)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long hwcap =3D qemu_getauxval(=
AT_HWCAP);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long hwcap2 =3D qemu_getauxval=
(AT_HWCAP2);
>
>

