Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFECAC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc0yu-00086I-3j; Mon, 19 Feb 2024 05:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rc0yj-00085x-I5
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:34:29 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rc0yf-0006zc-Jg
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:34:29 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx2uipLtNlWlIOAA--.18700S3;
 Mon, 19 Feb 2024 18:34:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzxOoLtNlVPE7AA--.33368S2; 
 Mon, 19 Feb 2024 18:34:16 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Andrea Bolognani <abologna@redhat.com>, maobibo@loongson.cn,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, zhaotianrui@loongson.cn
Subject: [PATCH V2 0/1] Change the UEFI loading mode to loongarch
Date: Mon, 19 Feb 2024 18:34:13 +0800
Message-Id: <cover.1708336919.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzxOoLtNlVPE7AA--.33368S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The UEFI loading mode in loongarch is very different
from that in other architectures:loongarch's UEFI code
is in rom, while other architectures' UEFI code is in flash.

loongarch UEFI can be loaded as follows:
-machine virt,pflash=pflash0-format
-bios ./QEMU_EFI.fd

Other architectures load UEFI using the following methods:
-machine virt,pflash0=pflash0-format,pflash1=pflash1-format

loongarch's UEFI loading method makes qemu and libvirt incompatible
when using NVRAM, and the cost of loongarch's current loading method
far outweighs the benefits, so we decided to use the same UEFI loading
scheme as other architectures.

V2:
Change the size of flash0 from 4M to 16M
Add test-by

Cc: Andrea Bolognani <abologna@redhat.com>
Cc: maobibo@loongson.cn
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>
Cc: zhaotianrui@loongson.cn

Xianglai Li (1):
  loongarch: Change the UEFI loading mode to loongarch

 hw/loongarch/acpi-build.c   |  29 +++++++++--
 hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
 include/hw/loongarch/virt.h |  10 ++--
 3 files changed, 107 insertions(+), 33 deletions(-)

-- 
2.39.1


