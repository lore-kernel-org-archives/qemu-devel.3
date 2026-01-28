Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F25BD46BFA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCHP-0005o3-44; Wed, 28 Jan 2026 15:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vlCHL-0005jz-6g
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:36:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vlCHI-0007Vd-5D
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769632598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vt/Yx2ILvTvUsd7S2GGZ+UNDdPAruQOzBtA0eVRKVkg=;
 b=EFaKADgtX9Yxul+jBewa+H40xyB9y6bYLCi9JnA6ZTGEDo2EhAB+hBGBIaTWuf2Lf+wXBV
 vPZingiEXyIbjeM9lQUEj41z2q0JwLffTuRBDcsE65X4059Cevo3DjjSANOY0b0fY80BzS
 EnRCRp/vbyfm43W8WH4jvumKcxbylZ8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-PsK-gL_vMEOPBxeV9h6AFQ-1; Wed, 28 Jan 2026 15:36:37 -0500
X-MC-Unique: PsK-gL_vMEOPBxeV9h6AFQ-1
X-Mimecast-MFC-AGG-ID: PsK-gL_vMEOPBxeV9h6AFQ_1769632596
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89471437f64so9454176d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 12:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769632596; x=1770237396; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vt/Yx2ILvTvUsd7S2GGZ+UNDdPAruQOzBtA0eVRKVkg=;
 b=IG2XEQWaaAcyeTCpI7wfzaAqLe0h2fpA9pAqo/oWnSFSgxSP2EorHm2ZU2560rAArT
 UA117HnANADESIIpjcYsm69niTriA3XAO9/t525hRCPZgFkXmeSqSsl72lzWYlexFR94
 rzHQLEYNUgYejXkGS+6HFQM1yN6Sqa4oQwLvk3nQi4/n8jNqyAFqsFF57NYYUaN77Bxh
 52xRjTEV6qrB2KF08Qde0UaOx/8T3Ry6makOI9yhlGKeeGZ3Eic8Q+LbAdZQZA7aSa8e
 n4VBMkCXFy3Qo+LXu5z/bYKNMgv+79L9wsfEolgKip5i+s6uXzuN97DUgwbNjbR5A5h7
 RtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769632596; x=1770237396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vt/Yx2ILvTvUsd7S2GGZ+UNDdPAruQOzBtA0eVRKVkg=;
 b=SDnKiyt73LZ1oZrDSA67JqGUKiO6MGS3ZVVFD4dp42ufayPfW1ZjOeJb9hsQOR4gj2
 /8uHvmniyQDCXh8B1sa+Q5BEEl7X+RB0N5ax98qhC3bWmlyG6AYZ7b2u4bxhn01EpU/c
 KN5GjF6tdiGABYqHf16rsOxrc9J/IZuU7El0+Mzx+M0grwruujIhBeVnm1kUppp/l85B
 chcH1cHZAZbUwlKDYy3tn0aeY91Yz7RMwKvUr87/qNbCPZ2TpJRS1umTtEn3DDwu3ZPj
 ZYMdy9lwIsCc0kSaccuu5N832wqWrizhUJ1fhO2ETdlhlalvtXqs9SEtfp99fcdJr60I
 qqLA==
X-Gm-Message-State: AOJu0YwkWH2fEn2CYDc+0FVaBWgfJocsf7sct7KLAhSXEm2fMhXpe/nk
 PAAHx4ACgRBEOXzfCxCgSAKHvIy3yoEdHnH3K8YiZR9mUjv819jk5/1dmYUr0qDz7rB+RfaI5mc
 4Yx4lHxjOo64RpVeMtP8l0FiGuKywUDxChqN6h5mLRHcmb+MPJPMZ1iU7
X-Gm-Gg: AZuq6aI3qWARVUSblp+C+U2LlvrovZxr1J4zYcGbw4W6Uhw9TIYhHzKdSTVMtP5A/hY
 7JTC6xHoTZWdJkeyBrlJ7m61l0Z4IrnDqW2R9bufYMm5nfIy2Bd/XNMP1iENwmAWUX+idHwzlgt
 wTplLERxioTjdbF2gg5jHrb/ZqXTOgbsEGglEB7iuZFjuoqYCIHH7Gnkb+T27wN/gVMpnY6bSIM
 9VJY1V6/+QrxeINiaBp2MKchK6K3jN8LJeKZIJOaTX8TLCnRMKnUskKTW3hfi5cUVEgvrFbMsCV
 hJ84XOPhoO4oGO/5XqfSpGRoWw5bbebmk+U60F+EVJgVFt+cDHeq8pS66m/Fqoy55LQTzKfxxe+
 94xY=
X-Received: by 2002:a05:6214:e4a:b0:88a:568b:f4af with SMTP id
 6a1803df08f44-894cc83ffd8mr93851456d6.23.1769632596214; 
 Wed, 28 Jan 2026 12:36:36 -0800 (PST)
X-Received: by 2002:a05:6214:e4a:b0:88a:568b:f4af with SMTP id
 6a1803df08f44-894cc83ffd8mr93851046d6.23.1769632595622; 
 Wed, 28 Jan 2026 12:36:35 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e62sm24353226d6.26.2026.01.28.12.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 12:36:35 -0800 (PST)
Date: Wed, 28 Jan 2026 15:36:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 19/24] migration: Refactor qemu_savevm_state_setup()
Message-ID: <aXpzUiPGcAnFiU-S@x1.local>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-20-peterx@redhat.com>
 <87wm11ediz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wm11ediz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 28, 2026 at 04:35:32PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Split it into two smaller chunks:
> >
> >   - Dump of early_setup VMSDs
> >   - Dump of save_setup() sections
> >
> > They're mutual exclusive, hence we can run two loops and do them
> > sequentially.  This will cause migration thread to loop one more time, but
> > it should be fine when migration just started and only do it once.  It's
> > needed because we will need to reuse the early_vmsd helper later to
> > deduplicate code elsewhere.
> >
> > QEMU almost sticks with qemu_savevm_state_XXX() to represent the dump of
> > vmstates's section XXX.
> > With that in mind, this patch renamed the original
> > qemu_savevm_state_setup() to qemu_savevm_state_do_setup() instead.
> >
> > So after this patch:
> >
> >   - qemu_savevm_state_non_iterable_early() dumps early_vmsds only,
> >   - qemu_savevm_state_setup() dumps save_setup() sections only,
> >   - qemu_savevm_state_do_setup() does all things needed during setup
> >     phase (including migration SETUP notifies)
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Not for this series, but I think we could try to standardize the naming
> in savevm.c a bit. Here's a list of functions from savevm.c plus the
> main function called by them. You'll see that there's room from
> improvement.
> 
> Removing this "qemu" prefix and choosing when to put "state" in the name
> would already be a win.

True.

IMHO if we choose it again we can use prefix vmstate_.  The current
savevm_state_ is pretty vague on its own when loadvm needs to use it.  Then
it can be vmstate_save_* on save side, and vmstate_load_* on load side (and
vmstate_XXX) when valid on both.

> 
> Also maybe making more clear what calls vmstate code and what deals with
> se->ops only.

Yes we can try, but there'll be some tricky ones, inline below (assuming we
can shorten the prefix to "vmstate_").

> 
> ---
> qemu_loadvm_state_setup                  { se->ops->load_setup }

Taking this one as example.

We could rename this to vmstate_ops_load_setup(), however "load_setup" is
actually a concept that is higher than the impl.  IOW it'll be also
reasonable if we want to add a load_setup() hook to VMSDs some day.  Maybe
still good to rename it to vmstate_load_setup().

> qemu_savevm_state_active                 { se->ops->is_active }

Similarly, here I'd think vmstate_active() (it applies to both save/load)
better than vmstate_ops_active() because active describes the vmstate
instance, and it's fine one day we want to introduce VMSD.active.

...

> qemu_savevm_state_blocked                { se->vmsd->unmigratable }
> qemu_savevm_state_cleanup                { se->ops->save_cleanup }
> qemu_savevm_state_guest_unplug_pending   { se->vmsd->dev_unplug_pending }
> qemu_savevm_state_iterate                { se->ops->save_live_iterate }
> qemu_savevm_state_non_iterable_early     { se->vmsd->early_setup; vmstate_save }
> qemu_savevm_state_pending_estimate       { se->ops->state_pending_estimate }
> qemu_savevm_state_pending_exact          { se->ops->state_pending_exact }
> qemu_savevm_state_postcopy_prepare       { se->ops->save_postcopy_prepare }
> qemu_savevm_state_prepare                { se->ops->save_prepare }
> qemu_savevm_state_resume_prepare         { se->ops->resume_prepare }
> loadvm_postcopy_handle_switchover_start  { se->ops->switchover_start }
> qemu_loadvm_load_state_buffer            { se->ops->load_state_buffer }
> qemu_loadvm_state_switchover_ack_needed  { se->ops->switchover_ack_needed }
> qemu_savevm_complete                     { se->ops->save_complete }
> qemu_savevm_complete_exists              { se->ops->save_complete }
> qemu_savevm_non_migratable_list          { se->vmsd->unmigratable }
> qemu_savevm_se_iterable                  { se->ops->save_setup }
> save_state_priority                      { se->vmsd->priority }
> vmstate_load                             { se->ops->load_state }

This one (and vmstate_save()) is special because it handles both impls
(VMSD and OPS).  The current names are actually suitable.

> vmstate_save_old_style                   { se->ops->save_state }
> 
> loadvm_handle_cmd_packaged                  { qemu_loadvm_state_main }
> qemu_load_device_state                      { qemu_loadvm_state_main }
> qemu_savevm_maybe_send_switchover_start     { qemu_savevm_send_switchover_start }
> qemu_savevm_send_*                          { qemu_savevm_command_send }
> qemu_savevm_state_complete_postcopy         { qemu_savevm_complete }
> qemu_savevm_state_complete_precopy_iterable { qemu_savevm_complete }
> qemu_savevm_state_end_precopy               { qemu_savevm_state_end }
> qemu_savevm_state_header                    { qemu_savevm_send_header }

...

> 
> qemu_savevm_state_do_setup              { qemu_savevm_state_non_iterable_early;
>                                           qemu_savevm_state_setup }
> 
> qemu_loadvm_state                       { qemu_loadvm_state_header;
>                                           qemu_loadvm_state_setup;
>                                           qemu_loadvm_state_switchover_ack_needed;
>                                           qemu_loadvm_state_main;
>                                           qemu_loadvm_thread_pool_wait }
> 
> qemu_loadvm_state_main                  { qemu_loadvm_section_start_full;
>                                           qemu_loadvm_section_part_end;
>                                           loadvm_process_command }
> 
> qemu_savevm_state                       { qemu_savevm_state_header;
>                                           qemu_savevm_state_do_setup;
>                                           qemu_savevm_state_iterate;
>                                           qemu_savevm_state_complete_precopy;
>                                           qemu_savevm_state_cleanup }
> 
> qemu_savevm_state_complete_precopy      { qemu_savevm_state_complete_precopy_iterable;
>                                           qemu_savevm_state_non_iterable;
>                                           qemu_savevm_state_end_precopy }
> 
> qemu_save_device_state                  { qemu_savevm_state_non_iterable_early;
>                                           qemu_savevm_state_non_iterable;
>                                           qemu_savevm_state_end }

Most of above are special functions higher than vmstate alone, hence IMHO
not vmstate_*() APIs.  We can name it whatever way we like, or leave them
be.

> 
> loadvm_handle_recv_bitmap           { migrate_send_rp_recv_bitmap }
> loadvm_postcopy_handle_advise       { ram_postcopy_incoming_init }
> loadvm_postcopy_handle_listen       { postcopy_incoming_setup }
> loadvm_postcopy_handle_resume       { mis->postcopy_pause_sem_fault }
> loadvm_postcopy_handle_run          { loadvm_postcopy_handle_run_bh }
> loadvm_postcopy_handle_run_bh       { vm_start }
> loadvm_postcopy_ram_handle_discard  { postcopy_ram_prepare_discard }
> loadvm_process_command              { switch (cmd) }
> loadvm_process_enable_colo          { colo_init_ram_cache }

These are almost not vmstate relevant but about MIG_CMD*.  We can likely
leave them alone.  Currently the loadvm_ prefix actually sounds not too
bad.

...

[will skip most of below; we could start with vmstate API first]

> qemu_loadvm_approve_switchover      { migrate_send_rp_switchover_ack }
> qemu_loadvm_load_thread             { data->function }
> qemu_loadvm_section_part_end        { vmstate_load }
> qemu_loadvm_section_start_full      { vmstate_load }
> qemu_loadvm_start_load_thread       { thread_pool_submit }
> qemu_loadvm_state_cleanup           { se->ops->load_cleanup }
> qemu_loadvm_state_header            { QEMU_VM_FILE_MAGIC }
> qemu_loadvm_thread_pool_create      { thread_pool_new }
> qemu_loadvm_thread_pool_destroy     { thread_pool_free }
> qemu_loadvm_thread_pool_wait        { thread_pool_wait }
> qemu_savevm_command_send            { QEMU_VM_COMMAND }
> qemu_savevm_send_colo_enable        { MIG_CMD_ENABLE_COLO }
> qemu_savevm_send_configuration      { vmstate_save_state(&vmstate_configuration) }
> qemu_savevm_send_header             { QEMU_VM_FILE_MAGIC }
> qemu_savevm_state_end               { QEMU_VM_EOF }
> qemu_savevm_state_non_iterable      { vmstate_save }
> qemu_savevm_state_setup             { se->ops->save_setup }
> qemu_savevm_state_vm_desc           { QEMU_VM_VMDESCRIPTION }
> register_savevm_live                { savevm_state_handler_insert }
> save_section_footer                 { QEMU_VM_SECTION_FOOTER }
> save_section_header                 { section_type }
> savevm_state_handler_insert         { QTAILQ_INSERT_TAIL }
> savevm_state_handler_remove         { QTAILQ_REMOVE }
> unregister_savevm                   { savevm_state_handler_remove }
> vmstate_register_with_alias_id      { savevm_state_handler_insert }
> vmstate_save                        { vmstate_save_old_style; vmstate_save_state }
> vmstate_unregister                  { savevm_state_handler_remove }
> 

-- 
Peter Xu


