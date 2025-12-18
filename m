Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6CED711C3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 20:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWL53-0003BZ-R9; Thu, 18 Dec 2025 15:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWL4y-0003Aq-4Y
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 15:58:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWL4v-0004dz-J5
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 15:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766091506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBthgVuhRSJXZvhcfIR9Sza3Wk4+V+VE8QQJ/l2bSf8=;
 b=O4xkjK9q9oNKCHxmkH3JGZpUIj68pNsI5zFT9+rYY1Fa5K9GRJa2PQfTO5RAA9eOHZNmTk
 GgVOEGVx4KKKIqnWHhj7RenbcV7nW2+BB+YdijulRfD8JlyfpH3TgmqpdeicgKd/4xYP4T
 yoqYAoYPd4vZmng8N66LLatETyJIvlQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Bmsmhh4gOwuA8Ba8Fo5wbw-1; Thu, 18 Dec 2025 15:58:18 -0500
X-MC-Unique: Bmsmhh4gOwuA8Ba8Fo5wbw-1
X-Mimecast-MFC-AGG-ID: Bmsmhh4gOwuA8Ba8Fo5wbw_1766091498
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b17194d321so139917685a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766091498; x=1766696298; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IBthgVuhRSJXZvhcfIR9Sza3Wk4+V+VE8QQJ/l2bSf8=;
 b=YBd2A65AGlo6hpDOkL8eaUUsc9JG1HzCYPPF3qvwuBMXQ7E5AalS1AYyL9Yc518NPo
 p3CdrX9Z15MjRakatrAG32Z6XoRDZdRuLtNmMZiHjCbIXdDjm2uO5GeXeirql67VBHvW
 9qdnTg+WvN+VxIf7bg0gedF5K9VNWgQ3I9tAdK4EkXvVkKTwi53DdKFK+3AA+QkRRllL
 TBrm3wK3ebQRWuhAZE/eCR9FJ+5rWFg2l/ZE83GGXSXQ+zjMHRDiUd3fgAWleXVsShnN
 vHOFrtXFgwG3gnkugUC/F3jjm5VdWr+aAR9YjijcPkdf65qnzbjQjDf/PA3VoYY8FMbI
 rzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766091498; x=1766696298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBthgVuhRSJXZvhcfIR9Sza3Wk4+V+VE8QQJ/l2bSf8=;
 b=QH/yJjAV2IW+fG/INmD6aQ3wULQeqm+VTj1r9yyT4Tt08O3eO2di6IMUzjkfp8uqsD
 qnAD6Ap9jjL3UAxBEzPeRpzVX+WSm542MkkzuaFujJf7bho1NgE4sSxRYznYxTO6P0BX
 cjQOp1/52f8501ey7fkNFP4BYRdyyczNf//zJlE0OVgZZK/jziNVTzhDZPQyl4/XFGEA
 KYDs7XPWArS+boF3QK7mrJ5mYIOwfRFg9tcpV0cgdzLr+2KG/t/mEWaMURoRHdwz4e66
 1Jx8C2j8JXkHFmqyWWuqRte8GhGFb0J6AE9X2hinVlsnMcK4mDSCNJ+MEK1YoVpz6Ouq
 YVBg==
X-Gm-Message-State: AOJu0Yy89Moax/I4GUujPC67q/q2vd6et7xttQG2QArZwZWwrNrbauvY
 u5WbXlXP1oz1ubrG0YDHF4M9GMzR2cwSm2JEgZz23WKXIg07zAcRSTswpXpHs8kddNiyEZtZ113
 ennVGXU0z/bAvlF8boOICuIs+FVnWMvD3OP8D84Yb4D99WjSJxMFdCpvE
X-Gm-Gg: AY/fxX6PTQk1VP/dXlFRne0S56zomUnNqF8hxW81xsOvhv20Zy2ZCo1zzjT0IOvT83q
 qUH/zuMT6oSrX0+XLH60/ZWCCbOQ7BDHfbaULypQaHNCMyPelHdIThMmWTCL7M26t7pWm8fwf6Q
 LFGQd54B+fOqI+wvAm7/rRFoGBnrBO9SdjUzh5m1uDbc/1kSKCH1maWN+TUjgCskw51RHjXDXea
 qMikXX299RyY/5XVD2YTPYFTxgkgm1zuc2ZMHczLtOteM3f0FvzsHMar7KbTT5nRDgsoNvdHljL
 Y53mjmq/zZcRLlBuPnJBErmckKrgL6cDubncpqcxXzgrjbg1YKEaiLzVq/jFswgUr0z/JVJLJu2
 CS0A=
X-Received: by 2002:a05:620a:1a87:b0:8b2:e1bd:6b0 with SMTP id
 af79cd13be357-8c08fd2781bmr158846485a.54.1766091497898; 
 Thu, 18 Dec 2025 12:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnLOuwNO0bhq/C5n1YnbvdqyYGZ0uwymR4TsAnUHhPLBFbgMGJgtHCnfvbmxvR5oUOvA+Cig==
X-Received: by 2002:a05:620a:1a87:b0:8b2:e1bd:6b0 with SMTP id
 af79cd13be357-8c08fd2781bmr158842885a.54.1766091497314; 
 Thu, 18 Dec 2025 12:58:17 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0971ee247sm25918185a.27.2025.12.18.12.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 12:58:16 -0800 (PST)
Date: Thu, 18 Dec 2025 15:58:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 30/51] tests/qtest/migration: Add temporary code to
 toggle usage of config
Message-ID: <aURq58a8dsZuDbcL@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-31-farosas@suse.de>
 <aUQ7DcU5T_GH8G1V@x1.local> <875xa31ssl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xa31ssl.fsf@suse.de>
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

On Thu, Dec 18, 2025 at 04:41:46PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Dec 15, 2025 at 07:00:16PM -0300, Fabiano Rosas wrote:
> >> The tests are being refactored to pass migration options to QEMU using
> >> the new API of passing a JSON object as argument the migration
> >> commands instead of using several calls to the
> >> migrate_set_capabilities|parameters commands.
> >> 
> >> Since multiple tests share common infrastructure (framework.c,
> >> migration-utils.c, migration-qmp.c), it's cumbersome to convert tests
> >> in small chunks, which would require changes to every common function
> >> to accept both the new and old ways.
> >> 
> >> After some tinkering, an easier way to do this transition is to allow
> >> the tests to set a key in the config dict itself telling whether the
> >> config is supported. With this, the common functions can be fully
> >> altered to support the config object, as long as they check this
> >> temporary key and do the right thing.
> >> 
> >> QEMU doesn't know about this hack, so some code is needed to hide it
> >> when issuing QMP commands with the config object.
> >> 
> >> This will all be removed once tests are fully converted.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration/migration-qmp.h  |  1 -
> >>  tests/qtest/migration/migration-util.c |  1 +
> >>  tests/qtest/migration/migration-util.h | 34 ++++++++++++++++++++++++++
> >>  3 files changed, 35 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
> >> index 940ffd5950..9a36a677ba 100644
> >> --- a/tests/qtest/migration/migration-qmp.h
> >> +++ b/tests/qtest/migration/migration-qmp.h
> >> @@ -47,5 +47,4 @@ void migrate_recover(QTestState *who, const char *uri);
> >>  void migrate_cancel(QTestState *who);
> >>  void migrate_postcopy_start(QTestState *from, QTestState *to,
> >>                              QTestMigrationState *src_state);
> >> -
> >>  #endif /* MIGRATION_QMP_H */
> >> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
> >> index 416dd10ef8..e702f00896 100644
> >> --- a/tests/qtest/migration/migration-util.c
> >> +++ b/tests/qtest/migration/migration-util.c
> >> @@ -255,6 +255,7 @@ static void migration_test_wrapper(const void *data)
> >>  
> >>      test->data = g_new0(MigrateCommon, 1);
> >>      test->data->start.config = qdict_new();
> >> +    qdict_put_bool(test->data->start.config, "use-config", false);
> >>  
> >>      g_test_message("Running /%s%s", qtest_get_arch(), test->name);
> >>      test->func(test->name, test->data);
> >> diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
> >> index e73d69bab0..3c3b5a8777 100644
> >> --- a/tests/qtest/migration/migration-util.h
> >> +++ b/tests/qtest/migration/migration-util.h
> >> @@ -60,4 +60,38 @@ void migration_test_add_suffix(const char *path, const char *suffix,
> >>  char *migrate_get_connect_uri(QTestState *who);
> >>  void migrate_set_ports(QTestState *to, QList *channel_list);
> >>  
> >> +/*
> >> + * Scaffolding to allow the framework _common functions and _qmp
> >> + * functions to use the config object while some tests are still using
> >> + * migrate_set_*. Tests that have been converted will set use-config =
> >> + * true on the config dict.
> >> + */
> >> +static bool has_key;
> >> +static bool use_config;
> >
> > Looks like this is temp measure, so no strong opinions.. said that, it
> > looks tricky to have the two globals shared between all the tests, and
> > having magic keys in the qdict.
> >
> 
> It is tricky, but it works. The other options all require "passing
> something" in, which ends up touching good code and causing a mess with
> rebases and the overall clarity of the patches. But let me read about
> your suggestions below...
> 
> > Can we pass in MigrateStart* for config_load() and config_put()?  Then at
> > least we can change globals into per-test flags of MigrateStart.
> >
> > Btw, AFAIU the two helpers should always used in a pair but load() and
> > put() do not look like a pair..
> >
> 
> My mind went to vcpu_load/vcpu_put from kvm code. =D

Fair enough. :) Personally I'd use load/unload in new codes.

> 
> > If we can have args->use_config as a bool, having tests opt-in config
> > setups by setting it, then I wonder if we can do that like:
> >
> 
> The migrate_qmp commands don't take args. So I'd have to alter their
> signature just for this temporary state. That's why I put the flag in
> the dict itself.
> 
> >   if (args->use_config) {
> >       // do whatever with args->config...
> >   } else {
> >       // covered by other migrate-set-parameters QMP commands..
> >   }
> >
> > Do we really need config_put()? I'll keep reading, but please evaluate..
> >
> 
> Because of the migrate_incoming_qmp and -incoming calls, we need to take
> the key out of the dict to hide it. Then put it back so the rest of the
> code, e.g. migrate_qmp can use it.

Can we introduce migrate_qmp_args() wrapper which takes the *args, then
only pass in config if args->use_config for migrate_qmp()?

I still want to know if we can have better way to do this, so that the
qdict should only and always be the real configs to be applied.  That can
remove a major confusion I had when reading this series.

Another example is, I see that you also reused the qdict keys for storing
different tls-creds for client/server, which needs tweak as well before
applying.  I wonder if those can be done with config, config_src,
config_dst, hence whatever passed into migrate_qmp should be
"config+config_src", whilist "config+config_dst" for migrate_incoming_qmp.

IMHO if no way to work it out, one last request is for all special keys we
should have somewhere document them explicitly (maybe above the "config"
var?). We could also make all special keys to be prefixed with "__" (or
something else) so as to be very clear they are special.  We can even
assert in a config_load() making sure no special keys after loaded.

So in general, if there's way to not introduce special keys I'll consider
voting for them first..  Said that, please go choose whatever way you
finally decide. It can take into account of how easy it is to impl the idea
based on your current version, to not make this series drag you too much.
Not a big deal, IMHO we can work on top especially with tests.

> 
> >> +static inline QDict *config_load(QDict *config)
> >> +{
> >> +    if (!config) {
> >> +        return NULL;
> >> +    }
> >> +
> >> +    has_key = qdict_haskey(config, "use-config");
> >> +    if (has_key) {
> >> +        use_config = qdict_get_try_bool(config, "use-config", false);
> >> +        qdict_del(config, "use-config");
> >> +    }
> >> +
> >> +    if (use_config) {
> >> +        return config;
> >> +    }
> >> +
> >> +    return NULL;
> >> +}
> >> +
> >> +static inline void config_put(QDict *config)
> >> +{
> >> +    if (config && has_key) {
> >> +        qdict_put_bool(config, "use-config", use_config);
> >> +    }
> >> +}
> >> +
> >>  #endif /* MIGRATION_UTIL_H */
> >> -- 
> >> 2.51.0
> >> 
> 

-- 
Peter Xu


