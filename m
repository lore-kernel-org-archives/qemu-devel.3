Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB361606A92E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=cE/iKAdZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP0Xb-0007wx-I4; Thu, 05 Nov 2026 11:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xP0XU-0007w0-Hd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:42:14 -0500
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xP0XQ-00029U-EV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:42:11 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.0.161])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jL7PZ4mZCz3xVQ;
 Thu,  5 Nov 2026 16:41:54 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 17:41:53 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Guillaume Vincke
 <guillaume.vincke@ovhcloud.com>
Subject: [PATCH v3 0/2] nbd/client-connection: Fix client returning a closed
 channel
Date: Thu, 5 Nov 2026 17:41:22 +0100
Message-ID: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 12813585366188114215
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGkduLjVF85I0khH1OxuKJhvVynFF9DnCMiP2xkO6+hsW+7/ZSRkhxzYcYPqobMPlZ5lYUkRuHvi1OeKuzuf1YLct+dkPi0IlnYFvWn3H6JPjorJn2YCmTbRYc5iQd/UEpdTFZAjHQoPak8i4/4bcEERMaOOAD/SbosoorMDLHN12r99aRgKNph7HNSv+9h63C3KW5kNmIhT/rn7thahDVwSP3x6t3WcTtmcXP99D1HJL5fgM2XyJkuHxlX+ZbXsNzZfZgHtDiDL/EmeWDr1tqrRDDtL/EQZtyV2FasUKK0eMX/EwnVv0fGZph7bCX+Yn1ajObQJY0N8043mz9s7yr4PDPnn0kEwQm/pNcC4cDPp7MNUEmxVQJexDoPWTNJOm1XjMEqJYy2EVyC+tOqtQyrhb97/ppRbKVaX7RzSuMdZ1sT58l4s0j2oGyvWeRQNjMM3UQ/DX01o/HfzH6bAfVgp2FuWni7GcRnuEP4MvIrSgUeqG3AfG4Cl8e+4wJdTHgsHRsMTqHFi14UkHGmahHYgPInQk5FhTLjaMhW4v+Y8wWEwZhVa2ifntMJqpHbQo7pBnaZJsu/JWWCUdqJ2w6EUsQmnHxOYQMkhGv0msXlKaAbbhkAX/0F612fIt6NXfZZzNIka1ONRXE78XJdsyIjY0hNncfFNzo7WSxDY95zaA
DKIM-Signature: a=rsa-sha256; bh=/+hwAZC/uTX77ZBRYzjjIKnmwbhSk+oU3Bt1bxqsm+I=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1793896915; v=1; 
 b=cE/iKAdZKEkh3GUGFUAKJmt6tRuLhTjXNh1zX/god/UanklDcQ9qGig7H7okq8mSnt2kt2rc
 22UqAwPZ3yN3G2sbeZiI+C+vh1RmdmDFPscdOED4yEh4Om9od9BPEImsvEfpOt2qKaSKsY4hwZF
 jubn85D6kYxff/44IZ+qeyWk=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NBD client relies on lazy reconnection on error. There is a case where
nbd_co_establish_connection() will hand back a channel disconnected by
its peer. This leads to the request running on the dead channel. When
reconnect-delay is set to 0 (the default), this bug prevents the
nbd-connect thread from running on the first operation. This patch set
addresses this specific case.

Found while searching for a way to force client reconnection to simplify
the resize of idle nodes which will be the subject of another patch set.

v1: https://patchew.org/QEMU/20260925155346.357703-1-guillaume.vincke@ovhcloud.com/
v2: https://patchew.org/QEMU/20261016084136.233836-1-guillaume.vincke@ovhcloud.com/

v1 -> v2:
- patch 1: Pick up Eric Blake's formatting changes.
- patch 2: Start the connect thread after the NBD server so the test no
longer depends on the 1s connect retry, which made v1 fail in CI. Raise
the connect wait to 1s.

v2 -> v3:
- patch 2: Restrict the test to qcow2. The luks CI failure was the
missing key-secret and the parallels failure was the dirty-image repair
message. Neither was timing.

v3 does not use a more robust method than sleeping to wait for the NBD
client to reach the desired state. An option would be to add a QMP
unstable debug query reporting the NBD client state and whether the
connect thread has a channel ready. The test would poll this instead of
sleeping. Would that be an acceptable follow-up?

Guillaume Vincke (2):
  nbd/client-connection: Fix client returning a closed channel
  iotests: Add coverage for NBD connect thread start delay

 nbd/client-connection.c                       | 32 ++++++++++
 tests/qemu-iotests/tests/nbd-stale-connection | 60 +++++++++++++++++++
 .../tests/nbd-stale-connection.out            | 17 ++++++
 3 files changed, 109 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out

-- 
2.43.0


