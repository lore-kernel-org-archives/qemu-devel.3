Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E17CCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY9B-0005BY-HE; Sun, 19 Oct 2025 14:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY93-00058X-SB
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY90-0000ZC-M2
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2909448641eso35044915ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898517; x=1761503317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llxq6qfqlHF5luVrkm+L5VreeqcrRVzoabCRD01R3N4=;
 b=cBSvh2UnyEPBcyKxz9omWEBIL8Ci4VXD9kDQDCfUwqEv6l4TzoM7HBZ5vg2MZI+6XH
 fnPbpx+ZnlWTSeC/LHSt3XiaWhAXiGJTEw195O3Ga7QxJD6UvQjmb+s3KkWea0wIW1iG
 cieb6e5H7vpPJDyNMUMDwZIX4WGA0hwIxN9BfDviq7bNBM+9VSRIYMJF4fhqF8ZUKD7t
 daXHr88s8vX5avnV+VT1WUYAfd1beC0sYZxm9tFjXU3f813soeGtGO5kHmOYQ/c34BPy
 SxIPnpdo+xWx4Ahbfh13uBlS1v7B07i5VAOV++Zr42lcNcy7qFAiWIX2xvEn/2B4Xa8T
 lLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898517; x=1761503317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llxq6qfqlHF5luVrkm+L5VreeqcrRVzoabCRD01R3N4=;
 b=q4ghtNjT6olKVEyyiytvXqWnKBlrLzr/nn0140XmX7tqU/divtJ74UCbRsjenlNDac
 XiB4Uk4ZfCCJf3P8HIdJ1AgArhOzeycyIqZj+JoNF8E1o39WI4tT02Cwku6fE3xe03qj
 /8Hx8GmPK9ROwhOj4Xsu8UjPLh91PbKpn0C+FL7acTVS/BtAfel8lHGgBG/UuQz3JKCX
 8HgzzfDQ5YVilP0UgtLcz/osgzn1DP2QhVIPoiQcwF/FygV/uNZP2i2TiapnudRbLms8
 IDhgpNyS8XFRHv+s0tngO3zxKJpc+G2KMoAn7H7MWxNFQNxQu9U3BchX1ap5rYTg0YXD
 lpBw==
X-Gm-Message-State: AOJu0YwvGpw0L5oFjABMDfvH/IyQxyDyzW6w5nSLkf0v1ET2gyQZv12y
 BOH+r11jKDQq8FHZAAPhqVk5WCfnKIqxszgo/NhkOlUqkd97uhLiMEuwo9EiSFAlXlAb531vGGH
 9/bhKTUY=
X-Gm-Gg: ASbGncugFuhtIiCgFsAFv9oqo/jzMsbr38M8xFqV/WqyPrmBiWwxojuGcrRcTfzgvgf
 k6yVECaiRmM3xJDbZTq18y8Z77P25GZ6gCGLPuMKBbDRCITugYq4HRLIMkfDIVJY7VXMmgAYA7O
 JvR51URZP9EI+mR+pD7JDptxzx4ri8hAJ/D2yWpxk4BpwiOLA73E3DjtntKl9YaSXCs4+Voj/HU
 YeFqu9Ga8VDxNnaA3nJKEW9bqcSuZHjQTjYB7He6ucetZH9l/7l+spBEaRxTBmgxlYP6m41EhpC
 BFXXF8MFdnFQyV2G+yDsGBzYtGjfMaJbVnEn2jCI3LDFhYZcDYwS/kLCQpkZV9anat/gYFj0qSt
 GcSXhY/a2ISGQNDbfIC069t4F5MJRl0edn2tBjtWgowLDbmtneNVuKcFcTJYxF+0srf0A0f9ueH
 MMsihQ41tgpQiopBy0
X-Google-Smtp-Source: AGHT+IFOlq3mi7jtou9ldBF1RgvU6BVNJr0IRHHU/F6+ituaEKKiHa2DH7iNdQLLKe9CIiAuMPtQag==
X-Received: by 2002:a17:903:2310:b0:290:ad7a:bb50 with SMTP id
 d9443c01a7336-290ad7abe3amr146387505ad.27.1760898516478; 
 Sun, 19 Oct 2025 11:28:36 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/9] gitlab: Stop cross-testing for 32-bit MIPS hosts
Date: Sun, 19 Oct 2025 11:28:26 -0700
Message-ID: <20251019182834.481541-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
References: <20251019182834.481541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"). Next commits will
remove support for 32-bit MIPS hosts. Stop cross-building
QEMU on our CI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-3-philmd@linaro.org>
---
 .gitlab-ci.d/container-cross.yml |  6 ------
 .gitlab-ci.d/crossbuilds.yml     | 14 --------------
 2 files changed, 20 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d3be53b75..0fd7341afa 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -52,12 +52,6 @@ mips64el-debian-cross-container:
   variables:
     NAME: debian-mips64el-cross
 
-mipsel-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mipsel-cross
-
 ppc64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 8ff0c27f74..99dfa7eea6 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -68,20 +68,6 @@ cross-i686-tci:
     # would otherwise be using a parallelism of 9.
     MAKE_CHECK_ARGS: check check-tcg -j2
 
-cross-mipsel-system:
-  extends: .cross_system_build_job
-  needs:
-    - job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
-cross-mipsel-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
 cross-mips64el-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


