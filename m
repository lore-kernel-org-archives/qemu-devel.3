Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390FCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fr6-0005h4-CF; Tue, 14 Oct 2025 10:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v8fqy-0005gh-DJ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:18:16 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v8fqn-00066z-GY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:18:15 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 709411FB6E;
 Tue, 14 Oct 2025 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760451475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6il3MiOfVqH5ZqSybd4flZzVhhfDytNW2X0vcpY3d9w=;
 b=qCqJ5igvcZLYXuMoMe/8AytzPMr8fonWazt7cKh9rpkFrjL9j1mW1LZRLLSSuIolRnii1F
 N+s2vCHVKHbj5dgUROPuX9UND6ZnMem/agn9OfgZfkUZREVxNeAtpRWx5/yDAgp2eabECA
 TAweYissk+8u9MgH0+lEG/70oU5rmbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760451475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6il3MiOfVqH5ZqSybd4flZzVhhfDytNW2X0vcpY3d9w=;
 b=Zndq5bgmP0HaymfeiMg+0Nh8N1PXHPVmTJl74D5BeaAVKO0mkXm2sSf+kWbYRgFFJEL3Of
 7JFYRgcDks2h8PDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760451475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6il3MiOfVqH5ZqSybd4flZzVhhfDytNW2X0vcpY3d9w=;
 b=qCqJ5igvcZLYXuMoMe/8AytzPMr8fonWazt7cKh9rpkFrjL9j1mW1LZRLLSSuIolRnii1F
 N+s2vCHVKHbj5dgUROPuX9UND6ZnMem/agn9OfgZfkUZREVxNeAtpRWx5/yDAgp2eabECA
 TAweYissk+8u9MgH0+lEG/70oU5rmbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760451475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6il3MiOfVqH5ZqSybd4flZzVhhfDytNW2X0vcpY3d9w=;
 b=Zndq5bgmP0HaymfeiMg+0Nh8N1PXHPVmTJl74D5BeaAVKO0mkXm2sSf+kWbYRgFFJEL3Of
 7JFYRgcDks2h8PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D900713A44;
 Tue, 14 Oct 2025 14:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EQdhJpJb7mgDcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Oct 2025 14:17:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: GuoBin <guobin@linux.alibaba.com>
Cc: Jamin Lin via <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIXQ==?= migration: Use
 QAPI_CLONE() instead of duplicating it inline
In-Reply-To: <ec3cda54-2e8e-435c-bccb-f15f43999cc4.guobin@linux.alibaba.com>
References: <20250929080115.98072-1-guobin@linux.alibaba.com>
 <87a52dwcyv.fsf@suse.de>
 <ec3cda54-2e8e-435c-bccb-f15f43999cc4.guobin@linux.alibaba.com>
Date: Tue, 14 Oct 2025 11:17:51 -0300
Message-ID: <87ikgha7ow.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.28 / 50.00]; BAYES_HAM(-2.98)[99.92%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

"GuoBin" <guobin@linux.alibaba.com> writes:

> ok, nice job, I will try to test it.
> When will the v3 version be released?

I hope to send it late this week. The series is ready in terms of code,
I just need to organize it a bit, make it palatable for review, etc.

