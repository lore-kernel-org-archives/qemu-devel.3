Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68614606A336
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hP3/mF1X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7Ze-0002kX-Vt; Wed, 11 Nov 2026 07:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7ZX-0002is-De
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:37:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7ZV-0001Oc-El
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794400620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMfrvqWAxBU6yHWowUHPzvt+Iy+Os8eJPAwLpmC08hM=;
 b=hP3/mF1Xa4FBTTgvYEA34dEAONqgkZzcopF8O0bvNOrxv78CYsJGFPQynT5EXjq/2Dc1g2
 xHm7PuctnQXV3Dbf0TnbIeNNPPLjLd886+SP3gMH2hxuaPImN5ly3Ds8APQeoOCjsfq6VU
 J/L5OLw6zdbbLmeqdkNsPyZpoQz6RRk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-WUdK_FO0NDWDcv8bTpWbhw-1; Wed,
 11 Nov 2026 07:36:56 -0500
X-MC-Unique: WUdK_FO0NDWDcv8bTpWbhw-1
X-Mimecast-MFC-AGG-ID: WUdK_FO0NDWDcv8bTpWbhw_1794400615
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6BDA1800BEE; Wed, 11 Nov 2026 12:36:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49D5B1956086; Wed, 11 Nov 2026 12:36:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03A9221E6A04; Wed, 11 Nov 2026 13:36:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org,  imammedo@redhat.com,  berrange@redhat.com,
 peter.maydell@linaro.org
Subject: Use of qemu_memfd_check() in system/physmem.c (was: [PATCH 0/7]
 backends/hostmem: Make QOM types and properties unconditional)
In-Reply-To: <20261111122342.634370-1-armbru@redhat.com> (Markus Armbruster's
 message of "Wed, 11 Nov 2026 13:23:35 +0100")
References: <20261111122342.634370-1-armbru@redhat.com>
Date: Wed, 11 Nov 2026 13:36:52 +0100
Message-ID: <87qzgrv923.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After this series, there is just one use of qemu_memfd_check() outside
tests/ left:

    /*
     * Create MAP_SHARED RAMBlocks by mmap'ing a file descriptor, so it can be
     * shared with another process if CPR is being used.  Use memfd if available
     * because it has no size limits, else use POSIX shm.
     */
    static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
    {
        int fd = cpr_find_fd(name, 0);

        if (fd >= 0) {
            *reused = true;
            return fd;
        }

--->    if (qemu_memfd_check(0)) {
            fd = qemu_memfd_create(name, 0, 0, 0, 0, errp);
        } else {
            fd = qemu_shm_alloc(0, errp);
        }

        if (fd >= 0 && !cpr_save_fd(name, 0, fd, errp)) {
            close(fd);
            fd = -1;
        }
        *reused = false;
        return fd;
    }

We test whether memfd_create("test", MFD_CLOEXEC) succeeds to decide
whether to use memfd_create(name, MFD_CLOEXEC) or POSIX shared memory.
This is anti-pattern "predict which method should succed, then try that
method".  A better way is "try methods one after the other until one
succeeds".

Doing that here would require refactoring, because both
qemu_memfd_create() and qemu_shm_alloc() do additional work that can
also fail: ftruncate().

Doubt: qemu_memfd_create(0) caches its result[*].  Is that a mere
optimization, or does something depend on "we use the same method
always"?

I don't plan to mess with this myself, I'm merely reporting something I
found.


[*] Only when the argument is 0.


