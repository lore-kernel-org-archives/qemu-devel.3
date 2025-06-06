Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA5BC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXWS-0004Ti-13; Fri, 06 Jun 2025 09:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNXWM-0004Qz-Qs
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:54:11 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNXWD-0006al-OT
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:54:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D65621F445;
 Fri,  6 Jun 2025 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749218006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94U5K4uUciJ36vXt7pWmpDSrFR/4JX1g0D9J7FyhREI=;
 b=qiI5FA2oFwXZ2uQK5+l7UjOtpcMCvaNO9OzUmq8rDhw6eycNW3/5W+vpvsMoTiPBQkgB+Q
 XJrbMwCalWV3USUi3fVgJQHyJa+aSEasy4vlYT8494Zt7iLtqfc53DATMpZrahDuymeuT8
 1iSrYOrdRhfedyOOV+XyE+K1Q9qlAxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749218006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94U5K4uUciJ36vXt7pWmpDSrFR/4JX1g0D9J7FyhREI=;
 b=FE9fZvpFGr++hpFzGZPzs2mx6qBgu/c0rve9eVMfV2vlGBYnEj2hevpINg5qydzPtL0MEK
 9STXOu6YAt7nriCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749218006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94U5K4uUciJ36vXt7pWmpDSrFR/4JX1g0D9J7FyhREI=;
 b=qiI5FA2oFwXZ2uQK5+l7UjOtpcMCvaNO9OzUmq8rDhw6eycNW3/5W+vpvsMoTiPBQkgB+Q
 XJrbMwCalWV3USUi3fVgJQHyJa+aSEasy4vlYT8494Zt7iLtqfc53DATMpZrahDuymeuT8
 1iSrYOrdRhfedyOOV+XyE+K1Q9qlAxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749218006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94U5K4uUciJ36vXt7pWmpDSrFR/4JX1g0D9J7FyhREI=;
 b=FE9fZvpFGr++hpFzGZPzs2mx6qBgu/c0rve9eVMfV2vlGBYnEj2hevpINg5qydzPtL0MEK
 9STXOu6YAt7nriCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 532891336F;
 Fri,  6 Jun 2025 13:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HIhGBdbyQmh9CAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Jun 2025 13:53:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH 16/21] qapi/migration: Mark that
 query/set-migrate-parameters support capabilities
In-Reply-To: <aD654nsXOrCg9umj@redhat.com>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-17-farosas@suse.de> <aD654nsXOrCg9umj@redhat.com>
Date: Fri, 06 Jun 2025 10:53:23 -0300
Message-ID: <87ikl9vuwc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jun 02, 2025 at 10:38:05PM -0300, Fabiano Rosas wrote:
>> Add a QAPI command feature "capabilities" that can be queried by the
>> client to check that the parameters commands now also support
>> capabilities.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  qapi/migration.json | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 5942622ba7..557a9c523e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -776,6 +776,13 @@
>>  #
>>  # Set various migration parameters.
>>  #
>> +# Features:
>> +#
>> +# @capabilities: Indicates this command supports setting the set of
>> +# parameters previously known as capabilities.  This means this
>> +# command can (and should) be used instead of the depreacated
>> +# @migrate-set-capabilities.
>> +#
>>  # Since: 2.4
>>  #
>>  # .. qmp-example::
>> @@ -785,7 +792,8 @@
>>  #     <- { "return": {} }
>>  ##
>>  { 'command': 'migrate-set-parameters', 'boxed': true,
>> -  'data': 'MigrationParameters' }
>> +  'data': 'MigrationParameters',
>> +  'features': [ 'capabilities' ] }
>>=20=20
>>  ##
>>  # @MigrationParameters:
>> @@ -1110,6 +1118,13 @@
>>  #
>>  # Returns: @MigrationParameters
>>  #
>> +# Features:
>> +#
>> +# @capabilities: Indicates this command supports setting the set of
>> +# parameters previously known as capabilities.  This means this
>> +# command can (and should) be used instead of the depreacated
>> +# @migrate-set-capabilities.
>> +#
>>  # Since: 2.4
>>  #
>>  # .. qmp-example::
>> @@ -1125,7 +1140,8 @@
>>  #        }
>>  ##
>>  { 'command': 'query-migrate-parameters',
>> -  'returns': 'MigrationParameters' }
>> +  'returns': 'MigrationParameters',
>> +  'features': [ 'capabilities' ] }
>>
>
> Adding QAPI "features" is only needed if there is no other viable
> way to detect existence of the feature. In this case, apps can
> trivially detect the feature by querying the QAPI schema and
> identifying that the MigrationParameters struct has gained a
> load of new fields. So IMHO this patch can be dropped.
>

Oh, ok. I was thinking this would be friendlier to the management layer,
but if it's all the same I'll drop it. Same for the other one in patch
19.

Thanks

