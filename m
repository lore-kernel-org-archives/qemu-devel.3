Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B885C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9KjS-0000d5-9G; Tue, 21 May 2024 04:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9KjQ-0000ck-Pu
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9KjO-00046Q-Pk
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716279618;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FNDnqfzG5OQOeeLKdR90CnrFJYqiPUYj5+DdXbdcMn8=;
 b=jA5JA1n6aSe4GOY/b9CG3KMET/SDhLp+BmVAVlQ/CTcDiDySsSCdEbWc6XlDY2YbiWSP2y
 ahojmHwSjjDONsCbpbD0l0tFW1RaXwTJ7H5EpJOP/pOUvOZy/nNPBNu77yoosOAUQDf6IK
 8q8nRFr5djQ2n4/PcU8ZtKisB2cL+pQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-OE-XWr3CM02FiZn79kdKUA-1; Tue, 21 May 2024 04:20:11 -0400
X-MC-Unique: OE-XWr3CM02FiZn79kdKUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88659185AD2C;
 Tue, 21 May 2024 08:20:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 631E21C09480;
 Tue, 21 May 2024 08:20:08 +0000 (UTC)
Date: Tue, 21 May 2024 09:20:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 20/26] migration: cpr-exec mode
Message-ID: <ZkxZNtLnyIsVf_Dw@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-21-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-21-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Apr 29, 2024 at 08:55:29AM -0700, Steve Sistare wrote:
> Add the cpr-exec migration mode.  Usage:
>   qemu-system-$arch -machine memfd-alloc=on ...
>   migrate_set_parameter mode cpr-exec
>   migrate_set_parameter cpr-exec-args \
>     <arg1> <arg2> ... -incoming <uri>
>   migrate -d <uri>
> 
> The migrate command stops the VM, saves state to the URI,
> directly exec's a new version of QEMU on the same host,
> replacing the original process while retaining its PID, and
> loads state from the URI.  Guest RAM is preserved in place,
> albeit with new virtual addresses.
> 
> Arguments for the new QEMU process are taken from the
> @cpr-exec-args parameter.  The first argument should be the
> path of a new QEMU binary, or a prefix command that exec's the
> new QEMU binary.
> 
> Because old QEMU terminates when new QEMU starts, one cannot
> stream data between the two, so the URI must be a type, such as
> a file, that reads all data before old QEMU exits.
> 
> Memory backend objects must have the share=on attribute, and
> must be mmap'able in the new QEMU process.  For example,
> memory-backend-file is acceptable, but memory-backend-ram is
> not.
> 
> The VM must be started with the '-machine memfd-alloc=on'
> option.  This causes implicit ram blocks (those not explicitly
> described by a memory-backend object) to be allocated by
> mmap'ing a memfd.  Examples include VGA, ROM, and even guest
> RAM when it is specified without a memory-backend object.
> 
> The implementation saves precreate vmstate at the end of normal
> migration in migrate_fd_cleanup, and tells the main loop to call
> cpr_exec.  Incoming qemu loads preceate state early, before objects
> are created.  The memfds are kept open across exec by clearing the
> close-on-exec flag, their values are saved in precreate vmstate,
> and they are mmap'd in new qemu.
> 
> Note that the memfd-alloc option is not related to memory-backend-memfd.
> Later patches add support for memory-backend-memfd, and for additional
> devices, including vfio, chardev, and more.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/cpr.h  |  14 +++++
>  include/migration/misc.h |   3 ++
>  migration/cpr.c          | 131 +++++++++++++++++++++++++++++++++++++++++++++++
>  migration/meson.build    |   1 +
>  migration/migration.c    |  21 ++++++++
>  migration/migration.h    |   5 +-
>  migration/ram.c          |   1 +
>  qapi/migration.json      |  30 ++++++++++-
>  system/physmem.c         |   2 +
>  system/vl.c              |   4 ++
>  10 files changed, 210 insertions(+), 2 deletions(-)
>  create mode 100644 include/migration/cpr.h
>  create mode 100644 migration/cpr.c
> 

> +
> +void cpr_exec(char **argv)
> +{
> +    MigrationState *s = migrate_get_current();
> +    Error *err = NULL;
> +
> +    /*
> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
> +     * earlier because they should not persist across miscellaneous fork and
> +     * exec calls that are performed during normal operation.
> +     */
> +    cpr_preserve_fds();
> +
> +    execvp(argv[0], argv);
> +
> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);

This is where you could give a more direct message about the sandbox.
eg

   if (errno == EPERM) {
      error_append_hint("sandbox is blocking ability to exec");
   }

this would also benefit the case where an external sandbox is
used, rather than qemu's built-in sandbox.

> +    error_report_err(err);
> +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +    migrate_set_error(s, err);
> +    migration_precreate_unsave();
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


