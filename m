Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74679E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBB0-0004S9-Hr; Tue, 24 Dec 2024 15:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQBAl-0003nr-Ec
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQBAj-0002nj-Aj
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735070786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VX9q+QvKx3mLVKEbNX0KGAhDRcUWyt3V/hEcHlB5kLM=;
 b=MFdI3z/LMVSQj13tCIkqzm/acYrQyp458mzn8DgSolOaUdro5unMtBpgYJRTArqn8zd0GD
 exWxEoKhs6CqTzozcAARp7B+F8A09dWQOJOG6oQs7nRO+6SMlG3d5lmwJ9lCJSzErJM+qJ
 NJS98y5PoGO8mCzogBraRYze9WzX5w8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-x5MbjEUeMGKy-SOCgaOUiw-1; Tue, 24 Dec 2024 15:06:23 -0500
X-MC-Unique: x5MbjEUeMGKy-SOCgaOUiw-1
X-Mimecast-MFC-AGG-ID: x5MbjEUeMGKy-SOCgaOUiw
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4675c482d6cso91416591cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070782; x=1735675582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VX9q+QvKx3mLVKEbNX0KGAhDRcUWyt3V/hEcHlB5kLM=;
 b=Ikgf7DhlmVdWLSNZ/ZZ+eg+uuyTPAReNPmKZIn3NOsohgrNW0MvrbAtUJHzUIHp9Vj
 r4e+aNdxdYCxcJSEfgukgj5EPEqbDLThQMIo4oLmgSF8dwuCatflUzYBjFnitrYG162k
 Z/jJE7iDNI8TSva6miqgwgVio5hTNmJrL+fKUyOkFcUjrrcIdr6c1KTrnFTFQjesLpeh
 TCF4mTtR+c3nY8LfDk9CDVkdAoVhcFL9QhdTFJ2tOdMjfQOXbro77FCpofaajWnDqPuM
 pXqXNp5xVMqlIAdmBMYNMA+HyHg+0kMz8C26AXm9cHJq1wo8eNChUCjx2mI/yXSYPQfC
 O5ag==
X-Gm-Message-State: AOJu0YxgECwgfxMDHuQ0xeuOrH60czkkWvLtfqDzJT5Z9TZpXUE5NjFI
 ryi6kIeX+EeA3mhmFUe1OcVQl/o9D6Z0CDF5mqeVMKPgB2SOj0eBP4Zl3PutJl+Donm3QqrQY/3
 6zb6yAmNy767adHmr8AT57rSQBqfEWydGEszo5W/Uj/LYTvvk8+1t
X-Gm-Gg: ASbGncsronFh6RMlhFmjyGOLbbgnJwqfMWqwFtC/Im6Bsxl+HbpHL2I9yMcK64YnQd3
 0kHUJymVuAR1D8VnyRK0eI2ZR41ACnxWAbn+e8Ikdfw/mhuayt76AXEIh0QJsEoWWjy+nnGklTX
 UYIC6iEp97VhS1HiV9pj7O/78W1Qc3C9O+dLhRwjsWEeH0euiZcZpC1FGeWljbBBDWOmHDEy5kk
 q0Uat/hGJbFrKEVbHW5vrLQL1Iq1HOSdJsX5MfpO4lIzxXctIdMVG3mFVRJ8QAIj5oyu5IXWpXH
 RRbiBVtFmo5hoQ9Vaw==
X-Received: by 2002:a05:6214:1c8e:b0:6d8:a0c8:e467 with SMTP id
 6a1803df08f44-6dd23344c84mr297736676d6.13.1735070782462; 
 Tue, 24 Dec 2024 12:06:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkL7e7srtc7v+Gp40aFeJjZjx0Mig53TJ5WdSvThadrtQlgdJiPQG3ILAWbF9h5RYCj0pXbQ==
X-Received: by 2002:a05:6214:1c8e:b0:6d8:a0c8:e467 with SMTP id
 6a1803df08f44-6dd23344c84mr297736396d6.13.1735070782158; 
 Tue, 24 Dec 2024 12:06:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb474sm55516866d6.85.2024.12.24.12.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:06:21 -0800 (PST)
Date: Tue, 24 Dec 2024 15:06:19 -0500
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
Message-ID: <Z2sUO7OoX7UK-DPY@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
 <Z2sTHg-t0wB4g3Mh@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2sTHg-t0wB4g3Mh@x1n>
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

On Tue, Dec 24, 2024 at 03:01:34PM -0500, Peter Xu wrote:
> On Tue, Dec 24, 2024 at 08:17:07AM -0800, Steve Sistare wrote:
> > Add a migration test for cpr-transfer mode.  Defer the connection to the
> > target monitor, else the test hangs because in cpr-transfer mode QEMU does
> > not listen for monitor connections until we send the migrate command to
> > source QEMU.
> > 
> > To test -incoming defer, send a migrate incoming command to the target,
> > after sending the migrate command to the source, as required by
> > cpr-transfer mode.
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >  tests/qtest/migration/cpr-tests.c | 60 +++++++++++++++++++++++++++++++++++++++
> >  tests/qtest/migration/framework.c | 19 +++++++++++++
> >  tests/qtest/migration/framework.h |  3 ++
> >  3 files changed, 82 insertions(+)
> > 
> > diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> > index 44ce89a..b221980 100644
> > --- a/tests/qtest/migration/cpr-tests.c
> > +++ b/tests/qtest/migration/cpr-tests.c
> > @@ -44,6 +44,62 @@ static void test_mode_reboot(void)
> >      test_file_common(&args, true);
> >  }
> >  
> > +static void *test_mode_transfer_start(QTestState *from, QTestState *to)
> > +{
> > +    migrate_set_parameter_str(from, "mode", "cpr-transfer");
> > +    return NULL;
> > +}
> > +
> > +/*
> > + * cpr-transfer mode cannot use the target monitor prior to starting the
> > + * migration, and cannot connect synchronously to the monitor, so defer
> > + * the target connection.
> > + */
> > +static void test_mode_transfer_common(bool incoming_defer)
> > +{
> > +    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
> > +    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
> > +    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
> > +
> > +    const char *opts = "-machine aux-ram-share=on -nodefaults";
> > +    g_autofree const char *cpr_channel = g_strdup_printf(
> > +        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
> > +        cpr_path);
> > +    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
> > +                                                   cpr_channel, opts);
> > +
> > +    g_autofree char *connect_channels = g_strdup_printf(
> > +        "[ { 'channel-type': 'main',"
> > +        "    'addr': { 'transport': 'socket',"
> > +        "              'type': 'unix',"
> > +        "              'path': '%s' } } ]",
> > +        mig_path);
> 
> So this test already uses json-format channels, IMHO we probably don't need
> MigrateCommon.cpr_channel anymore?  We could put them all here. Then..
> 
> > +
> > +    MigrateCommon args = {
> > +        .start.opts_source = opts,
> > +        .start.opts_target = opts_target,
> > +        .start.defer_target_connect = true,

One more comment: maybe we can even drop defer_target_connect.  I don't
expect any non-cpr test to use it.. so introducing the parameter may only
complicate MigrateCommon struct with almost zero benefit to be reused.

If to drop it, we could detect "cpr" channel in test_precopy_common() and
only defer the connection if "cpr" channel is present.

> > +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
> > +                                " -machine memory-backend=pc.ram",
> > +        .listen_uri = incoming_defer ? "defer" : uri,
> > +        .connect_channels = connect_channels,
> > +        .cpr_channel = cpr_channel,
> > +        .start_hook = test_mode_transfer_start,
> > +    };
> > +
> > +    test_precopy_common(&args);
> > +}
> > +
> > +static void test_mode_transfer(void)
> > +{
> > +    test_mode_transfer_common(NULL);
> > +}
> > +
> > +static void test_mode_transfer_defer(void)
> > +{
> > +    test_mode_transfer_common(true);
> > +}
> > +
> >  void migration_test_add_cpr(MigrationTestEnv *env)
> >  {
> >      tmpfs = env->tmpfs;
> > @@ -55,4 +111,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
> >      if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> >          migration_test_add("/migration/mode/reboot", test_mode_reboot);
> >      }
> > +
> > +    migration_test_add("/migration/mode/transfer", test_mode_transfer);
> > +    migration_test_add("/migration/mode/transfer/defer",
> > +                       test_mode_transfer_defer);
> >  }
> > diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> > index c6ea3e1..f6175de 100644
> > --- a/tests/qtest/migration/framework.c
> > +++ b/tests/qtest/migration/framework.c
> > @@ -411,6 +411,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
> >      qtest_quit(to);
> >  
> >      cleanup("migsocket");
> > +    cleanup("cpr.sock");
> >      cleanup("src_serial");
> >      cleanup("dest_serial");
> >      cleanup(FILE_TEST_FILENAME);
> > @@ -692,8 +693,11 @@ void test_precopy_common(MigrateCommon *args)
> >  {
> >      QTestState *from, *to;
> >      void *data_hook = NULL;
> > +    QObject *in_channels = NULL;
> >      QObject *out_channels = NULL;
> >  
> > +    g_assert(!args->cpr_channel || args->connect_channels);
> > +
> >      if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
> >          return;
> >      }
> > @@ -725,8 +729,20 @@ void test_precopy_common(MigrateCommon *args)
> >          }
> >      }
> >  
> > +    /*
> > +     * The cpr channel must be included in outgoing channels, but not in
> > +     * migrate-incoming channels.
> > +     */
> >      if (args->connect_channels) {
> > +        in_channels = qobject_from_json(args->connect_channels, &error_abort);
> >          out_channels = qobject_from_json(args->connect_channels, &error_abort);
> > +
> > +        if (args->cpr_channel) {
> > +            QList *channels_list = qobject_to(QList, out_channels);
> > +            QObject *obj = migrate_str_to_channel(args->cpr_channel);
> > +
> > +            qlist_append(channels_list, obj);
> > +        }
> 
> ... here IIUC we don't need this trick to manipulate the qlist anymore?
> 
> Looks like if with that (convert the current cpr_connect string to JSON
> format, attach it with connect_channels), then we also don't need the
> pre-requisite patch to make connect_channels manipulate-able. Not sure.
> 
> >      }
> >  
> >      if (args->result == MIG_TEST_QMP_ERROR) {
> > @@ -739,6 +755,9 @@ void test_precopy_common(MigrateCommon *args)
> >      if (args->start.defer_target_connect) {
> >          qtest_connect(to);
> >          qtest_qmp_handshake(to);
> > +        if (!strcmp(args->listen_uri, "defer")) {
> > +            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
> > +        }
> >      }
> >  
> >      if (args->result != MIG_TEST_SUCCEED) {
> > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> > index 1341368..4678e2a 100644
> > --- a/tests/qtest/migration/framework.h
> > +++ b/tests/qtest/migration/framework.h
> > @@ -152,6 +152,9 @@ typedef struct {
> >       */
> >      const char *connect_channels;
> >  
> > +    /* Optional: the cpr migration channel, in JSON or dotted keys format */
> > +    const char *cpr_channel;
> > +
> >      /* Optional: callback to run at start to set migration parameters */
> >      TestMigrateStartHook start_hook;
> >      /* Optional: callback to run at finish to cleanup */
> > -- 
> > 1.8.3.1
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


