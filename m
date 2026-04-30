Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB83FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISUV-0000UX-Vz; Thu, 30 Apr 2026 10:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wISUU-0000R1-1j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:35:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wISUS-00022w-99
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:35:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A9BF65BCD0;
 Thu, 30 Apr 2026 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777559741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=voPji9+VosrFZjXlE6itOyMjHu0TJciUUjLNKI9xpvo=;
 b=IOIpd6f5LGZGlr5zoE5Z8aE7ZA3dLVsny0tzsJYvTUG3o9PamH8hHkMmkcKl60RK42mG7B
 v37sCH0eWXEd9iuAPWbjwIDmBmB44GwTuDjACfM2wL6SunGElwYt4wc0oYmQBhZn9uNRFh
 KAkUFu+tRK4Rcd2mzRSqbYTvo21vN8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777559741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=voPji9+VosrFZjXlE6itOyMjHu0TJciUUjLNKI9xpvo=;
 b=cdKvfUyEw0RY5tik7rnnbN3Ufs8WCtkcPtImVNGSEVgISn8VfTqOfy7be6Lsi+vgXAW4Q7
 lbJEbdB/GzqPYfDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777559741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=voPji9+VosrFZjXlE6itOyMjHu0TJciUUjLNKI9xpvo=;
 b=IOIpd6f5LGZGlr5zoE5Z8aE7ZA3dLVsny0tzsJYvTUG3o9PamH8hHkMmkcKl60RK42mG7B
 v37sCH0eWXEd9iuAPWbjwIDmBmB44GwTuDjACfM2wL6SunGElwYt4wc0oYmQBhZn9uNRFh
 KAkUFu+tRK4Rcd2mzRSqbYTvo21vN8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777559741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=voPji9+VosrFZjXlE6itOyMjHu0TJciUUjLNKI9xpvo=;
 b=cdKvfUyEw0RY5tik7rnnbN3Ufs8WCtkcPtImVNGSEVgISn8VfTqOfy7be6Lsi+vgXAW4Q7
 lbJEbdB/GzqPYfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46367593B0;
 Thu, 30 Apr 2026 14:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EszeBb1o82kueQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 30 Apr 2026 14:35:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/3] tests/qtest/libqtest: Replace QTEST_TRACE with
 QTEST_QEMU_ARGS
In-Reply-To: <CAFEAcA_5hpKE3t07+NqjXWnhwAiRCBugt1DirJ+2-bq4r657jg@mail.gmail.com>
References: <20260429003130.15164-1-farosas@suse.de>
 <20260429003130.15164-2-farosas@suse.de>
 <CAFEAcA_5hpKE3t07+NqjXWnhwAiRCBugt1DirJ+2-bq4r657jg@mail.gmail.com>
Date: Thu, 30 Apr 2026 11:35:35 -0300
Message-ID: <87wlxoplc8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 29 Apr 2026 at 01:32, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> The QTEST_TRACE environment variable allows for any QEMU command line
>> option to be passed if used like so:
>>
>> export QTEST_TRACE="-trace tracepoint -more -opts -here"
>>
>> Formalize that usage by accepting a new QTEST_QEMU_ARGS
>> variable. Since the QTEST_TRACE now becomes redundant, remove its
>> usage.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/libqtest.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 051faf31e1..a580d75179 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -454,11 +454,9 @@ gchar *qtest_qemu_args(const char *extra_args)
>>  {
>>      g_autofree gchar *socket_path = qtest_socket_path("sock");
>>      g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
>> -    const char *trace = g_getenv("QTEST_TRACE");
>> -    g_autofree char *tracearg = trace ? g_strdup_printf("-trace %s ", trace) :
>> -                                        g_strdup("");
>> +    const char *args_from_env = g_getenv("QTEST_QEMU_ARGS");
>> +
>>      gchar *args = g_strdup_printf(
>> -                      "%s"
>>                        "-qtest unix:%s "
>>                        "-qtest-log %s "
>>                        "-chardev socket,path=%s,id=char0 "
>> @@ -466,16 +464,17 @@ gchar *qtest_qemu_args(const char *extra_args)
>>                        "-display none "
>>                        "-audio none "
>>                        "%s"
>> +                      "%s "
>>                        "%s"
>>                        " -accel qtest",
>>
>> -                      tracearg,
>>                        socket_path,
>>                        getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
>>                        qmp_socket_path,
>>                        can_exit_with_parent() ?
>>                        "-run-with exit-with-parent=on " : "",
>> -                      extra_args ?: "");
>> +                      extra_args ?: "",
>> +                      args_from_env ?: "");
>
> Maybe we should have all those "%s" consistently be "%s "
> (and drop the trailing space in the "-run-with exit-with-parent=on "
> string and the leading one in " -accel qtest")?
>

Yep, I'll fix it.

At some point I'll figure out how to integrate this qgraph thing with
the rest of qtest so we can build command lines in a cleaner way.

> Sometimes we might get an extra space we don't technically
> need in the command line, but on the other hand we would be able
> to look at the format string and see at a glance that it
> definitely doesn't potentially run one argument into the next
> without having to cross-check all the %s with the arguments,
> and the arguments would consistently always be just strings
> with no requirement to bring along a leading or trailing space.
>
> But either way
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM

