Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC28BC98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rEK-0001wM-3C; Thu, 24 Sep 2026 17:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x9rEF-0001w6-TE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x9rED-0001Ip-WC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790286220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qL0mklFhHwLyO8eqXZBIulmeA7xhQQb1Jd+zb0BfiYg=;
 b=HIEHMvlZXRR68hgYvjPRXARXFZuTkWQGvXCJob1gTSIWVsTt3AEkbC0DdvhLp8Q6VNnR7/
 7zNGzPKKla7VrgEldb3IWAhNx1Kle4uJrp7eg5IK1Cc8M1lIQpPywNqCxvwvE1SNgsDLhZ
 e6mtYIc1phVXQvPEuAnNRxlb6IjjAs4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-5Vh788KOMvqdDhIBW13vbg-1; Thu,
 24 Sep 2026 17:43:38 -0400
X-MC-Unique: 5Vh788KOMvqdDhIBW13vbg-1
X-Mimecast-MFC-AGG-ID: 5Vh788KOMvqdDhIBW13vbg_1790286217
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BF471955F1F; Thu, 24 Sep 2026 21:43:37 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61A6F180057F; Thu, 24 Sep 2026 21:43:36 +0000 (UTC)
Date: Thu, 24 Sep 2026 23:43:33 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/3] linux-user/sh4: fix race in atomic variables
In-Reply-To: <20260923220654.127167-1-richard.henderson@linaro.org>
Message-ID: <dcccc3cb-9554-5474-32e1-303e8b5d1e47@redhat.com>
References: <20260923220654.127167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On Wed, 23 Sep 2026, Richard Henderson wrote:

> Fix the race detailed in patch 2 in a more generic fashion.
> 
> Squash the silly loop that was part of the problem by suppressing
> interrupts within cpu_exec_step_atomic.
> 
> 
> r~
> 
> 
> Richard Henderson (3):
>   accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
>   target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with CF_STEP_ATOMIC
>   target/sh4: Drop use_exit_tb
> 
>  include/exec/translation-block.h |  1 +
>  target/sh4/cpu.h                 |  6 ++--
>  accel/tcg/cpu-exec.c             |  4 ++-
>  target/sh4/translate.c           | 48 +++++++++++++++-----------------
>  4 files changed, 28 insertions(+), 31 deletions(-)
> 
> -- 
> 2.53.0

Thanks, I tested the patches and it works.

Tested-by: Mikulas Patocka <mpatocka@redhat.com>

Mikulas


