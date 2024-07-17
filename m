Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBA2C3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 00:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTs5o-0005Ju-AT; Tue, 16 Jul 2024 20:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sTs5m-0005Im-31
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 20:00:22 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sTs5e-0000Eq-36
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 20:00:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F4771FCE1;
 Wed, 17 Jul 2024 00:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721174409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMwMedaIy8nJRKtp2yiTnoqzybsASlKusFOLgfn+nU8=;
 b=CamQDd/B7uIpGXT9LD/OWUuBrviY2vbJnFEdmn74/nxs3zhL9dokpxjMCWVwQ/YyJ3I8XP
 UBKl7uNFjWRkO/WOsKK8t7A4s2OZY/ynXEJz0tRDlAXcTJbLR2swoYInEA9QpBEkTpEnfj
 kedzuea4aXQRxUp8j4R7FDqJFyaclNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721174409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMwMedaIy8nJRKtp2yiTnoqzybsASlKusFOLgfn+nU8=;
 b=vcOtz/J7h1Xg7ns/8TzcaahVwlJZdMO7y/VNJD1LZJpQvuIocLy20f/s6vuOcP0Af0T4bh
 wsDz6D6Qje/GGTBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CamQDd/B";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="vcOtz/J7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721174409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMwMedaIy8nJRKtp2yiTnoqzybsASlKusFOLgfn+nU8=;
 b=CamQDd/B7uIpGXT9LD/OWUuBrviY2vbJnFEdmn74/nxs3zhL9dokpxjMCWVwQ/YyJ3I8XP
 UBKl7uNFjWRkO/WOsKK8t7A4s2OZY/ynXEJz0tRDlAXcTJbLR2swoYInEA9QpBEkTpEnfj
 kedzuea4aXQRxUp8j4R7FDqJFyaclNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721174409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMwMedaIy8nJRKtp2yiTnoqzybsASlKusFOLgfn+nU8=;
 b=vcOtz/J7h1Xg7ns/8TzcaahVwlJZdMO7y/VNJD1LZJpQvuIocLy20f/s6vuOcP0Af0T4bh
 wsDz6D6Qje/GGTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3159137EB;
 Wed, 17 Jul 2024 00:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8jEfIogJl2YMFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jul 2024 00:00:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>
Subject: Re: [PATCH v5 08/13] migration/multifd: Add new migration option
 for multifd DSA offloading.
In-Reply-To: <CAHObMVZ1rifLMe-6R_Lttu_aOWDPvqv29sa6p_gz_7HROn00Tg@mail.gmail.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711215244.19237-9-yichen.wang@bytedance.com>
 <CAHObMVZ1rifLMe-6R_Lttu_aOWDPvqv29sa6p_gz_7HROn00Tg@mail.gmail.com>
Date: Tue, 16 Jul 2024 21:00:06 -0300
Message-ID: <87y1603n21.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4F4771FCE1
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> On Thu, Jul 11, 2024 at 2:53=E2=80=AFPM Yichen Wang <yichen.wang@bytedanc=
e.com> wrote:
>
>> diff --git a/migration/options.c b/migration/options.c
>> index 645f55003d..f839493016 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -29,6 +29,7 @@
>>  #include "ram.h"
>>  #include "options.h"
>>  #include "sysemu/kvm.h"
>> +#include <cpuid.h>
>>
>>  /* Maximum migrate downtime set to 2000 seconds */
>>  #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
>> @@ -162,6 +163,10 @@ Property migration_properties[] =3D {
>>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationSta=
te,
>>                         parameters.zero_page_detection,
>>                         ZERO_PAGE_DETECTION_MULTIFD),
>> +    /* DEFINE_PROP_ARRAY("dsa-accel-path", MigrationState, x, */
>> +    /*                    parameters.dsa_accel_path, qdev_prop_string, =
char *), */

This is mostly correct, I think, you just need to create a field in
MigrationState to keep the length (instead of x). However, I found out
just now that this only works with QMP. Let me ask for other's
opinions...

>> +    /* DEFINE_PROP_STRING("dsa-accel-path", MigrationState, */
>> +    /*                    parameters.dsa_accel_path), */
>>
>>      /* Migration capabilities */
>>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>
> I changed the dsa-accel-path to be a ['str'], i.e. strList* in C.
> However, I am having a hard time about how to define the proper
> properties here. I don't know what MACRO to use and I can't find good
> examples... Need some guidance about how to proceed. Basically I will
> need this to pass something like '-global
> migration.dsa-accel-path=3D"/dev/dsa/wq0.0"' in cmdline, or
> "migrate_set_parameter dsa-accel-path" in QEMU CLI. Don't know how to
> pass strList there.
>
> Thanks very much!

@Daniel, @Markus, any idea here?

If I'm reading this commit[1] right, it seems we decided to disallow
passing of arrays without JSON, which affects -global on the
command-line and HMP.

1- b06f8b500d (qdev: Rework array properties based on list visitor,
2023-11-09)

QMP shell:
(QEMU) migrate-set-parameters dsa-accel-path=3D['a','b']
{"return": {}}

HMP:
(qemu) migrate_set_parameter dsa-accel-path "['a','b']"
qemu-system-x86_64: ../qapi/string-input-visitor.c:343: parse_type_str:
Assertion `siv->lm =3D=3D LM_NONE' failed.

Any recommendation? I believe all migration parameters so far can be set
via those means, I don't think we can allow only this one to be
QMP-only.

Or am I just missing something?

