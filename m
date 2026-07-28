Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077BDC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woemy-00016V-H0; Tue, 28 Jul 2026 06:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1woemr-00015N-JS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:11:51 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1woemp-0003RT-NN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785233499; x=1785838299; i=deller@gmx.de;
 bh=MbWJusUJOfrd0A0T463H37nu5wFvm7hE4P6bEP+DeY4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mVCnDmdxUAASrH4rG1cOq/q3l0EqzVKJspUKZMTNXKxK6VL4Vy9x2ePsHPDAr4JG
 6G5NPrREvAxqJ6e2dQ7j51SOGm4PWd7ohFGRe4tXBJPhrHX+CxEzPfU3rbpM0D6Yb
 IMHuiZ4AJG67nnQQwUzV2iqZeanYpz54/MKoUxPt9w6TuTmIuZ8N0zWWnkQCAHche
 fNp1BlabVclLIOI84Zz1DA1XdX5uxPVSK0qboSc8ILzoq5IBznDUzQ6vMrJ9oi0oG
 ykKzNfo4KWQ2bENbJlO4vwcaXZz7UvVTOPw4RkDcpUhDrAxeKRddp0bxEiSyM60z0
 +c8JjKLzOmW9XxGr8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bk4-1x1Iv71246-00tDSN; Tue, 28
 Jul 2026 12:11:39 +0200
Message-ID: <071e926e-afee-4b6a-80b7-b475d3284833@gmx.de>
Date: Tue, 28 Jul 2026 12:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/2] linux-user: fix guards for the fsmount(2) syscall
 series
To: Stefan Hajnoczi <stefanha@gmail.com>, Helge Deller <deller@kernel.org>,
 Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260726193636.110586-1-deller@kernel.org>
 <20260726193636.110586-3-deller@kernel.org>
 <CAJSP0QVMP8dPx4-123C8HtryogHyhcwBRdFUe5HcfGu8i2EbJg@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QVMP8dPx4-123C8HtryogHyhcwBRdFUe5HcfGu8i2EbJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4k366rARhxV5iTO5xzcNEn6kJ1ABLgvlsepCcMFNH+uJ4rruYY5
 u6eQOQFw6zRu9x0D1QlK4z4iJpma0/I+zZ32xfEJGhH0NmSjomamWuF2Td+7uTeAtQPpsMA
 IJ31nmE7oTQW7RJAvoBAQ9DsS7NIc6P121ceDpXiBKC/rYhYY/A94Zk43+wh5jhkRTMP4fw
 dPeMg3dfMyPNU27etWkXA==
UI-OutboundReport: notjunk:1;M01:P0:RSHjsGotFas=;M9tSXrVgtSWEoL1YZDlu/czg2cJ
 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
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/27/26 16:15, Stefan Hajnoczi wrote:
> On Sun, Jul 26, 2026 at 3:36=E2=80=AFPM Helge Deller <deller@kernel.org>=
 wrote:
>>
>> From: Matt Turner <mattst88@gmail.com>
>>
>> The fsopen(), fsconfig(), fsmount() and fspick() implementations are
>> guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
>> macro exists, so the guard is never true and the entire series compiles
>> out. Guests calling any of the four get -ENOSYS, which for example make=
s
>> systemd's credential setup fail with EXIT_CREDENTIALS for most units.
>>
>> The strace bits for fsconfig() have the same typo.
>=20
> Please take a look at the following CI failure:
>=20
> ../linux-user/strace.c: In function =E2=80=98print_fsconfig_cmd_name=E2=
=80=99:
> ../linux-user/strace.c:4352:10: error: =E2=80=98FSCONFIG_SET_FLAG=E2=80=
=99 undeclared
> (first use in this function)
> 4352 | case FSCONFIG_SET_FLAG:
> | ^~~~~~~~~~~~~~~~~
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/15553379213#L2358
>=20
> Once this has been fixed, please send a v2 pull request. Thanks!

I've sent a new pull request.
I added a dependency on the availability of the FSCONFIG_SET_FLAG define.
This is okay for now, but maybe a better fix is possible?

Usually this define should be available, but it doesn't seem to
be in that chroot image.
I'm sure I'm missing something, but is it somewhere documented how to get =
that chroot
image locally so that I can reproduce the problem?

Helge

