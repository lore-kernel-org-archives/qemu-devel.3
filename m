Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39AFD0D143
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdX7l-0006tw-Ua; Wed, 07 Jan 2026 12:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdX7U-0006rY-AU
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdX7S-0005Cy-4f
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767806088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s7R7mEoVz559+pUzC2DlMmB9UCaLtYyTfUVcfnw+FhU=;
 b=P+jjWTbrQAS9M+309UAORR6x0LxhhQjGO4w0UIpki6EAt9cEFJLbf46vpHDkSVvTefdS02
 RWjX6N5Q8oWgsp7qKjTpQym0eQk07iN5K7BWpRnNpNxRC4JqM5OE4CVHPH6vss3SzHHZqt
 jOqeQX3mlej5vje/l1DstNxj54swnjI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-82670iIZNo2TBQU995TGxA-1; Wed, 07 Jan 2026 12:14:47 -0500
X-MC-Unique: 82670iIZNo2TBQU995TGxA-1
X-Mimecast-MFC-AGG-ID: 82670iIZNo2TBQU995TGxA_1767806087
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8bbe16e0a34so382677985a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767806087; x=1768410887; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s7R7mEoVz559+pUzC2DlMmB9UCaLtYyTfUVcfnw+FhU=;
 b=TPn9ssXxwLK5Yxo9e13q+DAmmEYbNA0tnwDOHdFuRyZoB7kustonyUHoxRHx+g+Fqh
 SrFZmQY8OE54iDM1un9ZXOwKX6OFTw8iX6r0I8Ry33Hd9Mfsh4dRYZqtot6T7Xvskbsf
 sFl6bCtytEe0w+UJmEYT0Y2OiwDVuRQa7pAG30scJEJZkbsi7Z9wwGNvoV5ww3RPjqP1
 sEY9YIdzeVSXanxv0W/spPd9W9ZGrVtkp1n8qWK2At7mVISVaJLeg+68foIZz/sPkrQy
 +GVA808wx/cwftlSxzUIYo4f/izmTRJxrOBtFPBf2W4FWM+67XA/lmzD+pmkNiu8Kd6G
 A8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767806087; x=1768410887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7R7mEoVz559+pUzC2DlMmB9UCaLtYyTfUVcfnw+FhU=;
 b=gKxA+Rh/LTA5W5yueEdSl+qtQLuAvfcXQgACar0i6w1UTzhHUuwmMKtAJPLZQlPAZH
 2jj5/8NI/e8poE1ACK2qqM6PT9EUOt3eUZKNQYNUmPWvmMQ4OuZSqbWlwRlnvC3+lJmf
 no+fnl9ar8nrFpmkN8NUKq+yQlY7ceyUq6ARQ+UhqqHhQl3z+jmBeVJnu6l+4F/waQnr
 Hul1YbnItho7mcMgYch7pHE+4AZWat5VmEe9hohyXHx4cvjja8G5W/YAaHhHt8YFTmFj
 CLVvLWynpi+k0K2KsSMVXDhSo4VgeiqW/EK5zk6CzVN0IUiFS18tEgtQZPzDpGEBrSqt
 oYyA==
X-Gm-Message-State: AOJu0YyJoEwUqSUktK14SV1jbiLunCO4yza6jQpxKC796K8M001g4j4S
 aA1IKE+byEF113x6MtKVCKezrnDuO2BznZRKvgy2S3f3Fo2UzVJl4gFwH5UfxzH35CWoXqKIyaW
 rk3Q8sZkZK5jrfOsWAGgs9ipKdorJ7DPaW1cANn/gjX5g+pUO1udNNsfF
X-Gm-Gg: AY/fxX4Pfvo66WmLsU+HPuecasbCKw6EzKIl4BwBPod3aElIRcGbibnF/csUlp9DUbt
 5HcQM098QRl47RbGjZKAygzLpK/0MITYPLY8V24ztah+xhouJWjEumm9GQE2CWypGhuEITJQxPJ
 khqSCOUsGgml+4BN6D+NNbwM5anKv1hyDw4TlVv5r+p0ZLQCQp/CaYvQbviRb+3U+0KK5QHQNyp
 mn7xEfo+ZKqfSveyxpQ7I133TqIXEEV+sSErS5FTJe6MPOsYg6fEwXX90KAEKVGBY7FSVv3XUGT
 6Jh02Tg//TdH+pPPPRK162ToxuIa1Fn98eCJeLEScRPu4nBre8cU0TjzJ5pUOc70h1qLYX89RBp
 Kdbk=
X-Received: by 2002:a05:620a:1a24:b0:8bb:a037:fd90 with SMTP id
 af79cd13be357-8c388b7f4bbmr436797485a.12.1767806086782; 
 Wed, 07 Jan 2026 09:14:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1YV480F68kczEtVI/cm3nsOEVbi340L3pTWb0uq+RKvEuT1Xl08NF8UHbYKQFS5cz72GX2g==
X-Received: by 2002:a05:620a:1a24:b0:8bb:a037:fd90 with SMTP id
 af79cd13be357-8c388b7f4bbmr436792285a.12.1767806086181; 
 Wed, 07 Jan 2026 09:14:46 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4b917dsm428385285a.17.2026.01.07.09.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 09:14:45 -0800 (PST)
Date: Wed, 7 Jan 2026 12:14:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/2] tests/migration-test: Remove
 postcopy_recovery_fail_stage from MigrateCommon
Message-ID: <aV6UhNJzQLnDaJvO@x1.local>
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-3-peterx@redhat.com>
 <CAE8KmOz9XtaEY+LMD9CCCR_bMXe04chGHdvuwVqsYRNe+AtUJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOz9XtaEY+LMD9CCCR_bMXe04chGHdvuwVqsYRNe+AtUJg@mail.gmail.com>
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

On Wed, Jan 07, 2026 at 05:07:40PM +0530, Prasad Pandit wrote:
> On Wed, 7 Jan 2026 at 02:04, Peter Xu <peterx@redhat.com> wrote:
> > The parameter can be instead passed into the function.
> 
> * It'll help to include - why? pass the parameter instead.

I want to remove special and unnecessary fields in MigrateCommon struct.

I'll add a sentence when repost.

> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration/framework.h      |  6 ++----
> >  tests/qtest/migration/framework.c      |  7 ++++---
> >  tests/qtest/migration/postcopy-tests.c | 12 ++++--------
> >  tests/qtest/migration/tls-tests.c      |  8 ++++----
> >  4 files changed, 14 insertions(+), 19 deletions(-)
> >
> > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> > index 0d39bb0d3c..bc6cf6040f 100644
> > --- a/tests/qtest/migration/framework.h
> > +++ b/tests/qtest/migration/framework.h
> > @@ -228,9 +228,6 @@ typedef struct {
> >       * refer to existing ones with live=true), or use live=off by default.
> >       */
> >      bool live;
> > -
> > -    /* Postcopy specific fields */
> > -    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
> >  } MigrateCommon;
> >
> >  void wait_for_serial(const char *side);
> > @@ -243,7 +240,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
> >  void migrate_end(QTestState *from, QTestState *to, bool test_dest);
> >
> >  void test_postcopy_common(MigrateCommon *args);
> > -void test_postcopy_recovery_common(MigrateCommon *args);
> > +void test_postcopy_recovery_common(MigrateCommon *args,
> > +                                   PostcopyRecoveryFailStage fail_stage);
> >  int test_precopy_common(MigrateCommon *args);
> >  void test_file_common(MigrateCommon *args, bool stop_src);
> >  void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
> > diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> > index 4f46cf8629..d7a5ae56f9 100644
> > --- a/tests/qtest/migration/framework.c
> > +++ b/tests/qtest/migration/framework.c
> > @@ -739,7 +739,8 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to,
> >  #endif
> >  }
> >
> > -void test_postcopy_recovery_common(MigrateCommon *args)
> > +void test_postcopy_recovery_common(MigrateCommon *args,
> > +                                   PostcopyRecoveryFailStage fail_stage)
> ===
>     static void postcopy_recover_fail(QTestState *from, QTestState
> *to,
>                                        PostcopyRecoveryFailStage stage)
> ===
> 
> * To keep it consistent, maybe we can call the variable 'stage' as above?

Personally I prefer fail_stage, e.g. fail_stage=NONE means it never fails.
stage==NONE is less clear.

Thanks,

> 
> >  {
> >      QTestState *from, *to;
> >      g_autofree char *uri = NULL;
> > @@ -784,12 +785,12 @@ void test_postcopy_recovery_common(MigrateCommon *args)
> >      wait_for_postcopy_status(to, "postcopy-paused");
> >      wait_for_postcopy_status(from, "postcopy-paused");
> >
> > -    if (args->postcopy_recovery_fail_stage) {
> > +    if (fail_stage) {
> >          /*
> >           * Test when a wrong socket specified for recover, and then the
> >           * ability to kick it out, and continue with a correct socket.
> >           */
> > -        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
> > +        postcopy_recover_fail(from, to, fail_stage);
> >          /* continue with a good recovery */
> >      }
> >
> > diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> > index 7ae4d765d7..13a5759655 100644
> > --- a/tests/qtest/migration/postcopy-tests.c
> > +++ b/tests/qtest/migration/postcopy-tests.c
> > @@ -41,30 +41,26 @@ static void test_postcopy_preempt(char *name, MigrateCommon *args)
> >
> >  static void test_postcopy_recovery(char *name, MigrateCommon *args)
> >  {
> > -    test_postcopy_recovery_common(args);
> > +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
> >  }
> >
> >  static void test_postcopy_recovery_fail_handshake(char *name,
> >                                                    MigrateCommon *args)
> >  {
> > -    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY;
> > -
> > -    test_postcopy_recovery_common(args);
> > +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_RECOVERY);
> >  }
> >
> >  static void test_postcopy_recovery_fail_reconnect(char *name,
> >                                                    MigrateCommon *args)
> >  {
> > -    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH;
> > -
> > -    test_postcopy_recovery_common(args);
> > +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_CHANNEL_ESTABLISH);
> >  }
> >
> >  static void test_postcopy_preempt_recovery(char *name, MigrateCommon *args)
> >  {
> >      args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
> >
> > -    test_postcopy_recovery_common(args);
> > +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
> >  }
> >
> >  static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
> > diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> > index 6a20c65104..bf0bb06a29 100644
> > --- a/tests/qtest/migration/tls-tests.c
> > +++ b/tests/qtest/migration/tls-tests.c
> > @@ -385,7 +385,7 @@ static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
> >      args->start_hook = migrate_hook_start_tls_psk_match;
> >      args->end_hook = migrate_hook_end_tls_psk;
> >
> > -    test_postcopy_recovery_common(args);
> > +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
> >  }
> >
> >  static void test_multifd_postcopy_recovery_tls_psk(char *name,
> > @@ -396,7 +396,7 @@ static void test_multifd_postcopy_recovery_tls_psk(char *name,
> >
> >      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> >
> > -    test_postcopy_recovery_common(args);
> > +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
> >  }
> >
> >  /* This contains preempt+recovery+tls test altogether */
> > @@ -407,7 +407,7 @@ static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
> >
> >      args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
> >
> > -    test_postcopy_recovery_common(args);
> > +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
> >  }
> >
> >  static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
> > @@ -419,7 +419,7 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
> >      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> >      args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
> >
> > -    test_postcopy_recovery_common(args);
> > +    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
> >  }
> >
> >  static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
> 
> * Change looks okay otherwise.
> 
> Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


