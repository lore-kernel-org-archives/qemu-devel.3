Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C910ED666
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66H0-0007mj-SL; Fri, 27 Mar 2026 08:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66Gw-0007mP-Aw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:26:42 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66Gu-0002aB-Ob
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:26:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17C0E5BDD3;
 Fri, 27 Mar 2026 12:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWIkjQWxyhQDDp2L7lOWyWTqIeNLHCYUMbRWlwNLIig=;
 b=BvX/ZGIsebRgpBYGNbReHIDrRIGOGYx3GAAmvQ0+m/a3rWq09yah34GcKtmg/4Y3TnBeeq
 46u0Z5PL/2pHpY3LiYsxUUsRD+9jZHJ3ozXKcMzZCVBi9TKRtv/YkNYlyys+DpEc9/s5IC
 MoUk596sFJ7Z2MADbpPFpUobSqfQHXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWIkjQWxyhQDDp2L7lOWyWTqIeNLHCYUMbRWlwNLIig=;
 b=HnwsZJgCMj9hTeUji2jv+SeNchLmWFSWmOvfSLxwTA58lXSITPgB4Itc+qeFMzOcu0KrGU
 R+XvDK/6IhRzf+DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWIkjQWxyhQDDp2L7lOWyWTqIeNLHCYUMbRWlwNLIig=;
 b=BvX/ZGIsebRgpBYGNbReHIDrRIGOGYx3GAAmvQ0+m/a3rWq09yah34GcKtmg/4Y3TnBeeq
 46u0Z5PL/2pHpY3LiYsxUUsRD+9jZHJ3ozXKcMzZCVBi9TKRtv/YkNYlyys+DpEc9/s5IC
 MoUk596sFJ7Z2MADbpPFpUobSqfQHXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWIkjQWxyhQDDp2L7lOWyWTqIeNLHCYUMbRWlwNLIig=;
 b=HnwsZJgCMj9hTeUji2jv+SeNchLmWFSWmOvfSLxwTA58lXSITPgB4Itc+qeFMzOcu0KrGU
 R+XvDK/6IhRzf+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A92B44A0A2;
 Fri, 27 Mar 2026 12:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eQ/4HX53xmlgUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 12:26:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 04/11] vmstate: Update max_elems early and check
 field compressable once
In-Reply-To: <20260326210532.379027-5-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-5-peterx@redhat.com>
Date: Fri, 27 Mar 2026 09:26:36 -0300
Message-ID: <87pl4pihkz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> QEMU has a trick in vmstate_save_vmsd_v(), where it will try to compress
> multiple JSON entries into one with a count to avoid duplicated entries.
>
> That only applies to the cases where vmsd_can_compress() should return
> true.  For example, vmsd_desc_field_start() later (who will take the
> updated max_elems as the last parameter) will ignore the value passed in
> when vmsd_can_compress() returns false.
>
> Do that check once at the start of loop, and use it to update max_elems, so
> that max_elems keeps 1 for uncompressable VMSD fields, which is more
> straightforward.
>
> This also paves way to make this counter work for ptr marker VMSD fields
> too.
>
> No functional change intended in this patch alone.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

