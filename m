Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6367AC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 06:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJR1b-0000op-4s; Mon, 26 May 2025 02:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJR1X-0000oL-JB
 for qemu-devel@nongnu.org; Mon, 26 May 2025 02:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJR1V-0006Ip-Lo
 for qemu-devel@nongnu.org; Mon, 26 May 2025 02:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748239759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZilIz7FWnS1OfGqz/1CDvegrKKm5lsnsQNj5oYNOkJI=;
 b=SXhggmtDbEB7332QcDfrosuOAgN6C8Z/djZ+sWy5pDmeDmvcYh9NgLoz2Y29abn1hPiZhH
 G0yTbxzVSypg5tGXGtD34eSjV7acQOznglW4TkN4+C82cBNKrjIbN1n9cwkaO9oGT7+QxQ
 8A3xnPEI0Q5iAj8A309dikA4/81bik4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-9ZeyZakfN-uSP_gYUh0T8w-1; Mon,
 26 May 2025 02:09:17 -0400
X-MC-Unique: 9ZeyZakfN-uSP_gYUh0T8w-1
X-Mimecast-MFC-AGG-ID: 9ZeyZakfN-uSP_gYUh0T8w_1748239757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1AAD1800570; Mon, 26 May 2025 06:09:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 795D619560AB; Mon, 26 May 2025 06:09:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E354F21E6768; Mon, 26 May 2025 08:09:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] tests/qtest: Remove migration-helpers.c
In-Reply-To: <20250523123023.19284-1-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 23 May 2025 09:30:23 -0300")
References: <20250523123023.19284-1-farosas@suse.de>
Date: Mon, 26 May 2025 08:09:13 +0200
Message-ID: <87msazkinq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Fabiano Rosas <farosas@suse.de> writes:

> Commit 407bc4bf90 ("qapi: Move include/qapi/qmp/ to include/qobject/")
> brought the migration-helpers.c back by mistake. This file has been
> replaced with migration/migration-qmp.c and
> migration/migration-util.c.
>
> Fixes: 407bc4bf90 ("qapi: Move include/qapi/qmp/ to include/qobject/")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I have no idea how that happened.  Rebase accident, perhaps?  Thanks for
cleaning up the mess I made!

Your patch does what it says on the tin, but there's another dangling
#include:

    $ git-grep migration-helpers
--> tests/qtest/dbus-vmstate-test.c:#include "migration-helpers.h"
    tests/qtest/migration-helpers.c:#include "migration-helpers.h"

Missed in commit b7d7f723a985 (tests/qtest/migration: Rename
migration-helpers.c).  Looks like dbus-vmstate-test is never compiled in
CI.  Dig, dig...

    dbus_daemon = find_program('dbus-daemon', required: false)
    if dbus_daemon.found() and gdbus_codegen.found()
      # Temporarily disabled due to Patchew failures:
-->   #qtests_i386 += ['dbus-vmstate-test']
      dbus_vmstate1 = custom_target('dbus-vmstate description',
                                    output: ['dbus-vmstate1.h', 'dbus-vmstate1.c'],
                                    input: meson.project_source_root() / 'backends/dbus-vmstate1.xml',
                                    command: [gdbus_codegen, '@INPUT@',
                                              '--interface-prefix', 'org.qemu',
                                              '--generate-c-code', '@BASENAME@']).to_list()
    else
      dbus_vmstate1 = []
    endif

It's been "emporarily" disabled for more than five years:

commit d46f81cb746d18b4530b5fe63e75b11f6b926f1f
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Tue Mar 10 15:21:41 2020 +0000

    tests: Disable dbus-vmstate-test
    
    The dbus-vmstate-test has been failing in some Patchew configs
    since about the 6th March:
    
      dbus-daemon[9321]: Could not get password database information for UID of current process: User "???" unknown or no memory to allocate password entry
    
      **
      ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
      cleaning up pid 9321
      ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
      make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86_64] Error 1
      make: *** Waiting for unfinished jobs....
    
    It's not clear why this is happening (perhaps a recently revealed
    race condition or a change in the patchew build environment?).
    
    For the moment, disable this test so that patchew test runs are
    useful and don't email the list with spurious failure mails.
    
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
    Message-id: 20200310152141.13959-1-peter.maydell@linaro.org

Separate issue, so for this patch
Reviewed-by: Markus Armbruster <armbru@redhat.com>


