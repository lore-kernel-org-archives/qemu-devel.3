Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFE5E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvM7-0001u0-Op; Thu, 09 Jan 2025 11:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVvM6-0001tp-BA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:25:58 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVvM4-0008KN-Ny
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:25:58 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC3FF21164;
 Thu,  9 Jan 2025 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736439954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p+0Yw9wp9VdlIEXZ8BPiNFWFan17zmYRQ2+H4GBNU7c=;
 b=yekNkHx4Dpp6PVb2WmUKFCV6QkLOWlSzQkoz8ZymVfoZc0Niy/3F9bG7h/GS6dUzADuUdd
 6vu9ROGPhpgWOYFeuxWDSYL4FAaDLv+XmIroFCElAjHtQIZW6hc09fpr8yydm1jFYq4bof
 yUcv/9BxsI5tIIQhJBVMoQpdYefSmO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736439954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p+0Yw9wp9VdlIEXZ8BPiNFWFan17zmYRQ2+H4GBNU7c=;
 b=sz8HjQ3flDwcP65mP2nZaBlP3OW+TSMcfIA6hIh4ovAW2SdeNXhxvtKA/FH91cw3OslUdn
 l3rjIPIV3Jpz/ZDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yekNkHx4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sz8HjQ3f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736439954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p+0Yw9wp9VdlIEXZ8BPiNFWFan17zmYRQ2+H4GBNU7c=;
 b=yekNkHx4Dpp6PVb2WmUKFCV6QkLOWlSzQkoz8ZymVfoZc0Niy/3F9bG7h/GS6dUzADuUdd
 6vu9ROGPhpgWOYFeuxWDSYL4FAaDLv+XmIroFCElAjHtQIZW6hc09fpr8yydm1jFYq4bof
 yUcv/9BxsI5tIIQhJBVMoQpdYefSmO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736439954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p+0Yw9wp9VdlIEXZ8BPiNFWFan17zmYRQ2+H4GBNU7c=;
 b=sz8HjQ3flDwcP65mP2nZaBlP3OW+TSMcfIA6hIh4ovAW2SdeNXhxvtKA/FH91cw3OslUdn
 l3rjIPIV3Jpz/ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 435A3139AB;
 Thu,  9 Jan 2025 16:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WzGKApL4f2fHBgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 16:25:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 6/7] migration: Fix arrays of pointers in JSON writer
In-Reply-To: <Z3_3oPAypaz2HOfW@x1n>
References: <20250109140959.19464-1-farosas@suse.de>
 <20250109140959.19464-7-farosas@suse.de> <Z3_eZId2Ylj3bCU2@x1n>
 <87r05c2c9m.fsf@suse.de> <Z3_3oPAypaz2HOfW@x1n>
Date: Thu, 09 Jan 2025 13:25:51 -0300
Message-ID: <87y0zk54z4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: BC3FF21164
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On Thu, Jan 09, 2025 at 01:16:37PM -0300, Fabiano Rosas wrote:
>> > Btw, since the new code will process it correctly with non-array below,
>> > IIUC here we can make it simple:
>> >
>> >   if 'index' in field:
>> >       self.data[fname] = fdata
>> >
>> 
>> Sorry, I don't understand what you mean here. I changed it now to:
>> 
>>     if fname not in self.data:
>>         if 'index' in field:
>>             self.data[fname] = [fdata]
>>         else:
>>             self.data[fname] = fdata
>>     elif type(self.data[fname]) == list:
>>         self.data[fname].append(fdata)
>>     else:
>>         tmp = self.data[fname]
>>         self.data[fname] = [tmp, fdata]
>
> I meant we could avoid checking "index" completely now with the new code
> knowing how to expand, so IIUC it can be simplified to:
>
>   if fname not in self.data:
>       self.data[fname] = fdata
>   elif type(self.data[fname]) == list:
>       self.data[fname].append(fdata)
>   else:
>       tmp = self.data[fname]
>       self.data[fname] = [tmp, fdata]

Good point, I'll change that. Thanks

