Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BFC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjb0a-0004V5-TU; Tue, 14 Jul 2026 07:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjb0a-0004UV-3w
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjb0X-0006Ra-VX
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784027340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hOsATTuaeZG6V0zyFE811nYlBGFjbQgqIchT9vAbik8=;
 b=SiFtVWrqOiUq7mb/h4dsn9z+WoV8MeOI1nixaa+fRRDY/Yi5KKXwxSjgW9Ybtwkj4laN/J
 S7YfDMiPRwYZY4Gj+Vb7RSQZumhxZfAo/xsTT6O0eNk/sQyI+PcqrVJ03l0eeqlErF6yOE
 scV0YSI5YIuPSZ2lLCCCtNSzwBRwhBs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-MZXLWtyDP6CVJjI_qbPJbg-1; Tue,
 14 Jul 2026 07:08:58 -0400
X-MC-Unique: MZXLWtyDP6CVJjI_qbPJbg-1
X-Mimecast-MFC-AGG-ID: MZXLWtyDP6CVJjI_qbPJbg_1784027337
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D58D31955F16; Tue, 14 Jul 2026 11:08:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53409180035F; Tue, 14 Jul 2026 11:08:56 +0000 (UTC)
Date: Tue, 14 Jul 2026 13:08:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/3] iotests: run the test pool with the 'fork' start
 method
Message-ID: <alYYxYcpZEm6qN1M@redhat.com>
References: <20260710161309.1104712-1-den@openvz.org>
 <20260710161309.1104712-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710161309.1104712-2-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kwolf@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 10.07.2026 um 18:13 hat Denis V. Lunev geschrieben:
> run_tests_pool() shares the runner via the class attribute
> TestRunner.shared_self, relying on worker processes to inherit it.
> That only works with the 'fork' start method. Python 3.14 switched
> the Linux default to 'forkserver', so workers see shared_self as
> None and parallel runs abort with:
> 
>   assert runner is not None
>   AssertionError
> 
> Only reproduces with Python 3.14+ and 'check -jN' (N > 1); meson
> runs one test per process and never calls run_tests_pool(), so CI
> is unaffected.
> 
> Request get_context('fork') explicitly; it is available on all
> supported Python versions and a no-op before 3.14.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>  tests/qemu-iotests/testrunner.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
> index dbe2dddc32..5b2664d9f3 100644
> --- a/tests/qemu-iotests/testrunner.py
> +++ b/tests/qemu-iotests/testrunner.py
> @@ -26,7 +26,7 @@
>  import json
>  import shutil
>  import sys
> -from multiprocessing import Pool
> +from multiprocessing import Pool, get_context
>  from typing import List, Optional, Any, Sequence, Dict
>  from testenv import TestEnv
>  
> @@ -125,7 +125,7 @@ def run_tests_pool(self, tests: List[str],
>          assert TestRunner.shared_self is None
>          TestRunner.shared_self = self
>  
> -        with Pool(jobs) as p:
> +        with get_context('fork').Pool(jobs) as p:
>              results = p.starmap(self.proc_run_test,
>                                  zip(tests, [test_field_width] * len(tests)))

Makes sense, but the Pool import is now unused:

 === pylint ===
+************* Module testrunner
+testrunner.py:29:0: W0611: Unused Pool imported from multiprocessing (unused-import)
 === mypy ===

Kevin


