Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8B606A896
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=RK0WLV5Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSYpl-0004Rn-BQ; Sun, 15 Nov 2026 06:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1xSYpc-0004R9-HS
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 06:55:37 -0500
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1xSYpZ-0002Q9-PD
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 06:55:36 -0500
Received: from [192.168.17.1] (unknown [124.79.98.159])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04f8;
 Sun, 15 Nov 2026 19:48:16 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH] migration/rdma: remove the dangling fd handler before
 re-entering loadvm
Date: Sun, 15 Nov 2026 19:48:13 +0800
Message-ID: <179474329361.103840.4072531561797843442@seu.edu.cn>
In-Reply-To: <ar6sjer6_pafjhhb@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260904033130.276-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-HM-Tid: 0aa1df0960b903a1kunmbac61c98bf7c3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkoeVk5CGUhDSUtJQ0hJSFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVCQklOS1
 VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
 b=RK0WLV5ZAlCC5wryC/Zfg/QzXJqcv7QYbuyAip8bHwuLLNMR5SjNpaAf0NJUPUtNsyrg2pHvVhuLq22iIXKIcscIDFqunIiQ35JNnPrEN1qI/dtomnttANcNVqBea2YLZAEwl7LrbFmM6dzNxTPY5LW9wsCBUBi9jzOXkhhJz5o=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=fyW36UmvDRZooZywH7plbBj1J9JPNpOc34KtzPfvCNM=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=101.71.155.101; envelope-from=getshell@seu.edu.cn;
 helo=mail-m155101.qiye.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

Thanks for confirming the problem and for the simpler suggestion.

I tried your version of the fix (remove the fd handler after
qemu_coroutine_yield() returns, instead of inside fd_coroutine_enter())
on top of qemu master e9fa1f66f0d4 and ran the existing tests:

  - tests/unit/test-coroutine: 13/13 passed
  - tests/unit/test-aio:      27/27 passed

Both the normal fd path and the re-entry path remove the handler exactly
once, and the stack-allocated FDYieldUntilData is no longer referenced by
a stale handler.

The analysis that led here (fd handler registered on a stack object and
re-entered through a path that bypasses fd_coroutine_enter()) came from
our in-house static analysis tool, so I am glad it matches a real issue
you had already seen.

Best regards,
Hongyan

