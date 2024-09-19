Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229ADCDD56F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGjA-0002T6-2w; Thu, 19 Sep 2024 08:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1srGj5-0002RK-Pu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:57:40 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1srGj3-0007Zw-AK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:57:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D692720925;
 Thu, 19 Sep 2024 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726750655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3VH3Nmc4rOBTLCAODHiTswBJfhxuTO+QgXRrocmGG9E=;
 b=yAfSLSJlsWgw4D0WZwvSD/M30+S5gi2EAjHtJiuZebvDt0NerUrku18VAykihoZDlCm8st
 fGqpPxLyx6mHZYpTLdKmWSfy0P8sN532tBpgPQAtJfkHkXnsiwxgIVFgzOfyqzrVEMIOVz
 zwluQg0zWCHd3YMh0VGWbASb3yYUaok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726750655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3VH3Nmc4rOBTLCAODHiTswBJfhxuTO+QgXRrocmGG9E=;
 b=6nFzCZTO4fjVgWhEr2DCfeztKPhO+LevbFRyk7lKv9lsoWd8YxWKoxiKGCfEfTrNgRWsmA
 L+q2ggyYR4pRdKCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fesKkIII;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Aww7JHbw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726750654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3VH3Nmc4rOBTLCAODHiTswBJfhxuTO+QgXRrocmGG9E=;
 b=fesKkIIInz5xJ8+pEDKLiSuttGgPd4fARSGhjOWyjzM0FGkiVZKooXrZ8oCTv3CYFQREPX
 kfnUGUVzZrPUV88mceLW5OGCpwAqVNIbjlf3bnY8Q0yLKxOFN1znbEB2tO4b5dO7wEJAJE
 2pbcAQk0lSLK2jp0QaKg7i/1m+qDplo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726750654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3VH3Nmc4rOBTLCAODHiTswBJfhxuTO+QgXRrocmGG9E=;
 b=Aww7JHbwgaADMzppS1WdpORgE0cluf2Cvk9gagIsQjl+lMvUcUDTAABg771lrmGzd0CXgF
 +fr4H3c+j57phBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F2DD13A1E;
 Thu, 19 Sep 2024 12:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0SnFCb4f7Gb8MwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Sep 2024 12:57:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: dave@treblig.org, eblake@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] migration: Remove unused zero-blocks capability
In-Reply-To: <87ttecrkqe.fsf@pond.sub.org>
References: <20240918000207.182683-1-dave@treblig.org>
 <20240918000207.182683-3-dave@treblig.org> <87msk54ifb.fsf@pond.sub.org>
 <Zur_d4m4D3QSHYOu@x1n> <87ttecrkqe.fsf@pond.sub.org>
Date: Thu, 19 Sep 2024 09:57:31 -0300
Message-ID: <87tteber7o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D692720925
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
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

Markus Armbruster <armbru@redhat.com> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Wed, Sep 18, 2024 at 07:52:56AM +0200, Markus Armbruster wrote:
>>> dave@treblig.org writes:
>>> 
>>> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
>>> >
>>> > migrate_zero_blocks is unused since
>>> >   eef0bae3a7 ("migration: Remove block migration")
>>> >
>>> > Remove it.
>>> > That whole zero-blocks capability was just for old-school
>>> > block migration anyway.
>>> >
>>> > Remove the capability as well.
>>> >
>>> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
>>> > ---
>>> >  migration/options.c |  8 --------
>>> >  migration/options.h |  1 -
>>> >  qapi/migration.json | 10 +---------
>>> >  3 files changed, 1 insertion(+), 18 deletions(-)
>>> >
>>> > diff --git a/migration/options.c b/migration/options.c
>>> > index 9460c5dee9..997e060612 100644
>>> > --- a/migration/options.c
>>> > +++ b/migration/options.c
>>> > @@ -177,7 +177,6 @@ Property migration_properties[] = {
>>> >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>>> >      DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
>>> >      DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
>>> > -    DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
>>> >      DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
>>> >      DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
>>> >      DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
>>> 
>>> Property of (pseudo-)device "migration".  The "x-" prefix suggests we
>>> expect management software not to rely on it.  Okay.
>>> 
>>> [...]
>>> 
>>> > diff --git a/qapi/migration.json b/qapi/migration.json
>>> > index b66cccf107..82d0fc962e 100644
>>> > --- a/qapi/migration.json
>>> > +++ b/qapi/migration.json
>>> > @@ -389,13 +389,6 @@
>>> >  #     footprint is mlock()'d on demand or all at once.  Refer to
>>> >  #     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
>>> >  #
>>> > -# @zero-blocks: During storage migration encode blocks of zeroes
>>> > -#     efficiently.  This essentially saves 1MB of zeroes per block on
>>> > -#     the wire.  Enabling requires source and target VM to support
>>> > -#     this feature.  To enable it is sufficient to enable the
>>> > -#     capability on the source VM.  The feature is disabled by
>>> > -#     default.  (since 1.6)
>>> > -#
>>> >  # @events: generate events for each migration state change (since 2.4)
>>> >  #
>>> >  # @auto-converge: If enabled, QEMU will automatically throttle down
>>> > @@ -483,7 +476,7 @@
>>> >  # Since: 1.2
>>> >  ##
>>> >  { 'enum': 'MigrationCapability',
>>> > -  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>>> > +  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
>>> >             'events', 'postcopy-ram',
>>> >             { 'name': 'x-colo', 'features': [ 'unstable' ] },
>>> >             'release-ram',
>>> 
>>> This is used by migrate-set-capabilities and query-migrate-capabilities,
>>> via ['MigrationCapabilityStatus'].
>>> 
>>> query-migrate-capabilities is unaffected: it couldn't return zero-blocks
>>> anymore even before the patch.
>>> 
>>> migrate-set-capabilities changes incompatibly, I'm afraid.  Before the
>>> patch:
>>> 
>>>     {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"capability": "zero-blocks", "state": true}]}}
>>>     {"return": {}}
>>> 
>>> Afterwards:
>>> 
>>>     {"error": {"class": "GenericError", "desc": "Parameter 'capability' does not accept value 'zero-blocks'"}}
>>> 
>>> If we had somehow rejected the capability when it made no sense,
>>> removing it now it never makes sense would be obviously fine.
>>> 
>>> The straight & narrow path is to deprecate now, remove later.
>>
>> I wonder whether we can make this one simpler, as IIUC this cap depends on
>> the block migration feature, which properly went through the deprecation
>> process and got removed in the previous release.
>>
>> IOW, currently QEMU behaves the same with this cap on/off, ignoring it
>> completely.  I think it means the deprecation message (even if we provide
>> some for two extra releases..) wouldn't be anything helpful as anyone who
>> uses this feature already got affected before this patch.. this feature,
>> together with block migration, are simply all gone already?
>
> We break compatibility for users who supply capability @zero-blocks even
> though they are not using block migration.
>
> Before this patch, the capability is silently ignored.
>
> Afterwards, we reject it.
>
> This harmless misuse was *not* affected by our prior removal of block
> migration.
>
> It *is* affected by the proposed removal of the capability.

How does this policy_skip thing works? Could we automatically warn
whenever a capability has the 'deprecated' feature in migration.json?

Also, some of the incompatibility errors in migrate_caps_check() could
be simplified with something like a new:
'features': [ 'conflicts': [ 'cap1', 'cap2' ] ]
to indicate which caps are incompatible between themselves.

>
> We either treat this in struct accordance to our rules: deprecate now,
> remove later.  Or we bend our them:
>
>>> If we believe nothing relies on it, we can bend the rules and remove
>>> right away.
>
> Not for me to decide.
>

I'm fine either way, but in any case:

-- >8 --
From 3ff313a52e37b8cb407c900d7a1aa266560aebb7 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Thu, 19 Sep 2024 09:49:44 -0300
Subject: [PATCH] migration: Deprecate zero-blocks capability

The zero-blocks capability was meant to be used along with the block
migration, which has been removed already in commit eef0bae3a7
("migration: Remove block migration").

Setting zero-blocks is currently a noop, but the outright removal of
the capability would cause and error in case some users are still
setting it. Put the capability through the deprecation process.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst | 6 ++++++
 migration/options.c       | 4 ++++
 qapi/migration.json       | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ed31d4b0b2..47cabb6fcc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -476,3 +476,9 @@ usage of providing a file descriptor to a plain file has been
 deprecated in favor of explicitly using the ``file:`` URI with the
 file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
 command documentation for details on the ``fdset`` usage.
+
+``zero-blocks`` capability (since 9.2)
+''''''''''''''''''''''''''''''''''''''
+
+The ``zero-blocks`` capability was part of the block migration which
+doesn't exist anymore since it was removed in QEMU v9.1.
diff --git a/migration/options.c b/migration/options.c
index 147cd2b8fd..b828bad0d9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -457,6 +457,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (new_caps[MIGRATION_CAPABILITY_ZERO_BLOCKS]) {
+        warn_report("zero-blocks capability is deprecated");
+    }
+
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
diff --git a/qapi/migration.json b/qapi/migration.json
index b66cccf107..3af6aa1740 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -479,11 +479,14 @@
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
+# @deprecated: Member @zero-blocks is deprecated as being part of
+#     block migration which was already removed.
 #
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
-  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
+  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
+           { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
-- 
2.35.3


