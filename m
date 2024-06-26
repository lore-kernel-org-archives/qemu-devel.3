Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C1AC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 08:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMNwS-00058k-RP; Wed, 26 Jun 2024 04:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sMNwR-00058Z-I1
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:23:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sMNwP-00069o-Qv
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:23:47 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:10:168:4:11])
 by smtp-out1.suse.de (Postfix) with ESMTP id EEA0321A42;
 Wed, 26 Jun 2024 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719390223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gn8tI82BQm0FF9gt7xmG0UIgmsVsEWtVGNeSWmc1Q3k=;
 b=bzvyNJJViUPscQcQAH0NT8jfREVaGm44JhOy0r0/0aB0NBzRzJFRrFPRz2Ha54kwnw4C2j
 vaeyFPsGjRTbPoKR2WnBqO1Y1twAadR4Kv1aWW1Qw8DkaOorbR3XXrUqmwwSl07fKCfZQt
 X2pEbG5iEeDRY1S3JbWcxO5o/Fn2rdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719390223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gn8tI82BQm0FF9gt7xmG0UIgmsVsEWtVGNeSWmc1Q3k=;
 b=6N5cWksDEeFVAqcXXz9K7rMYEzpkN7CTAv1b7m4tlHHsFPrSpXJr8u/BoPiHIaClLLk+7B
 YOh/EIJ7fChvqgCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VioOpHv7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AwQrjAVr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719390222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gn8tI82BQm0FF9gt7xmG0UIgmsVsEWtVGNeSWmc1Q3k=;
 b=VioOpHv7qBEodDFug4Qov9aPM6ednnfB86JC28SZyx4GEr4MkZdqbNv4566GOeyKnFxyPS
 umYlPlhyvzzCGvGVE4+8hi5L2WcyTp412/RvGOUEtKEFLFPpxWPy5//oHgP3xuVi2vuqg7
 kGgkRiFlXN3eUguLkyrKPW6vDY+j9OY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719390222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gn8tI82BQm0FF9gt7xmG0UIgmsVsEWtVGNeSWmc1Q3k=;
 b=AwQrjAVrSjXpniqAgmTSDo8yDs26xEg+GOGwe/XVoq9OzhPR9J0X14e+PBG2MPcW+f6yVZ
 sAPa09eqzBdWR4Cg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 79DCC4A050D; Wed, 26 Jun 2024 10:23:42 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
In-Reply-To: <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org> (Richard
 Henderson's message of "Tue, 25 Jun 2024 08:47:32 -0700")
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org>
X-Yow: Everybody gets free BORSCHT!
Date: Wed, 26 Jun 2024 10:23:42 +0200
Message-ID: <mvm4j9gp0xd.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [3.50 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
 NEURAL_SPAM_SHORT(1.70)[0.568]; ONCE_RECEIVED(1.20)[];
 RDNS_NONE(1.00)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-0.999];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:10:168:4:11:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_ONE(0.00)[1];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spamd-Bar: +++
X-Rspamd-Queue-Id: EEA0321A42
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=schwab@suse.de; helo=smtp-out1.suse.de
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

On Jun 25 2024, Richard Henderson wrote:

> can always force the use of a non-zero base with -B or -R.

$ qemu-riscv64 -d page -B 0x3ee000 hello.riscv64
host mmap_min_addr=0x1000 (fallback)
qemu-riscv64: /daten/src/test/hello.riscv64: requires virtual address space that is in use (omit the -B option or choose a different value)

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

