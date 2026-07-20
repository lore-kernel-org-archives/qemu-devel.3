Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CD0C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqhR-0005g5-4V; Mon, 20 Jul 2026 12:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wlqdT-0003lQ-Rc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:14:34 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wlqdP-00086Z-U3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:14:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFC073E62;
 Mon, 20 Jul 2026 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784564066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfa/PGAd4uynsgTLCAN8zy5kI1rq7speraonJ3KnCGo=;
 b=lKZhbYhE12WbvjumBXDmvGlJRUDQGK/YDC0lznpafePLCH4YZpFRnVOdFWu/YyIZ4SZyIm
 cuB/iEoOolAx3O2CpvYRzWlh+U/qabePB6++r+puNO6JA03U4Es5fzk/YnDCyuVHj/LzlG
 9c8cprhLNELIMz0DLR9lz8JZXnlfyVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784564066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfa/PGAd4uynsgTLCAN8zy5kI1rq7speraonJ3KnCGo=;
 b=xe/p0CYXPPV2mIlD37CVlHPS2eb/kMVQY9NFKkuOjUdazaahzFi7vVncsilejW30/jKgrF
 qflUWQOnpgJZ3ODA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wwu1Jkqd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="x2/xeZCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784564065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfa/PGAd4uynsgTLCAN8zy5kI1rq7speraonJ3KnCGo=;
 b=wwu1JkqdhmJcHWMR+ksm8RURzCIDH4MrQ+GaUa0YJNOnX2TwvCbnAvw9nbSEC6ayUa7fPC
 O3aqx6JRrT++qFyITGcPdREBfPgZfh590bTizgE+43eCYJsfSlau1ks9dTuQGm0inIQ9IR
 6DeVf/I4OsMRbIYzYbCZ7jEeCl0fpJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784564065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfa/PGAd4uynsgTLCAN8zy5kI1rq7speraonJ3KnCGo=;
 b=x2/xeZCH9tdABXKwZ40BkhOT0vK9n24oXEInJboCkVybTo401u+sZb3gKWqxtdbZfLEe8O
 t8syTiv1GFVCMKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66007779AA;
 Mon, 20 Jul 2026 16:14:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o8PmDWFJXmpROQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 20 Jul 2026 16:14:25 +0000
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
In-Reply-To: <al46bcG96ARl5Rf6@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <al46bcG96ARl5Rf6@redhat.com>
Date: Mon, 20 Jul 2026 13:14:18 -0300
Message-ID: <87zezl3ag5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CFC073E62
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[12]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

> On Thu, Jul 16, 2026 at 11:08:49AM -0300, Fabiano Rosas wrote:
>> Assumptions:
>>=20
>> A) The migration stream is assumed to be secured by TLS on a per-host
>> basis.
>>=20
>> B) For migration streams stored to file, including snapshots, it is
>> assumed that the storage file is authentic, i.e. the files are owned by
>> the party performing the live migration and have not been tampered with.
>>=20
>> C) The network ports used for migration are expected to be available
>> only during migration. No long-standing listening destination QEMU
>> process.
>>=20
>> D) The network used for migration is expected to be adequately isolated.
>>=20
>> E) The migration source QEMU process is assumed to be secure. Compromise
>> of the source QEMU process is nonetheless possible but exploiting the
>> migration process is expected to grant no further privileges.
>
>
> In the security.rst doc, we have an "Architecture" heading where
> we outline design principals  for security. The "Assumptions" feels
> like it has overlap with that section.
>

What if we tweak that section to be more broad?

- Under "Guest Isolation":

Disk image files and network traffic must be protected from other guests...

s/unless explicitly shared between/, users and processes unless explicitly =
shared with/

... them by the user.

- Under Isolation Mechanisms, we can add a bullet:

  - Transport Layer Security (TLS) protocol can be used to ensure
    hypervisor authenticity and encryption of the live migration
    connection.

I can send a separate patch with this.

>> For security consideration, the following are considered:
>>=20
>> OUT OF SCOPE:
>>=20
>> 1) Abort of destination QEMU process while migration is still in course.
>> Rationale: the source virtual machine is not affected.
>>=20
>> 2) Migration failure.
>> Rationale: eventual failed migrations are part of normal operation.
>>=20
>> 3) Memory over-allocation issues in the destination QEMU process.
>> Rationale: the destination host's operating system is expected to
>> constrain resource usage. Process termination due to OOM falls under
>> point 1 above.
>
> The "Security boundary scope" section has primarily been listing
> things that are definitely "out of scope".
>

I think the only point not yet covered is the destination crash
situation, could we add this to your patch?

* **migration and snapshots**. Migration failures and snapshot load
failures are considered part of normal operation as long as the source
virtual machine and savevm file, respectively, are still
functional. Aborting the QEMU process at the migration/snapshot
destination is similarly not considered a security issue.

> ...so I'm not sure we especially need an "in scope" section.

ok, let's leave it behind.


