Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664C0D0D145
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdX5Q-0006EY-0R; Wed, 07 Jan 2026 12:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdX5G-0006Bp-8t
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:12:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdX5C-0004do-1a
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767805948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fl8OoEB6ymyDAmvKR4gB28r6fFjQq90VwYdwgydSsu8=;
 b=Ra5yko4wUTZj4IS8XDWiVxQTBSU59FDlKSOyOkKA7mD79Nq7xtPcLBCALlpHyLe4KQX0wC
 W+klTVi4V0MEl0pjT5WZzLUZKvNqGWtM69BVx0fmnZNngG6BBdn3iHuvZvWTvmP0vWKcOU
 fwOU+qi9DFTbe+/NLh/QeUJDxT8GYdE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-OChKf6PDPEmvQWElujiN1w-1; Wed, 07 Jan 2026 12:12:27 -0500
X-MC-Unique: OChKf6PDPEmvQWElujiN1w-1
X-Mimecast-MFC-AGG-ID: OChKf6PDPEmvQWElujiN1w_1767805946
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a366fa140so28264616d6.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767805946; x=1768410746; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl8OoEB6ymyDAmvKR4gB28r6fFjQq90VwYdwgydSsu8=;
 b=IeBsyg9Xm/6YwWt4xjK6/EXaTa2TJ7Aq72PYHIyehDxq/4hdqG9eSJztKvsVJc1CQq
 cPpmcC4Jihl3PzzcYm1AXyaWEwbtn8IMAE9iAkqYo7Of9GavZfr6yvUAI8twR+uezUnT
 skfGyvvOFWl0XxxC1KvdqGk6X3Y9Qy53lEHprVt3inJFIyREWh3Q5khcguoLNdcntyWH
 SS3bjSQT+pCswNJ2NRUqWrZl3vYywYXhE0u9xQa9/AzhXEzGlXz7XtMXu0NdXRFS5eL3
 T4YOmYOUCrjVl65Kb2kajNwrfU9nMesleXEQLilF35qotuQP49acCx2h09iHguPGR5py
 yTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767805946; x=1768410746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fl8OoEB6ymyDAmvKR4gB28r6fFjQq90VwYdwgydSsu8=;
 b=NSs373a9Hs5p6iSuWZkIwVLladBj7R2gyhrVEuIlRWepKmG6FOQFpYbZX6iDH4nAzx
 s2m676PqedFjrDox9Aaj3qOzaCOqD8YJbdzWdclCXC3LFTU13aUFQBUi7Z7ZU+bHk58L
 XuqG+buZ4cH4rx613fQnDEDETKMgiP6v7QIupRnNEk3rjEWy6qG7rEDaxB+Z6FWj6s21
 fEA9EDcAss7iBsIdhxGUdoQc8uheZSKtjg2OPe+OQpPxTF+H0ICYbQsA1wuikzwvDq+6
 NvZB1nUWdG85ANbwZNVWnX7uKdyxFxgty3GRzdDk+bgnHKgH4CVxSWi+sxKy/oHCkrY5
 4fIQ==
X-Gm-Message-State: AOJu0YwLzGuUWVCrCAJtv8kN+YhWelqqkUFxM6/TEsQL30LZz0uujAWO
 ed1tJCWXGF1LNiQKN5/odj544JDZTaP6Nd5N9TecIUoL3doEI00FaQaVfRd9WQdr15dEt23bhmj
 N6l5dRgLA/zNKyHfsDMCT8jSmUUKJYoQzuDCrk5scEwSQjs/Ds6i87kdRGd4v0ACk
X-Gm-Gg: AY/fxX7YBHyl5tjQuLDPPavItPArvteYGgRc3GvhGx9ipMASuxt3J5a0fBBdK2ugnD2
 9TBLOp6KcZotlbf2HDMeo5PDlYGAJ3mZU2NqxxpgTqy46Fe0uUMdsRU6veN1r+gSEyWtwS/fRqE
 m7sNDf9NlnenP11QhLHmfRUBS3Hqw0K5nqncW7XNu/4hfCTGKctk+h5irbndDQe6eF3XZuWt35r
 zbuW3tDi6ET49I+meS2jyttvcHDgjWVzV4hoH5CEUcAbCf/dSZQm+2kgNshUbIPfg0URa952093
 JcdZK+MdQQZMxjaQQY7js5eV11vWs3CIRRbUsf4CbpzesnmG/gRxMKm8KDCvpcww4mHS8Eou0YW
 C/Sg=
X-Received: by 2002:a05:6214:21c3:b0:880:3e92:3d33 with SMTP id
 6a1803df08f44-89084255090mr44803106d6.34.1767805946099; 
 Wed, 07 Jan 2026 09:12:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW0t6QXUjb83V5NW+JpP/lqNjdARqCfdtCyX82IOmqpxY2Onfjoe3lIKGIbXEOC62LzugJog==
X-Received: by 2002:a05:6214:21c3:b0:880:3e92:3d33 with SMTP id
 6a1803df08f44-89084255090mr44802586d6.34.1767805945558; 
 Wed, 07 Jan 2026 09:12:25 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffaac486efsm31480841cf.27.2026.01.07.09.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 09:12:25 -0800 (PST)
Date: Wed, 7 Jan 2026 12:12:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 1/2] tests/migration-test: Remove postcopy_data from
 MigrateCommon
Message-ID: <aV6T-JDXv3wa7tdc@x1.local>
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-2-peterx@redhat.com>
 <CAE8KmOwA-SVy1tQOzAKpa6B4uoVw=veMcn3qzkF0KJ8Cq0C_8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwA-SVy1tQOzAKpa6B4uoVw=veMcn3qzkF0KJ8Cq0C_8w@mail.gmail.com>
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

On Wed, Jan 07, 2026 at 04:53:17PM +0530, Prasad Pandit wrote:
> On Wed, 7 Jan 2026 at 02:04, Peter Xu <peterx@redhat.com> wrote:
> > Now postcopy is not the only user of start_hook / end_hook that will pass
> > in a opaque pointer.  It doesn't need to be defined in MigrateCommon as
> > part of the framework, as all other hook users can pass hook_data around.
> > Do it too for postcopy.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration/framework.h |  1 -
> >  tests/qtest/migration/framework.c | 18 ++++++++++--------
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> > index ed85ed502d..0d39bb0d3c 100644
> > --- a/tests/qtest/migration/framework.h
> > +++ b/tests/qtest/migration/framework.h
> > @@ -230,7 +230,6 @@ typedef struct {
> >      bool live;
> >
> >      /* Postcopy specific fields */
> > -    void *postcopy_data;
> >      PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
> >  } MigrateCommon;
> >
> > diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> > index e35839c95f..4f46cf8629 100644
> > --- a/tests/qtest/migration/framework.c
> > +++ b/tests/qtest/migration/framework.c
> > @@ -541,6 +541,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
> >
> >  static int migrate_postcopy_prepare(QTestState **from_ptr,
> >                                      QTestState **to_ptr,
> > +                                    void **hook_data,
> >                                      MigrateCommon *args)
> >  {
> >      QTestState *from, *to;
> > @@ -554,7 +555,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
> >      }
> >
> >      if (args->start_hook) {
> > -        args->postcopy_data = args->start_hook(from, to);
> > +        *hook_data = args->start_hook(from, to);
> >      }
> >      migrate_ensure_non_converge(from);
> > @@ -582,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
> >  }
> >
> >  static void migrate_postcopy_complete(QTestState *from, QTestState *to,
> > -                                      MigrateCommon *args)
> > +                                      void *hook_data, MigrateCommon *args)
> >  {
> >      MigrationTestEnv *env = migration_get_env();
> >
> > @@ -601,8 +602,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
> >      }
> >
> >      if (args->end_hook) {
> > -        args->end_hook(from, to, args->postcopy_data);
> > -        args->postcopy_data = NULL;
> > +        args->end_hook(from, to, hook_data);
> >      }
> >
> >      migrate_end(from, to, true);
> > @@ -610,13 +610,14 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
> >
> >  void test_postcopy_common(MigrateCommon *args)
> >  {
> > +    void *hook_data = NULL;
> >      QTestState *from, *to;
> >
> > -    if (migrate_postcopy_prepare(&from, &to, args)) {
> > +    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
> >          return;
> >      }
> >      migrate_postcopy_start(from, to, &src_state);
> > -    migrate_postcopy_complete(from, to, args);
> > +    migrate_postcopy_complete(from, to, hook_data, args);
> >  }
> >
> >  static void wait_for_postcopy_status(QTestState *one, const char *status)
> > @@ -742,6 +743,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
> >  {
> >      QTestState *from, *to;
> >      g_autofree char *uri = NULL;
> > +    void *hook_data = NULL;
> 
> * Should 'hook_data' pointer be g_autofree too? Where is it free'd otherwise?

hook_data is freed in end_hook().  This patch doesn't change that fact for
postcopy.  It's the smae to non-postcopy tests.

> 
> >      /*
> >       * Always enable OOB QMP capability for recovery tests, migrate-recover is
> > @@ -752,7 +754,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
> >      /* Always hide errors for postcopy recover tests since they're expected */
> >      args->start.hide_stderr = true;
> >
> > -    if (migrate_postcopy_prepare(&from, &to, args)) {
> > +    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
> >          return;
> >      }
> >
> > @@ -808,7 +810,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
> >      /* Restore the postcopy bandwidth to unlimited */
> >      migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
> >
> > -    migrate_postcopy_complete(from, to, args);
> > +    migrate_postcopy_complete(from, to, hook_data, args);
> >  }
> >
> >  int test_precopy_common(MigrateCommon *args)
> 
> * The changes look okay; But if tests define hook_data = NULL; Where
> does it get populated?

It's populated in start_hook() conditionally.  When populated, it is always
(and a must) to be released in end_hook().

Thanks,

-- 
Peter Xu


