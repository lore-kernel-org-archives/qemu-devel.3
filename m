Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38897CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMckI-00015C-TZ; Fri, 21 Nov 2025 20:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vMbU2-0006yo-TF
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:28:12 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vMbTr-0003pa-GC
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:28:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A257E21A14;
 Fri, 21 Nov 2025 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763750301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBav5TuA4Fqrr6eQjjhiog9gWxCNywki8J3VYY0+BFM=;
 b=ovGWBc++T8rBpcK0J4eJ/SULbDLcUssL9zfmsVLNuz5+Fb2Qx/6avzH/xRDWi2ZzJSUigY
 FBdx2t/WcHyhGZ4Fs1DSs0idXI7OwjryvTTpbZZAV/qB/CrXEyYLMlIyd+8uLSfAMcYEA8
 uCXgv+PQyP7G3W7BZQq34Io1bbv8CUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763750301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBav5TuA4Fqrr6eQjjhiog9gWxCNywki8J3VYY0+BFM=;
 b=p0bpfwWzAnBYFSXdYOISRLC76jKzJhQLgn1Drvbeanrq/UDyCEPE8DNjllP2Zh7GsoAjhM
 OLjxPoNla3tnYCCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ovGWBc++;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p0bpfwWz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763750301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBav5TuA4Fqrr6eQjjhiog9gWxCNywki8J3VYY0+BFM=;
 b=ovGWBc++T8rBpcK0J4eJ/SULbDLcUssL9zfmsVLNuz5+Fb2Qx/6avzH/xRDWi2ZzJSUigY
 FBdx2t/WcHyhGZ4Fs1DSs0idXI7OwjryvTTpbZZAV/qB/CrXEyYLMlIyd+8uLSfAMcYEA8
 uCXgv+PQyP7G3W7BZQq34Io1bbv8CUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763750301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBav5TuA4Fqrr6eQjjhiog9gWxCNywki8J3VYY0+BFM=;
 b=p0bpfwWzAnBYFSXdYOISRLC76jKzJhQLgn1Drvbeanrq/UDyCEPE8DNjllP2Zh7GsoAjhM
 OLjxPoNla3tnYCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2218B3EA61;
 Fri, 21 Nov 2025 18:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LsYDNZyxIGncBgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Nov 2025 18:38:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] qtest: Allow and ignore blank lines in input
In-Reply-To: <20251106151959.1088095-1-peter.maydell@linaro.org>
References: <20251106151959.1088095-1-peter.maydell@linaro.org>
Date: Fri, 21 Nov 2025 15:38:17 -0300
Message-ID: <87zf8fdyee.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A257E21A14
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.14 / 50.00]; BAYES_HAM(-2.63)[98.36%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim,linaro.org:email];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim,linaro.org:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> Currently the code that reads the qtest protocol commands insists
> that every input line has a command.  If it receives a line with
> nothing but whitespace it will trip an assertion in
> qtest_process_command().
>
> This is a little awkward for the case where we are feeding qtest a
> set of bug-reproduction commands via standard input or a file,
> because it means you need to be careful not to leave a blank line at
> the start or the end when cutting and pasting the command sequence
> from a bug report.
>
> Change the code to allow and ignore blank lines in the input.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  system/qtest.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/system/qtest.c b/system/qtest.c
> index e4d1cd75daa..baef06d4d1b 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -69,6 +69,9 @@ static void *qtest_server_send_opaque;
>   * so clients should always handle many async messages before the response
>   * comes in.
>   *
> + * Extra ASCII space characters in command inputs are permitted and ignored.
> + * Lines containing only spaces are permitted and ignored.
> + *
>   * Valid requests
>   * ^^^^^^^^^^^^^^
>   *
> @@ -367,7 +370,11 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>          fprintf(qtest_log_fp, "\n");
>      }
>  
> -    g_assert(command);
> +    if (!command) {
> +        /* Input line was blank: ignore it */
> +        return;
> +    }
> +
>      if (strcmp(words[0], "irq_intercept_out") == 0
>          || strcmp(words[0], "irq_intercept_in") == 0) {
>          DeviceState *dev;

Reviewed-by: Fabiano Rosas <farosas@suse.de>

Queued

