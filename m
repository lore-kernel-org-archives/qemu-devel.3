Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75E1D46C05
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 21:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlDDt-0003SK-8L; Wed, 28 Jan 2026 16:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vlDDX-0003Om-9O
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 16:36:51 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vlDDV-00021Y-AG
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 16:36:51 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21B9533DBB;
 Wed, 28 Jan 2026 21:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769636207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpeMTMmpULJeOmJlZ+MmOYSaIS8ucvbu0mi5O7CiFh4=;
 b=kmgzJBzHy2rEB6TVq6gyDoJkJObBMxDo0DmU42KMnkh8X7BvOUKthLTa9JfY1UXYAbunQ1
 sxQUA0M8/C/a1SpLKKsjxeF8Dgu4P8zQnuoeKBOrTYSWgpXKliS0SelrINxi7GSA0xrAxj
 2PehMQ3mwj6REkzvM+qf1So6PCmognA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769636207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpeMTMmpULJeOmJlZ+MmOYSaIS8ucvbu0mi5O7CiFh4=;
 b=U6OIhyhWMdFswDcrFUm+mQpI2zoPp4WEuCcItNl3uvh15yc5Luc9xX88iaAdrG0BxqXd6N
 SHq3frOTw9V2RdBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769636207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpeMTMmpULJeOmJlZ+MmOYSaIS8ucvbu0mi5O7CiFh4=;
 b=kmgzJBzHy2rEB6TVq6gyDoJkJObBMxDo0DmU42KMnkh8X7BvOUKthLTa9JfY1UXYAbunQ1
 sxQUA0M8/C/a1SpLKKsjxeF8Dgu4P8zQnuoeKBOrTYSWgpXKliS0SelrINxi7GSA0xrAxj
 2PehMQ3mwj6REkzvM+qf1So6PCmognA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769636207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpeMTMmpULJeOmJlZ+MmOYSaIS8ucvbu0mi5O7CiFh4=;
 b=U6OIhyhWMdFswDcrFUm+mQpI2zoPp4WEuCcItNl3uvh15yc5Luc9xX88iaAdrG0BxqXd6N
 SHq3frOTw9V2RdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D5A63EA61;
 Wed, 28 Jan 2026 21:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iXvPE26BemkoFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 21:36:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 19/24] migration: Refactor qemu_savevm_state_setup()
In-Reply-To: <aXpzUiPGcAnFiU-S@x1.local>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-20-peterx@redhat.com> <87wm11ediz.fsf@suse.de>
 <aXpzUiPGcAnFiU-S@x1.local>
Date: Wed, 28 Jan 2026 18:36:43 -0300
Message-ID: <87343pto5w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,web.de,redhat.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jan 28, 2026 at 04:35:32PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Split it into two smaller chunks:
>> >
>> >   - Dump of early_setup VMSDs
>> >   - Dump of save_setup() sections
>> >
>> > They're mutual exclusive, hence we can run two loops and do them
>> > sequentially.  This will cause migration thread to loop one more time, but
>> > it should be fine when migration just started and only do it once.  It's
>> > needed because we will need to reuse the early_vmsd helper later to
>> > deduplicate code elsewhere.
>> >
>> > QEMU almost sticks with qemu_savevm_state_XXX() to represent the dump of
>> > vmstates's section XXX.
>> > With that in mind, this patch renamed the original
>> > qemu_savevm_state_setup() to qemu_savevm_state_do_setup() instead.
>> >
>> > So after this patch:
>> >
>> >   - qemu_savevm_state_non_iterable_early() dumps early_vmsds only,
>> >   - qemu_savevm_state_setup() dumps save_setup() sections only,
>> >   - qemu_savevm_state_do_setup() does all things needed during setup
>> >     phase (including migration SETUP notifies)
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> 
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> 
>> Not for this series, but I think we could try to standardize the naming
>> in savevm.c a bit. Here's a list of functions from savevm.c plus the
>> main function called by them. You'll see that there's room from
>> improvement.
>> 
>> Removing this "qemu" prefix and choosing when to put "state" in the name
>> would already be a win.
>
> True.
>
> IMHO if we choose it again we can use prefix vmstate_.  The current
> savevm_state_ is pretty vague on its own when loadvm needs to use it.  Then
> it can be vmstate_save_* on save side, and vmstate_load_* on load side (and
> vmstate_XXX) when valid on both.
>

It's slightly annoying that vmstate is also used in the macros and
virtually every single VMStateDescription all over QEMU. I wish we had a
separate name for the implementation. But vmstate_ is definitely better
than qemu_savevm_state_.

Or perhaps something like migstate, migvm, etc.

I think we could see great benefit from a small-ish change doing:
s/qemu_savevm_state_/new_name_/ and s/SaveStateEntry/NewNameEntry/

Because then it becomes clear there's a high level thing that deals with
SaveVMHandlers and VMStateDescription which are two different ways of
migrating state.

>> 
>> Also maybe making more clear what calls vmstate code and what deals with
>> se->ops only.
>
> Yes we can try, but there'll be some tricky ones, inline below (assuming we
> can shorten the prefix to "vmstate_").
>

Yeah, I see.

>> 
>> ---
>> qemu_loadvm_state_setup                  { se->ops->load_setup }
>
> Taking this one as example.
>
> We could rename this to vmstate_ops_load_setup(), however "load_setup" is
> actually a concept that is higher than the impl.  IOW it'll be also
> reasonable if we want to add a load_setup() hook to VMSDs some day.  Maybe
> still good to rename it to vmstate_load_setup().
>
>> qemu_savevm_state_active                 { se->ops->is_active }
>
> Similarly, here I'd think vmstate_active() (it applies to both save/load)
> better than vmstate_ops_active() because active describes the vmstate
> instance, and it's fine one day we want to introduce VMSD.active.
>
> ...
>
>> qemu_savevm_state_blocked                { se->vmsd->unmigratable }
>> qemu_savevm_state_cleanup                { se->ops->save_cleanup }
>> qemu_savevm_state_guest_unplug_pending   { se->vmsd->dev_unplug_pending }
>> qemu_savevm_state_iterate                { se->ops->save_live_iterate }
>> qemu_savevm_state_non_iterable_early     { se->vmsd->early_setup; vmstate_save }
>> qemu_savevm_state_pending_estimate       { se->ops->state_pending_estimate }
>> qemu_savevm_state_pending_exact          { se->ops->state_pending_exact }
>> qemu_savevm_state_postcopy_prepare       { se->ops->save_postcopy_prepare }
>> qemu_savevm_state_prepare                { se->ops->save_prepare }
>> qemu_savevm_state_resume_prepare         { se->ops->resume_prepare }
>> loadvm_postcopy_handle_switchover_start  { se->ops->switchover_start }
>> qemu_loadvm_load_state_buffer            { se->ops->load_state_buffer }
>> qemu_loadvm_state_switchover_ack_needed  { se->ops->switchover_ack_needed }
>> qemu_savevm_complete                     { se->ops->save_complete }
>> qemu_savevm_complete_exists              { se->ops->save_complete }
>> qemu_savevm_non_migratable_list          { se->vmsd->unmigratable }
>> qemu_savevm_se_iterable                  { se->ops->save_setup }
>> save_state_priority                      { se->vmsd->priority }
>> vmstate_load                             { se->ops->load_state }
>
> This one (and vmstate_save()) is special because it handles both impls
> (VMSD and OPS).  The current names are actually suitable.
>
>> vmstate_save_old_style                   { se->ops->save_state }
>> 
>> loadvm_handle_cmd_packaged                  { qemu_loadvm_state_main }
>> qemu_load_device_state                      { qemu_loadvm_state_main }
>> qemu_savevm_maybe_send_switchover_start     { qemu_savevm_send_switchover_start }
>> qemu_savevm_send_*                          { qemu_savevm_command_send }
>> qemu_savevm_state_complete_postcopy         { qemu_savevm_complete }
>> qemu_savevm_state_complete_precopy_iterable { qemu_savevm_complete }
>> qemu_savevm_state_end_precopy               { qemu_savevm_state_end }
>> qemu_savevm_state_header                    { qemu_savevm_send_header }
>
> ...
>
>> 
>> qemu_savevm_state_do_setup              { qemu_savevm_state_non_iterable_early;
>>                                           qemu_savevm_state_setup }
>> 
>> qemu_loadvm_state                       { qemu_loadvm_state_header;
>>                                           qemu_loadvm_state_setup;
>>                                           qemu_loadvm_state_switchover_ack_needed;
>>                                           qemu_loadvm_state_main;
>>                                           qemu_loadvm_thread_pool_wait }
>> 
>> qemu_loadvm_state_main                  { qemu_loadvm_section_start_full;
>>                                           qemu_loadvm_section_part_end;
>>                                           loadvm_process_command }
>> 
>> qemu_savevm_state                       { qemu_savevm_state_header;
>>                                           qemu_savevm_state_do_setup;
>>                                           qemu_savevm_state_iterate;
>>                                           qemu_savevm_state_complete_precopy;
>>                                           qemu_savevm_state_cleanup }
>> 
>> qemu_savevm_state_complete_precopy      { qemu_savevm_state_complete_precopy_iterable;
>>                                           qemu_savevm_state_non_iterable;
>>                                           qemu_savevm_state_end_precopy }
>> 
>> qemu_save_device_state                  { qemu_savevm_state_non_iterable_early;
>>                                           qemu_savevm_state_non_iterable;
>>                                           qemu_savevm_state_end }
>
> Most of above are special functions higher than vmstate alone, hence IMHO
> not vmstate_*() APIs.  We can name it whatever way we like, or leave them
> be.
>

They definitely need a better name, it's only a question of "when".

>> 
>> loadvm_handle_recv_bitmap           { migrate_send_rp_recv_bitmap }
>> loadvm_postcopy_handle_advise       { ram_postcopy_incoming_init }
>> loadvm_postcopy_handle_listen       { postcopy_incoming_setup }
>> loadvm_postcopy_handle_resume       { mis->postcopy_pause_sem_fault }
>> loadvm_postcopy_handle_run          { loadvm_postcopy_handle_run_bh }
>> loadvm_postcopy_handle_run_bh       { vm_start }
>> loadvm_postcopy_ram_handle_discard  { postcopy_ram_prepare_discard }
>> loadvm_process_command              { switch (cmd) }
>> loadvm_process_enable_colo          { colo_init_ram_cache }
>
> These are almost not vmstate relevant but about MIG_CMD*.  We can likely
> leave them alone.  Currently the loadvm_ prefix actually sounds not too
> bad.
>

I agree.

> ...
>
> [will skip most of below; we could start with vmstate API first]
>
>> qemu_loadvm_approve_switchover      { migrate_send_rp_switchover_ack }
>> qemu_loadvm_load_thread             { data->function }
>> qemu_loadvm_section_part_end        { vmstate_load }
>> qemu_loadvm_section_start_full      { vmstate_load }
>> qemu_loadvm_start_load_thread       { thread_pool_submit }
>> qemu_loadvm_state_cleanup           { se->ops->load_cleanup }
>> qemu_loadvm_state_header            { QEMU_VM_FILE_MAGIC }
>> qemu_loadvm_thread_pool_create      { thread_pool_new }
>> qemu_loadvm_thread_pool_destroy     { thread_pool_free }
>> qemu_loadvm_thread_pool_wait        { thread_pool_wait }
>> qemu_savevm_command_send            { QEMU_VM_COMMAND }
>> qemu_savevm_send_colo_enable        { MIG_CMD_ENABLE_COLO }
>> qemu_savevm_send_configuration      { vmstate_save_state(&vmstate_configuration) }
>> qemu_savevm_send_header             { QEMU_VM_FILE_MAGIC }
>> qemu_savevm_state_end               { QEMU_VM_EOF }
>> qemu_savevm_state_non_iterable      { vmstate_save }
>> qemu_savevm_state_setup             { se->ops->save_setup }
>> qemu_savevm_state_vm_desc           { QEMU_VM_VMDESCRIPTION }
>> register_savevm_live                { savevm_state_handler_insert }
>> save_section_footer                 { QEMU_VM_SECTION_FOOTER }
>> save_section_header                 { section_type }
>> savevm_state_handler_insert         { QTAILQ_INSERT_TAIL }
>> savevm_state_handler_remove         { QTAILQ_REMOVE }
>> unregister_savevm                   { savevm_state_handler_remove }
>> vmstate_register_with_alias_id      { savevm_state_handler_insert }
>> vmstate_save                        { vmstate_save_old_style; vmstate_save_state }
>> vmstate_unregister                  { savevm_state_handler_remove }
>> 

