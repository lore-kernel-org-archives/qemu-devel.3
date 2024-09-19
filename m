Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD274CE8D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 11:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srFSq-0002px-B2; Thu, 19 Sep 2024 07:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1srFSn-0002or-GA; Thu, 19 Sep 2024 07:36:45 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1srFSl-0005k2-Dn; Thu, 19 Sep 2024 07:36:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25DDD3389A;
 Thu, 19 Sep 2024 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726745801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN3IQqa64vRMg4h+Wr7zWchzJEAtuQ/fyQe/maW3neY=;
 b=e74v4OZhWn0mQvMb2oI4tfMF3CRwWtwZgkMsLkTdhGkpVC7dokg52SDcc5kU6xbGhg7Jnb
 mqMNjJlLNz12H1gOqOnuURCWc8dfSygcbVuBeyeJvIUrQPWCcKCPvbLwU8AB2XGtEd5DVd
 urSjjDTsfQ5j3vYqnu/OJNfR+sJpQeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726745801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN3IQqa64vRMg4h+Wr7zWchzJEAtuQ/fyQe/maW3neY=;
 b=MF26RqvoK/i6bNrRmqNC/346g1hxKkTB2v1JSqklN/8p6AA0TOCJ5A7XqXlDJtVq2LmPr+
 84j3jVQztcrgksDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e74v4OZh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MF26Rqvo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726745801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN3IQqa64vRMg4h+Wr7zWchzJEAtuQ/fyQe/maW3neY=;
 b=e74v4OZhWn0mQvMb2oI4tfMF3CRwWtwZgkMsLkTdhGkpVC7dokg52SDcc5kU6xbGhg7Jnb
 mqMNjJlLNz12H1gOqOnuURCWc8dfSygcbVuBeyeJvIUrQPWCcKCPvbLwU8AB2XGtEd5DVd
 urSjjDTsfQ5j3vYqnu/OJNfR+sJpQeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726745801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN3IQqa64vRMg4h+Wr7zWchzJEAtuQ/fyQe/maW3neY=;
 b=MF26RqvoK/i6bNrRmqNC/346g1hxKkTB2v1JSqklN/8p6AA0TOCJ5A7XqXlDJtVq2LmPr+
 84j3jVQztcrgksDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D947B13A5F;
 Thu, 19 Sep 2024 11:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 03a2MsgM7GY4GwAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 19 Sep 2024 11:36:40 +0000
Message-ID: <b9231ac0-d4b7-4565-b2aa-5ceff3a7e672@suse.de>
Date: Thu, 19 Sep 2024 13:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix lxvx/stxvx facility check
From: Claudio Fontana <cfontana@suse.de>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240911141651.6914-1-farosas@suse.de>
 <9e6212ca-5c2f-459c-a59d-11fbdb796c07@suse.de>
 <bcdc7a95-09de-4a2e-a45c-aa4a539afc06@suse.de>
Content-Language: en-US
In-Reply-To: <bcdc7a95-09de-4a2e-a45c-aa4a539afc06@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25DDD3389A
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
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

ping, adding Richard.

We will need to include this downstream because of the breakage its lack causes.
It is already reviewed by me, but some TCG maintainer indicating it will be included in some queue would help,

Thanks,

Claudio

On 9/18/24 17:11, Claudio Fontana wrote:
> Adding Ilya FYI.
> 
> Ciao,
> 
> Claudio
> 
> On 9/11/24 18:19, Claudio Fontana wrote:
>> On 9/11/24 16:16, Fabiano Rosas wrote:
>>> The XT check for the lxvx/stxvx instructions is currently
>>> inverted. This was introduced during the move to decodetree.
>>>
>>> From the ISA:
>>>   Chapter 7. Vector-Scalar Extension Facility
>>>   Load VSX Vector Indexed X-form
>>>
>>>   lxvx XT,RA,RB
>>>   if TX=0 & MSR.VSX=0 then VSX_Unavailable()
>>>   if TX=1 & MSR.VEC=0 then Vector_Unavailable()
>>>   ...
>>>   Let XT be the value 32×TX + T.
>>>
>>> The code currently does the opposite:
>>>
>>>     if (paired || a->rt >= 32) {
>>>         REQUIRE_VSX(ctx);
>>>     } else {
>>>         REQUIRE_VECTOR(ctx);
>>>     }
>>>
>>> This was already fixed for lxv/stxv at commit "2cc0e449d1 (target/ppc:
>>> Fix lxv/stxv MSR facility check)", but the indexed forms were missed.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 70426b5bb7 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  target/ppc/translate/vsx-impl.c.inc | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
>>> index 40a87ddc4a..a869f30e86 100644
>>> --- a/target/ppc/translate/vsx-impl.c.inc
>>> +++ b/target/ppc/translate/vsx-impl.c.inc
>>> @@ -2244,7 +2244,7 @@ static bool do_lstxv_PLS_D(DisasContext *ctx, arg_PLS_D *a,
>>>  
>>>  static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool store, bool paired)
>>>  {
>>> -    if (paired || a->rt >= 32) {
>>> +    if (paired || a->rt < 32) {
>>>          REQUIRE_VSX(ctx);
>>>      } else {
>>>          REQUIRE_VECTOR(ctx);
>>
>> Reviewed-by: Claudio Fontana <cfontana@suse.de>
>>
> 
> 


