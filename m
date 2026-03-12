Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2E5106703C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0hy5-0002i5-Aa; Thu, 12 Mar 2026 11:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0hy4-0002hk-DU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:28:56 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0hy1-0000IO-5q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:28:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AAA164D31E;
 Thu, 12 Mar 2026 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773329330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQhUOs0m8NTgoP31YsWyGLMEZCud/IhFe2PXD9beev0=;
 b=UBm5xTIPZpYRqNvcWOJBwY6/bb99cXNDB68t1Q0h2hwOiXGnHBrCjs+U+/jhETE55WGKLd
 PMyXFjCzwnzQWi2nBUFSrkwOq6NXwkG/NwvrPZ9NFsg80/YnR9QzdOZfvMDki+tbkxkLYO
 UnO3OO6mJ3bd/eCcAknbED8YRMrDvTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773329330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQhUOs0m8NTgoP31YsWyGLMEZCud/IhFe2PXD9beev0=;
 b=ewXfjjjXe1PkUuMmJcWjoPuUCSiVFIYc9INpftL2xS4j2B/s+9IRfuR/cCi0fl+VbmgIlP
 S0plRRPf2eYlxOBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773329330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQhUOs0m8NTgoP31YsWyGLMEZCud/IhFe2PXD9beev0=;
 b=UBm5xTIPZpYRqNvcWOJBwY6/bb99cXNDB68t1Q0h2hwOiXGnHBrCjs+U+/jhETE55WGKLd
 PMyXFjCzwnzQWi2nBUFSrkwOq6NXwkG/NwvrPZ9NFsg80/YnR9QzdOZfvMDki+tbkxkLYO
 UnO3OO6mJ3bd/eCcAknbED8YRMrDvTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773329330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQhUOs0m8NTgoP31YsWyGLMEZCud/IhFe2PXD9beev0=;
 b=ewXfjjjXe1PkUuMmJcWjoPuUCSiVFIYc9INpftL2xS4j2B/s+9IRfuR/cCi0fl+VbmgIlP
 S0plRRPf2eYlxOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3633840033;
 Thu, 12 Mar 2026 15:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nPBWO7HbsmkoNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Mar 2026 15:28:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 marcandre.lureau@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v2] ui/vdagent: add migration blocker when machine
 version < 10.1
In-Reply-To: <20260310142552.240877-1-f.ebner@proxmox.com>
References: <20260310142552.240877-1-f.ebner@proxmox.com>
Date: Thu, 12 Mar 2026 12:28:47 -0300
Message-ID: <87zf4dxe1c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,habkost.net,gmail.com,linaro.org,huawei.com,intel.com,redhat.com];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> In QEMU 10.1, commit 5d56bff11e ("ui/vdagent: add migration support")
> added migration support for the vdagent chardev and commit 42000e0013
> ("ui/vdagent: remove migration blocker") removed the migration
> blocker. No compat for older machine versions was added, so migration
> with pre-10.1 machine version, from a 10.1 binary to a pre-10.1 binary
> will result in a failure when loading the VM state in the target
> instance:
>
>> Unknown savevm section or instance 'vdagent' 0. Make sure that your
>> current VM setup matches your saved VM setup, including any
>> hotplugged devices
>
> Add a compat flag to block migration when the machine version is less
> than 10.1 to avoid this.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 42000e0013 ("ui/vdagent: remove migration blocker")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

