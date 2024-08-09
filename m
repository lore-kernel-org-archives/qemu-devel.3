Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37661C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 12:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scPDY-00030f-Td; Fri, 09 Aug 2024 08:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1scPDX-000302-6e
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:59:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1scPDV-0005Xe-3Y
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:59:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87CE921E5F;
 Fri,  9 Aug 2024 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723208375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Hjj5nSkbaBm6fAGNCv4sjrweL5iY6nY2i6ix5tWBUs=;
 b=jdqHuf/tBqH0/5UPbtAV20DqKnz4yosYhYS+73R9cst3y0J1pG9bMgMkHIEnFBj7A90lin
 JC3EBgyifIoGVHYRCf8auGZlGnfmq3kH7VEGEy+/GEHvocPWXAi71Ks52Wvc+EWk8PBqIU
 bP/tXFcXuAeTIrDVHfgrE8DN5zXYSn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723208375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Hjj5nSkbaBm6fAGNCv4sjrweL5iY6nY2i6ix5tWBUs=;
 b=4vMW260dZgrwzzHgVJ80Ofi07253mpRYzRIYYzz79rgIoQGUHiJbvPp01swnCNjjkE9AJx
 kEWRdxG7taLo3WCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jdqHuf/t";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4vMW260d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723208375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Hjj5nSkbaBm6fAGNCv4sjrweL5iY6nY2i6ix5tWBUs=;
 b=jdqHuf/tBqH0/5UPbtAV20DqKnz4yosYhYS+73R9cst3y0J1pG9bMgMkHIEnFBj7A90lin
 JC3EBgyifIoGVHYRCf8auGZlGnfmq3kH7VEGEy+/GEHvocPWXAi71Ks52Wvc+EWk8PBqIU
 bP/tXFcXuAeTIrDVHfgrE8DN5zXYSn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723208375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Hjj5nSkbaBm6fAGNCv4sjrweL5iY6nY2i6ix5tWBUs=;
 b=4vMW260dZgrwzzHgVJ80Ofi07253mpRYzRIYYzz79rgIoQGUHiJbvPp01swnCNjjkE9AJx
 kEWRdxG7taLo3WCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1331A1379A;
 Fri,  9 Aug 2024 12:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tGnKMrYStmavdwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Aug 2024 12:59:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH v1 2/5] tests/migration: Make initrd-stress.img built by
 default
In-Reply-To: <7134ee3f7632b0454ef287301bda6c4faeb1d473.1723189080.git.yong.huang@smartx.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
 <7134ee3f7632b0454ef287301bda6c4faeb1d473.1723189080.git.yong.huang@smartx.com>
Date: Fri, 09 Aug 2024 09:59:32 -0300
Message-ID: <87v809g8cr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.48 / 50.00]; BAYES_HAM(-1.97)[94.88%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 87CE921E5F
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
> The initrd-stress.img was compiled by specifying the
> target, to make it easier for developers to play the
> guestperf tool, make it built by default.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  tests/migration/meson.build | 5 +++--

This could have moved along with the rest of guestperf. There's already
a scripts/meson.build where these could go.

