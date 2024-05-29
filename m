Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60678C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJKN-00070F-P2; Wed, 29 May 2024 09:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sCJKK-0006zb-Bb; Wed, 29 May 2024 09:26:48 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sCJKI-0006N4-Bc; Wed, 29 May 2024 09:26:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 336CE2055B;
 Wed, 29 May 2024 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716989204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cl7vjtl2FXTcp8RdIfAmnp+QBj5owrSuQji8jQz2Wn4=;
 b=qsHYgikzManVpcgDV/O4L2rN+KceZKRccfPDlnCq5/HMxXj4LeMCWrKWsrqqtfhni77IgE
 OUfR4XRNaMaQARpMtleZhb7oy4TiBoGnDwVIVK3xFrtaELsro804w9yqQqtDsM9xBgD2pX
 2aAzskiTNSvZ3iu/J1w/SKaQr/WW2+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716989204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cl7vjtl2FXTcp8RdIfAmnp+QBj5owrSuQji8jQz2Wn4=;
 b=EZMTMoNWWdK8d6wAydaydsJPe1q6rAT5CiglBtZy6/s8HB3oRInRJ45uHUln/eHbCbNo72
 na3Nxe77F80oQ6Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716989203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cl7vjtl2FXTcp8RdIfAmnp+QBj5owrSuQji8jQz2Wn4=;
 b=jWJKnJS8vfppcA4N6CpVskKXkFOuC5xuAfClKIOR/9UQJ3OrKd6WNcmGfifpl+Ug3vxOLf
 Sxbfn86ssuotAeZ2u8Sb5+jXdtU3YKBm5j0/KbTZBGhavruvnfQOlqxPnBROQVzfCrGhHg
 OE+7gHhVmUD0c/Kb/dMI2YWPNc8kTBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716989203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cl7vjtl2FXTcp8RdIfAmnp+QBj5owrSuQji8jQz2Wn4=;
 b=oLS1sziemEFzn5gZCM7aWcgdVAmu9rIcP8Inj3e1URxSwet3e36K73GtK04/Ji4FKen1ET
 WvLWn4Uk0FWTJACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B194813A6B;
 Wed, 29 May 2024 13:26:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hXLxHRItV2ZhSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 May 2024 13:26:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PULL 6/9] virtio-gpu: fix v2 migration
In-Reply-To: <94b38346-7ad7-4fa4-b7e8-3ba00cc72f16@proxmox.com>
References: <20240522222034.4001-1-farosas@suse.de>
 <20240522222034.4001-7-farosas@suse.de>
 <94b38346-7ad7-4fa4-b7e8-3ba00cc72f16@proxmox.com>
Date: Wed, 29 May 2024 10:26:40 -0300
Message-ID: <8734q0g35b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.47 / 50.00]; BAYES_HAM(-1.17)[88.88%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, proxmox.com:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> CC-ing stable, because this already is an issue in 9.0.0
>

Thank you for pointing this out. I was expecting b4 to find the tag, but
I just now noticed that the CC was added by Peter as a reply to the
message and not originally via the patch headers, so I should have added
it manually.


