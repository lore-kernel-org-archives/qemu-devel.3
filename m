Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D0DD1AD43
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t118k-0000KL-Fk; Wed, 16 Oct 2024 06:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t118g-0000Jp-Rt
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t118f-0002mT-6T
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729074019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qjMV6IFXMIFaUc9QMeKz16C92+HbCPAACDPEy3sqKt0=;
 b=MBtDUubi1MMVTCsp5Qwho5Gyfo/XfIoo8y3Ns6D9cwIChI8i+zzXE9G5tOJdxMbohTJzsM
 NWbVc4E5ppOH4u9+MVivFtzcnIfzYJPwvzQQydUCb9dV6IKEpVcAfOUaut2022y8sRe/Jj
 YOlgvuhbzr0icz/uoyT8/Mo9LvAnhDg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-ft637SLLMxKBR6LmPgDSbA-1; Wed,
 16 Oct 2024 06:20:15 -0400
X-MC-Unique: ft637SLLMxKBR6LmPgDSbA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18EEA1964CEC; Wed, 16 Oct 2024 10:20:10 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2A7E1955E7F; Wed, 16 Oct 2024 10:20:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PATCH v2 0/3] crypto: fix regression in hash result buffer handling
Date: Wed, 16 Oct 2024 11:20:03 +0100
Message-ID: <20241016102006.480218-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Daniel P. Berrangé (3):
  crypto/hash: avoid overwriting user supplied result pointer
  tests: correctly validate result buffer in hash/hmac tests
  include/crypto: clarify @result/@result_len for hash/hmac APIs

 crypto/hash-gcrypt.c          | 15 ++++++++++++---
 crypto/hash-glib.c            | 11 +++++++++--
 crypto/hash-gnutls.c          | 16 +++++++++++++---
 crypto/hash-nettle.c          | 14 +++++++++++---
 include/crypto/hash.h         | 30 +++++++++++++++++++++++-------
 include/crypto/hmac.h         | 17 ++++++++++++-----
 tests/unit/test-crypto-hash.c |  7 ++++---
 tests/unit/test-crypto-hmac.c |  6 ++++--
 8 files changed, 88 insertions(+), 28 deletions(-)

-- 
2.46.0


