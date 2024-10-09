Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE1ACEDD89
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 13:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syWbH-000681-AY; Wed, 09 Oct 2024 09:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syWb3-000672-Pe
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:19:23 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syWb1-0002PS-Fr
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:19:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA05F21E95;
 Wed,  9 Oct 2024 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728479956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ED7tUsu7TmKjVcSIaTWGT1vbVKv4lLxuDpa22IesXl4=;
 b=oAGRaGAcgCUm4XIFJ+jpbEAR38jLGaHgeraTT6dmSm8A0+gUMHhB6V3fZw3qC16gkIPGOB
 aAOF1c/2lA0nZqWML/ZTE3+eN4JM9dGCYZ+4ulqQMSz6sR002oAkYtYHUC5qW0Nb3inz59
 GEyNd9NdckC+5ZFIdi/OM3cHdgESJS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728479956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ED7tUsu7TmKjVcSIaTWGT1vbVKv4lLxuDpa22IesXl4=;
 b=b5sBxOaHDR4QNcRiLDpM73l4eMs165C9Gz1jlS9+jzqjjnBERKCQ+eFLnpTajyfMTu8xUl
 mdmaJ1085Ce7rLCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728479955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ED7tUsu7TmKjVcSIaTWGT1vbVKv4lLxuDpa22IesXl4=;
 b=Kh7HezfX2YkPHu68rZdR2BXRfPj4guU+WbZzpAjlULaFIkxFb+EAE8RQg3jjzgaPFQ70jw
 4te8NkgoK2s7jZMdrzw7Y8N5JK65vP89G5RTNkfxe1iRecPDHsZyQUeYrdLd/CfFp4m7H5
 gNF0Ern/2zTwq25D+jw/6qJ+NnW+ULg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728479955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ED7tUsu7TmKjVcSIaTWGT1vbVKv4lLxuDpa22IesXl4=;
 b=lZVDoQDpRAdPaPPYqqds0BzVwPW5oEUlDnY2r5SiuwYTJvZMIygmYCDH6pVbFyVTCo5PY3
 qVLTtB+cNYEdRZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7595E13A58;
 Wed,  9 Oct 2024 13:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lYdSD9OCBmdOLQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Oct 2024 13:19:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Use multifd state to determine if multifd cleanup is
 needed
In-Reply-To: <168B09C3-2EDB-4C2B-AD3D-9D4B283A66C0@nutanix.com>
References: <20241007154451.107007-1-shivam.kumar1@nutanix.com>
 <ZwQLzf8mGHCr1Itg@x1n> <87h69mu164.fsf@suse.de> <ZwVJ16JDW_U6fPeo@x1n>
 <87a5fetp3k.fsf@suse.de>
 <168B09C3-2EDB-4C2B-AD3D-9D4B283A66C0@nutanix.com>
Date: Wed, 09 Oct 2024 10:19:12 -0300
Message-ID: <87y12xs9bj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[];
 REDIRECTOR_URL(0.00)[proofpoint.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]
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

Shivam Kumar <shivam.kumar1@nutanix.com> writes:

> On 9 Oct 2024, at 12:10=E2=80=AFAM, Fabiano Rosas <farosas@suse.de> wrote:
>
> !-------------------------------------------------------------------|
>  CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Peter Xu <peterx@redhat.com<mailto:peterx@redhat.com>> writes:
>
> On Tue, Oct 08, 2024 at 11:20:03AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
>
> On Mon, Oct 07, 2024 at 03:44:51PM +0000, Shivam Kumar wrote:
> If the client calls the QMP command to reset the migration
> capabilities after the migration status is set to failed or cancelled
>
> Is cancelled ok?
>
> Asked because I think migrate_fd_cleanup() should still be in CANCELLING
> stage there, so no one can disable multifd capability before that, it
> should fail the QMP command.
>
> But FAILED indeed looks problematic.
>
> IIUC it's not only to multifd alone - is it a race condition that
> migrate_fd_cleanup() can be invoked without migration_is_running() keeps
> being true?  Then I wonder what happens if a concurrent QMP "migrate"
> happens together with migrate_fd_cleanup(), even with multifd always off.
>
> Do we perhaps need to cleanup everything before the state changes to
> FAILED?
>
>
> Should we make CANCELLED the only terminal state aside from COMPLETED?
> So migrate_fd_cleanup would set CANCELLED whenever it sees either
> CANCELLING or FAILED.
>
> I think that may be a major ABI change that can be risky, as we normally
> see CANCELLED to be user's choice.
>
> Ok, I misunderstood your proposal.
>
>
> If we really want an ABI change, we could also introduce FAILING too, but=
 I
> wonder what I replied in the other email could work without any ABI chang=
e,
> but close the gap on this race.
>
> I don't think we want a FAILING state, but indeed something else that
> conveys the same meaning as CANCELLING. I have already suggested
> something similar in our TODO list[1]. We need a clear indication of
> both "cancelling" and "failing" that's decoupled from the state ABI. Of
> course we're talking only about "failing" here, we can leave
> "cancelling" which is more complex for another time maybe.
>
> What multifd does with ->exiting seems sane to me.
>
> 1- https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__wiki.qemu.org_T=
oDo_LiveMigration-23Migration-5Fcancel-5Fconcurrency&d=3DDwIBAg&c=3Ds883GpU=
COChKOHiocYtGcg&r=3D4hVFP4-J13xyn-OcN0apTCh8iKZRosf5OJTQePXBMB8&m=3D8BHh6O0=
5G9bfMxWIM951LFPPGU1RqpOpPUOd646hGmzh7_Aes30zw81Pj4OAxVmc&s=3Dxqf0rCR4tKMBp=
r7flPSuGtGkAFy5txwi0Wf_Sa-MR84&e=3D
> Having flags to track the 'cancelling' and =E2=80=98failing=E2=80=99 stat=
es makes
> sense. I think they should be a part of MigrationState itself. I will
> send follow-up patches.
>
> However, can this patch be accpeted as a cosmetic change? To me, it
> makes sense to check 'multifd_send_state' and not migration multifd
> capability before cleaning 'multifd_send_state'.  And this also helps
> with one race at least (with qmp_migrate_set_capabilities).
> Please let me know if you have different thoughts.

This change cannot be considered cosmetic. There is the implication that
checking a capability state is not enough to determine if code
pertaining to that feature can be executed. So it makes for more
confusing code overall. I'd prefer if we fixed the underlying issue of
reaching multifd_send_shutdown() while capabilities can be cleared.

