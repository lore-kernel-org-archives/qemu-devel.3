Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9E7D17138
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 21:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2zbO-0003bt-Io; Mon, 21 Oct 2024 17:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t2zbI-0003Zd-Dy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:06:05 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t2zb1-0001R9-Nh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:05:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1B7B1F851;
 Mon, 21 Oct 2024 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729544746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEcjmthpNr7+iXw4LUpLW4L9dxA3b1IVFWA4PROkrDU=;
 b=UaL/T1+m2XTSyeRS6xJnvj8S3ZrdpCeGt4aZs4uZvkLlmhzvDK98q1hGO6UXpiMduYC5g0
 MgCSeg+VuSG33yXBfiIjBAJN/UfxDNI8HmzSzEP/NT9mifF2+doe8gReyYyEEmOeqHr5qw
 +ZHaM7K3mqc8/RoPaZJW/DxncprE9m8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729544746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEcjmthpNr7+iXw4LUpLW4L9dxA3b1IVFWA4PROkrDU=;
 b=UdeBHpAioFSuHLftZQXGKY483ZzwWEt1bCO2p4qz2Z4gVDaEhmTMfmdyptmA4yJ+tSOh8j
 ig+xXx9bzji0JSCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pUVdOj39;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="PxgK51/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729544745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEcjmthpNr7+iXw4LUpLW4L9dxA3b1IVFWA4PROkrDU=;
 b=pUVdOj39snZ+awh1/f5O/hRJhhYokiPkbQzwAn40w5LXlolO6Ln05F1fJJJVmMzgIwGrBp
 qKxFlMYPydE9n0tnrZiwfPajNW3aGkBlFhzNMQcW5OavK1H3G63zltXHmNLOg4eg6PNaH4
 9Ur9d/tqA05XCrxaOcNyfphWTURWVjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729544745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEcjmthpNr7+iXw4LUpLW4L9dxA3b1IVFWA4PROkrDU=;
 b=PxgK51/JZMU9ETW9u6fE86sf44ZUFYSwvnVlbHo01YmSeGeNFpInip9AFpxGjEcENlxap1
 TqTIlxFqCyMGCPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58BCE136DC;
 Mon, 21 Oct 2024 21:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xpghCCnCFmcFTAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Oct 2024 21:05:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [RFC V1 05/14] migration: init and listen during precreate
In-Reply-To: <1729178055-207271-6-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-6-git-send-email-steven.sistare@oracle.com>
Date: Mon, 21 Oct 2024 18:05:42 -0300
Message-ID: <871q09dv4p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D1B7B1F851
X-Spamd-Result: default: False [-2.96 / 50.00]; BAYES_HAM(-2.95)[99.79%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Initialize the migration object as early as possible so that migration
> configuration commands may be sent during the precreate phase.  Also,
> start listening for the incoming migration connection during precreate,
> so that the listen port number is assigned (if dynamic), and the user
> can discover it during precreate via query-migrate.  The precreate phase
> will be delineated in a subsequent patch.
>
> The code previously called migration_object_init after memory backends
> were created so that a subsequent migrate-set-capabilities call to set
> MIGRATION_CAPABILITY_POSTCOPY_RAM would verify all backends support
> postcopy.  See migrate_caps_check and postcopy_ram_supported_by_host.
> The new code calls migration_object_init before backends are created.
> However, migrate-set-capabilities will only be received during the
> precreate phase for CPR, and CPR does not support postcopy.  If the
> precreate phase is generalized in the future, then the ram compatibility
> check must be deferred to the start of migration.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/vl.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index bca2292..d32203c 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2753,17 +2753,7 @@ void qmp_x_exit_preconfig(Error **errp)
>          replay_vmstate_init();
>      }
>  
> -    if (incoming) {
> -        Error *local_err = NULL;
> -        if (strcmp(incoming, "defer") != 0) {
> -            qmp_migrate_incoming(incoming, false, NULL, true, true,
> -                                 &local_err);
> -            if (local_err) {
> -                error_reportf_err(local_err, "-incoming %s: ", incoming);
> -                exit(1);
> -            }
> -        }
> -    } else if (autostart) {
> +    if (!incoming && autostart) {
>          qmp_cont(NULL);
>      }
>  }
> @@ -3751,6 +3741,18 @@ void qemu_init(int argc, char **argv)
>       * called from do_configure_accelerator().
>       */
>  
> +    /* Creates a QOM object */
> +    migration_object_init();
> +
> +    if (incoming && !g_str_equal(incoming, "defer")) {
> +        Error *local_err = NULL;
> +        qmp_migrate_incoming(incoming, false, NULL, true, true, &local_err);
> +        if (local_err) {
> +            error_reportf_err(local_err, "-incoming %s: ", incoming);
> +            exit(1);
> +        }
> +    }

Doesn't this break preconfig? Now migrate_incoming happens without user
input so there's no time to set migration options before incoming code
starts using them.

> +
>      suspend_mux_open();
>  
>      qemu_disable_default_devices();
> @@ -3773,20 +3775,9 @@ void qemu_init(int argc, char **argv)
>                       machine_class->name, machine_class->deprecation_reason);
>      }
>  
> -    /*
> -     * Create backends before creating migration objects, so that it can
> -     * check against compatibilities on the backend memories (e.g. postcopy
> -     * over memory-backend-file objects).
> -     */
>      qemu_create_late_backends();
>      phase_advance(PHASE_LATE_BACKENDS_CREATED);
>  
> -    /*
> -     * Note: creates a QOM object, must run only after global and
> -     * compat properties have been set up.
> -     */
> -    migration_object_init();
> -
>      /* parse features once if machine provides default cpu_type */
>      current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
>      if (cpu_option) {

