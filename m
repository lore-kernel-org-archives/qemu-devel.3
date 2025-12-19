Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEFBD78786
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 15:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWc7N-0007ne-Rd; Fri, 19 Dec 2025 10:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWc7E-0007iI-8B
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 10:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWc7A-0004kM-3b
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 10:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766156989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HF3laBWC6521w7GJz78VdCqKgNk9d3qG5i4OVBKFYf8=;
 b=MHXXc+T5GZd0xPY0ctaNZ7nZfU2qmsevax76SY0XEPLsEixE7qucAghVPhxfuGB+ln8lQe
 eIV4TnhMxgoARM3eWsUYukTJENXdU3SEGavUV7osN8FOZ+utPQAjX84YULI6sjGBGOh2K0
 mxaay4HzfAMS4S2tMhXn/fdY2iTBO7A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Q-VWtqeQMgKH2eifuSpTDA-1; Fri, 19 Dec 2025 10:09:47 -0500
X-MC-Unique: Q-VWtqeQMgKH2eifuSpTDA-1
X-Mimecast-MFC-AGG-ID: Q-VWtqeQMgKH2eifuSpTDA_1766156987
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8888a6cb328so44753286d6.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766156987; x=1766761787; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HF3laBWC6521w7GJz78VdCqKgNk9d3qG5i4OVBKFYf8=;
 b=gauf+Ijdil+YhPF1TPgJqjHhb6dqbOwTYTD6+59i6DV7gikV+zmWN8FqYmPThAyDxr
 A7PABnz+BAGcwx1fwZ3d1rWRyJVFELO7PJgr4Q4VrXeEHfYIPuGs8bF9BFuuVlHfz/SX
 TgpT4oTPr8lBBC2rlI31UAOTAwqDIg8nGU2rP/RRNtsVUptiyY2ARjKxl7vn0tA+lw2p
 LrhcO0l6jXUkSTzQtueGw+fsB+9hsIRGjL3kmEdCPhuf30OhbeajnrtpScPCfmGHmkzd
 Pvj/1TGxrEusfHct0Ibcfb5Jtffw29dlQVIJksoAcZyIyHeYFctT7OmBlK2Pd1q36GhU
 B06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766156987; x=1766761787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HF3laBWC6521w7GJz78VdCqKgNk9d3qG5i4OVBKFYf8=;
 b=nIoXEuxMrpMT1NkVbPOSxPNwkRfhwF05/n+sTsyLiKg+KswNr4Nm3wt5RbpB6p9s7C
 PlKJr5V7CEiq1botqkWoY0JbFa6c2nogEV/iGgpHiWpl0aMDglLjFw/zKMI+fjmv6IJU
 96L94WbYm+bza6bHbbFm6XLtS1CyMtse5Kl3DDp/Gs5RiXicqjBIKfmiYA6BgGiiYyUn
 zDYoPpIqPfF8OrFZaBfdLwimzKMxMTyCOy2Hw6qNfJix3atd8vrjT3HhijU7FKDK71Zk
 25dprf8vDG5fhzMf/gua58Y9Mm70+0h9LYEGJupaPOFrZvmBXKB6l9S7aURMq0I8Rzkk
 1zsQ==
X-Gm-Message-State: AOJu0Yxbe1bp9Hbknxkdfw7opLKVOUMHT6T6/eyWZgc/oy+ikhMheA1R
 DiG4SMF1SIrMoXiu7lh2OJgi3+nalOHZpvdJHDmO6UMI+6vX38u6ycUoASAy3zw4SXE5BMC3xd6
 Nwpv0eD0LM8WVG0h3HieuUL/uDQxHst4jguxmb2dgJwBiFZBxPxaBwIJG
X-Gm-Gg: AY/fxX7A3H6//nInBu5wlyZDuYas5AYGojmwffcejLqs1+WVkqqka7qKJgMH0jycexH
 E7QKeEyHCOR6NoBvk4WKlAz0N3FjIrzUb44nOyO/ygwBaPFX8BuggZzBUyP25OT1dKBlEjpriAa
 rkMmiknEDflq7dZvFRV+IVE1ZJFqnEQfPnrJsz+WIg9bCZjkAg+pYr5rts773MtqbEA6/NC3L8h
 GDGgIBZFzArn1d5Ko++pmvV3Jpi23qvrRmLpv7yWYeSnZHqoVbxPnTKDdCDSVAA5AsXdeuneYfl
 ebncQtbfyA1DJGd8P7PZVSgYSfLLTfpGrh7ZowpwQWekOrMniU9SJy3wrOZzO2MJyNCbuZ0QiPn
 mTR0=
X-Received: by 2002:a05:622a:410e:b0:4f1:be70:7a76 with SMTP id
 d75a77b69052e-4f4abd8c6afmr43987091cf.49.1766156986804; 
 Fri, 19 Dec 2025 07:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlN/MpNECGajbRA7jQKTH57XQHHwLIn+6BLx36ZQIfopj+tcF3DjyzIeG0GC9LRmQPeer/Jg==
X-Received: by 2002:a05:622a:410e:b0:4f1:be70:7a76 with SMTP id
 d75a77b69052e-4f4abd8c6afmr43986291cf.49.1766156986197; 
 Fri, 19 Dec 2025 07:09:46 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4ad519939sm16177291cf.2.2025.12.19.07.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 07:09:45 -0800 (PST)
Date: Fri, 19 Dec 2025 10:09:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 30/51] tests/qtest/migration: Add temporary code to
 toggle usage of config
Message-ID: <aUVquIHqShlBRXHS@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-31-farosas@suse.de>
 <aUQ7DcU5T_GH8G1V@x1.local> <875xa31ssl.fsf@suse.de>
 <aURq58a8dsZuDbcL@x1.local> <87tsxnz7bz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tsxnz7bz.fsf@suse.de>
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

On Thu, Dec 18, 2025 at 08:41:20PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Dec 18, 2025 at 04:41:46PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Dec 15, 2025 at 07:00:16PM -0300, Fabiano Rosas wrote:
> >> >> The tests are being refactored to pass migration options to QEMU using
> >> >> the new API of passing a JSON object as argument the migration
> >> >> commands instead of using several calls to the
> >> >> migrate_set_capabilities|parameters commands.
> >> >> 
> >> >> Since multiple tests share common infrastructure (framework.c,
> >> >> migration-utils.c, migration-qmp.c), it's cumbersome to convert tests
> >> >> in small chunks, which would require changes to every common function
> >> >> to accept both the new and old ways.
> >> >> 
> >> >> After some tinkering, an easier way to do this transition is to allow
> >> >> the tests to set a key in the config dict itself telling whether the
> >> >> config is supported. With this, the common functions can be fully
> >> >> altered to support the config object, as long as they check this
> >> >> temporary key and do the right thing.
> >> >> 
> >> >> QEMU doesn't know about this hack, so some code is needed to hide it
> >> >> when issuing QMP commands with the config object.
> >> >> 
> >> >> This will all be removed once tests are fully converted.
> >> >> 
> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >> ---
> >> >>  tests/qtest/migration/migration-qmp.h  |  1 -
> >> >>  tests/qtest/migration/migration-util.c |  1 +
> >> >>  tests/qtest/migration/migration-util.h | 34 ++++++++++++++++++++++++++
> >> >>  3 files changed, 35 insertions(+), 1 deletion(-)
> >> >> 
> >> >> diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
> >> >> index 940ffd5950..9a36a677ba 100644
> >> >> --- a/tests/qtest/migration/migration-qmp.h
> >> >> +++ b/tests/qtest/migration/migration-qmp.h
> >> >> @@ -47,5 +47,4 @@ void migrate_recover(QTestState *who, const char *uri);
> >> >>  void migrate_cancel(QTestState *who);
> >> >>  void migrate_postcopy_start(QTestState *from, QTestState *to,
> >> >>                              QTestMigrationState *src_state);
> >> >> -
> >> >>  #endif /* MIGRATION_QMP_H */
> >> >> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
> >> >> index 416dd10ef8..e702f00896 100644
> >> >> --- a/tests/qtest/migration/migration-util.c
> >> >> +++ b/tests/qtest/migration/migration-util.c
> >> >> @@ -255,6 +255,7 @@ static void migration_test_wrapper(const void *data)
> >> >>  
> >> >>      test->data = g_new0(MigrateCommon, 1);
> >> >>      test->data->start.config = qdict_new();
> >> >> +    qdict_put_bool(test->data->start.config, "use-config", false);
> >> >>  
> >> >>      g_test_message("Running /%s%s", qtest_get_arch(), test->name);
> >> >>      test->func(test->name, test->data);
> >> >> diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
> >> >> index e73d69bab0..3c3b5a8777 100644
> >> >> --- a/tests/qtest/migration/migration-util.h
> >> >> +++ b/tests/qtest/migration/migration-util.h
> >> >> @@ -60,4 +60,38 @@ void migration_test_add_suffix(const char *path, const char *suffix,
> >> >>  char *migrate_get_connect_uri(QTestState *who);
> >> >>  void migrate_set_ports(QTestState *to, QList *channel_list);
> >> >>  
> >> >> +/*
> >> >> + * Scaffolding to allow the framework _common functions and _qmp
> >> >> + * functions to use the config object while some tests are still using
> >> >> + * migrate_set_*. Tests that have been converted will set use-config =
> >> >> + * true on the config dict.
> >> >> + */
> >> >> +static bool has_key;
> >> >> +static bool use_config;
> >> >
> >> > Looks like this is temp measure, so no strong opinions.. said that, it
> >> > looks tricky to have the two globals shared between all the tests, and
> >> > having magic keys in the qdict.
> >> >
> >> 
> >> It is tricky, but it works. The other options all require "passing
> >> something" in, which ends up touching good code and causing a mess with
> >> rebases and the overall clarity of the patches. But let me read about
> >> your suggestions below...
> >> 
> >> > Can we pass in MigrateStart* for config_load() and config_put()?  Then at
> >> > least we can change globals into per-test flags of MigrateStart.
> >> >
> >> > Btw, AFAIU the two helpers should always used in a pair but load() and
> >> > put() do not look like a pair..
> >> >
> >> 
> >> My mind went to vcpu_load/vcpu_put from kvm code. =D
> >
> > Fair enough. :) Personally I'd use load/unload in new codes.
> >
> >> 
> >> > If we can have args->use_config as a bool, having tests opt-in config
> >> > setups by setting it, then I wonder if we can do that like:
> >> >
> >> 
> >> The migrate_qmp commands don't take args. So I'd have to alter their
> >> signature just for this temporary state. That's why I put the flag in
> >> the dict itself.
> >> 
> >> >   if (args->use_config) {
> >> >       // do whatever with args->config...
> >> >   } else {
> >> >       // covered by other migrate-set-parameters QMP commands..
> >> >   }
> >> >
> >> > Do we really need config_put()? I'll keep reading, but please evaluate..
> >> >
> >> 
> >> Because of the migrate_incoming_qmp and -incoming calls, we need to take
> >> the key out of the dict to hide it. Then put it back so the rest of the
> >> code, e.g. migrate_qmp can use it.
> >
> > Can we introduce migrate_qmp_args() wrapper which takes the *args, then
> > only pass in config if args->use_config for migrate_qmp()?
> >
> > I still want to know if we can have better way to do this, so that the
> > qdict should only and always be the real configs to be applied.  That can
> > remove a major confusion I had when reading this series.
> >
> 
> Ok, I can try harder.

Thanks.

> 
> > Another example is, I see that you also reused the qdict keys for storing
> > different tls-creds for client/server, which needs tweak as well before
> > applying.  I wonder if those can be done with config, config_src,
> > config_dst, hence whatever passed into migrate_qmp should be
> > "config+config_src", whilist "config+config_dst" for migrate_incoming_qmp.
> >
> 
> Hm, but then we'd have these args->config_src and args->config_dst for
> people to misuse. The config reaches migrate_qmp via the _common
> functions:
> 
> test_foobar(args)
> {
>     args->config.multifd = true;
>     args->config.tls_creds = "abc";
>     test_foobar_common(args);
> }
> 
> test_foobar_common(args)
> {
>     migrate_start(args);
>     ...
>     migrate_qmp_incoming(args->config);
>     ...
>     migrate_qmp(args->config);
> }
> 
> It would be weird:
> 
> test_foobar(args)
> {
>     args->config.multifd = true;
>     args->config_src.tls_creds = "abc";
>     args->config_dst.tls_creds = "def";
>     test_foobar_common(args);
> }
> 
> test_foobar_common(args)
> {
>     migrate_start(args);
>     ...
>     migrate_qmp_incoming(args->config, args->config_dst);
>     ...
>     migrate_qmp(args->config, args->config_src);

Here IMHO we can keep the migrate[_incoming]_qmp() taking only one qdict,
like:

      config = migrate_start_get_config_dst(args);  // merge config+dst
      migrate_incoming_qmp(config);
      qobject_unref(config);
      ...
      config = migrate_start_get_config_src(args);  // merge config+src
      migrate_qmp(config);
      qobject_unref(config);

PS: irrelevant of whether we need config_src/config_dst, maybe it'll always
be good to have a pair of such:

   config = migrate_start_get_config_src/dst()
   ...
   qobject_unref(config);

Over fixup_tls_creds()?

I think fixup_tls_creds() is almost that, however IMHO the name of the
function makes it hard to guess what it really does.

> }
> 
> If there's code that needs to check the config for an option, how does
> it know which of the three to look at?

I doubt if we need such use case in tests; I can't find any so far.

If we'll need it, IMHO it should always check against args->config, because
by default migration configs should really always match on both
sides.. which is the shared portion in args->config.

Looks like tls-creds is the only outlier here? If so, maybe we can also
special case it to have args->start having special variable for tls-creds
for both src/dst, then migrate_start_get_config_src() can apply that on top
of the shared config.  IMHO it'll still be slightly better than reusing
keys directly in the qdict.

But maybe config_src/dst is more future-proof.

You may have a better grasp.  Having temp keys in qdict is still fine to me
when use cases are very limited, but as requested before, I wish we can
document all these special keys then above "MigrateStart.config" explicitly
if so.

Not sure if Dan has any preference.

> 
> > IMHO if no way to work it out, one last request is for all special keys we
> > should have somewhere document them explicitly (maybe above the "config"
> > var?). We could also make all special keys to be prefixed with "__" (or
> > something else) so as to be very clear they are special.  We can even
> > assert in a config_load() making sure no special keys after loaded.
> >
> > So in general, if there's way to not introduce special keys I'll consider
> > voting for them first..  Said that, please go choose whatever way you
> > finally decide. It can take into account of how easy it is to impl the idea
> > based on your current version, to not make this series drag you too much.
> > Not a big deal, IMHO we can work on top especially with tests.
> >
> >> 
> >> >> +static inline QDict *config_load(QDict *config)
> >> >> +{
> >> >> +    if (!config) {
> >> >> +        return NULL;
> >> >> +    }
> >> >> +
> >> >> +    has_key = qdict_haskey(config, "use-config");
> >> >> +    if (has_key) {
> >> >> +        use_config = qdict_get_try_bool(config, "use-config", false);
> >> >> +        qdict_del(config, "use-config");
> >> >> +    }
> >> >> +
> >> >> +    if (use_config) {
> >> >> +        return config;
> >> >> +    }
> >> >> +
> >> >> +    return NULL;
> >> >> +}
> >> >> +
> >> >> +static inline void config_put(QDict *config)
> >> >> +{
> >> >> +    if (config && has_key) {
> >> >> +        qdict_put_bool(config, "use-config", use_config);
> >> >> +    }
> >> >> +}
> >> >> +
> >> >>  #endif /* MIGRATION_UTIL_H */
> >> >> -- 
> >> >> 2.51.0
> >> >> 
> >> 
> 

-- 
Peter Xu


