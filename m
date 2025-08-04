Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEACC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0rc-0006r2-Iu; Mon, 04 Aug 2025 15:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uj0Im-0005Nv-R5
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:52:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uj0Il-0003Ux-9z
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:52:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B53F9219F7;
 Mon,  4 Aug 2025 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754333569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8fvFrJce7GkUrfeJQ/he1NeBLiQt/hMIjqYUITGWoY=;
 b=HzQ0JPEK6TUTU6DqQdeQ9e+rHqztuMuZpKcnWBTCfs8DlRwjlN6QK8fDMBJaTb5idivLu/
 U76eKO2Rf7Ra269PEAVyP45Incb9Wy5DJA6MpAvERz4oUyJQpIgGKL1DjqiaZWRtU4RgI0
 ea3gBS7SGtqNgQOEG2U/2lOKDfABpEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754333569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8fvFrJce7GkUrfeJQ/he1NeBLiQt/hMIjqYUITGWoY=;
 b=6agGksn2mPtuXvVpbkuxODlfyjRxb7slyLEwjAyk5gKApnU8lGCehxLgoZrmAQ4SMR/Me6
 AOXav+4xegdrjbBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754333569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8fvFrJce7GkUrfeJQ/he1NeBLiQt/hMIjqYUITGWoY=;
 b=HzQ0JPEK6TUTU6DqQdeQ9e+rHqztuMuZpKcnWBTCfs8DlRwjlN6QK8fDMBJaTb5idivLu/
 U76eKO2Rf7Ra269PEAVyP45Incb9Wy5DJA6MpAvERz4oUyJQpIgGKL1DjqiaZWRtU4RgI0
 ea3gBS7SGtqNgQOEG2U/2lOKDfABpEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754333569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8fvFrJce7GkUrfeJQ/he1NeBLiQt/hMIjqYUITGWoY=;
 b=6agGksn2mPtuXvVpbkuxODlfyjRxb7slyLEwjAyk5gKApnU8lGCehxLgoZrmAQ4SMR/Me6
 AOXav+4xegdrjbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36EAA133D1;
 Mon,  4 Aug 2025 18:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EsCAOoABkWiqMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Aug 2025 18:52:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Cedric Le Goater
 <clg@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex
 Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V2 1/1] hw/intc/arm_gicv3_kvm: preserve pending
 interrupts during cpr
In-Reply-To: <4c6c57c6-fe7d-44a4-a875-3ede9e0aba58@oracle.com>
References: <1752689274-233526-1-git-send-email-steven.sistare@oracle.com>
 <CAFEAcA8P4H7n=uXe3qredxVMwB4QtDfZtVyuuTWBLwa6enGR3g@mail.gmail.com>
 <63d52f3e-5d29-45be-986c-3827a5c0cb5c@oracle.com>
 <CAFEAcA-TsQdFt7S=qyd14gxW095t=Nx2skaxnmxtGUhR9pubtA@mail.gmail.com>
 <4c6c57c6-fe7d-44a4-a875-3ede9e0aba58@oracle.com>
Date: Mon, 04 Aug 2025 15:52:46 -0300
Message-ID: <87ms8e3on5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 8/4/2025 10:47 AM, Peter Maydell wrote:
>> On Mon, 4 Aug 2025 at 15:23, Steven Sistare <steven.sistare@oracle.com> wrote:
>>>
>>> Fabiano, could you sanity check this patch? Thanks!
>>>
>>> Peter, more below:
>>>
>>> On 7/21/2025 6:24 AM, Peter Maydell wrote:
>>>>> @@ -883,13 +895,17 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>>>>>                                   GICD_CTLR)) {
>>>>>            error_setg(&s->migration_blocker, "This operating system kernel does "
>>>>>                                              "not support vGICv3 migration");
>>>>> -        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>>>>> +        if (migrate_add_blocker_modes(&s->migration_blocker, MIG_MODE_NORMAL,
>>>>> +                                      MIG_MODE_CPR_TRANSFER, errp) < 0) {
>>>>
>>>> Why did you change this? It's the general "if no support, can't
>>>> migrate at all" check, which seems unrelated to cpr-transfer.
>>>
>>> "If no support", then cpr-transfer should also be blocked.
>> 
>> But migrate_add_blocker() is a wrapper for
>> migrate_add_blocker_modes(..., MIG_MODE_ALL). So doesn't
>> this change go from "block migration for normal, and cpr-transfer,
>> and everything else" to "block migration for normal and
>> cpr-transfer but let the rest through"?
>> 
>> That doesn't seem like the right thing; if it *is* the right
>> thing then it should be a separate patch with a commit message
>> that explains why we do it; and we would probably want to
>> audit all the other uses of plain migrate_add_blocker() and/or
>> change that function's name or API...
>
> Yup, my bad. I will revert this hunk.
>

With that,

Reviewed-by: Fabiano Rosas <farosas@suse.de>

