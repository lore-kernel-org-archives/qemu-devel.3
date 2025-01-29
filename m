Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C666EC02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8NM-0007aQ-RY; Wed, 29 Jan 2025 08:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NB-0007ZU-K6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8N9-00088e-8G
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738158289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eLkU0jczH9+axJY8TTBFUBAllbC/EeHNAL6GZX89o9o=;
 b=bdH/Wk00oIhhNbj4EIu4ipIHGW6rx9eKyPISZaCKOQ1F0P1ned7L88hIcJvzHvDL65ym4m
 7oKoUQwAiV1TC+AIJTOUzlOIp+1YtxU4UIFXOTm/qGlOP3ffxcfeSHR9lNo+WZ4igXml2b
 E4paWbfF3os+HeavL8mOg9vtHIeYZQ0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-FzkuO1cAOXWl0-JRVVJHgw-1; Wed,
 29 Jan 2025 08:44:46 -0500
X-MC-Unique: FzkuO1cAOXWl0-JRVVJHgw-1
X-Mimecast-MFC-AGG-ID: FzkuO1cAOXWl0-JRVVJHgw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73D35195605A; Wed, 29 Jan 2025 13:44:43 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B3CF1800352; Wed, 29 Jan 2025 13:44:39 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, gaosong@loongson.cn, laurent@vivier.eu
Subject: [PATCH 0/6] tcg: fix qemu crash when add assert_cpu_is_self() is
 enabled and cleanups related to cpu->created check
Date: Wed, 29 Jan 2025 14:44:30 +0100
Message-ID: <20250129134436.1240740-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

1st 3 patches are cleanups around cpu_reset logic
4th patch enables assert_cpu_is_self() macro on --enable-debug builds
5th drops offending patch
    (since my understanding of TCG is close to nill, so I'd leave it up to
     TCG folks to fix if needed properly) 
6th is removing no longer needed cpu->created check, since
    by the time it's invoked, cpu->created == true

CC: alex.bennee@linaro.org
CC: richard.henderson@linaro.org
CC: pbonzini@redhat.com 
CC: imp@bsdimp.com
CC: kevans@freebsd.org
CC: gaosong@loongson.cn
CC: laurent@vivier.eu

Igor Mammedov (6):
  bsd-user: drop not longer used target_reset_cpu()
  loongarch: reset vcpu after it's created
  m68k: reset vcpu after it's created
  tcg:tlb: use tcg_debug_assert() in assert_cpu_is_self()
  Revert "tcg/cputlb: remove other-cpu capability from TLB flushing"
  tcg: drop cpu->created check

 bsd-user/aarch64/target_arch_cpu.h |  5 ---
 bsd-user/arm/target_arch_cpu.h     |  4 ---
 bsd-user/i386/target_arch_cpu.h    |  5 ---
 bsd-user/riscv/target_arch_cpu.h   |  4 ---
 bsd-user/x86_64/target_arch_cpu.h  |  5 ---
 accel/tcg/cputlb.c                 | 53 +++++++++++++++++++++---------
 target/loongarch/cpu.c             |  2 +-
 target/m68k/cpu.c                  |  2 +-
 8 files changed, 39 insertions(+), 41 deletions(-)

-- 
2.43.0


