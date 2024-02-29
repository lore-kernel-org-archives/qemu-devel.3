Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0220EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rficd-0008Pz-4I; Thu, 29 Feb 2024 10:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rficZ-0008PO-5Q
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:46:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rficW-00034R-5E
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:46:54 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DB841F7F9;
 Thu, 29 Feb 2024 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709221609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgpRTV863yfrDW3IoVMPAmBqhzf7j9E3e5u0jsE/hDw=;
 b=JgLuERsCYY0rGhb5QAnZaqYq34f7gL7eWokdpyk/59yVxukiMFTJWNw6M7I27qHUrUrPcP
 818riDb/3Qef9//PfEz3fNiSJfCUuzqOX2SFLdeCr2OoQa1CEfxceReCfNdqqWe7qd/q6a
 +xZfg8di9rXZgDfvCXqlY1UC4+3jg0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709221609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgpRTV863yfrDW3IoVMPAmBqhzf7j9E3e5u0jsE/hDw=;
 b=eqPIoXBhk9Nc0oqD80+UiqKdczJiYNY1UJZUbQK9SG9Xnrm4ZtuecasIRVMy2LZi53gBZo
 PlB9e7NmvF4UlPAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709221609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgpRTV863yfrDW3IoVMPAmBqhzf7j9E3e5u0jsE/hDw=;
 b=JgLuERsCYY0rGhb5QAnZaqYq34f7gL7eWokdpyk/59yVxukiMFTJWNw6M7I27qHUrUrPcP
 818riDb/3Qef9//PfEz3fNiSJfCUuzqOX2SFLdeCr2OoQa1CEfxceReCfNdqqWe7qd/q6a
 +xZfg8di9rXZgDfvCXqlY1UC4+3jg0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709221609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgpRTV863yfrDW3IoVMPAmBqhzf7j9E3e5u0jsE/hDw=;
 b=eqPIoXBhk9Nc0oqD80+UiqKdczJiYNY1UJZUbQK9SG9Xnrm4ZtuecasIRVMy2LZi53gBZo
 PlB9e7NmvF4UlPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D514413503;
 Thu, 29 Feb 2024 15:46:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vguQJuim4GViNAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:46:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, eblake@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v3 2/7] migration/multifd: Implement zero
 page transmission on the multifd thread.
In-Reply-To: <87a5nju8ro.fsf@pond.sub.org>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-3-hao.xiang@bytedance.com>
 <871q8w29zx.fsf@pond.sub.org>
 <CAAYibXgdaH_=JxswvKaz9qaXRFuRncmkrrSpkqSMbFu=3ypfLQ@mail.gmail.com>
 <87a5nju8ro.fsf@pond.sub.org>
Date: Thu, 29 Feb 2024 12:46:46 -0300
Message-ID: <87h6hrz315.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 BAYES_HAM(-3.00)[100.00%];
 R_RATELIMIT(0.00)[to_ip_from(RLhqagydafxgxrmodn9uzmj73y)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWELVE(0.00)[14];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,huawei.com,nongnu.org];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> Hao Xiang <hao.xiang@bytedance.com> writes:
>
>> On Wed, Feb 28, 2024 at 1:50=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>>
>>> Hao Xiang <hao.xiang@bytedance.com> writes:
>>>
>>> > 1. Add zero_pages field in MultiFDPacket_t.
>>> > 2. Implements the zero page detection and handling on the multifd
>>> > threads for non-compression, zlib and zstd compression backends.
>>> > 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
>>> > 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
>>> > 5. Adds zero page counters and updates multifd send/receive tracing
>>> > format to track the newly added counters.
>>> >
>>> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>>>
>>> [...]
>>>
>>> > diff --git a/qapi/migration.json b/qapi/migration.json
>>> > index 1e66272f8f..5a1bb8ad62 100644
>>> > --- a/qapi/migration.json
>>> > +++ b/qapi/migration.json
>>> > @@ -660,10 +660,13 @@
>>> >  #
>>> >  # @legacy: Perform zero page checking from main migration thread.
>>> >  #
>>> > +# @multifd: Perform zero page checking from multifd sender thread.
>>> > +#
>>> >  # Since: 9.0
>>> > +#
>>> >  ##
>>> >  { 'enum': 'ZeroPageDetection',
>>> > -  'data': [ 'none', 'legacy' ] }
>>> > +  'data': [ 'none', 'legacy', 'multifd' ] }
>>> >
>>> >  ##
>>> >  # @BitmapMigrationBitmapAliasTransform:
>>>
>>> What happens when you set "zero-page-detection": "multifd" *without*
>>> enabling multifd migration?
>>
>> Very good question! Right now the behavior is that if "multifd
>> migration" is not enabled, it goes through the legacy code path and
>> the "multifd zero page" option is ignored. The legacy path has its own
>> zero page checking and will run the same way as before. This is for
>> backward compatibility.
>
> We need one of two improvements then:
>
> 1. Make "zero-page-detection" reject value "multifd" when multifd
>    migration is not enabled.  Document this: "Requires migration
>    capability @multifd" or similar.
>
> 2. Document that "multifd" means multifd only when multifd is enabled,
>    else same as "legacy".
>
> I prefer 1., because it's easier to document.  But migration maintainers
> may have their own preference.  Peter, Fabiano?

I think we need to go with 2 for consistency with the other multifd_*
parameters. I don't see any validation at options.c.

