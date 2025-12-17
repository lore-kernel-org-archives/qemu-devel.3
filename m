Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B666D65C7D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 16:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVuZV-00031c-Ff; Wed, 17 Dec 2025 11:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVuZT-000305-6e
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:40:15 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVuZR-0005BY-Bi
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:40:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CCFB5BD35;
 Wed, 17 Dec 2025 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765989611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nins76EGNPs0hv/EmKdjPjAqiYqtTLTolDhuNeLBsWo=;
 b=xfB3VHjzl36va070j5sAg6Kjm1i49/WHTEjVmtDSPGn6GFbrzvnoI9+JzQ9IKyDu98RmZF
 96oVQxYHNb8NjEYzX+aZsI0uj6UK/OHwdlkj+gMfTkAm0/xk9CaU5YgOyBenw4X+Fw3HEI
 +p02W3ssOqljbtl5N3yYA1vfiqlSFIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765989611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nins76EGNPs0hv/EmKdjPjAqiYqtTLTolDhuNeLBsWo=;
 b=buGcQwF/GNJn/K7Ziuona+SMGzZUtBq0m5FzZ+bEXMvuRHgDxK7bHZo6bMuJnSf97bojQo
 W/K3kb4H94mjiIDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nQ85UaKU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jzvj4JUE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765989610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nins76EGNPs0hv/EmKdjPjAqiYqtTLTolDhuNeLBsWo=;
 b=nQ85UaKUOtJyJ3hoCBKIRlJiLOD+2IybE/dhdnc+J8GRHfL+vsN6El7OLDdrihOOJnW7i1
 gRAXrE1Y0oeizSNpE3J5GTaL0VzYAByRzfvsCbw1LX1743pjZLnDRgOB1kHLPcJx7ykKVY
 5W3VVvW7g/8TS6QXZmHjN3/JCajUYaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765989610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nins76EGNPs0hv/EmKdjPjAqiYqtTLTolDhuNeLBsWo=;
 b=jzvj4JUEDr0TFPTjIRwJAYnb9Y9J4f93KsarQ0m6grdhy6BZlzQiXERFL+ii+VuD0rbfK9
 derLmegZR6WGxoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE4F93EA63;
 Wed, 17 Dec 2025 16:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0hBRH+ncQmkYCAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Dec 2025 16:40:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 05/51] migration: Normalize tls arguments
In-Reply-To: <aUGVxIHNbVDba2dc@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-6-farosas@suse.de> <aUGVxIHNbVDba2dc@x1.local>
Date: Wed, 17 Dec 2025 13:40:06 -0300
Message-ID: <87ldj112qh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4CCFB5BD35
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Dec 15, 2025 at 06:59:51PM -0300, Fabiano Rosas wrote:
>> The migration parameters tls_creds, tls_authz and tls_hostname
>> currently have a non-uniform handling. When used as arguments to
>> migrate-set-parameters, their type is StrOrNull and when used as
>> return value from query-migrate-parameters their type is a plain
>> string.
>> 
>> Not only having to convert between the types is cumbersome, but it
>> also creates the issue of requiring two different QAPI types to be
>> used, one for each command. MigrateSetParameters is used for
>> migrate-set-parameters with the TLS arguments as StrOrNull while
>> MigrationParameters is used for query-migrate-parameters with the TLS
>> arguments as str.
>> 
>> Since StrOrNull could be considered a superset of str, change the type
>> of the TLS arguments in MigrationParameters to StrOrNull. Also ensure
>> that QTYPE_QNULL is never used.
>> 
>> 1) migrate-set-parameters will always write QTYPE_QSTRING to
>>   s->parameters, either an empty or non-empty string.
>> 
>> 2) query-migrate-parameters will always return a QTYPE_QSTRING, either
>>   empty or non-empty.
>> 
>> 3) the migrate_tls_* helpers will always return a non-empty string or
>>   NULL, for the internal migration code's consumption.
>> 
>> Points (1) and (2) above help simplify the parameters validation and
>> the query command handling because s->parameters is already kept in
>> the format that query-migrate-parameters (and info migrate_paramters)
>> expect. Point (3) is so people don't need to care about StrOrNull in
>> migration code.
>> 
>> This will allow the type duplication to be removed in the next
>> patches.
>> 
>> Note that the type of @tls_creds, @tls-hostname, @tls-authz changes
>> from str to StrOrNull in introspection of the query-migrate-parameters
>> command. We accept this imprecision to enable de-duplication.
>> 
>> There's no need to free the TLS options in
>> migration_instance_finalize() because they're freed by the qdev
>> properties .release method.
>> 
>> Temporary in this patch:
>> migrate_params_test_apply() copies s->parameters into a temporary
>> structure, so it's necessary to drop the references to the TLS options
>> if they were not set by the user to avoid double-free. This is fixed
>> in the next patches.
>> 
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> [...]
>
>> @@ -403,6 +403,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>          monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
>>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>>              params->xbzrle_cache_size);
>> +        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> +            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
>> +            params->max_postcopy_bandwidth);
>>  
>>          if (params->has_block_bitmap_mapping) {
>>              const BitmapMigrationNodeAliasList *bmnal;
>
> This chunk seems to be introduced by accident and removed in patch 18..
>

Yes, rebase mistake. Thanks.

