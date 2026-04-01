Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D0910FCAEA
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w83W5-0005O5-CT; Wed, 01 Apr 2026 17:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w83W3-0005Fo-Fr
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:54:23 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w83W0-0000LE-H8
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:54:23 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1F3408080F;
 Thu, 02 Apr 2026 00:54:15 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:42a::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Csj1K70KDeA0-5xkNskpe; Thu, 02 Apr 2026 00:54:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1775080454;
 bh=QiityOVcQioNI4l1p3HdxUOd55Ddq3yDrPnwcu3qNB0=;
 h=In-Reply-To:Subject:Cc:Message-Id:Date:References:To:From;
 b=oePfcnQdmkfkKaLd/D4fM9Imj+CL2E9v39vl2Zdamx8eANHiLsZVdPzb/7hBatlQe
 CAcf9z33QjwxOjcNQpcdnRHuy094UdG13hzDILIyF6App6vVD54YREevmAZINs15d6
 mkHeNywKNOE1whchkNS/OmmICO/8viIafCUP7R2Q=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 02:54:12 +0500
Message-Id: <DHI5I6GW62LL.2WBYO3E1ZHT71@yandex-team.com>
Cc: "Eric Blake" <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Markus Armbruster"
 <armbru@redhat.com>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Eduardo Habkost" <eduardo@habkost.net>, "Yanan Wang"
 <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, "Thomas Huth" <thuth@redhat.com>, "Laurent Vivier"
 <lvivier@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>
Subject: Re: [PATCH v3 02/11] ui/vnc: disable audio feature when configured
 with --disable-audio
From: "Sergei Heifetz" <heifetz@yandex-team.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
X-Mailer: aerc 0.20.1-262-gc2819a603771-dirty
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-3-heifetz@yandex-team.com>
 <406a855e-5058-4206-b693-d1b74c11a395@linaro.org>
In-Reply-To: <406a855e-5058-4206-b693-d1b74c11a395@linaro.org>
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed Apr 1, 2026 at 3:07 PM +05, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>
> On 15/3/26 21:16, Sergei Heifetz wrote:
>> Disable the audio feature in VNC when QEMU is configured with
>> `--disable-audio`. Do not compile the corresponding audio-related
>> code.
>>=20
>> The audio feature is disabled in a way that makes a QEMU server behave
>> like a non-QEMU server (as far as audio is concerned). The client sends
>> the audio pseudo-encoding, but the server does not respond with
>> confirmation, because send_ext_audio_ack is now behind an #ifdef.
>> A well-behaved client should handle this accordingly and continue
>> using VNC without sending any audio-related messages to the server.
>> If a client misbehaves and sends VNC_MSG_CLIENT_QEMU_AUDIO while
>> the audio feature is disabled, the server will close the connection with
>> an error.
>>=20
>> The behaviour described above is already present when there is no audiod=
ev
>> (`vs->vd->audio_be` is NULL).
>>=20
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>   qemu-options.hx |  3 +++
>>   ui/vnc.c        | 27 +++++++++++++++++++++++++++
>>   2 files changed, 30 insertions(+)
>
>
>> @@ -2197,10 +2205,15 @@ static void set_encodings(VncState *vs, int32_t =
*encodings, size_t n_encodings)
>>               send_ext_key_event_ack(vs);
>>               break;
>>           case VNC_ENCODING_AUDIO:
>> +#ifdef CONFIG_AUDIO
>>               if (vs->vd->audio_be) {
>>                   vnc_set_feature(vs, VNC_FEATURE_AUDIO);
>>                   send_ext_audio_ack(vs);
>>               }
>> +#else
>> +            VNC_DEBUG("Audio encoding received with audio subsystem "
>> +                      "disabled\n");
>> +#endif
>>               break;
>
> IIRC the way the project choose to compartmentalize subsystem is
> to use stubs instead of cluttering the source with #ifdef'ry, so
> I'd expect this effort to be extracting the audio code. For example
> here declare vnc_audio_set_encodings() in "ui/vnc.h" ...:
>
> [...]
>
> Does it make sense?

Has the project really chosen this approach? Does it apply only to
subsystems, and not to individual options? I did it without stubs
because it's simpler, and there is already a lot of #ifdef'ry present in
the code. I am, of course, willing to refactor the series to use stubs
if it's necessary, but I wonder if you could provide a bit more context
about why you think it should be done.

Also, how strict do we want to be about it? There are places where the
stub approach looks perfect, but there are also places where, for
example, the whole change is putting a few lines of a big function
inside an #ifdef block. Do we want to be as strict as possible, or try
to strike a balance?

