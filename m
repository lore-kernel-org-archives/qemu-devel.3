Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B81ECD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRlY-0005W7-6G; Tue, 19 May 2026 17:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wPRlW-0005VI-IY; Tue, 19 May 2026 17:14:14 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wPRlU-0004Xy-MJ; Tue, 19 May 2026 17:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779225237; x=1779830037; i=deller@gmx.de;
 bh=b910me0mJRWumnqLIiqIk5eUDsB/7MavmDU9x7KX/6A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=h6jOtAmmwSlACn2+l0D8Kqs0vTAOKP+E8sVVZWldC83/hfB5aruWi1b/+mpSVhBF
 07oYZQkLq6V75WD6kdWIWMJiydEclB7B6zEQ3YbqZLdbG7OCki/bckYpHgNfYlS9e
 hRt1Ru2gcQ9frKqgjp82VSORd1Lz2IRWkMnLB1UZVx97wp8plye+ofMgxjR3Xqro9
 Zq7hvrgzx8BapmGyAPf5FJtP/rpCBXEJsp404rjSoMCjSwV734zWrB7jifULGFPZe
 1vtVJ3rlDPq0celyJJGOv4pya2NP+JmOha3ElzJc3nOup5QYNWLfTwdeZlNeTSECj
 134LUV4ZYuE34c6Pyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1whWbv0Tz8-00NmS2; Tue, 19
 May 2026 23:13:57 +0200
Message-ID: <f453c71a-2499-45aa-8194-782af5306b8c@gmx.de>
Date: Tue, 19 May 2026 23:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix AT_EXECFN in AUXV for symlinked programs
To: Michael Tokarev <mjt@tls.msk.ru>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20260501111854.15674-1-deller@kernel.org>
 <aa716453-1383-4f14-a90f-7e91cdef6964@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aa716453-1383-4f14-a90f-7e91cdef6964@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5twKpMRPhdleL6mT1bBLV2C2ikJ04nLUQmYia4XjNHy33l9xn0
 G24jljWL31hjCiUh+wijJ+Sgps1gqaG17rFf3Kv+g6OoJbXTU1jbGV10Z3aopDwzkDBrqQv
 cYRFZbp+okXeUjIuU5Sbi3QCpQYzsWhCH+G2lcgFvvUzIXBQYdHHxPsBImwI7bbO2RSWs9I
 WlYq3lea2Ck8XFFaPBQwA==
UI-OutboundReport: notjunk:1;M01:P0:+GeeNUorAyo=;bdbWEizmwVJ7WSSvHkR4llmjMEw
 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
 l+seSahrSRuBTLpMtzY02+QyN58=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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

On 5/19/26 22:55, Michael Tokarev wrote:
> On 01.05.2026 14:18, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> The AT_EXECFN entry in AUXV needs to keep the value which was used when
>> the program was started. Especially for symlinked programs qemu should
>> not try to resolve the realpath.
>>
>> Here is a reproducer:
>> (arm64-chroot)root@p100:/# cd /usr/bin
>> (arm64-chroot)root@p100:/usr/bin# ln -s echo testprog
>> (arm64-chroot)root@p100:/usr/bin# LD_SHOW_AUXV=3D1 ./testprog | grep AT=
_EXECFN
>> AT_EXECFN:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ./testprog
>>
>> In this example, "./testprog" is the correct output, and not "/usr/bin/=
echo".
>>
>> This patch fixes parts of commit 258bec39 ("linux-user: Fix access to
>> /proc/self/exe").
>>
>> Fixes: 258bec39 ("linux-user: Fix access to /proc/self/exe")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3379
>> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
>> --- a/linux-user/user-internals.h
>> +++ b/linux-user/user-internals.h
>> @@ -24,6 +24,7 @@
>> =C2=A0 #include "exec/translation-block.h"
>> =C2=A0 extern char *exec_path;
>> +extern char real_exec_path[PATH_MAX];
>=20
> btw, why this is not char*, allocated dynamically?

no specific reason.
 =20
> I'm picking this up for qemu-stable.=C2=A0 Please let me know if I shoul=
dn't.

Please pick up.

Thanks!
Helge

