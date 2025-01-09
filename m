Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AF8E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVuqY-0006Jr-NU; Thu, 09 Jan 2025 10:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVuqX-0006JK-7Z
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:53:21 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVuqV-0002Tw-Ew
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:53:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B35471F394;
 Thu,  9 Jan 2025 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736437997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUn/DCYjWtFdE+jJ9ja0rNr2cOTx5GnTpw/bq6XgCcY=;
 b=ZUte4Yk2LHlCPz3BvfoZwjPWyEfAgn9v4oJpNQz513gPCaN7oxPByRty0hmblIRdvPe05p
 fAL6Tjq+yA0VE+kV0eeSGScTlAziIRf/XBL50S1iQK8xec6wvr2XpJ+5MtKoeV4xSWjiYI
 MjmihvHGxGjj7cN1GGJhbYEDCyCIJ0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736437997;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUn/DCYjWtFdE+jJ9ja0rNr2cOTx5GnTpw/bq6XgCcY=;
 b=+M9v7JoSsQkCmSVX62LuSa4HnaolhTAmDETF5OlBbPHWbKLxSZB9mj7eocs/FqWnEVSeHK
 cMqj/x9KYmB2PdBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736437997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUn/DCYjWtFdE+jJ9ja0rNr2cOTx5GnTpw/bq6XgCcY=;
 b=ZUte4Yk2LHlCPz3BvfoZwjPWyEfAgn9v4oJpNQz513gPCaN7oxPByRty0hmblIRdvPe05p
 fAL6Tjq+yA0VE+kV0eeSGScTlAziIRf/XBL50S1iQK8xec6wvr2XpJ+5MtKoeV4xSWjiYI
 MjmihvHGxGjj7cN1GGJhbYEDCyCIJ0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736437997;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUn/DCYjWtFdE+jJ9ja0rNr2cOTx5GnTpw/bq6XgCcY=;
 b=+M9v7JoSsQkCmSVX62LuSa4HnaolhTAmDETF5OlBbPHWbKLxSZB9mj7eocs/FqWnEVSeHK
 cMqj/x9KYmB2PdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35EC413876;
 Thu,  9 Jan 2025 15:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2isaO+zwf2cfewAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 15:53:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 4/7] migration: Rename vmstate_info_nullptr
In-Reply-To: <Z3_br0JVQ0F_Zas6@x1n>
References: <20250109140959.19464-1-farosas@suse.de>
 <20250109140959.19464-5-farosas@suse.de> <Z3_br0JVQ0F_Zas6@x1n>
Date: Thu, 09 Jan 2025 12:53:14 -0300
Message-ID: <87tta82dcl.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

> On Thu, Jan 09, 2025 at 11:09:56AM -0300, Fabiano Rosas wrote:
>> Rename vmstate_info_nullptr from "uint64_t" to "nullptr". This vmstate
>> actually reads and writes just a byte, so the proper name would be
>> uint8. However, since this is a marker for a NULL pointer, it's
>> convenient to have a more explicit name that can be identified by the
>> consumers of the JSON part of the stream.
>> 
>> Change the name to "nullptr" and add support for it in the
>> analyze-migration.py script. Arbitrarily use the name of the type as
>> the value of the field to avoid the script showing 0x30 or '0', which
>> could be confusing for readers.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/vmstate-types.c    |  2 +-
>>  scripts/analyze-migration.py | 22 ++++++++++++++++++++++
>>  2 files changed, 23 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index e83bfccb9e..d70d573dbd 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -338,7 +338,7 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
>>  }
>>  
>>  const VMStateInfo vmstate_info_nullptr = {
>> -    .name = "uint64",
>> +    .name = "nullptr",
>>      .get  = get_nullptr,
>>      .put  = put_nullptr,
>>  };
>> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
>> index fcda11f31d..134c25f20a 100755
>> --- a/scripts/analyze-migration.py
>> +++ b/scripts/analyze-migration.py
>> @@ -377,6 +377,8 @@ def read(self):
>>  
>>  
>>  class VMSDFieldInt(VMSDFieldGeneric):
>> +    NULL_PTR_MARKER = 0x30
>> +
>>      def __init__(self, desc, file):
>>          super(VMSDFieldInt, self).__init__(desc, file)
>>          self.size = int(desc['size'])
>> @@ -385,6 +387,16 @@ def __init__(self, desc, file):
>>          self.udtype = '>u%d' % self.size
>>  
>>      def __repr__(self):
>> +
>> +        # A NULL pointer is encoded in the stream as a '0' to
>> +        # disambiguate from a mere 0x0 value and avoid consumers
>> +        # trying to follow the NULL pointer. Displaying '0', 0x30 or
>> +        # 0x0 when analyzing the JSON debug stream could become
>> +        # confusing, so use an explicit term instead. The actual value
>> +        # in the stream was already validated by VMSDFieldNull.
>> +        if self.data == self.NULL_PTR_MARKER:
>> +            return "nullptr"
>
> What happens if a real int field has value 0x30 which is not a marker?
> Would it be wrongly represented as "nullptr"?
>

Yes, better to not inherit from VMSDFieldInt then.

>> +
>>          if self.data < 0:
>>              return ('%s (%d)' % ((self.format % self.udata), self.data))
>>          else:
>> @@ -417,6 +429,15 @@ def __init__(self, desc, file):
>>          super(VMSDFieldIntLE, self).__init__(desc, file)
>>          self.dtype = '<i%d' % self.size
>>  
>> +class VMSDFieldNull(VMSDFieldUInt):
>> +    def __init__(self, desc, file):
>> +        super(VMSDFieldUInt, self).__init__(desc, file)
>> +
>> +    def read(self):
>> +        super(VMSDFieldUInt, self).read()
>> +        assert(self.data == self.NULL_PTR_MARKER)
>> +        return self.data
>> +
>>  class VMSDFieldBool(VMSDFieldGeneric):
>>      def __init__(self, desc, file):
>>          super(VMSDFieldBool, self).__init__(desc, file)
>> @@ -558,6 +579,7 @@ def getDict(self):
>>      "bitmap" : VMSDFieldGeneric,
>>      "struct" : VMSDFieldStruct,
>>      "capability": VMSDFieldCap,
>> +    "nullptr": VMSDFieldNull,
>>      "unknown" : VMSDFieldGeneric,
>>  }
>>  
>> -- 
>> 2.35.3
>> 

