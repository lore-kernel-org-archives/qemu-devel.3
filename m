Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506CBC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 21:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVI62-0004lq-2L; Wed, 31 Jan 2024 16:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVI5w-0004jA-5x
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 16:26:11 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVI5u-000337-Jj
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 16:26:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 434A521FF4;
 Wed, 31 Jan 2024 21:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706736363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=raCxn7M1JwJSlmWVm3wCtnBHXD8rf3rGK7pdpuZWE8Y=;
 b=ePhn+jJmjd3H/7wtuzQTdke+27aDjgVhtfX0rbQHnQ2HACHxNrSRPL3Z0bQSgGrFtNp8XA
 l+EDPIEMQtORByNltCEF7tKySmkbPHbS8B8UE7ri5HuW5vcqzlg+gEsFV8DZNfW1oOMuYh
 AwyykoAYT6dJ4x3RS1ry11WBol40abM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706736363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=raCxn7M1JwJSlmWVm3wCtnBHXD8rf3rGK7pdpuZWE8Y=;
 b=uXJmzy2dmnhFf/YyUV/tuk0lSsWK1Qa6hzVTI6gKld34C/g3kBJn/NaPAtKICNMCQEFRCh
 WyhtMkQjmpLCn/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706736363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=raCxn7M1JwJSlmWVm3wCtnBHXD8rf3rGK7pdpuZWE8Y=;
 b=ePhn+jJmjd3H/7wtuzQTdke+27aDjgVhtfX0rbQHnQ2HACHxNrSRPL3Z0bQSgGrFtNp8XA
 l+EDPIEMQtORByNltCEF7tKySmkbPHbS8B8UE7ri5HuW5vcqzlg+gEsFV8DZNfW1oOMuYh
 AwyykoAYT6dJ4x3RS1ry11WBol40abM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706736363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=raCxn7M1JwJSlmWVm3wCtnBHXD8rf3rGK7pdpuZWE8Y=;
 b=uXJmzy2dmnhFf/YyUV/tuk0lSsWK1Qa6hzVTI6gKld34C/g3kBJn/NaPAtKICNMCQEFRCh
 WyhtMkQjmpLCn/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E9C1347F;
 Wed, 31 Jan 2024 21:26:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lx76Ieq6umXTbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 21:26:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>, Prasad Pandit
 <ppandit@redhat.com>, peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 10/14] migration/multifd: Move total_normal_pages
 accounting
In-Reply-To: <20240131103111.306523-11-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-11-peterx@redhat.com>
Date: Wed, 31 Jan 2024 18:26:00 -0300
Message-ID: <87frydjitz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.19)[89.07%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Just like the previous patch, move the accounting for total_normal_pages on
> both src/dst sides into the packet fill/unfill procedures.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

