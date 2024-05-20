Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE18C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 22:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9BUn-00045O-5H; Mon, 20 May 2024 18:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9BUl-000457-Ff
 for qemu-devel@nongnu.org; Mon, 20 May 2024 18:28:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9BUj-0006Xv-Vm
 for qemu-devel@nongnu.org; Mon, 20 May 2024 18:28:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3366422620;
 Mon, 20 May 2024 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716244116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLOroT7+uZu0zB6A/1yXVvdNo3nLdCUWDjkkOi46l5Q=;
 b=2WlE4ZPsA0Eh5dz+lsaswVGLiNg+O+cEqznfXvU+zqz5as98YYzS/AjYm2h3jGBo6oJsfc
 6yUp4VR07DkiKv1ayybyzByYkCRLncAxfkiwChk68a4o8gN/zhfoATFzgA1bFL2bQuQQpv
 fmlcHgEqI+VKd2gUPVQ1Gf6ZIRzD+TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716244116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLOroT7+uZu0zB6A/1yXVvdNo3nLdCUWDjkkOi46l5Q=;
 b=g8bM3P72rup8fp/b63MYyb2k4JE2abBCyyRi2mKoUTwOHWK89alBSvnRSY/1wP5+gSe3UF
 xr+3ybsQ0OO6JaAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2WlE4ZPs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g8bM3P72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716244116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLOroT7+uZu0zB6A/1yXVvdNo3nLdCUWDjkkOi46l5Q=;
 b=2WlE4ZPsA0Eh5dz+lsaswVGLiNg+O+cEqznfXvU+zqz5as98YYzS/AjYm2h3jGBo6oJsfc
 6yUp4VR07DkiKv1ayybyzByYkCRLncAxfkiwChk68a4o8gN/zhfoATFzgA1bFL2bQuQQpv
 fmlcHgEqI+VKd2gUPVQ1Gf6ZIRzD+TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716244116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLOroT7+uZu0zB6A/1yXVvdNo3nLdCUWDjkkOi46l5Q=;
 b=g8bM3P72rup8fp/b63MYyb2k4JE2abBCyyRi2mKoUTwOHWK89alBSvnRSY/1wP5+gSe3UF
 xr+3ybsQ0OO6JaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A365313A21;
 Mon, 20 May 2024 22:28:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MN0eGZPOS2ZpJQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 20 May 2024 22:28:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org, Peter
 Xu <peterx@redhat.com>
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
In-Reply-To: <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com>
Date: Mon, 20 May 2024 19:28:32 -0300
Message-ID: <87ed9wjey7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3366422620
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.18 / 50.00]; BAYES_HAM(-2.67)[98.55%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Steven Sistare <steven.sistare@oracle.com> writes:

> Hi Peter, Hi Fabiano,
>    Will you have time to review the migration guts of this series any time soon?
> In particular:
>
> [PATCH V1 05/26] migration: precreate vmstate
> [PATCH V1 06/26] migration: precreate vmstate for exec
> [PATCH V1 12/26] migration: vmstate factory object
> [PATCH V1 18/26] migration: cpr-exec-args parameter
> [PATCH V1 20/26] migration: cpr-exec mode
>

I'll get to them this week. I'm trying to make some progress with my own
code before I forget how to program. I'm also trying to find some time
to implement the device options in the migration tests so we can stop
these virtio-* breakages that have been popping up.

