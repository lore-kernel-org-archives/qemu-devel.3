Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D121EC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 20:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Wkg-000070-Uk; Fri, 10 May 2024 16:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s5Wkd-0008LC-Ho
 for qemu-devel@nongnu.org; Fri, 10 May 2024 16:21:55 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s5Wkb-0003s9-WA
 for qemu-devel@nongnu.org; Fri, 10 May 2024 16:21:55 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88D891FB84;
 Fri, 10 May 2024 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715372511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GGdu5vcOXIIzT0LvxXwfXUyK7Xjk/slraiOwm4UWY04=;
 b=n0V50dngZZXM0DSrsFfq4RcmCJwzXmSIEt2j3m9PmX4MMbXh2yA3pL04A0cfgfTf/5O4tb
 gHFHU5JI0zlJPhRv+pB28/dIjGT6uYsS6uLP3RDWUU8tXRSE2kY7MwZPfLvDzScLCwMX/h
 Gs6XTKaSfcHjOAlMRlEWPhyqfaVbJmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715372511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GGdu5vcOXIIzT0LvxXwfXUyK7Xjk/slraiOwm4UWY04=;
 b=iAQnjLAg9wR1ZYZNbqC5ueCcmQyZM+QyK1clno9JIHnweiosZQL/NcPw+FkfKmWD61q6IM
 5DUCjaIZGC1DB3AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n0V50dng;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iAQnjLAg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715372511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GGdu5vcOXIIzT0LvxXwfXUyK7Xjk/slraiOwm4UWY04=;
 b=n0V50dngZZXM0DSrsFfq4RcmCJwzXmSIEt2j3m9PmX4MMbXh2yA3pL04A0cfgfTf/5O4tb
 gHFHU5JI0zlJPhRv+pB28/dIjGT6uYsS6uLP3RDWUU8tXRSE2kY7MwZPfLvDzScLCwMX/h
 Gs6XTKaSfcHjOAlMRlEWPhyqfaVbJmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715372511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GGdu5vcOXIIzT0LvxXwfXUyK7Xjk/slraiOwm4UWY04=;
 b=iAQnjLAg9wR1ZYZNbqC5ueCcmQyZM+QyK1clno9JIHnweiosZQL/NcPw+FkfKmWD61q6IM
 5DUCjaIZGC1DB3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 085581386E;
 Fri, 10 May 2024 20:21:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IMHBL96BPmZJAQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 May 2024 20:21:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v6 2/7] migration/multifd: put IOV initialization into
 compression method
In-Reply-To: <20240505165751.2392198-3-yuan1.liu@intel.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-3-yuan1.liu@intel.com>
Date: Fri, 10 May 2024 17:21:48 -0300
Message-ID: <87plttfmeb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.76 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; BAYES_HAM(-1.25)[89.65%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,intel.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 88D891FB84
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Yuan Liu <yuan1.liu@intel.com> writes:

> Different compression methods may require different numbers of IOVs.
> Based on streaming compression of zlib and zstd, all pages will be
> compressed to a data block, so two IOVs are needed for packet header
> and compressed data block.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

