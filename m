Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11C8C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVzDj-0003jg-S5; Fri, 02 Feb 2024 14:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVzDf-0003j8-Ui
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:28:59 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVzDe-00088N-Hd
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:28:59 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D541F21FB2;
 Fri,  2 Feb 2024 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706902136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/xXYPLAMntOilzEyO2j3FmVm0bxyZCZp2FbD6JtPSuA=;
 b=QARRSCagc6wgD0dNgsDESOuN56G6qdIBfCa3MO1EE82j/tjmu6+/h93eSx81dpj5KTCYnY
 1S5iF7vHNvtY/Kyvyv/zDPx2wo6FFDzYOnfWPGqz3TA7ju1t53ZSMUiu9w4hI7k7mnUlIb
 JG1b8jYbfhJvmPAA8udZbWLZe9Ttd+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706902136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/xXYPLAMntOilzEyO2j3FmVm0bxyZCZp2FbD6JtPSuA=;
 b=gXlBJO5EkmHnP1glDxGEo/FROsKGhv+8QRCsEooqZm+qZwJ2d71zqme2c1KCVzVsVuUo5+
 n+uuk2gcMy/c8gDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706902136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/xXYPLAMntOilzEyO2j3FmVm0bxyZCZp2FbD6JtPSuA=;
 b=QARRSCagc6wgD0dNgsDESOuN56G6qdIBfCa3MO1EE82j/tjmu6+/h93eSx81dpj5KTCYnY
 1S5iF7vHNvtY/Kyvyv/zDPx2wo6FFDzYOnfWPGqz3TA7ju1t53ZSMUiu9w4hI7k7mnUlIb
 JG1b8jYbfhJvmPAA8udZbWLZe9Ttd+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706902136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/xXYPLAMntOilzEyO2j3FmVm0bxyZCZp2FbD6JtPSuA=;
 b=gXlBJO5EkmHnP1glDxGEo/FROsKGhv+8QRCsEooqZm+qZwJ2d71zqme2c1KCVzVsVuUo5+
 n+uuk2gcMy/c8gDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 603A3139AB;
 Fri,  2 Feb 2024 19:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZEcuCnhCvWUvaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 19:28:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH v2 15/23] migration/multifd: Split
 multifd_send_terminate_threads()
In-Reply-To: <20240202102857.110210-16-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-16-peterx@redhat.com>
Date: Fri, 02 Feb 2024 16:28:53 -0300
Message-ID: <87le82hdhm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[33.99%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
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
> Split multifd_send_terminate_threads() into two functions:
>
>   - multifd_send_set_error(): used when an error happened on the sender
>     side, set error and quit state only
>
>   - multifd_send_terminate_threads(): used only by the main thread to kick
>     all multifd send threads out of sleep, for the last recycling.
>
> Use multifd_send_set_error() in the three old call sites where only the
> error will be set.
>
> Use multifd_send_terminate_threads() in the last one where the main thread
> will kick the multifd threads at last in multifd_save_cleanup().
>
> Both helpers will need to set quitting=1.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

