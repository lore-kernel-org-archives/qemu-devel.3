Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C61DC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcX-0003gd-GI; Fri, 25 Jul 2025 11:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc9-0003PR-Gr
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:45 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc6-0002W5-7S
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:40 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae0c4945c76so316873766b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458335; x=1754063135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vi6txes3Cym2c47zpRf6J2fLu3c8dV2yAjdnOgZrKq4=;
 b=KGCccPTo2xzJVLLPYjxbP26nAoj/1J6fJ90OqkWjnndGMsGmonWrp68SDFGyxGdD9Q
 bs8N7RQaP9dmpDGPqpX8/DiakVeVH9tgjtZGxjpqS9SKQv/qFoiIGoGO0un6upYTFujz
 IrZtqhbOC4u0fwanACq2U1vhpuPZRSy5vj41m5D7vXb6KF7xurBIuCYTYUEz8W4Xadpf
 hOAv86jnyQda7ruOXGjW0UFHSQto7Evo790YIwWw1DoYYDKFOXZdCfJMr3/OWpD6KN11
 GJJfVecIVCyQW9RJjaYOXkcSCS/cSuqNwzZAf7wDIwYoGgfkEyos1gyLralrfI6IsHuj
 CfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458335; x=1754063135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vi6txes3Cym2c47zpRf6J2fLu3c8dV2yAjdnOgZrKq4=;
 b=EkByOnFIxW4Yfoz7VGwRQ4WuScT2uCp51Fo1MS9sOUKsnybmmIGevHK1W81pcLlysK
 xGaJ/e+mbnBU45QkkD7cyTbLSlWKvT59sJJ5eQn1tSUoG8rXOQ7t5En7HARJPyHBGTy+
 uGbUL9Z9hv3SIzXRnMXmfdriOO+toFTjWfXbrf8SbiNgwcEeTvOd4by9Biikmj8npkQt
 evAUHcsEQbrjHqtduVJ6/xLYyZyxnyyrNVBo9PwhWtLHQW7no0QDE47CMD5bfXAYZj5z
 bgwTQbSVOQWl0N1FS6IhwDxFNp9OgyI7KsAqnIq4UllRSy8ox3kE1Ct1LFL7seqQdlxj
 voKQ==
X-Gm-Message-State: AOJu0Ywv59eJEUlLdMiDPEsk+hE+3Nk57m9SrUVXqcbYBMUF6UvgnPgz
 sogg6jPo3xSRWA/bkhzcvQW+CDtov/H14QMs5z72684HYynzF9fi3rbxJdxLvlQlg7c=
X-Gm-Gg: ASbGncvmJo4I7p0QsXuMTSreOip6Xcl+JHw7P8y+YFHvfIY2WPi8AOikgVKn2kI+35/
 PhkpJOgmE1cDWy+t6MODBF/0Clf351sejohfHI+KBWAxeJmY76COhnajq1li38lllFSuiwfL6SN
 Pz1fMDz8buI+/oA2JFDggAYm0zd8ADq78Sj7PzMXHh6olgcDInpTH99Nhfkpb3LAkPUNibiVfRo
 8crvSHqXAgYzMT9hi4gkf/A2QTwiTUvODCs2kyOgHEfpmERFIqrVEPsEqvCLggA+fSuGS1W2DVl
 ++Pxjb50Ms3Pc/x8MGzIpQw3S10lCwWtEmuhctbW/exTtTn+Eka9NqVJ0UHdKVFuUyZkZhKj47G
 KLlhl1ENAD5kzlarQJJYHRkA=
X-Google-Smtp-Source: AGHT+IG8U6FQ6Ft2GyqVqXMTpXIqWg+4xsErLRA+yMKV9WbS8m53Tr1MijT1QnXnpa6NB90o7oRQkw==
X-Received: by 2002:a17:907:971e:b0:af4:f3e4:50f8 with SMTP id
 a640c23a62f3a-af617afbdc2mr300178266b.22.1753458334843; 
 Fri, 25 Jul 2025 08:45:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635accc38sm8360266b.114.2025.07.25.08.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB1275F8F2;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 12/14] tests/docker: add --arch-only to qemu deps
 for all-test-cross
Date: Fri, 25 Jul 2025 16:45:15 +0100
Message-ID: <20250725154517.3523095-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

If we want to build this container on non-x86 systems we might not
have all the cross-compilers needed for the ROM blobs we don't
actually build. Use --arch-only to avoid stalling on these missing
bits.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 8ab244e018a..5aa43749ebe 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -15,7 +15,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get install -y eatmydata && \
     eatmydata apt-get dist-upgrade -y && \
-    apt build-dep -yy qemu
+    apt build-dep -yy --arch-only qemu
 
 # Add extra build tools and as many cross compilers as we can for testing
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-- 
2.47.2


