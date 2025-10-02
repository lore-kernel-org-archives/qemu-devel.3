Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252FACAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Jvy-0006ao-Du; Thu, 02 Oct 2025 10:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v4Jvv-0006aS-J1
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v4Jvj-0005hD-0B
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759413898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9amMnUU8RVSypkHnAn8Mvq6+kyn+DhLsN7tI6WR4t0=;
 b=eBG/XpKpP8vzRAYlbuVhkoCAWv/EgVYHeXSR7lg+GiJ63FEjEuVveGxIiD9a+DXLxsNkfI
 U9g56dYmYqxzQKQjWbT6IeqlcT+j5pOxDXygllWCq8p1mAwdm+KryS0fnLph6aKU80Bkf6
 yXe1uRMFP/X2AZ5Pq0358l1US+JQKRc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-M3LkeQKtMPKCvY2hifG18Q-1; Thu,
 02 Oct 2025 10:04:51 -0400
X-MC-Unique: M3LkeQKtMPKCvY2hifG18Q-1
X-Mimecast-MFC-AGG-ID: M3LkeQKtMPKCvY2hifG18Q_1759413890
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92F0D1956053; Thu,  2 Oct 2025 14:04:49 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.182])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4AAC19560B8; Thu,  2 Oct 2025 14:04:47 +0000 (UTC)
Date: Thu, 2 Oct 2025 16:04:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] tests/qemu-iotests: Improve the dry run list to
 speed up thorough testing
Message-ID: <aN6GfX8js5f_nS_o@redhat.com>
References: <20250910153727.226217-1-thuth@redhat.com>
 <20250910153727.226217-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910153727.226217-3-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 10.09.2025 um 17:37 hat Thomas Huth geschrieben:
> From: Thomas Huth <thuth@redhat.com>
> 
> When running the tests in thorough mode, e.g. with:
> 
>  make -j$(nproc) check SPEED=thorough
> 
> we currently always get a huge amount of total tests that the test
> runner tries to execute (2457 in my case), but a big bunch of them are
> only skipped (1099 in my case, meaning that only 1358 got executed).
> This happens because we try to run the whole set of iotests for multiple
> image formats while a lot of the tests can only run with one certain
> format only and thus are marked as SKIP during execution. This is quite a
> waste of time during each test run, and also unnecessarily blows up the
> displayed list of executed tests in the console output.
> 
> Thus let's try to be a little bit smarter: If the "check" script is run
> with "-n" and an image format switch (like "-qed") at the same time (which
> is what we do already for discovering the tests for the meson test runner),
> only report the tests that likely support the given format instead of
> providing the whole list of all tests. We can determine whether a test
> supports a format or not by looking at the lines in the file that contain
> a "supported_fmt" or "unsupported_fmt" statement. This is only heuristics,
> of course, but it is good enough for running the iotests via "make
> check-block" - I double-checked that the list of executed tests does not
> get changed by this patch, it's only the tests that are skipped anyway that
> are now not run anymore.
> 
> This way the amount of total tests drops from 2457 to 1432 for me, and
> the amount of skipped tests drops from 1099 to just 74 (meaning that we
> still properly run 1432 - 74 = 1358 tests as we did before).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/check | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)

> +def dry_run_list(test_dir, imgfmt, testlist):
> +    for t in testlist:
> +        if not imgfmt:
> +            print('\n'.join([os.path.basename(t)]))
> +            continue
> +        # If a format has been given, we look for the "supported_fmt"
> +        # and the "unsupported_fmt" lines in the test and try to find out
> +        # whether the format is supported or not. This is only heuristics,
> +        # but it should be good enough for "make check-block"

I'm not completely sure if this is a good idea at all, but I think we
should at least mention the possible surprising cases where the
heuristics fails in this comment.

One thing is that '_unsupported_fmt qcow' will also disable the test
case for qcow2. 181 would almost run into this, but because it has
'_supported_fmt generic' first (which is an order not required by
anything else) and you stop after seeing this line, the test as written
currently is still returned (for both qcow and qcow2).

Actually, I suspect that the '_supported_fmt generic' tests that are
then followed by an '_unsupported_fmt' line are the majority of the
still skipped cases you see. (We don't have to do anything about it,
just an observation.)

There are other theoretical scenarios, like multiple options on a single
line in Python, but I think in practice you'll never combine block
driver names that this would skip something it shouldn't skip (apart
from the same 'qcow2' and 'qcow' problem).

Kevin


