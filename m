Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A773C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 08:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTHl6-0008Mi-Oo; Fri, 26 Jan 2024 03:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTHl0-0008E7-J6
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 03:40:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTHkw-0002RS-0f
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 03:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706258408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LgFnQEsxtyzbsFHgckgmEGg9L/IocL3BBH29Awp0ZOI=;
 b=IlD32lG4hdHcBBbgj3Ev4FP+wVp2tJrRcMKOF4Jgg5gyAbjn0oTAOBE7jNMTETTgLU+x+V
 zqXPGJY+VOLSMrDS00lMkvFpKTEq9R7HHTuCJIZb/KPn0GON9EcEHoFEbWcUjZtQ7E2wsD
 3wuXIZnhLWffl9fGRNAFhk9lJ166gkI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-oeRLs0giNSq4syuIqZgtsQ-1; Fri,
 26 Jan 2024 03:40:04 -0500
X-MC-Unique: oeRLs0giNSq4syuIqZgtsQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 047073C000AB;
 Fri, 26 Jan 2024 08:40:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF78B492BFA;
 Fri, 26 Jan 2024 08:40:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/arm: Allow compilation without CONFIG_ARM_V7M
Date: Fri, 26 Jan 2024 09:39:58 +0100
Message-ID: <20240126084001.879548-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Thomas Huth (3):
  target/arm: Move v7m-related code from cpu32.c into a separate file
  target/arm/tcg/m_helper.c: Include the full helpers only with
    CONFIG_ARM_V7M
  target/arm/Kconfig: Stop requiring CONFIG_ARM_V7M

 target/arm/tcg/cpu-v7m.c   | 292 +++++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu32.c     | 261 ---------------------------------
 target/arm/tcg/m_helper.c  |   3 +-
 target/arm/Kconfig         |   4 -
 target/arm/tcg/meson.build |   4 +
 5 files changed, 298 insertions(+), 266 deletions(-)
 create mode 100644 target/arm/tcg/cpu-v7m.c

-- 
2.43.0


