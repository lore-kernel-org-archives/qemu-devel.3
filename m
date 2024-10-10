Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB66DD2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 20:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz087-00032R-Bn; Thu, 10 Oct 2024 16:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sz085-00032A-Eo
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:51:26 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sz083-0007c8-Nn
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:51:25 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 806971FE32;
 Thu, 10 Oct 2024 20:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728593479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51MOetaPlixfPFAdTfo2QPJtkw+5tygnpjgbPdgR9wc=;
 b=RJIOCeLB0eZVCtkGNUi1Irr4Za8SYTn5w5XTfeml/x0gPYeBQyNZM/BPPVDyFxyqmOv4Of
 1xlFhui9bYtEcTD41n542SghFCWq5hlTHDxqnV7glHPqxNp0lOqTChv5qrHWk+2WmEJUZc
 ONgVCBr/zoWPv48WT7/FIHCSaV7Zcc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728593479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51MOetaPlixfPFAdTfo2QPJtkw+5tygnpjgbPdgR9wc=;
 b=4/Yl5gPMeCc+LEcEB9loyyhKbCx3NO4c0OC8bgkmu/65kl3mDENt7j0AXnbBPtYpm08/VI
 z9GDdr9MDw2TptDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728593479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51MOetaPlixfPFAdTfo2QPJtkw+5tygnpjgbPdgR9wc=;
 b=RJIOCeLB0eZVCtkGNUi1Irr4Za8SYTn5w5XTfeml/x0gPYeBQyNZM/BPPVDyFxyqmOv4Of
 1xlFhui9bYtEcTD41n542SghFCWq5hlTHDxqnV7glHPqxNp0lOqTChv5qrHWk+2WmEJUZc
 ONgVCBr/zoWPv48WT7/FIHCSaV7Zcc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728593479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51MOetaPlixfPFAdTfo2QPJtkw+5tygnpjgbPdgR9wc=;
 b=4/Yl5gPMeCc+LEcEB9loyyhKbCx3NO4c0OC8bgkmu/65kl3mDENt7j0AXnbBPtYpm08/VI
 z9GDdr9MDw2TptDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A9351370C;
 Thu, 10 Oct 2024 20:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z7HQMEY+CGc+WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Oct 2024 20:51:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: precreate phase
In-Reply-To: <b57f8eda-d0ec-469f-8ac2-635f3c8d238b@oracle.com>
References: <b57f8eda-d0ec-469f-8ac2-635f3c8d238b@oracle.com>
Date: Thu, 10 Oct 2024 17:51:16 -0300
Message-ID: <877cafsmuz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Steven Sistare <steven.sistare@oracle.com> writes:

> Peter, Fabiano,
>
> I have a nice solution that allows dest qemu configuration with cpr-transfer.
> I define a new qemu initialization phase called 'precreate' which occurs
> before most backends or devices have been created.  The only exception
> is monitor devices and the qtest device and their chardevs, which are created.
> I untangled dependencies so that that migration_object_init can be called
> before this phase.  The monitor accepts commands during this phase and can
> receive migration configuration commands.  qemu starts listening on the
> normal migration URI during this phase (which can come from either the
> qemu command line or from a migrate_incoming command) so the user can
> issue query-migrate to get the socket-address for dynamically allocated
> port numbers.
>
> qemu enters the phase if qemu is started with the -precreate option.
> The phase ends when the user sends a precreate-exit command.
> Qemu then calls cpr_load_state and reads from the normal migration connection
> as in the existing design, including the HUP.
>
> (This sounds like the preconfig phase, but that occurs too late, after
> backends have been created.)
>
> I implemented this scheme for another reason but abandoned it, so I need
> a few days to rebase it and test.  It is not small, and requires approvals
> from additional maintainers.  Let me know if you think this is the right
> solution, and I will revive it.

Seems reasonable to me, given the requirements we're working with. Was
there a branch we could skim somewhere?

>
> Preview:
>
>    0725d70 vl: precreate phase
>    edd2dee net: cleanup for precreate phase
>    4733c00 accel: encapsulate search state
>    6d26ea4 accel: accel preinit function
>    518e737 accel: split configure_accelerators
>    8ef936b accel: delete accelerator and machine props
>    b5c2a84 accel: set accelerator and machine props earlier
>    56890a0 migration: init early
>    76506b2 monitor: chardev name
>    e85111d qom: get properties
>    8356f7e qemu-option: filtered foreach
>    fb6cc98 qemu-options: pass object to filter
>    bdfec1b monitor: connect in precreate
>    8f2f292 qtest: connect in precreate
>    629cb50 migration: connect URI early
>    0ae530e migration: allow commands during precreate and preconfig
>
>   accel/accel-system.c            |   2 -
>   accel/kvm/kvm-all.c             |  58 +++++---
>   accel/xen/xen-all.c             |  11 +-
>   hmp-commands.hx                 |  20 +++
>   include/migration/misc.h        |   2 +
>   include/monitor/hmp.h           |   1 +
>   include/monitor/monitor.h       |   1 +
>   include/qapi/visitor.h          |   1 +
>   include/qemu/accel.h            |   1 +
>   include/qemu/option.h           |   5 +
>   include/qom/object_interfaces.h |   2 +
>   include/sysemu/sysemu.h         |   3 +
>   migration/migration.c           |  31 +++++
>   monitor/hmp-cmds.c              |   8 ++
>   monitor/monitor.c               |  21 +++
>   net/net.c                       |   4 +-
>   qapi/migration.json             |  16 ++-
>   qapi/misc.json                  |  23 +++-
>   qemu-options.hx                 |  13 ++
>   qom/object_interfaces.c         |  27 ++--
>   system/vl.c                     | 291 +++++++++++++++++++++++++++++++---------
>   target/i386/nvmm/nvmm-all.c     |  10 +-
>   target/i386/whpx/whpx-all.c     |  14 +-
>   util/qemu-option.c              |  25 ++++
>   24 files changed, 471 insertions(+), 119 deletions(-)

