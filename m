Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0294E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIqG-0004rL-Uf; Mon, 29 Dec 2025 14:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaIq6-0004pi-KR
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:23:35 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaIq4-0005Aa-Vp
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:23:34 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 47A21336BA;
 Mon, 29 Dec 2025 19:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767036211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h5ZwfPDOnOKmoE4+IB9GNKnVXCmTIBriWgBnsdn3FU=;
 b=DfeGNvt9NAcVDJPTbaBgtAevFAW2CAg3jQwbO26WyCBt7Gl5KrGUwaW3W8yH+k8iW+HpJm
 m8PUQ9Rp35ziERWQm5tdlb65Ztp0vM86G7Mm3FXyYamfv23LQdb/ZweEKsE+Ewkzpdb94u
 sCeCEECPdr9uD9ygTbVzaNTVxMWfQqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767036211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h5ZwfPDOnOKmoE4+IB9GNKnVXCmTIBriWgBnsdn3FU=;
 b=MOP1ZdsLThvf6V7aITHzhiypkAI8cwcZ2RfWIkQgsxzjltFavAIAWUq9jViusbs48iYswi
 hIWCi57/iA1nmAAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767036211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h5ZwfPDOnOKmoE4+IB9GNKnVXCmTIBriWgBnsdn3FU=;
 b=DfeGNvt9NAcVDJPTbaBgtAevFAW2CAg3jQwbO26WyCBt7Gl5KrGUwaW3W8yH+k8iW+HpJm
 m8PUQ9Rp35ziERWQm5tdlb65Ztp0vM86G7Mm3FXyYamfv23LQdb/ZweEKsE+Ewkzpdb94u
 sCeCEECPdr9uD9ygTbVzaNTVxMWfQqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767036211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4h5ZwfPDOnOKmoE4+IB9GNKnVXCmTIBriWgBnsdn3FU=;
 b=MOP1ZdsLThvf6V7aITHzhiypkAI8cwcZ2RfWIkQgsxzjltFavAIAWUq9jViusbs48iYswi
 hIWCi57/iA1nmAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9D25137C3;
 Mon, 29 Dec 2025 19:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MDNHHjLVUmmfVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Dec 2025 19:23:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 07/25] migration: Use migrate_mode() to query for
 cpr-transfer
In-Reply-To: <aVKtYlK_4eLFEds_@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-8-farosas@suse.de> <aVKtYlK_4eLFEds_@x1.local>
Date: Mon, 29 Dec 2025 16:23:27 -0300
Message-ID: <87ldil853k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.986]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Dec 26, 2025 at 06:19:09PM -0300, Fabiano Rosas wrote:
>> cpr_set_incoming_mode() is only called on the target side, so
>> migrate_mode() on the source side is the same as s->parameters.mode.
>> 
>> Use the function to reduce explicit access to s->parameters, we have
>> options.c for that.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Said that, we have three more users outside options.c.  Wanna do it
> together?  They are:
>
>   migration_call_notifiers, migrate_mode_is_cpr, migrate_prepare.
>

Yep

