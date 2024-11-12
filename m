Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E40D41D44
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 01:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAg3k-0003qs-Gs; Mon, 11 Nov 2024 20:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tAg3e-0003pK-9f; Mon, 11 Nov 2024 20:51:06 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tAg3Z-0001sM-J9; Mon, 11 Nov 2024 20:51:05 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 74B2B4E6001;
 Tue, 12 Nov 2024 02:50:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id wARPds8jdvKh; Tue, 12 Nov 2024 02:50:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 170FD4E6000; Tue, 12 Nov 2024 02:50:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 114FC746F60;
 Tue, 12 Nov 2024 02:50:54 +0100 (CET)
Date: Tue, 12 Nov 2024 02:50:54 +0100 (CET)
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
In-Reply-To: <CAAibmn2MPxgB+HQPMz_U=1LEeg8GzQEovKzoLe-gYRYv9EX89A@mail.gmail.com>
Message-ID: <a1d15bf8-68b1-2650-daa5-1595d9d4b8e9@eik.bme.hu>
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-2-phil@philjordan.eu>
 <9c2e0b96-2125-4041-9f66-116d54accb04@daynix.com>
 <CAAibmn3NbtOEwWLQFOo_UmAGTehOj+dDP04A=-JGMZVK9AYMDw@mail.gmail.com>
 <ZzHJgAbBJZYrSt84@redhat.com>
 <CAAibmn2+pT_kpcdHd26KsFggRNRR3yPep11fToOK=GZ9AEDHpw@mail.gmail.com>
 <e08017b1-5b38-f482-5534-cea4dcc0f000@eik.bme.hu>
 <CAAibmn2MPxgB+HQPMz_U=1LEeg8GzQEovKzoLe-gYRYv9EX89A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-323661804-1731376254=:34944"
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

--3866299591-323661804-1731376254=:34944
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 11 Nov 2024, Phil Dennis-Jordan wrote:
> On Mon, 11 Nov 2024 at 13:41, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Mon, 11 Nov 2024, Phil Dennis-Jordan wrote:
>>> On Mon, 11 Nov 2024 at 10:08, Daniel P. Berrangé <berrange@redhat.com>
>>> wrote:
>>>
>>>> On Sun, Nov 10, 2024 at 08:08:16AM +0100, Phil Dennis-Jordan wrote:
>>>>> On Sun 10. Nov 2024 at 08:01, Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> wrote:
>>>>>
>>>>>> On 2024/11/08 23:46, Phil Dennis-Jordan wrote:
>>>>>>> macOS's Cocoa event handling must be done on the initial (main)
>>>> thread
>>>>>>> of the process. Furthermore, if library or application code uses
>>>>>>> libdispatch, the main dispatch queue must be handling events on the
>>>> main
>>>>>>> thread as well.
>>>>>>>
>>>>>>> So far, this has affected Qemu in both the Cocoa and SDL UIs,
>>>> although
>>>>>>> in different ways: the Cocoa UI replaces the default qemu_main
>>>> function
>>>>>>> with one that spins Qemu's internal main event loop off onto a
>>>>>>> background thread. SDL (which uses Cocoa internally) on the other
>>>> hand
>>>>>>> uses a polling approach within Qemu's main event loop. Events are
>>>>>>> polled during the SDL UI's dpy_refresh callback, which happens to run
>>>>>>> on the main thread by default.
>>>>>>
>>>>>> GTK should also do the same as SDL and requires treatment; I forgot to
>>>>>> note that in previous reviews.
>>>>>
>>>>>
>>>>> Although it‘s possible to build Qemu with GTK support enabled on macOS,
>>>>> that UI doesn’t actually work on macOS at all, and apparently hasn’t
>> been
>>>>> supported since 2018, see:
>>>>> https://stackoverflow.com/a/51474795
>>>>>
>>>>> I don’t think there’s any point making adjustments to the GTK code by
>>>>> guessing what might be needed if someone did fix that to work with
>> macOS
>>>> at
>>>>> some point.
>>>>
>>>> If we don't support GTK on macOS, then we should update meson.build
>>>> to actively prevent users enabling GTK on macOS builds, rather than
>>>> letting them suffer random runtime crashes.
>>>>
>>>>
>>> Agreed - I'm now more confused than ever though because
>>> https://gitlab.com/qemu-project/qemu/-/issues/2539 sort of implies that
>>> Philippe has previously been using it successfully. Or perhaps this was
>>> created in response to
>> https://gitlab.com/qemu-project/qemu/-/issues/2515 ?
>>> But it seems like even the SDL implementation isn't perfect:
>>> https://gitlab.com/qemu-project/qemu/-/issues/2537
>>>
>>> Basically, it seems like Qemu's UI threading on macOS is currently a bit
>> of
>>> a mess, except in the Cocoa UI.
>>
>> Maybe it worked with older MacOS X releases but broke around the same time
>> when commit 5588840ff77800 was needed to fix the cocoa UI? Maybe gtk needs
>> a similar fix or whatever cocoa was changed to use since somewhere in gtk
>> or QEMU?
>>
>
> Possible! Calling the Cocoa UI APIs from anything other than the main
> thread has never officially been supported as far as I'm aware, but perhaps
> some subset silently worked on earlier releases. Modern versions definitely
> enforce the rule to some extent.
>
> Also I find it strange to require UI backends to NULL init a global. If
>> the cocoa UI is the only one that needs it could that also set it instead
>> of doing it in /system? That would also confine macOS specific code to
>> cocoa.m and the other UIs would not need any change that way.
>>
>
> Well, that's the whole point, it's not just the Cocoa UI - other macOS
> system frameworks also need a runloop or libdispatch to be handling events
> on thread 0. Relevant here are the ParavirtualizedGraphics.framework that's
> integrated with patches 2-4 from this patch set, as well as the
> Metal.framework, which PVG uses internally, and which we need to use
> directly to some extent to complete the generated guest frames. These
> frameworks internally use libdispatch, and they just don't work if nothing
> is processing events on the main dispatch queue/runloop. So without patch
> 01/16, PV graphics will only work in conjunction with Cocoa or SDL, because
> those do process the runloop on the main thread. But if you were to run
> with -nographic, or VNC/SPICE-only, Mac PV graphics just wouldn't work. So
> the idea is to uncouple the main thread's runloop from the Cocoa UI.

OK, I think I got that now.

> An then, the GTK+ and SDL libraries themselves call down into Cocoa on
> macOS. Windows also has specific rules about its Win32 UI API and
> threading. SDL says outright that everything needs to be done from the main
> thread. GTK+ says everything needs to be called from a single thread on
> Win32; it seems like the rule on macOS is the same, except that thread must
> be thread 0. Both those UIs in Qemu seem to violate the threading rules of
> the libraries they integrate, as evidenced by the bug reports listed above.
> This brokenness is entirely independent of this patch set here, it's just
> that we're bumping up against the same underlying issue of needing runloop
> handling on thread 0 in macOS.
>
> With regard to NULL'ing the qemu_main function pointer from the SDL or GTK
> UIs in Qemu: I had implemented a different approach to solving the problem
> in v4, where each UI declared up-front what kind of threading arrangement
> it needed rather than each one just overwriting a global variable. This was
> somewhat more complex than the current one though.
> https://patchew.org/QEMU/20241024102813.9855-1-phil@philjordan.eu/20241024102813.9855-2-phil@philjordan.eu/

That does not seem to be better than the current version.

> Ultimately, it seems like someone needs to take a look at the SDL and GTK
> integrations in Qemu and rework them in a way that doesn't violate the SDL
> and GTK+ libraries' own threading rules. Once we've figured out what
> requirements fall out of that, we can tidy up the qemu_main arrangement.
>
> But that's an undertaking that's out of scope for this patch - I see the
> current patch as a step towards a global solution to the problem.
> Definitely not the last word on the matter, but at least starting to get
> away from the situation where each UI does whatever it wants with zero
> regard for the rest of the code base.

Agreed. As long as it's not more broken than it is already, i.e. the 
current behaviour is preserved, that should be good enough but I'm not a 
maintainer who has a word in this so that's just my opinion. Then maybe 
you could add a comment when the global variable needs to be set to NULL 
to note that this may not be the correct way and some hint of the above 
that this may need fixing later. I think we don't have a graphics 
maintainer at the moment who has time to look at this so then at least 
leave a comment to help whoever comes later who wants to fix this 
eventually.

Regards,
BALATON Zoltan
--3866299591-323661804-1731376254=:34944--

