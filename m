Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709E7C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbcOF-0007RY-7i; Sun, 18 Feb 2024 03:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rbcOC-0007RL-Pc
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:19:08 -0500
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rbcOA-0003W8-S6
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:19:08 -0500
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
 by mailout06.t-online.de (Postfix) with SMTP id 558395B56;
 Sun, 18 Feb 2024 09:19:01 +0100 (CET)
Received: from [192.168.211.200] ([79.208.24.6]) by fwd80.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbcO4-29RwZd0; Sun, 18 Feb 2024 09:19:00 +0100
Message-ID: <b2f21483-b2c6-43a2-ae92-429667583928@t-online.de>
Date: Sun, 18 Feb 2024 09:19:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hw/audio/virtio-sound: return correct command
 response size
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
 <20240104203422.12308-5-vr_qemu@t-online.de>
 <CAMxuvazLnP-_PC-0PbxNncp1C+HzZOwvvmNwbdrLUxgY7eMcqA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <CAMxuvazLnP-_PC-0PbxNncp1C+HzZOwvvmNwbdrLUxgY7eMcqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708244340-759C19CF-FA9D2478/0/0 CLEAN NORMAL
X-TOI-MSGID: 0c322acf-a1c1-4ddc-9ef4-42c1e9868eeb
Received-SPF: pass client-ip=194.25.134.19; envelope-from=vr_qemu@t-online.de;
 helo=mailout06.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 05.01.24 um 12:36 schrieb Marc-André Lureau:
> Hi
>
> On Fri, Jan 5, 2024 at 12:34 AM Volker Rümelin <vr_qemu@t-online.de> wrote:
>> The payload size returned by command VIRTIO_SND_R_PCM_INFO is
>> wrong. The code in process_cmd() assumes that all commands
>> return only a virtio_snd_hdr payload, but some commands like
>> VIRTIO_SND_R_PCM_INFO may return an additional payload.
>>
>> Add a zero initialized payload_size variable to struct
>> virtio_snd_ctrl_command to allow for additional payloads.
>>
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> ---
>>  hw/audio/virtio-snd.c         | 7 +++++--
>>  include/hw/audio/virtio-snd.h | 1 +
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>> index a2817a64b5..9f3269d72b 100644
>> --- a/hw/audio/virtio-snd.c
>> +++ b/hw/audio/virtio-snd.c
>> @@ -262,12 +262,13 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
>>          memset(&pcm_info[i].padding, 0, 5);
>>      }
>>
>> +    cmd->payload_size = sizeof(virtio_snd_pcm_info) * count;
>>      cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
>>      iov_from_buf(cmd->elem->in_sg,
>>                   cmd->elem->in_num,
>>                   sizeof(virtio_snd_hdr),
>>                   pcm_info,
>> -                 sizeof(virtio_snd_pcm_info) * count);
>> +                 cmd->payload_size);
> iov_from_buf() return value should probably be checked to match the
> expected written size..
>
> The earlier check for iov_size() is then probably redundant. Hmm, it
> checks for req.size, which should probably match
> sizeof(virtio_snd_pcm_info) too.

I wouldn't like to change that in this patch. There are more places in
this device and also in other virtio devices where this is done in
exactly the same way.

>
>>  }
>>
>>  /*
>> @@ -805,7 +806,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
>>                   0,
>>                   &cmd->resp,
>>                   sizeof(virtio_snd_hdr));
>> -    virtqueue_push(cmd->vq, cmd->elem, sizeof(virtio_snd_hdr));
>> +    virtqueue_push(cmd->vq, cmd->elem,
>> +                   sizeof(virtio_snd_hdr) + cmd->payload_size);
>>      virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
>>  }
>>
>> @@ -856,6 +858,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>>          cmd->elem = elem;
>>          cmd->vq = vq;
>>          cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
>> +        /* implicit cmd->payload_size = 0; */
>>          QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
>>          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>>      }
>> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>> index d1a68444d0..d6e08bd30d 100644
>> --- a/include/hw/audio/virtio-snd.h
>> +++ b/include/hw/audio/virtio-snd.h
>> @@ -210,6 +210,7 @@ struct virtio_snd_ctrl_command {
>>      VirtQueue *vq;
>>      virtio_snd_hdr ctrl;
>>      virtio_snd_hdr resp;
>> +    size_t payload_size;
>>      QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
>>  };
>>  #endif
>> --
>> 2.35.3
>>
> otherwise, lgtm. Should it be backported to -stable ?

Yes, I will cc qemu-stable in my v2 series. While the Linux virtio sound
driver ignores the returned "used length", this is required by the
virtio specification.

> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>


