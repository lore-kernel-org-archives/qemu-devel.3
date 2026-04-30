Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF975CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGO-000423-N4; Thu, 30 Apr 2026 10:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1wIRNU-0002jU-2Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:24:28 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1wIRNR-0008C3-DP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:24:27 -0400
Received: from localhost.localdomain (1.general.hector.uk.vpn [10.172.192.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1615A3F69B; 
 Thu, 30 Apr 2026 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777555462;
 bh=kXXVJl0ODHN5s7FNtsXQd5oP5uALJWlq/V9Fz9lDZF4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=RK7AnXCA+biOJYX7i1TPHjnRzi8RsGHqYM31YQLF1Kdq4MOAQ+5Zw6EZBbYg5XI/x
 BoZkAnSP5GASEoiYlpEU7uVPVGNh6AHj92eUjAqPb2VB2pKT2Os4vsJb+3dz/alqA2
 qJ/OQdu9WYcLqcu17oBUEEEayAdODRljLgra1WkJjvJwaJOITGtt9pWSDTyW4WpyAj
 7iVoBVGxmYtOV5Ap64cg41EzEp1yx1UyFyYGCMz2jrOZ1vucFUU4FCLJHBIo3En9l/
 DJcYgotnXS2hG6jRniBz0eynYM2rWpe8lh6e44NZNOBAeonRiVfefff9/C5rKpNfuP
 Knfz+9jbFb4coPVvmsrJfgdgLPPqNtj7OAqHI6dTnz77UFoxGUSTfVK2JT9LYhI6KL
 LXtZicWe5CVk/++6Wv4Uu4SiO6a163ilvmBLXecK6gQOawrvrTpZWUz8roAdc9XLGi
 wJzPII69ai5+en0VfZf3YVoVm6AAvGz0mFu8Hf3r0rLceXMvf7kigbtIeaHqyX1FL2
 GyWrtGS1+mXDJME/2XORdG0AnxB3JfkTGUaGFOpz3+mEjzD4n9gsDQLk/Ewf9v9TqU
 lpcbWnSWOJo7y/HMdE0VZ9o7i1LIu4PkrW60fFNd+C8rZL/EDC7X/PWjKLOUEkTn5A
 q+6D+w8qREy+EzTtKdNUAW2U=
From: Hector Cao <hector.cao@canonical.com>
To: qemu-devel@nongnu.org
Cc: cfontana@suse.de, richard.henderson@linaro.org, pbonzini@redhat.com,
 gabriel.hartmann@netways.de
Subject: [PATCH v2 0/1] module: fix early stop for load module function
Date: Thu, 30 Apr 2026 15:24:17 +0200
Message-ID: <20260430132418.275842-1-hector.cao@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.120;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-canonical-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

please find the v2 submission for fixing the early stop
of module loading function.

v2:
* better management of the error (errp) to avoid assert
  on reuse
* set rv return code to -1 to stay compliant with the
  load_module() API specification in case the module load fails.

Hector Cao (1):
  module: fix early stop for load module function

 util/module.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

-- 
2.43.0


