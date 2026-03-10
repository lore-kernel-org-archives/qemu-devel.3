Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FB4FD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05h6-0008SM-DG; Tue, 10 Mar 2026 18:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w05h4-0008Rw-A0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:36:50 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w05h1-00080G-Qk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773182204; x=1773787004; i=deller@gmx.de;
 bh=JSZzJmaUSV2KkXUF1SgSNZKI4rTM8c+AlsuU8ENJ0us=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DzidtO4ZyXLew+HAhyFbbY3UQxtYim9WWNvqVb3X2LuQ7gstlgBmJ6VklxscgpLH
 nM++H4wPG4SCOP+Y+No7xb8vwmnnwovyCQ39vrRiZ2L9eOpddYBdYPUMqZDymah9C
 XQwYaE/hkpFfQiS7Q3XXif+BKnM7KWCNWnP87iLkn8AjC4OAXqL7CjqgOtiCjkEla
 bQRtwEX9m+h9xjrnPhykNl1xPlps2s5q+SdP+r4eq7+zcqrtNQeXj71VhFGNLVySF
 pTAOnoPGfHTx/fcK9ff+sVMsbCTvBjzy07dzLvmB2THVgm0F0qpzgm3/tmDAAmcbK
 lTXn/CvaPcrFMgsZCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1vU2eu0ZOm-00Zgxi; Tue, 10
 Mar 2026 23:36:44 +0100
Message-ID: <f29f610a-11ad-401d-a3c7-d58c0a828ac4@gmx.de>
Date: Tue, 10 Mar 2026 23:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix zero_bss for RX PT_LOAD segments
To: razvan ghiorghe <razvanghiorghe16@gmail.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20260202002615.27441-1-razvanghiorghe16@gmail.com>
 <edfc4472-783a-4205-acab-80f16d113784@gmx.de>
 <CAK=UehJqpN5=wkTq2x6dn4iUdcBL5_x3+VRdo43AbFnfN1b2jQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAK=UehJqpN5=wkTq2x6dn4iUdcBL5_x3+VRdo43AbFnfN1b2jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RYGapEy+pUaTVR5CORKbbob4VIj7Vo4qEPM34rTxegt3apd/AT5
 WEPIPD+gYp9VAqfbJt8Wlv8XD+JZHRyXLMLK54DffZqXu7qrpK5HGFowWYr0Arp7wq2kdj2
 9HeJk8phh5aWpq8neARGkc6KsZTCLdWA6WO+GW3z+G/0d98VaRLCGG1VmUZt2lmLx85iQht
 r06hJuzWqkfdR0eJSCHXw==
UI-OutboundReport: notjunk:1;M01:P0:0x9Ih5DzJ90=;ZBL4WNVD09l/NmyzSrfimMYH06i
 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
 XCXzYxyV5Rk
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/10/26 21:49, razvan ghiorghe wrote:
> Hello Helge,

Hello Razvan,
 =20
> This is a real-life case reported by user xtex in GitLab issue
> ( #3179) [1] who encountered an ELF binary with PT_LOAD + (PROT_READ
> | PROT_EXEC) that the Linux kernel loads successfully but QEMU
> rejects.

Well, it's just a report.
I don't see an actual real program which fails to load, just some
hand-crafted executables.

I'm not saying there isn't a problem or that you did not solved it,
but I think it's not ok to include code when there is not a real
problem which normal users would face.

> In response to Richard's feedback, I sent a follow-up patch on February =
3rd with 2 test cases that reproduce the exact ELF layout:
>=20
> test-zerobss-1 has a .bss section but never accesses it, validates that =
the loader correctly zeros the fractional .bss in an RX segment without pe=
rmission violations. test-zerobss-2 reads from multiple .bss variables and=
 exits with the sum as the exit code ( if .bss was correctly zeroed, exit =
code is 0)
>=20
> Both of them use a custom linker script that forces .text and .bss into =
the same PT_LOAD segment with FLAGS(5) =3D R|X.Note that this reply is to =
the first patch and the test cases are in the second patch sent on Februar=
y 3rd [2].

Interesting!
But again: Will normal users face this?

Helge


> Best regards,
>=20
> Razvan
>=20
>=20
> [1]: https://gitlab.com/qemu-project/qemu/-/issues/3179 <https://gitlab.=
com/qemu-project/qemu/-/issues/3179>
>=20
> [2]: https://lore.kernel.org/all/20260203073740.19913-2-razvanghiorghe16=
@gmail.com/ <https://lore.kernel.org/all/20260203073740.19913-2-razvanghio=
rghe16@gmail.com/>
>=20
> (https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg00662.html <htt=
ps://mail.gnu.org/archive/html/qemu-devel/2026-02/msg00662.html>)
>=20
>=20
>=20
> =C3=8En vin., 6 mar. 2026 la 21:53, Helge Deller <deller@gmx.de <mailto:=
deller@gmx.de>> a scris:
>=20
>     Hello Razvan,
>=20
>     On 2/2/26 01:24, Razvan Ghiorghe wrote:
>      > zero_bss() incorrectly assumed that any PT_LOAD containing .bss m=
ust be
>      > writable, rejecting valid ELF binaries where .bss overlaps the ta=
il of
>      > an RX file-backed page.
>=20
>     A .bss section which overlaps with a RX page?
>     That sounds strange.
>     Since I wonder, if is this a real-world case or just a theoretical c=
ase,
>     maybe you can explain a littler further why/how you ran into that is=
sue?
>=20
>     Helge
>=20
>      > Instead of failing, temporarily enable write access on the overla=
pping
>      > page to zero the fractional bss range, then restore the original =
page
>      > permissions once initialization is complete.
>      >
>      > To validate the correctness of the modified zero_bss() implementa=
tion,
>      > two targeted test cases were constructed, designed to exercise th=
e edge cases where
>      > the .bss segment overlaps a partially filled virtual memory page =
belonging to a
>      > R_X region. The test binaries were intentionally built without a =
main() function
>      > and instead defined a custom ELF entry-point via the _start symbo=
l.
>      > This approach bypasses CRT, dynamic loader, libc initialization e=
tc. ensuring that
>      > execution begins immediately after QEMU completes ELF loading and=
 memory mapping.
>      >
>      > The first binary defines a minimal _start routine and immediately=
 terminates
>      > via a system call, without ever referencing the .bss symbol. Alth=
ough a .bss section
>      > is present in the ELF, it is not accessed at runtime, and the res=
ulting PT_LOAD
>      > mapping can be established without triggering any writes to a fil=
e-backed RX page.
>      > In this configuration, QEMU successfully loads the binary, and th=
e loader reaches
>      > the zero_bss() path, validating that the fractional .bss region i=
s correctly zeroed
>      > without violating the original segment permissions.
>      >
>      > The second binary explicitly reads from the global .bss symbol (x=
) at program entry.
>      > This forces the linker to materialize the .bss region within the =
same PT_LOAD
>      > segment as the RX code, yielding a segment with p_filesz < p_mems=
z and flags R|X.
>      > In this case, QEMU correctly fails during the initial file-backed=
 mmap() of the PT_LOAD
>      > segment, returning EINVAL. This behavior is consistent with the L=
inux kernel=E2=80=99s ELF
>      > loader semantics, which prohibit mapping a file-backed segment as=
 RX when it (logically)
>      > contains writable memory. Consequently, this failure occurs befor=
e zero_bss()
>      > is reached (behaviour expected and correct).
>      >
>      > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3179 <htt=
ps://gitlab.com/qemu-project/qemu/-/issues/3179>
>      > Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com <mailt=
o:razvanghiorghe16@gmail.com>>
>      > ---
>      >=C2=A0 =C2=A0linux-user/elfload.c | 38 +++++++++++++++++++++++----=
=2D----------
>      >=C2=A0 =C2=A01 file changed, 23 insertions(+), 15 deletions(-)
>      >
>      > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>      > index 35471c0c9a..fa3f7cda69 100644
>      > --- a/linux-user/elfload.c
>      > +++ b/linux-user/elfload.c
>      > @@ -449,18 +449,11 @@ static bool zero_bss(abi_ulong start_bss, a=
bi_ulong end_bss,
>      >=C2=A0 =C2=A0{
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong align_bss;
>      >
>      > -=C2=A0 =C2=A0 /* We only expect writable bss; the code segment s=
houldn't need this. */
>      > -=C2=A0 =C2=A0 if (!(prot & PROT_WRITE)) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, "PT_LOAD with non-w=
ritable bss");
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
>      > -=C2=A0 =C2=A0 }
>      > -
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0align_bss =3D TARGET_PAGE_ALIGN(start_b=
ss);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0end_bss =3D TARGET_PAGE_ALIGN(end_bss);
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (start_bss < align_bss) {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags =3D page_get_fl=
ags(start_bss);
>      > -
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(flags & PAGE_RWX)) =
{
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The whol=
e address space of the executable was reserved
>      > @@ -472,20 +465,35 @@ static bool zero_bss(abi_ulong start_bss, a=
bi_ulong end_bss,
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0align_bss -=
=3D TARGET_PAGE_SIZE;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong start_page_a=
ligned =3D start_bss & TARGET_PAGE_MASK;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The start of t=
he bss shares a page with something.
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The only thing=
 that we expect is the data section,
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* which would al=
ready be marked writable.
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Overlapping th=
e RX code segment seems malformed.
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The logical OR=
 between flags and PAGE_WRITE works because
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in include/exe=
c/page-protection.h they are defined as PROT_*
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* values, matchi=
ng mprotect().
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Temporarily en=
able write access to zero the fractional bss.
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* target_mprotec=
t() handles TB invalidation if needed.
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(flags=
 & PAGE_WRITE)) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_se=
tg(errp, "PT_LOAD with bss overlapping "
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"non-writable page");
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return f=
alse;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (targ=
et_mprotect(start_page_aligned,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_PAGE=
_SIZE,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot | PAGE=
_WRITE) =3D=3D -1) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 error_setg_errno(errp, errno,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Error enab=
ling write access for bss");
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return false;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      >
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The page is already=
 mapped and writable. */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The page is already=
 mapped and now guaranteed writable. */
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(g2h_=
untagged(start_bss), 0, align_bss - start_bss);
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(flags & PAGE_WRI=
TE)) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (targ=
et_mprotect(start_page_aligned,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_PAGE=
_SIZE, prot) =3D=3D -1) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 error_setg_errno(errp, errno,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Error rest=
oring bss first permissions");
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return false;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      >
>=20


