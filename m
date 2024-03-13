Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B07BC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 14:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkPaR-0005py-M5; Wed, 13 Mar 2024 10:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkPaO-0005jS-8h
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:28:05 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkPaK-00040H-IB
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:28:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82B941F7D4;
 Wed, 13 Mar 2024 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710340077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5OyDaNB+5FUEe6wfcv4oIdSuSQx67supBYvsXn8/jYU=;
 b=JatGiC+PlV2AC0K4MWbThyMLESaF6Ug5mFJSBFo8h88iy57cUu7iRp5sn8s0bVyeBDFlAA
 W9cxuLRH8wpxPAUK3YhR82Hz8jzuUM8mzkTfsIR1EKxq0EqZAWd/qo5+Ptud8fRfBhCoqL
 7LwWQWnS2A3xiKwmAYdMa//6CFEOOQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710340077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5OyDaNB+5FUEe6wfcv4oIdSuSQx67supBYvsXn8/jYU=;
 b=rTvSdjxrLCfihWYhdLLB4dAToN/ayqL1bEtIkCc1EN5NrwiUk5FmCDFzxicW3t3d5k7vyv
 W4gFP77gKpc+O3CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710340077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5OyDaNB+5FUEe6wfcv4oIdSuSQx67supBYvsXn8/jYU=;
 b=JatGiC+PlV2AC0K4MWbThyMLESaF6Ug5mFJSBFo8h88iy57cUu7iRp5sn8s0bVyeBDFlAA
 W9cxuLRH8wpxPAUK3YhR82Hz8jzuUM8mzkTfsIR1EKxq0EqZAWd/qo5+Ptud8fRfBhCoqL
 7LwWQWnS2A3xiKwmAYdMa//6CFEOOQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710340077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5OyDaNB+5FUEe6wfcv4oIdSuSQx67supBYvsXn8/jYU=;
 b=rTvSdjxrLCfihWYhdLLB4dAToN/ayqL1bEtIkCc1EN5NrwiUk5FmCDFzxicW3t3d5k7vyv
 W4gFP77gKpc+O3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CB6A13977;
 Wed, 13 Mar 2024 14:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id io1WMey38WV2YQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Mar 2024 14:27:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH] migration: cpr-reboot documentation
In-Reply-To: <1710338119-330923-1-git-send-email-steven.sistare@oracle.com>
References: <1710338119-330923-1-git-send-email-steven.sistare@oracle.com>
Date: Wed, 13 Mar 2024 11:27:54 -0300
Message-ID: <877ci6cil1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JatGiC+P;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rTvSdjxr
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim,oracle.com:email];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,oracle.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 82B941F7D4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  docs/devel/migration/CPR.rst      | 147 ++++++++++++++++++++++++++++++++++++++
>  docs/devel/migration/features.rst |   1 +
>  2 files changed, 148 insertions(+)
>  create mode 100644 docs/devel/migration/CPR.rst
>
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> new file mode 100644
> index 0000000..63c3647
> --- /dev/null
> +++ b/docs/devel/migration/CPR.rst
> @@ -0,0 +1,147 @@
> +CheckPoint and Restart (CPR)
> +============================
> +
> +CPR is the umbrella name for a set of migration modes in which the
> +VM is migrated to a new QEMU instance on the same host.  It is
> +intended for use when the goal is to update host software components
> +that run the VM, such as QEMU or even the host kernel.  At this time,
> +cpr-reboot is the only available mode.
> +
> +Because QEMU is restarted on the same host, with access to the same
> +local devices, CPR is allowed in certain cases where normal migration
> +would be blocked.  However, the user must not modify the contents of
> +guest block devices between quitting old QEMU and starting new QEMU.
> +
> +CPR unconditionally stops VM execution before memory is saved, and
> +thus does not depend on any form of dirty page tracking.
> +
> +cpr-reboot mode
> +---------------
> +
> +In this mode, QEMU stops the VM, and writes VM state to the migration
> +URI, which will typically be a file.  After quitting QEMU, the user
> +resumes by running QEMU with the ``-incoming`` option.  Because the
> +old and new QEMU instances are not active concurrently, the URI cannot
> +be a type that streams data from one instance to the other.
> +
> +Guest RAM can be saved in place if backed by shared memory, or can be
> +copied to a file.  The former is more efficient and is therefore
> +preferred.
> +
> +After state and memory are saved, the user may update userland host
> +software before restarting QEMU and resuming the VM.  Further, if
> +the RAM is backed by persistent shared memory, such as a DAX device,
> +then the user may reboot to a new host kernel before restarting QEMU.
> +
> +This mode supports VFIO devices provided the user first puts the
> +guest in the suspended runstate, such as by issuing the
> +``guest-suspend-ram`` command to the QEMU guest agent.  The agent
> +must be pre-installed in the guest, and the guest must support
> +suspend to RAM.  Beware that suspension can take a few seconds, so
> +the user should poll to see the suspended state before proceeding
> +with the CPR operation.
> +
> +Usage
> +^^^^^
> +
> +It is recommended that guest RAM be backed with some type of shared
> +memory, such as ``memory-backend-file,share=on``, and that the
> +``x-ignore-shared`` capability be set.  This combination allows memory
> +to be saved in place.  Otherwise, after QEMU stops the VM, all guest
> +RAM is copied to the migration URI.
> +
> +Outgoing:
> +  * Set the migration mode parameter to ``cpr-reboot``.
> +  * Set the ``x-ignore-shared`` capability if desired.
> +  * Issue the ``migrate`` command.  It is recommended the the URI be a
> +    ``file`` type, but one can use other types such as ``exec``,
> +    provided the command captures all the data from the outgoing side,
> +    and provides all the data to the incoming side.
> +  * Quit when QEMU reaches the postmigrate state.
> +
> +Incoming:
> +  * Start QEMU with the ``-incoming defer`` option.
> +  * Set the migration mode parameter to ``cpr-reboot``.
> +  * Set the ``x-ignore-shared`` capability if desired.
> +  * Issue the ``migrate-incoming`` command.
> +  * If the VM was running when the outgoing ``migrate`` command was
> +    issued, then QEMU automatically resumes VM execution.
> +
> +Example 1
> +^^^^^^^^^
> +::
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
> +  ...
> +
> +  (qemu) info status
> +  VM status: running
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate -d file:vm.state
> +  (qemu) info status
> +  VM status: paused (postmigrate)
> +  (qemu) quit
> +
> +  ### optionally update kernel and reboot
> +  # systemctl kexec
> +  kexec_core: Starting new kernel
> +  ...
> +
> +  # qemu-kvm ... -incoming defer
> +  (qemu) info status
> +  VM status: paused (inmigrate)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate_incoming file:vm.state
> +  (qemu) info status
> +  VM status: running
> +
> +Example 2: VFIO
> +^^^^^^^^^^^^^^^
> +::
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
> +  -device vfio-pci, ...
> +  -chardev socket,id=qga0,path=qga.sock,server=on,wait=off
> +  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
> +  ...
> +
> +  (qemu) info status
> +  VM status: running
> +
> +  # echo '{"execute":"guest-suspend-ram"}' | ncat --send-only -U qga.sock
> +
> +  (qemu) info status
> +  VM status: paused (suspended)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate -d file:vm.state
> +  (qemu) info status
> +  VM status: paused (postmigrate)
> +  (qemu) quit
> +
> +  ### optionally update kernel and reboot
> +  # systemctl kexec
> +  kexec_core: Starting new kernel
> +  ...
> +
> +  # qemu-kvm ... -incoming defer
> +  (qemu) info status
> +  VM status: paused (inmigrate)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate_incoming file:vm.state
> +  (qemu) info status
> +  VM status: paused (suspended)
> +  (qemu) system_wakeup
> +  (qemu) info status
> +  VM status: running
> +
> +Caveats
> +^^^^^^^
> +
> +cpr-reboot mode may not be used with postcopy, background-snapshot,
> +or COLO.
> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index 9d1abd2..d5ca7b8 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -11,3 +11,4 @@ Migration has plenty of features to support different use cases.
>     vfio
>     virtio
>     mapped-ram
> +   CPR

Reviewed-by: Fabiano Rosas <farosas@suse.de>

