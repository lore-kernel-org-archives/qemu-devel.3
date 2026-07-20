Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F523C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlpqI-00076X-Gm; Mon, 20 Jul 2026 11:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wlpqG-000764-Qs
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:23:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wlpqF-0001NW-2f
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:23:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EDD63E23;
 Mon, 20 Jul 2026 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784561016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5tPuo1xRGF1vjewjDIfx78o6HHCQjfbdIeumnw4Cqw=;
 b=R4e/JONCfSKecEZ70D/cvKc6pkjKr4tAP0BegTulHWt3pkbwWjOMb1I44Mugoh3XVUgmU+
 rWJZkeUrEExSHgTKvekNYKQ8moWrh+1EcDLLLhsJvoHm4iATGy8/udrHjkCUi9qnOam6Br
 WmKVnO1uZUzXMat5gMq3GrrV0Dgtris=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784561016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5tPuo1xRGF1vjewjDIfx78o6HHCQjfbdIeumnw4Cqw=;
 b=vGJI2hCYcc1XRg+KPqmKB5qU1sdv3cNTIWmykkj8srJcXFtsuPvBi30z9eqfIg8OVwNsVa
 KuTXhFYgNDGxsHAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784561016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5tPuo1xRGF1vjewjDIfx78o6HHCQjfbdIeumnw4Cqw=;
 b=R4e/JONCfSKecEZ70D/cvKc6pkjKr4tAP0BegTulHWt3pkbwWjOMb1I44Mugoh3XVUgmU+
 rWJZkeUrEExSHgTKvekNYKQ8moWrh+1EcDLLLhsJvoHm4iATGy8/udrHjkCUi9qnOam6Br
 WmKVnO1uZUzXMat5gMq3GrrV0Dgtris=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784561016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5tPuo1xRGF1vjewjDIfx78o6HHCQjfbdIeumnw4Cqw=;
 b=vGJI2hCYcc1XRg+KPqmKB5qU1sdv3cNTIWmykkj8srJcXFtsuPvBi30z9eqfIg8OVwNsVa
 KuTXhFYgNDGxsHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB439779AA;
 Mon, 20 Jul 2026 15:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Sy7jHnc9XmrpBgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 20 Jul 2026 15:23:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
In-Reply-To: <alpIDh7WOcFsa9EA@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <alj4V6I__bCOjRTt@redhat.com> <87ech24wcz.fsf@suse.de>
 <alpIDh7WOcFsa9EA@redhat.com>
Date: Mon, 20 Jul 2026 12:23:33 -0300
Message-ID: <874iht4rd6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

>> >> E) The migration source QEMU process is assumed to be secure. Comprom=
ise
>> >> of the source QEMU process is nonetheless possible but exploiting the
>> >> migration process is expected to grant no further privileges.
>> >
>> > This is the tricky assumption.
>> >
>> > Cnsider source host as 2 QEMU processes, one of tenant A and
>> > one for tenant B.
>> >
>> > If tenant A compromises their QEMU, and can wait until a live
>> > migration for tenant B is initiating, potentially tenant A can
>> > connect to a dest QEMU for tenant B. I would consider that to
>> > be gaining privileges.
>> >
>>=20
>> I thought of that, but I can't understand how "dest QEMU for tenant B"
>> isn't just "dest QEMU for tenant A that has now took over". If none of
>> the stream from source B is reaching dest B, then that's harmless.
>
> Two VMs configured with identical virtual hardware should have
> the same vmstate structure, and so be compatible from the
> POV of live migration flow. They can none the less have different
> backend connections. So if tenant A can connect to a incoming
> QEMU from tenant B, the live migration can probably succeed,
> thus giving tenant A a working VM but with the HDD now backed
> by data belonging to tenant B.
>

Ok, I haven't thought about the storage aspect. In the scenario you
describe, there's nothing the migration code can currently do to avoid
such an exploit. The "migration process" seen as a larger thing is
vulnerable and there's currently no code in QEMU whether broken or
behaving properly that would stop this attack. We're kind of back to
what Peter said that compromised source is game over. Unless I'm missing
some mechanism.

>
>> > With TLS we lack fine grained authentication in common setups
>> > today that rely on x509 certs configured per-host, not per-QEMU.
>> >
>> > In current libvirt we're introducing oout of the box support for
>> > TLS PSK, which means live migration sessions will be tied to
>> > individual matched (src,dst) QEMU pairs, so even if tenant A is
>> > compromised they would be able to do a TLS handshake for tenant
>> > B's dst QEMU.
>> >
>>=20
>> ITYM "wouldn't be able".
>
> Yes.
>
>> > I'd like app mgmt apps to switch to PSK instad of x509 for
>> > live migration, but that'll take along time.
>> >
>>=20
>> Is TLS PSK a reasonable setup to expect and to include in this policy?
>
> We should probably have a standalone doc for migraton detailing
> the recommended configuration scenarios, we could then link to
> from this doc if needed.
>
>
>> > WIth this it seems like the only 2 scenarios where a migration security
>> > flaw can be issued are:
>> >
>> >  * Something goes wrong before/during the TLS handshake
>> >  * A bug in source QEMU, somehow allows a guest OS user
>> >    to set magic device data that turns into an exploitable
>> >    VM state record.
>> >
>>=20
>> We don't need a bug in source QEMU, the magic data could be within
>> accepted parameters.
>
> I guess there could be a bug in the dest QEMU that trips up over
> otherwise valid vmstate data. Dn't recall seeing an example of it
> but never say never.
>
>
> With regards,
> Daniel

