Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB014D33995
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsQ-0005ap-On; Fri, 05 Dec 2025 11:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsD-0005WZ-Jy
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsB-0005lJ-Uu
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so23706765e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952894; x=1765557694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74Wp3ifpoSboSpeuz+yKQ7pVV8feIghZIJx4U7i0D0M=;
 b=zaDyKa0Frvp4sDYSuRvP1YhNCXx/Kry96GSrnqgTnVdqBW2DeY/+XQXsSPAaa6Wgbe
 K8Z1MP+gmwrNUXec+cpksRd7N+I4OvZc1rwb/NfZ3YmvZuTCQhU9CpgZW3eGLzzxq2cW
 rnRAmFj6cgWV98HHYSCcQ8WXejCuOwEtUp083cJ3OUydx4kEY/izb7cPlK9hiAc62e98
 1CLVM9B1uZK4nKo3eDFZ+sUuGKWazRzlCkGRTHSltEuS4hTjnv2XOIlAQU/IBzaO+R/A
 KfIFThA44jh7iY3zI67dmuoMQcn0m6gyp2guQpxnadpkfntusXv8N9uZDcrcjEw7SQjh
 nCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952894; x=1765557694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=74Wp3ifpoSboSpeuz+yKQ7pVV8feIghZIJx4U7i0D0M=;
 b=CI8IHRkGst40G1G1nMmtyCp+x9rv8wjMitx1nZxAjZo0d6JK7z5lJDNp0ofpcB4QOf
 C6ooRbm3gZH6JZT8EkfxfsSkLarT77fSJUcTlZmpeUqw5wtdeB/jxNMeplhVEb2nshM0
 shBdzFLYkmu01Zpjliq0hM+7ZOkfgHGLwpSWJxnocZztDtrrtqgPDmwkY7cO1wgisFdZ
 iO8iKdJstgOLzACtCUT0qXD9eZKWVONMLtOog5hVpTNLXWqtYcljT2+qVhW+0g5A2ueo
 NrLD2Q4ubM+EuUrkXveWQpiG+yisJKxtG/f8wt02uiHNpEmBYb9V5Q3+C/gD+CalH2Vz
 69Iw==
X-Gm-Message-State: AOJu0YwN9mW89yaF8DxS/qzForUXOsd5viF4cZyoqJChdclksPdl29ef
 jXyyJFBDS9f8+eQyN1E7G5q9l/roXqK8SJYZFFsllp6smD6qTpGFqeoese36rfh7l+GXNfveI97
 lTtfp
X-Gm-Gg: ASbGncsde4gqkLkboqlpkpvvWiSuxHYmOcBoMXTfIIw51utjpqjvqo929fDwkyIqcbp
 tKggNxVlfvtiWsk/Gf98yOyCKstM74thjntr3lk4QMSxd/ERu2t+zWRWx4KAZ0oFyOrp1Y0npNr
 9Vv/bvBIKK1z/VF8J6KYtIYJKkV+K94KRRTuUvJ05PibhgKm/ct5L5y2VAFHsOkOAxHJ28IYbjD
 B2jYiinU8T/5ZX/q7jCfW/NBRObqUSGRsOhk1CEZp8IPw0jbhhLIIy3YBEVBA1uc9pvb+dyYFLi
 VkXeLri//GfbIRPsaN1026NkOc/4O2NCT/Ol0IjtDt4s0YpNwuuRNSf3TsHHU0dXPbg31PRai4K
 zNo60eVr3z82EJIv08JWIg7qTf0+F/Mtl1A80OJuy/h4d2NLdIl1rUgdh/7suBHDHgtREclskOT
 VvxSuYa0Uzl9U=
X-Google-Smtp-Source: AGHT+IHqkYElxZuZe5gnEejsB1m1MSXzJoj8HyEhj2i/COrQ7/5y6NbEMmruIrceUmQDuADGjqAYsA==
X-Received: by 2002:a05:600c:4711:b0:476:84e9:b571 with SMTP id
 5b1f17b1804b1-4792f25f316mr78488395e9.14.1764952894053; 
 Fri, 05 Dec 2025 08:41:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b693csm89738615e9.4.2025.12.05.08.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 093725F910;
 Fri, 05 Dec 2025 16:41:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 11/14] MAINTAINERS: update the custom runner entries
Date: Fri,  5 Dec 2025 16:41:22 +0000
Message-ID: <20251205164125.2122504-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Fix a number of issues:

  - update the ubuntu references to 24.0
  - add the s390x and ppc64le yml files
  - replace Works on Arm with Linaro
  - Also mention IBM (s390x) and OSUL (ppc64le) as HW hosts

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251204194902.1340008-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index d007584b476..63e9ba521bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4444,12 +4444,13 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: tests/tcg/Makefile.target
 
-GitLab custom runner (Works On Arm Sponsored)
+GitLab custom runners (HW sponsored by Linaro, OSOUL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
-F: .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
-F: .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
+F: .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+F: .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
+F: .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
 
 Documentation
 -------------
-- 
2.47.3


