Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E543D66BA1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVy6O-0004eB-RB; Wed, 17 Dec 2025 15:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVy6N-0004c7-8F
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:26:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVy6L-0005fd-6n
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766003183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cWvMel2LH6i3672nUNVySmqmzCL3jXodXMENhc6a4oE=;
 b=F74CmtjYdUWaIaElWL79Dg3q79H/HbVi+xcSlZa+jAf99JbSm6ngNGriiOA6evTU8seVZq
 dSypXvOgZT2txcY+r3rLvfmgjkboLBA1aFn/cJolWiYVqH6zj5Cu8ZfPW8roX0Amud2pyX
 Tf0k9neYJ66cjqsMjRVSf8m2GWzlLpY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-kE6pgYx7Mvaxs9CGnvOiVA-1; Wed, 17 Dec 2025 15:26:22 -0500
X-MC-Unique: kE6pgYx7Mvaxs9CGnvOiVA-1
X-Mimecast-MFC-AGG-ID: kE6pgYx7Mvaxs9CGnvOiVA_1766003181
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b286006ffaso1629468885a.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766003181; x=1766607981; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cWvMel2LH6i3672nUNVySmqmzCL3jXodXMENhc6a4oE=;
 b=VOhMPv1lqbcsFUy/l55xRlyrsI23F1fyyhGZ6HoAjtyjiJctf+7wmTtdE+h8J9t6g0
 2112Sozdq1wF2MPyBLmHUxC7RprZE4gMr7qQxLAzvxIxIkUUhLTJhTbeHrcTKvMuarUw
 ujb5Rq2Ejr52vLht7hdSrKD3fEJAMPdKoYuYiZoX8IGVsSoa0xc72vUX2ybaivVyc5aD
 nuMfIbMzgENjpoHhz6DBmUajDAO6hdAIOMRXHEPLcQG+90kLmcJ2MHWzbJbkWsI+iOGP
 vXwvRWKmhp314X/hRlwzrDzI95kBnznmTwplHYpG266yvSXs5QSPmSRlo/EFJ9RJ407l
 GhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766003181; x=1766607981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWvMel2LH6i3672nUNVySmqmzCL3jXodXMENhc6a4oE=;
 b=RVSolUgVJ9c1XwT/WmOzcsP3gSJt2pf8BZ1lRKg8tbKSdRGWAhguzYPZXDK0vNkplZ
 7hGFs+omGYkfg1fnlbUs63Opvny5rOVucFKP8xhHmkvNiSTqIGMeWuFkZuzX7c2O5u2J
 pxv/iuAXr5NIhiG8wEe8UKkYWWUffxWu4e1Eqd8c0vd9bZiwQod9G+cXOsUlC2DDbl4n
 6npHgQnoTwB4OD9DdcPpx5uUVdpqtIf8LmZlYANy0zieiJQEyxJW/m9TGyPFLzQIs1Vs
 2bZpx037aaPe/fycHQIjSnEDYX2xSPx50KHN7QbpLODSHYyBvzgd+dnPWEXV8/9sJu48
 RnAA==
X-Gm-Message-State: AOJu0YzJOBPlnPfYOqFrHpQyFuoWBKMo1QPe7HcmIgd0zF+HhF74kQe6
 HcAJlDqWqciw7Uu7kGnbpOGmw0Mn3gKCvMvM1SEv2r37/qaMWJcyOWlXDufocjTOvyz8zl7qZn9
 zlnVFJLQve/G0tszSkdxo5e2M2F2IcR1GdRhp0HNk0+RzEgi/A916Y+TS
X-Gm-Gg: AY/fxX6hWbsqWKHe3HLxfyTz9AxP5lBFidAgTEWpMySbmz7/HUGf4yY/aAKdmYxhfWQ
 ZwDoMoP7a9W16983Lbz/EE7gZMowKRr0gD3f9Ot6pSdA+Hzgv2UY/B7eC0058WSnlro1L959bXP
 6xf/wyRK3xBYr/EraQw7dAfrJV9Y3YNKu0yQ/EhyHqr0cSKpue8y8S6R8Fz6mB0Ba46j8S6Pyn4
 ZbfCgR4MyBc84ObudVFsXZDhA+KAbXwrjYAvQIx8Yd9kB6eAbr/CG+c3kBWihFH/sgM3/uN8jO5
 zWxMenVkCnitYrIH+Mi0bSZgj3Eg+1x9ot6piYF1ru/6ES9dRwRzkEAlf7f2ZUe6TbaI7k/zavm
 B1Bk=
X-Received: by 2002:a05:620a:4606:b0:89f:db05:408e with SMTP id
 af79cd13be357-8bb3b3701admr2498543185a.85.1766003181271; 
 Wed, 17 Dec 2025 12:26:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY8b2kmUUp485ianjWfZAQRYJOvYRy3B7FoZhopfU/6+GJsDfATDb5L6J+UPo809YJErVbTA==
X-Received: by 2002:a05:620a:4606:b0:89f:db05:408e with SMTP id
 af79cd13be357-8bb3b3701admr2498538585a.85.1766003180694; 
 Wed, 17 Dec 2025 12:26:20 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8beeba39aaesm18945685a.39.2025.12.17.12.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 12:26:20 -0800 (PST)
Date: Wed, 17 Dec 2025 15:26:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 28/51] tests/qtest/migration: Stop invoking
 migrate_incoming from hooks
Message-ID: <aUMR699ZHbiF7_lh@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-29-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-29-farosas@suse.de>
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

On Mon, Dec 15, 2025 at 07:00:14PM -0300, Fabiano Rosas wrote:
> Now that the listen_uri is being properly used, tests can stop calling
> migrate_incoming from their hooks. The _common functions and
> migrate_start should take care of that.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

IMHO this patch is almost fine,

Reviewed-by: Peter Xu <peterx@redhat.com>

still, some thoughts inline.

> ---
>  tests/qtest/migration/compression-tests.c |  6 ++++++
>  tests/qtest/migration/framework.c         | 14 +++++++++++---
>  tests/qtest/migration/precopy-tests.c     |  7 ++++---
>  tests/qtest/migration/tls-tests.c         |  8 ++++++++
>  4 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index eb0b7d6b4b..bed39dece0 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -33,6 +33,7 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
>  
>  static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri = "tcp:127.0.0.1:0";

Definitely a step forward to unify migrate_incoming into the precopy
framework, however lots duplication of this "tcp:*" string..

Shall we provide some migrate_common_set_listen_uri_default()?

>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
>  
>      args->start.incoming_defer = true;
> @@ -43,6 +44,7 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
>  
>  static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri = "tcp:127.0.0.1:0";
>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
>  
>      args->start.incoming_defer = true;
> @@ -66,6 +68,7 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
>  
>  static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri = "tcp:127.0.0.1:0";
>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
>  
>      args->start.incoming_defer = true;
> @@ -85,6 +88,7 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
>  
>  static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri = "tcp:127.0.0.1:0";
>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
>  
>      args->start.incoming_defer = true;
> @@ -104,6 +108,7 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
>  
>  static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri = "tcp:127.0.0.1:0";
>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
>  
>      args->start.incoming_defer = true;
> @@ -156,6 +161,7 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
>  
>  static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri = "tcp:127.0.0.1:0";
>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
>  
>      args->start.incoming_defer = true;
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index e811945122..199e439263 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -820,6 +820,9 @@ int test_precopy_common(MigrateCommon *args)
>      QObject *out_channels = NULL;
>  
>      g_assert(!args->cpr_channel || args->connect_channels);
> +    if (args->start.incoming_defer) {
> +        g_assert(args->listen_uri || args->connect_channels);
> +    }
>  
>      if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>          return -1;
> @@ -829,6 +832,14 @@ int test_precopy_common(MigrateCommon *args)
>          data_hook = args->start_hook(from, to);
>      }
>  
> +    if (args->start.incoming_defer && !args->start.defer_target_connect) {
> +        if (args->connect_channels) {
> +            in_channels = qobject_from_json(args->connect_channels,
> +                                            &error_abort);
> +        }
> +        migrate_incoming_qmp(to, args->listen_uri, in_channels, "{}");
> +    }

The changes here in the framework code looks all correct, even though I
don't think "connect_channels" is used here in this patch.

Said that, IMHO the channel management is chaos right now in our qtest..
At least it took me some time staring at this path when reviewing.

IMHO a major reason is due to the cpr complexities.

E.g. test_mode_transfer_common() used different things to specify incoming
channels (cpr_channel, opts_target, connect_channels).  We should clean
them up at some point..

> +
>      /* Wait for the first serial output from the source */
>      if (args->result == MIG_TEST_SUCCEED) {
>          wait_for_serial("src_serial");
> @@ -1060,9 +1071,6 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
>      migrate_set_parameter_str(from, "multifd-compression", method);
>      migrate_set_parameter_str(to, "multifd-compression", method);
>  
> -    /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
> -
>      return NULL;
>  }
>  
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index d9c463dd0f..ab5789717f 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -239,9 +239,6 @@ static void *migrate_hook_start_fd(QTestState *from,
>                                   "  'arguments': { 'fdname': 'fd-mig' }}");
>      close(pair[0]);
>  
> -    /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
> -
>      /* Send the 2nd socket to the target */
>      qtest_qmp_fds_assert_success(from, &pair[1], 1,
>                                   "{ 'execute': 'getfd',"
> @@ -283,6 +280,7 @@ static void migrate_hook_end_fd(QTestState *from,
>  static void test_precopy_fd_socket(char *name, MigrateCommon *args)
>  {
>      args->connect_uri = "fd:fd-mig";
> +    args->listen_uri = "fd:fd-mig";
>      args->start_hook = migrate_hook_start_fd;
>      args->end_hook = migrate_hook_end_fd;
>  
> @@ -484,6 +482,7 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
>       * everything will work alright even if guest page is changing.
>       */
>      args->live = true;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> @@ -500,6 +499,7 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
>       * everything will work alright even if guest page is changing.
>       */
>      args->live = true;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> @@ -516,6 +516,7 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
>       * everything will work alright even if guest page is changing.
>       */
>      args->live = true;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 166f27f478..f63f37132a 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -677,6 +677,7 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
>  {
>      args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
>      args->end_hook = migrate_hook_end_tls_psk;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> @@ -689,6 +690,7 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
>      args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
>      args->end_hook = migrate_hook_end_tls_psk;
>      args->result = MIG_TEST_FAIL;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.hide_stderr = true;
>      args->start.incoming_defer = true;
> @@ -702,6 +704,7 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
>  {
>      args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
>      args->end_hook = migrate_hook_end_tls_psk;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> @@ -716,6 +719,7 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
>  {
>      args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
>      args->end_hook = migrate_hook_end_tls_x509;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> @@ -728,6 +732,7 @@ static void test_multifd_tcp_tls_x509_override_host(char *name,
>  {
>      args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
>      args->end_hook = migrate_hook_end_tls_x509;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> @@ -754,6 +759,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
>      args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
>      args->end_hook = migrate_hook_end_tls_x509;
>      args->result = MIG_TEST_FAIL;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.hide_stderr = true;
> @@ -767,6 +773,7 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
>  {
>      args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
>      args->end_hook = migrate_hook_end_tls_x509;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> @@ -780,6 +787,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
>      args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
>      args->end_hook = migrate_hook_end_tls_x509;
>      args->result = MIG_TEST_FAIL;
> +    args->listen_uri = "tcp:127.0.0.1:0";
>  
>      args->start.incoming_defer = true;
>      args->start.hide_stderr = true;
> -- 
> 2.51.0
> 

-- 
Peter Xu


