Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2963FC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2VZx-0003Ua-SP; Fri, 04 Sep 2026 11:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2VZw-0003Tz-2z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:11:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2VZu-0002jP-7a
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:11:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7444C21D3F;
 Fri,  4 Sep 2026 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788534694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wwxed4RAYOP6K1zGX8c9yybcHev5O24BqBMvVkTvsg=;
 b=HyoEIJw2OD9W9Aa0AkQIRo+Vjc1VBg/DpiCO0pZ7/1M3Kf/AXUaj87Um8v4H1Up22xmCOC
 S+75m96JsGXrXOoxQP9SCriLIJnq1n138X5rP1BVpJyiiBlkIfwOmiz4rfdIsP0dBuATFk
 xwIdILynClm0AN6JiQ99X3L+Mm8uflk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788534694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wwxed4RAYOP6K1zGX8c9yybcHev5O24BqBMvVkTvsg=;
 b=ewOXeWH1IH+w2Y7CdDZFexA1yV3bKgdygFoq4twCYpDqYtTlMT8Wq+mktIt9uwAU/Wp7/g
 PgCP67lMnymq0fCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788534690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wwxed4RAYOP6K1zGX8c9yybcHev5O24BqBMvVkTvsg=;
 b=OsSoYKZ0cGlVXSrufEkTfavozN5dHWNdu5Pr9/fsDn7lrsNQ/olXJqUyHn5AyHBxoN2nrw
 L6k+EuVx83mW6IEmPtP/I/4I5yE/Wi9gacQtlFcl8pCQFz1j5hSGhIo/Yxzd9fgdbT28Pv
 5fIhpCqAENxLj6rVdTjTYLUeW6ssB4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788534690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wwxed4RAYOP6K1zGX8c9yybcHev5O24BqBMvVkTvsg=;
 b=3ZDjBWSZdYYssu+L+x11Ki0/0SZbxPFbKxnxECMGFjDyJMkouW9vn5/94K9o2VyZzvCrk9
 68/u9zlUwWZ76hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F160213726;
 Fri,  4 Sep 2026 15:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ry8MMKHfmmobdAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Sep 2026 15:11:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 10/18] migration: Validate that all params are set for
 query
In-Reply-To: <apnDfpdyAzo2Vuwc@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-11-farosas@suse.de> <apnDfpdyAzo2Vuwc@x1.local>
Date: Fri, 04 Sep 2026 12:11:27 -0300
Message-ID: <87ld9h6ogw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Sep 02, 2026 at 07:15:38PM -0300, Fabiano Rosas wrote:
>> There are a couple of situations where all fields of a
>> MigrationParameters object need to be marked as present: when cloning
>> an entire object and when creating the transient object in
>> qmp_query_migrate(). The query-migrate-parameters QMP command contract
>> requires that all parameters, except block-bitmap-mapping, are present
>> in the output.
>>=20
>> Validate that a given object has all has_* fields set to true.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>=20
>> diff --git a/migration/options.c b/migration/options.c
>> index bd7be8f9832..5d17acdd881 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -12,6 +12,7 @@
>>   */
>>=20=20
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/units.h"
>>  #include "exec/target_page.h"
>> @@ -23,8 +24,10 @@
>>  #include "qapi/qmp/qerror.h"
>>  #include "qapi/qobject-input-visitor.h"
>>  #include "qapi/qobject-output-visitor.h"
>> +#include "qobject/qbool.h"
>>  #include "qobject/qdict.h"
>>  #include "qobject/qnull.h"
>> +#include "qobject/qstring.h"
>>  #include "system/runstate.h"
>>  #include "migration/colo.h"
>>  #include "migration/cpr.h"
>> @@ -1149,12 +1152,63 @@ static void migrate_mark_all_params_present(Migr=
ationParameters *p)
>>      }
>>  }
>>=20=20
>> +static bool assert_all_params_present(MigrationParameters *params, Erro=
r **errp)
>> +{
>> +    g_autoptr(QDict) d =3D migrate_params_to_dict(params, errp);
>> +    const QDictEntry *e =3D NULL;
>> +    int i =3D 0;
>> +
>> +    if (!d) {
>> +        return false;
>> +    }
>> +
>> +    for (e =3D qdict_first(d); e; e =3D qdict_next(d, e), i++) {
>> +        const char *key =3D qdict_entry_key(e);
>> +        const char *p;
>> +
>> +        if (strstart(key, "tls-", &p)) {
>> +            QString *s =3D qobject_to(QString, qdict_entry_value(e));
>> +
>> +            if (!s) {
>> +                break;
>> +            }
>> +        } else if (strstart(key, "has-", &p)) {
>
> Does the qdict contain any has- field?=20=20
>

=C2=AC=C2=AC

I guess that decides the fate of the MigrationParameter enum.

> visit_type_MigrationParameters_members:
>
>     if (visit_optional(v, "announce-initial", &obj->has_announce_initial)=
) {
>         if (!visit_type_size(v, "announce-initial", &obj->announce_initia=
l, errp)) {
>             return false;
>         }
>     }
>     ...
>
> It seems the has_* fields are only used to identify existance of objects,
> not converted.
>
>> +            if (qdict_haskey(d, p)) {
>> +                QBool *b =3D qobject_to(QBool, qdict_entry_value(e));
>> +
>> +                If (!b || !qbool_get_bool(b)) {
>> +                    break;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    if (i && !e) {
>> +        return true;
>> +    }
>> +
>> +    /*
>> +     * Should never happen, but avoid asserting becase this is
>> +     * reachable from QMP.
>
> IIUC as long as this fact shouldn't be changed by any possible user input,
> we could still assert.  But I understand you want to be careful, maybe
> either (1) directly assert, or (2) change the function name,
> s/assert/check/?  I vote (1).
>
> Said that, if the qdict trick didn't work it beats the whole patch.. so
> IMHO we can also leave this sanity check for later too.  Your call.
>
>> +     */
>> +    error_setg(errp, "Missing parameter. Query output will be incomplet=
e.");
>> +    return false;
>> +}
>> +
>>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>  {
>>      MigrationState *s =3D migrate_get_current();
>>      MigrationParameters *params =3D QAPI_CLONE(MigrationParameters,
>>                                               &s->parameters);
>>=20=20
>> +    /*
>> +     * Validate all parameters have their has_* field set to true as
>> +     * consequence of the initial migrate_mark_all_params_present().
>> +     */
>> +    if (!assert_all_params_present(params, errp)) {
>> +        return NULL;
>> +    }
>> +
>>      /*
>>       * The block-bitmap-mapping breaks the expected API of
>>       * query-migrate-parameters of having all members present. To keep
>> --=20
>> 2.53.0
>>=20

