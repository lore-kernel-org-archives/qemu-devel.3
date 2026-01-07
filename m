Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C886CD585A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 11:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdRri-0003Pi-GK; Wed, 07 Jan 2026 06:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdRrY-0003P2-LH
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdRrW-0003hV-Cg
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767785880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6Jjvzha3sCghhGu4p/aQhLm4x/ikNHp0yR8Loy0/sA=;
 b=GXXgaXq8Rv7LsLtIUXN9zU7rwiVfqV7/wmKVvj0JMN1v4NIhFQrzW92TfzpwS3vw6pd4Py
 LkBsoJkmsXZgz+GqyzXpvUyhzyQ+qRZgAnmzGOePd1tvHuxhjurZx1ISNsyWuh8x8948iH
 ijJhQpIv/irERyOGmrmCfTx9ED+OBIc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-1FsI7oG8O62AKLahM9QCFg-1; Wed, 07 Jan 2026 06:37:58 -0500
X-MC-Unique: 1FsI7oG8O62AKLahM9QCFg-1
X-Mimecast-MFC-AGG-ID: 1FsI7oG8O62AKLahM9QCFg_1767785878
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so15152945e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 03:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767785877; x=1768390677; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h6Jjvzha3sCghhGu4p/aQhLm4x/ikNHp0yR8Loy0/sA=;
 b=WOIoyRRZh2PoZChVZzO09S+crcm7B74KTaDkK/kIc1ub8wc1OGP4UW1u4UYWENB3Kl
 NeF3AciKZm8MdRM8qinc33WbSj6W5JhjEcjb8HJpuxg75cGNmzV/bC1rHqT4Vg1RtT92
 38UcDGVajvfn5j9op31RUHspJJdC9bB3SjNrRjOGPUWCQZwsotDcE+3+9ezBLv+IDD3H
 9HARIX0nsJZgj+8t/pF7+q1Pb8ZgEjN2JsorYhHTCV048I14sVo+rfwPBxwX4BPwueRV
 9Lju7+opS8swU15mXz13+FVL0Ty2UW2KHvkeVr3Gk+DcaxhEJEgcFJrwRQvg3yz0DAns
 HiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767785877; x=1768390677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6Jjvzha3sCghhGu4p/aQhLm4x/ikNHp0yR8Loy0/sA=;
 b=vPXrRZJ1cq0sQutJpacnQVb2n8IEsWZTK2LyoDY5d9An0Zz3ICwBzxgt8wjm7Pr/it
 kTtZtry/Bj0IcyvrUrCwBqszizeL/JA8hjnOJ56z7tcw8JC+u9a1ayFt5XRdLlUF3LFo
 73zsswbkprY79QydoDitu59vT8u75P7ItaiSj9QCHXwYy7GcjUAUtNhMZhpNaCcTIeTZ
 occUdGulTWHtFLmn3a4UBZiKbqYn+Nr8fK/es2W0zQM7ZxtniVCV6psqaRzl2ecaAkot
 /Bo+YCzat4Qobq15ZnJa3rVJgemP7HYIc5CajpZ8SZQDjLJv+7sH14UB4ATnowRgaayZ
 wWEw==
X-Gm-Message-State: AOJu0Yxrv6MttOLKbzcux/5zR/R+Uh6pmqhTLP6viohXtfCeISnZCDwY
 64XmlZMwoYFpcrtn+VECkqOFgFzWFYnZ4K6/6JVZ9pI2LC93dOYZ9SNzswGb12bMkFSpzFoLvKO
 M8w9yQGcn0wTtxOmifWct1FCLL2+o2ydDbIzkX/LqITXJl9yQpP2hiOSGTfzfn9oqmcsyEVnqG2
 G5L2tNTi0gkql/dTPFEAhQiznab2SRBsA=
X-Gm-Gg: AY/fxX6uxBSp7L1IFEFpGbRhx+jtN7pVwWRtYjcZ03wpezfBjQ8MTjNjBAbxt7hA21r
 6aaz3MyAzqaeiwxC5lZbjfX/nvTILDZ85hXbsEcbLf7emOo1o15/Wl05c9lifsOKtj3EqUT1UCt
 Frl9GMBQdYkiZfyhbll+ZpqPdbzpjtPrR2w7t6774dIr9JchoqX/yOJXdy9aJe/qftXFM=
X-Received: by 2002:a05:600c:83c9:b0:47b:e2a9:2bd9 with SMTP id
 5b1f17b1804b1-47d84b3b719mr27726615e9.31.1767785877595; 
 Wed, 07 Jan 2026 03:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERCi8KAhcoMxFYioFbooiyPdhqlEMacPfRtkolvWRC6PQxGDxC3UYeUin34AVkwurl+zIseHXAbdSQ1JesCso=
X-Received: by 2002:a05:600c:83c9:b0:47b:e2a9:2bd9 with SMTP id
 5b1f17b1804b1-47d84b3b719mr27726255e9.31.1767785877191; Wed, 07 Jan 2026
 03:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-3-peterx@redhat.com>
In-Reply-To: <20260106203320.2110372-3-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 7 Jan 2026 17:07:40 +0530
X-Gm-Features: AQt7F2oV4ReTQSCoOunHFxC8J0o_QQbmVXgY9gnjQT3YUToMSW0fmg6hgE_8laQ
Message-ID: <CAE8KmOz9XtaEY+LMD9CCCR_bMXe04chGHdvuwVqsYRNe+AtUJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/migration-test: Remove
 postcopy_recovery_fail_stage from MigrateCommon
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 7 Jan 2026 at 02:04, Peter Xu <peterx@redhat.com> wrote:
> The parameter can be instead passed into the function.

* It'll help to include - why? pass the parameter instead.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/framework.h      |  6 ++----
>  tests/qtest/migration/framework.c      |  7 ++++---
>  tests/qtest/migration/postcopy-tests.c | 12 ++++--------
>  tests/qtest/migration/tls-tests.c      |  8 ++++----
>  4 files changed, 14 insertions(+), 19 deletions(-)
>
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 0d39bb0d3c..bc6cf6040f 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -228,9 +228,6 @@ typedef struct {
>       * refer to existing ones with live=true), or use live=off by default.
>       */
>      bool live;
> -
> -    /* Postcopy specific fields */
> -    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
>  } MigrateCommon;
>
>  void wait_for_serial(const char *side);
> @@ -243,7 +240,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>  void migrate_end(QTestState *from, QTestState *to, bool test_dest);
>
>  void test_postcopy_common(MigrateCommon *args);
> -void test_postcopy_recovery_common(MigrateCommon *args);
> +void test_postcopy_recovery_common(MigrateCommon *args,
> +                                   PostcopyRecoveryFailStage fail_stage);
>  int test_precopy_common(MigrateCommon *args);
>  void test_file_common(MigrateCommon *args, bool stop_src);
>  void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 4f46cf8629..d7a5ae56f9 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -739,7 +739,8 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to,
>  #endif
>  }
>
> -void test_postcopy_recovery_common(MigrateCommon *args)
> +void test_postcopy_recovery_common(MigrateCommon *args,
> +                                   PostcopyRecoveryFailStage fail_stage)
===
    static void postcopy_recover_fail(QTestState *from, QTestState
*to,
                                       PostcopyRecoveryFailStage stage)
===

* To keep it consistent, maybe we can call the variable 'stage' as above?

>  {
>      QTestState *from, *to;
>      g_autofree char *uri = NULL;
> @@ -784,12 +785,12 @@ void test_postcopy_recovery_common(MigrateCommon *args)
>      wait_for_postcopy_status(to, "postcopy-paused");
>      wait_for_postcopy_status(from, "postcopy-paused");
>
> -    if (args->postcopy_recovery_fail_stage) {
> +    if (fail_stage) {
>          /*
>           * Test when a wrong socket specified for recover, and then the
>           * ability to kick it out, and continue with a correct socket.
>           */
> -        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
> +        postcopy_recover_fail(from, to, fail_stage);
>          /* continue with a good recovery */
>      }
>
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index 7ae4d765d7..13a5759655 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -41,30 +41,26 @@ static void test_postcopy_preempt(char *name, MigrateCommon *args)
>
>  static void test_postcopy_recovery(char *name, MigrateCommon *args)
>  {
> -    test_postcopy_recovery_common(args);
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
>  }
>
>  static void test_postcopy_recovery_fail_handshake(char *name,
>                                                    MigrateCommon *args)
>  {
> -    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY;
> -
> -    test_postcopy_recovery_common(args);
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_RECOVERY);
>  }
>
>  static void test_postcopy_recovery_fail_reconnect(char *name,
>                                                    MigrateCommon *args)
>  {
> -    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH;
> -
> -    test_postcopy_recovery_common(args);
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_CHANNEL_ESTABLISH);
>  }
>
>  static void test_postcopy_preempt_recovery(char *name, MigrateCommon *args)
>  {
>      args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
>
> -    test_postcopy_recovery_common(args);
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
>  }
>
>  static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 6a20c65104..bf0bb06a29 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -385,7 +385,7 @@ static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
>      args->start_hook = migrate_hook_start_tls_psk_match;
>      args->end_hook = migrate_hook_end_tls_psk;
>
> -    test_postcopy_recovery_common(args);
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
>  }
>
>  static void test_multifd_postcopy_recovery_tls_psk(char *name,
> @@ -396,7 +396,7 @@ static void test_multifd_postcopy_recovery_tls_psk(char *name,
>
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>
> -    test_postcopy_recovery_common(args);
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
>  }
>
>  /* This contains preempt+recovery+tls test altogether */
> @@ -407,7 +407,7 @@ static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
>
>      args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
>
> -    test_postcopy_recovery_common(args);
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
>  }
>
>  static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
> @@ -419,7 +419,7 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>      args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
>
> -    test_postcopy_recovery_common(args);
> +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
>  }
>
>  static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)

* Change looks okay otherwise.

Thank you.
---
  - Prasad


