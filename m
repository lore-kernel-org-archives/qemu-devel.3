Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5939CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB907-0004B5-SG; Tue, 21 Oct 2025 05:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vB905-00049y-Ey
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vB903-0001wH-IW
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761040189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oX9qVRapdRnyLzUm3e38l1BBYvYc94xxQZWwXn/YXjQ=;
 b=XHVedbluHGxHHKev2aT+aEMsfALXSZZadyLhtWfw/ZOVLKe67j4EUej8kXC3fuLDfvlb7q
 GFrzg++kCHAVo0E7X+dO83SJKGITwmZB87URaQzUTQ9VZDMdJQZepDWJ43uoiy+kUpF+29
 XhBfavLIAoVIQq9MbE5XBYSEMfdnNFI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-VjdO5ZAFMKq7bGz0EIF-cA-1; Tue,
 21 Oct 2025 05:49:47 -0400
X-MC-Unique: VjdO5ZAFMKq7bGz0EIF-cA-1
X-Mimecast-MFC-AGG-ID: VjdO5ZAFMKq7bGz0EIF-cA_1761040186
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 795031800654; Tue, 21 Oct 2025 09:49:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B00F1955F22; Tue, 21 Oct 2025 09:49:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BFA021E6A27; Tue, 21 Oct 2025 11:49:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/1] Error reporting patches for 2025-10-21
Date: Tue, 21 Oct 2025 11:49:42 +0200
Message-ID: <20251021094943.3585876-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 3a2d5612a7422732b648b46d4b934e2e54622fd6:

  .gitlab-ci.d/buildtest.yml: Install 'file' for the Coverity job (2025-10-19 11:49:36 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-10-21

for you to fetch changes up to 1a5319e26797404a5f7738111ba788b593483af6:

  ui/pixman: Fix crash in qemu_pixman_shareable_free() (2025-10-21 09:54:48 +0200)

----------------------------------------------------------------
Error reporting patches for 2025-10-21

----------------------------------------------------------------
Markus Armbruster (1):
      ui/pixman: Fix crash in qemu_pixman_shareable_free()

 ui/qemu-pixman.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.49.0


