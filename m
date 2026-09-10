Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DFEC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4bvg-0007ZL-Kr; Thu, 10 Sep 2026 06:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4bve-0007Yy-Q5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:22:50 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4bvc-0003uX-LI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789035762; x=1789640562; i=deller@gmx.de;
 bh=RqnT0iyIiGKy1lW5/MivCWOVY/HpUu2wS27b0l3SUEs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LHtzJsZ3BH7/Xlt2TPKQp6AJgvyF8ErnIgNkUpbAa/1RBuFdpIdkbCbZO+NfNEuH
 u1CzMhHXu7+DMCk3v82iFgKkF2r68vp6mPdMLQz/HcK5l89T25RFD80MSwSpdGG2T
 algTLFN/xHrM+F+IQGdrAYGeqlHu/6TfCeGN8tMdJKdeGKCL1lGZkPPX33qhn6J/I
 11eVAfIWVPZ6cXYpz4r/4TFAvwPHcmPF8LeYR1OVr/ZRlyWhBu8j5fwATBkVoEGU7
 /4u7XGcLeIoPtlr31lXAgXz1B80B/asQa9w46/27oHAjEwgJrI9QXLO6vy0OVh9Cm
 JchnCpPKsfsy4UH9LA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUUm-1wUEMo1I68-00iqSS; Thu, 10
 Sep 2026 12:22:42 +0200
Message-ID: <976bdd4a-c416-4cd1-bbca-cf1ae5a9d9f8@gmx.de>
Date: Thu, 10 Sep 2026 12:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] linux-user: madvise() on unmapped ranges should
 return ENOMEM
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260903142720.1467316-1-alex.bennee@linaro.org>
 <4238afee-7706-47de-9cd0-effe503a9f5d@gmx.de>
 <878q599zs8.fsf@draig.linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <878q599zs8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A3I3/bti3GxBSbq4e6ggCW0juBnXrGuNaZg1ivm7bm+MCN89xae
 DdSLYxgqW02Aja1iWxQvzAdJxlKbBi1QllqTLMmdMDFVOnzIBlEDO4qdpMROUu/yvVpXTpv
 h/Qi+oE6uVFRCH4r20M8VEPFqc+2yojVr4JBduCG8mVzRuLWWCUaOvHi3OFN+S92UhyIXwP
 jbReDlfKdDgN+82mbpjEw==
UI-OutboundReport: notjunk:1;M01:P0:94Qa9xGcRtM=;snNTGmZ8W7R2u+VyiMlvRWL8Usj
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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

On 9/10/26 12:16, Alex Benn=C3=A9e wrote:
> Helge Deller <deller@gmx.de> writes:
>=20
>> Hi Alex,
>>
>> On 9/3/26 16:27, Alex Benn=C3=A9e wrote:
>>> Per madvise(2) and the Linux kernel implementation (madvise_walk_vmas)=
,
>>> madvise() must validate that the requested range is currently mapped
>>> and return -ENOMEM if any page in the range is unmapped.
>>> Add a page_check_range(start, len, PAGE_VALID) check for valid
>>> advice
>>> values before proceeding with the advice actions. In addition, extend =
the
>>> tcg multiarch test linux-madvise.c to test this behaviour.
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4382
>>> AI-used-for: importing and validating test case
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>> NOTE
>>>     - again testing the minimal agents which did stop and say:
>>> *(Note: Per user policy, git commits are never executed
>>> automatically by the agent. Please review the diff with `git diff`
>>> and commit the changes if you are satisfied.)*
>>>     but non-the-less imported the test and wrote a crap patch which I
>>>     have re-done dropping a load of unneeded verbosity.
>>
>>
>> Did you test this patch?
>> If yes, did it work for you?
>=20
> Yes - ran the test case before and after the changes and it asserts
> before.

Yes, sorry, as mentioned in earlier mail, it was a misconfiguration on my =
side.

>    ./qemu-aarch64 -strace -d guest_errors,unimp aarch64-linux-user-linux=
-madvise.test
>    681364 uname(0x7f403e54d3c8) =3D 0
>    681364 brk(NULL) =3D 0x00000000004a7000
>    681364 brk(0x00000000004a7b00) =3D 0x00000000004a7b00
>    681364 set_tid_address(0x4a70f0) =3D 681364
>    681364 set_robust_list(0x4a7100,24) =3D -1 errno=3D38 (Function not i=
mplemented)
>    681364 rseq(0x4a77c0,32,0,0xd428bc00)Unsupported syscall: 293
>     =3D -1 errno=3D38 (Function not implemented)
>    681364 prlimit64(0,RLIMIT_STACK,NULL,0x00007f403e54d518) =3D 0 ({rlim=
_cur=3D8388608,rlim_max=3D-1})
>    681364 readlinkat(AT_FDCWD,"/proc/self/exe",0x00007f403e54c4a0,4096) =
=3D 73
>    681364 getrandom(0x4a6808,8,1) =3D 8
>    681364 brk(NULL) =3D 0x00000000004a7b00
>    681364 brk(0x00000000004c8b00) =3D 0x00000000004c8b00
>    681364 brk(0x00000000004c9000) =3D 0x00000000004c9000
>    681364 mprotect(0x000000000049b000,20480,PROT_READ) =3D 0
>    681364 mmap(NULL,4096,PROT_READ,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) =3D 0=
x00007f40405f2000
>    681364 mprotect(0x00007f40405f2000,4096,PROT_READ|PROT_WRITE) =3D 0
>    681364 madvise(0x00007f40405f2000,4096,MADV_DONTNEED) =3D 0
>    681364 munmap(0x00007f40405f2000,4096) =3D 0
>    681364 getrandom(0x7f403e54d360,8,1) =3D 8
>    681364 openat(AT_FDCWD,"/tmp/.cmadvisebhAABn",O_RDWR|O_CREAT|O_EXCL,0=
600) =3D 3
>    681364 unlinkat(AT_FDCWD,"/tmp/.cmadvisebhAABn",0) =3D 0
>    681364 write(3,0x7f403e54d3f7,1) =3D 1
>    681364 ftruncate(3,4096) =3D 0
>    681364 mmap(NULL,4096,PROT_READ,MAP_PRIVATE,3,0) =3D 0x00007f40405f20=
00
>    681364 mprotect(0x00007f40405f2000,4096,PROT_READ|PROT_WRITE) =3D 0
>    681364 madvise(0x00007f40405f2000,4096,MADV_DONTNEED) =3D 0
>    681364 munmap(0x00007f40405f2000,4096) =3D 0
>    681364 close(3) =3D 0
>    681364 mmap(NULL,4096,PROT_READ,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) =3D 0=
x00007f40405f2000
>    681364 munmap(0x00007f40405f2000,4096) =3D 0
>    681364 madvise(0x00007f40405f2000,4096,MADV_NORMAL) =3D 0
>    681364 write(2,0x7f403e54cbc8,128)aarch64-linux-user-linux-madvise.te=
st: /home/alex/lsrc/qemu.git/tests/tcg/multiarch/linux/linux-madvise.c:81:=
 test_unmapped: Ass =3D 128
>    681364 write(2,0x7f403e54cbc8,27)ertion `ret =3D=3D -1' failed.
>     =3D 27
>    681364 mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,=
-1,0) =3D 0x00007f40405f2000
>    681364 gettid() =3D 681364
>    681364 getpid() =3D 681364
>    681364 tgkill(681364,681364,SIGIOT) =3D 0
>    --- SIGIOT {si_signo=3DSIGIOT, si_code=3DSI_TKILL, si_pid=3D681364, s=
i_uid=3D1000} ---
>    qemu: uncaught target signal 6 (Aborted) - core dumped
>    fish: Job 1, './qemu-aarch64 -strace -d guest=E2=80=A6' terminated by=
 signal SIGABRT (Abort)
>=20
>> I'm asking, because I tried the testcase from the bug report, and
>> in qemu I still get 0 (success).
>=20
> I suspect you've been tripped up by the conversion of tests to meson as
> they now have the .test suffix.=20

No, actually I ran the test in a chroot which I set up with binfmt_misc,
and it was configured to use an outdated (v5.something) qemu version :-(

Helge

