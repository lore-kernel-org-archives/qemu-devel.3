Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FDDC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJIM0-0007Wl-61; Mon, 17 Jun 2024 15:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJILx-0007WY-Sh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:49:21 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJILw-0005SD-ET
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:49:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E64A31F383;
 Mon, 17 Jun 2024 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718653759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOf7kOOt4iV7JCMOx3ui/gLXYgesjyFhVvtHbstP0Q8=;
 b=qCass09g3npHQqzXjwPlURdFrDKOdzgypGRIhlB0XPpnsBeT9QcFKdZ855Sgaiq2IESq4h
 vLC0OYLpKzKLEH+fByc9XUQ2NVkH5S9GlPFM1625aDShdEB2EN2oLMYLH2UuKDZOv8nK8y
 z3a5g7cryu3sGeo9Blz+agD8SDBA/HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718653759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOf7kOOt4iV7JCMOx3ui/gLXYgesjyFhVvtHbstP0Q8=;
 b=hjnZ6pdjLWRBk+3mhgJnmSzayrUtw4ks2U5yLMB95025FXTqwK1YhOOFJthjLXKja45Ziy
 /tIO8mwit+XpBNDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718653757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOf7kOOt4iV7JCMOx3ui/gLXYgesjyFhVvtHbstP0Q8=;
 b=XAVyorC8mhg+EqLH+fwqAfauzFLpUb8ioaWjQpSKAnUhJ5RqHeYZHIElFHFWKAM5BXp5mJ
 gJfVys/nyp2/omZkTlm15hdkpGwq2EI1zstefwIfytWyu28ss0FH3r2EvOf4VIEGDLv5gd
 YT4Ui+cLAogDjLhymFjq6+VIsz8MNu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718653757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOf7kOOt4iV7JCMOx3ui/gLXYgesjyFhVvtHbstP0Q8=;
 b=u6Ywl6dWR21hUWUVf4e8LTPRSJOrY6RIaLV6GDVF1gtxSmlDIKCp9E/PH6tmH7+OcDqs1P
 6qGBR5rdRgmNGdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F2A613AAA;
 Mon, 17 Jun 2024 19:49:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9ZaEDT2TcGY5NgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 19:49:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com, Jiri Denemark
 <jdenemar@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH v2 07/10] tests/migration-tests: Drop most WIN32 ifdefs
 for postcopy failure tests
In-Reply-To: <20240617181534.1425179-8-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
 <20240617181534.1425179-8-peterx@redhat.com>
Date: Mon, 17 Jun 2024 16:49:14 -0300
Message-ID: <87cyofbb9h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.17 / 50.00]; BAYES_HAM(-2.87)[99.44%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
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

> Most of them are not needed, we can stick with one ifdef inside
> postcopy_recover_fail() so as to cover the scm right tricks only.
> The tests won't run on windows anyway due to has_uffd always false.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

