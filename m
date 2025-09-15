Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFFACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 20:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyFx2-0002oc-Du; Mon, 15 Sep 2025 16:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyFwx-0002nz-Ur
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:37:24 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyFwl-0001x2-BG
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:37:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEF431F7FE;
 Mon, 15 Sep 2025 20:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757968619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8wSKPGH/Tp3X+Be7s0PiK3WpCNN6PGUG4mB7x2nd4U=;
 b=Ib66SGYODCxvqb25KnO9B0qW9dx30GBYdLMuOx/qucbAjBGM7eLwVdSXgeeAvUyJlu7G9z
 qFsC2txFpkOTBAWLnIbxyt1KaiVDx8AjHQyzrB4cD7X+5tdZp3k4+oT435YvpeeWp/SxCZ
 mOzSH/21RaK1s1U/lq4fl5clzqTuJ5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757968619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8wSKPGH/Tp3X+Be7s0PiK3WpCNN6PGUG4mB7x2nd4U=;
 b=F3MAkXHViihxn1qB7JTdWmGN65BJlXLZVeVV6tFacdhxoECp0ick8CJNoCCVBBfMhRxC4V
 PV1THYbweYBNn5Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KkBXc5+c;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="S/zwUqPt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757968618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8wSKPGH/Tp3X+Be7s0PiK3WpCNN6PGUG4mB7x2nd4U=;
 b=KkBXc5+ct1c49+suKsTp9Nh7DVoMQJRZI7iwVkg/gjTKFELLzZccQjySezmuY9fL+Czoc3
 5PQsRh5yPXnlqIKZEmFqoe8KyxlmT4eQQ5aPJ2drCNK7kJaYnNG0XziOgFgwHkpL3R6nhO
 zIU93MCuUSVaEUERj5/Ey69rgJuRD28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757968618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8wSKPGH/Tp3X+Be7s0PiK3WpCNN6PGUG4mB7x2nd4U=;
 b=S/zwUqPtrbi+TO1LgZQL69qBdqhP5UH72TAvDGDNR1hqnExwRoGMQMrV64/4MyqoGwC/10
 uOs9eTzbs2RlMLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62AD61372E;
 Mon, 15 Sep 2025 20:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tCKOCOl4yGhlWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Sep 2025 20:36:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V3 8/9] migration: cpr-exec docs
In-Reply-To: <1755191843-283480-9-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-9-git-send-email-steven.sistare@oracle.com>
Date: Mon, 15 Sep 2025 17:36:54 -0300
Message-ID: <87h5x3sba1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EEF431F7FE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> Update developer documentation for cpr-exec mode.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

Just a typo below.

> ---
>  docs/devel/migration/CPR.rst | 103 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> index 0a0fd4f..abc9a90 100644
> --- a/docs/devel/migration/CPR.rst
> +++ b/docs/devel/migration/CPR.rst
> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>  VM is migrated to a new QEMU instance on the same host.  It is
>  intended for use when the goal is to update host software components
>  that run the VM, such as QEMU or even the host kernel.  At this time,
> -the cpr-reboot and cpr-transfer modes are available.
> +the cpr-reboot, cpr-transfer, and cpr-exec modes are available.
>  
>  Because QEMU is restarted on the same host, with access to the same
>  local devices, CPR is allowed in certain cases where normal migration
> @@ -324,3 +324,104 @@ descriptors from old to new QEMU.  In the future, descriptors for
>  vhost, and char devices could be transferred,
>  preserving those devices and their kernel state without interruption,
>  even if they do not explicitly support live migration.
> +
> +cpr-exec mode
> +-------------
> +
> +In this mode, QEMU stops the VM, writes VM state to the migration
> +URI, and directly exec's a new version of QEMU on the same host,
> +replacing the original process while retaining its PID.  Guest RAM is
> +preserved in place, albeit with new virtual addresses.  The user
> +completes the migration by specifying the ``-incoming`` option, and
> +by issuing the ``migrate-incoming`` command if necessary; see details
> +below.
> +
> +This mode supports VFIO/IOMMUFD devices by preserving device descriptors
> +and hence kernel state across the exec, even for devices that do not
> +support live migration.
> +
> +Because the old and new QEMU instances are not active concurrently,
> +the URI cannot be a type that streams data from one instance to the
> +other.
> +
> +Usage
> +^^^^^
> +
> +Arguments for the new QEMU process are taken from the
> +@cpr-exec-args parameter.  The first argument should be the
> +path of a new QEMU binary, or a prefix command that exec's the
> +new QEMU binary, and the arguments should include the ''-incoming''
> +option.
> +
> +Memory backend objects must have the ``share=on`` attribute.
> +The VM must be started with the ``-machine aux-ram-share=on`` option.
> +
> +Outgoing:
> +  * Set the migration mode parameter to ``cpr-exec``.
> +  * Set the ``cpr-exec-args`` parameter.
> +  * Issue the ``migrate`` command.  It is recommended the the URI be

s/the the/that the/

> +    a ``file`` type, but one can use other types such as ``exec``,
> +    provided the command captures all the data from the outgoing side,
> +    and provides all the data to the incoming side.
> +
> +Incoming:
> +  * You do not need to explicitly start new QEMU.  It is started as
> +    a side effect of the migrate command above.
> +  * If the VM was running when the outgoing ``migrate`` command was
> +    issued, then QEMU automatically resumes VM execution.
> +
> +Example 1: incoming URI
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In these examples, we simply restart the same version of QEMU, but in
> +a real scenario one would set a new QEMU binary path in cpr-exec-args.
> +
> +::
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-memfd,id=ram0,size=4G
> +  -machine memory-backend=ram0
> +  -machine aux-ram-share=on
> +  ...
> +
> +  QEMU 10.2.50 monitor - type 'help' for more information
> +  (qemu) info status
> +  VM status: running
> +  (qemu) migrate_set_parameter mode cpr-exec
> +  (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming file:vm.state
> +  (qemu) migrate -d file:vm.state
> +  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
> +  (qemu) info status
> +  VM status: running
> +
> +Example 2: incoming defer
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +::
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-memfd,id=ram0,size=4G
> +  -machine memory-backend=ram0
> +  -machine aux-ram-share=on
> +  ...
> +
> +  QEMU 10.2.50 monitor - type 'help' for more information
> +  (qemu) info status
> +  VM status: running
> +  (qemu) migrate_set_parameter mode cpr-exec
> +  (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming defer
> +  (qemu) migrate -d file:vm.state
> +  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
> +  (qemu) info status
> +  status: paused (inmigrate)
> +  (qemu) migrate_incoming file:vm.state
> +  (qemu) info status
> +  VM status: running
> +
> +Caveats
> +^^^^^^^
> +
> +cpr-exec mode may not be used with postcopy, background-snapshot,
> +or COLO.
> +
> +cpr-exec mode requires permission to use the exec system call, which
> +is denied by certain sandbox options, such as spawn.

