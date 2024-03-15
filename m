Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22920C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 17:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlBCm-00061B-3N; Fri, 15 Mar 2024 13:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rlBCk-00060t-P1; Fri, 15 Mar 2024 13:18:50 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rlBCj-0004z5-4v; Fri, 15 Mar 2024 13:18:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F2D41FB76;
 Fri, 15 Mar 2024 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710523123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGWtaRiMDysWe3rSBY5RWEQ52fm1eJuar54PWZmTxVQ=;
 b=tVv4Im/X54COKjzTgWOWGP/N/uC9CcuwyQi79r1izdJfejdxJ82ssz02uv6sJ8eACkZHvr
 y5EQrGDSqzV/SSTs+t1BykBu72iZ7LMkYWNg5wdYOfpPNh9j75G8z6C1uCTseqwWYOc6qy
 X1DdFFbwD77tebYA159cSw7X5Ka2EfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710523123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGWtaRiMDysWe3rSBY5RWEQ52fm1eJuar54PWZmTxVQ=;
 b=UBQNXHBVJn6xl1N4xSNg7LTXsRP0Nl9Xsz/i3Xln0xbrxb9YTogay9+Mg1vvQfdWCY0zdn
 h+EuXblMpYVfodCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710523123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGWtaRiMDysWe3rSBY5RWEQ52fm1eJuar54PWZmTxVQ=;
 b=tVv4Im/X54COKjzTgWOWGP/N/uC9CcuwyQi79r1izdJfejdxJ82ssz02uv6sJ8eACkZHvr
 y5EQrGDSqzV/SSTs+t1BykBu72iZ7LMkYWNg5wdYOfpPNh9j75G8z6C1uCTseqwWYOc6qy
 X1DdFFbwD77tebYA159cSw7X5Ka2EfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710523123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGWtaRiMDysWe3rSBY5RWEQ52fm1eJuar54PWZmTxVQ=;
 b=UBQNXHBVJn6xl1N4xSNg7LTXsRP0Nl9Xsz/i3Xln0xbrxb9YTogay9+Mg1vvQfdWCY0zdn
 h+EuXblMpYVfodCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B9A1368C;
 Fri, 15 Mar 2024 17:18:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id efDuAvOC9GULdwAAD6G6ig
 (envelope-from <cfontana@suse.de>); Fri, 15 Mar 2024 17:18:43 +0000
Message-ID: <5cbf8c4e-2741-6e52-c245-62fe1c50f22a@suse.de>
Date: Fri, 15 Mar 2024 18:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] target/s390x: improve cpu compatibility check error
 message
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240314213746.27163-1-cfontana@suse.de>
 <6ce770d49082d4a2b42bcf71200521ca58dc4ed5.camel@linux.ibm.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <6ce770d49082d4a2b42bcf71200521ca58dc4ed5.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tVv4Im/X";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UBQNXHBV
X-Rspamd-Queue-Id: 8F2D41FB76
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.686,
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

On 3/15/24 17:59, Nina Schoetterl-Glausch wrote:
> On Thu, 2024-03-14 at 22:37 +0100, Claudio Fontana wrote:
>> some users were confused by this message showing under TCG:
>>
>> Selected CPU generation is too new. Maximum supported model
>> in the configuration: 'xyz'
>>
>> Clarify that the maximum can depend on the accel, and add a
>> hint to try a different one.
>>
>> Also add a hint for features mismatch to suggest trying
>> different accel, QEMU and kernel versions.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> 
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> 
>> ---
>>  target/s390x/cpu_models.c | 22 +++++++++++++++-------
>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 1a1c096122..8ed3bb6a27 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -500,6 +500,16 @@ static void error_prepend_missing_feat(const char *name, void *opaque)
>>      error_prepend((Error **) opaque, "%s ", name);
>>  }
>>  
>> +static void check_compat_model_failed(Error **errp,
>> +                                      const S390CPUModel *max_model,
>> +                                      const char *msg)
>> +{
>> +    error_setg(errp, "%s. Maximum supported model in the current configuration: \'%s\'",
>> +               msg, max_model->def->name);
>> +    error_append_hint(errp, "Consider a different accelerator, try \"-accel help\"\n");
>> +    return;
>> +}
>> +
>>  static void check_compatibility(const S390CPUModel *max_model,
>>                                  const S390CPUModel *model, Error **errp)
>>  {
>> @@ -507,15 +517,11 @@ static void check_compatibility(const S390CPUModel *max_model,
>>      S390FeatBitmap missing;
>>  
>>      if (model->def->gen > max_model->def->gen) {
>> -        error_setg(errp, "Selected CPU generation is too new. Maximum "
>> -                   "supported model in the configuration: \'%s\'",
>> -                   max_model->def->name);
>> +        check_compat_model_failed(errp, max_model, "Selected CPU generation is too new");
>>          return;
>>      } else if (model->def->gen == max_model->def->gen &&
>>                 model->def->ec_ga > max_model->def->ec_ga) {
>> -        error_setg(errp, "Selected CPU GA level is too new. Maximum "
>> -                   "supported model in the configuration: \'%s\'",
>> -                   max_model->def->name);
>> +        check_compat_model_failed(errp, max_model, "Selected CPU GA level is too new");
>>          return;
>>      }
>>  
>> @@ -537,7 +543,9 @@ static void check_compatibility(const S390CPUModel *max_model,
>>      error_setg(errp, " ");
>>      s390_feat_bitmap_to_ascii(missing, errp, error_prepend_missing_feat);
>>      error_prepend(errp, "Some features requested in the CPU model are not "
>> -                  "available in the configuration: ");
>> +                  "available in the current configuration: ");
>> +    error_append_hint(errp,
>> +                      "Consider a different accelerator, QEMU, or kernel version\n");
> 
> If I'm reading the regex right, this ^, a string literal on a separate line, is excluded
> from the line length check.

Thanks, it's very good to know!

Claudio
> 
>>  }
>>  
>>  S390CPUModel *get_max_cpu_model(Error **errp)
> 


