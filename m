Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DD8C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbbr-0001nc-N4; Fri, 21 Mar 2025 08:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvbbp-0001lm-My
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvbbn-0008LX-DA
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742560576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YUiRazojRK/P6MIBeokXrgi2DMcuzUnLip4zXvzo0lg=;
 b=WyG6/EDJWCfXedxn7Vxyzrfz0maq8rZpKIqeOgEYT2Yuo/qmA25Oc++cFmkohbzWydqf+7
 5swWvwAYnH9++pcHmaAbNePqOlqoPVT4TyyZEoCu9xGISVoFcrZsG5YJ8G5bUSIW8qwigI
 m0H0q0wMjbkWzY3VmKAWDUqVIUOAtvU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-xo0Tq3TIMn29WNHdMl0r3A-1; Fri,
 21 Mar 2025 08:36:12 -0400
X-MC-Unique: xo0Tq3TIMn29WNHdMl0r3A-1
X-Mimecast-MFC-AGG-ID: xo0Tq3TIMn29WNHdMl0r3A_1742560570
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46A02196B344; Fri, 21 Mar 2025 12:36:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 676BD1955BFE; Fri, 21 Mar 2025 12:36:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D81351800386; Fri, 21 Mar 2025 13:36:04 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/6] Uefi 20250321 patches
Date: Fri, 21 Mar 2025 13:35:58 +0100
Message-ID: <20250321123604.2126923-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 1dae461a913f9da88df05de6e2020d3134356f2e:

  Update version for v10.0.0-rc0 release (2025-03-18 10:18:14 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/uefi-20250321-pull-request

for you to fetch changes up to 5e5d18d2ccd674778715f828df80fdddac73bdea:

  docs/firmware: add feature flag for host uefi variable store (2025-03-21 12:01:12 +0100)

----------------------------------------------------------------
hw/uefi-vars: bug fixes
hw/uefi-vars: support riscv and loongarch
docs: update firmware.json spec

----------------------------------------------------------------

Gerd Hoffmann (6):
  hw/uefi: flush variable store to disk in post load
  hw/uefi: fix error handling in uefi_vars_json_save
  hw/uefi: fix error handling in uefi_vars_json_load
  hw/uefi-vars-sysbus: allow for riscv virt
  hw/uefi-vars-sysbus: allow for loongarch virt
  docs/firmware: add feature flag for host uefi variable store

 hw/loongarch/virt.c        |  2 ++
 hw/riscv/virt.c            |  2 ++
 hw/uefi/var-service-core.c |  1 +
 hw/uefi/var-service-json.c | 24 +++++++++++++++++++-----
 docs/interop/firmware.json | 12 +++++++++++-
 hw/uefi/Kconfig            |  2 +-
 6 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.49.0


