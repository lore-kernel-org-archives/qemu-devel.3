Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F26C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLON-0002hq-4s; Tue, 18 Feb 2025 06:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1tkLOL-0002hZ-5Z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:03:53 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1tkLOJ-0003lr-DV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:03:52 -0500
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 250841F442;
 Tue, 18 Feb 2025 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739876628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4btNqxjjDW7EHNzEmxZv3mtJn1qXA8kTvwH6bAOmO0k=;
 b=05mCUq5x3xbSuI0USvILXQ98PqRyL6JeenRla9LGZdYq8jD5pc3jlLAJkYbU0pLhLyt2Yb
 yye5GmiIGJPTfikRG3/8D5zOIW38Ap/4JpTZensfvLiI/TnHTlH911KX36k8Vbzn2Qq3Nv
 EKgJ9em0WSVIv4y8LCZZyC4eTeoJFPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739876628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4btNqxjjDW7EHNzEmxZv3mtJn1qXA8kTvwH6bAOmO0k=;
 b=mNbg33LiIQFTe2QpSZCTrm84RUcjF8nVD3boiKMt2Czyz35PdPyvZ6iQe6M8KPoLZUtuJu
 yaiJiJyTxT50DSAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739876627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4btNqxjjDW7EHNzEmxZv3mtJn1qXA8kTvwH6bAOmO0k=;
 b=jJ9MrppZdgjeLHq6mYDscNVDmrhboDjBcP4/J1oNUlV2nUqn3gdAOjUiXvgh8Kq45tc7F8
 4eWIgKwPcWl8+aRChCw3tOpyA4htqPAqjdef5/6YzQ2BKcWlPDWZ5JdQJhh1wzG4kvifs9
 0oyR/WwNfwXRkBe4gwaZWsWzClKgBGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739876627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4btNqxjjDW7EHNzEmxZv3mtJn1qXA8kTvwH6bAOmO0k=;
 b=DdMZZIAR3rkvyBHHtwPE5cFp3QedjGEdl8nuuh5xQNc7NTBsPI2A0GjS5FaKNNNIvm2nd9
 d8lE0/47OK/S/aBg==
Date: Tue, 18 Feb 2025 12:03:46 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: ROM files and non-x86
Message-ID: <Z7RpEvbg7ecBN1vf@kitsune.suse.cz>
References: <a430de0f-1c27-4c52-97d4-b881efa47131@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a430de0f-1c27-4c52-97d4-b881efa47131@tls.msk.ru>
X-Spamd-Result: default: False [-3.74 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-0.999]; R_MIXED_CHARSET(0.56)[subject];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_ZERO(0.00)[0];
 MIME_TRACE(0.00)[0:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=msuchanek@suse.de; helo=smtp-out2.suse.de
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

Hello,

this came up because these rom files are somewhat difficult to build on
non-x86, and distributions that have problem with distributing blobs
verbatim may be missing them.

On Tue, Feb 18, 2025 at 01:38:42PM +0300, Michael Tokarev wrote:
> Hi!
> 
> Qemu system-mode emulation, when used with a NIC, loads a ROM file
> for network booting (and fails to start if such file is not provided).
> ROMs shipped in the source tarball are x86-only, so such loading does
> nothing on non-x86, where we just wasting guest memory, - since the
> ROM code can not be executed on the target architecture anyway.
> 
> These days, ipxe provides (UEFI) ROM files for architectures other than
> x86.  And these ROMs actually works, making it possible to network-boot
> qemu guests in UEFI mode.
> 
> Would it be possible to make ROMs target-arch-specific, and drop the
> ROM dependency/loading on non-x86 if there's no arch-specific ROM found?
> This probably requires machine version dependency, to make the machine
> migratable.  Currently, romfile is a static property of a device,
> independent of the architecture.

And for emulation of a specific device (eg. e1000) it makes sense that
it comes with a ROM, even if the architecture does not make use of it.
That's how the hardware looks. And while it may be unusual the ROM can
be empty, eg. because somebody used a tool to erase it. That is using an
empty ROM as a fallback is something that is reasonable emulation of the
hardware in question, or no ROM at all for devices like virtio.

> A similar question exists about seabios and vgabios - for example,
> virtio-vga device always tries to load vgabios.rom on all architectures,
> while on non-x86 it is useless.

In this case it is more dodgy. I vaguely recall some code for
interpreting these BIOSes somewhere. That is the x86 BIOS can run in
some emulation to provide the BIOS functionality on non-x86. Not sure
how much it's actually used in practice for the kinds of cards that qemu
emulates.

Thanks

Michal

