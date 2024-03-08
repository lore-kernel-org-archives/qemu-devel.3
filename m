Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E101C54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riawV-0007fC-N7; Fri, 08 Mar 2024 09:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riawR-0007eO-MS
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riawN-0000be-3c
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709907072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7xWQJb046Cd1cbaMyzGU4tbZb3+rUnbGtrw6OhayPjI=;
 b=G946+k3d45AOgZMv4inxCoiiIgmxQ2SRtyz/Esh+7eZHPDqChklkfT4R7PBs4frbQrjorM
 fpeTvkpjJHCDz3GSox/jqtULbFJED0sYRCRG263GFkxowPgo8S0epf4py9TTAmw/EvFonZ
 yN6heHqvib0gSEXscXv/28uv39wlyHk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-unHregWpMBaKgZflfai7RA-1; Fri,
 08 Mar 2024 09:11:10 -0500
X-MC-Unique: unHregWpMBaKgZflfai7RA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FFA73801F53;
 Fri,  8 Mar 2024 14:10:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6090492BCB;
 Fri,  8 Mar 2024 14:10:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 0/3] target/arm: Allow compilation without CONFIG_ARM_V7M
Date: Fri,  8 Mar 2024 15:10:48 +0100
Message-ID: <20240308141051.536599-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We've got a switch to disable v7m code since a long time - but it
currently cannot be disabled since linking then fails due to missing
functions. But thanks to the clean-ups that have been done during the
past years, it's not that difficult anymore to finally make it possible
to disable CONFIG_ARM_V7M: We just have to move some v7m-related code
out of cpu32.c to a separate file (that we only compile if the switch
CONFIG_ARM_V7M is enabled) and make sure to use the stub functions in
m_helper.c if it is disabled. Then we can finally remove the hard-coded
"select ARM_V7M" from the Kconfig file.

v3:
- Rebase to current master branch
- Make sure that the stubs use g_assert_not_reached() in the second patch

v2:
- Updated a comment
- Avoid #ifdef in cpu-v7m.c, handle it via meson.build instead

Thomas Huth (3):
  target/arm: Move v7m-related code from cpu32.c into a separate file
  target/arm/tcg/m_helper.c: Include the full helpers only with
    CONFIG_ARM_V7M
  target/arm/Kconfig: Stop requiring CONFIG_ARM_V7M

 target/arm/tcg/cpu-v7m.c   | 290 +++++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu32.c     | 261 ---------------------------------
 target/arm/tcg/m_helper.c  |  93 ++++++++----
 target/arm/Kconfig         |   4 -
 target/arm/meson.build     |   3 +
 target/arm/tcg/meson.build |   3 +
 6 files changed, 357 insertions(+), 297 deletions(-)
 create mode 100644 target/arm/tcg/cpu-v7m.c

-- 
2.44.0


