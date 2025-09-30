Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E323FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 17:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3dq8-0004A9-Fz; Tue, 30 Sep 2025 13:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3dpy-00048z-Tr
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 13:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3dpq-0004wd-Ie
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 13:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759252092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ey/6o95xRv+Vgqw/ApEvFnVJay4Qx1xYDPi7txHKqzE=;
 b=Rfd4ZsVJEFLjDW88HJ46KKL1E6iG1Cd1lNQzDNMJmQQ9CbMKhiIM6seNaHiOVXkcLej9Sk
 4RDeS5tcD3uujxHFVtIsk2BKNISDeW4tK1EZcGXLiaaLDZQ+UqkV0j3CDAa7orY9X2fAN4
 bsnHhlSpcbiTFDDwzZ3LsE9rBUmB+R8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-wSjy4fsQPe6lg-DeT8u1Bw-1; Tue, 30 Sep 2025 13:08:11 -0400
X-MC-Unique: wSjy4fsQPe6lg-DeT8u1Bw-1
X-Mimecast-MFC-AGG-ID: wSjy4fsQPe6lg-DeT8u1Bw_1759252091
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-856d34460a3so1357190485a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 10:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759252091; x=1759856891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ey/6o95xRv+Vgqw/ApEvFnVJay4Qx1xYDPi7txHKqzE=;
 b=LNzJsxJfI19JHdfjr2N1C2xIXJN1gGbPHpYwhou23gGzIjTnP1nZBEpuc766LdeGcF
 o+rCTF3qQ/9iAwoUjpPFn4sYFjRpKXzBU81gAIuos2Zi9S8akgHFIXtKigbLi9X52jea
 VXzwkN9BAOVMBi10KKawxzrpKHoXVGah7Dqe5WbAUmxgMGY+L76hF+FwU5jrPi4uyXAN
 iAdqm6yWINcl8rsnlmhIQo9A9VnsS7ZBV/eOlH7EtEVHjsQfeemi54yBoZYdbPZR45b6
 6P2gCbh8MCeP9y5OJk503Q+8KW0MGjz53nBZDf9qAkwkgZnMxqejzTosEy9vPDl7nWSr
 sJBg==
X-Gm-Message-State: AOJu0YzOpyF8i0tBI+vWXgSOSRiLViEcPcelq9hBt5zMY+tF3Tosux/3
 xM4b8S8oI473HWd7IrVxIYCzGL6P1PK23Jwn3JJuE8J41X9ED36Wm5IKxhseNqlRym3yWK7IZGS
 cmsp/Ro9X1mU+lvCJ/SUC8rp7OLmLppmfHAevR/ovSGzZa4v0USlrj3ww
X-Gm-Gg: ASbGncv7AOMm2nMjkEZjwJA2OnhZEnQDlUL+W+dIChRbtfO94DNqueoC4snV0OrlbSB
 RcotmJpnnd2B0Joug+EHjQmaRNSk7G/mUogh1JGatuV/PO3eCozk8JQNddMa76a3soGovpQ9n5O
 TDYznOC1+aQmlwZ69azOAbqOONheNFTZ6oi9V1NbcrdyuMfWewCT9m0201H7lXvuZUjMkGJF/lH
 T6yg/VIVL26YK7yAD5rjL3eJXs4+b2d133OiW5dvoujM6o/keqdMtX9rEMOvR+0jb47+/IEi57O
 AhphIpO7kLN+4hihixmDCHettN4UgKPwnGt5fA==
X-Received: by 2002:a05:620a:191d:b0:85e:96ce:e833 with SMTP id
 af79cd13be357-873797b25cemr70016385a.67.1759252090635; 
 Tue, 30 Sep 2025 10:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiYG6f9gQBgBRo5UEeNPEdvdvAh9tIm7uF+lHHRX8AyNPun7mTuPjORDcvoQmbSIRCM7Opg==
X-Received: by 2002:a05:620a:191d:b0:85e:96ce:e833 with SMTP id
 af79cd13be357-873797b25cemr70010985a.67.1759252090086; 
 Tue, 30 Sep 2025 10:08:10 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c27099635sm1137900485a.2.2025.09.30.10.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 10:08:09 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:08:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V1 11/11] migration-test: test cpr-exec
Message-ID: <aNwOeCkXZpPtmPTF@x1.local>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-12-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1758291153-349744-12-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 19, 2025 at 07:12:33AM -0700, Steve Sistare wrote:
> Add a test for the cpr-exec migration mode.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Looks good, only some nitpicks or pure questions below.

> ---
>  tests/qtest/migration/cpr-tests.c | 120 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 5e764a6..f33af76 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -110,6 +110,125 @@ static void test_mode_transfer_defer(void)
>      test_mode_transfer_common(true);
>  }
>  
> +static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
> +{
> +    g_autofree char *qtest_from_args = NULL;
> +    g_autofree char *from_args = NULL;
> +    g_autofree char *to_args = NULL;
> +    g_autofree char *exec_args = NULL;
> +    g_auto(GStrv) argv = NULL;
> +    char *from_str, *src, *dst;
> +
> +    args->start.hide_stderr = false;    /* omit redirection word from args */

It's default off, right?  Could I request for some more explanations?

Could we also set it in test_mode_exec() directly if needed?

> +    migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
> +    qtest_from_args = qtest_qemu_args(from_args);
> +
> +    /* De-dup spaces so argv does not contain empty strings */
> +    from_str = src = dst = g_strstrip(qtest_from_args);
> +    do {
> +        if (*src != ' ' || src[-1] != ' ') {
> +            *dst++ = *src;
> +        }
> +    } while (*src++);

Pure ask.. when will empty string be present?

> +
> +    exec_args = g_strconcat(qtest_qemu_binary(QEMU_ENV_SRC),

Should this be QEMU_ENV_DST?

OTOH, we can use migration_get_env()->qemu_dst to reduce referencing global
vars.

> +                            " -incoming defer ", from_str, NULL);
> +    argv = g_strsplit(exec_args, " ", -1);
> +    migrate_set_parameter_strv(who, "cpr-exec-command", argv);
> +}
> +
> +static void wait_for_migration_event(QTestState *who, const char *waitfor)
> +{
> +    QDict *rsp, *data;
> +    char *status;
> +    bool done = false;
> +
> +    while (!done) {
> +        rsp = qtest_qmp_eventwait_ref(who, "MIGRATION");
> +        g_assert(qdict_haskey(rsp, "data"));
> +        data = qdict_get_qdict(rsp, "data");
> +        g_assert(qdict_haskey(data, "status"));
> +        status = g_strdup(qdict_get_str(data, "status"));
> +        g_assert(strcmp(status, "failed"));
> +        done = !strcmp(status, waitfor);
> +        qobject_unref(rsp);
> +    }
> +}
> +
> +static void test_cpr_exec(MigrateCommon *args)
> +{
> +    QTestState *from, *to;
> +    void *data_hook = NULL;
> +    g_autofree char *connect_uri = g_strdup(args->connect_uri);
> +    g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
> +                                                FILE_TEST_FILENAME);
> +
> +

Newline can be dropped.

> +    if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
> +        return;
> +    }
> +
> +    /* Source and dest never run concurrently */
> +    g_assert_false(args->live);
> +
> +    if (args->start_hook) {
> +        data_hook = args->start_hook(from, NULL);
> +    }
> +
> +    wait_for_serial("src_serial");
> +    set_cpr_exec_args(from, args);
> +    migrate_set_capability(from, "events", true);
> +    migrate_qmp(from, NULL, connect_uri, NULL, "{}");
> +    wait_for_migration_event(from, "completed");
> +
> +    to = qtest_init_after_exec(from);
> +
> +    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> +                             "  'arguments': { "
> +                             "      'channels': [ { 'channel-type': 'main',"
> +                             "      'addr': { 'transport': 'file',"
> +                             "                'filename': %s,"
> +                             "                'offset': 0  } } ] } }",
> +                             filename);
> +    wait_for_migration_complete(to);
> +
> +    wait_for_resume(to, get_dst());
> +    /* Device on target is still named src_serial because args do not change */
> +    wait_for_serial("src_serial");
> +
> +    if (args->end_hook) {
> +        args->end_hook(from, to, data_hook);
> +    }
> +
> +    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
> +}
> +
> +static void *test_mode_exec_start(QTestState *from, QTestState *to)
> +{
> +    assert(!to);
> +    migrate_set_parameter_str(from, "mode", "cpr-exec");
> +    return NULL;
> +}
> +
> +static void test_mode_exec(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    g_autofree char *listen_uri = g_strdup_printf("defer");
> +
> +    MigrateCommon args = {
> +        .start.only_source = true,
> +        .start.opts_source = "-machine aux-ram-share=on -nodefaults",
> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
> +                                " -machine memory-backend=pc.ram",
> +        .connect_uri = uri,
> +        .listen_uri = listen_uri,
> +        .start_hook = test_mode_exec_start,
> +    };
> +
> +    test_cpr_exec(&args);
> +}
> +
>  void migration_test_add_cpr(MigrationTestEnv *env)
>  {
>      tmpfs = env->tmpfs;
> @@ -132,5 +251,6 @@ void migration_test_add_cpr(MigrationTestEnv *env)
>          migration_test_add("/migration/mode/transfer", test_mode_transfer);
>          migration_test_add("/migration/mode/transfer/defer",
>                             test_mode_transfer_defer);
> +        migration_test_add("/migration/mode/exec", test_mode_exec);
>      }
>  }
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


