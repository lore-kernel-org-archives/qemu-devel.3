Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6008CE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVW9T-0007zB-OJ; Wed, 08 Jan 2025 08:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVW9R-0007yX-Bq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:31:13 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVW9P-0003Ww-DN
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:31:13 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DF2321101;
 Wed,  8 Jan 2025 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736343069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPSwN5pw+lbBvyGADDmqhlFI0ZFz6WtRmpEKNcTF6d4=;
 b=Jpx/0ZEarmaWtRqLJ0P9M47pMBQPuqn1N8hOZSiozUsYKqSVAkX/zT6+Dl8IaRf7t1R5vU
 xZuW1wOoQ6DAKoi1UO4W0kjEq6DYxJXMBrz3u7dLhrFnKQKZLYUSGO8zzhIKt2NKksPNkv
 pEOq1Y9KKbZbgNopltdQeeXWiIMKedE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736343069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPSwN5pw+lbBvyGADDmqhlFI0ZFz6WtRmpEKNcTF6d4=;
 b=tALuJF5vbMr+PtJKiynWNuibY/CYY6xp+fM92WtsyO/1QSLfMsED79n7BgcmofmL9E4yh+
 B++cCFfvgwdHlxAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736343068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPSwN5pw+lbBvyGADDmqhlFI0ZFz6WtRmpEKNcTF6d4=;
 b=TTTijvUAmVdnPlcKkFdJY3x9TSnOQPgR29gkI4tEKWSFauVO1GXeudLKxzJsdecXfmxgaF
 lgUellzA/oTHakocqhcW7S031y5sdtWHuERzCiaKsjBOwInjJuyCukFss31t2j5h/ake7V
 /g1nT3o4Hobf/faYBfjO2ZoHNiUtQNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736343068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPSwN5pw+lbBvyGADDmqhlFI0ZFz6WtRmpEKNcTF6d4=;
 b=NikhXjEO8pLawtP0TYP9rcVe8Owq0ijIGA7K4Ay0257ust1SN1LP8hpasp82dp9ilVZyFa
 jDUPDzFw5fLWeYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9922B137DA;
 Wed,  8 Jan 2025 13:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z05zFxt+fmcMNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 Jan 2025 13:31:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/7] migration: Document the effect of vmstate_info_nullptr
In-Reply-To: <Z32bkFa4snLklsbj@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-4-farosas@suse.de> <Z32bkFa4snLklsbj@x1n>
Date: Wed, 08 Jan 2025 10:31:05 -0300
Message-ID: <87frlt4eli.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[self.data:url, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

> On Tue, Jan 07, 2025 at 04:50:21PM -0300, Fabiano Rosas wrote:
>> The migration stream lacks magic numbers at some key points. It's easy
>> to mis-parse data. Unfortunately, the VMS_NULLPTR_MARKER continues
>> with the trend. A '0' byte is ambiguous and could be interpreted as a
>> valid 0x30.
>> 
>> It is maybe not worth trying to change this while keeping backward
>> compatibility, so add some words of documentation to clarify.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/vmstate-types.c    | 6 ++++++
>>  scripts/analyze-migration.py | 9 +++++++++
>>  2 files changed, 15 insertions(+)
>> 
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index e83bfccb9e..08ed059f87 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -339,6 +339,12 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
>>  
>>  const VMStateInfo vmstate_info_nullptr = {
>>      .name = "uint64",
>
> Ouch.. So I overlooked this line and this explains why it didn't go via
> VMSDFieldGeneric already.

Yes, actually I overlooked as well that it should match the size of the
data being handled in the get/put functions.

My comment below is about NULL -> 0x30 that I think should instead be
NULL -> 0x3030303030303030 so we have any chance of looking at this and
identifying it's a NULL pointer. When we write 0x30 it might become
confusing for people reading the scripts output that their stream has a
bunch of '0' in the place where pointers should be. If the MAGIC number
were more identifiable, I could change the script to output (null) or 0x0ULL.

We also don't really have the concept of a pointer, which I suspect
might be the real reason behind all this mess. So we'll see:

0x30
0x30
{
  .some
  .struct
  .here
}
0x30

So all this patch was trying to do is document this situation somehow.

>
> Instead of below comment, do we still have chance to change this to
> something like "uint8"?  Then I suppose the script will be able to identify
> this properly.
>
>> +
>> +     /*
>> +      * Ideally these would actually read/write the size of a pointer,
>> +      * but we're stuck with just a byte now for backward
>> +      * compatibility.
>> +      */
>>      .get  = get_nullptr,
>>      .put  = put_nullptr,
>>  };
>> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
>> index f2457b1dde..4292fde424 100755
>> --- a/scripts/analyze-migration.py
>> +++ b/scripts/analyze-migration.py
>> @@ -388,12 +388,21 @@ def read(self):
>>          return self.data
>>  
>>  class VMSDFieldUInt(VMSDFieldInt):
>> +    NULL_PTR_MARKER = 0x30
>> +
>>      def __init__(self, desc, file):
>>          super(VMSDFieldUInt, self).__init__(desc, file)
>>  
>>      def read(self):
>>          super(VMSDFieldUInt, self).read()
>>          self.data = self.udata
>> +
>> +        if self.data == self.NULL_PTR_MARKER:
>> +            # The migration stream encodes NULL pointers as '0' so any
>> +            # 0x30 in the stream could be a NULL. There's not much we
>> +            # can do without breaking backward compatibility.
>> +            pass
>
> So this change doesn't do anything, right?
>
> It'll be weird here having it "uint64" but the super().read() will actually
> only read 1 byte..  I assume the oneliner change of s/uint64/uint8/ could
> be a replacement of this patch, and I hope that'll work too for the script.
> So we will still see a bunch of 0x30s but I assume it's ok.
>
>> +
>>          return self.data
>>  
>>  class VMSDFieldIntLE(VMSDFieldInt):
>> -- 
>> 2.35.3
>> 

