Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25AACD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWCi-00089x-SH; Fri, 05 Jun 2026 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wVWBU-0007v6-AX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:10:10 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wVWBD-0000b8-27
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:10:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 410B76B34F;
 Fri,  5 Jun 2026 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780672018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIbgIMmdxHdu6Z+tMe+rvAelnCNQmcaO7KIff7gZWdE=;
 b=PyShQUUXIjgQE6FvYJTgCrLSj4+EpN00CiIo8v2P4zV1IFqmSSWMiMOP/AMnO2c2a//fNU
 yEKj32BTenHKGGz/eINpEPoWmgYHwWFiAHuvMz2FInncZlF/hlRqfFHYP46LjnrGXoWprP
 IPa5GvooJeDGTuE0dn2zWyCOgMMDKAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780672018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIbgIMmdxHdu6Z+tMe+rvAelnCNQmcaO7KIff7gZWdE=;
 b=coA7/e5P0hDi6QR62Y6suqI2IfZ6KvSISQCwlYjHGkTsD3WV3nQbku9/Yuo/1EFJJt8kv6
 82EMdQ/pYVxx67DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780672018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIbgIMmdxHdu6Z+tMe+rvAelnCNQmcaO7KIff7gZWdE=;
 b=PyShQUUXIjgQE6FvYJTgCrLSj4+EpN00CiIo8v2P4zV1IFqmSSWMiMOP/AMnO2c2a//fNU
 yEKj32BTenHKGGz/eINpEPoWmgYHwWFiAHuvMz2FInncZlF/hlRqfFHYP46LjnrGXoWprP
 IPa5GvooJeDGTuE0dn2zWyCOgMMDKAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780672018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIbgIMmdxHdu6Z+tMe+rvAelnCNQmcaO7KIff7gZWdE=;
 b=coA7/e5P0hDi6QR62Y6suqI2IfZ6KvSISQCwlYjHGkTsD3WV3nQbku9/Yuo/1EFJJt8kv6
 82EMdQ/pYVxx67DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D524F779A8;
 Fri,  5 Jun 2026 15:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zoQLKRHmImrHcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 05 Jun 2026 15:06:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Sana Sharma
 <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 2/4] qdev: Introduce helper object_apply_globals()
In-Reply-To: <aiLhcXUxVQ1K_6xA@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-3-peterx@redhat.com> <aiKOalYvribeaiqw@redhat.com>
 <87cxy56o80.fsf@suse.de> <aiLhcXUxVQ1K_6xA@redhat.com>
Date: Fri, 05 Jun 2026 12:06:55 -0300
Message-ID: <878q8t6n74.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Jun 05, 2026 at 11:44:47AM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Thu, Jun 04, 2026 at 07:11:16PM -0400, Peter Xu wrote:
>> >> The helper allows one object to apply anything from -global command l=
ines
>> >> to an object.
>> >>=20
>> >> Signed-off-by: Peter Xu <peterx@redhat.com>
>> >> ---
>> >>  include/hw/core/qdev-properties.h | 1 +
>> >>  hw/core/qdev-properties.c         | 5 +++++
>> >>  2 files changed, 6 insertions(+)
>> >>=20
>> >> diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev=
-properties.h
>> >> index eba5436e53..779acb31b6 100644
>> >> --- a/include/hw/core/qdev-properties.h
>> >> +++ b/include/hw/core/qdev-properties.h
>> >> @@ -268,6 +268,7 @@ const GlobalProperty *qdev_find_global_prop(Objec=
t *obj,
>> >>                                              const char *name);
>> >>  int qdev_prop_check_globals(void);
>> >>  void qdev_prop_set_globals(DeviceState *dev);
>> >> +void object_apply_globals(Object *obj);
>> >>  void error_set_from_qdev_prop_error(Error **errp, int ret, Object *o=
bj,
>> >>                                      const char *name, const char *va=
lue);
>> >>=20=20
>> >> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> >> index 8f870c85fc..a91c2ad101 100644
>> >> --- a/hw/core/qdev-properties.c
>> >> +++ b/hw/core/qdev-properties.c
>> >> @@ -1045,6 +1045,11 @@ void qdev_prop_set_globals(DeviceState *dev)
>> >>                                dev->hotplugged ? NULL : &error_fatal);
>> >>  }
>> >>=20=20
>> >> +void object_apply_globals(Object *obj)
>> >> +{
>> >> +    object_apply_global_props(obj, global_props(), &error_fatal);
>> >> +}
>> >
>> > If a method has the "object_" prefix and takex "Object *" as its
>> > instance, then it needs to live in qom/object.c / include/qom/object.h
>> > but this again has the complexity of relying on the qdev Property
>> > struct.  This is really mixing qdev & qom layers together which I
>> > find pretty unpleasant.
>> >
>>=20
>> True, but code like qdev_property_add_static() already mixes things up
>> quite a bit. Not that this is justification to mix it even more, of
>> course.
>
> That's not the same scenario as it is exclusively qdev code, using
> qdev_ name prefix and taking "Device *" not "Object *".
>

Reading your message again, I misinterpreted you as arguing against the
overall coupling of ObjectProperty and Property. I agree with the
specific point of the abstraction layers.

> With regards,
> Daniel

