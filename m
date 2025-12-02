Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8D0CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQPRh-00019d-JY; Tue, 02 Dec 2025 07:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1vQPRf-00019F-9L
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:25:27 -0500
Received: from mail1.hostfission.com ([51.161.137.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1vQPRc-000144-0H
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1764678314;
 bh=pM8TD8TuHWj60lVNlFno8+K1ZwO+FJWhoQTtiZNdP1I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iWENSWfNN5ie7tr4l1yjI8Hyxmg1XglPRWM7zd854p/rnHj7lxHroSDlIceozZTz9
 ha0SH0u/tdGD9iuXyaCI7kgZ8oK2YCQF21JNTDR4l6zffWA0up6vVAz1HI92eiDrQ7
 PDWkwrdONLObLKGSTC4BHbSIqW3fXGJfKjOtdwcM=
Received: from www1.hostfission.com (www1.hostfission.com [51.161.137.49])
 by mail1.hostfission.com (Postfix) with ESMTP id EEF8F54016F;
 Tue,  2 Dec 2025 23:25:13 +1100 (AEDT)
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id CFC41602FA0;
 Tue,  2 Dec 2025 23:25:13 +1100 (AEDT)
MIME-Version: 1.0
Date: Tue, 02 Dec 2025 23:25:13 +1100
From: Geoffrey McRae <geoff@hostfission.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth
 <huth@tuxfamily.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 dirty.ice.hu@gmail.com, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
In-Reply-To: <20e6b7a1-cc84-29ff-6570-94fed9520466@eik.bme.hu>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <aS4BZZnzQPUHzbaD@vm3.arverb.com>
 <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
 <20e6b7a1-cc84-29ff-6570-94fed9520466@eik.bme.hu>
Message-ID: <d63b9773727b546cea38b1f17e0babd0@hostfission.com>
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



On 2025-12-02 23:03, BALATON Zoltan wrote:
> On Tue, 2 Dec 2025, Paolo Bonzini wrote:
>> On 12/1/25 21:58, Alexandre Ratchov wrote:
>>> On Mon, Dec 01, 2025 at 10:20:49PM +0400, Marc-André Lureau wrote:
>>>>> cases. Also when using jack you'd want to have a QEMU backend for 
>>>>> it not
>>>> It would be great if people with very specific or constrained 
>>>> requirements
>>>> on qemu audio could check if the GStreamer backend fits their need.
>>> 
>>> I'm thinking mainly about their simplicity.
>>> 
>>> Dropping the system API backends would add an extra sophisticated
>>> layer (GStreamer) between the system and the program. In theory, an
>>> unlimited number of software layers may be stacked in a program, but
>>> the more layers there are, the more fragile the program tends to
>>> be. Based on my limited experience, when things went wrong, the 
>>> system
>>> backends were simpler to debug and make work than the big frameworks.
>>> 
>>> IMHO, the system API backends won't hurt GStreamer users, so I see no
>>> reason to remove them.
>> 
>> I mostly agree.  Perhaps the DirectSound backend could be removed by 
>> just letting Windows use SDL (unlike macOS, Windows doesn't have a 
>> "native" GUI layer), and the ALSA backend is also not so useful in my 
>> opinion.  But all the others have a reason to be there.
> 
> ALSA is also useful as the native sound backend for Linux. I'd say it 
> can already do what pulseaudio or pipewire do so those are not so 
> useful in my opinion not ALSA. :-)
> 
> Regards,
> BALATON Zoltan

The PipeWire and PulseAudio backends are used by a large number of users 
in the VFIO community. Removing these would be an enormous determent to 
QEMU.

Audio output from QEMU has always been problematic, but with the 
PulseAudio and later, the PipeWire interface, it became much more user 
friendly for those that wanted to configure the VM to output native 
audio into their sound plumbing.

I do not agree that ALSA is as useful as you state it is, it's dependent 
on the host system's audio hardware support. If the sound device doesn't 
support hardware mixing (almost none do anymore), or the bitrate/sample 
rate QEMU wishes to use, your out of luck.

What I do think needs fixing here is the removal of the forced S16 audio 
format, and the resampler which forces all output to 48KHz. This though 
would require changes to the SPICE protocol as currently it is fixed at 
two channel 48KHz S16 also IIRC.

IMHO adding GStreamer is unnecessary, we have the modern PipeWire 
interface which is compatible with everything. I see absolutely no 
reason to add so much complexity to the project for little to no gain.

Regards,
Geoffrey McRae (gnif)

