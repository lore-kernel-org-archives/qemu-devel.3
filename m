Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5286FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoiS-0000nS-GT; Thu, 09 Jul 2026 09:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1whoiQ-0000kl-94; Thu, 09 Jul 2026 09:22:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1whoiN-0006Ma-Cq; Thu, 09 Jul 2026 09:22:58 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C3F3759673B;
 Thu, 09 Jul 2026 15:22:43 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id TuaZ3GDGXGeP; Thu,  9 Jul 2026 15:22:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A7471596747; Thu, 09 Jul 2026 15:22:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A3A5F596746;
 Thu, 09 Jul 2026 15:22:41 +0200 (CEST)
Date: Thu, 9 Jul 2026 15:22:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: A few Machines crash when "no default audio driver available"
In-Reply-To: <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
Message-ID: <541af191-0693-b268-beed-a326e0fd515f@eik.bme.hu>
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 9 Jul 2026, Peter Maydell wrote:
> On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> I stumbled over ARM machine musicpal, PPC machines pegasos1, pegasos2,
>> and MIPS machine fuloong2e crashes.
>>
>> I run them like this:
>>
>> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -monitor stdio
>
>> Died when device_set_realized() tried to propagate a "no default audio
>> driver available" error to &error_abort.
>
> Is this something we want to have be a possibility the devices
> have to cope with? Can we have the "ignores all audio data"
> backend be always available instead?
>
> Otherwise every audio device needs to cope with "there is no
> audio backend available" and implement "do nothing with the
> audio data" itself.

I think the "no default audio driver available" error was returned from 
the device but it was not propagated properly somewhere around 
error_handle to become an error message to abort with so it's not 
something the devices should care about but some problem in error 
handling. Without -nodefaults there is a default audio device so this does 
not happen but with -nodefaults you need to specify one explicitly. I 
think the question is why the error is not propagated and exited with on 
error_abort instead of crashing and is not something specific to these 
devices or machines which are just reproducers of the error handling 
issue.

Regards,
BALATON Zoltan

