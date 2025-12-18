Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B79D6E2BF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 17:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWHl1-0000aU-EM; Thu, 18 Dec 2025 12:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWHkw-0000Zn-Ca
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 12:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWHku-0001t3-2E
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 12:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766078734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9LqEQZLypetkJDQTTtA+Qnu3qzCMl8/IZ4G/dH9EoI=;
 b=Ja5bjkcqw7MJhVdybaRyzdSBrBlwcstNu6+2lkYClAPtle8yDjHlbo7T9e5XFgpzHYWsS7
 nyNPyyqXqx4rsrkMCg6UIErDCkhvUhnhExvvrR1DJFRzWMHRxXwf80Z957jOLk8UM4mhoI
 4Vk83j2JNRRCypX3YfiRzvfx3bu1y7A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-ID4UVXSxO-GGDrgCnDlvaQ-1; Thu, 18 Dec 2025 12:25:32 -0500
X-MC-Unique: ID4UVXSxO-GGDrgCnDlvaQ-1
X-Mimecast-MFC-AGG-ID: ID4UVXSxO-GGDrgCnDlvaQ_1766078729
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b6963d1624so200018385a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766078729; x=1766683529; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K9LqEQZLypetkJDQTTtA+Qnu3qzCMl8/IZ4G/dH9EoI=;
 b=KebADqk9vQmpYnbHTvUKvGBSJ3ZAdwWr1Eadw4cAbpLKroFG1tALRWF/w5oGXKpzvo
 fB0YY7qcwz/rXMrFdisk4vGf4PxVEGrgSfjGKxZ7oh5Ik4OnAF9OlDIzSQKljLhWdr/Z
 lDeh6ReQSyF/SZYqtyynnkd6APvhKKESa1OJ1k6ro8IlN6tyKZSfGjKmxqHt1AhNajTf
 uVtS9ZK2CAwb+PJqX3Yy33kkqlwDpnc8e5VfClDxqWaGWtLS4f867Yw8v7WKcgmAlTwg
 ETfEYrBcYC2MLSB986uYD7sV6wwgIqih49OFPeMFCKcEHOtv7gc5HFJIvcfOXHVwzS+t
 NEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078729; x=1766683529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9LqEQZLypetkJDQTTtA+Qnu3qzCMl8/IZ4G/dH9EoI=;
 b=RmP11of/Dm/Pm9jdBvpnA06PoKkzCIcmqV2ChP7L+h0u9jtxLzr5LOR/6a6AAj87Jh
 Bw9f6MkwGzp87t7OmhQAk5QNPnW2rgGbOFciUzUOGUD0gWROoa+r4ZGEbq8yf+gAIMg0
 yLkfnYt1xOX8LYVZfG6zOeujwGqSyV1U1BsmOuC82UhW5qXwASrFi6yLa++jF/J+ylFF
 DBrmNR/GWHVVOkGOxiFXW1ETSmbQ9+CfASRypWE9tqwDqG6JZshhh9DKszBXWN5nCq/e
 OGHwS6A3wvrCKMQAd3iI73F7gwcZGWN3FmyObAUtJ+bpn3/eqbXiEZaAaAn9wGk0zvKP
 Sylg==
X-Gm-Message-State: AOJu0Yxsy28vrl/1HWOyx/1RV0IL835K6Sd6RUi7avQQnjeaRxt0PHDJ
 xK6EGIyVgP02lYCwdsjFhHK0YeN02RKZfuW0/klNXlYTSsPWu6h3nBkeOXgV4OZOdfKWPDHrpIY
 7gnPJzIgsUoMN2ox3/WmhPFFX1yZWgmAYQMIyLQbdJ5TI6u7i9yt/MjZE
X-Gm-Gg: AY/fxX44itkvEX3+IXmwyn5/O9uuCCYejq1trBy7TK63tscqK9QoKDsoH4xikgTvA3X
 PhY7bo0chB0SV5fTNJq82OUkGEwvA+QWYqmSzHU38ODpsoJXAOyn4RAhsiEWuKkYRO6nfmUVZJz
 02H2XSXZb82YxI+7+F5aTU8WBlk+4ELgUYUb3pFXbho8xlMJF7XrFfGnLqbn2Sf+qVlZuvRzIT7
 mrlSKRRKMxL2ZJISYDiicZS/7FnAFmAT/pG/yrUxsZNy8/XEGLIxSjTFuqUVo0c0XZAiLe0raay
 SIVi+OIfW2q2YWv4N/tL8cDsopDLdWv7pKLT7AeVuTNUPvnbstwZMj5Tv/f6iUz93eGxOQh5fLS
 iAEg=
X-Received: by 2002:a05:620a:1794:b0:892:9838:b16a with SMTP id
 af79cd13be357-8c08fabfeabmr60051785a.59.1766078728989; 
 Thu, 18 Dec 2025 09:25:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvRgoa2c76zq9SUFQUlM95YTKj44Dz6RPilh2Y4Y5DsRyNwkOJ0KnyFB2aZg6A+TEBmgbk4A==
X-Received: by 2002:a05:620a:1794:b0:892:9838:b16a with SMTP id
 af79cd13be357-8c08fabfeabmr60047585a.59.1766078728473; 
 Thu, 18 Dec 2025 09:25:28 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8beeb6e987asm207296185a.22.2025.12.18.09.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:25:27 -0800 (PST)
Date: Thu, 18 Dec 2025 12:25:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 32/51] tests/qtest/migration: Adapt convergence
 routines to config
Message-ID: <aUQ5BoCrMXk2SJDC@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-33-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-33-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Dec 15, 2025 at 07:00:18PM -0300, Fabiano Rosas wrote:
> Adapt the convergence routines migrate_ensure_[non_]converge to set
> the convergence parameters in the config dict it instead of using
> migrate-set-parameters.
> 
> Some tests need to change the convergence parameters during the
> migration. The config object method is specific to configuration prior
> to starting a migration, so by design it's not suitable to effect
> migration-runtime changes. The existing routines will be kept for this
> purpose (renamed with 'ongoing' for clarity).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/framework.c     | 10 ++++-----
>  tests/qtest/migration/migration-qmp.c | 32 +++++++++++++++++++++++++--
>  tests/qtest/migration/migration-qmp.h |  6 +++--
>  tests/qtest/migration/misc-tests.c    |  4 ++--
>  tests/qtest/migration/precopy-tests.c | 26 +++++++++-------------
>  5 files changed, 52 insertions(+), 26 deletions(-)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index fd15bd832e..df42a8a2c6 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -583,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>          args->postcopy_data = args->start_hook(from, to);
>      }
>  
> -    migrate_ensure_non_converge(from);
> +    migrate_ensure_non_converge(from, args->start.config);
>      migrate_prepare_for_dirty_mem(from);
>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>                               "  'arguments': { "
> @@ -872,7 +872,7 @@ int test_precopy_common(MigrateCommon *args)
>      }
>  
>      if (args->live) {
> -        migrate_ensure_non_converge(from);
> +        migrate_ensure_non_converge(from, args->start.config);
>          migrate_prepare_for_dirty_mem(from);
>      } else {
>          /*
> @@ -884,7 +884,7 @@ int test_precopy_common(MigrateCommon *args)
>          if (args->result == MIG_TEST_SUCCEED) {
>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
>              wait_for_stop(from, &src_state);
> -            migrate_ensure_converge(from);
> +            migrate_ongoing_ensure_converge(from);
>          }
>      }
>  
> @@ -942,7 +942,7 @@ int test_precopy_common(MigrateCommon *args)
>              }
>              migrate_wait_for_dirty_mem(from, to);
>  
> -            migrate_ensure_converge(from);
> +            migrate_ongoing_ensure_converge(from);
>  
>              /*
>               * We do this first, as it has a timeout to stop us
> @@ -1047,7 +1047,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
>          data_hook = args->start_hook(from, to);
>      }
>  
> -    migrate_ensure_converge(from);
> +    migrate_ensure_converge(from, args->start.config);
>      wait_for_serial("src_serial");
>  
>      if (stop_src) {
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index 5c46ceb3e6..7fe47a5793 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -499,20 +499,48 @@ void migrate_set_parameter_bool(QTestState *who, const char *parameter,
>      migrate_check_parameter_bool(who, parameter, value);
>  }
>  
> -void migrate_ensure_non_converge(QTestState *who)
> +void migrate_ongoing_ensure_non_converge(QTestState *who)
>  {
>      /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
>      migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
>      migrate_set_parameter_int(who, "downtime-limit", 1);
>  }
>  
> -void migrate_ensure_converge(QTestState *who)
> +void migrate_ongoing_ensure_converge(QTestState *who)
>  {
>      /* Should converge with 30s downtime + 1 gbs bandwidth limit */
>      migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
>      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
>  }
>  
> +void migrate_ensure_non_converge(QTestState *who, QDict *config)
> +{
> +    config = config_load(config);
> +    if (config) {
> +        /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> +        qdict_put_int(config, "max-bandwidth", 3 * 1000 * 1000);
> +        qdict_put_int(config, "downtime-limit", 1);
> +    } else {
> +        assert(who);
> +        migrate_ongoing_ensure_non_converge(who);
> +    }
> +    config_put(config);
> +}
> +
> +void migrate_ensure_converge(QTestState *who, QDict *config)
> +{
> +    config = config_load(config);
> +    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> +    if (config) {
> +        qdict_put_int(config, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> +        qdict_put_int(config, "downtime-limit", 30 * 1000);
> +    } else {
> +        assert(who);
> +        migrate_ongoing_ensure_converge(who);
> +    }
> +    config_put(config);
> +}

It's slightly an overkill to me to have these converge helpers to provide
two versions.  Also a bit confusing on when should we use which.

After all, parameters touched on convergence must be able to be dynamically
set..

Can we always stick with the QMP set-parameters for all these?

> +
>  void migrate_pause(QTestState *who)
>  {
>      qtest_qmp_assert_success(who, "{ 'execute': 'migrate-pause' }");
> diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
> index 9a36a677ba..e465c69094 100644
> --- a/tests/qtest/migration/migration-qmp.h
> +++ b/tests/qtest/migration/migration-qmp.h
> @@ -39,8 +39,10 @@ void migrate_set_parameter_strv(QTestState *who, const char *parameter,
>  void migrate_set_parameter_null(QTestState *who, const char *parameter);
>  void migrate_set_parameter_bool(QTestState *who, const char *parameter,
>                                  int value);
> -void migrate_ensure_non_converge(QTestState *who);
> -void migrate_ensure_converge(QTestState *who);
> +void migrate_ongoing_ensure_non_converge(QTestState *who);
> +void migrate_ongoing_ensure_converge(QTestState *who);
> +void migrate_ensure_non_converge(QTestState *who, QDict *config);
> +void migrate_ensure_converge(QTestState *who, QDict *config);
>  void migrate_pause(QTestState *who);
>  void migrate_continue(QTestState *who, const char *state);
>  void migrate_recover(QTestState *who, const char *uri);
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 61bdfda857..0a737cb54f 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -68,7 +68,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
>      file = g_strdup_printf("%s/migfile", tmpfs);
>      uri = g_strdup_printf("exec:cat > %s", file);
>  
> -    migrate_ensure_converge(from);
> +    migrate_ensure_converge(from, args->start.config);
>      migrate_qmp(from, to, uri, NULL, "{}");
>      wait_for_migration_complete(from);
>  
> @@ -102,7 +102,7 @@ static void test_ignore_shared(char *name, MigrateCommon *args)
>          return;
>      }
>  
> -    migrate_ensure_non_converge(from);
> +    migrate_ensure_non_converge(from, args->start.config);
>      migrate_prepare_for_dirty_mem(from);
>  
>      /* Wait for the first serial output from the source */
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index ab5789717f..eabbbf39c3 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -374,7 +374,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
>       * Set the initial parameters so that the migration could not converge
>       * without throttling.
>       */
> -    migrate_ensure_non_converge(from);
> +    migrate_ensure_non_converge(from, args->start.config);
>  
>      /* To check remaining size after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);
> @@ -427,7 +427,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
>      g_assert_cmpint(hit, ==, 1);
>  
>      /* Now, when we tested that throttling works, let it converge */
> -    migrate_ensure_converge(from);
> +    migrate_ongoing_ensure_converge(from);
>  
>      /*
>       * Wait for pre-switchover status to check last throttle percentage
> @@ -562,7 +562,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
>          return;
>      }
>  
> -    migrate_ensure_non_converge(from);
> +    migrate_ensure_non_converge(from, args->start.config);
>      migrate_prepare_for_dirty_mem(from);
>  
>      if (postcopy_ram) {
> @@ -623,14 +623,12 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
>      /* Start incoming migration from the 1st socket */
>      migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
>  
> -    migrate_ensure_non_converge(from);
> +    migrate_ensure_non_converge(from, args->start.config);
>  
>      migrate_qmp(from, to2, NULL, NULL, "{}");
>  
>      migrate_wait_for_dirty_mem(from, to2);
> -
> -    migrate_ensure_converge(from);
> -
> +    migrate_ongoing_ensure_converge(from);
>      wait_for_stop(from, get_src());
>      qtest_qmp_eventwait(to2, "RESUME");
>  
> @@ -659,7 +657,7 @@ static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
>       */
>  
>      wait_for_serial("src_serial");
> -    migrate_ensure_converge(from);
> +    migrate_ensure_converge(from, args->config);
>  
>      migrate_qmp(from, to, uri, NULL, "{}");
>  
> @@ -684,7 +682,7 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
>      migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>  
>      wait_for_serial("src_serial");
> -    migrate_ensure_converge(from);
> +    migrate_ensure_converge(from, args->config);
>  
>      migrate_qmp(from, to, uri, NULL, "{}");
>  
> @@ -709,7 +707,7 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
>      migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>  
>      wait_for_serial("src_serial");
> -    migrate_ensure_converge(from);
> +    migrate_ensure_converge(from, args->config);
>  
>      migrate_qmp(from, to, uri, NULL, "{}");
>  
> @@ -739,7 +737,7 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
>  
>      migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>  
> -    migrate_ensure_converge(from);
> +    migrate_ensure_converge(from, args->config);
>      migrate_qmp(from, to, uri, NULL, "{}");
>  
>      wait_for_migration_complete(from);
> @@ -759,7 +757,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
>      migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>  
>      wait_for_serial("src_serial");
> -    migrate_ensure_converge(from);
> +    migrate_ensure_converge(from, args->config);
>  
>      migrate_qmp(from, to, uri, NULL, "{}");
>  
> @@ -1066,9 +1064,6 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
>      migrate_set_parameter_int(from, "x-vcpu-dirty-limit-period", period);
>      migrate_set_parameter_int(from, "vcpu-dirty-limit", value);
>  
> -    /* Make sure migrate can't converge */
> -    migrate_ensure_non_converge(from);
> -
>      /* To check limit rate after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);
>  
> @@ -1128,6 +1123,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
>      }
>  
>      /* Prepare for dirty limit migration and wait src vm show up */
> +    migrate_ensure_non_converge(from, args->start.config);
>      migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
>  
>      /* Start migrate */
> -- 
> 2.51.0
> 

-- 
Peter Xu


