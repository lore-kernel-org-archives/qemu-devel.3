Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1E606A881
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=gWYWKdbo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjD-0001OP-6N; Fri, 13 Nov 2026 08:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRng1-0001hX-Fb; Fri, 13 Nov 2026 04:34:33 -0500
Received: from fraori-sdnproxy-3.icoremail.net ([132.226.202.154])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnfy-00033u-0N; Fri, 13 Nov 2026 04:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=bn3++
 Q81ry49X+H130ch/bUUKsf9OKCKTGj4V+H79G0=; b=gWYWKdboUNi0gfTTCJn2z
 4Hus8LxVnCQAYlWTcgsNsJuwrdBvRjv0QosyTQTJdvwgqUOG7DeC1EZjcm+yxBc0
 Av2INztGBm3yBAe7598ykky3Y5WRI/m2HrPW6pX3ZJZobjRPU8b8Em2Rd6Q9vnU5
 29rqf96YG7TVwaD6QwrVO4=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQCnHD2P2fZq1wBCAg--.19135S2;
 Fri, 13 Nov 2026 17:34:11 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, bin.meng@processmission.com,
 tangtao1634@phytium.com.cn
Subject: [PATCH 0/4] hw/block/m25p80: Fix erase and page program behavior
Date: Fri, 13 Nov 2026 17:33:55 +0800
Message-ID: <cover.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQCnHD2P2fZq1wBCAg--.19135S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1xXFWfKw18XF48ZF4UCFg_yoWDtFb_ur
 Wj9FWDGr4vva1rCayayr9xtFW7KFW0gr15JF1Fqr9rWr13tFsagF4kJr1UXw1kXFW0yFn3
 Wr1qvr1SyryxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbDxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
 rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
 v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
 CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeNVyUUUU
 U
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=132.226.202.154;
 envelope-from=w-yf22@mails.tsinghua.edu.cn;
 helo=fraori-sdnproxy-3.icoremail.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:48 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series fixes erase alignment, write-enable latch handling, block
protection on erase, and page-program address wrapping in the M25P80
flash model.

Patch 1 aligns erase addresses to the containing erase unit and checks
the device bounds. Patch 2 clears the write-enable latch after WRSR2.
Patch 3 checks block protection before erase operations and updates the
ASPEED SMC tests to clear protection before their setup erases.
Patch 4 wraps page-program addresses within the page and corrects the
page sizes of affected devices.

Comments and suggestions are welcome.

Thanks,
Yifan

Chao Liu (4):
  hw/block/m25p80: fix erase past the end of the flash device
  hw/block/m25p80: fix write enable latch after WRSR2
  hw/block/m25p80: fix block protection on erase
  hw/block/m25p80: fix page program address wrap

 hw/block/m25p80.c              | 118 +++++++++++++++++++++++++--------
 tests/qtest/aspeed-smc-utils.c |  19 ++++++
 2 files changed, 109 insertions(+), 28 deletions(-)


base-commit: 49559567804523cb28cad002aa8e97f444e23ad7
-- 
2.53.0


