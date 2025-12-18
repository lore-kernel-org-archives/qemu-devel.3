Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B824FD711C3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLEw-0005mI-1X; Thu, 18 Dec 2025 16:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLEu-0005kG-Ax
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLEr-0007cv-4y
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766092123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4DS+/X7pVYn8FrKJVfhsCXH/xyvuE41EWhAFSvrQdo4=;
 b=QNY1UUNSCWbGG4+k8Ybaq9sJeYHjZTV++7koWbTxFIQMrwJ82TZF1cr1JqK3u7xD5n09Va
 7jO79UVw5HiWKyJ7alGkwaQbYm8/k1NAhIKzKf+Xn2WlwzJyHV7EhQWx+RC15RD5i3nUuO
 dHzdNI3cEbNb0CgC1ug48fGwjj6ZLtk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-FKgrhItDOJSnc3rG09y35A-1; Thu, 18 Dec 2025 16:08:41 -0500
X-MC-Unique: FKgrhItDOJSnc3rG09y35A-1
X-Mimecast-MFC-AGG-ID: FKgrhItDOJSnc3rG09y35A_1766092121
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2f0be2cf0so374035885a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766092121; x=1766696921; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4DS+/X7pVYn8FrKJVfhsCXH/xyvuE41EWhAFSvrQdo4=;
 b=jYBI5xh+GeN/x8DF/t7hyuAq1v9NsoDjCabZYNp4j78mb6kz3bOoYeQ0kWnA4BmDI1
 XpQC2Eyhmc6GaGEa5SKMbPjfJVOUy0fylNS4g/f60z/IuRMoeSx9ajuy5pIHnNXX3o04
 fN2rLuSp6E092qrWN9D/6afEK+Dqi/um+MH7l9AVdYJsKuhE04cT6eFuUVnD6S8CIz3H
 kiOlJkKnf/gGnzU+F9JdzDkTaLsE7+9BDHkN6/OxTEylzYiMO9DZKzpy3wR21+XhiDZJ
 NNQ91Ha90ZZIjCfZAqk+PUpj5j+O2yPqLxm3YCFnMRCbdd7yAO1ku+EfL2JPUW1dIZta
 pReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766092121; x=1766696921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DS+/X7pVYn8FrKJVfhsCXH/xyvuE41EWhAFSvrQdo4=;
 b=uLegtADHqpxpYz5wFecpqBWRv5KrIsku2j+ENJVcLiaG4uV0F7tLZ8e3IQVAFnOgP3
 5zHxvSKyEy0NZP+Lpk3Ba8eD56/otVWrCsoZIO6wFamakgxoL9livKn5UIXeXYqZTVoV
 oef7h51EdT4K+UZ/ePySXe+Oyk3F+F9bNdMyr80kcuPB8lUSnIISQEqj39Ak0y0vxA6N
 xed5iBAtO6AOxSEJw7onVT1gxkxFMjAQZjcAIi9cgLVDxA/mUZNxC0BuTiy6adZ5VICl
 oBpLd6eZakOt5JEK7a0BiDpH9kcQh8FdWxyqW4LlE6Hh9axeHvIMjdEUAnVYv/Xq6g+j
 /T2g==
X-Gm-Message-State: AOJu0Yy2qDoLZE62WcEMdiSCPrDUjLvaDnWDCbKw6cRdsiVE62rM+NkT
 o2dykLxSNPv3+AlrDuyC01ZZXxE7QS9zEP8ZwrxQnsEoq59XoPtY6HR/WcD36/Nz/SJQzoDa9t+
 XFhWoff4/MzxZePRs8OmtnaPMCD2XXH+l6cC4R8JNHoLcv1aQVXPHtfvl
X-Gm-Gg: AY/fxX6xEBjYyNcNITwWuZGqkTc4isgGM4kB7E755QQo8BxQ0L5sGIa7IbJANUU2Z5y
 yoTHqUMW+P0Bhj7EMHCNP1ptdDLrLRIiExCxlVuDcbIBIlHe/SaC4RL46bl0GqFyIhTVIcor4vh
 X7vsH6lTiFN2s5r7Av1iPfLJB3MYUlwWM7gu94MjcWzAS05bKj9mfl0hgAYq7pvD6qWpgQBtxvv
 ppAE0pPQz1x42Aa+CC1MqmGR/sorDk85CDlqkDTIMe4Rapa4B2oRjs2LrpT7XCWPytq4ewHwcpt
 Mh09DXGuPXgPr6uY3gg/zOrQvjORs0dFiBM0Fl6tQYokMJYCjJqBLiNRrt+Ew8ZMgtSUuaIXs8e
 +w98=
X-Received: by 2002:a05:620a:4049:b0:8b2:fef0:742d with SMTP id
 af79cd13be357-8c08fa9bd1amr174269085a.7.1766092120788; 
 Thu, 18 Dec 2025 13:08:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEINC4DWwgZTcLNmyG8Cj8AlgHJBQySdY55NVDTCQllMhYiuMyEGTpW/oPd0sC0iI2Igv+9dQ==
X-Received: by 2002:a05:620a:4049:b0:8b2:fef0:742d with SMTP id
 af79cd13be357-8c08fa9bd1amr174263585a.7.1766092120155; 
 Thu, 18 Dec 2025 13:08:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d99d7e926sm3913366d6.42.2025.12.18.13.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 13:08:39 -0800 (PST)
Date: Thu, 18 Dec 2025 16:08:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 32/51] tests/qtest/migration: Adapt convergence
 routines to config
Message-ID: <aURtVveE88n31AN_@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-33-farosas@suse.de>
 <aUQ5BoCrMXk2SJDC@x1.local> <8734571sik.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734571sik.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Dec 18, 2025 at 04:47:47PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Dec 15, 2025 at 07:00:18PM -0300, Fabiano Rosas wrote:
> >> Adapt the convergence routines migrate_ensure_[non_]converge to set
> >> the convergence parameters in the config dict it instead of using
> >> migrate-set-parameters.
> >> 
> >> Some tests need to change the convergence parameters during the
> >> migration. The config object method is specific to configuration prior
> >> to starting a migration, so by design it's not suitable to effect
> >> migration-runtime changes. The existing routines will be kept for this
> >> purpose (renamed with 'ongoing' for clarity).
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration/framework.c     | 10 ++++-----
> >>  tests/qtest/migration/migration-qmp.c | 32 +++++++++++++++++++++++++--
> >>  tests/qtest/migration/migration-qmp.h |  6 +++--
> >>  tests/qtest/migration/misc-tests.c    |  4 ++--
> >>  tests/qtest/migration/precopy-tests.c | 26 +++++++++-------------
> >>  5 files changed, 52 insertions(+), 26 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> >> index fd15bd832e..df42a8a2c6 100644
> >> --- a/tests/qtest/migration/framework.c
> >> +++ b/tests/qtest/migration/framework.c
> >> @@ -583,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
> >>          args->postcopy_data = args->start_hook(from, to);
> >>      }
> >>  
> >> -    migrate_ensure_non_converge(from);
> >> +    migrate_ensure_non_converge(from, args->start.config);
> >>      migrate_prepare_for_dirty_mem(from);
> >>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> >>                               "  'arguments': { "
> >> @@ -872,7 +872,7 @@ int test_precopy_common(MigrateCommon *args)
> >>      }
> >>  
> >>      if (args->live) {
> >> -        migrate_ensure_non_converge(from);
> >> +        migrate_ensure_non_converge(from, args->start.config);
> >>          migrate_prepare_for_dirty_mem(from);
> >>      } else {
> >>          /*
> >> @@ -884,7 +884,7 @@ int test_precopy_common(MigrateCommon *args)
> >>          if (args->result == MIG_TEST_SUCCEED) {
> >>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
> >>              wait_for_stop(from, &src_state);
> >> -            migrate_ensure_converge(from);
> >> +            migrate_ongoing_ensure_converge(from);
> >>          }
> >>      }
> >>  
> >> @@ -942,7 +942,7 @@ int test_precopy_common(MigrateCommon *args)
> >>              }
> >>              migrate_wait_for_dirty_mem(from, to);
> >>  
> >> -            migrate_ensure_converge(from);
> >> +            migrate_ongoing_ensure_converge(from);
> >>  
> >>              /*
> >>               * We do this first, as it has a timeout to stop us
> >> @@ -1047,7 +1047,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
> >>          data_hook = args->start_hook(from, to);
> >>      }
> >>  
> >> -    migrate_ensure_converge(from);
> >> +    migrate_ensure_converge(from, args->start.config);
> >>      wait_for_serial("src_serial");
> >>  
> >>      if (stop_src) {
> >> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> >> index 5c46ceb3e6..7fe47a5793 100644
> >> --- a/tests/qtest/migration/migration-qmp.c
> >> +++ b/tests/qtest/migration/migration-qmp.c
> >> @@ -499,20 +499,48 @@ void migrate_set_parameter_bool(QTestState *who, const char *parameter,
> >>      migrate_check_parameter_bool(who, parameter, value);
> >>  }
> >>  
> >> -void migrate_ensure_non_converge(QTestState *who)
> >> +void migrate_ongoing_ensure_non_converge(QTestState *who)
> >>  {
> >>      /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> >>      migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
> >>      migrate_set_parameter_int(who, "downtime-limit", 1);
> >>  }
> >>  
> >> -void migrate_ensure_converge(QTestState *who)
> >> +void migrate_ongoing_ensure_converge(QTestState *who)
> >>  {
> >>      /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> >>      migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> >>      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> >>  }
> >>  
> >> +void migrate_ensure_non_converge(QTestState *who, QDict *config)
> >> +{
> >> +    config = config_load(config);
> >> +    if (config) {
> >> +        /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> >> +        qdict_put_int(config, "max-bandwidth", 3 * 1000 * 1000);
> >> +        qdict_put_int(config, "downtime-limit", 1);
> >> +    } else {
> >> +        assert(who);
> >> +        migrate_ongoing_ensure_non_converge(who);
> >> +    }
> >> +    config_put(config);
> >> +}
> >> +
> >> +void migrate_ensure_converge(QTestState *who, QDict *config)
> >> +{
> >> +    config = config_load(config);
> >> +    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> >> +    if (config) {
> >> +        qdict_put_int(config, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> >> +        qdict_put_int(config, "downtime-limit", 30 * 1000);
> >> +    } else {
> >> +        assert(who);
> >> +        migrate_ongoing_ensure_converge(who);
> >> +    }
> >> +    config_put(config);
> >> +}
> >
> > It's slightly an overkill to me to have these converge helpers to provide
> > two versions.  Also a bit confusing on when should we use which.
> >
> > After all, parameters touched on convergence must be able to be dynamically
> > set..
> >
> > Can we always stick with the QMP set-parameters for all these?
> >
> 
> Well, QEMU ignores anything set with migrate-set-parameters once it sees
> the config, so we'd need to change that in the code.
> 
> Thinking about the design of "config", I think the point was to never
> configure a migration via migrate-set-parameters. Always pass the config
> to the migration commands.
> 
> These options are special in that they make sense both before and after
> starting the migration, so it's indeed confusing. I don't know what the
> best approach is.

Hmm, now I start to question whether this is a good idea.  That's about
this patch of the series:

    migration: Allow migrate commands to provide the migration config
    
    Allow the migrate and migrate_incoming commands to pass the migration
    configuration options all at once, dispensing the use of
    migrate-set-parameters and migrate-set-capabilities.
    
    The motivation of this is to simplify the interface with the
    management layer and avoid the usage of several command invocations to
    configure a migration. It also avoids stale parameters from a previous
    migration to influence the current migration.

Logically speaking, if mgmt worries about a stale parameter leftover, the
mgmt should always overwrite it in the config of this QMP migrate command..
Now I don't see a real benefit that we need to ignore global setups.

A mgmt should simply query all parameters when QEMU just started up, then
keep it, then whatever user changes should be applied on top,  Then when
any QMP migrate happens, it should always set all parameters.. no matter
what is the global.

The problem is exactly here, that when some parameters can be dynamically
changed like max-bw, if it was set and throttled 10Gbps dynamically,
migration failed, someone re-started the migration expecting the 10Gbps was
still applied when QMP migrate didn't set max-bw this time, but it didn't
work like that.

Do you think we should make "config" of migrate / migrate_incoming taking
global setting as base, rather than initial_params?  I hope we don't
introduce something for nobody at last, but only to make our lives slightly
harder. :(

-- 
Peter Xu


