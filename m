Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B696C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4d6A-00031X-85; Wed, 08 May 2024 04:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4d5x-0002hL-0C
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4d5v-0000Kb-3N
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715158569;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/veHvlT+0fZAPXT0cMOuZ1ca0+5PrJ2ffw32eoZ86C8=;
 b=Q9Z+3LJJcdvPRwy0QIGtgC06CiESgWHr0HQz2pfgb3F7nubU534KVuAD+wvLgCSeRDeefu
 awfcAzWFD40KefZufS4qg8bjt2xUc8jxwaXOPnQFXAnj/rWzcpml2tFFBvv7mVPdk6bqRq
 y6x6PpYfSyTkeW/aiv/mlA92v0fddwc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-ovNQfArhNPaFnYJQotEY5w-1; Wed,
 08 May 2024 04:56:07 -0400
X-MC-Unique: ovNQfArhNPaFnYJQotEY5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA0CB3801FE2;
 Wed,  8 May 2024 08:56:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D8A01C060AE;
 Wed,  8 May 2024 08:56:05 +0000 (UTC)
Date: Wed, 8 May 2024 09:56:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 9/9] tests/qtest/migration: Add a test for mapped-ram
 with passing of fds
Message-ID: <Zjs-IzSjCtCPr7Uz@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-10-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 26, 2024 at 11:20:42AM -0300, Fabiano Rosas wrote:
> Add a multifd test for mapped-ram with passing of fds into QEMU. This
> is how libvirt will consume the feature.
> 
> There are a couple of details to the fdset mechanism:
> 
> - multifd needs two distinct file descriptors (not duplicated with
>   dup()) on the outgoing side so it can enable O_DIRECT only on the
>   channels that write with alignment. The dup() system call creates
>   file descriptors that share status flags, of which O_DIRECT is one.
> 
>   the incoming side doesn't set O_DIRECT, so it can dup() fds and
>   therefore can receive only one in the fdset.
> 
> - the open() access mode flags used for the fds passed into QEMU need
>   to match the flags QEMU uses to open the file. Currently O_WRONLY
>   for src and O_RDONLY for dst.
> 
> O_DIRECT is not supported on all systems/filesystems, so run the fdset
> test without O_DIRECT if that's the case. The migration code should
> still work in that scenario.

If O_DIRECT is not supported, then we're not setting 'direct-io',
and thus isn't this test just duplicating coverage of existing
tests ?

If this test is specifically to cover O_DIRECT, then I'd just
#ifdef the entire thing with O_DIRECT.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 90 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 512b7ede8b..d83f1bdd4f 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2331,8 +2331,93 @@ static void test_multifd_file_mapped_ram_dio(void)
>      test_file_common(&args, true);
>  }
>  
> +static void migrate_multifd_mapped_ram_fdset_dio_end(QTestState *from,
> +                                                    QTestState *to,
> +                                                    void *opaque)
> +{
> +    QDict *resp;
> +    QList *fdsets;
> +
> +    file_offset_finish_hook(from, to, opaque);
> +
> +    /*
> +     * Check that we removed the fdsets after migration, otherwise a
> +     * second migration would fail due to too many fdsets.
> +     */
> +
> +    resp = qtest_qmp(from, "{'execute': 'query-fdsets', "
> +                     "'arguments': {}}");
> +    g_assert(qdict_haskey(resp, "return"));
> +    fdsets = qdict_get_qlist(resp, "return");
> +    g_assert(fdsets && qlist_empty(fdsets));
> +}
>  #endif /* O_DIRECT */
>  
> +#ifndef _WIN32
> +static void *migrate_multifd_mapped_ram_fdset(QTestState *from, QTestState *to)
> +{
> +    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
> +    int fds[3];
> +    int src_flags = O_WRONLY;
> +
> +    file_dirty_offset_region();
> +
> +    /* main outgoing channel: no O_DIRECT */
> +    fds[0] = open(file, src_flags, 0660);
> +    assert(fds[0] != -1);
> +
> +    qtest_qmp_fds_assert_success(from, &fds[0], 1, "{'execute': 'add-fd', "
> +                                 "'arguments': {'fdset-id': 1}}");
> +
> +#ifdef O_DIRECT
> +    src_flags |= O_DIRECT;
> +
> +    /* secondary outgoing channels */
> +    fds[1] = open(file, src_flags, 0660);
> +    assert(fds[1] != -1);
> +
> +    qtest_qmp_fds_assert_success(from, &fds[1], 1, "{'execute': 'add-fd', "
> +                                 "'arguments': {'fdset-id': 1}}");
> +
> +    /* incoming channel */
> +    fds[2] = open(file, O_CREAT | O_RDONLY, 0660);
> +    assert(fds[2] != -1);
> +
> +    qtest_qmp_fds_assert_success(to, &fds[2], 1, "{'execute': 'add-fd', "
> +                                 "'arguments': {'fdset-id': 1}}");
> +
> +    migrate_multifd_mapped_ram_dio_start(from, to);
> +#else
> +    migrate_multifd_mapped_ram_start(from, to);
> +#endif
> +
> +    return NULL;
> +}
> +
> +static void test_multifd_file_mapped_ram_fdset(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
> +                                           FILE_TEST_OFFSET);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .start_hook = migrate_multifd_mapped_ram_fdset,
> +#ifdef O_DIRECT
> +        .finish_hook = migrate_multifd_mapped_ram_fdset_dio_end,
> +#endif
> +    };
> +
> +#ifdef O_DIRECT
> +    if (!probe_o_direct_support(tmpfs)) {
> +        g_test_skip("Filesystem does not support O_DIRECT");
> +        return;
> +    }
> +#endif
> +
> +    test_file_common(&args, true);
> +}
> +#endif /* _WIN32 */
> +
>  static void test_precopy_tcp_plain(void)
>  {
>      MigrateCommon args = {
> @@ -3761,6 +3846,11 @@ int main(int argc, char **argv)
>                         test_multifd_file_mapped_ram_dio);
>  #endif
>  
> +#ifndef _WIN32
> +    qtest_add_func("/migration/multifd/file/mapped-ram/fdset",
> +                   test_multifd_file_mapped_ram_fdset);
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


