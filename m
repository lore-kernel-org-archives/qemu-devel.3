Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A16D3B7F3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 15:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSdPb-0007yd-5s; Mon, 08 Dec 2025 10:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1vSdPa-0007yD-2N
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:44:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1vSdPY-0007lW-KG
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:44:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 960865BCFF;
 Mon,  8 Dec 2025 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765208666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSGMnvXRl1SU79SD2AjR6o25Jb20JT9DvCwDWfMnqLM=;
 b=Q1rUOCioWm06+KQPOQDtjlPR71YeNnqu4F2mN+hFHU28Eb1swTKIYoNF0TmhvaBMCWcco4
 MWyvCkJJHdX0tk0E6bnhwD5Wo8iQLK409raZz3fVL1HgmA1eROa6wnoyIEi3V7Z3qyTmBi
 St7iOILv7iFE8XEZqf8tlZmxrTm1gdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765208666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSGMnvXRl1SU79SD2AjR6o25Jb20JT9DvCwDWfMnqLM=;
 b=Vi8naevZP9qbzDW0zzLV++CnfUKp340I/3V2W/Cx9q+VVq4hMI1Sp8VAtiaRC0lMYVjSDm
 cJ3wDfmWj6F1E1BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765208666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSGMnvXRl1SU79SD2AjR6o25Jb20JT9DvCwDWfMnqLM=;
 b=Q1rUOCioWm06+KQPOQDtjlPR71YeNnqu4F2mN+hFHU28Eb1swTKIYoNF0TmhvaBMCWcco4
 MWyvCkJJHdX0tk0E6bnhwD5Wo8iQLK409raZz3fVL1HgmA1eROa6wnoyIEi3V7Z3qyTmBi
 St7iOILv7iFE8XEZqf8tlZmxrTm1gdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765208666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSGMnvXRl1SU79SD2AjR6o25Jb20JT9DvCwDWfMnqLM=;
 b=Vi8naevZP9qbzDW0zzLV++CnfUKp340I/3V2W/Cx9q+VVq4hMI1Sp8VAtiaRC0lMYVjSDm
 cJ3wDfmWj6F1E1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52BEE3EA63;
 Mon,  8 Dec 2025 15:44:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 64szEVryNmnefQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Mon, 08 Dec 2025 15:44:26 +0000
Message-ID: <6d36351f-5faf-449d-9de1-0db1fedf394d@suse.de>
Date: Mon, 8 Dec 2025 16:44:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration/options: Add x-ignore-shared
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>
References: <20251205172054.288909-1-peterx@redhat.com>
 <87h5u1kmku.fsf@suse.de>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <87h5u1kmku.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.24 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.14)[-0.716]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

On 12/8/25 16:41, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> This aids scriptings only.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  migration/options.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index e78324b80c..30bf9afaf0 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -203,6 +203,7 @@ const Property migration_properties[] = {
>>                          MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>>      DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
>>      DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
>> +    DEFINE_PROP_MIG_CAP("x-ignore-share", MIGRATION_CAPABILITY_X_IGNORE_SHARED),
>>  };
>>  const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 

Nit: x-ignore-shared or x-ignore-share ? Commit msg and code seem to disagree.

Ciao,

C

