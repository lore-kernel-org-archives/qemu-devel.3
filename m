Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7489C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2Nv-0007aK-S9; Tue, 12 Mar 2024 09:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2NZ-0007Dl-TH
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2NX-0003e1-GM
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710250874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E+s935q+U364XaKYTAXYyEiDJmVpO/CnTMyXiiR1ojg=;
 b=dTin2IqsW/oWNfYirNamBRIEI3KieOGbIMIuv7toT5wE5g3thqesFKCdNNP+9QwHJuYW6y
 6D0e/iD4p0KoSrDTwBFOUMgITOntg2MK+PGnkIJEqyRtxkHy8iivBgxPGCCij/+oQi6bWD
 DDYRyccqPKEG3z9TDjx8MFuER96Xy3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-RZqjK4eGPIuzYtPw7Ee8Pw-1; Tue, 12 Mar 2024 09:41:10 -0400
X-MC-Unique: RZqjK4eGPIuzYtPw7Ee8Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F4C9185A783;
 Tue, 12 Mar 2024 13:41:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D355200E1B2;
 Tue, 12 Mar 2024 13:41:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAF1C21E6A24; Tue, 12 Mar 2024 14:41:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/4] Error reporting patches for 2024-03-12
Date: Tue, 12 Mar 2024 14:41:04 +0100
Message-ID: <20240312134108.3030801-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 05ec974671200814fa5c1d5db710e0e4b88a40af:

  Merge tag 'm68k-for-9.0-pull-request' of https://github.com/vivier/qemu-m68k into staging (2024-03-11 18:42:53 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2024-03-12

for you to fetch changes up to 28054406715a90e3fab96d4a29190e8857e57fbc:

  target/loongarch: Fix query-cpu-model-expansion to reject props (2024-03-12 14:03:37 +0100)

----------------------------------------------------------------
Error reporting patches for 2024-03-12

----------------------------------------------------------------
Markus Armbruster (4):
      target: Simplify type checks for CpuModelInfo member @props
      target/i386: Fix query-cpu-model-expansion to reject props
      target: Improve error reporting for CpuModelInfo member @props
      target/loongarch: Fix query-cpu-model-expansion to reject props

 target/arm/arm-qmp-cmds.c             | 16 ++++------------
 target/i386/cpu-sysemu.c              | 34 +++++++++++++++++++++++++---------
 target/loongarch/loongarch-qmp-cmds.c | 18 +++++++++++++++++-
 target/riscv/riscv-qmp-cmds.c         | 20 ++++++--------------
 target/s390x/cpu_models_sysemu.c      | 31 +++++++++++++------------------
 tests/qtest/arm-cpu-features.c        | 13 +++++++------
 6 files changed, 72 insertions(+), 60 deletions(-)

-- 
2.44.0


