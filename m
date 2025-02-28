Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D377FC282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 15:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to23x-0003P5-PM; Fri, 28 Feb 2025 10:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to23v-0003OR-2T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:14:03 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to23s-0000FV-SV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:14:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECF001F38F;
 Fri, 28 Feb 2025 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740755637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HXU3hMfH2Ul03gdCrmqXwOT0PnwWLpuTw7hnp0fjYM=;
 b=MJz9usGimM2r7jgrptUQhT/FglyTk2n0DLJDmRxpnqH5FxYNtl/kA5wjWTz4CRaoILH96Q
 ao0QUc1WFDgFnjdIf1hLmkQQ+KF2+lj7+yZndg0iW1CokOrl2HEePEpSNNJJLEI+zKXRyX
 gBsFfUmIFoOfntvyM9hdLJfJi4LQqeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740755637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HXU3hMfH2Ul03gdCrmqXwOT0PnwWLpuTw7hnp0fjYM=;
 b=zJzm/XXkRqTqScKnUnPzWW6hAdop5thHkugrTKFW2TneAMXArslgA2Hq9kgv0PHe4RGL1g
 /PwAIx2FulOPwYAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CMlmvWBG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pwd2mn4l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740755636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HXU3hMfH2Ul03gdCrmqXwOT0PnwWLpuTw7hnp0fjYM=;
 b=CMlmvWBG9FqEIATKByJgzFVlnSa+pHdRr8uczjgShb9gC+KjJj+EvOxEoy97zryTqBMGbA
 iTu2scd/ca04liDoZOam25PZyAW5xY5xsMyTRgeJ78DWWFynpWgHN3Pv1+PXwNbyjrJYUE
 9fFuGiSOfM1nSu33gYgCTIrB8EGfbtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740755636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HXU3hMfH2Ul03gdCrmqXwOT0PnwWLpuTw7hnp0fjYM=;
 b=pwd2mn4lK2Az9rAfWR2FV2vSDij6tZG2YdUxGXM97vNKpMKj5LuU1Xy8CvBODTqNKkY2W+
 ZNBvwteDGOVVftBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65D971344A;
 Fri, 28 Feb 2025 15:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ADgGCbTSwWcBRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Feb 2025 15:13:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Keoseong Park <keosung.park@samsung.com>, Jeuk Kim
 <jeuk20.kim@samsung.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Keoseong Park <keosung.park@samsung.com>, Jinyoung
 Choi <j-young.choi@samsung.com>
Subject: Re: [PATCH 2/2] tests/qtest/ufs-test: Add test code for the
 temperature feature
In-Reply-To: <20250225064243epcms2p8b7b59e7bf381bd68d30a6f59b40dea9f@epcms2p8>
References: <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
 <CGME20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
 <20250225064243epcms2p8b7b59e7bf381bd68d30a6f59b40dea9f@epcms2p8>
Date: Fri, 28 Feb 2025 12:13:53 -0300
Message-ID: <87a5a62jbi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: ECF001F38F
X-Spamd-Result: default: False [-4.46 / 50.00]; BAYES_HAM(-2.95)[99.76%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_EQ_ADDR_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Keoseong Park <keosung.park@samsung.com> writes:

> This commit adds tests to verify the correctness of query attribute
> results related to the temperature feature. It ensures that querying
> temperature attributes returns expected values.
>
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>

Acked-by: Fabiano Rosas <farosas@suse.de>

