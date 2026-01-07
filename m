Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E8CCD583B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 11:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdRdg-00058W-3N; Wed, 07 Jan 2026 06:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdRdd-0004yL-KW
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdRdb-0001Wn-EC
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767785017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9CVOFgYvcab9tFb37MSVBS/BDqI6hyaB8Sjo503Sz04=;
 b=hPXeJulrnzT2bYUdxb2VyWaRz7finqTBmZcE716hNh9H9VR6dIweIRAEb418uvAXBtRLND
 7vJL1kgWKTLLtEljB5/XjC+UsSwj2B3c1vxGz44Cp4gqgCOtYOH8+0UI0zzc0HL055PZqf
 NON7PNyJ2cpdPba9QelQkG6M/baTY5I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-QZyKFiC7Ohii7kmP0AzwBg-1; Wed, 07 Jan 2026 06:23:35 -0500
X-MC-Unique: QZyKFiC7Ohii7kmP0AzwBg-1
X-Mimecast-MFC-AGG-ID: QZyKFiC7Ohii7kmP0AzwBg_1767785015
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso20228975e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767785015; x=1768389815; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9CVOFgYvcab9tFb37MSVBS/BDqI6hyaB8Sjo503Sz04=;
 b=IMwD8yWK2HEyXHZP42NlIRpbVHGaDXclloazPN9i9ax1ZDMOUb1UuwQFecJ26GM6JL
 VOP9QiSgNWABwRJuPpaefOL9A2UHqeCecGkOoEuJ4f24nMefs3f0qdzZ+qu0UiQIUEWS
 PqAQI9Byqm9eigEXzhl4M99Dr0qWxReV4LURonMtqfn89Ynd/k/2FXxhJmKdRznVR8Zd
 vWjDhUBKSWbdUSBw4VMpB/JIbJnXh3wXVoa9mpcq8oB/DjZvToKqcSSOC25PlfPJlTAh
 RCeNt1j59ksgsxc7ZuEpUOtaKizBaI8vm8Jb+/tnESqibug4pEZcN+nIgj1X7FVSKLMy
 Z85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767785015; x=1768389815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9CVOFgYvcab9tFb37MSVBS/BDqI6hyaB8Sjo503Sz04=;
 b=wOOiJWbgN/XFylnDQx/HTU0fNSivqRBifp+zMfWjmbaHO5WIo87ExgJ7O7EnSz5Q5P
 SRKtLlE35emiMN83CiXF98VrinePIgPJ7nCqm/LDuKNGAZ2QdAcFnRB/4SS81uclU9jg
 Po7OwkcpZ/MEN3KFdYg8j97FOjAmtJKgPSCQ/MQm62ctnBiAQtLsuxuKOoexFn8t9EYy
 xjq4VI9ceo+bnh5mP5C687KRuWDrndkJNOfBIx8LRZcSRoq1VDxCUa/FHF2dWpFCAqUS
 u89anIrhO1QzSYjrypoCbG7OB+24MpCDO0Fyy17v6tg9cpsEPsehHhbRG9ZARoQWTFP9
 Ggsg==
X-Gm-Message-State: AOJu0Yw+QqYEW10KCUC50tuCCzUnVl5VhHYEU0sgwMrL//FxM8w9qFaV
 QyO28A/JBIsuE9YA+XS3I6LGHWmaYt75zWjxyJ0niRnWiYml+v5QuQBnnMVPa3qEDz7ulBZ2Fra
 Ka6IVcac1Sc6lJrSALiE4bRkSHfN0Rr3VW+hdkzT/KPKRyMQZZqCJTcrCqwVQ63Tf1PbtgzyjOd
 2IhRqQt+A1duRjMYF6vmL64YUmXU3yfxI=
X-Gm-Gg: AY/fxX5Rij48B8r11d9sFVuh8lMUuBi6Ae0miKkfwNqjiNH2ev9sG5vx/bIbqntiY/e
 PwXVvzYGQyT8JBKkeF1jxUlxfTp7Wwj+OglFxFIIOcl6ryGo5+6SJCUY4sLNjN25PrvMDYVK3If
 uhqbu3XjVd/OxmvTbHOZwKWsodoi6mWojKHHmKH9AuV3Vg1a13D8fSzy6BVpiA59phsfY=
X-Received: by 2002:a05:600c:3114:b0:47d:403e:90c9 with SMTP id
 5b1f17b1804b1-47d84b18663mr23871735e9.11.1767785014524; 
 Wed, 07 Jan 2026 03:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8dlfRkDZ0I9wI5A445iRrJuaZf8qiwxRCTBQ4fpLzDt1HoqdTi7RRZZ1seHyRFFheyzkLyE/+d5GNnCIMyjg=
X-Received: by 2002:a05:600c:3114:b0:47d:403e:90c9 with SMTP id
 5b1f17b1804b1-47d84b18663mr23871005e9.11.1767785014107; Wed, 07 Jan 2026
 03:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-2-peterx@redhat.com>
In-Reply-To: <20260106203320.2110372-2-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 7 Jan 2026 16:53:17 +0530
X-Gm-Features: AQt7F2qX8zV6RG8uhHbhTAw3_KlEGrepDsImVg0WrJbG0hSMk5JbE5GQhoNACIQ
Message-ID: <CAE8KmOwA-SVy1tQOzAKpa6B4uoVw=veMcn3qzkF0KJ8Cq0C_8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests/migration-test: Remove postcopy_data from
 MigrateCommon
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
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

On Wed, 7 Jan 2026 at 02:04, Peter Xu <peterx@redhat.com> wrote:
> Now postcopy is not the only user of start_hook / end_hook that will pass
> in a opaque pointer.  It doesn't need to be defined in MigrateCommon as
> part of the framework, as all other hook users can pass hook_data around.
> Do it too for postcopy.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/framework.h |  1 -
>  tests/qtest/migration/framework.c | 18 ++++++++++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index ed85ed502d..0d39bb0d3c 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -230,7 +230,6 @@ typedef struct {
>      bool live;
>
>      /* Postcopy specific fields */
> -    void *postcopy_data;
>      PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
>  } MigrateCommon;
>
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index e35839c95f..4f46cf8629 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -541,6 +541,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
>
>  static int migrate_postcopy_prepare(QTestState **from_ptr,
>                                      QTestState **to_ptr,
> +                                    void **hook_data,
>                                      MigrateCommon *args)
>  {
>      QTestState *from, *to;
> @@ -554,7 +555,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      }
>
>      if (args->start_hook) {
> -        args->postcopy_data = args->start_hook(from, to);
> +        *hook_data = args->start_hook(from, to);
>      }
>      migrate_ensure_non_converge(from);
> @@ -582,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>  }
>
>  static void migrate_postcopy_complete(QTestState *from, QTestState *to,
> -                                      MigrateCommon *args)
> +                                      void *hook_data, MigrateCommon *args)
>  {
>      MigrationTestEnv *env = migration_get_env();
>
> @@ -601,8 +602,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
>      }
>
>      if (args->end_hook) {
> -        args->end_hook(from, to, args->postcopy_data);
> -        args->postcopy_data = NULL;
> +        args->end_hook(from, to, hook_data);
>      }
>
>      migrate_end(from, to, true);
> @@ -610,13 +610,14 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
>
>  void test_postcopy_common(MigrateCommon *args)
>  {
> +    void *hook_data = NULL;
>      QTestState *from, *to;
>
> -    if (migrate_postcopy_prepare(&from, &to, args)) {
> +    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
>          return;
>      }
>      migrate_postcopy_start(from, to, &src_state);
> -    migrate_postcopy_complete(from, to, args);
> +    migrate_postcopy_complete(from, to, hook_data, args);
>  }
>
>  static void wait_for_postcopy_status(QTestState *one, const char *status)
> @@ -742,6 +743,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
>      g_autofree char *uri = NULL;
> +    void *hook_data = NULL;

* Should 'hook_data' pointer be g_autofree too? Where is it free'd otherwise?

>      /*
>       * Always enable OOB QMP capability for recovery tests, migrate-recover is
> @@ -752,7 +754,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
>      /* Always hide errors for postcopy recover tests since they're expected */
>      args->start.hide_stderr = true;
>
> -    if (migrate_postcopy_prepare(&from, &to, args)) {
> +    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
>          return;
>      }
>
> @@ -808,7 +810,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
>      /* Restore the postcopy bandwidth to unlimited */
>      migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
>
> -    migrate_postcopy_complete(from, to, args);
> +    migrate_postcopy_complete(from, to, hook_data, args);
>  }
>
>  int test_precopy_common(MigrateCommon *args)

* The changes look okay; But if tests define hook_data = NULL; Where
does it get populated?

Thank you.
---
  - Prasad


