Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFB0C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 20:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkrfH-0006hx-Bk; Thu, 14 Mar 2024 16:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rkrfE-0006hc-S5; Thu, 14 Mar 2024 16:26:56 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rkrfA-00014U-Th; Thu, 14 Mar 2024 16:26:56 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3812C21D60;
 Thu, 14 Mar 2024 20:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710448011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sElH8nAbakcnDQrw6pZA9TEJ9r69EEpC77TqJhFDDBI=;
 b=Yivo40q8qr00W/VvsXqva4ridqbzSl+yiuXsHNdpXK17/sLPOKTX/dBHCEufH2MEzR/z/b
 h2LwdBjnvXJSgji/xmUyerrxFxGNgqhFGBQ1ri+/b9MVrQzkQJI8OpDasmLC3bSiXE/8um
 u144qmLqDGn+o5vsAQhGQmWj3HKJnI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710448011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sElH8nAbakcnDQrw6pZA9TEJ9r69EEpC77TqJhFDDBI=;
 b=cbjuEoSZkQYBy2dW+1vCynaw+yrS7KXvO8QZvf6414o1L3DrqY8G+oJPHIO4rpffNSQvtg
 2fincy9oxgnJb/Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710448011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sElH8nAbakcnDQrw6pZA9TEJ9r69EEpC77TqJhFDDBI=;
 b=Yivo40q8qr00W/VvsXqva4ridqbzSl+yiuXsHNdpXK17/sLPOKTX/dBHCEufH2MEzR/z/b
 h2LwdBjnvXJSgji/xmUyerrxFxGNgqhFGBQ1ri+/b9MVrQzkQJI8OpDasmLC3bSiXE/8um
 u144qmLqDGn+o5vsAQhGQmWj3HKJnI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710448011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sElH8nAbakcnDQrw6pZA9TEJ9r69EEpC77TqJhFDDBI=;
 b=cbjuEoSZkQYBy2dW+1vCynaw+yrS7KXvO8QZvf6414o1L3DrqY8G+oJPHIO4rpffNSQvtg
 2fincy9oxgnJb/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3FA51368C;
 Thu, 14 Mar 2024 20:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vubSOYpd82XGBgAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 14 Mar 2024 20:26:50 +0000
Message-ID: <2a7b5636-132b-17f9-bd8c-0ee4f2beef0e@suse.de>
Date: Thu, 14 Mar 2024 21:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] target/s390x: improve cpu compatibility check error
 message
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240314190007.19568-1-cfontana@suse.de>
 <226063093bf4dcb200c981dd5b655135d8a47feb.camel@linux.ibm.com>
 <540bb2d3-7bd6-a4b7-32e2-5787dc1ca015@suse.de>
In-Reply-To: <540bb2d3-7bd6-a4b7-32e2-5787dc1ca015@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.534,
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

On 3/14/24 21:10, Claudio Fontana wrote:
> On 3/14/24 20:44, Nina Schoetterl-Glausch wrote:
>> On Thu, 2024-03-14 at 20:00 +0100, Claudio Fontana wrote:
>>> some users were confused by this message showing under TCG:
>>>
>>> Selected CPU generation is too new. Maximum supported model
>>> in the configuration: 'xyz'
>>>
>>> Try to clarify that the maximum can depend on the accel by
>>> adding also the current accelerator to the message as such:
>>>
>>> Selected CPU generation is too new. Maximum supported model
>>> in the accelerator 'tcg' configuration: 'xyz'
>>>
>>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>>> ---
>>>  target/s390x/cpu_models.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index 1a1c096122..0d6d8fc727 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -508,14 +508,14 @@ static void check_compatibility(const S390CPUModel *max_model,
>>>  
>>>      if (model->def->gen > max_model->def->gen) {
>>>          error_setg(errp, "Selected CPU generation is too new. Maximum "
>>> -                   "supported model in the configuration: \'%s\'",
>>> -                   max_model->def->name);
>>> +                   "supported model in the accelerator \'%s\' configuration: \'%s\'",
>>> +                   current_accel_name(), max_model->def->name);
>>>          return;
>>>      } else if (model->def->gen == max_model->def->gen &&
>>>                 model->def->ec_ga > max_model->def->ec_ga) {
>>>          error_setg(errp, "Selected CPU GA level is too new. Maximum "
>>> -                   "supported model in the configuration: \'%s\'",
>>> -                   max_model->def->name);
>>> +                   "supported model in the accelerator \'%s\' configuration: \'%s\'",
>>> +                   current_accel_name(), max_model->def->name);
>>>          return;
>>>      }
>>>  
>>> @@ -537,7 +537,8 @@ static void check_compatibility(const S390CPUModel *max_model,
>>>      error_setg(errp, " ");
>>>      s390_feat_bitmap_to_ascii(missing, errp, error_prepend_missing_feat);
>>>      error_prepend(errp, "Some features requested in the CPU model are not "
>>> -                  "available in the configuration: ");
>>> +                  "available in the accelerator \'%s\' configuration: ",
>>> +                  current_accel_name());
>>>  }
>>
>> I wonder if these might not be confusing in other circumstances, e.g. when
>> running with KVM and the Linux version lacks support for some feature.
> 
> Here you are referencing specifically the last hunk right? Ie the "Some features requested..." message.
> 
>> I think something along the lines of:
>>
>> error_...(errp, "... supported by the current configuration ...", ...);
>> error_append_hint(errp, "Consider using a different accelerator, a different QEMU version or, when using KVM, a different kernel");
>>
>> would be better.
> 
> Interesting I'll try something along these lines.
> 
>>
>> I'm not sure about line breaks in error message, I like the better grepability
>> of unbroken lines but the coding style guide doesn't mention anything.
> 
> better greppability in the log (as the error message in the log), or in the source code (or both)?
> I am generally in favor of both, but there might be constraints on line length, although scripts/checkpatch.pl did not complain when I attempted this (I wonder if bug or feature).
> 
> docs/devel/style.rst on the code line length topic says:
> "Lines should be 80 characters; try not to make them longer..."
> 
> and it does talk about exceptions. In the case of error message strings I think this could be one one of those exceptions.
> 
> In terms of logs, I did not find anything either, the most pertinent section should be "Error handling and reporting" in the same file,
> but there is nothing about breaking up [or not] a single message in errors with newlines.

Ah I forgot the mythical include/qapi/error.h:

for error_setg we have:

"The resulting message should be a single phrase, with no newline or trailing punctuation."

so this helps.

> 
>>>  
>>>  S390CPUModel *get_max_cpu_model(Error **errp)
>>
> 
> Thanks,
> 
> Claudio


