Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D8AC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 19:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD6Xm-0000Ra-5m; Thu, 08 May 2025 15:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uD6Xk-0000KS-4d
 for qemu-devel@nongnu.org; Thu, 08 May 2025 15:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uD6Xh-0002sj-Rg
 for qemu-devel@nongnu.org; Thu, 08 May 2025 15:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746731063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6VWCa5BJCIoDSSI6KNqQJv3SFohlERCH1fBhRxprs5c=;
 b=Q2935vdEZ6JWIav1FcnRE21R11M4hdzx2yo98jyVI+ZLSLZZVGq6oTdTadYKyuEjxzd279
 I1h/xACx47V+98K7EKcfrbgvC2WRgck4/llHXGePQMirNpQdekxsZgCNBHW8QPmsqxA9dr
 sAex2fkiajdHerW6k4uGycO5cM1OXeI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-MdUtY1_uMOiBeAZSPJApIg-1; Thu, 08 May 2025 15:04:22 -0400
X-MC-Unique: MdUtY1_uMOiBeAZSPJApIg-1
X-Mimecast-MFC-AGG-ID: MdUtY1_uMOiBeAZSPJApIg_1746731062
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7caee990715so399799985a.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 12:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746731061; x=1747335861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VWCa5BJCIoDSSI6KNqQJv3SFohlERCH1fBhRxprs5c=;
 b=R42Stk8zDCQgPrK5L5Do+veLWuS76ixf8cSaMM/LUdO0bTkPOOEKrk3Y5x1kLju5qA
 RtFr1azAU9PRi1DSvT/fD/qAis1ZqisYZPlSxg+u6YaYsaX/Dq94BHqq3CbP8ik1x2S0
 /LPR7P7/XO+4922aNXWuhEIoeiipXk48DC4+LQ1ozDq/38BD1dYrj1xBYh0JXI/NLcBQ
 RdIuGc7wOh0Lc2KH2GCsq3A3aEFIBcpIm+hqEir9zrp73An2+zT9MVw0/JvcBL4Zz/ss
 ZiL9lb+45ENzmAyaUq6fYSQqMGVFwYF+xgm4yjH8vc+UHg/TPgaQ51G1kU82yqcDV+5i
 UwnA==
X-Gm-Message-State: AOJu0YwOl/DfHUCui10ub8a+/VXQT9VB+UH6Zq9/vCXlzy4YnrlGCMvS
 9UrarnyOFDX1B9N+Oc3tnY25fAASKaVBBvAiNVS87iPM+ie51m78SGsMrC5OCcIQcWoQfdNBQhr
 0F3mSnjXO5+wCKnDqOIk6e2EB+QkROOpqtn4gIrglzt+5C4Pg1Sf0
X-Gm-Gg: ASbGnctHE/fkoR/jI+EJlUyPFLdT+DVHeC1iQK9C0Ur08aq8uQU+WTmyYBrCYQ3Bke4
 EoKuQGgxPUVV5pT0bCn29Ern+7GfQ0ivJnXuGa5PzBjbZBWQ3TQ4mtF3NUt2jJ62OMnTzF3ftoo
 aG+DmNTZPizkQmkTyGFAapUSEAMG2P/cGtwLQUBnBAAaAr0X7WB++wt2raO8i/kC0EiKVGu+3zs
 98UfhJgEK2S+5SbDbZtiNk4sMPM7XqI8nhQRYQ/cQzax6SPWybBKOeEYkhqeeR2YMPtFhrXquRn
 fkY=
X-Received: by 2002:a05:620a:d8b:b0:7c5:dcaa:d799 with SMTP id
 af79cd13be357-7cd0114eed3mr102868885a.39.1746731061645; 
 Thu, 08 May 2025 12:04:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcNy64W+ga7Z4pIrWUl44jQz8hmt5CFTWN0/jDXxr9/XcKHtof46FMckZUOvnrdUrnl28Ftw==
X-Received: by 2002:a05:620a:d8b:b0:7c5:dcaa:d799 with SMTP id
 af79cd13be357-7cd0114eed3mr102866885a.39.1746731061330; 
 Thu, 08 May 2025 12:04:21 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00fe6dc4sm26979485a.90.2025.05.08.12.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 12:04:20 -0700 (PDT)
Date: Thu, 8 May 2025 15:04:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v10 2/3] tests/qtest/migration: add postcopy tests with
 multifd
Message-ID: <aB0AMQdPbcdNy_bS@x1.local>
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508122849.207213-3-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 08, 2025 at 05:58:48PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Add new qtests to run postcopy migration with multifd
> channels enabled.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  tests/qtest/migration/compression-tests.c | 18 ++++++++
>  tests/qtest/migration/postcopy-tests.c    | 27 ++++++++++++
>  tests/qtest/migration/precopy-tests.c     | 22 ++++++++++
>  tests/qtest/migration/tls-tests.c         | 50 +++++++++++++++++++++++
>  4 files changed, 117 insertions(+)
> 
> v10:
> - Check 'env->has_uffd' before postcopy test
> 
> v9:
> - https://lore.kernel.org/qemu-devel/20250411114534.3370816-8-ppandit@redhat.com/
> 
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index 41e79f031b..b827665b8e 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -42,6 +42,20 @@ static void test_multifd_tcp_zstd(void)
>      };
>      test_precopy_common(&args);
>  }
> +
> +static void test_multifd_postcopy_tcp_zstd(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
> +        },
> +        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
> +    };
> +
> +    test_precopy_common(&args);
> +}
>  #endif /* CONFIG_ZSTD */
>  
>  #ifdef CONFIG_QATZIP
> @@ -184,6 +198,10 @@ void migration_test_add_compression(MigrationTestEnv *env)
>  #ifdef CONFIG_ZSTD
>      migration_test_add("/migration/multifd/tcp/plain/zstd",
>                         test_multifd_tcp_zstd);
> +    if (env->has_uffd) {
> +        migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
> +                           test_multifd_postcopy_tcp_zstd);
> +    }
>  #endif
>  
>  #ifdef CONFIG_QATZIP
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index 483e3ff99f..eb637f94f7 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -94,6 +94,29 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
>      }
>  }
>  
> +static void test_multifd_postcopy(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        },
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
> +static void test_multifd_postcopy_preempt(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
> +        },
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  void migration_test_add_postcopy(MigrationTestEnv *env)
>  {
>      migration_test_add_postcopy_smoke(env);
> @@ -114,6 +137,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
>              "/migration/postcopy/recovery/double-failures/reconnect",
>              test_postcopy_recovery_fail_reconnect);
>  
> +        migration_test_add("/migration/postcopy/multifd/plain",
> +                           test_multifd_postcopy);
> +        migration_test_add("/migration/postcopy/multifd/preempt/plain",
> +                           test_multifd_postcopy_preempt);
>          if (env->is_x86) {
>              migration_test_add("/migration/postcopy/suspend",
>                                 test_postcopy_suspend);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 87b0a7e8ef..a575791c72 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -34,6 +34,7 @@
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>  
>  static char *tmpfs;
> +static bool postcopy_ram = false;

I may not have followed the whole discussions, but have you tried to avoid
this global?

>  
>  static void test_precopy_unix_plain(void)
>  {
> @@ -538,6 +539,11 @@ static void test_multifd_tcp_cancel(void)
>      migrate_ensure_non_converge(from);
>      migrate_prepare_for_dirty_mem(from);
>  
> +    if (postcopy_ram) {
> +        migrate_set_capability(from, "postcopy-ram", true);
> +        migrate_set_capability(to, "postcopy-ram", true);
> +    }
> +
>      migrate_set_parameter_int(from, "multifd-channels", 16);
>      migrate_set_parameter_int(to, "multifd-channels", 16);
>  
> @@ -579,6 +585,10 @@ static void test_multifd_tcp_cancel(void)
>          return;
>      }
>  
> +    if (postcopy_ram) {
> +        migrate_set_capability(to2, "postcopy-ram", true);
> +    }
> +
>      migrate_set_parameter_int(to2, "multifd-channels", 16);
>  
>      migrate_set_capability(to2, "multifd", true);
> @@ -602,6 +612,13 @@ static void test_multifd_tcp_cancel(void)
>      migrate_end(from, to2, true);
>  }
>  
> +static void test_multifd_postcopy_tcp_cancel(void)
> +{
> +    postcopy_ram = true;
> +    test_multifd_tcp_cancel();
> +    postcopy_ram = false;
> +}
> +
>  static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
>                                           const char *uri, const char *phase)
>  {
> @@ -1189,6 +1206,11 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>                         test_multifd_tcp_uri_none);
>      migration_test_add("/migration/multifd/tcp/plain/cancel",
>                         test_multifd_tcp_cancel);
> +    if (env->has_uffd) {
> +        migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
> +                           test_multifd_postcopy_tcp_cancel);
> +    }
> +
>  #ifdef CONFIG_RDMA
>      migration_test_add("/migration/precopy/rdma/plain",
>                         test_precopy_rdma_plain);
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 72f44defbb..50a07a1c0f 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -395,6 +395,19 @@ static void test_postcopy_recovery_tls_psk(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_multifd_postcopy_recovery_tls_psk(void)
> +{
> +    MigrateCommon args = {
> +        .start_hook = migrate_hook_start_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        },
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  /* This contains preempt+recovery+tls test altogether */
>  static void test_postcopy_preempt_all(void)
>  {
> @@ -409,6 +422,20 @@ static void test_postcopy_preempt_all(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
> +{
> +    MigrateCommon args = {
> +        .start_hook = migrate_hook_start_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
> +        },
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  static void test_precopy_unix_tls_psk(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> @@ -657,6 +684,21 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_multifd_postcopy_tcp_tls_psk_match(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
> +        },
> +        .listen_uri = "defer",
> +        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
>  #ifdef CONFIG_TASN1
>  static void test_multifd_tcp_tls_x509_default_host(void)
>  {
> @@ -774,6 +816,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                             test_postcopy_preempt_tls_psk);
>          migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
>                             test_postcopy_preempt_all);
> +        migration_test_add("/migration/postcopy/multifd/recovery/tls/psk",
> +                           test_multifd_postcopy_recovery_tls_psk);
> +        migration_test_add("/migration/postcopy/multifd/preempt/recovery/tls/psk",
> +                           test_multifd_postcopy_preempt_recovery_tls_psk);
>      }
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/precopy/unix/tls/x509/default-host",
> @@ -805,6 +851,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                         test_multifd_tcp_tls_psk_match);
>      migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
>                         test_multifd_tcp_tls_psk_mismatch);
> +    if (env->has_uffd) {
> +        migration_test_add("/migration/multifd+postcopy/tcp/tls/psk/match",
> +                           test_multifd_postcopy_tcp_tls_psk_match);
> +    }
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
>                         test_multifd_tcp_tls_x509_default_host);
> --
> 2.49.0
> 

-- 
Peter Xu


