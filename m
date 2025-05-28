Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C1BC54F30
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 03:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK7WX-0004aB-5y; Tue, 27 May 2025 23:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1uK7WU-0004ZT-2A
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:32:10 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1uK7WR-0005Zr-Da
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:32:09 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso317852a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1748403121; x=1749007921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nOPBSNrJ4C8XDFaisEKYLLN2uWBWtV3MVkynCIe5cxA=;
 b=VRKfqz2/ePmaX6R7P4AgmflFB1FLzDe0xmsBjMB/RiBxghAjKQi+k8KYC90NGTLT6+
 qxT/PrOwTAale0eiWOM/0N4ds1FOlaHrNWYNULltoxIYhkHEHJ2peOYkJX1ZUkahKeEZ
 wA22oQkktkhd2DaF+xLUi6zCuUGr0yinLHADyFdqxx9aUjjJRET0YclfUhFsQHd76pKt
 XkzDn7HaD+tpKqgc0u1pvbFSBRtjSGnzG9m5CnK18vF/56YIxAWWPFO1q21X+0yhAGbF
 uM+pKF6ZisQS0ZlTrb2tawceJ22AniHWhuei7dYcn8LurdzjW+I/DyOBIkJlQmPInZgS
 NtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748403121; x=1749007921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOPBSNrJ4C8XDFaisEKYLLN2uWBWtV3MVkynCIe5cxA=;
 b=ZQ+gY1e9oTcX4HzkPhId4Udzk2HkT70vUNDh/APmKCXwqslwxC303cxhbKkqZ9jR+0
 V+yYeiyNeaAjLxtbfK8c+sDPY5oWzUgeWtH+Vpi+rhgSWXtrYUE9npb2K+lX0WaJvaCQ
 4MAmzdHnHV6zt9403Nco7Rw0zNnHM3DM5qBOQeMJAPF9gaeJ7Vb+CloTpsM0HXVZ9lGp
 Hp6R8hYkVaH/1umzLuF/dTlz8gvcN/f8xVQuBsTbJK/OsjrHZymPAgt1gHRaLNdfYmGQ
 a79ER0GhVk7ZUTDqfOoTz9AiwvsUSx87kp7ckQcQfpetWRGqNNZ+a95HPI7MsokfuKmU
 gpWA==
X-Gm-Message-State: AOJu0YxKTgSqX2z0fTMcW4373lD9esSnGcqYRZEeqDXMtXbUc0FJQFLH
 WDeihzguP9t64IqR4ED4OKcCP61zEUmvXL0KaSjY3MLFhqEzswLg59uuEBsXus1EjyOvH5WREKG
 q9ACc
X-Gm-Gg: ASbGncuh1ZO9jWDjrC8vg+7bTjbQpgjsXc3WEXxAbrlCVkJJ2cXoAuDmCmJa9qCrTWi
 4DRymQXdgwwb8THlNTJf1vD/iamsvEeMovzyuEI0jemTu71ciSZCEQwDiExCPBQf9HRkiG8wVoJ
 j5oNdQRue+Nz8fsnOK+1lXuGwsLt4VV+hVgJAVgbSPpBD6bTTWAkyM2okdaKiEzzx+uxRu8nDY2
 1qETVPP1+j2w64qJI9ZDxNbQDgttQPDkkWaZLaqYhrlq9R4TQxKWHGHXVlMFJ1SFxB5BnprqItP
 yfdgTI4audKvk1JRzz/BZj0hmJxc10TpmDAJV1jh2qPLYTgk2ycPh3RH1MxTdlwndBytn7f84ds
 =
X-Google-Smtp-Source: AGHT+IHZ+xgzbJkF0mJL3aGfttvdiBHTaaygPaYVCAHuwrwHOKuHpYNGpMUpsArqk7w1Ph0qHhJTsA==
X-Received: by 2002:a17:902:d4d2:b0:234:9fee:af95 with SMTP id
 d9443c01a7336-234b73239f0mr55756785ad.0.1748403121209; 
 Tue, 27 May 2025 20:32:01 -0700 (PDT)
Received: from always-zbook.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-234d2fd226fsm2022295ad.36.2025.05.27.20.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 20:32:00 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: qemu-devel@nongnu.org
Cc: fam.zheng@bytedance.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] MAINTAINERS: update email of zhenwei pi
Date: Wed, 28 May 2025 11:31:56 +0800
Message-ID: <20250528033156.1188531-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I will leave ByteDance in the next days. Update email to stay reachable.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7060cf49b9..2da7cf76b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3278,7 +3278,7 @@ T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
-M: zhenwei pi <pizhenwei@bytedance.com>
+M: zhenwei pi <zhenwei.pi@linux.dev>
 S: Maintained
 F: include/system/cryptodev*.h
 F: backends/cryptodev*.c
-- 
2.43.0


