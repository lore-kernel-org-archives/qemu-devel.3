Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C437F55105
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 19:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyx64-0001cj-Ml; Sat, 07 Mar 2026 14:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vyx63-0001cW-Bm
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:13:55 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vyx61-0004NH-0F
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772910830; x=1773515630; i=deller@gmx.de;
 bh=yEAZdOO++SW+2+s7FBJr7nia1Q8978Tv3Qg6qHOGBHg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GlmWjTLEtXMCdUfVPkJjs6udbFLuCdhGivjgYFtqsRO+2hieRosDqE5xOHuoUf9l
 ejPFd9/PNHFQBrT9HSyKE2954ljb2RbVf1XcyHyJxR9aabC383cI0SIdBL2knlLfp
 BYegv5rQLCawa20kTbbcdAfYJ5rO+dkb+AmElKsk2MiFOLJunZTHh+1Rrtv3tkLbN
 03KVMLYi4VGE5t+ZRqU9rTQi/s+j01BoN3J7DuBnWIdq6rHsSC7yVhtuFdCFy6yva
 hL7qUp8r71d9z/rrETs88Q1UszV44JM3BQVHy4meF0aY/Tt+SZLEpcGmhAu8CXlZd
 W7MqpDaCQU0KO/x7Fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1vq7OI0IBk-003rTK; Sat, 07
 Mar 2026 20:13:50 +0100
Message-ID: <edf2a69e-810f-4555-bb0b-e476296377fd@gmx.de>
Date: Sat, 7 Mar 2026 20:13:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Fix mremap() with old_size == 0
To: razvan ghiorghe <razvanghiorghe16@gmail.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu
References: <20260201010436.5735-1-razvanghiorghe16@gmail.com>
 <CAK=UehLPXz9AB2tEqdYEwKH+rUrmxbPeV2W0gDo2rUuwv-X3OA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAK=UehLPXz9AB2tEqdYEwKH+rUrmxbPeV2W0gDo2rUuwv-X3OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xHFOfNI0UPUq8LHSwQpmZs+xBVjppJiZ8RqACP/4tgC3QT2khYv
 h3GcbwETrBuGl9fa3toWS7hjsG7eHs63PzSg4OT6nP6B1e82MZuhS2oL9izjcqISy8M3Ncx
 0jMZFWM9VDZpw6DqpAo/jHC9qVa7F+i3iOjRtFkAhZMBpY2L757RZrblI9JAZh0bLE5IOEL
 ZRNjvj8/Mkrn3WtxJAa5Q==
UI-OutboundReport: notjunk:1;M01:P0:+k3+Sad6Ho8=;kJNYeng/KYkZHwL5iHds8guOSeH
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

Hello Razvan,

On 3/3/26 20:01, razvan ghiorghe wrote:
> Hi,
> I'd like to kindly ping this patch. It has been a few weeks since submis=
sion and I haven't received any feedback yet.
> I'm working on getting familiar with the contribution flux. Any review, =
even brief comments on the approach would be very helpful!

First of all, I could not find the "v2" version of your patch.
It's not in the qemu mail archives, only in your mail below.
Did you sent a v2 version at all?

More importantly, I can confirm with the testcase from https://gitlab.com/=
qemu-project/qemu/-/issues/3105,
that the problem exists.
Testcase works on a physical hppa box, but fails in qemu-linux-user.

The patch seems ok, but it did not work for me.

Without your patch:
(hppa-chroot)root@p100:/# ./a.out
mremap with old_size=3D0 failed: Bad address
-> problem exists as you described.

With your patch:
(hppa-chroot)root@p100:/# ./a.out
qemu-hppa-static: ../../qemu/linux-user/mmap.c:1142: target_mremap: Assert=
ion `h2g_valid(host_addr)' failed.
Aborted  (core dumped) ./a.out

More info:
(hppa-chroot)root@p100:/# QEMU_LOG=3Dstrace ./a.out
...
7087 mmap2(NULL,4096,PROT_READ|PROT_WRITE,MAP_SHARED|MAP_ANONYMOUS,-1,0) =
=3D 0x45214000
7087 mremap(1159806976,0,8192,1,0,1159087572)
qemu-hppa-static: ../../qemu/linux-user/mmap.c:1142: target_mremap: Assert=
ion `h2g_valid(host_addr)' failed.
Aborted                    (core dumped) QEMU_LOG=3Dstrace ./a.out

Helge


> Thanks in advance,
> Razvan
>=20
> =C3=8En dum., 1 feb. 2026 la 03:08, Razvan Ghiorghe <razvanghiorghe16@gm=
ail.com <mailto:razvanghiorghe16@gmail.com>> a scris:
>=20
>     When old_size is zero and old_address refers to a shareable mapping,
>     mremap() should create a new mapping of the same pages according to =
the
>     mremap(2) man page. The MREMAP_MAYMOVE flag must be specified in thi=
s case.
>     Previously, QEMU's target_mremap() rejected this valid case with EFA=
ULT during
>     the initial validation, before checking for the special old_size =3D=
=3D 0 behaviour.
>=20
>     This patch adds proper handling for old_size =3D=3D 0:
>     - Validates that MREMAP_MAYMOVE flag is set (required by man spec)
>     - Passes the call through to the host mremap()
>     - Creates a new mapping without invalidating the original, with both
>     beeing valid and sharing the same physical memory frames.
>=20
>     Tested with the reproducer from the issue on qemu-riscv64.
>     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3105 <https:=
//gitlab.com/qemu-project/qemu/-/issues/3105>
>     Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com <mailto:r=
azvanghiorghe16@gmail.com>>
>     ---
>      =C2=A0linux-user/mmap.c | 32 ++++++++++++++++++++++++++++++++
>      =C2=A01 file changed, 32 insertions(+)
>=20
>     diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>     index 4bcfaf7894..b1a84eb60a 100644
>     --- a/linux-user/mmap.c
>     +++ b/linux-user/mmap.c
>     @@ -1117,6 +1117,38 @@ abi_long target_mremap(abi_ulong old_addr, ab=
i_ulong old_size,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EINVAL;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>      =C2=A0 =C2=A0 =C2=A0}
>     +
>     +=C2=A0 =C2=A0 if (!old_size) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(flags & MREMAP_MAYMOVE)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D EINVAL;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_lock();
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags & MREMAP_FIXED) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_addr =3D mremap(g2h_=
untagged(old_addr), old_size, new_size,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags, g2h_untagged(new_addr));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_addr =3D mremap(g2h_=
untagged(old_addr), old_size, new_size,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_addr =3D=3D MAP_FAILED) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_unlock();
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_addr =3D h2g(host_addr);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prot =3D page_get_flags(old_addr);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* For old_size zero, there is not=
hing to clear at old_addr.
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Only set the flags for the new =
mapping. They both are valid.
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 page_set_flags(new_addr, new_addr + new=
_size - 1,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0prot | PAGE_VALID, PAGE_VALID);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 shm_region_rm_complete(new_addr, new_ad=
dr + new_size - 1);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_unlock();
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return new_addr;
>     +=C2=A0 =C2=A0 }
>     +
>      =C2=A0 =C2=A0 =C2=A0if (!guest_range_valid_untagged(old_addr, old_s=
ize)) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EFAULT;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>     --=20
>     2.43.0
>=20


