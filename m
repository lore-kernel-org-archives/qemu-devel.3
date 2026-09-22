Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1571C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zER-00024u-GQ; Tue, 22 Sep 2026 08:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zEP-00024O-UH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:04:18 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zEN-0004VA-Vd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:04:17 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D77651F820;
 Tue, 22 Sep 2026 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790078649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jCzFw8OBfOH5FVqNvRFYUUuGNi6XY9GdXxvsz7nkQ/8=;
 b=0igaLNpsfM+9PjHKSJ19VTyB1aDYLNzQu9zEK6Wv7n9zIZKLwpYvawI6/HYygwq7Bq5KYQ
 y3buGFPOYzoAvY2zVid4xcq/y6sLZw+/+oMd8yZB3R8EqyiFFbUWi9JWYhWY8iOkvsZ4VJ
 HgDfZ9IqWGRaBM4a74xNf+yyuGT7Aow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790078649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jCzFw8OBfOH5FVqNvRFYUUuGNi6XY9GdXxvsz7nkQ/8=;
 b=MBC7VSHJUF6p/a3FvZ/Gfp4KBmnPIpJ4nJRf77pnUfStIg0Um8/IqY8ScsM+NA6DsRx0lh
 pV6Kuzecj6cSt/Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790078644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jCzFw8OBfOH5FVqNvRFYUUuGNi6XY9GdXxvsz7nkQ/8=;
 b=LzKilkXJXqvdLC+lEA7UzLgMIR4zkBVJgylDUR2A2LktNn2BEkQTqRDbigodzLyytseoen
 tddOftq9tbLFqljoPo0yfFGvaEdelZZnFyxlz0aCBCnEofbobpeQKDAy6EAVu/HLbRyRzW
 r0yTpOErNgC/pxLt8RCJF4ZHG7keXtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790078644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jCzFw8OBfOH5FVqNvRFYUUuGNi6XY9GdXxvsz7nkQ/8=;
 b=oN9SdFf8uxkq5v3aC5oGh1Bi35sld1ytcqWjsPgVDyzgPuxwPqX96z0i3MGZRkzc8nxz3i
 pqeWd51GBo61y8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56A25136D9;
 Tue, 22 Sep 2026 12:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3V3gOrNusmp4FgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Sep 2026 12:04:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [PATCH 00/30] move to new migration APIs
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
Date: Tue, 22 Sep 2026 09:03:57 -0300
Message-ID: <87cxu5bihe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

> Hi all!
>
> That's a new version for old
>
> [RFC 00/22] migration: convert vmstate_load/save_state
>
> after the core patches converting migration code
> are already merged into master.
>
> Let's now convert the whole code base.
>
> Vladimir Sementsov-Ogievskiy (30):
>   tests/unit/test-vmstate: move to new migration APIs
>   ui/vdagent: move to new migration APIs
>   hw/virtio: extra state: move to new migration APIs
>   hw/virtio: config save/load: move to new migration APIs
>   hw/virtio: make virtio_save() and virtio_load() static
>   hw/virtio: remaining: move to new migration APIs
>   hw/s390x/virtio-ccw.c: move to new migration APIs
>   hw/scsi/spapr_vscsi: move to new migration APIs
>   hw/scsi/scsi-bus.c: use new migration APIs
>   hw/vfio/pci: move to new migration APIs
>   hw/pci/pci: move to new migration APIs
>   hw/pci/msix.c: use new migration APIs
>   hw/pci/shpc.c: use new migration APIs
>   hw/display/virtio-gpu: move to new migration APIs
>   hw/net/virtio-net.c: use new migration APIs
>   hw/nvram/eeprom93xx.c: use new migration APIs
>   hw/nvram/fw_cfg.c: use new migration APIs
>   hw/usb/redirect.c: move to new migration APIs
>   alpha/machine: move to new migration APIs
>   avr/machine: move to new migration APIs
>   or1k/machine: move to new migration APIs
>   microblaze/machine: move to new migration APIs
>   hppa/machine: move to new migration APIs
>   sparc/machine: move to new migration APIs
>   ppc/machine: move to new migration APIs
>   mips/machine: move to new migration APIs
>   arm/machine: move to new migration APIs
>   migration/vmstate-types: convert vmstate_info_g_byte_array to new APIs
>   migration: VMStateInfo: remove old .get / .set handlers
>   migration: finally drop vmstate_save/load_state() functions
>
>  hw/display/virtio-gpu.c        |  99 +++++++++++----------
>  hw/net/virtio-net.c            | 133 ++++++++++++++--------------
>  hw/nvram/eeprom93xx.c          |  17 ++--
>  hw/nvram/fw_cfg.c              |  24 ++---
>  hw/pci/msix.c                  |  17 ++--
>  hw/pci/pci.c                   |  85 +++++++++---------
>  hw/pci/shpc.c                  |  20 +++--
>  hw/s390x/virtio-ccw.c          |  40 ++++-----
>  hw/scsi/scsi-bus.c             |  17 ++--
>  hw/scsi/spapr_vscsi.c          |   9 +-
>  hw/usb/redirect.c              |  59 +++++++------
>  hw/vfio/pci.c                  |  14 ++-
>  hw/virtio/vhost-user-fs.c      |  68 +++++++-------
>  hw/virtio/virtio-mmio.c        |  31 +++----
>  hw/virtio/virtio-pci.c         |  45 +++++-----
>  hw/virtio/virtio.c             | 157 +++++++++++++++++----------------
>  include/hw/pci/pci.h           |   4 +-
>  include/hw/virtio/virtio-bus.h |   8 +-
>  include/hw/virtio/virtio.h     |   4 -
>  include/migration/vmstate.h    |  17 ----
>  migration/vmstate-types.c      |  17 ++--
>  migration/vmstate.c            |  32 +------
>  target/alpha/machine.c         |  17 ++--
>  target/arm/machine.c           | 107 +++++++++++-----------
>  target/avr/machine.c           |  50 ++++++-----
>  target/hppa/machine.c          |  34 +++----
>  target/microblaze/machine.c    |  17 ++--
>  target/mips/system/machine.c   |  49 +++++-----
>  target/or1k/machine.c          |  17 ++--
>  target/ppc/machine.c           |  80 ++++++++---------
>  target/sparc/machine.c         |  68 +++++++-------
>  tests/unit/test-vmstate.c      | 118 +++++++------------------
>  ui/vdagent.c                   |  38 ++++----
>  33 files changed, 710 insertions(+), 802 deletions(-)

Queued patches 1 and 28 for migration-next.

