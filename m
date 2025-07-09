Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ECEC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 07:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZPgy-0000YW-Rb; Wed, 09 Jul 2025 03:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1uZPgv-0000TM-4u
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 03:58:10 -0400
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1uZPgs-0002Ml-TF
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 03:58:08 -0400
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
 by mailout06.t-online.de (Postfix) with SMTP id 6D4B21C185;
 Wed,  9 Jul 2025 09:58:01 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.150.188]) by fwd82.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uZPZ6-0vDXxB0; Wed, 9 Jul 2025 09:50:27 +0200
Message-ID: <62ecfaee-0b18-46d5-9931-ec5092639d7d@t-online.de>
Date: Wed, 9 Jul 2025 09:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/9] audio: fix size calculation in
 AUD_get_buffer_size_out()
To: Michael Tokarev <mjt@tls.msk.ru>, marcandre.lureau@redhat.com
Cc: stefanha@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
 <20250525132717.527392-4-marcandre.lureau@redhat.com>
 <a9bdc547-fec8-44f8-8079-6167ff3b5d2c@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <a9bdc547-fec8-44f8-8079-6167ff3b5d2c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1752047427-FAFFB4EA-45427FDF/0/0 CLEAN NORMAL
X-TOI-MSGID: 79fb0fc9-0362-4ff8-ab25-04d4235a4e21
Received-SPF: pass client-ip=194.25.134.19; envelope-from=vr_qemu@t-online.de;
 helo=mailout06.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Am 09.07.25 um 04:24 schrieb Michael Tokarev:
> On 25.05.2025 16:27, marcandre.lureau@redhat.com wrote:
>> From: Volker Rümelin <vr_qemu@t-online.de>
>>
>> The buffer size calculated by AUD_get_buffer_size_out() is often
>> incorrect. sw->hw->samples * sw->hw->info.bytes_per_frame is the
>> size of the mixing engine buffer in audio frames multiplied by
>> the size of one frame of the audio backend. Due to resampling or
>> format conversion, the size of the frontend buffer can differ
>> significantly.
>>
>> Return the correct buffer size when the mixing engine is used.
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> Message-Id: <20250515054429.7385-3-vr_qemu@t-online.de>
>> ---
>>   audio/audio.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/audio/audio.c b/audio/audio.c
>> index 70ef22b1a4..3f5baf0cc6 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -909,6 +909,10 @@ int AUD_get_buffer_size_out(SWVoiceOut *sw)
>>           return 0;
>>       }
>>   +    if (audio_get_pdo_out(sw->s->dev)->mixing_engine) {
>> +        return sw->resample_buf.size * sw->info.bytes_per_frame;
>> +    }
>> +
>>       return sw->hw->samples * sw->hw->info.bytes_per_frame;
>>   }
>>   
>
> Hi!
>
> Is this relevant for 7.2.x qemu-stable series?
>
> Commit v7.2.0-2160-g2c3f9a0a92 "audio: change type and name of the
> resample buffer" introduced sw->resample_buf, before that commit
> there was sw->buf, of different type.
>
> Maybe whole this series should not be picked up for stable-7.2,
> after all?
>

Hi,

I would drop this patch in staging-7.2. This issue exists since end of
2004 and it hasn't really been a big problem since then. You can keep
the patch "audio: fix SIGSEGV in AUD_get_buffer_size_out()".

With best regards,
Volker

> Thanks,
>
> /mjt
>
>


