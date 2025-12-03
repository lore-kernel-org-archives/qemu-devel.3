Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AECCD1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQj25-0003Qf-BQ; Wed, 03 Dec 2025 04:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vQj22-0003QM-U9
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:20:18 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vQj1z-0002qO-Ui
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:20:18 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B39JLo5013924
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 3 Dec 2025 18:19:28 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=OMQ0mCIEfbBZ7bjkomF6H7jybI1a8HXSQpLjYZz1hlE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:From:Subject:To;
 s=rs20250326; t=1764753568; v=1;
 b=OoKYbBG8wiq/B/TgclDVInKGQvMq33GIUC21b68G0EzEgJ7NNqYv4NPwFaLGg9i3
 Oqn4M9JSySTKilu3zY1fC8GzROJODhCgMdxhoL3rWguVvac0WG1zm274SWwZ7n2E
 osPf97hPy31K11dwcJtRr+e4mSwLv1/gj2tIR3vi7+BEh8lC0JvxalYXruMll6qt
 rxWURwr5L1MYrziVtqu8ORlNPd8YDu74F6RhTG0mDhTwbnj0chJT70BpUvaFGtR6
 WtNe/wAVnwL1wmX2B950TwgMrq6sKcWgf3pN3e+n6CRMg3XEpK696sf8jaCNp31D
 6tPhRUjWp8iy6ywp5qJcYg==
Message-ID: <41021c83-f284-4c6b-b0e2-ddd930d653e4@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 3 Dec 2025 18:19:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Geoffrey McRae <geoff@hostfission.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Ratchov <alex@caoua.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 dirty.ice.hu@gmail.com, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
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
 <87qztdrl66.fsf@pond.sub.org>
Content-Language: en-US
In-Reply-To: <87qztdrl66.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/02 23:52, Markus Armbruster wrote:
> Marc-André Lureau <marcandre.lureau@gmail.com> writes:
> 
>> Hi
>>
>> On Tue, Dec 2, 2025 at 5:26 PM Geoffrey McRae <geoff@hostfission.com> wrote:
>>>
>>>
>>>
>>> On 2025-12-02 23:44, Marc-André Lureau wrote:
>>>> Hi Geoffrey
>>>>
>>>> On Tue, Dec 2, 2025 at 4:31 PM Geoffrey McRae
>>>> <geoff@hostfission.com> wrote:
>>>>
>>>>> The PipeWire and PulseAudio backends are used by a large number of
>>>>> users
>>>>> in the VFIO community. Removing these would be an enormous determent
>>>>> to
>>>>> QEMU.
>>>>
>>>> They come with GStreamer pulse/pipe elements.
>>>
>>> Yes, but through another layer of abstraction/complexity with no real
>>> benefit.
>>
>> The benefit is that QEMU would not have to maintain 10 backends and
> 
> Twelve according to the QAPI schema.
> 
>> all the audio mixing/resampling. The QEMU code would be simpler and
>> more maintainable overall.
> 
> This matters.
> 
> The question can't be whether some QEMU feature is useful to somebody
> (it basically always is).  It must be whether it is worth its keep.
> 
> Maintaining code is not free.  Easy to forget when somebody else does
> the actual work quietly and well.
> 
> I'm not qualified to judge either utility or maintenance of audio
> drivers.  However, I trust our long-serving maintainers there.

If someone touches the Core Audio backend after GStreamer gets in, my 
first question as a reviewer may be: why don't they use GStreamer instead?

GStreamer has mixing/resampling and Core Audio code that is:
- more optimized (e.g., SIMD resampling),
- better maintained, and
- has more features (GStreamer seems to support microphone/source while 
QEMU's coreaudio backend doesn't).

The reasons _not_ to use GStreamer I can come up with are:
- You don't have GStreamer installed. However I guess it will be 
automatically installed when doing "brew install qemu" once the 
GStreamer backend gets in.
- Bugs in GStreamer or the glue code between QEMU and GStreamer. But of 
course the code that connects QEMU's mixing/resampling has another set 
of bugs.

I think there is a good chance that nobody notices if the coreaudio 
backend breaks once GStreamer becomes the default.

Regards,
Akihiko Odaki

