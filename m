Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ACBC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX1av-00040k-QU; Mon, 05 Feb 2024 11:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1rX1au-00040H-Hb
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:13:16 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1rX1aq-0002uC-TW
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:13:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2EC92215B;
 Mon,  5 Feb 2024 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707149590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdBb7iCoxoKEgkQRzvJEuNDAGtYug4EpulrLEd3jz40=;
 b=GvYLsOComs6/rBdz3NwEqjOulhPsnKVedXjUK00YYsp89/YRZ2wKykmx6uwlltn44oDj9l
 bvVOJC6j35qOh7ypahg590JMoYsp3ruOcz7EOG42DXlYSheaPw0SzbvVV9QwAW7e4IO2Dd
 xZRBPofhsHAP6Fxz9q0qJFSTVhuzTfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707149590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdBb7iCoxoKEgkQRzvJEuNDAGtYug4EpulrLEd3jz40=;
 b=uftb8JnrRSisCTIWpOwSDC35TTW+eqtQv/1m7wLPcZFEO8/faWAZrWl35FBSGIfPtPkgp/
 w6lMrXjP/nz0s2CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707149590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdBb7iCoxoKEgkQRzvJEuNDAGtYug4EpulrLEd3jz40=;
 b=GvYLsOComs6/rBdz3NwEqjOulhPsnKVedXjUK00YYsp89/YRZ2wKykmx6uwlltn44oDj9l
 bvVOJC6j35qOh7ypahg590JMoYsp3ruOcz7EOG42DXlYSheaPw0SzbvVV9QwAW7e4IO2Dd
 xZRBPofhsHAP6Fxz9q0qJFSTVhuzTfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707149590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdBb7iCoxoKEgkQRzvJEuNDAGtYug4EpulrLEd3jz40=;
 b=uftb8JnrRSisCTIWpOwSDC35TTW+eqtQv/1m7wLPcZFEO8/faWAZrWl35FBSGIfPtPkgp/
 w6lMrXjP/nz0s2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AA66136F5;
 Mon,  5 Feb 2024 16:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qK0xEBYJwWXzDAAAD6G6ig
 (envelope-from <cfontana@suse.de>); Mon, 05 Feb 2024 16:13:10 +0000
Message-ID: <a482543e-581f-a13e-21f5-a6392e7c4524@suse.de>
Date: Mon, 5 Feb 2024 17:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL 5/8] util: Add write-only "node-affinity" property for
 ThreadContext
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Michal Privoznik <mprivozn@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20221028095225.86118-1-david@redhat.com>
 <20221028095225.86118-6-david@redhat.com>
 <beb8fd5c-3fc4-9bf5-1f9b-3947a25f52d9@suse.de>
 <f7f8f5ac-dfed-456d-91b1-9e4c4e2073b5@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <f7f8f5ac-dfed-456d-91b1-9e4c4e2073b5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-1.11)[88.34%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[9]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,linaro.org,weilnetz.de,nongnu.org,amsat.org];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.543,
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

Hello David,

It would seem to me that a lot of the calling code like qemu_prealloc_mem for example
should be sysemu-only, not used for tools, or user mode either right?

And the thread_context.c itself should also be sysemu-only, correct?

Thanks,

Claudio

On 2/5/24 15:15, David Hildenbrand wrote:
> On 05.02.24 11:14, Claudio Fontana wrote:
>> Hi,
> 
> Hi Claudio,
> 
>>
>> turning pages back in time,
>>
>> noticed that in recent qemu-img binaries we include an ELF dependency on libnuma.so that seems unused.
>>
>> I think it stems from this commit:
>>
>> commit 10218ae6d006f76410804cc4dc690085b3d008b5
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Fri Oct 14 15:47:17 2022 +0200
>>
>>      util: Add write-only "node-affinity" property for ThreadContext
>>
>>
>> possibly this hunk?
>>
>> diff --git a/util/meson.build b/util/meson.build
>> index e97cd2d779..c0a7bc54d4 100644
>> --- a/util/meson.build
>> +++ b/util/meson.build
>> @@ -1,5 +1,5 @@
>>   util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
>> -util_ss.add(files('thread-context.c'))
>> +util_ss.add(files('thread-context.c'), numa)
>>   if not config_host_data.get('CONFIG_ATOMIC64')
>>     util_ss.add(files('atomic64.c'))
>>   endif
>>
>>
>> I wonder if there is some conditional we could use to avoid the apparently useless dependency to libnuma in the qemu-img binary?
> 
> the simplest change is probably moving the thread-context stuff out of 
> util (as you say, it's currently only used by QEMU itself).
> 


