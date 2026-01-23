Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66940D74EC9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjH1E-00062i-LO; Fri, 23 Jan 2026 08:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjH0k-0005yl-Fo
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:15:43 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjH0i-0000fe-IY
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:15:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 646765BCD3;
 Fri, 23 Jan 2026 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769174134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9hRY2w0EjzvxnJ0S3Oi4Vy8xQKDGixCZkyd7iqIHX8=;
 b=ijlY1jI+6Io6oVRTLJCSQNUH0N6t5gvx9HinhLnBb2ggk54f1SA7ZOltvEgA8JWoV8Kym4
 S2pavyq3MRxlibAsf9w5aftC8NIGhVs1thJU9S7thn1Wucqh1Ie3h3HW1qx6+iRDT+7jfs
 sIBjjjSR8oCGLHwEFzkOVj4Romu9dVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769174134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9hRY2w0EjzvxnJ0S3Oi4Vy8xQKDGixCZkyd7iqIHX8=;
 b=3Rv+s1/w90I+/yNnXL/gafQJTdJrDvLEu5L7/WkjVVfFGNP4SnSfUkJ/xYdajQYBo5z22J
 4d22oB5TLryx8YDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ijlY1jI+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3Rv+s1/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769174134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9hRY2w0EjzvxnJ0S3Oi4Vy8xQKDGixCZkyd7iqIHX8=;
 b=ijlY1jI+6Io6oVRTLJCSQNUH0N6t5gvx9HinhLnBb2ggk54f1SA7ZOltvEgA8JWoV8Kym4
 S2pavyq3MRxlibAsf9w5aftC8NIGhVs1thJU9S7thn1Wucqh1Ie3h3HW1qx6+iRDT+7jfs
 sIBjjjSR8oCGLHwEFzkOVj4Romu9dVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769174134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9hRY2w0EjzvxnJ0S3Oi4Vy8xQKDGixCZkyd7iqIHX8=;
 b=3Rv+s1/w90I+/yNnXL/gafQJTdJrDvLEu5L7/WkjVVfFGNP4SnSfUkJ/xYdajQYBo5z22J
 4d22oB5TLryx8YDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC3F8136AA;
 Fri, 23 Jan 2026 13:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vjQWI3V0c2kzXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 13:15:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/options: Fix leaks in StrOrNull accessors
In-Reply-To: <CAE8KmOwWhtTHSh=cbDS7CsgEKS7tf4+HRcJ8ax3Qfnxqgn-YyQ@mail.gmail.com>
References: <20260122232456.12722-1-farosas@suse.de>
 <CAE8KmOyAYnB8a-AsZvjCFGrX+xwbCjV3Wv2ybVLoBQu7RofOqA@mail.gmail.com>
 <87fr7wjz9v.fsf@suse.de>
 <CAE8KmOwWhtTHSh=cbDS7CsgEKS7tf4+HRcJ8ax3Qfnxqgn-YyQ@mail.gmail.com>
Date: Fri, 23 Jan 2026 10:15:31 -0300
Message-ID: <87v7gsii6k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 646765BCD3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Fri, 23 Jan 2026 at 17:51, Fabiano Rosas <farosas@suse.de> wrote:
>> >> diff --git a/migration/options.c b/migration/options.c
>> >> index 9a5a39c886..9dc44a3736 100644
>> >> --- a/migration/options.c
>> >> +++ b/migration/options.c
>> >> @@ -225,6 +225,7 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>> >>          str_or_null = g_new0(StrOrNull, 1);
>> >>          str_or_null->type = QTYPE_QSTRING;
>> >>          str_or_null->u.s = g_strdup("");                 <== [1]
>> >> +        *ptr = str_or_null;
>> >>      } else {
>> >>          /* the setter doesn't allow QNULL */
>> >>          assert(str_or_null->type != QTYPE_QNULL);
>> >> @@ -245,6 +246,7 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>> >>       */
>> >>      str_or_null->type = QTYPE_QSTRING;
>> >
>> > * Do we need to add:  str_or_null->u.s = g_strdup("");  here?
>>
>> It would leak, the visitor will allocate new memory for it below.
>
> * Then do we need to remove it from get_StrOrNull()?  <== [1] above.
>

The visitor behaves differently depending on the direction
(input/output), the getter is providing a new object with a default
empty string.

>> I'd rather leave to the caller. The errp will be set, I think it's
>> enough. Looking at the other instances of visit_type_str in qdev, they
>> all simply return without any handling. I think in practice it's
>> unlikely that the string visitors will ever set errp because they are
>> just a g_strdup() usually.
>
> * Hmmn, okay. Coverity reported a leak for it in set_StrOrNull(), not
> other places?
>

Well, the setter is slightly different because this property is a
wrapper that contains a string, so the string visitor in the setter can
(in theory) fail and that would indeed leak (the outer object's
memory). But the other properties are returning the string directly,
without any extra memory allocation so, as in this getter, they simply
return on (the theoretical) failure.

IOW, there is nothing to leak in the other setters and the other
getters, on failure leave the caller to deal with the memory that was
already allocated.

Now, I just double-checked and what I said in the previous email is not
entirely accurate:

  "I think in practice it's unlikely that the string visitors will ever
  set errp because they are just a g_strdup() usually." -- me

the input visitor can actually set errp, but it does so before
allocating the string.

> Thank you.
> ---
>   - Prasad

