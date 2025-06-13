Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9E7C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 12:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ3Ys-0007iD-GU; Fri, 13 Jun 2025 08:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uQ3YO-0007hN-Uz
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:30:44 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uQ3YL-0004g0-1H
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:30:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED42E1F7EC;
 Fri, 13 Jun 2025 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749817828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GWGn13O4aW2pbclGDr6yM4pF74Pb7Bzp7OijrpupQU=;
 b=ZlS96WZ8Qj/wuasbX+fjgHxSdFLiqTPuF/GD/nAbgv+zIN9BUAKu2kNpQMrN+wcGvmUX3m
 oGfrrWTf4S1QoC5SIZUUu+rlBXL6vysREOhxOlagZxhTYyiwhIHJcIa+tXgB2W1GjM/WmS
 s8dmalt7V/J6csAI8zAOINsZwtJQHw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749817828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GWGn13O4aW2pbclGDr6yM4pF74Pb7Bzp7OijrpupQU=;
 b=v7qn1c0u6hMn+916P+KfREvMrIY3S+OWpYH4OlsC0MyQ6mvo/6vB9bphpec22p309PeByF
 wV1o8Taej6OKpZBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749817826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GWGn13O4aW2pbclGDr6yM4pF74Pb7Bzp7OijrpupQU=;
 b=0kugf2jrs35b3sjlnhDYEqccCl0qevIlZm6ZPPkrDAKIOVv8uTBvFMbrESqS3fcjWQWXO6
 03gGpGzez95FlfMP3/U4R+iO2JEWdOJBU+wx64jLR75oyKZ7h3JAQyxb2Q4/CSIqs3Olqa
 kSciYwvpXrjPYz+whVHUKqcMqSa1z3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749817826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GWGn13O4aW2pbclGDr6yM4pF74Pb7Bzp7OijrpupQU=;
 b=pY13SM7MMtK56UBbjr7/LsLoshBxVu/T4O2+HXuC8ygxt2BGmueYoGRxrglxc5QnipmM8R
 F87QoDjX2f8m5YAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D05813782;
 Fri, 13 Jun 2025 12:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ofSNC+IZTGg4cQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Jun 2025 12:30:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 10/21] migration: Use QAPI_CLONE_MEMBERS in
 query_migrate_parameters
In-Reply-To: <aEtGL1J4LpLJ8Gj9@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-11-farosas@suse.de> <aEMJacJqDHLrdkgn@x1.local>
 <87a56kx3xc.fsf@suse.de> <87ecvovfrt.fsf@suse.de>
 <aEtGL1J4LpLJ8Gj9@x1.local>
Date: Fri, 13 Jun 2025 09:30:23 -0300
Message-ID: <87bjqrvn6o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Thu, Jun 12, 2025 at 05:58:14PM -0300, Fabiano Rosas wrote:
>> Fabiano Rosas <farosas@suse.de> writes:
>> 
>> > Peter Xu <peterx@redhat.com> writes:
>> >
>> >> On Mon, Jun 02, 2025 at 10:37:59PM -0300, Fabiano Rosas wrote:
>> >>> QAPI_CLONE_MEMBERS is a better option than copying parameters one by
>> >>> one because it operates on the entire struct and follows pointers. It
>> >>> also avoids the need to alter this function every time a new parameter
>> >>> is added.
>> >>> 
>> >>> Note, since this is a deep clone, now we must free the TLS strings
>> >>> before assignment.
>> >>> 
>> >>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >>> ---
>> >>>  migration/options.c | 31 ++++---------------------------
>> >>>  1 file changed, 4 insertions(+), 27 deletions(-)
>> >>> 
>> >>> diff --git a/migration/options.c b/migration/options.c
>> >>> index dd62e726cb..0a2a3050ec 100644
>> >>> --- a/migration/options.c
>> >>> +++ b/migration/options.c
>> >>> @@ -918,7 +918,9 @@ static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
>> >>>  {
>> >>>      StrOrNull *dst = *dstp;
>> >>>  
>> >>> -    assert(!dst);
>> >>> +    if (dst) {
>> >>> +        qapi_free_StrOrNull(dst);
>> >>> +    }
>> >>>  
>> >>>      dst = *dstp = g_new0(StrOrNull, 1);
>> >>>      dst->type = QTYPE_QSTRING;
>> >>> @@ -975,42 +977,17 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>> >>>      MigrationParameters *params;
>> >>>      MigrationState *s = migrate_get_current();
>> >>>  
>> >>> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
>> >>>      params = g_malloc0(sizeof(*params));
>> >>>  
>> >>> -    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
>> >>> -    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
>> >>> -    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
>> >>> -    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
>> >>> +    QAPI_CLONE_MEMBERS(MigrationParameters, params, &s->parameters);
>> >>>  
>> >>>      tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
>> >>>      tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
>> >>>      tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);
>
> [1]
>
>> >>>  
>> >>> -    params->max_bandwidth = s->parameters.max_bandwidth;
>> >>> -    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
>> >>> -    params->downtime_limit = s->parameters.downtime_limit;
>> >>> -    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
>> >>> -    params->multifd_channels = s->parameters.multifd_channels;
>> >>> -    params->multifd_compression = s->parameters.multifd_compression;
>> >>> -    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
>> >>> -    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
>> >>> -    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
>> >>> -    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
>> >>> -    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
>> >>> -    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
>> >>> -    params->announce_initial = s->parameters.announce_initial;
>> >>> -    params->announce_max = s->parameters.announce_max;
>> >>> -    params->announce_rounds = s->parameters.announce_rounds;
>> >>> -    params->announce_step = s->parameters.announce_step;
>> >>>      params->block_bitmap_mapping =
>> >>>          QAPI_CLONE(BitmapMigrationNodeAliasList,
>> >>>                     s->parameters.block_bitmap_mapping);
>> >>
>> >> Wouldn't the QAPI_CLONE_MEMBERS() have deep cloned this too?
>> >>
>> >
>> > Hmm, I think it should. But it definitely broke something without this
>> > line. I'll double check.
>> >
>> 
>> Thanks for the question, this was indeed wrong. QAPI_CLONE_MEMBERS
>> depend on the has_* fields on src, otherwise it's just a glorified
>> assignment (*dst = src). The reason I got this wrong is that I was using
>> the TLS strings to test and they have a different handling in QAPI:
>> 
>> visit_type_MigrationParameters_members():
>> 
>>     bool has_tls_creds = !!obj->tls_creds;
>
> [2]
>
>> 
>> So the code was working for them, but not for block_bitmap_mapping, for
>> which the QAPI has:
>> 
>> if (visit_optional(v, "block-bitmap-mapping", &obj->has_block_bitmap_mapping)) {
>>                                                     ^
>>     if (!visit_type_BitmapMigrationNodeAliasList(v, "block-bitmap-mapping",
>>         &obj->block_bitmap_mapping, errp)) {
>>         return false;
>>     }
>> }
>> 
>> IOW, the QAPI_CLONE routines depend on the has_ fields (in retrospect:
>> obviously).
>> 
>> That assert you didn't like will have to go then and s->parameters will
>> have to have all has_* fields permanently set. Not a huge deal, but it
>> undermines my argument of keeping it free from QAPI details.
>
> Oops, indeed.  Now you have that function to set all has_*, hopefully this
> is trivial now to still do so.
>

Yes.

> Since you mentioned tls_* won't have has_*, but they will get properly
> cloned IIUC as you mentioned above [2].  Does it mean we can also drop the
> three lines at [1] too?
>

I'm thinking yes as well, still woking on it.

> In general, I am curious why we can't already use QAPI_CLONE() like:
>
>   params = QAPI_CLONE(&s->parameters);
>
> And if my wish came true once more on having it a pointer (meanwhile if it
> even happened before this patch):
>
>   params = QAPI_CLONE(s->parameters);
>
> I thought with that, any of "g_malloc0(), copying of tls_*, copying of
> block_bitmap things" are all not needed?

Same here.

