Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137B6CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwL1-0001f3-Rs; Thu, 23 Oct 2025 10:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBwKx-0001bh-Td
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:30:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBwKt-0001jy-NB
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:30:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4E3F211CD;
 Thu, 23 Oct 2025 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761229831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIz+CW7Nn58UMLa/RU+PbumU16pmyLLAvYHbQ+gNibw=;
 b=JGbGu71GabzXPxGacf6/T0RodDIvgtBVa97Qel5Xr2hJqIcE9nGPqcWFhTltOhB83tDm7C
 DORMcpU56Fw9FnoqeQ9HgsZOwrR1LvbEomzqltH/kcg0f9wnj5gyH1F/tNhhpTbVUXKTrv
 LBp9PvWWa2smTTHze8SInvwQ10N88cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761229831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIz+CW7Nn58UMLa/RU+PbumU16pmyLLAvYHbQ+gNibw=;
 b=mzGCFxrkMaoPwXdjYNg9aZPK+kqEhlgceuYiJnHWr7CXk3bZJ8HueVot6J54GyLgiDbmcc
 ZlMle5MTieqFlPCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gl1CC76m;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9fVkzEfm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761229826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIz+CW7Nn58UMLa/RU+PbumU16pmyLLAvYHbQ+gNibw=;
 b=gl1CC76m00vlQpMBoH6PH3rV7b89HxHZV/10ORaBjyX5nxlDtA2WdsoFZe3QKuWkq8lWMb
 Fc7f+d/b5bHO6tyX7TKGNwcixXckw7MEM2NqirCOeLbF1cBZ8rbak4tyrdebdlM5fTGYkX
 8nZ42H3bGqSntHPi5Tei6TEH+IayfFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761229826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIz+CW7Nn58UMLa/RU+PbumU16pmyLLAvYHbQ+gNibw=;
 b=9fVkzEfmyG8YZX/ooRQNKrpzKNPW98sinERdoi1XhC5TSIIOjgUPc8r6um/kCV3Sz0V6B+
 QQqQkkoCmyvHOBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C7B0136CF;
 Thu, 23 Oct 2025 14:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xypyDAI8+mjPZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Oct 2025 14:30:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: peterx@redhat.com, qemu-devel@nongnu.org
Subject: re: [PATCH v2 06/24] migration: Run a post update routine after
 setting parameters
In-Reply-To: <20251013061024.31814-1-guobin@linux.alibaba.com>
References: <20250630195913.28033-7-farosas@suse.de>
 <20251013061024.31814-1-guobin@linux.alibaba.com>
Date: Thu, 23 Oct 2025 11:30:23 -0300
Message-ID: <87y0p1snb4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E4E3F211CD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
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

Bin Guo <guobin@linux.alibaba.com> writes:

> Fabiano Rosas wrote on Mon, 30 Jun 2025 16:58:55 -0300:
>
>> Some migration parameters are updated immediately once they are set
>> via migrate-set-parameters. Move that work outside of
>> migrate_params_apply() and leave that function with the single
>> responsibility of setting s->parameters and not doing any
>> side-effects.
>> 
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 295367ce92..1f8a977865 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1083,6 +1083,31 @@ void migrate_params_init(MigrationParameters *params)
>>      params->has_direct_io = true;
>>  }
>>  
>> +static void migrate_post_update_params(MigrationParameters *new, Error **errp)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    if (new->has_max_bandwidth) {
>> +        if (s->to_dst_file && !migration_in_postcopy()) {
>> +            migration_rate_set(new->max_bandwidth);
>> +        }
>> +    }
>> +
>> +    if (new->has_x_checkpoint_delay) {
>> +        colo_checkpoint_delay_set();
>> +    }
>> +
>> +    if (new->has_xbzrle_cache_size) {
>> +        xbzrle_cache_resize(new->xbzrle_cache_size, errp);
>> +    }
>> +
>> +    if (new->has_max_postcopy_bandwidth) {
>> +        if (s->to_dst_file && migration_in_postcopy()) {
>> +            migration_rate_set(new->max_postcopy_bandwidth);
>> +        }
>> +    }
>> +}
>> +
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 2140785a05..7432f82bdd 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -174,7 +174,7 @@ static void XBZRLE_cache_unlock(void)
>>  /**
>>   * xbzrle_cache_resize: resize the xbzrle cache
>>   *
>> - * This function is called from migrate_params_apply in main
>> + * This function is called from migrate_post_update_config in main
>>   * thread, possibly while a migration is in progress.  A running
>>   * migration may be using the cache and might finish during this call,
>>   * hence changes to the cache are protected by XBZRLE.lock().
>> -- 
>
> The function is migrate_post_update_params, 
> but the comment says migrate_post_update_config.
>

Nice catch, this series is a pain to rebase, a lot of cross-references
between patches. I'll fix.

> --
> Regards,
> Bin Guo

