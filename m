Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45136E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB6A-000113-4R; Tue, 24 Dec 2024 15:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQB68-00010o-Rx
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:01:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQB66-0001cx-Ut
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735070500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qsDASAj/GKa2wWR/iTceXumwIfbSNoIxSR2mUvNd5DI=;
 b=EQQ4nvRNrsOhYtdwX6IBYTJYkfYJikp9wCTbSGb7SYZvB9Oc5jjon6f8dGedVQBfB+2wF4
 4cQL8BhDGN7k/cwjJ/RSkTqlujaKL94pbK3E+sP9cs3N5w6uxTPMcqp9Qb9o7hRfcZAxol
 AvVPOMzLho6S9kRcvWakkGkbHH+w+9Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-R21A_ROIOCGfnokC7su4Iw-1; Tue, 24 Dec 2024 15:01:39 -0500
X-MC-Unique: R21A_ROIOCGfnokC7su4Iw-1
X-Mimecast-MFC-AGG-ID: R21A_ROIOCGfnokC7su4Iw
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467944446a0so89587371cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070499; x=1735675299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsDASAj/GKa2wWR/iTceXumwIfbSNoIxSR2mUvNd5DI=;
 b=OPN4yLkxMxEZCa9UsFJ54l7jCyoCiyWiWy81PEfkadVkrbAEumUTMOIFLdXsF38v8V
 lyiDyptfX0kuPnpNvO3o62Z4DKmLKDQxBBte3qX91gaxxfqwxRt8/KazbzAoFEb8eMy7
 csWROu9r2gS6SSYrcDAqpELbl6zwFCmFDgiqMAaFLxYCMqyxxlZQaPP0z2PrfGPHT882
 3C6XHswCQ7yOOSRDlkZdcN/ifJf1M0+4YWwFYgT5n0dgHILUIvrg1LxUh+OotLAlrS+k
 qz8O2sF4QxzQiR++inCmsq4pudHr7tlGjqsj/kb733Vx7xMLXdWq4SeE4Lh7rxsLWPVx
 6Ihw==
X-Gm-Message-State: AOJu0Yw+RblXluUqN4/NWWdpvHnwX0OMexqBZP6zoaiCB9jLmilY9Uc9
 NvMK7G/h1oQERAIhBqmmPZhgnqyTl42zjfAjDQUo8dgyneYrJZbsGHJVTDXzxRMMTtnkM4AUrqU
 s7lMsuINaoVae2cXYOB9Wj3anVxbmvbKBoi9ugxJQflwozkkIL3+m
X-Gm-Gg: ASbGncuaGuaOlmDaC+AMcoiomJMScDmfnZ9ixfBsIHuFbyIHOp17uAWzcCV3JSUEfJx
 d8O5Gao+HIqn9VzDUslA+HQDGG2LlvEARdYCBH4naFtfCCRNChPf1a1vLi0NGHIlnmkOkihpKiv
 BShO8yHCas+KsY0bDWm6Rh8zomjEJn0q2MOMXLwEG3RaSzIFwK/FJwOK9kZ3D5h4hAiA5NSur6M
 1P7qrPvgKgszXPOeP6Z5GvfvqdQFrPJ56kfJmEMbdmyCYeZwA+EeACQOnO+enqXmzyyuPfsg5Y+
 gv4DHiwwyRHqY6NYEQ==
X-Received: by 2002:ac8:7d4b:0:b0:467:5db1:696d with SMTP id
 d75a77b69052e-46a4a8caf98mr301060051cf.14.1735070497767; 
 Tue, 24 Dec 2024 12:01:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK1dhwaFMF4sGu+TtTJCZk8Jcfa1tjPGbjG6YEywIlpYcH9inwWLuV1ZrIMY4Yrh+2ZQGVrw==
X-Received: by 2002:ac8:7d4b:0:b0:467:5db1:696d with SMTP id
 d75a77b69052e-46a4a8caf98mr301059601cf.14.1735070497408; 
 Tue, 24 Dec 2024 12:01:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb175e3sm56289611cf.56.2024.12.24.12.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:01:36 -0800 (PST)
Date: Tue, 24 Dec 2024 15:01:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 22/23] migration-test: cpr-transfer
Message-ID: <Z2sTHg-t0wB4g3Mh@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 24, 2024 at 08:17:07AM -0800, Steve Sistare wrote:
> Add a migration test for cpr-transfer mode.  Defer the connection to the
> target monitor, else the test hangs because in cpr-transfer mode QEMU does
> not listen for monitor connections until we send the migrate command to
> source QEMU.
> 
> To test -incoming defer, send a migrate incoming command to the target,
> after sending the migrate command to the source, as required by
> cpr-transfer mode.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tests/qtest/migration/cpr-tests.c | 60 +++++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.c | 19 +++++++++++++
>  tests/qtest/migration/framework.h |  3 ++
>  3 files changed, 82 insertions(+)
> 
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 44ce89a..b221980 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -44,6 +44,62 @@ static void test_mode_reboot(void)
>      test_file_common(&args, true);
>  }
>  
> +static void *test_mode_transfer_start(QTestState *from, QTestState *to)
> +{
> +    migrate_set_parameter_str(from, "mode", "cpr-transfer");
> +    return NULL;
> +}
> +
> +/*
> + * cpr-transfer mode cannot use the target monitor prior to starting the
> + * migration, and cannot connect synchronously to the monitor, so defer
> + * the target connection.
> + */
> +static void test_mode_transfer_common(bool incoming_defer)
> +{
> +    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
> +    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
> +    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
> +
> +    const char *opts = "-machine aux-ram-share=on -nodefaults";
> +    g_autofree const char *cpr_channel = g_strdup_printf(
> +        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
> +        cpr_path);
> +    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
> +                                                   cpr_channel, opts);
> +
> +    g_autofree char *connect_channels = g_strdup_printf(
> +        "[ { 'channel-type': 'main',"
> +        "    'addr': { 'transport': 'socket',"
> +        "              'type': 'unix',"
> +        "              'path': '%s' } } ]",
> +        mig_path);

So this test already uses json-format channels, IMHO we probably don't need
MigrateCommon.cpr_channel anymore?  We could put them all here. Then..

> +
> +    MigrateCommon args = {
> +        .start.opts_source = opts,
> +        .start.opts_target = opts_target,
> +        .start.defer_target_connect = true,
> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
> +                                " -machine memory-backend=pc.ram",
> +        .listen_uri = incoming_defer ? "defer" : uri,
> +        .connect_channels = connect_channels,
> +        .cpr_channel = cpr_channel,
> +        .start_hook = test_mode_transfer_start,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
> +static void test_mode_transfer(void)
> +{
> +    test_mode_transfer_common(NULL);
> +}
> +
> +static void test_mode_transfer_defer(void)
> +{
> +    test_mode_transfer_common(true);
> +}
> +
>  void migration_test_add_cpr(MigrationTestEnv *env)
>  {
>      tmpfs = env->tmpfs;
> @@ -55,4 +111,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
>      if (getenv("QEMU_TEST_FLAKY_TESTS")) {
>          migration_test_add("/migration/mode/reboot", test_mode_reboot);
>      }
> +
> +    migration_test_add("/migration/mode/transfer", test_mode_transfer);
> +    migration_test_add("/migration/mode/transfer/defer",
> +                       test_mode_transfer_defer);
>  }
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index c6ea3e1..f6175de 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -411,6 +411,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
>      qtest_quit(to);
>  
>      cleanup("migsocket");
> +    cleanup("cpr.sock");
>      cleanup("src_serial");
>      cleanup("dest_serial");
>      cleanup(FILE_TEST_FILENAME);
> @@ -692,8 +693,11 @@ void test_precopy_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
>      void *data_hook = NULL;
> +    QObject *in_channels = NULL;
>      QObject *out_channels = NULL;
>  
> +    g_assert(!args->cpr_channel || args->connect_channels);
> +
>      if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>          return;
>      }
> @@ -725,8 +729,20 @@ void test_precopy_common(MigrateCommon *args)
>          }
>      }
>  
> +    /*
> +     * The cpr channel must be included in outgoing channels, but not in
> +     * migrate-incoming channels.
> +     */
>      if (args->connect_channels) {
> +        in_channels = qobject_from_json(args->connect_channels, &error_abort);
>          out_channels = qobject_from_json(args->connect_channels, &error_abort);
> +
> +        if (args->cpr_channel) {
> +            QList *channels_list = qobject_to(QList, out_channels);
> +            QObject *obj = migrate_str_to_channel(args->cpr_channel);
> +
> +            qlist_append(channels_list, obj);
> +        }

... here IIUC we don't need this trick to manipulate the qlist anymore?

Looks like if with that (convert the current cpr_connect string to JSON
format, attach it with connect_channels), then we also don't need the
pre-requisite patch to make connect_channels manipulate-able. Not sure.

>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> @@ -739,6 +755,9 @@ void test_precopy_common(MigrateCommon *args)
>      if (args->start.defer_target_connect) {
>          qtest_connect(to);
>          qtest_qmp_handshake(to);
> +        if (!strcmp(args->listen_uri, "defer")) {
> +            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
> +        }
>      }
>  
>      if (args->result != MIG_TEST_SUCCEED) {
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 1341368..4678e2a 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -152,6 +152,9 @@ typedef struct {
>       */
>      const char *connect_channels;
>  
> +    /* Optional: the cpr migration channel, in JSON or dotted keys format */
> +    const char *cpr_channel;
> +
>      /* Optional: callback to run at start to set migration parameters */
>      TestMigrateStartHook start_hook;
>      /* Optional: callback to run at finish to cleanup */
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


