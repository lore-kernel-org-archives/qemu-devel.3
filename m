Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26404CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 15:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqwKt-0004BZ-5A; Wed, 18 Sep 2024 11:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1sqwKr-00049C-JP; Wed, 18 Sep 2024 11:11:17 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1sqwKp-00032l-Pm; Wed, 18 Sep 2024 11:11:17 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DAF4322882;
 Wed, 18 Sep 2024 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726672273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2n1MkzXK7dljcVd1Lkol9q11Lc0CuOxmnky3vXAuoQ=;
 b=t7+nkE7zzu13xUXLGCiTtN+TwFy0Gda21SdXK5urrj147RdneP6OEskMAk1IgPjEERQG30
 C/LkIocHfcrdzv/pCUnmDd+vLYAGkQAZ7LyoiVW2n5fK0R1NcDO2IkpHQmuVQ+ug45kcIJ
 hIdprSSZoKbSQFk/iD8f9by7LQuup/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726672273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2n1MkzXK7dljcVd1Lkol9q11Lc0CuOxmnky3vXAuoQ=;
 b=cXAVnJA21dXv0la9F6mDtWYHVr1oZh9vKFVkK/5t7NK2XO24SOXXipJ1CgoOycCTK4BRct
 trtbqKrV8RQ+UYDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726672272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2n1MkzXK7dljcVd1Lkol9q11Lc0CuOxmnky3vXAuoQ=;
 b=zoXgN0GxZ9eagwn+drpUFEHw7JdK0sfdSRcvunbTW9rclw06Z9zRxhJ4iH2ZGpXCPK4wBb
 b1/IQAcbFkay+W5bFIB2BB1S6qORjJaTIeTrFfbOY/cZLo2pgZ1mbUMaJmUerACWIdzTWX
 Om47Y2pK3BvHv3+dQ/RtOMPl1JKhtDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726672272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2n1MkzXK7dljcVd1Lkol9q11Lc0CuOxmnky3vXAuoQ=;
 b=FIJbAkNApgbIRMKm6ZgBcCm1Uavpj4xMftVetmJLRATFpwcFgFN3zZl8K8cbZCnZztF9nM
 h3IwDM18iwtkB2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98C5913508;
 Wed, 18 Sep 2024 15:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8I9NI5Dt6ma9WAAAD6G6ig
 (envelope-from <cfontana@suse.de>); Wed, 18 Sep 2024 15:11:12 +0000
Message-ID: <bcdc7a95-09de-4a2e-a45c-aa4a539afc06@suse.de>
Date: Wed, 18 Sep 2024 17:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix lxvx/stxvx facility check
From: Claudio Fontana <cfontana@suse.de>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240911141651.6914-1-farosas@suse.de>
 <9e6212ca-5c2f-459c-a59d-11fbdb796c07@suse.de>
Content-Language: en-US
In-Reply-To: <9e6212ca-5c2f-459c-a59d-11fbdb796c07@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[nongnu.org,gmail.com];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Adding Ilya FYI.

Ciao,

Claudio

On 9/11/24 18:19, Claudio Fontana wrote:
> On 9/11/24 16:16, Fabiano Rosas wrote:
>> The XT check for the lxvx/stxvx instructions is currently
>> inverted. This was introduced during the move to decodetree.
>>
>> From the ISA:
>>   Chapter 7. Vector-Scalar Extension Facility
>>   Load VSX Vector Indexed X-form
>>
>>   lxvx XT,RA,RB
>>   if TX=0 & MSR.VSX=0 then VSX_Unavailable()
>>   if TX=1 & MSR.VEC=0 then Vector_Unavailable()
>>   ...
>>   Let XT be the value 32×TX + T.
>>
>> The code currently does the opposite:
>>
>>     if (paired || a->rt >= 32) {
>>         REQUIRE_VSX(ctx);
>>     } else {
>>         REQUIRE_VECTOR(ctx);
>>     }
>>
>> This was already fixed for lxv/stxv at commit "2cc0e449d1 (target/ppc:
>> Fix lxv/stxv MSR facility check)", but the indexed forms were missed.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 70426b5bb7 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  target/ppc/translate/vsx-impl.c.inc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
>> index 40a87ddc4a..a869f30e86 100644
>> --- a/target/ppc/translate/vsx-impl.c.inc
>> +++ b/target/ppc/translate/vsx-impl.c.inc
>> @@ -2244,7 +2244,7 @@ static bool do_lstxv_PLS_D(DisasContext *ctx, arg_PLS_D *a,
>>  
>>  static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool store, bool paired)
>>  {
>> -    if (paired || a->rt >= 32) {
>> +    if (paired || a->rt < 32) {
>>          REQUIRE_VSX(ctx);
>>      } else {
>>          REQUIRE_VECTOR(ctx);
> 
> Reviewed-by: Claudio Fontana <cfontana@suse.de>
> 


