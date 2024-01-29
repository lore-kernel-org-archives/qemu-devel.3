Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80241C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 12:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUR6Z-000204-Op; Mon, 29 Jan 2024 07:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUR6X-0001yf-QY
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:51:13 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUR6V-0004qL-U9
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:51:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A547F1FCF2;
 Mon, 29 Jan 2024 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706532669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ropfbvkcP8hYG8kFzkmIMjz33yQYNeTDAtdDm0GS0sI=;
 b=0vE4oGVpQUK5QOL2T/i2+xcE+8FP5LCTMNGCDuqrzcBs9yV00cuAId43z7OaKwJyhLYbxC
 jTTIcgMTGpVupbFrtjt3wF2nsx1oMrWw2+43Stm4vxES9SiG7MUZyVUJuaOyZvw17oGixM
 mKOs57mDvsj50eapUyx3H728hTJcEmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706532669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ropfbvkcP8hYG8kFzkmIMjz33yQYNeTDAtdDm0GS0sI=;
 b=GCUIuTcoANybfBY0g/0vjSRXSOKlKa6HxaWtPUITcCQ2VyyE5hkOshRs2KLw/d1j6QKBCp
 UuSFouGYdId2ahCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706532669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ropfbvkcP8hYG8kFzkmIMjz33yQYNeTDAtdDm0GS0sI=;
 b=0vE4oGVpQUK5QOL2T/i2+xcE+8FP5LCTMNGCDuqrzcBs9yV00cuAId43z7OaKwJyhLYbxC
 jTTIcgMTGpVupbFrtjt3wF2nsx1oMrWw2+43Stm4vxES9SiG7MUZyVUJuaOyZvw17oGixM
 mKOs57mDvsj50eapUyx3H728hTJcEmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706532669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ropfbvkcP8hYG8kFzkmIMjz33yQYNeTDAtdDm0GS0sI=;
 b=GCUIuTcoANybfBY0g/0vjSRXSOKlKa6HxaWtPUITcCQ2VyyE5hkOshRs2KLw/d1j6QKBCp
 UuSFouGYdId2ahCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32EE012FF7;
 Mon, 29 Jan 2024 12:51:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qBnUOjyft2U+HwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Jan 2024 12:51:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Hao Xiang
 <hao.xiang@bytedance.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH 0/5] migration/multifd: Prerequisite cleanups for
 ongoing work
In-Reply-To: <ZbdVhLTLo5udNfeL@x1n>
References: <20240126221943.26628-1-farosas@suse.de>
 <PH7PR11MB5941BDAB9743C53A9E08CC3CA37E2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZbdVhLTLo5udNfeL@x1n>
Date: Mon, 29 Jan 2024 09:51:06 -0300
Message-ID: <87jznse211.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jan 29, 2024 at 01:41:01AM +0000, Liu, Yuan1 wrote:
>> Because this change has an impact on the previous live migration 
>> With IAA Patch, does the submission of the next version needs 
>> to be submitted based on this change?
>
> I'd say hold off a little while until we're more certain on the planned
> interface changes, to avoid you rebase your code back and forth; unless
> you're pretty confident that this will be the right approach.
>
> I apologize on not having looked at any of the QAT/IAA compression / zero
> detection series posted on the list; I do plan to read them very soon too
> after Fabiano.  So I may not have a complete full picture here yet, please
> bare with me.
>
> If this series is trying to provide a base ground for all the efforts,
> it'll be great if we can thoroughly discuss here and settle an approach
> soon that will satisfy everyone.

Just a summary if it helps:

For compression work (IAA/QPL, QAT) the discussion is around having a
new "compression acceleration" option that enables the accelerators and
is complementary to the existing zlib compression method. We'd choose
those automatically based on availability and we'd make HW accelerated
compression produce a stream that is compatible with QEMU's zlib stream
so we could migrate between solutions.

For zero page work and zero page acceleration (DSA), the question is how
to fit zero page detection into multifd and whether we need a new hook
multifd_ops->zero_page_detect() (or similar) to allow client code to
provide it's own zero page detection methods. My worry here is that
teaching multifd to recognize zero pages is one more coupling to the
"pages" data type. Ideallly we'd find a way to include that operation as
a prepare() responsibility and the client code would deal with it.


