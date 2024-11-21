Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88457E64002
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 18:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECIt-0001o9-DH; Thu, 21 Nov 2024 13:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tECIq-0001nJ-VQ; Thu, 21 Nov 2024 13:53:21 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tECIo-0005Ry-Qa; Thu, 21 Nov 2024 13:53:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 338651F745;
 Thu, 21 Nov 2024 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732215195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z/8qWUuAC4IKHfWzYfTzMojL+goX/SGKXBvYnRyNYZo=;
 b=QXobUBc5WMt1qJz9SG8eZ7oKI79ce+YHQigRJtNygatNTihLeY0lakOvuGJ944Ay4o8aZ7
 BOX0NHLXeMPDtXnU7gl8x06o12Qf70SR2m2lavq39KaCD+tuiULlZY43X3bCyeVqplU7OA
 TDJDQG0Stpu/kZSMT3MhgU6qYSrdN4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732215195;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z/8qWUuAC4IKHfWzYfTzMojL+goX/SGKXBvYnRyNYZo=;
 b=bYzQaTtqCLrr2+eVHHtBQsNDk4Mb/L0bSXG10jSuG+fnQiJxlOYrOTb7uJhk1cPwUHrNTE
 IcunCPjT1ggzT2Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732215195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z/8qWUuAC4IKHfWzYfTzMojL+goX/SGKXBvYnRyNYZo=;
 b=QXobUBc5WMt1qJz9SG8eZ7oKI79ce+YHQigRJtNygatNTihLeY0lakOvuGJ944Ay4o8aZ7
 BOX0NHLXeMPDtXnU7gl8x06o12Qf70SR2m2lavq39KaCD+tuiULlZY43X3bCyeVqplU7OA
 TDJDQG0Stpu/kZSMT3MhgU6qYSrdN4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732215195;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z/8qWUuAC4IKHfWzYfTzMojL+goX/SGKXBvYnRyNYZo=;
 b=bYzQaTtqCLrr2+eVHHtBQsNDk4Mb/L0bSXG10jSuG+fnQiJxlOYrOTb7uJhk1cPwUHrNTE
 IcunCPjT1ggzT2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 906E1137CF;
 Thu, 21 Nov 2024 18:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /1VaEZqBP2euCgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Nov 2024 18:53:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Guenter Roeck <linux@roeck-us.net>, Michael Tokarev <mjt@tls.msk.ru>,
 Hannes Reinecke <hare@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH] scsi: megasas: Internal cdbs have 16-byte length
In-Reply-To: <6f2ba64a-dff1-49e7-bf81-4c1a7bf59494@roeck-us.net>
References: <20230228171129.4094709-1-linux@roeck-us.net>
 <dd384cc6-92f1-e940-a329-08b70f7ae439@msgid.tls.msk.ru>
 <96add555-a8aa-4ca7-8333-0890c3cedc0a@tls.msk.ru>
 <6f2ba64a-dff1-49e7-bf81-4c1a7bf59494@roeck-us.net>
Date: Thu, 21 Nov 2024 15:53:11 -0300
Message-ID: <87r0741krs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,roeck-us.net:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 roeck-us.net:email]
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

Guenter Roeck <linux@roeck-us.net> writes:

> On 2/17/24 01:06, Michael Tokarev wrote:
>>> 28.02.2023 20:11, Guenter Roeck wrote:
>>>> Host drivers do not necessarily set cdb_len in megasas io commands.
>>>> With commits 6d1511cea0 ("scsi: Reject commands if the CDB length
>>>> exceeds buf_len") and fe9d8927e2 ("scsi: Add buf_len parameter to
>>>> scsi_req_new()"), this results in failures to boot Linux from affected
>>>> SCSI drives because cdb_len is set to 0 by the host driver.
>>>> Set the cdb length to its actual size to solve the problem.
>> 
>> Has this been lost/forgotten?
>> 
>
> Not sure. My understanding was that I could not prove that this is how
> real hardware handles the situation, thus it wasn't applied. I carry it
> locally in my builds of qemu, so it is not a problem for me. Note that
> I didn't check if the problem has since been fixed differently. Maybe
> that is the case and the problem no longer exists in the upstream version
> of qemu.

The issue still happens upstream and I have just written the exact same
fix for it, so I'm adding my:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

