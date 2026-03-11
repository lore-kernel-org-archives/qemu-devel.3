Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27653106286B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IBO-00077e-If; Wed, 11 Mar 2026 07:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0IBM-00077U-Oo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0IBI-0004DN-Nv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773230210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZWCOfnSTZaNddYFcTXxhPDLbJWNn6W8B38ew0C4mm8=;
 b=VZcbZbwJUYfMavg6WnbDEkUmlBlAE8fd/RHbAX6ul6i678DG4nJLYXb0Ms88WSZzIR0cmN
 YS4bVPuWocYpok3ru1zF28EBtQPapVttDXg4HKvlhWOFnpKfJ1F0cT3lOtUKaOZ3/kEPXZ
 I0JIlpg6sDiZtJjFUHRJ01GQKK5Jj2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-juZuyfv-NoOK8a__or_F3Q-1; Wed, 11 Mar 2026 07:56:47 -0400
X-MC-Unique: juZuyfv-NoOK8a__or_F3Q-1
X-Mimecast-MFC-AGG-ID: juZuyfv-NoOK8a__or_F3Q_1773230206
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4852cf0318dso47227665e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773230206; cv=none;
 d=google.com; s=arc-20240605;
 b=ZvFZvWtDPtYZB7vRJV1KliPrqkBdYx9XLhwgX8U08JTDhOCdwqdmM7qHW9Be0cXhoZ
 LYA0akVpYtgQ8kbTZEcEYOZeJ6k7LBj8AcW4MbDFnEJC/9ddK7ZfxQcNpnOCVxtx5zJ4
 jR8xPQJtaAwUBdVgo7qvLUuCU03dRJ/a5qHW1uZqKbTGXa72GxBxglhHcHmA5gnoCxBc
 HR/0e3d6oM15tE0gari+PuFuoSmqcjGLEOEQ1EfJwLJHCoiZDXP/bV0vLJrAZ4EGV+dD
 8XrdNlgpUAgnsf/kGPS8x1DlIbaXnrlRXLtdXQjDUZ12kBn+SPmRL217wqCo4NA3aNzl
 W1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WZWCOfnSTZaNddYFcTXxhPDLbJWNn6W8B38ew0C4mm8=;
 fh=jJSuppldnKTzKFj6lwnMFqs9z6PbYca7cw17lgQhG4M=;
 b=LgZx5NIaJSXtA8B7kxxVqOQTSFkumKB7iyh2UEKUzrl5NyzwgG86rA32pkeZKLAa/S
 msK5yVdfSIuiuWa/opWp6dU/KDicDe7/78Kt/F6nFfxFSDEYm/wrjvjEQCTAFBy+loEo
 VwkQnQwQ1EqQ9iQCEzzN7G0qhMJgOFZPmgHnaHJrqosP4U9rJ4Qebkk2dPRUejwCCUmY
 TJ7fjjRXLmjVPdmFlPR3bcjbZEByx3hVC4r1uxV3XzdBed4Ug0HwWnDsWxbGiqvrBllf
 XFwy9lpnjxKDiQ5akWZJpVHIZy6y9IJ2jBItgVy2NC+c3fJaDslMOuNM/Bsw+2pl2zdv
 rzSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773230206; x=1773835006; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WZWCOfnSTZaNddYFcTXxhPDLbJWNn6W8B38ew0C4mm8=;
 b=t4C3VKqZJ3ivEmKXlCypJAMvCpHQmYDB7uuc9oPwWhJoMgdfQT1v77JBCLYuaa4jkJ
 9K7bsCzE6XN1RsfnpTXTSe1kkPYbZBcYB+MK7IQCbViQyl5vZP7usbSRHHCEYOeYOhgx
 Hut9d3hxNOG27n0cZLXm0OXJl4pOf+fjfZkS+pA8ks9Fnhnm0HKd6n2BKCTMnhSy7zU2
 iuPCExgdGUDRewQd5GojRPccDPBc6nyrU3theBBqMsr28DwowtfZpxcnXLzoE5K2DnX/
 JnSsotbVPe0JK+cm021w+1+gCwTxyYXQKekPrQZ0kMDqmBFEDbkPTGTfPVL2anWaOrm+
 afEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773230206; x=1773835006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZWCOfnSTZaNddYFcTXxhPDLbJWNn6W8B38ew0C4mm8=;
 b=c8rda/xYN8H17ZxVt52poMRYlzza/hPs2YpQ6l/PL0/EwM4l5lnA3SAXQ9fqd+t/jJ
 JvsKSp+/hbXkaacN5kaxugV9N8ZOv9k+H2uN6h6kdv4pfrKpCEDqvjuA2I/Iwd3vBxTl
 cM09lGPniKIY3RpCvDlOr0GzAISYKO/s7imY74N/2l0DPvwItMOH5T4N316Irq05BBqO
 pXljuNXZ+5rFs6yoZVFRugN3cz0bOcTEAsDax5pie5FtMvxY70KOKAU+K1Ouz5T+FUsx
 4BVEvDKlAJ/9SCYpwv+h+tOh4yWU5ZPTho3e1jg29Fj4tFGaMrHQcaHADVhuo/fMiSiO
 Uo2w==
X-Gm-Message-State: AOJu0YwzEkM7uhc5Cg2aumGuDfwEk805V5SLZcEwdk9vAav0yfe9PJrn
 XaDrcOMiQdeyutPkoCbZRcRN3nB/P35NCNmmVYY1VL4Gi0KsciA7aE3kFj0sqYYN0lTYJTkYCQA
 okReXGwHhkHRumvBku9oD7rVcK3r80zM/jMdnvxM8LFicy6hlf/dayMPURlYalcjyQ2u6K0BDm0
 dMXoyI8VXHbf/z6uxvHJJzuPzm8d1onlI=
X-Gm-Gg: ATEYQzwb4AEzmhhzmHqabF1sb3FSKYwE6Vlt2znSAF1PpM/2pAlC/6FOTWjBE9VI2XK
 dhw7ZLfF5MxCh9HBEwFUEsqXLiybBuZ68eyZenntHpAB1dnxTV8UXwJAUDDXHBGkYpHnQrXOeJI
 rhC0Y9osi74VnSjHVLipwzVmDQzsUjyV5KUf2N2EqfZ4UatsdSLkiXuTjQrlc3mFAHUe4or/88D
 hLakr+SxVvdjAP5iO2luOTsogBIXJoQG6XvYLSC3xcbCBIbhBCNnns3xRvabtsoOU81
X-Received: by 2002:a05:600c:a44:b0:485:4100:1eee with SMTP id
 5b1f17b1804b1-4854b10c539mr34987475e9.24.1773230205701; 
 Wed, 11 Mar 2026 04:56:45 -0700 (PDT)
X-Received: by 2002:a05:600c:a44:b0:485:4100:1eee with SMTP id
 5b1f17b1804b1-4854b10c539mr34987045e9.24.1773230205228; Wed, 11 Mar 2026
 04:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260310135540.8679-1-farosas@suse.de>
In-Reply-To: <20260310135540.8679-1-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 11 Mar 2026 17:26:28 +0530
X-Gm-Features: AaiRm50BsmrHxtgA1TvxXn0E2Lx0C8IxbgsLLibIki0DkGbFz27lW5BXGvYR8xs
Message-ID: <CAE8KmOx5XbY1m40gGb5_kDOwt5D_YMT1YDp1JFugK-6NMRW3YA@mail.gmail.com>
Subject: Re: [PATCH 1/8] tests/qtest/migration: Fix leak of migration tests
 data
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 10 Mar 2026 at 19:26, Fabiano Rosas <farosas@suse.de> wrote:
> When the migration-test is invoked with the '-p' flag (to run a single
> test), the glib code won't call the destroy function for the
> not-executed tests, causing the MigrationTest wrapper data to leak.

* With -p, only test data for that test should be loaded, right?
Freeing the data for non-executed tests does not seem right.

> This doesn't affect make check, but affects debugging use-cases where
> having a leak pop up in ASAN output is extra annoying.
>
> Fix by adding the tests data to a list and freeing them all at the end
> of migration-test execution. Any tests actually dispatched by glib
> will have the destroy function called as usual.
>
> Note that migration_test_add_suffix() is altered to call
> migration_test_add() so that there's only one place adding the data to
> the list.
>
> Performance is not an issue at the moment, we have < 100 tests.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/framework.c      |  2 ++
>  tests/qtest/migration/migration-util.c | 19 ++++++++++++++-----
>  tests/qtest/migration/migration-util.h |  2 +-
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 0bfc241914..b9371372de 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -1162,5 +1162,7 @@ int migration_env_clean(MigrationTestEnv *env)
>      }
>      g_free(tmpfs);
>
> +    migration_tests_free();
> +
>      return ret;
>  }
> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
> index c2462306a1..2648ad7f61 100644
> --- a/tests/qtest/migration/migration-util.c
> +++ b/tests/qtest/migration/migration-util.c
> @@ -38,6 +38,7 @@
>  #include "linux/kvm.h"
>  #endif
>
> +GQueue *tests;
>
>  static char *SocketAddress_to_str(SocketAddress *addr)
>  {
> @@ -243,6 +244,8 @@ static void migration_test_destroy(gpointer data)
>  {
>      MigrationTest *test = (MigrationTest *)data;
>
> +    g_queue_remove(tests, test);
> +
>      g_free(test->data);
>      g_free(test->name);
>      g_free(test);
> @@ -268,21 +271,27 @@ void migration_test_add(const char *path,
>
>      qtest_add_data_func_full(path, test, migration_test_wrapper,
>                               migration_test_destroy);
> +    if (!tests) {
> +        tests = g_queue_new();
> +    }
> +    g_queue_push_tail(tests, test);
>  }
>
>  void migration_test_add_suffix(const char *path, const char *suffix,
>                                 void (*fn)(char *name, MigrateCommon *args))
>  {
> -    MigrationTest *test = g_new0(MigrationTest, 1);
> +    g_autofree char *name = NULL;
>
>      g_assert(g_str_has_suffix(path, "/"));
>      g_assert(!g_str_has_prefix(suffix, "/"));
>
> -    test->func = fn;
> -    test->name = g_strconcat(path, suffix, NULL);
> +    name = g_strconcat(path, suffix, NULL);
> +    migration_test_add(name, fn);
> +}
>
> -    qtest_add_data_func_full(test->name, test, migration_test_wrapper,
> -                             migration_test_destroy);
> +void migration_tests_free(void)
> +{
> +    g_queue_free_full(tests, migration_test_destroy);
>  }
>
>  #ifdef O_DIRECT
> diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
> index e73d69bab0..694773e594 100644
> --- a/tests/qtest/migration/migration-util.h
> +++ b/tests/qtest/migration/migration-util.h
> @@ -59,5 +59,5 @@ void migration_test_add_suffix(const char *path, const char *suffix,
>                                 void (*fn)(char *name, MigrateCommon *args));
>  char *migrate_get_connect_uri(QTestState *who);
>  void migrate_set_ports(QTestState *to, QList *channel_list);
> -
> +void migration_tests_free(void);
>  #endif /* MIGRATION_UTIL_H */
> --

* Change looks okay. Still I think there could be a way to load only
the data required for the specific test.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


