Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E24CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FLP-0005xO-BG; Mon, 29 Sep 2025 10:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3FLK-0005x1-S4
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:59:10 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3FLI-0007vR-IG
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:59:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 220AE35D2E;
 Mon, 29 Sep 2025 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759157946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b80V9wVYxyB/QQOikv1qs6S6oWVkWvyP+LlkK55ZGUk=;
 b=c+TjsEHKvj+UB5Yq0zW0pHNOd/6wGipKD8uJalfyIS9VFT5CI2U4hbusB9kg7w2D/fEtFP
 bgbIQTjorqeISDYWtt3QXTFJObaMTOvcYDmH0V7xDgu/3D4da/+DE8TjeLpPRazJwLTD4b
 Hus6l1wuO3CBR1J90p3vXGWJ+srxhFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759157946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b80V9wVYxyB/QQOikv1qs6S6oWVkWvyP+LlkK55ZGUk=;
 b=j9pF/lz4TyuTFXHYasgvT8Dd5IzGIB7kYLvFErDwotZ+9DV5m14kfVFardLYH/97s/6bOk
 8K3vviDHCVww25Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759157946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b80V9wVYxyB/QQOikv1qs6S6oWVkWvyP+LlkK55ZGUk=;
 b=c+TjsEHKvj+UB5Yq0zW0pHNOd/6wGipKD8uJalfyIS9VFT5CI2U4hbusB9kg7w2D/fEtFP
 bgbIQTjorqeISDYWtt3QXTFJObaMTOvcYDmH0V7xDgu/3D4da/+DE8TjeLpPRazJwLTD4b
 Hus6l1wuO3CBR1J90p3vXGWJ+srxhFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759157946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b80V9wVYxyB/QQOikv1qs6S6oWVkWvyP+LlkK55ZGUk=;
 b=j9pF/lz4TyuTFXHYasgvT8Dd5IzGIB7kYLvFErDwotZ+9DV5m14kfVFardLYH/97s/6bOk
 8K3vviDHCVww25Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9132113782;
 Mon, 29 Sep 2025 14:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +5PNE7me2mjfOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Sep 2025 14:59:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 05/11] tests/qtest: qtest_init_after_exec
In-Reply-To: <1758291153-349744-6-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-6-git-send-email-steven.sistare@oracle.com>
Date: Mon, 29 Sep 2025 11:59:02 -0300
Message-ID: <87seg5uwy1.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Define a function to create a QTestState object representing the state
> of QEMU after old QEMU exec's new QEMU.  This is needed for testing
> the cpr-exec migration mode.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  tests/qtest/libqtest.h |  8 ++++++++
>  tests/qtest/libqtest.c | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index a164f58..ce6b9b0 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -57,6 +57,14 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
>  const char *qtest_qemu_binary(const char *var);
>  
>  /**
> + * qtest_init_after_exec:
> + * @from: the previous QEMU state

qts is the term used in libqtest. I'll amend it myself.

> + *
> + * Return a test state representing new QEMU after @from exec's it.
> + */
> +QTestState *qtest_init_after_exec(QTestState *from);
> +
> +/**
>   * qtest_qemu_args:
>   * @extra_args: Other arguments to pass to QEMU.
>   *
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index d97144e..3522d75 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -615,6 +615,25 @@ QTestState *qtest_init_ext(const char *var, const char *extra_args,
>      return s;
>  }
>  
> +static QTestState *qtest_attach_qemu(const char *qemu_bin,
> +                                     const char *extra_args,
> +                                     void *opaque)
> +{
> +    int pid = *(int *)opaque;
> +    return qtest_create_test_state(pid);
> +}
> +
> +QTestState *qtest_init_after_exec(QTestState *from)
> +{
> +    void *opaque = (void *)&from->qemu_pid;
> +    QTestState *s;
> +
> +    s = qtest_init_internal(NULL, NULL, true, qtest_attach_qemu, opaque);
> +    from->qemu_pid = -1;
> +    qtest_qmp_handshake(s, NULL);
> +    return s;
> +}
> +
>  QTestState *qtest_init(const char *extra_args)
>  {
>      return qtest_init_ext(NULL, extra_args, NULL, true);

