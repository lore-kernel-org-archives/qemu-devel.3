Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B29E64A8C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tISmI-00081t-Si; Tue, 03 Dec 2024 08:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tISmH-0007yn-7D
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:17:21 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tISmF-0006mi-Pa
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:17:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 592241F453;
 Tue,  3 Dec 2024 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733231838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WENcjt6WmM7UGCRxsQRA7RA1py1RCsEuGkd/7p7RMto=;
 b=GJsHHqeOTyQpss/aozxqqMC2bnsaFb89B3GlkMnkiWCDVFrgp+jdr5y1eWK8BU1irWpzZx
 uHPWgAIIveFYEAVir+Yqobtppv/l4tplJbZmcCD+6U0h7dbdgfSyI69BJDy4NmjVNR8/Ic
 j8lw6hw1VVEZbNSyCE8Sb4XR5cuKNAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733231838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WENcjt6WmM7UGCRxsQRA7RA1py1RCsEuGkd/7p7RMto=;
 b=jdsR1kYbUVn+TkK7mKJEeWJozgtHVPunvQ/CSf7H/kMTGkdlDGiMZZtqLtWnftTSbgDOJa
 49P/QnewM/7qsaAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733231837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WENcjt6WmM7UGCRxsQRA7RA1py1RCsEuGkd/7p7RMto=;
 b=NQjRK8bwtthVPPhvz3fs3QQ/ybefI4Vh1WXWO46scu9l3mTUtf/jzcCrERGIRcoIeItoi6
 7X+iGf3vlf3me8knAbTT5wcZOS7Ju4NzP8+cQZHNe71aQioev9sefmLVdG9uGhSnMF09tF
 KfV18lDq89oHRsCwiM7rCewz04qNq3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733231837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WENcjt6WmM7UGCRxsQRA7RA1py1RCsEuGkd/7p7RMto=;
 b=GGcrLXOTK3UGn0yVcFFf5OCDn6ZkMvSyfvX0NIo/WLNMz48SO8SX2XffpXEzv3IPqOUAK3
 v9utkwadY74NCvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D682D139C2;
 Tue,  3 Dec 2024 13:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J/9BJtwET2eSHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Dec 2024 13:17:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, peterx@redhat.com
Cc: linuxarm@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH] migration/multifd: Fix compile error caused by
 page_size usage
In-Reply-To: <20241203124943.52572-1-shameerali.kolothum.thodi@huawei.com>
References: <20241203124943.52572-1-shameerali.kolothum.thodi@huawei.com>
Date: Tue, 03 Dec 2024 10:17:14 -0300
Message-ID: <87zflcj485.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.97 / 50.00]; BAYES_HAM(-2.67)[98.53%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,huawei.com:email,imap1.dmz-prg2.suse.org:helo,nongnu.org:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Shameer Kolothum via <qemu-devel@nongnu.org> writes:

> From Commit 90fa121c6c07 ("migration/multifd: Inline page_size and
> page_count") onwards page_size is not part of MutiFD*Params but uses
> an inline constant instead.
>
> However, it missed updating an old usage, causing a compile error.
>
> Fixes: 90fa121c6c07 ("migration/multifd: Inline page_size and page_count")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

