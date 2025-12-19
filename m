Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFEAD7878C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 15:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWcaI-00051A-LE; Fri, 19 Dec 2025 10:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWcaH-00050z-Md
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 10:40:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWcaD-0004Dl-PF
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 10:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766158795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkT8zTzYlyOHd96obZ+oIGX/qv6HW3/FXZzqGMTEg+0=;
 b=M4qiFkRUQ42jAEcFZH7l/qCT3RQozQPcKv2wzL+i+EiQiOpsBg5xTRNxuZJDY7IC8UKkDN
 3iYyEwLVjme3W69KnxJZNfm3W/aBIt1M+qvlgSG66Gzq2cPlEpBTmJvVSmRgx0T5bbbr3T
 HS5aLpxNO7hLbH0Vnm2HOjITq+Y7CbM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-MT0n9G07O26OeVeeR2pXMg-1; Fri, 19 Dec 2025 10:39:54 -0500
X-MC-Unique: MT0n9G07O26OeVeeR2pXMg-1
X-Mimecast-MFC-AGG-ID: MT0n9G07O26OeVeeR2pXMg_1766158794
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2e41884a0so464027685a.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 07:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766158794; x=1766763594; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fkT8zTzYlyOHd96obZ+oIGX/qv6HW3/FXZzqGMTEg+0=;
 b=Zzy4c2c8g+GyhuCrPzg+yaCTYXQZfm7VscAi0utmdvXa7IPOO+T48awaBy32wf9gb2
 7wEgBTh0OBx6BP4wMrs3XWEkHjaiWPhSWZ7ZKa62ZwDaY9PrjAteONhYC/qZdV9AnygP
 tboqf/m/labWIKTnljUCaI3tu47jqtb3xY1Cy7EaWLR2ZMSfD4mCu0AaJvtR9eE4W4ws
 d+Wk4uIYQHGWRF8RXM9QXUSb3ikQ5ZhdhhhCUvcerSRfQbYlbJNb94/q0Od0Oy2//yBs
 SDEBCX19+iIr8Wtzi4cv4nQ2nxeMzpPoX+B9oLEixrI/lyKDTbXY7RyewgH5pxQma3W2
 TVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766158794; x=1766763594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkT8zTzYlyOHd96obZ+oIGX/qv6HW3/FXZzqGMTEg+0=;
 b=Qj8z1T9XpfF5DvTRxa+ImT4ShqOPmxPcxc4fNueuJXO6lHbS10SgOo5RX8N4uy2Rv2
 heF+LMSa5uIMX0vTc+h/XtmjouWQAAIQ+chEkioV3g/Ep/pWQAOehV2gR1tW0FSBCzVL
 ooPk+PhTyPmDwSlHwimaU50Xgfim8g12xXb0+1nzZL8ZUrf62+Dv5W0DhfHmns0hYLbm
 834giuexYcKSqaf4h0H3cWQLJccVRpFBJTboyfJ2g9KMGD2/C46o4NtGWHGX/9UUT/e6
 riAqeaNJTxYYhnAzSYtxqRuR4RcUygrv7WV+nVt41OF4JoYRivFscR/WdaOJ4y8L0ACP
 Tqvw==
X-Gm-Message-State: AOJu0Yx/9I1AMu9DsGBzW2Wb768OMamhN2O4RUldjR03XtoTDpx5c9mJ
 6POjYIeeXCo1tIaEAyOh/Vo/2qWFPfVVFoBlt55e1ioWxm4O+F0O5cFT0Rzej3AqPtjWYtlMYFg
 gz9xb15yUi59kVxHM6SI+NUVS7XxkKuZberW54KVVDrHr34xuNCneiNMA
X-Gm-Gg: AY/fxX7rJtbSXcS2TPT205hvxUGXrNgWliDxhmZ435Fcd5wzo18dpCh6i65lkj8z8PX
 KcS2ZGcDb8lmuIzJUR6NinKVch7FijExtGfOG7SGtVSmyerrW8A1IuVuPHMCdM7CH1r0z7/gwmE
 IvTdAipQDaRzmWXgyInHms3qDZQCVsknH2cCKo3J5gjfsa8magn6zaO7Tj/9zYP4wI6D8MWDXGx
 wwaxvShIQdsjjA9mGZfjWse4vwFQDrTVWmLURgMYJJPR7kC//ORDkKuTJJiHrP5XH4JasO9PWAr
 DZlBNNblK48PwSHIlYtZNU5e9CnOPyORFIKhwfivUHPQ+y+ilG8v0930LlRpbF7bXYUk/f/DGM7
 xFaE=
X-Received: by 2002:a05:620a:40cb:b0:893:2ba8:eec8 with SMTP id
 af79cd13be357-8c08fd18594mr509867885a.79.1766158793748; 
 Fri, 19 Dec 2025 07:39:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmnY8diRf3Hgyn17Of5DvW6s+tDKCwo0VO3AT23BXxrTFCff1ptF9xG4QBM2Pg2pECCSSeEg==
X-Received: by 2002:a05:620a:40cb:b0:893:2ba8:eec8 with SMTP id
 af79cd13be357-8c08fd18594mr509863785a.79.1766158793089; 
 Fri, 19 Dec 2025 07:39:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0971ed98dsm204046285a.31.2025.12.19.07.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 07:39:52 -0800 (PST)
Date: Fri, 19 Dec 2025 10:39:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 32/51] tests/qtest/migration: Adapt convergence
 routines to config
Message-ID: <aUVxx8tfPMe-liDT@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-33-farosas@suse.de>
 <aUQ5BoCrMXk2SJDC@x1.local> <8734571sik.fsf@suse.de>
 <aURtVveE88n31AN_@x1.local> <87wm2jz7xf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wm2jz7xf.fsf@suse.de>
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

On Thu, Dec 18, 2025 at 08:28:28PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Dec 18, 2025 at 04:47:47PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Dec 15, 2025 at 07:00:18PM -0300, Fabiano Rosas wrote:
> >> >> Adapt the convergence routines migrate_ensure_[non_]converge to set
> >> >> the convergence parameters in the config dict it instead of using
> >> >> migrate-set-parameters.
> >> >> 
> >> >> Some tests need to change the convergence parameters during the
> >> >> migration. The config object method is specific to configuration prior
> >> >> to starting a migration, so by design it's not suitable to effect
> >> >> migration-runtime changes. The existing routines will be kept for this
> >> >> purpose (renamed with 'ongoing' for clarity).
> >> >> 
> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >> ---
> >> >>  tests/qtest/migration/framework.c     | 10 ++++-----
> >> >>  tests/qtest/migration/migration-qmp.c | 32 +++++++++++++++++++++++++--
> >> >>  tests/qtest/migration/migration-qmp.h |  6 +++--
> >> >>  tests/qtest/migration/misc-tests.c    |  4 ++--
> >> >>  tests/qtest/migration/precopy-tests.c | 26 +++++++++-------------
> >> >>  5 files changed, 52 insertions(+), 26 deletions(-)
> >> >> 
> >> >> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> >> >> index fd15bd832e..df42a8a2c6 100644
> >> >> --- a/tests/qtest/migration/framework.c
> >> >> +++ b/tests/qtest/migration/framework.c
> >> >> @@ -583,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
> >> >>          args->postcopy_data = args->start_hook(from, to);
> >> >>      }
> >> >>  
> >> >> -    migrate_ensure_non_converge(from);
> >> >> +    migrate_ensure_non_converge(from, args->start.config);
> >> >>      migrate_prepare_for_dirty_mem(from);
> >> >>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> >> >>                               "  'arguments': { "
> >> >> @@ -872,7 +872,7 @@ int test_precopy_common(MigrateCommon *args)
> >> >>      }
> >> >>  
> >> >>      if (args->live) {
> >> >> -        migrate_ensure_non_converge(from);
> >> >> +        migrate_ensure_non_converge(from, args->start.config);
> >> >>          migrate_prepare_for_dirty_mem(from);
> >> >>      } else {
> >> >>          /*
> >> >> @@ -884,7 +884,7 @@ int test_precopy_common(MigrateCommon *args)
> >> >>          if (args->result == MIG_TEST_SUCCEED) {
> >> >>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
> >> >>              wait_for_stop(from, &src_state);
> >> >> -            migrate_ensure_converge(from);
> >> >> +            migrate_ongoing_ensure_converge(from);
> >> >>          }
> >> >>      }
> >> >>  
> >> >> @@ -942,7 +942,7 @@ int test_precopy_common(MigrateCommon *args)
> >> >>              }
> >> >>              migrate_wait_for_dirty_mem(from, to);
> >> >>  
> >> >> -            migrate_ensure_converge(from);
> >> >> +            migrate_ongoing_ensure_converge(from);
> >> >>  
> >> >>              /*
> >> >>               * We do this first, as it has a timeout to stop us
> >> >> @@ -1047,7 +1047,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
> >> >>          data_hook = args->start_hook(from, to);
> >> >>      }
> >> >>  
> >> >> -    migrate_ensure_converge(from);
> >> >> +    migrate_ensure_converge(from, args->start.config);
> >> >>      wait_for_serial("src_serial");
> >> >>  
> >> >>      if (stop_src) {
> >> >> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> >> >> index 5c46ceb3e6..7fe47a5793 100644
> >> >> --- a/tests/qtest/migration/migration-qmp.c
> >> >> +++ b/tests/qtest/migration/migration-qmp.c
> >> >> @@ -499,20 +499,48 @@ void migrate_set_parameter_bool(QTestState *who, const char *parameter,
> >> >>      migrate_check_parameter_bool(who, parameter, value);
> >> >>  }
> >> >>  
> >> >> -void migrate_ensure_non_converge(QTestState *who)
> >> >> +void migrate_ongoing_ensure_non_converge(QTestState *who)
> >> >>  {
> >> >>      /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> >> >>      migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
> >> >>      migrate_set_parameter_int(who, "downtime-limit", 1);
> >> >>  }
> >> >>  
> >> >> -void migrate_ensure_converge(QTestState *who)
> >> >> +void migrate_ongoing_ensure_converge(QTestState *who)
> >> >>  {
> >> >>      /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> >> >>      migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> >> >>      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> >> >>  }
> >> >>  
> >> >> +void migrate_ensure_non_converge(QTestState *who, QDict *config)
> >> >> +{
> >> >> +    config = config_load(config);
> >> >> +    if (config) {
> >> >> +        /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> >> >> +        qdict_put_int(config, "max-bandwidth", 3 * 1000 * 1000);
> >> >> +        qdict_put_int(config, "downtime-limit", 1);
> >> >> +    } else {
> >> >> +        assert(who);
> >> >> +        migrate_ongoing_ensure_non_converge(who);
> >> >> +    }
> >> >> +    config_put(config);
> >> >> +}
> >> >> +
> >> >> +void migrate_ensure_converge(QTestState *who, QDict *config)
> >> >> +{
> >> >> +    config = config_load(config);
> >> >> +    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> >> >> +    if (config) {
> >> >> +        qdict_put_int(config, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> >> >> +        qdict_put_int(config, "downtime-limit", 30 * 1000);
> >> >> +    } else {
> >> >> +        assert(who);
> >> >> +        migrate_ongoing_ensure_converge(who);
> >> >> +    }
> >> >> +    config_put(config);
> >> >> +}
> >> >
> >> > It's slightly an overkill to me to have these converge helpers to provide
> >> > two versions.  Also a bit confusing on when should we use which.
> >> >
> >> > After all, parameters touched on convergence must be able to be dynamically
> >> > set..
> >> >
> >> > Can we always stick with the QMP set-parameters for all these?
> >> >
> >> 
> >> Well, QEMU ignores anything set with migrate-set-parameters once it sees
> >> the config, so we'd need to change that in the code.
> >> 
> >> Thinking about the design of "config", I think the point was to never
> >> configure a migration via migrate-set-parameters. Always pass the config
> >> to the migration commands.
> >> 
> >> These options are special in that they make sense both before and after
> >> starting the migration, so it's indeed confusing. I don't know what the
> >> best approach is.
> >
> > Hmm, now I start to question whether this is a good idea.  That's about
> > this patch of the series:
> >
> >     migration: Allow migrate commands to provide the migration config
> >     
> >     Allow the migrate and migrate_incoming commands to pass the migration
> >     configuration options all at once, dispensing the use of
> >     migrate-set-parameters and migrate-set-capabilities.
> >     
> >     The motivation of this is to simplify the interface with the
> >     management layer and avoid the usage of several command invocations to
> >     configure a migration. It also avoids stale parameters from a previous
> >     migration to influence the current migration.
> >
> > Logically speaking, if mgmt worries about a stale parameter leftover, the
> > mgmt should always overwrite it in the config of this QMP migrate command..
> > Now I don't see a real benefit that we need to ignore global setups.
> >
> > A mgmt should simply query all parameters when QEMU just started up, then
> > keep it, then whatever user changes should be applied on top,  Then when
> > any QMP migrate happens, it should always set all parameters.. no matter
> > what is the global.
> >
> 
> We can decide that QEMU will not force the mgmt app to do that work and
> will provide an API that doesn't require setting all parameters. I don't
> see an argument here.
> 
> > The problem is exactly here, that when some parameters can be dynamically
> > changed like max-bw, if it was set and throttled 10Gbps dynamically,
> > migration failed, someone re-started the migration expecting the 10Gbps was
> > still applied when QMP migrate didn't set max-bw this time, but it didn't
> > work like that.
> >
> 
> We need to think about what the QMP API exposes.
> 
> If we expose an API that says: QMP_MIGRATE might use a value that was
> set using MIGRATE-SET-PARAMETERS 6 months ago because QEMU uses global
> state, that's an API usability issue.
> 
> If we expose an API that says: QMP_MIGRATE runs the migration with
> whatever arguments were passed to it via CONFIG, that sounds like
> something sensible.
> 
> I don't think the API consumers would be surprised if we allow
> MIGRATE-SET-PARAMETERS to change runtime values for a migration and on
> the next migration that value is no longer the same.
> 
> > Do you think we should make "config" of migrate / migrate_incoming taking
> > global setting as base, rather than initial_params?  I hope we don't
> > introduce something for nobody at last, but only to make our lives slightly
> > harder. :(
> 
> One calls a function and it uses the arguments passed to it, that's
> it. New migration, new arguments. As you said, mgmt could just hold the
> dynamic parameter that their user changed and pass that along with the
> config for the new migration.

It's never about when mgmt is an app like libvirt, IMHO either way we
define it, libvirt will be fine.  It's only about human beings when using
this API e.g. via HMPs, or who start to write scripts manipulating QEMU
directly assuming the max-bw will persist.

That's almost why I thought remembering the globals should be the best
because it will work well for both a computer and a human being.  But I
might be the only one thinking so if you don't agree on this; it's fine.

> 
> But I don't think we fleshed out the usage regarding the dynamic
> parameters yet. There might be other issues that I'm overlooking. Maybe
> we'd need a whole new command with slightly different semantics from
> migrate-set-parameters that adjusts the dynamic options while migration
> is running, I'm not sure.
> 
> ---
> side note:
> 
> If you think the whole endevour of passing a config to qmp_migrate
> is a bad idea, please speak up. If mgmt code will require the amount of
> churn I had to do for our test suite, maybe it's not worth the effort
> after all.

Frankly, I never thought there was an real problem to solve..  the only
thing I can remember is that "libvirt used to control this qemu, but link
down, some admin set something, libvirt reconnected and migration caused
weird issues".

IMHO when reconnect libvirt can always apply all the parameters once
more.. then if link kept, globals are also kept for this session anyway.
IMHO it's fair here because migration is special and unique for a QEMU
instance.  I don't further worry on other weird setups, like QEMU exposing
two QMP monitors - libvirt started the QEMU instance after all.

I almost always thought having "config" in migrate QMP command is a bonus
and optional, since it's still easy to get.  Hence, there's no harm anyway
we support it.  Your other changes (dedup >1 migration parameters structs,
merging caps into parameters, etc.) are more solid changers to me.

I'd confess initially I didn't expect so - logically we can introduce one
or a few new cases to test "config" setups, because most of the code paths
should really be shared (unless we decide to obsolete set-parameters; I
guess we won't.. forever).  But since we moved this far, The test cases are
now also moving all towards configs after this series. I think it's fine,
and you can decide that.

> 
> My opinion is that, in general, the "config" changes are going in a good
> direction. I worry slightly about what the cost would be for the users
> to adhere to it. Migration has been quirky for a looong time, you make
> it less quirky people will find it strange =)

Yes, actually I won't be surprised that after your series lands maybe the
"config" in QMP_MIGRATE won't be used for a while.  And if it keeps going
like that, nobody will consume it.. but I don't really know.  We'll see!

What I know is, after your series lands, I'll start to play with changing
default values for capabilities. :)

-- 
Peter Xu


