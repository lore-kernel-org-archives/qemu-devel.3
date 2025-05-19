Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D5AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH22E-0007aP-7i; Mon, 19 May 2025 11:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uH228-0007a6-Ff
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:04:07 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uH226-0002Jr-QY
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:04:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A87720409;
 Mon, 19 May 2025 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747667039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f5FsYGS7PxyUSiF5tM1P5NsRSyme9AjCsJ4ZYRNeSmo=;
 b=cnLx2SBFOyugcLkmYBqTjKOZ0g+keFVps7FevEotUrzCib7TqCU5dUOAn7rcLupc7HBEtq
 2cnbfZNUVLoXlIcoxgHA8FM7fDI25zhLyshsrL93h2mPnZc6oYxFIEEdKfz3+vcWkzI/Ll
 X4B0NAsZC+/8U4CeKZEiywC7oymTFFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747667039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f5FsYGS7PxyUSiF5tM1P5NsRSyme9AjCsJ4ZYRNeSmo=;
 b=aFTQUjcuAFhV7/FcxmdlUwSQDQjThpZBinafjm6GOe6baLwvneNwkew1LC+9WOIZ5KPI/g
 JeVOMiB/QGgvbSAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747667039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f5FsYGS7PxyUSiF5tM1P5NsRSyme9AjCsJ4ZYRNeSmo=;
 b=cnLx2SBFOyugcLkmYBqTjKOZ0g+keFVps7FevEotUrzCib7TqCU5dUOAn7rcLupc7HBEtq
 2cnbfZNUVLoXlIcoxgHA8FM7fDI25zhLyshsrL93h2mPnZc6oYxFIEEdKfz3+vcWkzI/Ll
 X4B0NAsZC+/8U4CeKZEiywC7oymTFFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747667039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f5FsYGS7PxyUSiF5tM1P5NsRSyme9AjCsJ4ZYRNeSmo=;
 b=aFTQUjcuAFhV7/FcxmdlUwSQDQjThpZBinafjm6GOe6baLwvneNwkew1LC+9WOIZ5KPI/g
 JeVOMiB/QGgvbSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 600AC1372E;
 Mon, 19 May 2025 15:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WiLIB15IK2g3QgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 19 May 2025 15:03:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Bernhard Beschow <shentey@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 21/22] tests/qtest/xhci: Test USB Mass Storage
 relaxed CSW order
In-Reply-To: <20250502033047.102465-22-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-22-npiggin@gmail.com>
Date: Mon, 19 May 2025 12:03:55 -0300
Message-ID: <87ldqs7ick.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.77 / 50.00]; BAYES_HAM(-2.97)[99.87%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,redhat.com,philjordan.eu,linaro.org];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

Nicholas Piggin <npiggin@gmail.com> writes:

> This adds a qtest for the improvement to the MSD protocol that
> allows an IN packet before the CBW packet. Send a CSW packet
> before a zero-length CBW command packet is sent. This test would
> fail with the MSD change reverted.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

#define CBW_SIGNATURE       0x43425355
#define CSW_SIGNATURE       0x53425355

would be nice

Reviewed-by: Fabiano Rosas <farosas@suse.de>
#define CBW_SIGNATURE       0x43425355
#define CSW_SIGNATURE       0x53425355

would be nice

Reviewed-by: Fabiano Rosas <farosas@suse.de>

