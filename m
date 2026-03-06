Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ADAFCC069
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybF3-0003Hr-Ep; Fri, 06 Mar 2026 14:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vybEq-0003Fj-LA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:53:33 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vybEo-0000hM-Cl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772826807; x=1773431607; i=deller@gmx.de;
 bh=8wJwC28kr0uWGS/yVGC7D75PsgynnMW1Xvizr5agvzM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ny4LGyJjwG+pTrQCsrrN797ncbG0bPQ4vdgYQQcSC0UgWm1i++XVVMAYpztocLwX
 TY5giBfnXWxgGbJuYLIbnTeArKGUqERyTfoGERBxKIdde5H2XernS0X8qbqGNw4Vl
 s13CLuNK5Luj/a1HOlrASnhDJUmOR8c/TymOUBlDRLvVGZox7w3KCoCXp3f3UVWPd
 JKH+WPunLvGqKFi+MLN0PlT+VkyQT3uEcNqu5K9QDG/vQx9+1V4hH99u4ENn37IGW
 RZRgz399dLzZ5CIARhLJGwEMHDNiZ6/4/BnzjtC41E3kGS4cV4Ex3vAIE1cI3mmCG
 CWM2d8rl8NrGK3F7RQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McY8d-1vOB5e2BIL-00izzg; Fri, 06
 Mar 2026 20:53:27 +0100
Message-ID: <edfc4472-783a-4205-acab-80f16d113784@gmx.de>
Date: Fri, 6 Mar 2026 20:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix zero_bss for RX PT_LOAD segments
To: Razvan Ghiorghe <razvanghiorghe16@gmail.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu
References: <20260202002615.27441-1-razvanghiorghe16@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260202002615.27441-1-razvanghiorghe16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:spP2O9FT2I5BmdiEKxePaEnO/4a/TfH6OfZ8O3cagrN/kSlVrIV
 9ex83ExswYuPNpU8QpcFA6K70wec3m85hHoiUeK6z7yJhuWkJsJFWpzooPmpPhfVchODTbl
 xr8aSfbwq28SqPXZMzV0cN59emAOCG+770LinNcEeJM0A6oK30dE1sRGJ/btvQizdGWIg1e
 1FnbdL1dErmJ+IGhXx4nw==
UI-OutboundReport: notjunk:1;M01:P0:N8GzGoqsWxg=;Xjk9T/bMvmj91yYFKSfuMBNQb40
 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
 M4uV5vPg=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Razvan,

On 2/2/26 01:24, Razvan Ghiorghe wrote:
> zero_bss() incorrectly assumed that any PT_LOAD containing .bss must be
> writable, rejecting valid ELF binaries where .bss overlaps the tail of
> an RX file-backed page.

A .bss section which overlaps with a RX page?
That sounds strange.
Since I wonder, if is this a real-world case or just a theoretical case,
maybe you can explain a littler further why/how you ran into that issue?

Helge
 =20
> Instead of failing, temporarily enable write access on the overlapping
> page to zero the fractional bss range, then restore the original page
> permissions once initialization is complete.
>=20
> To validate the correctness of the modified zero_bss() implementation,
> two targeted test cases were constructed, designed to exercise the edge =
cases where
> the .bss segment overlaps a partially filled virtual memory page belongi=
ng to a
> R_X region. The test binaries were intentionally built without a main() =
function
> and instead defined a custom ELF entry-point via the _start symbol.
> This approach bypasses CRT, dynamic loader, libc initialization etc. ens=
uring that
> execution begins immediately after QEMU completes ELF loading and memory=
 mapping.
>=20
> The first binary defines a minimal _start routine and immediately termin=
ates
> via a system call, without ever referencing the .bss symbol. Although a =
.bss section
> is present in the ELF, it is not accessed at runtime, and the resulting =
PT_LOAD
> mapping can be established without triggering any writes to a file-backe=
d RX page.
> In this configuration, QEMU successfully loads the binary, and the loade=
r reaches
> the zero_bss() path, validating that the fractional .bss region is corre=
ctly zeroed
> without violating the original segment permissions.
>=20
> The second binary explicitly reads from the global .bss symbol (x) at pr=
ogram entry.
> This forces the linker to materialize the .bss region within the same PT=
_LOAD
> segment as the RX code, yielding a segment with p_filesz < p_memsz and f=
lags R|X.
> In this case, QEMU correctly fails during the initial file-backed mmap()=
 of the PT_LOAD
> segment, returning EINVAL. This behavior is consistent with the Linux ke=
rnel=E2=80=99s ELF
> loader semantics, which prohibit mapping a file-backed segment as RX whe=
n it (logically)
> contains writable memory. Consequently, this failure occurs before zero_=
bss()
> is reached (behaviour expected and correct).
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3179
> Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
> ---
>   linux-user/elfload.c | 38 +++++++++++++++++++++++---------------
>   1 file changed, 23 insertions(+), 15 deletions(-)
>=20
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 35471c0c9a..fa3f7cda69 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -449,18 +449,11 @@ static bool zero_bss(abi_ulong start_bss, abi_ulon=
g end_bss,
>   {
>       abi_ulong align_bss;
>  =20
> -    /* We only expect writable bss; the code segment shouldn't need thi=
s. */
> -    if (!(prot & PROT_WRITE)) {
> -        error_setg(errp, "PT_LOAD with non-writable bss");
> -        return false;
> -    }
> -
>       align_bss =3D TARGET_PAGE_ALIGN(start_bss);
>       end_bss =3D TARGET_PAGE_ALIGN(end_bss);
>  =20
>       if (start_bss < align_bss) {
>           int flags =3D page_get_flags(start_bss);
> -
>           if (!(flags & PAGE_RWX)) {
>               /*
>                * The whole address space of the executable was reserved
> @@ -472,20 +465,35 @@ static bool zero_bss(abi_ulong start_bss, abi_ulon=
g end_bss,
>                */
>               align_bss -=3D TARGET_PAGE_SIZE;
>           } else {
> +            abi_ulong start_page_aligned =3D start_bss & TARGET_PAGE_MA=
SK;
>               /*
> -             * The start of the bss shares a page with something.
> -             * The only thing that we expect is the data section,
> -             * which would already be marked writable.
> -             * Overlapping the RX code segment seems malformed.
> +             * The logical OR between flags and PAGE_WRITE works becaus=
e
> +             * in include/exec/page-protection.h they are defined as PR=
OT_*
> +             * values, matching mprotect().
> +             * Temporarily enable write access to zero the fractional b=
ss.
> +             * target_mprotect() handles TB invalidation if needed.
>                */
>               if (!(flags & PAGE_WRITE)) {
> -                error_setg(errp, "PT_LOAD with bss overlapping "
> -                           "non-writable page");
> -                return false;
> +                if (target_mprotect(start_page_aligned,
> +                                    TARGET_PAGE_SIZE,
> +                                    prot | PAGE_WRITE) =3D=3D -1) {
> +                    error_setg_errno(errp, errno,
> +                                    "Error enabling write access for bs=
s");
> +                    return false;
> +                }
>               }
>  =20
> -            /* The page is already mapped and writable. */
> +            /* The page is already mapped and now guaranteed writable. =
*/
>               memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
> +
> +            if (!(flags & PAGE_WRITE)) {
> +                if (target_mprotect(start_page_aligned,
> +                                    TARGET_PAGE_SIZE, prot) =3D=3D -1) =
{
> +                    error_setg_errno(errp, errno,
> +                                    "Error restoring bss first permissi=
ons");
> +                    return false;
> +                }
> +            }
>           }
>       }
>  =20


