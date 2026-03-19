Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D513A109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IL6-0000Qx-At; Thu, 19 Mar 2026 14:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w3IL2-0000Pe-My
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:43:20 -0400
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w3IL0-0007N3-89
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:43:20 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 04127223182;
 Thu, 19 Mar 2026 18:43:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com
 (100-115-72-182.trex-nlb.outbound.svc.cluster.local [100.115.72.182])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 96ACB22317B;
 Thu, 19 Mar 2026 18:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773945793;
 b=6LS2OIH6t2VkYK+I71fKVDkUk5ydhA0/R5d6YFDeyEvi4dZkNxZPDDjCi226BNwsG08YEZ
 cBpxoQBxG3/zZ8YC6odbCo3T0yNHcgTHoKnQgsqzsO5GW+R1INqHAP6LbecmuagT1zj9Yx
 DPdIvLjMrSdZAfNqAH5t1rOjrFGE8DAUmSyYpgHR4iUFaYtsQKC5wuxPaPGh2UdYJoS/z/
 2bfVZX0uTSh/m2qv0OLc6Fe+S/xfF1lfOF2yGRizdwCWfEvAoKN/M1RU/EVZ45AqCvpSa+
 Uoo6BJoYJaDXcPxUR73/NZmECzuaT/xatb+0o06Nz748HA6ZhnkjaPIgIEgOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773945793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=aJ/6xWkZlH6NO7Ff7qmOszSXxiRY52wOFAFTxwsJZYA=;
 b=nVtl1j36vX3XvDzBYXglHMQLcMM3AVXG9UIwYko3uN8e4Z7Aiv/YARWvZ2wN9ZcUPDoWLf
 BsYIo9HPnsReRtWs1ZM1LtUKWYuabEndlyGniMJVUHRVRSvtM7oP3C5+/nobwPAJyZDcE1
 oMMebmC+8WaNRiIeVqK8D/xo3BxscgmRtKvBvDUUBUmc0IeL6XJuxMppj2Sp2nH02cY+J9
 G2bhvMGb8izKAQTFK33yUa4xpL/KM3qSBIglm+q7S0UPl2NNTQT1lwPzLBLH4ZHKRfC39m
 ORgBTPCsKDxpAhL79tmpIiWYXLa8TlF8S9F7YrXA7XqxSHDXzNagm6Tc9/qNjQ==
ARC-Authentication-Results: i=1; rspamd-7f98bb5847-b9j5n;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Wiry: 6afd8b96696e28c9_1773945793839_1018836678
X-MC-Loop-Signature: 1773945793839:2150298180
X-MC-Ingress-Time: 1773945793839
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.115.72.182 (trex/7.1.5); Thu, 19 Mar 2026 18:43:13 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4fcF290mDvz34; 
 Thu, 19 Mar 2026 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773945793;
 bh=aJ/6xWkZlH6NO7Ff7qmOszSXxiRY52wOFAFTxwsJZYA=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=p52jZUlVdfF/PhmnCyV+2TuOaheB+gUsH9J5bpi9NAPgnDkR6Q4q0FGk688vat9yV
 c5JOAqFgMw4k90m8M1NXTb+3RfKpd1k86FtQu9EQm7GIXsHrFX27hAFseNkFmLHZdT
 sEIpdXgFNsBRADi1GrTtJzce9DgIQoiEicWlbfiSCfCMDQvMfPsBLBaOiijXradBaf
 EmgqfzSsGB1zoXSc3O3pQKQAKiDvEAHOC9IaKRo2u0f2U3RVometG54zgILpt5cpZ5
 5pw3joscIRufC/t/lsF6MnecwKjx4rboe3u/T++Friws6blStmLZei3DZkzwVubmDT
 yu3DALwLYTVoQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v3 -qemu 0/2] hw/cxl: Media Operation Discovery fixlets
Date: Thu, 19 Mar 2026 11:42:54 -0700
Message-Id: <20260319184256.3762391-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.223.164; envelope-from=dave@stgolabs.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Changes from v2: indent fix in patch 1. Added reviewed+fixes tags.
Changes from v1: cleaned up comments in patch 2.

While working on the driver side of this, I tripped on two qemu issues
around discovery semantics. I think this is the first time these code
paths are exercised.

Davidlohr Bueso (2):
  hw/cxl: Respect Media Operation max ops discovery semantics
  hw/cxl: Exclude Discovery from Media Operation Discovery output

 hw/cxl/cxl-mailbox-utils.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.39.5


