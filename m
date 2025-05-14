Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B34C3ABCB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 06:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF5ZV-0003l1-Ak; Wed, 14 May 2025 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1uF5ZP-0003iY-2m; Wed, 14 May 2025 02:26:23 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1uF5ZN-0007S7-49; Wed, 14 May 2025 02:26:22 -0400
Received: from fwd75.aul.t-online.de (fwd75.aul.t-online.de [10.223.144.101])
 by mailout07.t-online.de (Postfix) with SMTP id 93804129D;
 Wed, 14 May 2025 08:26:16 +0200 (CEST)
Received: from [192.168.211.200] ([84.175.230.13]) by fwd75.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uF5ZH-2XjkOH0; Wed, 14 May 2025 08:26:15 +0200
Message-ID: <0deee33d-d0c1-4319-8833-59ebc031baec@t-online.de>
Date: Wed, 14 May 2025 08:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] audio related fixes for 10.1
To: Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
References: <d456c188-0463-4dc2-9178-469f840eaebe@t-online.de>
 <16ac7bdb-9df1-4951-bf3b-0b6cddbee358@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <16ac7bdb-9df1-4951-bf3b-0b6cddbee358@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1747203975-A0FF7517-F300A5BE/0/0 CLEAN NORMAL
X-TOI-MSGID: 23276547-9317-4b3f-be52-ee0055f400fd
Received-SPF: pass client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 13.05.25 um 08:40 schrieb Michael Tokarev:
> 11.05.2025 10:36, Volker Rümelin wrote:
>> A few audio related fixes for 10.1.
>>
>> The virtio-sound device is the first QEMU audio front end that
>> supports floating point samples. The audio subsystem is only
>> partially prepared for this. The commit message of patch 7/7 "audio:
>> add float sample endianness converters" has the details. The new code
>> paths in patch 7/7 are only compile tested. I don't have a big endian
>> host to test.
>>
>> checkpatch.pl complains about missing space characters in the type
>> punning macros in patch 7/7. I don't agree.
>>
>> Volker Rümelin (7):
>>    tests/functional: use 'none' audio driver for q800 tests
>>    audio: fix SIGSEGV in AUD_get_buffer_size_out()
>>    audio: fix size calculation in AUD_get_buffer_size_out()
>>    hw/audio/asc: fix SIGSEGV in asc_realize()
>>    hw/audio/asc: replace g_malloc0() with g_malloc()
>>    audio/mixeng: remove unnecessary pointer type casts
>>    audio: add float sample endianness converters
>>
>>   audio/audio.c                        | 11 +++-
>>   audio/audio_template.h               | 12 ++--
>>   audio/mixeng.c                       | 83 ++++++++++++++++++++++++----
>>   audio/mixeng.h                       |  6 +-
>>   hw/audio/asc.c                       |  9 ++-
>>   tests/functional/test_m68k_q800.py   |  3 +-
>>   tests/functional/test_m68k_replay.py |  3 +-
>>   7 files changed, 106 insertions(+), 21 deletions(-)
>
> It looks like (some of) these patches should go to 10.0-stable too,
> what do you think?

I would perhaps select patch 1/7 (‘tests/functional: use “none” audio
driver for q800 tests’). I don't see any serious bugs fixed by these
patches.

With best regards,
Volker

>
> Thanks,
>
> /mjt
>
>


