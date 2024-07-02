Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A585C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdhm-0005lF-5Q; Tue, 02 Jul 2024 09:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sOdhj-0005hU-UW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:37:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sOdhi-0006eI-6F
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:37:55 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:10:168:4:11])
 by smtp-out2.suse.de (Postfix) with ESMTP id A4F371FBA6;
 Tue,  2 Jul 2024 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719927471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ED0QvY8DZQQq1efLZpQ1exx1SnMfXMlFdf4du7/cM+o=;
 b=IhNDiDwSh5ZLkwiIBgbBWw8WV5SLE3AsxDxeZvVUvR5sVplLznyDxm/O5rFsSfjLTCQFVv
 teToSBVq0WB3l3ZW+mL48zu69olgRMPwt39wnb5v6jMleUdWsh2Pw9tI3KOA0QlC6B1BuG
 70tQRsD4g5372MK0RoAbnsmfn+1mT14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719927471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ED0QvY8DZQQq1efLZpQ1exx1SnMfXMlFdf4du7/cM+o=;
 b=X/KHS6wRYrfN1SHGyCCujM6o2eGFvIiLyoOIYkBXxUAaDHGKHVIEsTrQVTK7ZucLNgcscf
 wq6cunv2FS7WZgAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IhNDiDwS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="X/KHS6wR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719927471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ED0QvY8DZQQq1efLZpQ1exx1SnMfXMlFdf4du7/cM+o=;
 b=IhNDiDwSh5ZLkwiIBgbBWw8WV5SLE3AsxDxeZvVUvR5sVplLznyDxm/O5rFsSfjLTCQFVv
 teToSBVq0WB3l3ZW+mL48zu69olgRMPwt39wnb5v6jMleUdWsh2Pw9tI3KOA0QlC6B1BuG
 70tQRsD4g5372MK0RoAbnsmfn+1mT14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719927471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ED0QvY8DZQQq1efLZpQ1exx1SnMfXMlFdf4du7/cM+o=;
 b=X/KHS6wRYrfN1SHGyCCujM6o2eGFvIiLyoOIYkBXxUAaDHGKHVIEsTrQVTK7ZucLNgcscf
 wq6cunv2FS7WZgAA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 8F8CF4A054F; Tue,  2 Jul 2024 15:37:51 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
In-Reply-To: <f681575f-1dae-481e-8330-6fe2fc8d0f11@linaro.org> (Richard
 Henderson's message of "Mon, 1 Jul 2024 09:05:13 -0700")
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org>
 <mvm4j9gp0xd.fsf@suse.de>
 <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 <mvmv81un7m9.fsf@suse.de>
 <CANCZdfpW+G54v3oeKZ6QYuovOga93D5hou9Ajeo838Y9bDNsUA@mail.gmail.com>
 <mvmmsn6lawv.fsf@suse.de>
 <CAFEAcA-dbLncCmY8zyZAz8e+AWeoGC437B=nV3wPznER+RmhbA@mail.gmail.com>
 <mvmr0cdjjlh.fsf@suse.de>
 <f681575f-1dae-481e-8330-6fe2fc8d0f11@linaro.org>
X-Yow: I always have fun because I'm out of my mind!!!
Date: Tue, 02 Jul 2024 15:37:51 +0200
Message-ID: <mvm34orkj80.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [1.59 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 RDNS_NONE(1.00)[]; NEURAL_HAM_LONG(-1.00)[-0.996];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; ARC_NA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:10:168:4:11:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,opensuse.org:url]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: A4F371FBA6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
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

Please follow https://en.opensuse.org/openSUSE:RISC-V#QEMU_system_emulation
to start the JeOS-efi image.  When logged in:

# zypper rm qemu-linux-user-riscv
# zypper in qemu-linux-user

Then you can run qemu-riscv64 inside:

# qemu-riscv64 -d page hello.riscv64 
host mmap_min_addr=0x10000
Locating guest address space @ 0x3ee000
page layout changed following mmap
start            end              size             prot
0000000000010000-0000000000013000 0000000000003000 ---
page layout changed following mmap
start            end              size             prot
0000000000010000-0000000000011000 0000000000001000 r-x
0000000000011000-0000000000013000 0000000000002000 ---
page layout changed following mmap
start            end              size             prot
0000000000010000-0000000000011000 0000000000001000 r-x
0000000000011000-0000000000013000 0000000000002000 rw-
mmap stack: Cannot allocate memory

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

