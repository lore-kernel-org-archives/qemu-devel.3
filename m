Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244D6D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oaj-00019N-Nl; Fri, 18 Oct 2024 11:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1oai-00019E-Gk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:08:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1oag-0005a8-Fe
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:08:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E59621BAF;
 Fri, 18 Oct 2024 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729264111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltHtLdJcxUO8mMyAqdkV4ZQlReAYD4toFaSTWIULW38=;
 b=apydg/fsJgiSqGzIS/d5GnwaL23mr1zuovHcky5tcZICy1mUSEwZqiFjn+zv7EvBdE9DUd
 rxxJr1YznBj41abdUPOZ4TiSxBGPc1/91V/57uBqnKB/GWxW6qGPVVu2eq2aPz0fLKW3Vk
 2DRVV/R7/5ZCsw1Avlk8lUzUA0eQL4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729264111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltHtLdJcxUO8mMyAqdkV4ZQlReAYD4toFaSTWIULW38=;
 b=QsrnmZYcVyD9Evg/+JUlMmwuspcl33poQmQmWqZIWSHfvvtBKgpnEObXEiAO5MCB/X3si5
 44xKbneuwX0j+3AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="apydg/fs";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QsrnmZYc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729264111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltHtLdJcxUO8mMyAqdkV4ZQlReAYD4toFaSTWIULW38=;
 b=apydg/fsJgiSqGzIS/d5GnwaL23mr1zuovHcky5tcZICy1mUSEwZqiFjn+zv7EvBdE9DUd
 rxxJr1YznBj41abdUPOZ4TiSxBGPc1/91V/57uBqnKB/GWxW6qGPVVu2eq2aPz0fLKW3Vk
 2DRVV/R7/5ZCsw1Avlk8lUzUA0eQL4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729264111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltHtLdJcxUO8mMyAqdkV4ZQlReAYD4toFaSTWIULW38=;
 b=QsrnmZYcVyD9Evg/+JUlMmwuspcl33poQmQmWqZIWSHfvvtBKgpnEObXEiAO5MCB/X3si5
 44xKbneuwX0j+3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 355CC13433;
 Fri, 18 Oct 2024 15:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zm1RN+15Emc4QwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Oct 2024 15:08:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
In-Reply-To: <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
Date: Fri, 18 Oct 2024 12:08:22 -0300
Message-ID: <87ldyl1mah.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0E59621BAF
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[11]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid, oracle.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Make all global and compat properties available before the first objects
> are created.  Set accelerator compatibility properties in
> configure_accelerators, when the accelerator is chosen, and call
> configure_accelerators earlier.  Set machine options earlier.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  accel/accel-system.c |  2 --
>  system/vl.c          | 34 ++++++++++++++++++----------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index f6c947d..c8aeae4 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>          ms->accelerator = NULL;
>          *(acc->allowed) = false;
>          object_unref(OBJECT(accel));
> -    } else {
> -        object_set_accelerator_compat_props(acc->compat_props);
>      }
>      return ret;
>  }
> diff --git a/system/vl.c b/system/vl.c
> index b94a6b9..bca2292 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>          goto bad;
>      }
>  
> +    object_set_accelerator_compat_props(ac->compat_props);
>      acs->accel = accel;
>      return 1;
>  
> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>      parse_memory_options();
>  
>      qemu_create_machine(machine_opts_dict);
> -
> -    suspend_mux_open();
> -
> -    qemu_disable_default_devices();
> -    qemu_setup_display();
> -    qemu_create_default_devices();
> -    qemu_create_early_backends();
> -
>      qemu_apply_legacy_machine_options(machine_opts_dict);
>      qemu_apply_machine_options(machine_opts_dict);
>      qobject_unref(machine_opts_dict);
> -    phase_advance(PHASE_MACHINE_CREATED);
>  
> -    /*
> -     * Note: uses machine properties such as kernel-irqchip, must run
> -     * after qemu_apply_machine_options.
> -     */
>      accel = configure_accelerators(argv[0]);
> -    create_accelerator(accel);
> -    phase_advance(PHASE_ACCEL_CREATED);
>  
>      /*
> -     * Beware, QOM objects created before this point miss global and
> +     * QOM objects created after this point see all global and
>       * compat properties.
>       *
>       * Global properties get set up by qdev_prop_register_global(),
> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>       * called from do_configure_accelerator().
>       */
>  
> +    suspend_mux_open();
> +
> +    qemu_disable_default_devices();
> +    qemu_setup_display();
> +    qemu_create_default_devices();
> +    qemu_create_early_backends();
> +
> +    phase_advance(PHASE_MACHINE_CREATED);
> +
> +    /*
> +     * Note: uses machine properties such as kernel-irqchip, must run
> +     * after qemu_apply_machine_options.
> +     */
> +    create_accelerator(accel);
> +    phase_advance(PHASE_ACCEL_CREATED);
> +
>      machine_class = MACHINE_GET_CLASS(current_machine);
>      if (!qtest_enabled() && machine_class->deprecation_reason) {
>          warn_report("Machine type '%s' is deprecated: %s",

Hi Steve,

after this commit:

$ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/xlnx-can-test
# random seed: R02Saf9b44f2d88dd417052905692ee79981
1..5
# Start of aarch64 tests
# Start of net tests
# Start of can tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2396.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2396.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine xlnx-zcu102 -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus -accel qtest
qemu-system-aarch64: Device 'canbus' not found

I tried briefly to figure out what the issue is, but I don't really
understand the dependencies involved. Hope you can tell us.

