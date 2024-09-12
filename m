Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40848EED606
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sokFF-00009f-Cu; Thu, 12 Sep 2024 09:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sokFA-00008F-Sk
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:52:23 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sokF7-0001W8-J7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:52:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 036851FB7A;
 Thu, 12 Sep 2024 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726149133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3b8wmhi8iyAVetWR9Xdjp/iE2GwO3DYTbD3Qkb94Uo=;
 b=J8CsXwdxX+i75t1m8Un1CghLBjmQKv9QD+2yDMl0G0WAj4Dv9TdPRgqYO3POxq20pTjIPr
 A44b8BiVfV72AxGMCCYfXhhaxtqy+XEJM0FrSxJoUIEqPXYi9TB030xLiSlUa4EU5rzzCz
 tdtyvN8wcQUsDWlM2x7QpjfDcOjribw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726149133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3b8wmhi8iyAVetWR9Xdjp/iE2GwO3DYTbD3Qkb94Uo=;
 b=9WNrT730aeXhaX4d6dp/vg+RPBc2xkte+jUxGsylmdCt2odviYz4Cqh3yFgws3ACKNIQ26
 4EW1I4h+uYJy+TDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J8CsXwdx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9WNrT730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726149133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3b8wmhi8iyAVetWR9Xdjp/iE2GwO3DYTbD3Qkb94Uo=;
 b=J8CsXwdxX+i75t1m8Un1CghLBjmQKv9QD+2yDMl0G0WAj4Dv9TdPRgqYO3POxq20pTjIPr
 A44b8BiVfV72AxGMCCYfXhhaxtqy+XEJM0FrSxJoUIEqPXYi9TB030xLiSlUa4EU5rzzCz
 tdtyvN8wcQUsDWlM2x7QpjfDcOjribw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726149133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3b8wmhi8iyAVetWR9Xdjp/iE2GwO3DYTbD3Qkb94Uo=;
 b=9WNrT730aeXhaX4d6dp/vg+RPBc2xkte+jUxGsylmdCt2odviYz4Cqh3yFgws3ACKNIQ26
 4EW1I4h+uYJy+TDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 764F613A73;
 Thu, 12 Sep 2024 13:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I+D4Dgzy4mY2dwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Sep 2024 13:52:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Dan?=
 =?utf-8?Q?iel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/17] migration/multifd: Device state transfer
 support - receive side
In-Reply-To: <31954a8f-5182-49b4-9514-2839aaef77a3@nvidia.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
 <2a9d1c5d-6453-4b33-99cd-824f0002e305@nvidia.com>
 <c042036e-ff01-4adf-b9a6-090660887a2e@maciej.szmigiero.name>
 <31954a8f-5182-49b4-9514-2839aaef77a3@nvidia.com>
Date: Thu, 12 Sep 2024 10:52:09 -0300
Message-ID: <87ttelvv1y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 036851FB7A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Avihai Horon <avihaih@nvidia.com> writes:

> On 09/09/2024 21:05, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 5.09.2024 18:47, Avihai Horon wrote:
>>>
>>> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Add a basic support for receiving device state via multifd channels -
>>>> channels that are shared with RAM transfers.
>>>>
>>>> To differentiate between a device state and a RAM packet the packet
>>>> header is read first.
>>>>
>>>> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not=20
>>>> in the
>>>> packet header either device state (MultiFDPacketDeviceState_t) or RAM
>>>> data (existing MultiFDPacket_t) is then read.
>>>>
>>>> The received device state data is provided to
>>>> qemu_loadvm_load_state_buffer() function for processing in the
>>>> device's load_state_buffer handler.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>> =C2=A0 migration/multifd.c | 127=20
>>>> +++++++++++++++++++++++++++++++++++++-------
>>>> =C2=A0 migration/multifd.h |=C2=A0 31 ++++++++++-
>>>> =C2=A0 2 files changed, 138 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>>> index b06a9fab500e..d5a8e5a9c9b5 100644
>>>> --- a/migration/multifd.c
>>>> +++ b/migration/multifd.c
>>>> @@ -21,6 +21,7 @@
>>>> =C2=A0 #include "file.h"
>>>> =C2=A0 #include "migration.h"
>>>> =C2=A0 #include "migration-stats.h"
>>>> +#include "savevm.h"
>>>> =C2=A0 #include "socket.h"
>>>> =C2=A0 #include "tls.h"
>>>> =C2=A0 #include "qemu-file.h"
>>>> @@ -209,10 +210,10 @@ void=20
>>>> multifd_send_fill_packet(MultiFDSendParams *p)
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(packet, 0, p->packet_len);
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
>>>> -=C2=A0=C2=A0=C2=A0 packet->version =3D cpu_to_be32(MULTIFD_VERSION);
>>>> +=C2=A0=C2=A0=C2=A0 packet->hdr.magic =3D cpu_to_be32(MULTIFD_MAGIC);
>>>> +=C2=A0=C2=A0=C2=A0 packet->hdr.version =3D cpu_to_be32(MULTIFD_VERSIO=
N);
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 packet->flags =3D cpu_to_be32(p->flags);
>>>> +=C2=A0=C2=A0=C2=A0 packet->hdr.flags =3D cpu_to_be32(p->flags);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet->next_packet_size =3D cpu_to_be3=
2(p->next_packet_size);
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet_num =3D qatomic_fetch_inc(&multi=
fd_send_state->packet_num);
>>>> @@ -228,31 +229,49 @@ void=20
>>>> multifd_send_fill_packet(MultiFDSendParams *p)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->flags, p->next_packet_size);
>>>> =C2=A0 }
>>>>
>>>> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error=20
>>>> **errp)
>>>> +static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
>>>> + MultiFDPacketHdr_t *hdr,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>>> =C2=A0 {
>>>> -=C2=A0=C2=A0=C2=A0 MultiFDPacket_t *packet =3D p->packet;
>>>> -=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 packet->magic =3D be32_to_cpu(packet->magic);
>>>> -=C2=A0=C2=A0=C2=A0 if (packet->magic !=3D MULTIFD_MAGIC) {
>>>> +=C2=A0=C2=A0=C2=A0 hdr->magic =3D be32_to_cpu(hdr->magic);
>>>> +=C2=A0=C2=A0=C2=A0 if (hdr->magic !=3D MULTIFD_MAGIC) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp=
, "multifd: received packet "
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "magic %x and expected =
magic %x",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet->magic, MULTIFD_MAGIC);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr->magic, MULTIFD_MAGIC);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 packet->version =3D be32_to_cpu(packet->version);
>>>> -=C2=A0=C2=A0=C2=A0 if (packet->version !=3D MULTIFD_VERSION) {
>>>> +=C2=A0=C2=A0=C2=A0 hdr->version =3D be32_to_cpu(hdr->version);
>>>> +=C2=A0=C2=A0=C2=A0 if (hdr->version !=3D MULTIFD_VERSION) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp=
, "multifd: received packet "
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "version %u and expecte=
d version %u",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet->version, MULTIFD_VERSION);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr->version, MULTIFD_VERSION);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 p->flags =3D be32_to_cpu(packet->flags);
>>>> +=C2=A0=C2=A0=C2=A0 p->flags =3D be32_to_cpu(hdr->flags);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>> +static int=20
>>>> multifd_recv_unfill_packet_device_state(MultiFDRecvParams *p,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 MultiFDPacketDeviceState_t *packet =3D p->packet_d=
ev_state;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 packet->instance_id =3D be32_to_cpu(packet->instan=
ce_id);
>>>> +=C2=A0=C2=A0=C2=A0 p->next_packet_size =3D be32_to_cpu(packet->next_p=
acket_size);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>> +static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p,=20
>>>> Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 MultiFDPacket_t *packet =3D p->packet;
>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->next_packet_size =3D be32_to_cpu(pac=
ket->next_packet_size);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->packet_num =3D be64_to_cpu(packet->p=
acket_num);
>>>> -=C2=A0=C2=A0=C2=A0 p->packets_recved++;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(p->flags & MULTIFD_FLAG_SYNC)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D multifd=
_ram_unfill_packet(p, errp);
>>>> @@ -264,6 +283,19 @@ static int=20
>>>> multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0 }
>>>>
>>>> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error=20
>>>> **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 p->packets_recved++;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return multifd_recv_unfill=
_packet_device_state(p, errp);
>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return multifd_recv_unfill=
_packet_ram(p, errp);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
>>>
>>> We can drop the assert and the "else":
>>> if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 return multifd_recv_unfill_packet_device_state=
(p, errp);
>>> }
>>>
>>> return multifd_recv_unfill_packet_ram(p, errp);
>>
>> Ack.
>>
>>>> +}
>>>> +
>>>> =C2=A0 static bool multifd_send_should_exit(void)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return qatomic_read(&multifd_send_state=
->exiting);
>>>> diff --git a/migration/multifd.h b/migration/multifd.h
>>>> index a3e35196d179..a8f3e4838c01 100644
>>>> --- a/migration/multifd.h
>>>> +++ b/migration/multifd.h
>>>> @@ -45,6 +45,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
>>>> =C2=A0 #define MULTIFD_FLAG_QPL (4 << 1)
>>>> =C2=A0 #define MULTIFD_FLAG_UADK (8 << 1)
>>>>
>>>> +/*
>>>> + * If set it means that this packet contains device state
>>>> + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
>>>> + */
>>>> +#define MULTIFD_FLAG_DEVICE_STATE (1 << 4)
>>>> +
>>>> =C2=A0 /* This value needs to be a multiple of qemu_target_page_size()=
 */
>>>> =C2=A0 #define MULTIFD_PACKET_SIZE (512 * 1024)
>>>>
>>>> @@ -52,6 +58,11 @@ typedef struct {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t magic;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t version;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags;
>>>> +} __attribute__((packed)) MultiFDPacketHdr_t;
>>>
>>> Maybe split this patch into two: one that adds the packet header=20
>>> concept and another that adds the new device packet?
>>
>> Can do.
>>
>>>> +
>>>> +typedef struct {
>>>> +=C2=A0=C2=A0=C2=A0 MultiFDPacketHdr_t hdr;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* maximum number of allocated pages */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pages_alloc;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* non zero pages */
>>>> @@ -72,6 +83,16 @@ typedef struct {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset[];
>>>> =C2=A0 } __attribute__((packed)) MultiFDPacket_t;
>>>>
>>>> +typedef struct {
>>>> +=C2=A0=C2=A0=C2=A0 MultiFDPacketHdr_t hdr;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 char idstr[256] QEMU_NONSTRING;
>>>
>>> idstr should be null terminated, or am I missing something?
>>
>> There's no need to always NULL-terminate a constant-size field,
>> since the strncpy() already stops at the field size, so we can
>> gain another byte for actual string use this way.
>>
>> RAM block idstr also uses the same "trick":
>>> void multifd_ram_fill_packet(MultiFDSendParams *p):
>>> strncpy(packet->ramblock, pages->block->idstr, 256);
>>
> But can idstr actually be 256 bytes long without null byte?
> There are a lot of places where idstr is a parameter for functions that=20
> expect null terminated string and it is also printed as such.

Yeah, and I actually don't see the "trick" being used in
RAMBlock. Anyway, it's best to null terminate to be more predictable. We
also had Coverity reports about similar things:

https://lore.kernel.org/r/CAFEAcA_F2qrSAacY=3DV5Hez1qFGuNW0-XqL2LQ=3DY_UKYu=
HEJWhw@mail.gmail.com

I haven't got the time to send that patch yet.

>
> Thanks.

