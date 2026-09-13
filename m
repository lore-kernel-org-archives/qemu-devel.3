Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C43AC88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 07:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5eFP-0000P7-OA; Sun, 13 Sep 2026 03:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1x5eFN-0000Ox-VE
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 03:03:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1x5eFM-0006wQ-9y
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 03:03:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49e6deb520eso12276355e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789283007; x=1789887807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H0yMxZFHf+VRPFZLycJMxxNKEcHFQB+B6CO6Ssijaew=;
 b=aDx3y5zZn3cTFs9nfu5iVAVSSXaJRKJ5rA/xxkJUrPeoQwT4Mlz7GHtIRSXd2M0MWi
 lWqj81WN1bGLoHXoUV+gdaDH5dYIXxoYmcVulyVE6DAfWlFQ2oYLQxdu+KYhusJMbJdB
 TB17DHQhhh6MRQmD65BfJUlNJtD4Fd66bCnb88fY7Xwi10tuWIwu3BgFjD9oVTxTcvI2
 8fUEgPq7c0OuWS+0d9gb/1I+msrMDHZzxqzIdlylhVUyAjuxp1dd7RoUbINyWS6TsO2k
 A12QbxnNsTOad2mb1xbd/iwDsqIXzo29S7O5fXoO6Egahb5HrZ9O5k4qC9SYvZhYr5pG
 8+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789283007; x=1789887807;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H0yMxZFHf+VRPFZLycJMxxNKEcHFQB+B6CO6Ssijaew=;
 b=OmZ7/ADmigBf6bAsZcuMViBhPg/iMDkCqvWyC1F2aD5PerTCmiMemeDMVCn1L8i796
 SyjlouoczYEtS1MXaZqDlGi7DC0vSiGMoBhqnhsNKRuSLhEIpHEHKU3tUUWOcnyrqkro
 LJiVkGHgPoRYEsRlKU5UZjmP7EVS1nEr1uLvXCs0vi/n9b41CPqiri7NO4w9FumuftYX
 7/a7J6eUTQbRGLHam09IpcigiuO5zvnQ/Mgd/HLnwfkHem/2q44NgDLNmEX1z7daFSZ6
 4xXLXTOOj0IebWv6BCgOucEq5vcQQI69Hrpump87irnSH+eePoe9unqbMwWP0+Riurz1
 dXCw==
X-Gm-Message-State: AFuF++nnW6hnm+bVM5AsHHnsdSLoeWpLqE/BiCtzjAwSUwGX0zsmAgTe
 DYZhgGnebWYMlMdRRV9F7TTNlv+Uo80Qi6lBcNZqDRR9nvOIphWuDYz2tEMCGQ==
X-Gm-Gg: AYBFou1S7eC2QPkF+0nwQGdrTuFcUc7qXJlih9YZWIZsQAAWHjI3cEqcC7+NALxDSLq
 aBbT9A+lh591YioH9p8VDY8KVPQqR5aqXZY/VJLhWSLiGxg+i2dAqx9noTWZNUkx12LVlQMvOy9
 /IrIZcmVKzICk2dono054BvfA8LbzwUIIEG73ZdpDBFpbl3WstNQaaBDSNFoTpjgRB2lh5uIBzV
 e9QQxJPNG/eAjtyIkkPzZwofna6yErDdPeNZsAYL0Ck/9UFB1rjPjGxHEhOEM1IrKHr3ukZh5Tj
 RG+akG5pl5U/mZTZKsFuoTsU00AuRJpJ4TP2RBvIANX7fxARlg9iz88hITXGWtyzFLTUgwL/iJ9
 tKUEHEUw23fQaxrmTLgSm5sPOVa9m56pL24VMFlswYXU5IRzSckBETOiyCykDH235zHA9DjmQdW
 Euf8Pbed8ffNpjNwp9oBnrOvR4HsbwLyCXOr/0JMEYIbt+uDFmiZPjaW02eCZtBJibpYOw9dTcI
 k0eAJTbvvCXYl/oSPU3ZF98JqulFtQYA4JPAWPMllWKwViZTkhpzw==
X-Received: by 2002:a05:600c:6085:b0:49e:6cc1:14d9 with SMTP id
 5b1f17b1804b1-49e6cc11680mr57470885e9.32.1789283006372; 
 Sun, 13 Sep 2026 00:03:26 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e64221639sm79202045e9.4.2026.09.13.00.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:03:25 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stafford Horne <shorne@gmail.com>
Subject: [PULL 0/1] OpenRISC Updates 2026-09-13
Date: Sun, 13 Sep 2026 08:03:02 +0100
Message-ID: <20260913070303.1010504-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Please consider for pull,

The following changes since commit d43c2d5f89db70359a7b3a7e2ad7098fcc0165ef:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-09-11 12:04:42 -1000)

are available in the Git repository at:

  https://github.com/stffrdhrn/qemu.git tags/or1k-updates-20260913

for you to fetch changes up to cfaf6a1edd8803f0334007dbbff9ca5eb293e98b:

  target/or1k: Implement l.extws and l.extwz (2026-09-12 08:31:14 +0100)

----------------------------------------------------------------
OpenRISC Updates 2026-09-13

One patch:
 - Missing instruction definitions for word sign extension.

----------------------------------------------------------------
Ali Ahmet Memiş (1):
      target/or1k: Implement l.extws and l.extwz

 target/or1k/disas.c      |  2 ++
 target/or1k/insns.decode |  2 ++
 target/or1k/translate.c  | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

Ali Ahmet Memiş (1):
  target/or1k: Implement l.extws and l.extwz

 target/or1k/disas.c      |  2 ++
 target/or1k/insns.decode |  2 ++
 target/or1k/translate.c  | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

-- 
2.53.0


