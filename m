Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B48CF539E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 15:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3cwB-0005TF-0w; Wed, 23 Oct 2024 11:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t3cw8-0005T0-Ps
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:06:12 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t3cw4-0002Ka-JE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:06:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D73361FB58;
 Wed, 23 Oct 2024 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729695963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTw5oScmlrhD+n9qWthUDa9Ny9olGBls5oyEiW9bzPw=;
 b=1MELnhMMdY3NvhhwWzN9OtDpS9tR4viaO5AmIXxu4ey/CVV3oA6GwhBzPSkgqJB7l3qEdm
 FfPzJHvMSpMc5uWoJGB2Izf6+Oe9P5vdrSkT7u6qxjuWoU044k461xWvSTA0Wweqi8ylGM
 Y9t4kscwGtQBCOaamCwzxwrbTKJbHls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729695963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTw5oScmlrhD+n9qWthUDa9Ny9olGBls5oyEiW9bzPw=;
 b=+UKYj/3fg1GPMCHf9bLiEZot8OC64E0qIQ3awb40KJDB/SUMjoTYXA6BHVTTAb0M2HJFEe
 KKOnW/IV3FpzTjCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729695962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTw5oScmlrhD+n9qWthUDa9Ny9olGBls5oyEiW9bzPw=;
 b=aPOI6BSwuibiUdC1oFQRXvJ4yNvGUcd/S4NuCfTmDqW5tfSRCNO1wCZLQBQG3wFGyvZ2Ye
 tLF1xLNsskuYt6611HaGMGCwBcs6qbR5DhaRWAceDp1K6JYiaVRI/hW/dk8t6XbApvIA9/
 qAscpg+fM0oFDe5piV9287b5vP29j7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729695962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTw5oScmlrhD+n9qWthUDa9Ny9olGBls5oyEiW9bzPw=;
 b=/GS7rScRCE0E1PaObqDnzmw64FwnhFZL6HOzSCdfD4fADC7hFlfxqojUf5+DdjZEk9td9l
 YqwVOlcAGLiTeZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61C0C13A63;
 Wed, 23 Oct 2024 15:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1DxjCtoQGWe0IQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Oct 2024 15:06:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
In-Reply-To: <cover.1729562974.git.yong.huang@smartx.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
Date: Wed, 23 Oct 2024 12:05:59 -0300
Message-ID: <87sesmdfl4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> v3:
> 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by Da=
niel=20
>
> Please review, thanks
> Yong
>
> v2:
> 1. Update the MAINTAINERS section suggested by Fabiano Rosas=20
> 2. Ensure the dependencies when build the initrd-stress.img suggested by =
Daniel
> 3. Fix some bugs
>
> v1:
> The previous patchset:
> https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx=
.com/
> does not made the necessary changes and tests for the upstream version.
>
> This patchset works for that:
> 1. Move the guestperf to scripts directory suggested by Fabiano Rosas
> 2. Make initrd-stress.img built by default suggested by Fabiano Rosas
> 3. Make the necessary changes to adapt the latest multifd behavior
> 4. A nitpick for multifd migration
> 5. Support multifd compression option
>
> Hyman Huang (5):
>   tests/migration: Move the guestperf tool to scripts directory
>   tests/migration: Make initrd-stress.img built by default
>   guestperf: Support deferred migration for multifd
>   guestperf: Nitpick the inconsistent parameters
>   guestperf: Introduce multifd compression option
>
>  MAINTAINERS                                   |  5 +++
>  .../migration/guestperf-batch.py              |  0
>  .../migration/guestperf-plot.py               |  0
>  {tests =3D> scripts}/migration/guestperf.py     |  0
>  .../migration/guestperf/__init__.py           |  0
>  .../migration/guestperf/comparison.py         | 15 ++++++++-
>  .../migration/guestperf/engine.py             | 33 ++++++++++++++++---
>  .../migration/guestperf/hardware.py           |  0
>  .../migration/guestperf/plot.py               |  0
>  .../migration/guestperf/progress.py           |  0
>  .../migration/guestperf/report.py             |  0
>  .../migration/guestperf/scenario.py           |  7 ++--
>  .../migration/guestperf/shell.py              |  3 ++
>  .../migration/guestperf/timings.py            |  0
>  tests/migration/meson.build                   | 30 +++++++++--------
>  15 files changed, 73 insertions(+), 20 deletions(-)
>  rename {tests =3D> scripts}/migration/guestperf-batch.py (100%)
>  rename {tests =3D> scripts}/migration/guestperf-plot.py (100%)
>  rename {tests =3D> scripts}/migration/guestperf.py (100%)
>  rename {tests =3D> scripts}/migration/guestperf/__init__.py (100%)
>  rename {tests =3D> scripts}/migration/guestperf/comparison.py (89%)
>  rename {tests =3D> scripts}/migration/guestperf/engine.py (93%)
>  rename {tests =3D> scripts}/migration/guestperf/hardware.py (100%)
>  rename {tests =3D> scripts}/migration/guestperf/plot.py (100%)
>  rename {tests =3D> scripts}/migration/guestperf/progress.py (100%)
>  rename {tests =3D> scripts}/migration/guestperf/report.py (100%)
>  rename {tests =3D> scripts}/migration/guestperf/scenario.py (93%)
>  rename {tests =3D> scripts}/migration/guestperf/shell.py (98%)
>  rename {tests =3D> scripts}/migration/guestperf/timings.py (100%)

Reviewed-by: Fabiano Rosas <farosas@suse.de>


Thinking out loud a little bit, it's still somewhat obscure from which
directory this script should be called. None of these invocations work:

$ ./scripts/migration/guestperf.py

$ ./build/scripts/migration/guestperf.py

$ cd scripts/migration
$ ./guestperf.py

$ cd build/scripts/migration
$ ./guestperf.py

Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=E2=80=9D: op=
en() failed:
No such file or directory

This is the only one that works:
$ cd build
$ ./scripts/migration/guestperf.py

Maybe we could improve that somehow in the future.


