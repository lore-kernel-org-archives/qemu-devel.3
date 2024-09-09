Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CF9ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 10:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snbJC-0000nD-Ju; Mon, 09 Sep 2024 06:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1snbJA-0000mj-Q1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:07:44 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1snbJ9-0008MI-4m
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:07:44 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C39C31F7AB;
 Mon,  9 Sep 2024 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQbKFzQ0eUVaNRLx9qiwWOV82ics6dT90utmYiEvO7Q=;
 b=W+obvUBwjM58ZKxgB1Em1GvWT5bzepnYDC/8qzI+ckCTtahs3OuvfKQSpCdENLvX23FIlW
 VyJHJoGRloR4WW50CYLsckkGhVb6JhYn6Cm1RZ9mXiExV5q+g6g7twk5YPebzQM89UhMJF
 uIbFhwi5Ngm54cSQRLze8piapudI56I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQbKFzQ0eUVaNRLx9qiwWOV82ics6dT90utmYiEvO7Q=;
 b=6aGv5oD1i57o+W74wk9kQXzRDHMEo0un3MG4nVzud6hcfBX9Lk3os2RnZZ3/6B7AMEKnEK
 y6dpMpT2yBuTnfDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQbKFzQ0eUVaNRLx9qiwWOV82ics6dT90utmYiEvO7Q=;
 b=W+obvUBwjM58ZKxgB1Em1GvWT5bzepnYDC/8qzI+ckCTtahs3OuvfKQSpCdENLvX23FIlW
 VyJHJoGRloR4WW50CYLsckkGhVb6JhYn6Cm1RZ9mXiExV5q+g6g7twk5YPebzQM89UhMJF
 uIbFhwi5Ngm54cSQRLze8piapudI56I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQbKFzQ0eUVaNRLx9qiwWOV82ics6dT90utmYiEvO7Q=;
 b=6aGv5oD1i57o+W74wk9kQXzRDHMEo0un3MG4nVzud6hcfBX9Lk3os2RnZZ3/6B7AMEKnEK
 y6dpMpT2yBuTnfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9067213312;
 Mon,  9 Sep 2024 10:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ura0IerI3mYxEQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Mon, 09 Sep 2024 10:07:38 +0000
Message-ID: <0cbe47a3-5572-4f74-b2ba-69abd8d3b448@suse.de>
Date: Mon, 9 Sep 2024 12:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove unnecessary code in the interface
 accel_system_init_ops_interfaces
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, philmd@linaro.org,
 alistair.francis@wdc.com, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20240909031736.1881-1-andrew.yuan@jaguarmicro.com>
 <e93d6ed4-8fe2-434b-9d84-997bae44847f@ventanamicro.com>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <e93d6ed4-8fe2-434b-9d84-997bae44847f@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
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

On 9/9/24 11:54, Daniel Henrique Barboza wrote:
> 
> 
> On 9/9/24 12:17 AM, Andrew.Yuan wrote:
>> The code 'ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));' is unnecessary;
>>
>> And, the following code :
>> 1.has the same functionality;
>> 2.includes error checking;
>>
>> Signed-off-by: Andrew.Yuan <andrew.yuan@jaguarmicro.com>
>> ---
>>   accel/accel-system.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>> index f6c947dd82..5d502c8fd8 100644
>> --- a/accel/accel-system.c
>> +++ b/accel/accel-system.c
>> @@ -73,7 +73,7 @@ void accel_system_init_ops_interfaces(AccelClass *ac)
>>       g_assert(ac_name != NULL);
>>   
>>       ops_name = g_strdup_printf("%s" ACCEL_OPS_SUFFIX, ac_name);
>> -    ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));
>> +
> 
> The code you're changing was added by 5141e9a23f ("accel: abort if we fail to
> load the accelerator plugin") and I think this repetition is intended. If I have
> to guess (first time looking at this code), ACCEL_OPS_CLASS() is creating the class
> type QOM functions that the the second module_object_class_by_name() relies on to
> catch the module load error the commit is trying to address.
> 
> I'm CCing Claudio to get a better idea of the intention here. At the very least we
> should add a code comment explaining the reasoning behind initing 'ops' two times
> in a row and so on.
> 
> 
> Thanks,
> 
> Daniel

Hi Daniel, just to signal that I've seen this message and will get to it when I am back to work later this week.

Ciao,

Claudio

> 
>>       oc = module_object_class_by_name(ops_name);
>>       if (!oc) {
>>           error_report("fatal: could not load module for type '%s'", ops_name);


