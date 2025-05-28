Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCE2C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 13:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKGVD-0001L3-RB; Wed, 28 May 2025 09:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uKGV4-0001KL-Qd
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:07:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uKGV2-0004Up-5I
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:07:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04EA221995;
 Wed, 28 May 2025 13:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748437634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Hn0gFEKSVeQN3mcY8nwLkyuXKtoqS9V57cD5UtpoGk=;
 b=qmhYuY+Vso17c7CBQ1QRn+JNSKvuuEhesf9wrypevFvEYaLJX7aimm1O2ngGHhuxlr0Q6M
 KLOOjrKjhgwSe9Td4EdXTn8QUJPJR2q7IwS61BWuLZZ3+dT+6DV/m5Br+B5k+I4CIbR5XI
 Y77+R3MWUZkYWwYzLQnvSUMFswx1Iok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748437634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Hn0gFEKSVeQN3mcY8nwLkyuXKtoqS9V57cD5UtpoGk=;
 b=sbL8ulMrMnsULO2wj0BNFBpELfTdTSBld28HbYwB0WkXqEWslDlFpBJoxUFmhdU5Je0DE/
 UBR1ui8jbbbheuAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qmhYuY+V;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sbL8ulMr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748437634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Hn0gFEKSVeQN3mcY8nwLkyuXKtoqS9V57cD5UtpoGk=;
 b=qmhYuY+Vso17c7CBQ1QRn+JNSKvuuEhesf9wrypevFvEYaLJX7aimm1O2ngGHhuxlr0Q6M
 KLOOjrKjhgwSe9Td4EdXTn8QUJPJR2q7IwS61BWuLZZ3+dT+6DV/m5Br+B5k+I4CIbR5XI
 Y77+R3MWUZkYWwYzLQnvSUMFswx1Iok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748437634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Hn0gFEKSVeQN3mcY8nwLkyuXKtoqS9V57cD5UtpoGk=;
 b=sbL8ulMrMnsULO2wj0BNFBpELfTdTSBld28HbYwB0WkXqEWslDlFpBJoxUFmhdU5Je0DE/
 UBR1ui8jbbbheuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 722C1136E0;
 Wed, 28 May 2025 13:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D3tDDIEKN2hcMwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 May 2025 13:07:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Zheng Huang <hz1624917200@gmail.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Peter
 Xu <peterx@redhat.com>, peter.maydell@linaro.org
Subject: Re: [PATCH] hw/scsi/esp: fix assertion error in fifo8_push
In-Reply-To: <7e4a9c92-b33f-4bc9-968d-e726c6151a9d@gmail.com>
References: <37889706-8576-476c-8fea-c1a3a2858b1e@gmail.com>
 <684885a4-0022-4de8-98aa-07c9fe4a11c7@linaro.org>
 <6dd914b1-2a2f-4a4c-bd2b-54e8302d1a75@ilande.co.uk>
 <7e4a9c92-b33f-4bc9-968d-e726c6151a9d@gmail.com>
Date: Wed, 28 May 2025 10:07:10 -0300
Message-ID: <87tt54994x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,gitlab.com:url,euphon.net:email,gnu.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,ilande.co.uk,linaro.org,nongnu.org];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, suse.de:dkim, suse.de:mid,
 suse.de:email, gnu.org:url]
X-Rspamd-Queue-Id: 04EA221995
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Zheng Huang <hz1624917200@gmail.com> writes:

> On 2025/5/28 03:40, Mark Cave-Ayland wrote:
>> On 27/05/2025 14:59, Philippe Mathieu-Daud=C3=A9 wrote:
>>=20
>>> Hi,
>>>
>>> Cc'ing maintainers:
>>>
>>> $ ./scripts/get_maintainer.pl -f hw/scsi/esp.c
>>> Paolo Bonzini <pbonzini@redhat.com> (supporter:SCSI)
>>> Fam Zheng <fam@euphon.net> (reviewer:SCSI)
>>> $ ./scripts/get_maintainer.pl -f migration/
>>> Peter Xu <peterx@redhat.com> (maintainer:Migration)
>>> Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
>>>
>>> On 27/5/25 15:12, Zheng Huang wrote:
>>>> This patch add validation checks on FIFO structures in esp_post_load()=
 to
>>>> avoid assertion error `assert(fifo->num < fifo->capacity);` in fifo8_p=
ush(),
>>>> which can occur if the inbound migration stream is malformed. By perfo=
rming
>>>> these checks during post-load, we can catch and handle such issues ear=
lier,
>>>> avoiding crashes due to corrupted state.
>>>
>>> How can that happen? Can you share a reproducer?
>>>
>>>>
>>>> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
>>>> ---
>>>> =C2=A0 hw/scsi/esp.c | 6 ++++++
>>>> =C2=A0 1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>>>> index ac841dc32e..ba77017087 100644
>>>> --- a/hw/scsi/esp.c
>>>> +++ b/hw/scsi/esp.c
>>>> @@ -1350,11 +1350,17 @@ static int esp_post_load(void *opaque, int ver=
sion_id)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Migrate ti_b=
uf to fifo */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D s->mig_=
ti_wptr - s->mig_ti_rptr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i=
 < len; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (&s->fifo.num >=3D &s->fifo.capacity) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fifo8_push(&s->fifo, s->mig_ti_buf[i]);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Migrate cmdb=
uf to cmdfifo */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i=
 < s->mig_cmdlen; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (&s->cmdfifo.num >=3D &s->cmdfifo.capacity) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fifo8_push(&s->cmdfifo, s->mig_cmdbuf[i]);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>=20
>> This seems odd: this logic in esp_post_load() is for converting from pre=
-Fifo8 code to the current Fifo8 code, so why wouldn't we want to assert() =
for the case when the migration stream is intentionally malformed? Is there=
 a case whereby the old code could generate an invalid migration stream lik=
e this?
>>=20
>>=20
>> ATB,
>>=20
>> Mark.
>>=20
>
> Hi Mark,
>
> The malformed migration stream in question originates from QEMU itself=E2=
=80=94either accidentally, due to=20
> a bug, or maliciously crafted. If we allow unchecked data through in esp_=
post_load(), an attacker
> controlling the migration source could send crafted values that trigger u=
ndefined behavior.
> The commit https://gitlab.com/qemu-project/qemu/-/commit/b88cfee90268cad3=
76682da8f99ccf024d7aa304
> also check the migration stream integrity in post_load handler, which is =
suggested by Peter Maydell in
> https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg00099.html, 'to =
prevent the division-by-zero
> in the "malicious inbound migration state" case'.
>
> Also, I would appreciate your opinion on how we should handle such "malfo=
rmed migration stream" case
> more generally, if there are more severe issues than assertion error, suc=
h as FPE, UAF, etc.? Should
> QEMU adopt a more systematic =E2=80=9Cpost_load=E2=80=9D validation patte=
rn=E2=80=94verifying all critical fields across every
> migration handler=E2=80=94to harden the migration subsystem against any t=
ampering of the migration image?
>

From the migration perspective it does make sense to validate the values
and return error. The migration stream should indeed be considered
untrusted.

But I agree that it would be nice to have some sort of reproducer. I
don't think it's practical to go around adding code to handle every
single hypothetical scenario. That creates some churn in the codebase
that might introduce bugs by itself.

