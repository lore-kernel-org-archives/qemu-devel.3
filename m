Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616DAC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 17:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI9td-0004r2-K7; Thu, 22 May 2025 13:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uI9tb-0004qU-Fr
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:39:55 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uI9tZ-0007DG-Go
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:39:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C67F921B4D;
 Thu, 22 May 2025 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747935591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhtJQHP3SZsACA2ri7Ky6yw4ifL7MswHbA1sEXlRsIo=;
 b=O1/wsQYTSerMFipt72F00U+iqGy9Yvkx5JmvEYB30SjcTSBrRlljYb3amY6hSOk75VrXwZ
 RbyXB7/hIpGu5BM6MZSa2syZbI4iNmThcm0Jn+Bcb/yB9Uc72LrL2GEJNwSDnBv+acWPBv
 Wm87+teH8WCHxUOBaOCixHuN9uK5NK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747935591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhtJQHP3SZsACA2ri7Ky6yw4ifL7MswHbA1sEXlRsIo=;
 b=bH544mwGnQ3yjYUCwVSDX+Lcg/+v1FtTHE+MRaunUkHTPqDfwh+8at+FEYWqVDMZhas0jr
 ItMGPy+q2ljP4eAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747935591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhtJQHP3SZsACA2ri7Ky6yw4ifL7MswHbA1sEXlRsIo=;
 b=O1/wsQYTSerMFipt72F00U+iqGy9Yvkx5JmvEYB30SjcTSBrRlljYb3amY6hSOk75VrXwZ
 RbyXB7/hIpGu5BM6MZSa2syZbI4iNmThcm0Jn+Bcb/yB9Uc72LrL2GEJNwSDnBv+acWPBv
 Wm87+teH8WCHxUOBaOCixHuN9uK5NK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747935591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhtJQHP3SZsACA2ri7Ky6yw4ifL7MswHbA1sEXlRsIo=;
 b=bH544mwGnQ3yjYUCwVSDX+Lcg/+v1FtTHE+MRaunUkHTPqDfwh+8at+FEYWqVDMZhas0jr
 ItMGPy+q2ljP4eAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4004A13433;
 Thu, 22 May 2025 17:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3UN3O2ZhL2iHTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 May 2025 17:39:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 04/13] migration: Fix parameter validation
In-Reply-To: <87r00g61n5.fsf@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-5-farosas@suse.de> <aCZVolkNMBZb5KvC@x1.local>
 <87r00g61n5.fsf@suse.de>
Date: Thu, 22 May 2025 14:39:48 -0300
Message-ID: <87o6vk5yu3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.969]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Fri, Apr 11, 2025 at 04:14:34PM -0300, Fabiano Rosas wrote:
>>> The migration parameters validation involves producing a temporary
>>> structure which merges the current parameter values with the new
>>> parameters set by the user.
>>> 
>>> The has_ boolean fields of MigrateSetParameter are taken into
>>> consideration when writing the temporary structure, however the copy
>>> of the current parameters also copies all the has_ fields of
>>> s->parameters and those are (almost) all true due to being initialized
>>> by migrate_params_init().
>>> 
>>> Since the temporary structure copy does not carry over the has_ fields
>>> from MigrateSetParameters, only the values which were initialized in
>>> migrate_params_init() will end up being validated. This causes
>>> (almost) all of the migration parameters to be validated again every
>>> time a parameter is set, which could be considered a bug. But it also
>>> skips validation of those values which are not set in
>>> migrate_params_init(), which is a worse issue.
>>
>> IMHO it's ok to double check all parameters in slow path.  Definitely not
>> ok to skip them.. So now the question is, if migrate_params_test_apply() so
>> far should check all params anyway...

Actually, this doesn't work...

The migrate-set-* commands have optional fields, so we need some form of
checking has_* to know which fields the user is setting. Otherwise
MigrationSetParameters will have zeros all over that will trip the
check.

Then, we need some form of checking has_* to be able to enventually get
the values into s->config (former s->parameters/capabilities), otherwise
we'll overwrite the already-set values with the potentially empty ones
coming from QAPI.

Then there's also the issue of knowing whether a value is 0 because the
user set it 0 or because it was never set.

We also can't apply an invalid value to s->config and validate it after
because some parameters are allowed to be changed during migration.


