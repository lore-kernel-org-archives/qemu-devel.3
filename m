Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1584C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 15:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhV2N-0003y6-Bu; Thu, 31 Jul 2025 11:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhTkh-0002bo-Sy
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:55:23 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhTkf-0007Bw-JB
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:55:23 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FF3921295;
 Thu, 31 Jul 2025 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753970117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q6yfoBB9DIsLT7orlvMuFlUpf/w8raFJ6nGhcyejcao=;
 b=ZLXogax08NdhYCPWOeGwV26aV7Twilu/bSF1InKnHAvjbpVO+4wM+TxDvYypnqavDwxxJQ
 k1RabR7x0hh9LTFoLyvrVhW0hL0rkAyiVICaeBuSYFwman1+ll/hgV2HWh5m/Rx9tzX9ow
 w/deS/WeO/E6rHHVtvrlLICoQEcloR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753970117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q6yfoBB9DIsLT7orlvMuFlUpf/w8raFJ6nGhcyejcao=;
 b=kd1LOEpaJVwqld7JZ3sZooxUpvrKIrUs9IWQu1VLc8kEGbmVx8DJSsYNUwwR0ANMNr7o59
 qYKdFqUWbELAHwDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753970117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q6yfoBB9DIsLT7orlvMuFlUpf/w8raFJ6nGhcyejcao=;
 b=ZLXogax08NdhYCPWOeGwV26aV7Twilu/bSF1InKnHAvjbpVO+4wM+TxDvYypnqavDwxxJQ
 k1RabR7x0hh9LTFoLyvrVhW0hL0rkAyiVICaeBuSYFwman1+ll/hgV2HWh5m/Rx9tzX9ow
 w/deS/WeO/E6rHHVtvrlLICoQEcloR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753970117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q6yfoBB9DIsLT7orlvMuFlUpf/w8raFJ6nGhcyejcao=;
 b=kd1LOEpaJVwqld7JZ3sZooxUpvrKIrUs9IWQu1VLc8kEGbmVx8DJSsYNUwwR0ANMNr7o59
 qYKdFqUWbELAHwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E689713A43;
 Thu, 31 Jul 2025 13:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qG/iKcR1i2jcdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 31 Jul 2025 13:55:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 3/3] tests/qtest/migration: Change cpu for aarch64
In-Reply-To: <20250731110326.00000140@huawei.com>
References: <20250730205245.2118-1-farosas@suse.de>
 <20250730205245.2118-4-farosas@suse.de>
 <20250731110326.00000140@huawei.com>
Date: Thu, 31 Jul 2025 10:55:14 -0300
Message-ID: <875xf84g8t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Jonathan Cameron via <qemu-devel@nongnu.org> writes:

> On Wed, 30 Jul 2025 17:52:45 -0300
> Fabiano Rosas <farosas@suse.de> wrote:
>
>> Don't use the 'max' cpu for migration testing of aarch64. That cpu
>> does not provide a stable set of features and is expected to break
>> migration from time to time.
>
> Whilst I can see the motivation, doesn't this leave us with a lack of
> converage for new CPU features that are currently only in max?

It does. That's an interesting aspect. It's better to make sure the new
features come with at least some basic migration support off the gate.

I'll add a patch to this series leaving one of the tests with -cpu
max. That should be enough to cover this scenario.

Thanks

>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration/framework.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>> index f09365d122..6d980b6b51 100644
>> --- a/tests/qtest/migration/framework.c
>> +++ b/tests/qtest/migration/framework.c
>> @@ -317,7 +317,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>          memory_size = "150M";
>>          machine_alias = "virt";
>>          machine_opts = "gic-version=3";
>> -        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>> +        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
>>          start_address = ARM_TEST_MEM_START;
>>          end_address = ARM_TEST_MEM_END;
>>      } else {

