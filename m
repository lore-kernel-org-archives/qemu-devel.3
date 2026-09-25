Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA54C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA4vt-0005O3-Cv; Fri, 25 Sep 2026 08:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA4vr-0005Nh-N8
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 08:21:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA4vp-0006AR-UG
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 08:21:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 986181F799;
 Fri, 25 Sep 2026 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790338891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dlhq1rQCcFf4Ok0sJfffEzYV9Y+9RCSxGHwVlX5CKGs=;
 b=uk0k41W+5jALahGAzUnOA8a7FJmFb5c1GJq3utWQAd3mxX/zoo+APoslcmSyerK7HvFITl
 QpHHrn5dokBTvndNRmoRu6NqNBzYpRXhgFIfupsr70GU7WAzr2kDQ1SCCpftbOTqTwbjuq
 R4pLvo4M5zp3Ojq10zvrs4/DGaAxlhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790338891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dlhq1rQCcFf4Ok0sJfffEzYV9Y+9RCSxGHwVlX5CKGs=;
 b=GDYQ3ODQM1Wrds/DZR6FCSN5CwijcownjGMo1bHCPhvqTHvBVPNf+AS/yYPITYUgE7CTzF
 RRyyd4W3t8WarWDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790338887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dlhq1rQCcFf4Ok0sJfffEzYV9Y+9RCSxGHwVlX5CKGs=;
 b=xlpaK3A9DrZQ6ysj0hwtFBxVQh3tSCul6cqXxMp1tfKmGcObY6vBw5/sfmEOBIaLTEjflX
 K0FaUACgWTn0xBbqUf6/TQAA1Jrle2cGQdPyghBNrvqOvJ9Eqz953elgO4Poh0k1keqo58
 Gem/bfzR6YX/GG/DDrVnuzxMdwjFYvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790338887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dlhq1rQCcFf4Ok0sJfffEzYV9Y+9RCSxGHwVlX5CKGs=;
 b=jfgna6GWrVgdmzkYUtVNt228qOjKcO+G2d15Ki3SbAFNei0d2AbTvNK9OUQaIqay9H1CnT
 t2496jSsUE99VKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1963213432;
 Fri, 25 Sep 2026 12:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Mse+K0ZntmpmZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 12:21:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael
 Roth <michael.roth@amd.com>
Subject: Re: [RFC PATCH 07/14] qemu-options: Consolidate qemu_opts_parse*
 functions
In-Reply-To: <arZLO5A3S5A_2yE3@redhat.com>
References: <20260918223002.1892021-1-farosas@suse.de>
 <20260918223002.1892021-8-farosas@suse.de> <arZLO5A3S5A_2yE3@redhat.com>
Date: Fri, 25 Sep 2026 09:21:20 -0300
Message-ID: <87qzih8qtb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

> On Fri, Sep 18, 2026 at 07:29:54PM -0300, Fabiano Rosas wrote:
>> The qemu_opts_parse, qemu_opts_parse_list and qemu_opts_parse_noisily
>> functions all call opts_parse(), they can reuse code.
>>=20
>> Consolidate them at qemu_opts_parse_list(). Use the presence of the
>> Error pointer to determine whether the caller wants to be noisy: if
>> there is an Error pointer, then use it, otherwise print the message.
>>=20
>> This makes the code more opaque, so keep the qemu_opts_parse and
>> qemu_opts_parse_noisily functions as wrappers to make sure the intent
>> at the callers is still clear.
>
> It is also somewhat differnt from the normal semantics in QEMU.
>
> The behaviour of passing NULL for an "Error **errp" parameter
> indicates that the errors are to be ignored/discarded.
>
> This patch introduces atypical semantics, that the errors must
> be printed, so I'm not entirely convinced this patch is a win.
>

I understand. This is the main reason why this series is RFC. I could
exchange the implicit "pass NULL to mean noisily" with an explicit
parameter 'bool noisily'.

>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/unit/test-opts-visitor.c |  2 +-
>>  util/qemu-option.c             | 32 ++++++++++++++++++--------------
>>  2 files changed, 19 insertions(+), 15 deletions(-)
>
>> diff --git a/util/qemu-option.c b/util/qemu-option.c
>> index bb38d305c9..c8e552823b 100644
>> --- a/util/qemu-option.c
>> +++ b/util/qemu-option.c
>> @@ -938,7 +938,23 @@ QemuOpts *qemu_opts_parse(const char *group, const =
char *params,
>>  QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
>>                                 bool permit_abbrev, Error **errp)
>>  {
>> -    return opts_parse(list, params, permit_abbrev, false, false, errp);
>> +    bool noisily =3D !errp;
>> +    QemuOpts *opts =3D NULL;
>> +
>> +    if (noisily) {
>> +        Error *err =3D NULL;
>> +        bool help_wanted =3D !opts_accepts_any(list);
>> +
>> +        opts =3D opts_parse(list, params, permit_abbrev, true, help_wan=
ted, &err);
>> +        if (!opts && err) {
>> +            error_report_err(err);
>> +        }
>> +
>> +    } else {
>> +        opts =3D opts_parse(list, params, permit_abbrev, false, false, =
errp);
>> +    }
>> +
>> +    return opts;
>>  }
>>=20=20
>>  /**
>> @@ -952,19 +968,7 @@ QemuOpts *qemu_opts_parse_list(QemuOptsList *list, =
const char *params,
>>  QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *param=
s,
>>                                    bool permit_abbrev)
>>  {
>> -    Error *err =3D NULL;
>> -    QemuOpts *opts;
>> -    bool help_wanted =3D !opts_accepts_any(list);
>> -
>> -    opts =3D opts_parse(list, params, permit_abbrev, true, help_wanted,=
 &err);
>> -    if (!opts) {
>> -        if (help_wanted) {
>> -            assert(!err);
>> -        } else {
>> -            error_report_err(err);
>> -        }
>> -    }
>> -    return opts;
>> +    return qemu_opts_parse_list(list, params, permit_abbrev, NULL);
>>  }
>>=20=20
>>  static bool qemu_opts_from_qdict_entry(QemuOpts *opts,
>> --=20
>> 2.53.0
>>=20
>>=20
>
> With regards,
> Daniel

