Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E13BCFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRbq-0008Nk-Ac; Tue, 02 Dec 2025 09:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1vQRbo-0008NO-UO
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:44:04 -0500
Received: from mail1.hostfission.com ([51.161.137.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1vQRbm-0005TL-RR
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1764686638;
 bh=wBp/ocBpq9l9oNV247pkM8xFoIhdFdaloQkk8+ldNYQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bNmsXxvM+zXRKd7QoAeENjg0jXr6vuZWsAe/2HKB+zLfKdUAfQO/NHpJix35Hwzxm
 zoHLuAFcxmem6Nta7oOnbqIQhSJeTWxkwSS1Kx6WO0Q73lJKvzs4XdESkhvXdeMBVi
 L6TAbSBEtnnf5UiQA72EogSBMqc9TpV19ksVTqlk=
Received: from www1.hostfission.com (www1.hostfission.com [51.161.137.49])
 by mail1.hostfission.com (Postfix) with ESMTP id A050D5401E3;
 Wed,  3 Dec 2025 01:43:58 +1100 (AEDT)
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 83982602FA0;
 Wed,  3 Dec 2025 01:43:58 +1100 (AEDT)
MIME-Version: 1.0
Date: Wed, 03 Dec 2025 01:43:58 +1100
From: Geoffrey McRae <geoff@hostfission.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Ratchov <alex@caoua.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth
 <huth@tuxfamily.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 dirty.ice.hu@gmail.com, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
In-Reply-To: <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <aS4BZZnzQPUHzbaD@vm3.arverb.com>
 <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
 <20e6b7a1-cc84-29ff-6570-94fed9520466@eik.bme.hu>
 <d63b9773727b546cea38b1f17e0babd0@hostfission.com>
 <CAMxuvayp1WiqWe40Ox69DQ+R0X3VrJ_ai001Z04KbEouFGwCjg@mail.gmail.com>
 <12d3c2d298399c0935edee8caa3e52aa@hostfission.com>
 <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
Message-ID: <c32f11e604bbcd86d1c2c9d2b4b57d5a@hostfission.com>
X-Sender: geoff@hostfission.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.161.137.76; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 2025-12-03 01:14, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Dec 2, 2025 at 5:26 PM Geoffrey McRae <geoff@hostfission.com> 
> wrote:
>> 
>> 
>> 
>> On 2025-12-02 23:44, Marc-André Lureau wrote:
>> > Hi Geoffrey
>> >
>> > On Tue, Dec 2, 2025 at 4:31 PM Geoffrey McRae
>> > <geoff@hostfission.com> wrote:
>> >
>> >> The PipeWire and PulseAudio backends are used by a large number of
>> >> users
>> >> in the VFIO community. Removing these would be an enormous determent
>> >> to
>> >> QEMU.
>> >
>> > They come with GStreamer pulse/pipe elements.
>> 
>> Yes, but through another layer of abstraction/complexity with no real
>> benefit.
> 
> The benefit is that QEMU would not have to maintain 10 backends and
> all the audio mixing/resampling. The QEMU code would be simpler and
> more maintainable overall. GStreamer has a clear pipeline design,
> better suited (optimized code etc) and you can easily modify the
> pipeline settings.

Yes, I suppose I can see it from that point of view provided that the 
advanced features of GStreamer, such as user defined audio graphs, are 
never exposed to the user to configure. I can just imagine the false bug 
report nightmare this would induce (buggy plugins, etc).

> 
>> 
>> >
>> >> Audio output from QEMU has always been problematic, but with the
>> >> PulseAudio and later, the PipeWire interface, it became much more
>> >> user
>> >> friendly for those that wanted to configure the VM to output native
>> >> audio into their sound plumbing.
>> >
>> > Could you be more specific?
>> 
>> There are clock sync/drift issues with the emulated hardware device's
>> audio clock and the real hardware audio clock. GStreamer won't solve
>> this, it requires a tuned PID loop that resamples the audio to
>> compensate for the continual drift between the emulated and hardware
>> clocks. Without this, over time, the audio can and does get wildly out
>> of sync eventually resulting in xruns.
> 
> That's indeed a complicated subject and hard to test & measure. Adding
> some testing to our audio infra should help identify this better. Not
> sure when time permits though.
> 
> It seems to me that the current QEMU audio code is using the
> virtual/system clock timer to pull the data at a regular pace, which
> is not in sync with the actual audio sink clock. The GStreamer
> pipeline, otoh, uses the audio sink clock. But there are other
> emulated devices related issues (like hda not sending data when asked,
> or later, it has to be pulled regularly etc). I need to study this in
> more detail, this GStreamer implementation is a bit naive there.
> 

Yes, this is the primary issue here. I believe that solving this is more 
complicated then it appears however as headless systems that are using 
SPICE for audio wont have an audio clock to sync to.

> 
>> 
>> All you have to do is google for "QEMU Crackling Sound". JACK, 
>> PipeWire
>> and PulseAudio manage to mostly hide (not sovle) this issue from the
>> user, but it still occurs. It's worse for SPICE clients as the audio
>> gets buffered in the network stack rather then dropped and can lead to
>> many seconds of audio latency.
> 
> Yes, I think synchronization of audio/video playback for remoting is
> another issue, if QEMU has the audio & video frames in sync which can
> provide correct timestamps.

Note that I am referring to a SPICE client that only subscribes to the 
audio stream and not video, as is the case for Looking Glass as it uses 
an out of band mechanism to obtain the passthrough GPUs output. This is 
also occurs on the local host via a unix socket.

I do not think this aspect can be solved in QEMU, but rather must be 
solved in the SPICE client

See here if you're interested how we did this:
https://github.com/gnif/LookingGlass/blob/53bfb6547f2b7abd6c183192e13a57068c1677ea/client/src/audio.c

> 
>> 
>> As for applications, we have a large number of people using QEMU/KVM
>> with full GPU pass-through for gaming workloads, many of which route 
>> the
>> QEMU audio into PipeWire/JACK directly which enables the host's sound
>> server to perform DSP and mixing, etc.
>> 
>> Others are streaming the guest via Looking Glass for the video feed, 
>> and
>> using PipeWire from QEMU to feed into OBS for live streaming setups.
>> 
>> The flexibility that JACK & PipeWire bring to the table can not be
>> overstated. From a maintenance point of view, JACK and PipeWire are 
>> only
>> ~800 lines of code each, fully self contained and very easy to debug.
>> 
>> All the audio processing/mixing/resampling/routing (and any user
>> configured DSP) is fully offloaded to the host's audio server, where 
>> it
>> should be.
> 
> (by default QEMU is still doing resampling & mixing, and adds extra 
> buffering)
> 
> A GStreamer backend should not be incompatible with those use cases.
> 

In that case, i'd suggest that if possible the GStreamber back end 
maintains the same port and node names it presents to Jack/PipeWire to 
make the transition from the other audio backends to GStreamer as 
painless as possible.

> [..]
>> deprecated, I really think that effort should be put into implementing 
>> a
>> WASAPI backend for QEMU.
>> 
>> I really do not think that adding all the complexity of GStreamer to
>> QEMU is the right way forward. We should just hand off the audio
>> processing to the host system's sound server (as we do already),
>> whatever it might be, and let it do the heavy lifting.
> 
> I agree with the goal that we should leave most of the work to the
> host, and not have to do audio mixing resampling ourself whenever
> possible. Imho, GStreamer allows us to do that in less and cleaner
> code.

Great, as long as we don't let user's configure GStreamer's more 
advanced features its should be ok then.

