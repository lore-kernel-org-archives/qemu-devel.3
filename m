Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B088CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FFZ-0002pR-W4; Mon, 29 Sep 2025 10:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3FFT-0002le-J5
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:53:08 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3FFQ-0006sd-KA
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:53:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74B99330A7;
 Mon, 29 Sep 2025 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759157580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZCOQbrGvl2MqPX2JPOWM9EOXmeKGAX8uVM0N3kINSY=;
 b=H1laD3aVdshHeWbT4JdjBk/hV3rS4S+eiMeljgFgUr3b6kXX4ctNDeZLwIoNxWftPzMSe8
 rjLd8m9vpg/BkYh6qODPTgfmfAWSdk+BUkqbzOZxMYYSL/zyZRaF34y0rA7lx5cdfd83ux
 fs2t9RocnbvNlKWex4YmXigjWKv0nuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759157580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZCOQbrGvl2MqPX2JPOWM9EOXmeKGAX8uVM0N3kINSY=;
 b=wd/R6yNkYAb1tbuxn+QADjm1hgaH6VW1O7y9ISPpToC9S/Sqvr56OgbpKXmXsw8fF0gNsB
 8A0hSg8ipNaOcEBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759157580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZCOQbrGvl2MqPX2JPOWM9EOXmeKGAX8uVM0N3kINSY=;
 b=H1laD3aVdshHeWbT4JdjBk/hV3rS4S+eiMeljgFgUr3b6kXX4ctNDeZLwIoNxWftPzMSe8
 rjLd8m9vpg/BkYh6qODPTgfmfAWSdk+BUkqbzOZxMYYSL/zyZRaF34y0rA7lx5cdfd83ux
 fs2t9RocnbvNlKWex4YmXigjWKv0nuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759157580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZCOQbrGvl2MqPX2JPOWM9EOXmeKGAX8uVM0N3kINSY=;
 b=wd/R6yNkYAb1tbuxn+QADjm1hgaH6VW1O7y9ISPpToC9S/Sqvr56OgbpKXmXsw8fF0gNsB
 8A0hSg8ipNaOcEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBAE413782;
 Mon, 29 Sep 2025 14:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JC2/JUud2mgbOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Sep 2025 14:52:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 03/11] tests/qtest: qtest_create_test_state
In-Reply-To: <1758291153-349744-4-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-4-git-send-email-steven.sistare@oracle.com>
Date: Mon, 29 Sep 2025 11:52:57 -0300
Message-ID: <87y0pxux86.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Refactor qtest_spawn_qemu and create a subroutine to create a QTestState
> object, to be used in a subsequent patch.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tests/qtest/libqtest.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 551bc8c..3fa9317 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -409,22 +409,29 @@ static pid_t qtest_create_process(char *cmd)
>  }
>  #endif /* _WIN32 */
>  
> -static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
> +static QTestState *qtest_create_test_state(int pid)
>  {
>      QTestState *s = g_new0(QTestState, 1);
> +
> +    s->qemu_pid = pid;
> +    qtest_add_abrt_handler(kill_qemu_hook_func, s);
> +    return s;
> +}
> +
> +static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
> +{
> +    int pid;
>      g_autoptr(GString) command = g_string_new("");
>  
>      g_string_printf(command, CMD_EXEC "%s %s", qemu_bin, args);
>  
> -    qtest_add_abrt_handler(kill_qemu_hook_func, s);
> -
>      if (!silence_spawn_log) {
>          g_test_message("starting QEMU: %s", command->str);
>      }
>  
>  #ifndef _WIN32
> -    s->qemu_pid = fork();
> -    if (s->qemu_pid == 0) {
> +    pid = fork();
> +    if (pid == 0) {
>  #ifdef __linux__
>          /*
>           * Although we register a ABRT handler to kill off QEMU
> @@ -447,10 +454,10 @@ static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
>          exit(1);
>      }
>  #else
> -    s->qemu_pid = qtest_create_process(command->str);
> +    pid = qtest_create_process(command->str);
>  #endif /* _WIN32 */
>  
> -    return s;
> +    return qtest_create_test_state(pid);
>  }
>  
>  static char *qtest_socket_path(const char *suffix)

Reviewed-by: Fabiano Rosas <farosas@suse.de>

