Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1B0C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cl9-0003qd-Tx; Wed, 08 May 2024 04:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4cl7-0003qN-T9
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4ckw-00021G-V2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715157270;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KL2Vuj/MrH/x2k4BU4GzX2hZPjw94/RqW32lbjrQ3Jc=;
 b=aVUiqSaSYEuWK6zBtUAigwFNGWxnSljVkHu4yoHHnGQhfzgZkBs1UBaIO2G1s/pDffraSH
 fcuaGyjGqKPRGxnqkkwriuIeYjTIkOJHx1tk4Weo62LtgWM2nDO7s8OFiFxs3SwTa/Hx1A
 QSDuqjuAgVtzeY/ng/S4GflrFkXT730=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-QS2bXEq6OwC6fmJ4LNBioA-1; Wed,
 08 May 2024 04:34:27 -0400
X-MC-Unique: QS2bXEq6OwC6fmJ4LNBioA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 957633C01DE9;
 Wed,  8 May 2024 08:34:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36D8B407310;
 Wed,  8 May 2024 08:34:25 +0000 (UTC)
Date: Wed, 8 May 2024 09:34:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/9] tests/qtest/migration: Add tests for file migration
 with direct-io
Message-ID: <Zjs5D53Ab6o2GvtN@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-7-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 26, 2024 at 11:20:39AM -0300, Fabiano Rosas wrote:
> The tests are only allowed to run in systems that know about the
> O_DIRECT flag and in filesystems which support it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 42 +++++++++++++++++++++++++++++++++
>  tests/qtest/migration-helpers.h |  1 +
>  tests/qtest/migration-test.c    | 42 +++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index ce6d6615b5..356cd4fa8c 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -473,3 +473,45 @@ void migration_test_add(const char *path, void (*fn)(void))
>      qtest_add_data_func_full(path, test, migration_test_wrapper,
>                               migration_test_destroy);
>  }
> +
> +#ifdef O_DIRECT
> +/*
> + * Probe for O_DIRECT support on the filesystem. Since this is used
> + * for tests, be conservative, if anything fails, assume it's
> + * unsupported.
> + */
> +bool probe_o_direct_support(const char *tmpfs)
> +{
> +    g_autofree char *filename = g_strdup_printf("%s/probe-o-direct", tmpfs);
> +    int fd, flags = O_CREAT | O_RDWR | O_TRUNC | O_DIRECT;
> +    void *buf;
> +    ssize_t ret, len;
> +    uint64_t offset;
> +
> +    fd = open(filename, flags, 0660);
> +    if (fd < 0) {
> +        unlink(filename);
> +        return false;
> +    }
> +
> +    /*
> +     * Assuming 4k should be enough to satisfy O_DIRECT alignment
> +     * requirements. The migration code uses 1M to be conservative.
> +     */
> +    len = 0x100000;
> +    offset = 0x100000;

4k is unlikely insufficient for architectures with a 64k small
page size, and filesystem constraints also play a part. Suggest
rewording to

  /*
   * Using 1MB alignment as conservative choice to satisfy
   * any plausible architecture default page size, and/or
   * filesystem alignment restrictions.
   */

> +
> +    buf = aligned_alloc(len, len);
> +    g_assert(buf);
> +
> +    ret = pwrite(fd, buf, len, offset);
> +    unlink(filename);
> +    g_free(buf);
> +
> +    if (ret < 0) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +#endif
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 1339835698..d827e16145 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -54,5 +54,6 @@ char *find_common_machine_version(const char *mtype, const char *var1,
>                                    const char *var2);
>  char *resolve_machine_version(const char *alias, const char *var1,
>                                const char *var2);
> +bool probe_o_direct_support(const char *tmpfs);
>  void migration_test_add(const char *path, void (*fn)(void));
>  #endif /* MIGRATION_HELPERS_H */
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 7b177686b4..512b7ede8b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2295,6 +2295,43 @@ static void test_multifd_file_mapped_ram(void)
>      test_file_common(&args, true);
>  }
>  
> +#ifdef O_DIRECT
> +static void *migrate_mapped_ram_dio_start(QTestState *from,
> +                                                 QTestState *to)
> +{
> +    migrate_mapped_ram_start(from, to);
> +    migrate_set_parameter_bool(from, "direct-io", true);
> +    migrate_set_parameter_bool(to, "direct-io", true);
> +
> +    return NULL;
> +}
> +
> +static void *migrate_multifd_mapped_ram_dio_start(QTestState *from,
> +                                                 QTestState *to)
> +{
> +    migrate_multifd_mapped_ram_start(from, to);
> +    return migrate_mapped_ram_dio_start(from, to);
> +}
> +
> +static void test_multifd_file_mapped_ram_dio(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .start_hook = migrate_multifd_mapped_ram_dio_start,
> +    };
> +
> +    if (!probe_o_direct_support(tmpfs)) {
> +        g_test_skip("Filesystem does not support O_DIRECT");
> +        return;
> +    }
> +
> +    test_file_common(&args, true);
> +}
> +
> +#endif /* O_DIRECT */
>  
>  static void test_precopy_tcp_plain(void)
>  {
> @@ -3719,6 +3756,11 @@ int main(int argc, char **argv)
>      migration_test_add("/migration/multifd/file/mapped-ram/live",
>                         test_multifd_file_mapped_ram_live);
>  
> +#ifdef O_DIRECT
> +    migration_test_add("/migration/multifd/file/mapped-ram/dio",
> +                       test_multifd_file_mapped_ram_dio);
> +#endif
> +
>  #ifdef CONFIG_GNUTLS
>      migration_test_add("/migration/precopy/unix/tls/psk",
>                         test_precopy_unix_tls_psk);
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


