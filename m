Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAF6FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 14:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wH0cC-00036W-CQ; Sun, 26 Apr 2026 10:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wH0c5-000360-9c
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 10:37:38 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wH0c3-0005EV-Ee
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 10:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777214251; x=1777819051; i=deller@gmx.de;
 bh=g/bZUcF9rlU6Y0fVLFPSsjG+ysKCK1vRNESv4cVnRjE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RubE/EXjZbIXI6cR82ZVCsIcMbzJGS+BbBTdI2KZg5EpDS/3hgV5AIoCWBz4rVeV
 YaO9CImruH64/iy+5lPnZ9io9J+ZyrfPo/D3dSLUqxMR43hU2Xz01naM477kWu4tQ
 YOZtdxo6lmcloWt9YknMJCHBYaYqUKvURgt0RCjYgmtSFX5iBW8/Iz5Wpc/U3jSH1
 LdVEtMrMDX8Xz3065x7mZaBji08JMqTHkGCqKcotBfIzUQfai4ZMigYypyERY0JdG
 jxsIVNdGaVfxIqY1QYQJRJYb+q7ZEPm6UJeCOeCaGvzBzGXUmJFudTNK4MV/5tP7G
 CfhEpO6IQvAznUSLLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1wEokd20TI-00GGiS; Sun, 26
 Apr 2026 16:37:31 +0200
Message-ID: <eaa32c02-48d1-4ea5-8170-2ca29b6962a1@gmx.de>
Date: Sun, 26 Apr 2026 16:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Flush errors by using exit() instead of
 _exit() in error path
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260425144852.46590-1-deller@kernel.org>
 <CAFEAcA_hODcBVXw0TsHMXFipgh5+mwSrGEuHhCUOdtt186QP6g@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA_hODcBVXw0TsHMXFipgh5+mwSrGEuHhCUOdtt186QP6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n8TyAhZtwFJ9iQjTazj6C/muo7saz2h2JAT/zs0gxv4tectyXbV
 itOLi8Vyy9iXhK32cDG7qeAIemJKk1GidiUQWWI3Lo683IGNIi/81dq1KsSTzttVvfg25dT
 N76u2EgwK3UUO2IaWN21y3PG0NSLAjRcDJ1LyZCeruqt/N27LrylDchfx9Vo7xPPk11huJR
 jW2OZCTPLezBGvy+96XYw==
UI-OutboundReport: notjunk:1;M01:P0:rIrFRHaqO84=;IP5uMXhdw21Q9nb1QO0OKR9MfLa
 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
 ddFIJw==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

On 4/26/26 15:01, Peter Maydell wrote:
> On Sat, 25 Apr 2026 at 15:49, Helge Deller <deller@kernel.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> Qemu user mode does not properly flushes error messages related to bad
>> arguments when exiting (at least when the output is piped to a file
>> instead of running on a terminal).
>> Ensure that we always flush by using exit() instead of _exit().
>>
>> Reported by: Tobias Bergkvist
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>   linux-user/main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/main.c b/linux-user/main.c
>> index c49d1e91d2..84e110dfe9 100644
>> --- a/linux-user/main.c
>> +++ b/linux-user/main.c
>> @@ -767,7 +767,7 @@ int main(int argc, char **argv, char **envp)
>>           execfd =3D open(exec_path, O_RDONLY);
>>           if (execfd < 0) {
>>               printf("Error while loading %s: %s\n", exec_path, strerro=
r(errno));
>> -            _exit(EXIT_FAILURE);
>> +            exit(EXIT_FAILURE);
>>           }
>>       }
>=20
> How about the other _exit() further down in the function
> for the case where loader_exec() fails ? That seems like
> it would have the same problem.

I'll send a seperate patch for this one. Will then include in
next pull request series.

Thanks!
Helge

