Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2492CC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4bij-00052j-QL; Thu, 10 Sep 2026 06:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4bii-00052N-CV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:09:28 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4big-0000e4-A9
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789034964; x=1789639764; i=deller@gmx.de;
 bh=kZ9ESHzuNYwd0wu4Daz72OYfJqRb8EOje2HcN5iUtKs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=c8sx1+sfsHQk5CRLQP7OihIaw9/DuudWNrV1Q8II7eKQU1m8c7UEQH6wOcRz5Lll
 I97me2LQ+7Qq0ptE8aFfBFV4zng6EiLBjk7PlNW2mwTpoOSG2kYp/sD3e4kf7CdlA
 2xiBLg3gAtVsjgJMU19FgSwhKpE1LPptH/dkWbJM7bSettq0snnBBGmyHG7G4ureu
 t+YQSx5aW6Q6L2FNe6vfr5FQRRjMEbul2eHAwh4oGyQY5Bn/Bf7nrnxKFXi8QU85v
 E5oqpOSPCFGXVNJWIzg+lpBLuh6kuxQ8ALp99OIXenWKnJJ28vAvrByg/1UL6/OKb
 3avJJX4cax1E3GzG3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpex-1wPXsi40Fj-00mOea; Thu, 10
 Sep 2026 12:09:24 +0200
Message-ID: <00a3daad-5a92-41b3-a525-6115f0ff038c@gmx.de>
Date: Thu, 10 Sep 2026 12:09:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] linux-user: madvise() on unmapped ranges should
 return ENOMEM
From: Helge Deller <deller@gmx.de>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260903142720.1467316-1-alex.bennee@linaro.org>
 <4238afee-7706-47de-9cd0-effe503a9f5d@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <4238afee-7706-47de-9cd0-effe503a9f5d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:88lR02GFZLV83B92JkPSxyhC2OrdLGarmMZSlLmxpN14LGgAzXE
 iQ1sfpAdeKZJVw4q5uv5rem4aqBsf+oU10l7qKRjY5cwkt0/LVe5YyNK4SzVI4jSaMuMsgF
 rlhzGiuU0MfThc6OCbi++kEE1EXvCm/LdOR0gF6d+0NmbpdMZ0edpb6wDKQTVEZeP5HaN3x
 0vVHh8NLdsCqWSYXCyA6g==
UI-OutboundReport: notjunk:1;M01:P0:ZrqvcpzQmqk=;68Tz1y3vNpBUW+PvnayVE/hdrHO
 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
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

On 9/9/26 23:17, Helge Deller wrote:
> Hi Alex,
>=20
> On 9/3/26 16:27, Alex Benn=C3=A9e wrote:
>> Per madvise(2) and the Linux kernel implementation (madvise_walk_vmas),
>> madvise() must validate that the requested range is currently mapped
>> and return -ENOMEM if any page in the range is unmapped.
>>
>> Add a page_check_range(start, len, PAGE_VALID) check for valid advice
>> values before proceeding with the advice actions. In addition, extend t=
he
>> tcg multiarch test linux-madvise.c to test this behaviour.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4382
>> AI-used-for: importing and validating test case
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> NOTE
>> =C2=A0=C2=A0 - again testing the minimal agents which did stop and say:
>>
>> *(Note: Per user policy, git commits are never executed automatically b=
y the agent. Please review the diff with `git diff` and commit the changes=
 if you are satisfied.)*
>>
>> =C2=A0=C2=A0 but non-the-less imported the test and wrote a crap patch =
which I
>> =C2=A0=C2=A0 have re-done dropping a load of unneeded verbosity.
>=20
>=20
> Did you test this patch?
> If yes, did it work for you?
> I'm asking, because I tried the testcase from the bug report, and
> in qemu I still get 0 (success).
Oh, this was a misconfiguration on my side.
The patch works ok!

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

