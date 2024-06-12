Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DC4C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNic-0001qz-I4; Wed, 12 Jun 2024 09:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1sHNib-0001pz-Hw
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:08:49 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1sHNiZ-0000ns-Pc
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:08:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64C3221B11;
 Wed, 12 Jun 2024 13:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718197723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sLti1x2WHTPUgx+9FLUr6UUrzyE/h8D8CGPHkGLyBs=;
 b=lXlxS/9RqQXjv6BuJitJALq0QFqd8NxvLeZiYn3TEHiofKviiK7aaR3GUE09S2Z3AM0SBV
 q8wd7OzYp8RHXoSklA6f/jUFMeA5YROkuC+tEZRzIPO8xTmF46ljmvyS/5aztCG+RH+2MX
 rEfd7+g93EGhtQ9nqFrJfb9tsPMk+EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718197723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sLti1x2WHTPUgx+9FLUr6UUrzyE/h8D8CGPHkGLyBs=;
 b=gWLa7XthLeSfDqrUW74OWVuU9lAAgd2vAs7J6MOjEfeoTD7QLXxZif83c0rZQ9nPRznheE
 43LR7bq9j/Jb3QBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cX2cEdVE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ttvlMp9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718197721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sLti1x2WHTPUgx+9FLUr6UUrzyE/h8D8CGPHkGLyBs=;
 b=cX2cEdVEqFjnINK5ATAoz1pMBr+ojbcdwKikokD62jAHcsRna8PNkVzQe7+7NmWECVHkx1
 yBJ+tM8zan1nnTBXHzmhOtmJ0QQ+uCrpbqns9E4We7p86ECmBOFAF/+gGu7XwkuLDo4zzg
 TTl/95WFhDz0RqTopHYBAbps6h6l2SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718197721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sLti1x2WHTPUgx+9FLUr6UUrzyE/h8D8CGPHkGLyBs=;
 b=ttvlMp9VLpKNSNKtNeKJThL6b5uFoSle4XZIKbZQ9gzD76OI9Rncn4VX/oMXq7nPlYde/u
 zo+r2qoLT8QDkzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 301A3132FF;
 Wed, 12 Jun 2024 13:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r5o0CtmdaWYEMwAAD6G6ig
 (envelope-from <cfontana@suse.de>); Wed, 12 Jun 2024 13:08:41 +0000
Message-ID: <1a8cd52a-6c3e-47b4-89c8-d0254ba452e7@suse.de>
Date: Wed, 12 Jun 2024 15:08:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: assert fails in s390x TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
 <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
 <6a3e8443-2d0a-451e-a481-cc26575d8211@linaro.org>
 <14787dc3-66ae-e15e-0bdf-14ca53bff17d@linaro.org>
 <b0b49b1b-6877-487c-9f4d-b29ae54c5ab0@linaro.org>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <b0b49b1b-6877-487c-9f4d-b29ae54c5ab0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; XM_UA_NO_VERSION(0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nongnu.org:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, gnu.org:url, suse.de:email, suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 64C3221B11
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/12/24 14:41, Philippe Mathieu-Daudé wrote:
> On 28/7/23 18:43, Richard Henderson wrote:
>> On 7/28/23 09:05, Richard Henderson wrote:
>>> It's the page containing both code and a page table entry that 
>>> concerns me.  It seems like a kernel bug, though obviously we 
>>> shouldn't crash.  I'm not sure what to do about it.
>>
>> Bah.  Of course it's not a kernel bug, since the store is to LowCore.
>> And of course LowCore is part of a larger page, which easily has other 
>> stuff.
> 
> Maybe related to
> https://lore.kernel.org/qemu-devel/20240611215814.32752-1-anjo@rev.ng/
> 

Hi philippe,

this was already fixed by Ilya's commit:

commit 791b2b6a930273db694b9ba48bbb406e78715927
Author: Ilya Leoshkevich <iii@linux.ibm.com>
Date:   Sat Aug 5 01:03:18 2023 +0200

    target/s390x: Fix the "ignored match" case in VSTRS
    
    Currently the emulation of VSTRS recognizes partial matches in presence
    of \0 in the haystack, which, according to PoP, is not correct:
    
        If the ZS flag is one and a zero byte was detected
        in the second operand, then there can not be a
        partial match ...
    
    Add a check for this. While at it, fold a number of explicitly handled
    special cases into the generic logic.
    
    Cc: qemu-stable@nongnu.org
    Reported-by: Claudio Fontana <cfontana@suse.de>
    Closes: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00633.html
    Fixes: 1d706f314191 ("target/s390x: vxeh2: vector string search")
    Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
    Message-Id: <20230804233748.218935-3-iii@linux.ibm.com>
    Tested-by: Claudio Fontana <cfontana@suse.de>
    Acked-by: David Hildenbrand <david@redhat.com>
    Signed-off-by: Thomas Huth <thuth@redhat.com>

Ciao,

Claudio

