Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DC0C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 13:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tivWe-0004BQ-JA; Fri, 14 Feb 2025 08:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tivWb-0004BC-BN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:14:33 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tivWX-0003T1-BC
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:14:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 948C21F385;
 Fri, 14 Feb 2025 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739538856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5yfkZRU8CPrPI0m9Q+4t3NeRGC0X2JvvOIBZVmif1Y=;
 b=zd5yh9MLcjMbkichZJn8bDoIwutV0cTqol3c3vjwoUCcdTBHPqL+skESphK9pf5gd5AN+R
 MUDvduHh8Ts51nxVOO6NevT3yk5KdwX79hga/7hrkNZBuzNJVBePllWufsOyGlqXagi6hB
 7cFfKM+RXtaBfH+bURA91aKN6dOV3zQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739538856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5yfkZRU8CPrPI0m9Q+4t3NeRGC0X2JvvOIBZVmif1Y=;
 b=IugnT3dVjsr2XzrlA89ZRI+X0ncoiolrndGdtAUJ6JYOKmVEodeD8smqWAFlnX+DrNFXHv
 PRzV6lzZa4GtCfCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t5F9Fm36;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uQduSE9t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739538851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5yfkZRU8CPrPI0m9Q+4t3NeRGC0X2JvvOIBZVmif1Y=;
 b=t5F9Fm36yKGducpG7bIXjU1KCsk/PRIl/5g2TnF6KHl1pXfTnU0qm9+Iclc4PyYRHGcMyw
 m9mz9DiG4YJ0+SW6eiQWISNaeoN5TgCdew82y6XGYAiDHc4cMxKeS9UbeNpx6QQMsIWbWW
 OpzsicGsJTZ7TW/1PjZh1Dtll0vBEGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739538851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5yfkZRU8CPrPI0m9Q+4t3NeRGC0X2JvvOIBZVmif1Y=;
 b=uQduSE9toXc7M/U1VBTi52MZGXnWpuCUUOQ7mBNyzvLGUHFQZl38E25DPiopjb+pmNWRn5
 PQcfCKhWrTBhYZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01FC0137DB;
 Fri, 14 Feb 2025 13:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aDFsLKJBr2cOCAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 13:14:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu
 <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: use parameters.mode in cpr_state_save
In-Reply-To: <5dfa4bc5-fa4d-4047-b212-dec3b57457f6@oracle.com>
References: <1738788841-211843-1-git-send-email-steven.sistare@oracle.com>
 <Z6PX-Shf7UREfLD7@x1.local>
 <b30ab9b0-2ca2-4bfa-ab11-a09d73bd85b4@oracle.com>
 <5dfa4bc5-fa4d-4047-b212-dec3b57457f6@oracle.com>
Date: Fri, 14 Feb 2025 10:14:08 -0300
Message-ID: <87h64wvfbz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 948C21F385
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_NIXSPAM_FAIL(0.00)[2a07:de40:b281:104:10:150:64:97:query timed out];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 2/5/2025 4:52 PM, Steven Sistare wrote:
>> On 2/5/2025 4:28 PM, Peter Xu wrote:
>>> On Wed, Feb 05, 2025 at 12:54:01PM -0800, Steve Sistare wrote:
>>>> qmp_migrate guarantees that cpr_channel is not null for
>>>> MIG_MODE_CPR_TRANSFER when cpr_state_save is called:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 qmp_migrate()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->parameters.mod=
e =3D=3D MIG_MODE_CPR_TRANSFER && !cpr_channel) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpr_state_save(cpr_ch=
annel)
>>>>
>>>> but cpr_state_save checks for mode differently before using channel,
>>>> and Coverity cannot infer that they are equivalent in outgoing QEMU,
>>>> and warns that channel may be NULL:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 cpr_state_save(channel)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigMode mode =3D migr=
ate_mode();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mode =3D=3D MIG_M=
ODE_CPR_TRANSFER) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 f =3D cpr_transfer_output(channel, errp);
>>>>
>>>> To make Coverity happy, use parameters.mode in cpr_state_save.
>>>>
>>>> Resolves: Coverity CID 1590980
>>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> =C2=A0 migration/cpr.c | 3 ++-
>>>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index 584b0b9..7f20bd5 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -8,6 +8,7 @@
>>>> =C2=A0 #include "qemu/osdep.h"
>>>> =C2=A0 #include "qapi/error.h"
>>>> =C2=A0 #include "migration/cpr.h"
>>>> +#include "migration/migration.h"
>>>> =C2=A0 #include "migration/misc.h"
>>>> =C2=A0 #include "migration/options.h"
>>>> =C2=A0 #include "migration/qemu-file.h"
>>>> @@ -132,7 +133,7 @@ int cpr_state_save(MigrationChannel *channel, Erro=
r **errp)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUFile *f;
>>>> -=C2=A0=C2=A0=C2=A0 MigMode mode =3D migrate_mode();
>>>> +=C2=A0=C2=A0=C2=A0 MigMode mode =3D migrate_get_current()->parameters=
.mode;
>>>
>>> Are we sure this can make coverity happy?
>>=20
>> It should, based on Peter Maydell's analysis, but I would appreciate
>> if he could apply and test the fix.
>>=20
>>> Another more straightforward change is caching migrate mode in
>>> qmp_migrate() and also check that before invoking cpr_state_save().
>>=20
>> Surely anyone would consider my one-line change to be straight forward.
>
>
> Given that Coverity complains about channel, and not mode, this is the
> most direct fix:
>
> ----------------------------------------
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 59644e8..224b6ff 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -160,6 +160,7 @@ int cpr_state_save(MigrationChannel *channel, Error *=
*errp)
>       trace_cpr_state_save(MigMode_str(mode));
>
>       if (mode =3D=3D MIG_MODE_CPR_TRANSFER) {
> +        g_assert(channel);
>           f =3D cpr_transfer_output(channel, errp);
>       } else {
>           return 0;
> -------------------------------
>
> - Steve

Queueing this^ version. Thanks

