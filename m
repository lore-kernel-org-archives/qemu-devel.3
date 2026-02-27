Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5680104891D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6WO-0007Hw-Se; Fri, 27 Feb 2026 17:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw6WJ-0007Bc-3M
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:41:15 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw6WH-000300-8y
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:41:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D9583FACF;
 Fri, 27 Feb 2026 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772232070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7onmDyMLk8L74KuGD0ZRzUXXTBrppU5h3LV3AjMV3I=;
 b=exjwL75YE/pcTM67DsMMc5iL/MOfVXiTWvVRkopN2aj03TGCffxVyhnH/+PoDmc4+Vbfz3
 lFNopHO0r50BToQYtwoP2uxA1ElVVdux8Ij+PPN2jTs8FrnQPmoc3tqg76A90ouA4kjPto
 jEDywDeiclrtS9VyjWMUbN2vixf+nNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772232070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7onmDyMLk8L74KuGD0ZRzUXXTBrppU5h3LV3AjMV3I=;
 b=4jm6LsMoc8RLib/z8ZwCaTFguXRmVdWYhhPP2yzVbw4CBkLiuwTaMUPGXi4WIShnd+EVIM
 00EvrBOVNSW5q4AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=exjwL75Y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4jm6LsMo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772232070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7onmDyMLk8L74KuGD0ZRzUXXTBrppU5h3LV3AjMV3I=;
 b=exjwL75YE/pcTM67DsMMc5iL/MOfVXiTWvVRkopN2aj03TGCffxVyhnH/+PoDmc4+Vbfz3
 lFNopHO0r50BToQYtwoP2uxA1ElVVdux8Ij+PPN2jTs8FrnQPmoc3tqg76A90ouA4kjPto
 jEDywDeiclrtS9VyjWMUbN2vixf+nNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772232070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7onmDyMLk8L74KuGD0ZRzUXXTBrppU5h3LV3AjMV3I=;
 b=4jm6LsMoc8RLib/z8ZwCaTFguXRmVdWYhhPP2yzVbw4CBkLiuwTaMUPGXi4WIShnd+EVIM
 00EvrBOVNSW5q4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2BD73EA69;
 Fri, 27 Feb 2026 22:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wEnhGYUdomlucAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Feb 2026 22:41:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: vsementsov@yandex-team.ru, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, Peter Maydell
 <peter.maydell@linaro.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR (pseries)"
 <qemu-ppc@nongnu.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2 03/16] migration: make .post_save() a void function
In-Reply-To: <20260220210214.800050-4-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-4-vsementsov@yandex-team.ru>
Date: Fri, 27 Feb 2026 19:41:07 -0300
Message-ID: <87ecm5u7wc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[yandex-team.ru,linaro.org,gmail.com,linux.ibm.com,nongnu.org];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2D9583FACF
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> All other handlers now have _errp() variants. Should we go this way
> for .post_save()? Actually it's rather strange, when the vmstate do
> successful preparations in .pre_save(), then successfully save all
> sections and subsections, end then fail when all the state is
> successfully transferred to the target.
>
> Happily, we have only three .post_save() realizations, all always
> successful. Let's make this a rule.
>
> Also note, that we call .post_save() in two places, and handle
> its (theoretical) failure inconsistently. Fix that too.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  docs/devel/migration/main.rst |  2 +-
>  hw/ppc/spapr_pci.c            |  3 +--
>  include/migration/vmstate.h   | 10 +++++++++-
>  migration/savevm.c            |  3 +--
>  migration/vmstate.c           | 12 +++---------
>  target/arm/machine.c          |  4 +---
>  6 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 234d280249..2de7050764 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -439,7 +439,7 @@ The functions to do that are inside a vmstate definition, and are called:
>  
>    This function is called before we save the state of one device.
>  
> -- ``int (*post_save)(void *opaque);``
> +- ``void (*post_save)(void *opaque);``
>  
>    This function is called after we save the state of one device
>    (even upon failure, unless the call to pre_save returned an error).
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index ea998bdff1..1dc3b02659 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2093,14 +2093,13 @@ static int spapr_pci_pre_save(void *opaque)
>      return 0;
>  }
>  
> -static int spapr_pci_post_save(void *opaque)
> +static void spapr_pci_post_save(void *opaque)
>  {
>      SpaprPhbState *sphb = opaque;
>  
>      g_free(sphb->msi_devs);
>      sphb->msi_devs = NULL;
>      sphb->msi_devs_num = 0;
> -    return 0;
>  }
>  
>  static int spapr_pci_post_load(void *opaque, int version_id)
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 3695afd483..15578b3e28 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -223,7 +223,15 @@ struct VMStateDescription {
>      bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
>      int (*pre_save)(void *opaque);
>      bool (*pre_save_errp)(void *opaque, Error **errp);
> -    int (*post_save)(void *opaque);
> +
> +    /*
> +     * post_save() rarely used to free some temporary resources.
> +     * It's is called if .pre_save[_errp]() call was successful
> +     * (or .pre_save[_errp] handler absent), regardless success
> +     * or failure during fields and subsections save. If
> +     * .pre_save[_errp]() fails, .post_save() is not called.
> +     */

I would not mention usage directly and maybe also simplify the language
a bit. If there's doubt on the exact flow, people can read the code:

  /*
   * Unless .pre_save() fails, post_save() is called after saving
   * fields and subsections. It should not fail because at this point
   * the state has potentially already been transferred.
   */

> +    void (*post_save)(void *opaque);
>      bool (*needed)(void *opaque);
>      bool (*dev_unplug_pending)(void *opaque);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3a16c467b2..c5236e71ba 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -321,14 +321,13 @@ static int configuration_pre_save(void *opaque)
>      return 0;
>  }
>  
> -static int configuration_post_save(void *opaque)
> +static void configuration_post_save(void *opaque)
>  {
>      SaveState *state = opaque;
>  
>      g_free(state->capabilities);
>      state->capabilities = NULL;
>      state->caps_count = 0;
> -    return 0;
>  }
>  
>  static int configuration_pre_load(void *opaque)
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 651c3fe011..5111e7a141 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -550,10 +550,7 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  if (ret) {
>                      error_prepend(errp, "Save of field %s/%s failed: ",
>                                    vmsd->name, field->name);
> -                    if (vmsd->post_save) {
> -                        vmsd->post_save(opaque);
> -                    }
> -                    return ret;
> +                    goto out;
>                  }
>  
>                  /* Compressed arrays only care about the first element */
> @@ -578,12 +575,9 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>  
>      ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>  
> +out:
>      if (vmsd->post_save) {
> -        int ps_ret = vmsd->post_save(opaque);
> -        if (!ret && ps_ret) {
> -            ret = ps_ret;
> -            error_setg(errp, "post-save failed: %s", vmsd->name);
> -        }
> +        vmsd->post_save(opaque);

Nice cleanup.

>      }
>      return ret;
>  }
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index bbaae34449..de810220e2 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -993,15 +993,13 @@ static int cpu_pre_save(void *opaque)
>      return 0;
>  }
>  
> -static int cpu_post_save(void *opaque)
> +static void cpu_post_save(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
>  
>      if (!kvm_enabled()) {
>          pmu_op_finish(&cpu->env);
>      }
> -
> -    return 0;
>  }
>  
>  static int cpu_pre_load(void *opaque)

