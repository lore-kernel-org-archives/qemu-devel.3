Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0C8D58CC9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5168-0001Ag-GD; Tue, 24 Mar 2026 08:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5165-0000zI-NI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:43:01 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5163-0001mO-PL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:43:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0AF85BE9A;
 Tue, 24 Mar 2026 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774356175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/VVZuOaEf1Id/Xk4qf3VSDFnKtp3mD4oJ2vZlEFX1Y=;
 b=u+DO7VWIm55L0wmmas6v6wGJYDFozlOJ6Wm/M8hwdPD14tyzEw7nWhUVZqtjCwJQvycll4
 bFs/w/n7+XvNBRmfbMO8krW19gfRYdeSJkBDnOT1Xp+MzaqMWKhXNQwDiWSiqxSw93pkJv
 ImXuv92rNCsOCrE91Q4C65dqmsu4ly0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774356175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/VVZuOaEf1Id/Xk4qf3VSDFnKtp3mD4oJ2vZlEFX1Y=;
 b=xMJXNclkupQqipuBItUfbT0gmDCX6apKSYufHhYrPpTdwWEmtB8ng35FsJKlm0ix3DtGl+
 MDI3UqODFwciEEBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774356175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/VVZuOaEf1Id/Xk4qf3VSDFnKtp3mD4oJ2vZlEFX1Y=;
 b=u+DO7VWIm55L0wmmas6v6wGJYDFozlOJ6Wm/M8hwdPD14tyzEw7nWhUVZqtjCwJQvycll4
 bFs/w/n7+XvNBRmfbMO8krW19gfRYdeSJkBDnOT1Xp+MzaqMWKhXNQwDiWSiqxSw93pkJv
 ImXuv92rNCsOCrE91Q4C65dqmsu4ly0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774356175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/VVZuOaEf1Id/Xk4qf3VSDFnKtp3mD4oJ2vZlEFX1Y=;
 b=xMJXNclkupQqipuBItUfbT0gmDCX6apKSYufHhYrPpTdwWEmtB8ng35FsJKlm0ix3DtGl+
 MDI3UqODFwciEEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E1A543E40;
 Tue, 24 Mar 2026 12:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wXtrB8+GwmnSeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 12:42:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/18] migration: more bool+errp APIs
In-Reply-To: <5b67ef2c-c6c7-43bf-a3e8-88c0501b42a3@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <87seac1xy3.fsf@suse.de>
 <5b67ef2c-c6c7-43bf-a3e8-88c0501b42a3@yandex-team.ru>
Date: Tue, 24 Mar 2026 09:42:53 -0300
Message-ID: <87o6kd1jqq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.ru:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

> On 06.03.26 23:53, Fabiano Rosas wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> v3:
>>> 01,02: add r-bs by Fabiano and Peter
>>> 03: improve comment, add r-b by Peter
>>> 04: add r-bs by Fabiano and Peter
>>> 05: new, replacement for dropped "[PATCH v2 05/16] migration: vmstate_save/load_state(): stop tracing errors"
>>> 06: rebase on kept trace-points, keep r-b by Peter
>>> 07-09: add r-b by Peter
>>> 10: rebase on kept trace-points, keep r-b by Peter
>>> 11-12: add r-b by Peter
>>> 13: rebase ion kept traces and logic around trace_vmstate_load_field_error() already refactored, fix indent, drop r-b
>>> 14: add r-b by Peter
>>> 15: add r-b by Peter, use "else { if () {} }"
>>> 16-17: new
>>> 18: rebased on dropped err_hint, drop r-b
>>>
>>> Vladimir Sementsov-Ogievskiy (18):
>>>    migration: vmstate_save_state_v: fix double error_setg
>>>    migration: make vmstate_save_state_v() static
>>>    migration: make .post_save() a void function
>>>    migration: vmstate_load_state(): add some newlines
>>>    migration: vmstate_save/load_state(): refactor tracing errors
>>>    migration: factor out vmstate_pre_save() from vmstate_save_state()
>>>    migration: factor out vmstate_save_field() from vmstate_save_state()
>>>    migration: factor out vmstate_pre_load() from vmstate_load_state()
>>>    migration: factor out vmstate_load_field() from vmstate_load_state()
>>>    migration: factor out vmstate_post_load() from vmstate_load_state()
>>>    migration: convert vmstate_subsection_save/load functions to bool
>>>    migration: VMStateInfo: introduce new handlers with errp
>>>    migration: introduce vmstate_load_vmsd() and vmstate_save_vmsd()
>>>    migration/cpr: move to new migration APIs
>>>    migration/savevm: move to new migration APIs
>>>    hw/s390x/css: drop use of .err_hint for vmstate
>>>    migration: drop VMStateField.err_hint
>>>    migration/vmstate-types: move to new migration APIs
>>>
>>>   docs/devel/migration/main.rst |   2 +-
>>>   hw/block/fdc.c                |   2 +-
>>>   hw/display/qxl.c              |   4 +-
>>>   hw/display/vga.c              |   2 +-
>>>   hw/display/virtio-gpu.c       |   2 +-
>>>   hw/display/vmware_vga.c       |   2 +-
>>>   hw/i386/vmmouse.c             |   2 +-
>>>   hw/ide/ahci.c                 |   2 +-
>>>   hw/intc/openpic.c             |   2 +-
>>>   hw/intc/spapr_xive.c          |   2 +-
>>>   hw/intc/xics.c                |   2 +-
>>>   hw/intc/xive.c                |   2 +-
>>>   hw/nvram/eeprom93xx.c         |   2 +-
>>>   hw/pci/pci.c                  |   2 +-
>>>   hw/pci/pcie_aer.c             |   2 +-
>>>   hw/ppc/spapr_iommu.c          |   2 +-
>>>   hw/ppc/spapr_pci.c            |   7 +-
>>>   hw/ppc/spapr_vio.c            |   4 +-
>>>   hw/s390x/css.c                |  15 +-
>>>   hw/usb/hcd-uhci.c             |   2 +-
>>>   include/migration/cpr.h       |   2 +-
>>>   include/migration/vmstate.h   |  73 ++--
>>>   migration/cpr.c               |  22 +-
>>>   migration/savevm.c            | 108 +++---
>>>   migration/trace-events        |  30 +-
>>>   migration/vmstate-types.c     | 642 +++++++++++++++++-----------------
>>>   migration/vmstate.c           | 354 +++++++++++--------
>>>   target/arm/machine.c          |   4 +-
>>>   target/ppc/machine.c          |   6 +-
>>>   29 files changed, 691 insertions(+), 612 deletions(-)
>> 
>> Queued, thanks!
>
>
> Hi! Aren't these patches lost?

Hi, no, they are in my staging branch, I'll post when the devel window
reopens. Unfortunately the rust build issue took up the amount of time I
had slotted for this and I had to put it on hold to work on other
things.

