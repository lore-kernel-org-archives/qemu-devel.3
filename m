Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30739C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zgf-0002gb-7K; Tue, 22 Sep 2026 08:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zgd-0002gG-Vv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:33:28 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zgc-0008QK-Af
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:33:27 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 751ED21BE2;
 Tue, 22 Sep 2026 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790080399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVfwYHA7UBYnynYMd5LtkZjvujLzUql0doWptFy3BnI=;
 b=J23a5AxRggwWthSTiNI9V8J/LhnDJJs7HRejaK6MDIAHqTbz63C7PyQeHFHEm6TRERm4QP
 xZco4NQn6xKaofIggJ0R3gdLgTNZAaMaZsKR3j5m50QD7F/2MD7WKRXyQbX/yg4qDya1we
 tH9yiiF+Hw5C1tdNX7Rg7MWrJIsAdTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790080399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVfwYHA7UBYnynYMd5LtkZjvujLzUql0doWptFy3BnI=;
 b=v7vqdoUyl1MhChHg2ibI5/VxdnXkZdyUE/CwiME//I6ZfB5+QrrgpeQakZnJdhDNoUHaDi
 6xo2j5Y+LlxFFUAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790080395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVfwYHA7UBYnynYMd5LtkZjvujLzUql0doWptFy3BnI=;
 b=C1FzlWb1MnIYqPiqmraKoCZsHoAUdl8u/KN9HOiTOByj7/KMs4Z7VrIt4vbYOJRXwGe+i0
 AHU7LOX1beJNkYnL6DUfUMTaX50AYvczV8slKa4IRxuzL6u4xNgxp6j4sU0kOqwEQV458f
 UVXmjklohQam9pDtL7RROm1QynJs3rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790080395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVfwYHA7UBYnynYMd5LtkZjvujLzUql0doWptFy3BnI=;
 b=ikEGCd0Jq7958ttCvjYiep3IRWptlWDrpwnhuXeRMpYbnnCYBZicQo4zU4LTGM4n/uEnnO
 CAqnbIZo6MbPjQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBCF513A23;
 Tue, 22 Sep 2026 12:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Eu4OJIp1smpENwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Sep 2026 12:33:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: remove duplicate VMSTATE_STRUCT_VARRAY
In-Reply-To: <CAJ+F1C+RV6=nU=8d+QXd=X14WppRvPP76-jxBE0jNhx5UWpqWw@mail.gmail.com>
References: <20260831114749.2758129-1-marcandre.lureau@redhat.com>
 <CAJ+F1C+RV6=nU=8d+QXd=X14WppRvPP76-jxBE0jNhx5UWpqWw@mail.gmail.com>
Date: Tue, 22 Sep 2026 09:33:12 -0300
Message-ID: <87a4p9bh4n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> On Mon, Aug 31, 2026 at 3:48=E2=80=AFPM <marcandre.lureau@redhat.com> wro=
te:
>>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Fixes: 028d4ec43de6 ("migration: Remove duplicate vmstate macros")
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ping, trivial
>
>> ---
>>  include/migration/vmstate.h | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index e72c3fae9a69..21a31ed7053c 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -723,16 +723,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>>  #define VMSTATE_STRUCT_VARRAY_POINTER_UINT32 VMSTATE_STRUCT_VARRAY_POIN=
TER
>>  #define VMSTATE_STRUCT_VARRAY_POINTER_UINT16 VMSTATE_STRUCT_VARRAY_POIN=
TER
>>
>> -#define VMSTATE_STRUCT_VARRAY(_field, _state, _field_num, _version, _vm=
sd, \
>> -                              _type) {                                 =
 \
>> -    .name       =3D (stringify(_field)),                               \
>> -    .num_indirect =3D vmstate_field_offset(_state, _field_num),        \
>> -    .version_id =3D (_version),                                        \
>> -    .vmsd       =3D &(_vmsd),                                          \
>> -    .size       =3D sizeof(_type),                                     \
>> -    .flags      =3D VMS_STRUCT | VMS_VARRAY,                           \
>> -    .offset     =3D vmstate_offset_varray(_state, _field, _type),      \
>> -}
>>  #define VMSTATE_STRUCT_VARRAY_INT32 VMSTATE_STRUCT_VARRAY
>>  #define VMSTATE_STRUCT_VARRAY_UINT32 VMSTATE_STRUCT_VARRAY
>>
>> --
>> 2.55.0.543.g5ebe2ebe4ea8
>>
>>

Queued.

