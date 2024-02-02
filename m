Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD6DC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVzBe-0001mH-GD; Fri, 02 Feb 2024 14:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVzBb-0001bb-Rb
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:26:51 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVzBX-0007pC-FQ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:26:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AAC3221FB2;
 Fri,  2 Feb 2024 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706902002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ljhyRXFOPnk02lDhSdOIVvgRwL+n3a11haEAGPBUl8=;
 b=zU6Ube3ufL5hJAriqwXhB7ZokfrmHZ1737II9oy66P0DWjdSBYZco5R1qoNDcKB9xSE/22
 1ZWEuxhuXWQWUqu58Y/G+ySW+mzrOkrJWSLnJkd96RrPWbACS1W+ulkwD1Nhi6TLOtpPI7
 kYLfB/ng7YLlILBdtxd+0QUwq/D/+ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706902002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ljhyRXFOPnk02lDhSdOIVvgRwL+n3a11haEAGPBUl8=;
 b=+wI2OY0hJFYazSz89mHQA0XQWxsjbsoIV/WKB0MTvALNq7BGOlLEa4JLHTRqbIisLBnXm3
 FxgBACPO8Yc5ZzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706902002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ljhyRXFOPnk02lDhSdOIVvgRwL+n3a11haEAGPBUl8=;
 b=zU6Ube3ufL5hJAriqwXhB7ZokfrmHZ1737II9oy66P0DWjdSBYZco5R1qoNDcKB9xSE/22
 1ZWEuxhuXWQWUqu58Y/G+ySW+mzrOkrJWSLnJkd96RrPWbACS1W+ulkwD1Nhi6TLOtpPI7
 kYLfB/ng7YLlILBdtxd+0QUwq/D/+ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706902002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ljhyRXFOPnk02lDhSdOIVvgRwL+n3a11haEAGPBUl8=;
 b=+wI2OY0hJFYazSz89mHQA0XQWxsjbsoIV/WKB0MTvALNq7BGOlLEa4JLHTRqbIisLBnXm3
 FxgBACPO8Yc5ZzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32959139AB;
 Fri,  2 Feb 2024 19:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fJrDOfFBvWW5ZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 19:26:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH v2 13/23] migration/multifd: Move header prepare/fill
 into send_prepare()
In-Reply-To: <20240202102857.110210-14-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-14-peterx@redhat.com>
Date: Fri, 02 Feb 2024 16:26:39 -0300
Message-ID: <87o7cyhdlc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; URIBL_BLOCKED(0.00)[suse.de:email];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-0.09)[64.64%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
> This patch redefines the interfacing of ->send_prepare().  It further
> simplifies multifd_send_thread() especially on zero copy.
>
> Now with the new interface, we require the hook to do all the work for
> preparing the IOVs to send.  After it's completed, the IOVs should be ready
> to be dumped into the specific multifd QIOChannel later.
>
> So now the API looks like:
>
>   p->pages ----------->  send_prepare() -------------> IOVs
>
> This also prepares for the case where the input can be extended to even not
> any p->pages.  But that's for later.
>
> This patch will achieve similar goal of what Fabiano used to propose here:
>
> https://lore.kernel.org/r/20240126221943.26628-1-farosas@suse.de
>
> However the send() interface may not be necessary.  I'm boldly attaching a
> "Co-developed-by" for Fabiano.
>
> Co-developed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

