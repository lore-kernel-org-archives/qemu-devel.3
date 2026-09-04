Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EEFC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2VXI-0002g4-CV; Fri, 04 Sep 2026 11:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2VXH-0002fF-2Q
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:08:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2VXF-0001ka-5Q
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:08:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4342520398;
 Fri,  4 Sep 2026 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788534531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yR/zF7xQUqL2IezJ5t5YUwUGRoJ9AK1Qh9ZIojktQg=;
 b=glO4i/G1/HbWr6f2dFEJJzjrl1Sti/lHZjH/u+UfTWKtioklqHKM6NetAGAdvQsg7dqk4w
 vd4uoag4WugYBTRjl4oz1Tkv8pcUqwUNJ/ZYg9dx/5FAVl5Emrw7/i4dbTb9+tnuq7eLTM
 S+NBgQeQq6ggLqOe3N9Pyi9hPQpHnAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788534531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yR/zF7xQUqL2IezJ5t5YUwUGRoJ9AK1Qh9ZIojktQg=;
 b=GzI9oRhbuXbU5wMAlAXZTsefHdNm5SxDJDeK9inzu30A9map8tq6fjIs11PX45AORBCs7W
 Fx+Ra17lCn7JT5Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788534527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yR/zF7xQUqL2IezJ5t5YUwUGRoJ9AK1Qh9ZIojktQg=;
 b=Wwk1Sa4Qyx6HB0C02qse8yD7s92sUAwyDLeYq26Wn/rnKhdQ/0NY9NaxIdc78JOtGySsib
 SC0cwhEQHZZDpTdswah5ZuPrKRX8Po8thb+lIHe3QIOadiaHPErENsLU3xUSZLPt4hlJYY
 S7qJpIOh+rClrkj3tNYgX/qn4z+YKwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788534527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yR/zF7xQUqL2IezJ5t5YUwUGRoJ9AK1Qh9ZIojktQg=;
 b=9PSIVF+ypLBebVTX7OJ0SaZTIcnw6DOb2RwZZJ45THTDpiUiKCiEEZgjLXRqDqpqjerVig
 8dwUI04tqBUsIjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC69E13736;
 Fri,  4 Sep 2026 15:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2i+rHP7emmpwcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Sep 2026 15:08:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 13/18] migration: Use output visitor in info command
In-Reply-To: <aprbiKXh1WyHCWpN@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-14-farosas@suse.de> <apqzsh7pIkmKTYYg@x1.local>
 <87zexx6sn2.fsf@suse.de> <aprbiKXh1WyHCWpN@x1.local>
Date: Fri, 04 Sep 2026 12:08:40 -0300
Message-ID: <87o6ed6olj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> On Fri, Sep 04, 2026 at 10:41:21AM -0300, Fabiano Rosas wrote:
>> >> +    case QTYPE_QBOOL: {
>> >> +        QBool *b = qobject_to(QBool, obj);
>> >> +        if (b) {
>> >
>> > Similarly, I'd drop "if" if it will always happen, making qbool_get_bool()
>> > assert itself by deref.
>> >
>> 
>> I'd rather not have such asserts in user-facing code. Even with testing,
>> it's hard to ensure this 'obj' will reach here in integrity.
>
> Not a big deal here, but just for sake of pure discussion..
>
> IMHO it's not the "user triggerable path" that we are avoiding assert()s,
> but user input that may affect the result of the assert().
>

In this case, there should be none, agreed.

> Here if we just checked obj type is QTYPE_QBOOL, I can't see anything that
> can make this if not true.
>

Thanks for saying it explicitly, I wasn't seeing the obvious redundancy
there. You're right, I'll remove the checks.

> I still think assert() good guarding programming errors.  Say, if something
> we wanted to print here but skipped, I want it to crash hard, rather than
> silently ignored.

