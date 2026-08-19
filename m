Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DB0C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgw8-0003qQ-Lr; Wed, 19 Aug 2026 10:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1wwgvy-0003py-K2; Wed, 19 Aug 2026 10:06:28 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1wwgvx-00066S-0a; Wed, 19 Aug 2026 10:06:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C707484B87;
 Wed, 19 Aug 2026 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787148377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r46tzNMKqVrw2CsgVDC0FPkrfr3v61Yt/ErkI07wI8M=;
 b=mFYHvgBrXC97t9mRRHD1HEW7sE4Fx0Gkgazc1l0KReqk7KJLRctHbcyYBZEYSG8QbAp4nv
 oR6nQVNMI/9j/baAw5Bb01MTMWwFrwIRmw1viE6NlR7lF6mWijwCyQF0jUKVNRreAVgeIK
 qwZNRjU6PEe/XrjRVI5S3uvDIvdF9as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787148377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r46tzNMKqVrw2CsgVDC0FPkrfr3v61Yt/ErkI07wI8M=;
 b=3UlWoSIMoGSDjfwtKwwSIa3tgCVXllGftAPK41gwpt3rgHZWrx6bKObYK/zzgvIPohmxWn
 7OYGxdf97rj1+7AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787148373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r46tzNMKqVrw2CsgVDC0FPkrfr3v61Yt/ErkI07wI8M=;
 b=tWF9AZr25J3BMG4glLHjTTYTYWjyabJr2QT/UFcaWnB5sayE2owJFiFqbw9BDtSuFV+NMd
 J4f4DH1vM7X9uyu6WGEjBBWTHj6DFwPbOn3euZvCRvnmcvUbMICJyt5tyPA7KFTr8GbC6S
 g9fzt6EwE8ZQQZhdbX036KYdsIVxDSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787148373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r46tzNMKqVrw2CsgVDC0FPkrfr3v61Yt/ErkI07wI8M=;
 b=Gn8Y8YT3yaJEUO27TcuXiHIwDXy7e9yugEWoNaNHGZxnBSlNMokVwlLl+wygCTxH4+ymzy
 OASW7N0a2Kw/6xBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 668872F81;
 Wed, 19 Aug 2026 14:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 31YoDlW4hWqBbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Aug 2026 14:06:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Tao Tang <tangtao1634@phytium.com.cn>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>, Chao
 Liu <chao.liu@processmission.com>, Jim MacArthur
 <jim.macarthur@linaro.org>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v5 3/5] tests/qtest: Add raw command response helper
In-Reply-To: <20260814035628.3924513-4-tangtao1634@phytium.com.cn>
References: <20260814035628.3924513-1-tangtao1634@phytium.com.cn>
 <20260814035628.3924513-4-tangtao1634@phytium.com.cn>
Date: Wed, 19 Aug 2026 11:06:11 -0300
Message-ID: <87wltmkxws.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,phytium.com.cn:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 phytium.com.cn:email, suse.de:email, suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Tao Tang <tangtao1634@phytium.com.cn> writes:

> Split raw qtest response tokenization and qtest_raw_cmd() from the
> memory attributes helpers so this protocol support can be reviewed
> independently.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  tests/qtest/libqtest.c | 27 +++++++++++++++++++++++++--
>  tests/qtest/libqtest.h | 13 +++++++++++++
>  2 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 453d0dddd09..37aa69e1297 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -746,11 +746,10 @@ static GString *qtest_client_socket_recv_line(QTestState *s)
>      return line;
>  }
>  
> -static gchar **qtest_rsp_args(QTestState *s, int expected_args)
> +static gchar **qtest_rsp_words(QTestState *s)
>  {
>      GString *line;
>      gchar **words;
> -    int i;
>  
>  redo:
>      line = s->ops.recv_line(s);
> @@ -780,6 +779,15 @@ redo:
>      }
>  
>      g_assert(words[0] != NULL);
> +
> +    return words;
> +}
> +
> +static gchar **qtest_rsp_args(QTestState *s, int expected_args)
> +{
> +    gchar **words = qtest_rsp_words(s);
> +    int i;
> +
>      g_assert_cmpstr(words[0], ==, "OK");
>  
>      for (i = 0; i < expected_args; i++) {
> @@ -789,6 +797,21 @@ redo:
>      return words;
>  }
>  
> +gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
> +{
> +    va_list ap;
> +    gchar *str;
> +
> +    va_start(ap, fmt);
> +    str = g_strdup_vprintf(fmt, ap);
> +    va_end(ap);
> +
> +    s->ops.send(s, str);
> +    g_free(str);
> +
> +    return qtest_rsp_words(s);
> +}
> +
>  static void qtest_rsp(QTestState *s)
>  {
>      gchar **words = qtest_rsp_args(s, 0);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 7c0b239e5b5..715c363de30 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -239,6 +239,19 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
>  void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>      G_GNUC_PRINTF(2, 3);
>  
> +/**
> + * qtest_raw_cmd:
> + * @s: #QTestState instance to operate on.
> + * @fmt: raw qtest protocol text to send, formatted like sprintf().
> + *
> + * Sends a raw qtest command and returns the response split on spaces.
> + * The response is not required to start with ``OK``; callers can inspect
> + * ``args[0]`` for ``OK``, ``ERR``, or ``FAIL`` and must free the returned
> + * vector with g_strfreev().
> + */
> +gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
> +    G_GNUC_PRINTF(2, 3);
> +
>  /**
>   * qtest_socket_server:
>   * @socket_path: the UNIX domain socket path

Reviewed-by: Fabiano Rosas <farosas@suse.de>

