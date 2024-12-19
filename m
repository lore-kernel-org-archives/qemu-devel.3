Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67B6E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJpe-0006yr-DH; Thu, 19 Dec 2024 11:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOJpM-0006x8-Sk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOJpK-0002Pv-OO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734627400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FOn/IjgPFIZ3nT9Z+p9nOEtXPs+iAnG0PWKUF0jvUBk=;
 b=DEL69QnwuzAaLXrIhL/a9HxIzEr2vWIJWIuaEoxAYGDUovPTsSsbsVW9QdvbuxzRsJT2N+
 CKZxKDvgmoWCGZfjz6pzq1x2bgjuEZsRgJJT3Gny4O8crIANHyZ6unxXnTVFKCNKIF+TKL
 9jiH37f+4vFNCEthzCRvW2TIeOzu8x0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-hKO7nZAlMFKA1eYjMeWjtw-1; Thu, 19 Dec 2024 11:56:39 -0500
X-MC-Unique: hKO7nZAlMFKA1eYjMeWjtw-1
X-Mimecast-MFC-AGG-ID: hKO7nZAlMFKA1eYjMeWjtw
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e7f07332so152062085a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 08:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734627399; x=1735232199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOn/IjgPFIZ3nT9Z+p9nOEtXPs+iAnG0PWKUF0jvUBk=;
 b=ovl+0jEexRH27+9yjLRGexJzfTxDvFQrPuror6OjGb5evlCbwrqlzYN2vVDZNfzJuJ
 Rq2N7QeIvzE1jkfSkO+x76cW2vd9QD+24WKgpNMWR2QnulAbEqHYa0pJLkLYlZkeldp0
 Dr6lFZ0OiMkE8W+It0LA8s8wBGKhWGV9nNZ/guFiUEA4NSUf7cEIMy9X2vCMsV9dPG0f
 KnVoHYS3NsC5IQMzIC6zePyUHIa7ThAudpaLROD8MlbPENjz5O8v2aRmuEJHSFYT8lIu
 iW+K/dRUevX1Lw1srf5jurqeuS3d18PYplimw/p8PtEL+k57KjIhhjVa52fqYpBp0BqV
 ZqDg==
X-Gm-Message-State: AOJu0YzfryMxHJ07wmloG72yhUrrSd1QL7cVKE8v8WDib0+S2RfEYWr1
 9ZfIIopdIQtnbn4pk3cXnPcyn6x3/Mj7noGU95SZDerRBZghhCykvC9MfQjZfKxVUjpRAFXssqH
 cWp8Y1rlij/tS6FJDc1tnJctfCOwiDgKBT98Rfiqb1dhd6sepKxHk
X-Gm-Gg: ASbGncvZPin04nxh03SKqX44gdH13Tvypq4r7Gj+ekdIPZgYUd9W0XwmjjhR4av1xZZ
 3QnWblx2U9RktyZasV/2n/WT0erh0zXv+iFSL4o11Wfb3pXt77kvuGkDvL259fqF6iHUHrLSi/w
 LVA8++YGazHMMIiiVxW59PfyM7sKEEnu310VpStgouShZDqTs+oT9NMhmJQDhyg1dPVzeTryaKn
 lqp2/rGr6/fIpje85FpiOw9EOilT0fu+9zqqcx0px2pHjm1MYDufE3O2IUCarRd/eSg6t9wkqZZ
 0G0x0RbsCHOLedhmlg==
X-Received: by 2002:a05:620a:31a8:b0:7b6:5dbe:1b52 with SMTP id
 af79cd13be357-7b86375d1fcmr1098694085a.33.1734627398995; 
 Thu, 19 Dec 2024 08:56:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvZ32iSJTYbBhdxzWooRK2sovZdhVy3ezKtFl3AO/67ixxeLgXd2MgxNvsevAQHc63HvoM2w==
X-Received: by 2002:a05:620a:31a8:b0:7b6:5dbe:1b52 with SMTP id
 af79cd13be357-7b86375d1fcmr1098690385a.33.1734627398671; 
 Thu, 19 Dec 2024 08:56:38 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480943sm63094385a.89.2024.12.19.08.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 08:56:38 -0800 (PST)
Date: Thu, 19 Dec 2024 11:56:35 -0500
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
Subject: Re: [PATCH V4 18/19] migration-test: cpr-transfer
Message-ID: <Z2RQQwWuj1v1aarN@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-19-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-19-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 02, 2024 at 05:20:10AM -0800, Steve Sistare wrote:
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
>  tests/qtest/migration-test.c | 72 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8bc665d..4eb641c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1729,6 +1729,7 @@ static void test_precopy_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
>      void *data_hook = NULL;
> +    const char *connect_uri;
>  
>      if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
>          return;
> @@ -1766,11 +1767,16 @@ static void test_precopy_common(MigrateCommon *args)
>          goto finish;
>      }
>  
> -    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
> +    /* If has channels, then connect_uri is only used for listen defer */
> +    connect_uri = args->connect_channels ? NULL : args->connect_uri;
> +    migrate_qmp(from, to, connect_uri, args->connect_channels, "{}");

This smells like abuse.

If the test case sets connect_uri only because of below...

>  
>      if (args->start.defer_target_connect) {
>          qtest_connect_deferred(to);
>          qtest_qmp_handshake(to);
> +        if (!strcmp(args->listen_uri, "defer")) {
> +            migrate_incoming_qmp(to, args->connect_uri, "{}");

... here, then IMHO it's abusing connect_uri to start service incoming
ports.

We do have solution for "delay" incoming, right?   Shouldn't we use
migrate_get_connect_uri() instead, then never set connect_uri in
cpr-transfer tests?

> +        }
>      }
>  
>      if (args->result != MIG_TEST_SUCCEED) {
> @@ -2415,6 +2421,66 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
>  }
>  #endif /* !_WIN32 */
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
> +    g_autofree char *opts_target = g_strdup_printf(
> +        "-incoming \\{\\\'channel-type\\\':\\\'cpr\\\',"
> +        "\\\'addr\\\':\\{\\\'transport\\\':\\\'socket\\\',"
> +        "\\\'type\\\':\\\'unix\\\',\\\'path\\\':\\\'%s\\\'\\}\\} %s",
> +        cpr_path, opts);

Nobody will be able to change this easily.. Maybe use g_strescape()?

> +
> +    g_autofree char *channels = g_strdup_printf(
> +        "[ { 'channel-type': 'main',"
> +        "    'addr': { 'transport': 'socket',"
> +        "              'type': 'unix',"
> +        "              'path': '%s' } },"
> +        "  { 'channel-type': 'cpr',"
> +        "    'addr': { 'transport': 'socket',"
> +        "              'type': 'unix',"
> +        "              'path': '%s' } } ]",
> +        mig_path, cpr_path);
> +
> +    MigrateCommon args = {
> +        .start.opts_source = opts,
> +        .start.opts_target = opts_target,
> +        .start.defer_target_connect = true,
> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
> +                                " -machine memory-backend=pc.ram",
> +        .listen_uri = incoming_defer ? "defer" : uri,
> +        .connect_uri = incoming_defer ? uri : NULL,
> +        .connect_channels = channels,
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
>  static void test_precopy_tcp_plain(void)
>  {
>      MigrateCommon args = {
> @@ -3905,6 +3971,10 @@ int main(int argc, char **argv)
>          migration_test_add("/migration/mode/reboot", test_mode_reboot);
>      }
>  
> +    migration_test_add("/migration/mode/transfer", test_mode_transfer);
> +    migration_test_add("/migration/mode/transfer/defer",
> +                       test_mode_transfer_defer);
> +
>      migration_test_add("/migration/precopy/file/mapped-ram",
>                         test_precopy_file_mapped_ram);
>      migration_test_add("/migration/precopy/file/mapped-ram/live",
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


