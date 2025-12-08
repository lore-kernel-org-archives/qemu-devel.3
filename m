Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4D4D3B7F3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 14:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSc6a-0003ah-TR; Mon, 08 Dec 2025 09:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weizhi.li@linux.spacemit.com>)
 id 1vSZnh-0002gH-2v; Mon, 08 Dec 2025 06:53:10 -0500
Received: from smtpbgsg1.qq.com ([54.254.200.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weizhi.li@linux.spacemit.com>)
 id 1vSZnb-0007Yo-6y; Mon, 08 Dec 2025 06:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1765194755;
 bh=BhI3RNQ2Y+SzZZkgI/7u4UYKsOvFlB0vJxcJn+/o0yo=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=msYthhvXWmZLx4BwBgynH7JSn+xvygX8VPstg3stZLL3Az6ftKhfOOYaqg5YG12OV
 jZtjfHLVXWgQBtfRhBxs8oJm7WaKhwqpe+YhHLgS7cJDZJAjEZ0WhfetlNdc/fWmJj
 tT2BwTlK/9ZTOha7xkiY3UJbJYIVN18bt8H8PmlE=
X-QQ-mid: zesmtpsz1t1765194747t42c78f87
X-QQ-Originating-IP: Apr2DuTZvpBvLqbQ4qzv6njTQgMdFbrQ0CCMyilzSGg=
Received: from host1.dc.com ( [120.237.158.181])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 08 Dec 2025 19:52:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6037169953519126958
From: "weizhi.li" <weizhi.li@linux.spacemit.com>
To: npiggin@gmail.com
Cc: alistair.francis@wdc.com, dbarboza@ventanamicro.com, laurent@vivier.eu,
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 heinrich.schuchardt@canonical.com, Weizhi Li <weizhi.li@spacemit.com>
Subject: Re: [PATCH v2 0/4] linux-user/riscv: add vector state to signal
 context
Date: Mon,  8 Dec 2025 19:50:16 +0800
Message-Id: <20251208115014.2933813-1-weizhi.li@linux.spacemit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903081417.338515-1-npiggin@gmail.com>
References: <20250903081417.338515-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N0zPMTspoMafUShgy4yeZZAlnVCqZVi7VNvhvyHy5X1N9C5xGaCgd0Zi
 t8iVbRxt+dKWa1ap+NDvSXYqHIfh/yGod6r1Bv9oZ8sIoefAfmHjipVlmd7xCSc1LWyVmMs
 puZuoqGy8BSR/f8S0zfqGX24ycmb9/8jqc4MQWD0Jej11te2G1dK8I3g7l89hwil+mZ5aaq
 8F3iFQ7Jb0Q0MyzEByZDhgRKRMYAZcQAYphEGh/dPTg/LNgiJ9veHXkzKU8kxwwdkzKNQyE
 NLUJRrI11LG9WaZ8vNOwBsyXeMPfJpsQN71OW/xzUfbR31UjSvBk2+aqQBzv89T7dFjtzAM
 YXIoGadhx2aWCuvddlajEWiMKA91I5z7skvWfO6FIwppMFFy0A8FtkYm21HFEenlpt4CSab
 eRTaHYsQGeCDaHP+GEKbDqeomYK17aQ47FcO2SZDpgFu0WnsZvnCaKxl2brnFxwKGaNelrE
 0I3Zy9aWOeFcI8b5T1u5sl9q3K1Gegc6GJiz7WqwdkfvpZ9R/AFWfdP1fcB4MIPfsQzCHl8
 sJkjxSXuciYicFS9ri/wt06/tAHQYjYLx53hWAE7buoGm5fscRzMJLxJ9c1DV/2oFdRoqXA
 Bct9rH/3BFlpY6FZodslLhYeQALveXU9jEKCQAfZONDZdE0ttxJX4IrlmEAIT4d5GlA+WWI
 XmObjJWrXDT3f6dJkODogXVbZE8618nJDj40QUETLZMehBjVq+MZZqqXLYUSfbgzbvtj7oR
 pO+f/3d2nR7U8ZdhJE2crrLHIzqHl5CgVZ77yb617sKMVArW9It5OlAHnYrKQVQrUe5Rnqk
 KtKsUxOYD847oX3xggHhfFNiuXOIan4lPZGZD2skfILXYrnB0wn0D3uLWuY7gHrX9uteOni
 4nshI5X0p4zP6eZOMz1hb4m2R7r2Efk7dV0+4WYZ6d0IXgYR/NEgIqq6YhIVA5GxYW+KzQX
 FxJgMu8rzpFKqLAmFNAVKtQkefmmTPggA1u0hkvFvcy6Pbw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
Received-SPF: none client-ip=54.254.200.92;
 envelope-from=weizhi.li@linux.spacemit.com; helo=smtpbgsg1.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Dec 2025 09:20:46 -0500
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

This patch series resolves the issue I reported at:

https://gitlab.com/qemu-project/qemu/-/issues/3224
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2133188

Programs in foreign architecture RISC-V containers using RVA23 crash due
to not restoring the vector state after handling signals.

It would be great if this series could be reviewed soon.

Tested-by: Weizhi Li <weizhi.li@spacemit.com>


