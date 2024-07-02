Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD849C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOefR-0002Xo-Kd; Tue, 02 Jul 2024 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sOefQ-0002XT-CI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:39:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sOefO-0001p4-Lg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:39:36 -0400
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5FD0C2192D;
 Tue,  2 Jul 2024 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719931170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hw6KPjxSNwihZ2+cZgt6VpL7W2FBubD6ArgfOA4lcGg=;
 b=cHGgD3u9jR5tNWon3IeKklTKbskjYDK9hmI+GAZ+jgXkoume+Q5AOBhyHwxN9Lm6O4mket
 HGvvXKNcMs+5yrUjkPz3FiSB9+NlsWqu2/nUedKa9NzcS6ak7l94Sdvkf9m/gGWge52gmD
 FIMznXInsijiJUSIse+XpRs2HMzt+BE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719931170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hw6KPjxSNwihZ2+cZgt6VpL7W2FBubD6ArgfOA4lcGg=;
 b=NhyfQz9hwCEzn4fp76CVFkXY7IwuN9ojjKEo/3GAuTsHI4Izkh5aD10HD1PWhqvTbIXOjU
 szEkwbErqacTCACA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719931169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hw6KPjxSNwihZ2+cZgt6VpL7W2FBubD6ArgfOA4lcGg=;
 b=mabNIkChy35gQ6s3Y8f7jJ5uaehWueLg8n9iRBJdzxit0dCTYeZpnbIw/snNv62jni9JVg
 UxMD+JPMuy8cTbmKGVBe5ZnedqOkeWIMU36EWPhCXqI6UIel27evCgumztaBt2PsEPsaSY
 T6V1sMj5RCcDutOiFbf/RKwXteLkTvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719931169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hw6KPjxSNwihZ2+cZgt6VpL7W2FBubD6ArgfOA4lcGg=;
 b=AQafLEFZjqZC9CiRfU4kuybedq9gkAJtyTc/nDZWI7/oCzGbbVZ5VlSZfjfq0Bp3sYFqGh
 jiqTDkY0TDnmp3DA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 50D264A054F; Tue,  2 Jul 2024 16:39:29 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
In-Reply-To: <fbe9c88e-677a-4248-9901-76c56e52283b@linaro.org> (Richard
 Henderson's message of "Tue, 2 Jul 2024 07:18:46 -0700")
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
 <mvm7ce4jjvf.fsf@suse.de>
 <fbe9c88e-677a-4248-9901-76c56e52283b@linaro.org>
X-Yow: Everywhere I look I see NEGATIVITY and ASPHALT...
Date: Tue, 02 Jul 2024 16:39:29 +0200
Message-ID: <mvmtth7j1su.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:email,hawking.nue2.suse.org:helo];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,hawking.nue2.suse.org:helo]
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

On Jul 02 2024, Richard Henderson wrote:

> Is /proc mounted in your environment?

Sure, it's a fully running system on real hardware.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

