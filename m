Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9B9CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rOQ-0000ig-Nn; Thu, 09 Oct 2025 10:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1v6rOO-0000ga-F1
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:13:16 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1v6rOE-0000EH-61
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:13:16 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out2.suse.de (Postfix) with ESMTP id 575361F74A;
 Thu,  9 Oct 2025 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760019176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xU/JZGNmkGTrl19lB1V8Tq1nAMa1tPKyxGuNvC0Scm0=;
 b=FB8orlAzA48Fm5KH7HP61Iw33my/GbxG+Dp3yzlGySxSyR27Qj5s+gJyZTqHrUZb+b2En5
 HEemq7NopUAZ+tXNh8Aimrn0Wa1nPrWPXD99wvpm6a08nK6XgQX99Wu+AwufeL3Cm24Abv
 +M7wb3JmN3881bZuMSOBvdBYQTnqyXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760019176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xU/JZGNmkGTrl19lB1V8Tq1nAMa1tPKyxGuNvC0Scm0=;
 b=M8bSRaMi0HhqMFsHv3B9BPAtbtFxFK2VPE4M6SMqzTah9PUzV9xsxykBx18V+nEfS0SN1T
 pL0QcafmyLAEWGCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FB8orlAz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=M8bSRaMi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760019176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xU/JZGNmkGTrl19lB1V8Tq1nAMa1tPKyxGuNvC0Scm0=;
 b=FB8orlAzA48Fm5KH7HP61Iw33my/GbxG+Dp3yzlGySxSyR27Qj5s+gJyZTqHrUZb+b2En5
 HEemq7NopUAZ+tXNh8Aimrn0Wa1nPrWPXD99wvpm6a08nK6XgQX99Wu+AwufeL3Cm24Abv
 +M7wb3JmN3881bZuMSOBvdBYQTnqyXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760019176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xU/JZGNmkGTrl19lB1V8Tq1nAMa1tPKyxGuNvC0Scm0=;
 b=M8bSRaMi0HhqMFsHv3B9BPAtbtFxFK2VPE4M6SMqzTah9PUzV9xsxykBx18V+nEfS0SN1T
 pL0QcafmyLAEWGCw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 40B624A0784; Thu,  9 Oct 2025 16:12:56 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] linux-user: fix layout of struct target_msq_id_ds
In-Reply-To: <97a43b68-7f68-4f8f-a647-0967b604267d@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 9 Oct 2025 15:55:07
 +0200")
References: <mvma520fd3i.fsf@suse.de>
 <97a43b68-7f68-4f8f-a647-0967b604267d@linaro.org>
Date: Thu, 09 Oct 2025 16:12:56 +0200
Message-ID: <mvmwm54duzb.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.28 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_SPAM_SHORT(2.99)[0.997];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; RCVD_NO_TLS_LAST(0.10)[];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:92b1:1cff:fe69:ddc:from];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 575361F74A
X-Rspamd-Action: add header
X-Spam: Yes
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=schwab@suse.de; helo=smtp-out2.suse.de
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

On Okt 09 2025, Philippe Mathieu-Daudé wrote:

> Hi Andreas,
>
> On 9/10/25 14:56, Andreas Schwab wrote:
>> The msg_lspid and msg_lrpid members are of type pid_t, which is a 32-bit
>> integer.
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> ---
>>   linux-user/syscall.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 0956a7b310..3dcdb3ef42 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -4185,8 +4185,8 @@ struct target_msqid_ds
>>       abi_ulong __msg_cbytes;
>>       abi_ulong msg_qnum;
>>       abi_ulong msg_qbytes;
>> -    abi_ulong msg_lspid;
>> -    abi_ulong msg_lrpid;
>> +    unsigned int msg_lspid;
>> +    unsigned int msg_lrpid;
>
> Why not use the explicit 'uint32_t' type?

linux-user/syscall.c often just uses int for 32-bit integers, and it's
the same as x86_64/target_syscall.h:struct target_msgid64_ds.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

