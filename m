Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EDED44D56
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zvz-0002pZ-DN; Thu, 07 Nov 2024 05:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8zvy-0002oz-Fy
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:40:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8zvw-0005MD-1D
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730976009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8wsVuHcE/AJbEuWPFf1Axp/o8h4o52S9dYUSBzqjyeo=;
 b=B9GR+Aci8sXO2O0f0JlZ6DuoTxt+Ev9skkstdEceLmzyAfTHhsX8xAKJFqz4HW8oIAKsR0
 CiUop7JYhlD5co77k5TzSKRKly0WKxRmpFjW7Hwka6riv+jc54NLausUqlX7pYCOT0Mic5
 hJ04S/aYDWt3iaeFpTsasQFqEa3k92g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-U0y-gXpwONy9oS_k_roe7Q-1; Thu,
 07 Nov 2024 05:40:07 -0500
X-MC-Unique: U0y-gXpwONy9oS_k_roe7Q-1
X-Mimecast-MFC-AGG-ID: U0y-gXpwONy9oS_k_roe7Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C4C71955F69; Thu,  7 Nov 2024 10:40:06 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99D381956054; Thu,  7 Nov 2024 10:40:04 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/3] QGA fixes for guest_network_get_route command for 9.2
Date: Thu,  7 Nov 2024 12:39:58 +0200
Message-ID: <20241107104001.66039-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The following changes since commit f15f7273ea55472d5904c53566c82369d81214c1:

  Merge tag 'pull-target-arm-20241105' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-05 21:27:18 +0000)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-11-07

for you to fetch changes up to 5ab1c032e6eea810142eb918c57222464482756f:

  qemu-ga: Avoiding freeing line prematurely (2024-11-07 12:28:20 +0200)

----------------------------------------------------------------
qga-pull-2024-11-07

----------------------------------------------------------------
Dehan Meng (3):
      qemu-ga: Add 'Null' check and Redefine 'route'
      qemu-ga: Optimize var declaration and definition
      qemu-ga: Avoiding freeing line prematurely

 qga/commands-linux.c | 136 +++++++++++++++++++++++++--------------------------
 1 file changed, 66 insertions(+), 70 deletions(-)

--
2.47.0


