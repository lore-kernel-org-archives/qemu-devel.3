Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F193D2E9E4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 12:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tATjj-000268-Lv; Mon, 11 Nov 2024 07:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tATjJ-0001u7-4a; Mon, 11 Nov 2024 07:41:18 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tATjH-0003Zq-08; Mon, 11 Nov 2024 07:41:16 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 013F34E6001;
 Mon, 11 Nov 2024 13:41:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Y4HK22FdUUOH; Mon, 11 Nov 2024 13:41:04 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A24E54E6000; Mon, 11 Nov 2024 13:41:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9F222746F60;
 Mon, 11 Nov 2024 13:41:04 +0100 (CET)
Date: Mon, 11 Nov 2024 13:41:04 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Phil Dennis-Jordan <phil@philjordan.eu>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com, 
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com, 
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn, 
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com, 
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v8 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
In-Reply-To: <CAAibmn2+pT_kpcdHd26KsFggRNRR3yPep11fToOK=GZ9AEDHpw@mail.gmail.com>
Message-ID: <e08017b1-5b38-f482-5534-cea4dcc0f000@eik.bme.hu>
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-2-phil@philjordan.eu>
 <9c2e0b96-2125-4041-9f66-116d54accb04@daynix.com>
 <CAAibmn3NbtOEwWLQFOo_UmAGTehOj+dDP04A=-JGMZVK9AYMDw@mail.gmail.com>
 <ZzHJgAbBJZYrSt84@redhat.com>
 <CAAibmn2+pT_kpcdHd26KsFggRNRR3yPep11fToOK=GZ9AEDHpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-1363951794-1731328864=:607"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1363951794-1731328864=:607
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 11 Nov 2024, Phil Dennis-Jordan wrote:
> On Mon, 11 Nov 2024 at 10:08, Daniel P. Berrangé <berrange@redhat.com>
> wrote:
>
>> On Sun, Nov 10, 2024 at 08:08:16AM +0100, Phil Dennis-Jordan wrote:
>>> On Sun 10. Nov 2024 at 08:01, Akihiko Odaki <akihiko.odaki@daynix.com>
>>> wrote:
>>>
>>>> On 2024/11/08 23:46, Phil Dennis-Jordan wrote:
>>>>> macOS's Cocoa event handling must be done on the initial (main)
>> thread
>>>>> of the process. Furthermore, if library or application code uses
>>>>> libdispatch, the main dispatch queue must be handling events on the
>> main
>>>>> thread as well.
>>>>>
>>>>> So far, this has affected Qemu in both the Cocoa and SDL UIs,
>> although
>>>>> in different ways: the Cocoa UI replaces the default qemu_main
>> function
>>>>> with one that spins Qemu's internal main event loop off onto a
>>>>> background thread. SDL (which uses Cocoa internally) on the other
>> hand
>>>>> uses a polling approach within Qemu's main event loop. Events are
>>>>> polled during the SDL UI's dpy_refresh callback, which happens to run
>>>>> on the main thread by default.
>>>>
>>>> GTK should also do the same as SDL and requires treatment; I forgot to
>>>> note that in previous reviews.
>>>
>>>
>>> Although it‘s possible to build Qemu with GTK support enabled on macOS,
>>> that UI doesn’t actually work on macOS at all, and apparently hasn’t been
>>> supported since 2018, see:
>>> https://stackoverflow.com/a/51474795
>>>
>>> I don’t think there’s any point making adjustments to the GTK code by
>>> guessing what might be needed if someone did fix that to work with macOS
>> at
>>> some point.
>>
>> If we don't support GTK on macOS, then we should update meson.build
>> to actively prevent users enabling GTK on macOS builds, rather than
>> letting them suffer random runtime crashes.
>>
>>
> Agreed - I'm now more confused than ever though because
> https://gitlab.com/qemu-project/qemu/-/issues/2539 sort of implies that
> Philippe has previously been using it successfully. Or perhaps this was
> created in response to https://gitlab.com/qemu-project/qemu/-/issues/2515 ?
> But it seems like even the SDL implementation isn't perfect:
> https://gitlab.com/qemu-project/qemu/-/issues/2537
>
> Basically, it seems like Qemu's UI threading on macOS is currently a bit of
> a mess, except in the Cocoa UI.

Maybe it worked with older MacOS X releases but broke around the same time 
when commit 5588840ff77800 was needed to fix the cocoa UI? Maybe gtk needs 
a similar fix or whatever cocoa was changed to use since somewhere in gtk 
or QEMU?

Also I find it strange to require UI backends to NULL init a global. If 
the cocoa UI is the only one that needs it could that also set it instead 
of doing it in /system? That would also confine macOS specific code to 
cocoa.m and the other UIs would not need any change that way.

Regards,
BALATON Zoltan
--3866299591-1363951794-1731328864=:607--

