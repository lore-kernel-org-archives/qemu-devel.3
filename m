Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C149ACA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEak-0001Ph-7A; Mon, 12 Oct 2026 07:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xGEOG-0007Hr-NG
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:40:25 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xGEOF-0007zW-29
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:40:24 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab8309dcbaso1225478a91.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791805220; x=1792410020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CRtsmf4dp1yLdO1IThIeVYTpKJ/JnbXZagFUSD8OlUk=;
 b=Lb5Q9kEmNtspUD2PO0cbU+cvTHjUu1s1aJ0l72zwSC4u1KeOps998Wi5ufGV1fPp0s
 G0quPXsDgs1wZAjpNjbDxyGbZlNsZvo0JQ5FnuKBDcAehTDLVQJsXRNPQZrJWoQWBm/4
 7VFXh+Fns2TNW+86tynbyPceikMzaEP1GYMlAFE7MPn0S/w6jkNIdc66AiozWCalBzIc
 hEeS4y7/tCHK38W8oDrY62BwTPK4k9yVuoK++Ow+0SAtDaZUK5sTlDvcFALMxJwVlghZ
 uz0AN/5nX0UY/pJLptJYOz1zS1JmqohWlGMz6UkwmEEXbZqrESb45SN27GL/uIlDq9ts
 bk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791805220; x=1792410020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CRtsmf4dp1yLdO1IThIeVYTpKJ/JnbXZagFUSD8OlUk=;
 b=qBvfnP+44+tScRau/RYW9+tZK9L1iMhL+tBQRpokV6vxP4CaBLIPOesPArZJPRw+yd
 kD2YCwDVG8yJoS0en6JAHHwOsRkU6kHbLNMGmjwIKLNpOJNS/xvx8cdrN4pdqpbb0b/9
 D+zhsCeeTsqqBkYNyzTqUo3CXamO+1R9SrtkDg+6F5KyBVs49fINdgSpZ2f911d3hCmD
 HHlJIR4YqnnU/m7TKBsmvnttCeJENIkN3achehEhkng3Jad9Rl04DIvUOQmLoXRZb5GI
 sNjVXcVmmzHblljtvLTcVUGjX1MgsDeoFVS8Wj2VNYGHsgAvwasMIXqAS48KQmRbeyHW
 tu0w==
X-Gm-Message-State: AFq9FYIELEjzwxughXTFVFZpKVZvbvhtHSqjTe1zEw91c9ng8BWHsYVX
 MDhFYkYtoJEHjDvKXXo1fxG/TrIjEBe9Uq6fwDAdbaFnCxyj2apL7+HsYyhz2KAE/4TPbg==
X-Gm-Gg: AYBFou3RVjQa73got3Hhs1OfIbR3Kw+EzTYLFZsFOk+xF12Y9hQybmKCiiF0pZ22zlM
 KfLUAJZVZJLBR6OxBk93YcnTxUHGkGtIEzr9sTBBgnZvrBMbDtPh5qsiQtzZeQkehcNtWG8WmpV
 Uq2OgoZZ5nUCAY/Gcbc+R7V/P3F26jU5v2x9nQ+FjtPWOdQKqqzp1d7zXP6LeONrjiZb1KjmtPH
 cZ6rS6VUlO6H3npAWZ4e57uiRiHN/5tana8j3t60SoVHotj7qma4xRPT7rNtm6oYgq4Qc4M8kKn
 xa3Kv8sODw3GTpvYBnBSMROVHto592RlafLKspGFK9QuhBbGpt61iw31hgHht4o9wBPMDUq93bP
 O8cBBk4dNc1LiRdoj/V4Or3UIdo2Z9T7CUkwPB1enSVEtl+9apJf6KzqE/lI7nlmwrIqaUvaPHH
 5ocHnPfg7km4mzHoQY5d8NZiLQK+QzxyaLXhuqJkN0Tw0vL1YYdmv92ryQ14YGtb7ls7UqQhk+C
 A==
X-Received: by 2002:a17:90b:1d4f:b0:3a2:b4a6:9299 with SMTP id
 98e67ed59e1d1-3ab36d6f783mr6333534a91.26.1791805220331; 
 Mon, 12 Oct 2026 04:40:20 -0700 (PDT)
Received: from archlinux ([2409:8949:4c50:eb:9b22:b05b:94dc:7aa0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab421566acsm8614008a91.3.2026.10.12.04.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:40:17 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH 0/3] hw/loongarch/virt: Fix clock property name typo and order
Date: Mon, 12 Oct 2026 19:39:55 +0800
Message-ID: <cover.1791803914.git.waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=waysorrypub@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:53:15 -0400
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

The property was incorrectly named "clock-frenquency" and is now corrected to "clock-frequency". The order between the property name and its frequency value has also been adjusted for consistency.

pillow (3):
  bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
  hw/loongarch/virt: Fix clock property name typo and order
  tests/data/acpi/loongarch64: Update expected DSDT.*

 hw/loongarch/virt-acpi-build.c                |   2 +-
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4599 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5820 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4605 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4901 bytes
 5 files changed, 1 insertion(+), 1 deletion(-)


base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
-- 
2.56.0


