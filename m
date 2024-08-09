Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A23C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 12:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scPBn-0006qA-UM; Fri, 09 Aug 2024 08:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1scPBd-0006pY-Kn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:57:41 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1scPBb-0005Nb-Fs
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:57:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FCFE1FF62;
 Fri,  9 Aug 2024 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723208256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OUa+7cddpkmIsARzZi5G0iPbiA8w0Q8d3dlNdFuJaNQ=;
 b=phS0GxOp5dT60PvkuuoJl335T5hWajoIxa30H0XbZ3rWJ+V88T6IkX2tJI2Iip9QJeROBt
 XLlsDX65Bp/q3ybbRn7Q6CVUjVQeD1zo/K8vsh0Ttk1ywkTiEQiWGrdjpnt9wnxBkFYQYI
 zht4zXz8LRMjcjYzjxavWxQjjhrhrMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723208256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OUa+7cddpkmIsARzZi5G0iPbiA8w0Q8d3dlNdFuJaNQ=;
 b=lGlZ33dqjzXHI4u9zHjtrOThPkJl4f7CiEB6oF/GSu2JOp21M8xipoxNpNGavi4Ziw7A+8
 KkfHtnH3xsZyvGCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="NSQjZY/O";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jW6ibhoV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723208255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OUa+7cddpkmIsARzZi5G0iPbiA8w0Q8d3dlNdFuJaNQ=;
 b=NSQjZY/O3yyvb06a07yfSdDOi93lOHopK8H6Ys3IRG7y5oech94VVSIG54yY79+ipTrwcg
 zg/RObIzkByBSZ7kc5AeggHvsXxutQcWkhKGXLPiosR4jICFx+eHjNwpAHywX9Z1deaJbR
 wG2uNKH+fup4bD3dG0suaroKosTRwFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723208255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OUa+7cddpkmIsARzZi5G0iPbiA8w0Q8d3dlNdFuJaNQ=;
 b=jW6ibhoVHatRTNV7Tfv+0PSih4OFcoZpfw4b+5ckqUs/beGZfs4QQ7Ip3lSG6dsecv5w7B
 c/HqmQUowLyoblBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2F7F1379A;
 Fri,  9 Aug 2024 12:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aVT9KT4Stmb8dgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Aug 2024 12:57:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH v1 1/5] tests/migration: Move the guestperf tool to
 scripts directory
In-Reply-To: <38f6c0a2385f75f437d2b8b7b5fa82adacc2879c.1723189080.git.yong.huang@smartx.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
 <38f6c0a2385f75f437d2b8b7b5fa82adacc2879c.1723189080.git.yong.huang@smartx.com>
Date: Fri, 09 Aug 2024 09:57:32 -0300
Message-ID: <87y155g8g3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6FCFE1FF62
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> Guestperf was designed to test the performance of migration,
> with a loose connection to the fundamental test cases of QEMU.
>
> To improve the repository's structure, move it to the scripts
> directory.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  MAINTAINERS                                          | 5 +++++
>  {tests => scripts}/migration/guestperf-batch.py      | 0
>  {tests => scripts}/migration/guestperf-plot.py       | 0
>  {tests => scripts}/migration/guestperf.py            | 0
>  {tests => scripts}/migration/guestperf/__init__.py   | 0
>  {tests => scripts}/migration/guestperf/comparison.py | 0
>  {tests => scripts}/migration/guestperf/engine.py     | 0
>  {tests => scripts}/migration/guestperf/hardware.py   | 0
>  {tests => scripts}/migration/guestperf/plot.py       | 0
>  {tests => scripts}/migration/guestperf/progress.py   | 0
>  {tests => scripts}/migration/guestperf/report.py     | 0
>  {tests => scripts}/migration/guestperf/scenario.py   | 0
>  {tests => scripts}/migration/guestperf/shell.py      | 0
>  {tests => scripts}/migration/guestperf/timings.py    | 0
>  14 files changed, 5 insertions(+)
>  rename {tests => scripts}/migration/guestperf-batch.py (100%)
>  rename {tests => scripts}/migration/guestperf-plot.py (100%)
>  rename {tests => scripts}/migration/guestperf.py (100%)
>  rename {tests => scripts}/migration/guestperf/__init__.py (100%)
>  rename {tests => scripts}/migration/guestperf/comparison.py (100%)
>  rename {tests => scripts}/migration/guestperf/engine.py (100%)
>  rename {tests => scripts}/migration/guestperf/hardware.py (100%)
>  rename {tests => scripts}/migration/guestperf/plot.py (100%)
>  rename {tests => scripts}/migration/guestperf/progress.py (100%)
>  rename {tests => scripts}/migration/guestperf/report.py (100%)
>  rename {tests => scripts}/migration/guestperf/scenario.py (100%)
>  rename {tests => scripts}/migration/guestperf/shell.py (100%)
>  rename {tests => scripts}/migration/guestperf/timings.py (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10af212632..dae1535dae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3449,6 +3449,11 @@ F: migration/dirtyrate.h
>  F: include/sysemu/dirtyrate.h
>  F: docs/devel/migration/dirty-limit.rst
>  
> +Migration performance test tool
> +M: Hyman Huang <yong.huang@smartx.com>
> +S: Maintained
> +F: scripts/migration/

This probably needs to be scripts/migration/guestperf* unless of course
you intend to maintain all scripts that show up under
scripts/migration/. We have analyze-migration.py and
vmstate-static-checker.py which are candidates to be put in that same
directory.

> +
>  Detached LUKS header
>  M: Hyman Huang <yong.huang@smartx.com>
>  S: Maintained
> diff --git a/tests/migration/guestperf-batch.py b/scripts/migration/guestperf-batch.py
> similarity index 100%
> rename from tests/migration/guestperf-batch.py
> rename to scripts/migration/guestperf-batch.py
> diff --git a/tests/migration/guestperf-plot.py b/scripts/migration/guestperf-plot.py
> similarity index 100%
> rename from tests/migration/guestperf-plot.py
> rename to scripts/migration/guestperf-plot.py
> diff --git a/tests/migration/guestperf.py b/scripts/migration/guestperf.py
> similarity index 100%
> rename from tests/migration/guestperf.py
> rename to scripts/migration/guestperf.py
> diff --git a/tests/migration/guestperf/__init__.py b/scripts/migration/guestperf/__init__.py
> similarity index 100%
> rename from tests/migration/guestperf/__init__.py
> rename to scripts/migration/guestperf/__init__.py
> diff --git a/tests/migration/guestperf/comparison.py b/scripts/migration/guestperf/comparison.py
> similarity index 100%
> rename from tests/migration/guestperf/comparison.py
> rename to scripts/migration/guestperf/comparison.py
> diff --git a/tests/migration/guestperf/engine.py b/scripts/migration/guestperf/engine.py
> similarity index 100%
> rename from tests/migration/guestperf/engine.py
> rename to scripts/migration/guestperf/engine.py
> diff --git a/tests/migration/guestperf/hardware.py b/scripts/migration/guestperf/hardware.py
> similarity index 100%
> rename from tests/migration/guestperf/hardware.py
> rename to scripts/migration/guestperf/hardware.py
> diff --git a/tests/migration/guestperf/plot.py b/scripts/migration/guestperf/plot.py
> similarity index 100%
> rename from tests/migration/guestperf/plot.py
> rename to scripts/migration/guestperf/plot.py
> diff --git a/tests/migration/guestperf/progress.py b/scripts/migration/guestperf/progress.py
> similarity index 100%
> rename from tests/migration/guestperf/progress.py
> rename to scripts/migration/guestperf/progress.py
> diff --git a/tests/migration/guestperf/report.py b/scripts/migration/guestperf/report.py
> similarity index 100%
> rename from tests/migration/guestperf/report.py
> rename to scripts/migration/guestperf/report.py
> diff --git a/tests/migration/guestperf/scenario.py b/scripts/migration/guestperf/scenario.py
> similarity index 100%
> rename from tests/migration/guestperf/scenario.py
> rename to scripts/migration/guestperf/scenario.py
> diff --git a/tests/migration/guestperf/shell.py b/scripts/migration/guestperf/shell.py
> similarity index 100%
> rename from tests/migration/guestperf/shell.py
> rename to scripts/migration/guestperf/shell.py
> diff --git a/tests/migration/guestperf/timings.py b/scripts/migration/guestperf/timings.py
> similarity index 100%
> rename from tests/migration/guestperf/timings.py
> rename to scripts/migration/guestperf/timings.py

