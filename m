Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FB3E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXBT-0008P4-Tk; Wed, 08 Jan 2025 09:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVXBS-0008Ou-IY
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:37:22 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVXBQ-0006o3-Q2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:37:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07F3F1F391;
 Wed,  8 Jan 2025 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736347039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7i3NKvk82GbsaGFcG1uQDrT56Uv6oGYQo0k/886ZWA=;
 b=XKB9cUnJpkmkGMcPq2f0jrSE0u78sGa78EDEhH/7ZxtB/Vx6mU81PyCEEnZV+BOPebYwo7
 BVg0bG0WUONc6bWkOmUGYOl2f93JkSxI2gLldHDkDZlDMZ5BnvES8KkEQVOk+L4F5Ho+O8
 d6hpuylTHbc04tcgFX0kW1EHiJyEi8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736347039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7i3NKvk82GbsaGFcG1uQDrT56Uv6oGYQo0k/886ZWA=;
 b=rT/S7S5cj4Mjx4ZtJUUAMUljoZGyrQyAXp7GT1w15xuu/mdDRPiC8HDB37WKtcLi4Lpk69
 IBt5ni16y4sr0gCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736347039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7i3NKvk82GbsaGFcG1uQDrT56Uv6oGYQo0k/886ZWA=;
 b=XKB9cUnJpkmkGMcPq2f0jrSE0u78sGa78EDEhH/7ZxtB/Vx6mU81PyCEEnZV+BOPebYwo7
 BVg0bG0WUONc6bWkOmUGYOl2f93JkSxI2gLldHDkDZlDMZ5BnvES8KkEQVOk+L4F5Ho+O8
 d6hpuylTHbc04tcgFX0kW1EHiJyEi8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736347039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7i3NKvk82GbsaGFcG1uQDrT56Uv6oGYQo0k/886ZWA=;
 b=rT/S7S5cj4Mjx4ZtJUUAMUljoZGyrQyAXp7GT1w15xuu/mdDRPiC8HDB37WKtcLi4Lpk69
 IBt5ni16y4sr0gCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 829601351A;
 Wed,  8 Jan 2025 14:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LicrEp6NfmdLTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 Jan 2025 14:37:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/7] migration: Document the effect of vmstate_info_nullptr
In-Reply-To: <Z36CQojucUnvonfD@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-4-farosas@suse.de> <Z32bkFa4snLklsbj@x1n>
 <87frlt4eli.fsf@suse.de> <Z36CQojucUnvonfD@x1n>
Date: Wed, 08 Jan 2025 11:37:15 -0300
Message-ID: <87a5c14bj8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jan 08, 2025 at 10:31:05AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Jan 07, 2025 at 04:50:21PM -0300, Fabiano Rosas wrote:
>> >> The migration stream lacks magic numbers at some key points. It's easy
>> >> to mis-parse data. Unfortunately, the VMS_NULLPTR_MARKER continues
>> >> with the trend. A '0' byte is ambiguous and could be interpreted as a
>> >> valid 0x30.
>> >> 
>> >> It is maybe not worth trying to change this while keeping backward
>> >> compatibility, so add some words of documentation to clarify.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >>  migration/vmstate-types.c    | 6 ++++++
>> >>  scripts/analyze-migration.py | 9 +++++++++
>> >>  2 files changed, 15 insertions(+)
>> >> 
>> >> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> >> index e83bfccb9e..08ed059f87 100644
>> >> --- a/migration/vmstate-types.c
>> >> +++ b/migration/vmstate-types.c
>> >> @@ -339,6 +339,12 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
>> >>  
>> >>  const VMStateInfo vmstate_info_nullptr = {
>> >>      .name = "uint64",
>> >
>> > Ouch.. So I overlooked this line and this explains why it didn't go via
>> > VMSDFieldGeneric already.
>> 
>> Yes, actually I overlooked as well that it should match the size of the
>> data being handled in the get/put functions.
>> 
>> My comment below is about NULL -> 0x30 that I think should instead be
>> NULL -> 0x3030303030303030 so we have any chance of looking at this and
>> identifying it's a NULL pointer. When we write 0x30 it might become
>> confusing for people reading the scripts output that their stream has a
>> bunch of '0' in the place where pointers should be. If the MAGIC number
>> were more identifiable, I could change the script to output (null) or 0x0ULL.
>
> I suppose we can?  If we want, by renaming this from "uint64" to "nullptr",
> then add an entry for it in Python's vmsd_field_readers.

That would be a nice alternative because it maps NULL to something, just
like the actual stream does. NULL -> '0' in the stream, NULL -> nullptr
in the JSON. I'll give it a try, thanks.

>> 
>> We also don't really have the concept of a pointer, which I suspect
>> might be the real reason behind all this mess. So we'll see:
>> 
>> 0x30
>> 0x30
>> {
>>   .some
>>   .struct
>>   .here
>> }
>> 0x30
>> 
>> So all this patch was trying to do is document this situation somehow.
>
> Yes, more docs makes sense, though just to mention it's nothing better here
> to use a full size of pointer: firstly it's not possible I think as 32/64
> bits have different size of pointers...
>
> More importantly, we're not sending the pointer but a marker, in this case
> the size of the real pointer doesn't really matter, IMHO.  A marker would
> make sense in saving some bytes when / if the array is large and sparse.

Right, it's just that a larger data type allows for a more unique
marker, which can be detected more reliably by the consumers of the
stream. The smaller data type is too ambiguous.

>
> Said that, let's try above idea, maybe it's optimal as you said the script
> can show things like "nullptr" (or any better name, I think that's better
> than "null" at least to show it's not a real pointer, otherwise it's weird
> to see any pointer in a migration stream..).

Yes, the script is just presenting the data, we can use what's more
informative.

>
>> 
>> >
>> > Instead of below comment, do we still have chance to change this to
>> > something like "uint8"?  Then I suppose the script will be able to identify
>> > this properly.

