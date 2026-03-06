Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF836FCC076
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 20:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vycBl-0006Ix-Sf; Fri, 06 Mar 2026 15:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vycBg-0006Ij-Rt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:54:20 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vycBb-0001Iy-Ie
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:54:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9A1B5BEC4;
 Fri,  6 Mar 2026 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772830440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qSangVyA/Vm38pop4hbPvfKmeC9YLMHQejLY9W9vZrk=;
 b=VlNomPX+ah6H38vrivBq3aTIEzw5BuNHwIBk4AvnHLRwsnSHD5DeByEyd9ZrH9TAGU0uiz
 mO5RwzG1CvrNv5prequwBqXtNkI2SpeSRlAyxN4XqjRI/nRhSg14FFMt0bKJSjspWT71H8
 Peb8HLQs+k6H/gHseRY1s94rDLsMzw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772830440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qSangVyA/Vm38pop4hbPvfKmeC9YLMHQejLY9W9vZrk=;
 b=pzQ3jLYgCb9nkwAdp4GJ2OFObts0Nvya1rAAQitddn0HUxJoQbvVirHYKq+DUDACj5Db4t
 J2QR5fK1kcr120BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="U9qj/kxm";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2xAC2SLJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772830439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qSangVyA/Vm38pop4hbPvfKmeC9YLMHQejLY9W9vZrk=;
 b=U9qj/kxmJPfQgVRhfM2y87+ggsh5nWRHZpBsKEa3diRunjCP859yR0fUaJNYZG3zRsDhAL
 f/3TEP94huXy/A3/MM80DvTLWowznSnDkEvmbCnDljP7zMsDqKWGhFn6Qdlds99nkrLbMo
 aHolsbjk7esQnAmG6UMEilVJ22IbRvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772830439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qSangVyA/Vm38pop4hbPvfKmeC9YLMHQejLY9W9vZrk=;
 b=2xAC2SLJIesw3yPQ7fTZsGf8h09I1Zd5fSRomyeEqwLKnnXrAzu/cW66EdxR5SYjx0MMq4
 vpi8p2AMRqMjN4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 504A63EA75;
 Fri,  6 Mar 2026 20:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X2WcBec+q2mDSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Mar 2026 20:53:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/18] migration: more bool+errp APIs
In-Reply-To: <20260304212303.667141-1-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
Date: Fri, 06 Mar 2026 17:53:56 -0300
Message-ID: <87seac1xy3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C9A1B5BEC4
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> v3:
> 01,02: add r-bs by Fabiano and Peter
> 03: improve comment, add r-b by Peter
> 04: add r-bs by Fabiano and Peter
> 05: new, replacement for dropped "[PATCH v2 05/16] migration: vmstate_save/load_state(): stop tracing errors"
> 06: rebase on kept trace-points, keep r-b by Peter
> 07-09: add r-b by Peter
> 10: rebase on kept trace-points, keep r-b by Peter
> 11-12: add r-b by Peter
> 13: rebase ion kept traces and logic around trace_vmstate_load_field_error() already refactored, fix indent, drop r-b
> 14: add r-b by Peter
> 15: add r-b by Peter, use "else { if () {} }"
> 16-17: new
> 18: rebased on dropped err_hint, drop r-b
>
> Vladimir Sementsov-Ogievskiy (18):
>   migration: vmstate_save_state_v: fix double error_setg
>   migration: make vmstate_save_state_v() static
>   migration: make .post_save() a void function
>   migration: vmstate_load_state(): add some newlines
>   migration: vmstate_save/load_state(): refactor tracing errors
>   migration: factor out vmstate_pre_save() from vmstate_save_state()
>   migration: factor out vmstate_save_field() from vmstate_save_state()
>   migration: factor out vmstate_pre_load() from vmstate_load_state()
>   migration: factor out vmstate_load_field() from vmstate_load_state()
>   migration: factor out vmstate_post_load() from vmstate_load_state()
>   migration: convert vmstate_subsection_save/load functions to bool
>   migration: VMStateInfo: introduce new handlers with errp
>   migration: introduce vmstate_load_vmsd() and vmstate_save_vmsd()
>   migration/cpr: move to new migration APIs
>   migration/savevm: move to new migration APIs
>   hw/s390x/css: drop use of .err_hint for vmstate
>   migration: drop VMStateField.err_hint
>   migration/vmstate-types: move to new migration APIs
>
>  docs/devel/migration/main.rst |   2 +-
>  hw/block/fdc.c                |   2 +-
>  hw/display/qxl.c              |   4 +-
>  hw/display/vga.c              |   2 +-
>  hw/display/virtio-gpu.c       |   2 +-
>  hw/display/vmware_vga.c       |   2 +-
>  hw/i386/vmmouse.c             |   2 +-
>  hw/ide/ahci.c                 |   2 +-
>  hw/intc/openpic.c             |   2 +-
>  hw/intc/spapr_xive.c          |   2 +-
>  hw/intc/xics.c                |   2 +-
>  hw/intc/xive.c                |   2 +-
>  hw/nvram/eeprom93xx.c         |   2 +-
>  hw/pci/pci.c                  |   2 +-
>  hw/pci/pcie_aer.c             |   2 +-
>  hw/ppc/spapr_iommu.c          |   2 +-
>  hw/ppc/spapr_pci.c            |   7 +-
>  hw/ppc/spapr_vio.c            |   4 +-
>  hw/s390x/css.c                |  15 +-
>  hw/usb/hcd-uhci.c             |   2 +-
>  include/migration/cpr.h       |   2 +-
>  include/migration/vmstate.h   |  73 ++--
>  migration/cpr.c               |  22 +-
>  migration/savevm.c            | 108 +++---
>  migration/trace-events        |  30 +-
>  migration/vmstate-types.c     | 642 +++++++++++++++++-----------------
>  migration/vmstate.c           | 354 +++++++++++--------
>  target/arm/machine.c          |   4 +-
>  target/ppc/machine.c          |   6 +-
>  29 files changed, 691 insertions(+), 612 deletions(-)

Queued, thanks!

