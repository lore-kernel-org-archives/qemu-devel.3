Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02373C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 12:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAU4R-0000Ns-DZ; Fri, 24 May 2024 08:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAU4P-0000Mm-BE
 for qemu-devel@nongnu.org; Fri, 24 May 2024 08:30:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAU4N-00027d-9P
 for qemu-devel@nongnu.org; Fri, 24 May 2024 08:30:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E4EC209F4;
 Fri, 24 May 2024 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716553845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bv4e/aUlr46jA/u5f8rP6ikzEdwN8+0nhC/ccCHTb5o=;
 b=dbioLO2sDmZP4N0+Gdcw7t+VbMPQmWucyBIuMCXy+VwzRqZqKp8NW0rSMvJ+KsYT6sODvJ
 oKbkMw9mB7BNfASmO6lbFAaUspk/XYRS4rEfbpgjFf1PS4IEUywRGL2OtIODBl0tmiG+Uy
 7Dm6lnEruLq/iQngVSvOX0Swuq3zm24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716553845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bv4e/aUlr46jA/u5f8rP6ikzEdwN8+0nhC/ccCHTb5o=;
 b=c60th/7Nox9HVtOv+5hVb2TTDhRUDxGdi1++JAGRQlJQ4tZweZ8kB0EiLWS1TZcluAmwLb
 I53ubvkNVvAFXMBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716553845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bv4e/aUlr46jA/u5f8rP6ikzEdwN8+0nhC/ccCHTb5o=;
 b=dbioLO2sDmZP4N0+Gdcw7t+VbMPQmWucyBIuMCXy+VwzRqZqKp8NW0rSMvJ+KsYT6sODvJ
 oKbkMw9mB7BNfASmO6lbFAaUspk/XYRS4rEfbpgjFf1PS4IEUywRGL2OtIODBl0tmiG+Uy
 7Dm6lnEruLq/iQngVSvOX0Swuq3zm24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716553845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bv4e/aUlr46jA/u5f8rP6ikzEdwN8+0nhC/ccCHTb5o=;
 b=c60th/7Nox9HVtOv+5hVb2TTDhRUDxGdi1++JAGRQlJQ4tZweZ8kB0EiLWS1TZcluAmwLb
 I53ubvkNVvAFXMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A8BA13A6B;
 Fri, 24 May 2024 12:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G2zANHSIUGblPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 May 2024 12:30:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Peter Xu
 <peterx@redhat.com>, Claudio Fontana <cfontana@suse.de>, Jim Fehlig
 <jfehlig@suse.com>
Subject: Re: [PATCH v2 01/18] migration: Fix file migration with fdset
In-Reply-To: <CAE8KmOw7yULgf9hstkYL+E+azpG7RRhj_eGMMDeZK4qvcuLv0g@mail.gmail.com>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-2-farosas@suse.de>
 <CAE8KmOw7yULgf9hstkYL+E+azpG7RRhj_eGMMDeZK4qvcuLv0g@mail.gmail.com>
Date: Fri, 24 May 2024 09:30:42 -0300
Message-ID: <87r0drgznx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Fri, 24 May 2024 at 00:38, Fabiano Rosas <farosas@suse.de> wrote:
>> This is further indicated by the presence of the 'offset'
>> argument, which indicates the start of the region where QEMU is
>> allowed to write.
>>
>> Fix the issue by replacing the O_TRUNC flag on open by an ftruncate
>> call, which will take the offset into consideration.
>>
>> +    if (ftruncate(fioc->fd, offset)) {
>> +        error_setg_errno(errp, errno,
>> +                         "failed to truncate migration file to offset %" PRIx64,
>> +                         offset);
>> +        object_unref(OBJECT(fioc));
>> +        return;
>> +    }
>> +
>
> * Should 'offset' be checked for > zero while ftruncating? Else it'll
> be same as O_TRUNC. Otherwise it looks fine.

That's the point. If offset==0 we truncate all the way, if not, we
truncate to the offset.

>
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks!

