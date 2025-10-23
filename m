Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A435FCCF9E2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwje-0004os-P5; Thu, 23 Oct 2025 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjc-0004nQ-L6
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjb-0005aC-1V
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso906193f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231369; x=1761836169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zur/1Syyp7QKq3yESbOczhxVhBdbhamiIq+pcBe1C9o=;
 b=nlOX9Rjm+Q2FcqlJ8gFHkrhplff6KeeOk9TZjTCQXpd7kHorITHzEmQIr/AlUxFLhi
 /H2LamLMzGLqZjlJTYK5A5gjfPf5jRNTpsGWMiCXbhq4d+FOwNmKVIydc/x5Fe50RFWs
 dfl9le0D6MdsFBmjhc+3Lg6LgxLQjqq1kr9O7capxiE+7SD3sJSpj89NUdx0kCi66UXi
 DvNnWOwX0XgGOhCMA8ElApoDmmpVo42bD6dBU0BxekkPQbzIHgoBN1Dhhnb8tcKwI5W9
 H3RAAYaOriq3teAKABCXKbkhU3LVBHjgyhynHjOZgzdIZlK+U7t/wyWaTBeCtU3meT+X
 Ev9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231369; x=1761836169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zur/1Syyp7QKq3yESbOczhxVhBdbhamiIq+pcBe1C9o=;
 b=wsKb6/zJP+Gl7uCaXmAi2lZC9IfttX04L3dfn/xTzbDLk6LY6125DuUi4l7wvP7SIQ
 TB3R+FkI6rcJbgrn2Mgfp5Pyb9sPTKfGM+Ihr2eBruz0bYcyyzOmvRpkaMh3+xNHJsvq
 K8z2crIAiOb7t339roNCr4rAzhkQ6OktNAUrMpD12tKOVjY5pUSe1XduyHPwd4vLbwD2
 rqw2MCQKZ5sqcfGB/rnctfg7aNzzoKvDC4PPACTvKASLsWRySIRqquEynSh/wECN76FJ
 UvZdWH5F3HyjL3qaaSc4F6txmIKeCY+C89Zh3JKuqL47LBeUb24GAxFUt0efu4E31Ajy
 xK0A==
X-Gm-Message-State: AOJu0YxjSdj8B7lMFVt7tA9Vh9UaGREcwEyC+YQWZMSdf0wrC7otVcK6
 Lp9lfLXzt+lrcqOj16PXdN/eAqAtXodhaEJ91fbjLbqiC7oguhslwvqGjdK7MBrBGc7olskXUlP
 cAa4u
X-Gm-Gg: ASbGncv1d5guoMQ9E7HA+FNDy8v+i4r6eOjbwx4GdR2NpXVqYcgj2ZGXZ3Iwi9L+yJN
 a2BA8uMM/ldFTs0hw7lMLDB1vbINh0douqy6YfoXMUzXWbqMzVoORhKZNaG2UFvWu6V2QKCji2U
 B6Qae06vhoeS/9VtcW16fqHMmfsVB23XoEBLdh571K/LnmUtKXEIkBFKGj3yV+t/ebFXN2BwaTn
 0xiqeVJeqWp7Ib+bQ7x5X7MOvHSx9NCUFsrzyy93lZSzj5HsT5E7/FivT+q+7wUa3arfBNycUfb
 UyQzyZFi9sMta5m0GRIVlvr2arACAzfVjMg7Ntqb4p1LITTDQtqWieX5LNcqFQxepW3MMUqWSl+
 LHP7CVx0e4229QP9P6k+IMTRP7U0lrbzj/uHG+j8LfBrehNyMShLOTyba3GMGU2yQwCZyzro9ii
 vdvvAedA==
X-Google-Smtp-Source: AGHT+IE/zm8IKerLXqWyigf6UE26OMGy/D7IBfceqll6B6+wOGnNrm5xR9AGlfzVn/Lsi5p3ROFaNQ==
X-Received: by 2002:a5d:5d10:0:b0:427:7ac:5287 with SMTP id
 ffacd0b85a97d-42707ac52e1mr14817958f8f.34.1761231369200; 
 Thu, 23 Oct 2025 07:56:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] MAINTAINERS: Claim the Arm XML in gdb-xml
Date: Thu, 23 Oct 2025 15:55:50 +0100
Message-ID: <20251023145554.2062752-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Add F: entries to the Arm CPU section to claim the Arm related
XML files in gdb-xml.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251017154244.971608-1-peter.maydell@linaro.org
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36eef27b419..732b5242e85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -208,6 +208,8 @@ F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
 F: docs/system/target-arm.rst
 F: docs/system/arm/cpu-features.rst
+F: gdb-xml/arm*.xml
+F: gdb-xml/aarch64*.xml
 
 ARM SMMU
 M: Eric Auger <eric.auger@redhat.com>
-- 
2.43.0


