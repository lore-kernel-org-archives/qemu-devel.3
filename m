Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D856FCE8D76
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 19:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJzwM-0002fW-D2; Fri, 14 Nov 2025 14:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vJzr5-0006p5-PS
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 14:53:14 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vJzr3-00089Y-GZ
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 14:53:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75E96218F9;
 Fri, 14 Nov 2025 19:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763149986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjiabFdUcc9LmbkYc1Li+f9ngy25fg8hINhtpQQx5/w=;
 b=lvLvjlMMTHgr9hA0pOK5yYf+Hv+bzBzVukZuD5lYiwpJc6F4xnOoznFTfzo0eNzcwE7hoa
 xx8NXpnj+2P1J/HvmEtYSe8fILDBfAqlwT1W70yR/2kjAQeV2ht0Vqx3W7aIa85Gk/pg4t
 WYLYwLXfNNFgF1AOr8KC2bx5s8KaOzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763149986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjiabFdUcc9LmbkYc1Li+f9ngy25fg8hINhtpQQx5/w=;
 b=tu5VOrHe0ssmrEnTidP8zzGCVIJlMWwhZOdTTDb/13lrqoL7I+81inqOAzCcBmrxMQYqSQ
 FK/VAy3R/FuJCiCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XDbvqyt0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n1AWirpm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763149985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjiabFdUcc9LmbkYc1Li+f9ngy25fg8hINhtpQQx5/w=;
 b=XDbvqyt0oYHNEeRIl2JwEWZZUBfqBXHLX8KBKv4F9zsjFZ78zu6gxYPL9nt4zV/d+0gQOe
 3gXl+l4DVYUCFA+8kfRTb4anFR7PD3pSqDbNzNn7bGjOLS3XF+FWxwUExbM4v8oW4rspSZ
 t8Y+0vX0NuU2vV+3x0d9zLdJhrsyuA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763149985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjiabFdUcc9LmbkYc1Li+f9ngy25fg8hINhtpQQx5/w=;
 b=n1AWirpmhMLV/cKvwZxHm9cvzDlpqeQ/x3V4h0mh2joLMOAe1vCamfHM518mtTDz3Q/xLf
 3wr+VYAzwMC5qwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E13CE3EA61;
 Fri, 14 Nov 2025 19:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dQ6zJ6CIF2lTLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Nov 2025 19:53:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] system/qtest.c: Allow for multiple CHR_EVENT_CLOSED events
In-Reply-To: <CAFEAcA-ROzqrpb1Z9oR2LF5=YHhM95=Ae2RCsqPH7Yj3CRBwLA@mail.gmail.com>
References: <20251107174306.1408139-1-peter.maydell@linaro.org>
 <CAFEAcA-ROzqrpb1Z9oR2LF5=YHhM95=Ae2RCsqPH7Yj3CRBwLA@mail.gmail.com>
Date: Fri, 14 Nov 2025 16:53:02 -0300
Message-ID: <875xbccrxd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 75E96218F9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Ping for code review?
>
> thanks
> -- PMM
>
> On Fri, 7 Nov 2025 at 17:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> In the qtest_event() QEMUChrEvent handler, we create a timer
>> and log OPENED on CHR_EVENT_OPENED, and we destroy the timer and
>> log CLOSED on CHR_EVENT_CLOSED. However, the chardev subsystem
>> can send us more than one CHR_EVENT_CLOSED if we're reading from
>> a file chardev:
>>  * the first one happens when we read the last data from the file
>>  * the second one happens when the user hits ^C to exit QEMU
>>    and the chardev is finalized: char_fd_finalize()
>>
>> This causes us to call g_timer_elapsed() with a NULL timer
>> (which glib complains about) and print an extra CLOSED log line
>> with a zero timestamp:
>>
>> [I +0.063829] CLOSED
>> qemu-system-aarch64: GLib: g_timer_elapsed: assertion 'timer != NULL' failed
>> [I +0.000000] CLOSED
>>
>> Avoid this by ignoring a CHR_EVENT_CLOSED if we have already
>> processed one.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  system/qtest.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/system/qtest.c b/system/qtest.c
>> index baef06d4d1b..67e2385f4b0 100644
>> --- a/system/qtest.c
>> +++ b/system/qtest.c
>> @@ -815,6 +815,10 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
>>          }
>>          break;
>>      case CHR_EVENT_CLOSED:
>> +        if (!qtest_opened) {
>> +            /* Ignore CLOSED events if we have already closed the log */
>> +            break;
>> +        }
>>          qtest_opened = false;
>>          if (qtest_log_fp) {
>>              fprintf(qtest_log_fp, "[I +" FMT_timeval "] CLOSED\n", g_timer_elapsed(timer, NULL));
>> --
>> 2.43.0

I'm aware some qtest stuff is lingering on the list, I came back from
vacations yesterday and will give attention to it in the next few days.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

