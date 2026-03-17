Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD063FED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZVH-0002Km-Cy; Tue, 17 Mar 2026 14:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2ZVF-0002K8-VY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:50:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2ZVE-0008Jm-76
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:50:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23D444D3C2;
 Tue, 17 Mar 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773773449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fELw4pgf7oYeVrolgThQ7yxsMl4tb8wLsK8/JU7kkr4=;
 b=S/nAKBQVxkNZMiSB0bEVQScf79E72fdRvAuX2HVP/AEXbvwAG5FtVhrYeKQjHpqGRoOgv5
 CLAYYqUsq6NoR+dWa8ch8Ty2qnjy5JdpuNe6JnNOV5TtCXdcSYT/BzyI0S4QjBOtiw5Qc9
 vpR/CePjwkAvMreBGpXqi/pDqdN1Aas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773773449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fELw4pgf7oYeVrolgThQ7yxsMl4tb8wLsK8/JU7kkr4=;
 b=Jdf2XATmUrOrSrpG6cyYSQ/sw9fVG+e4xS6nMSbpiRjb3/jOpoCO3uHZfLJIb18SBNQJno
 Hvnq/y28i38uEhDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773773449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fELw4pgf7oYeVrolgThQ7yxsMl4tb8wLsK8/JU7kkr4=;
 b=S/nAKBQVxkNZMiSB0bEVQScf79E72fdRvAuX2HVP/AEXbvwAG5FtVhrYeKQjHpqGRoOgv5
 CLAYYqUsq6NoR+dWa8ch8Ty2qnjy5JdpuNe6JnNOV5TtCXdcSYT/BzyI0S4QjBOtiw5Qc9
 vpR/CePjwkAvMreBGpXqi/pDqdN1Aas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773773449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fELw4pgf7oYeVrolgThQ7yxsMl4tb8wLsK8/JU7kkr4=;
 b=Jdf2XATmUrOrSrpG6cyYSQ/sw9fVG+e4xS6nMSbpiRjb3/jOpoCO3uHZfLJIb18SBNQJno
 Hvnq/y28i38uEhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3FE24273B;
 Tue, 17 Mar 2026 18:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nrahGoiiuWm9EgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Mar 2026 18:50:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Roman Kiryanov <rkir@google.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com,
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Subject: Re: [PATCH v3] vmstate: validate VMStateDescription::fields upon
 registration
In-Reply-To: <20260313233538.1519319-1-rkir@google.com>
References: <20260313233538.1519319-1-rkir@google.com>
Date: Tue, 17 Mar 2026 15:50:46 -0300
Message-ID: <87ldfq2su1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Roman Kiryanov <rkir@google.com> writes:

> The vmstate_save_state_v() function does not support
> NULL in VMStateDescription::fields and will crash if
> one is provided.
>
> This change prevents this situation from happening
> by explicitly crashing earlier.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> v3:
>  - Also added assert to virtio.c to validate
>    VirtioDeviceClass instances which bypass
>    vmstate_register_with_alias_id.
>  - Updated the commit message to "Reviewed-by".
> v2:
>  - Moved the assert from vmstate_save_state_v to the registration
>    path (vmstate_register_with_alias_id) and the qtest validation path
>    (vmstate_check) to catch missing fields earlier.
> ---
>  hw/virtio/virtio.c | 6 ++++++
>  migration/savevm.c | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 0ba734d0bc..e4543de335 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -4054,6 +4054,12 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>      /* Devices should either use vmsd or the load/save methods */
>      assert(!vdc->vmsd || !vdc->load);
>  
> +    /*
> +     * If a device has vmsd, it either MUST have valid fields
> +     * or marked unmigratable.
> +     */
> +    assert(!vdc->vmsd || (vdc->vmsd->unmigratable || vdc->vmsd->fields));
> +
>      if (vdc->realize != NULL) {
>          vdc->realize(dev, &err);
>          if (err != NULL) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 197c89e0e6..20c2b99231 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -861,6 +861,8 @@ static void vmstate_check(const VMStateDescription *vmsd)
>      const VMStateField *field = vmsd->fields;
>      const VMStateDescription * const *subsection = vmsd->subsections;
>  
> +    assert(field || vmsd->unmigratable);
> +
>      if (field) {
>          while (field->name) {
>              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
> @@ -900,6 +902,9 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
>      /* If this triggers, alias support can be dropped for the vmsd. */
>      assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
>  
> +    /* If vmsd is migratable it MUST have valid fields. */
> +    assert(vmsd->fields || vmsd->unmigratable);
> +
>      se = g_new0(SaveStateEntry, 1);
>      se->version_id = vmsd->version_id;
>      se->section_id = savevm_state.global_section_id++;

Hi, this patch missed the train. It's crashing the
./scripts/device-crash-test

The vmstate_virtio_snd_device needs to be fixed first.

---
Some thoughts, no action needed:

I'm cautions after the issue with the stubs. We should expect that a
stub with all fields zeroed could still reach the vmstate code. Maybe
it'll be fine with the (eventual) fix for mips, but we need to test it
thoroughly.

There is also the -dump-vmstate command line option, which can certainly
process vmsds with incorrect fields as it takes them directly from the
device class. It doesn't crash, but prints stuff like:

"Fields": [{
    "field": "cpuhp_state",
    "version_id": 1,
    "field_exists": false,
    "size": 304,
    "Description": {
        "name": "(null)",  <---
        "version_id": 0,
        "minimum_version_id": 0
    }}]

Perhaps it should even do a validation pass and warn or add a comment to
the output.

