Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD1CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRd-0005sz-Vz; Fri, 15 May 2026 12:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRM-0005e8-Ia
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRJ-000287-Io
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so210335e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862664; x=1779467464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qZPpYES+4gSkEIJyytMALF3WWjAAhWFsBoc9tpHp+A=;
 b=auHrsPyPiJDEJ8vMBkt8bwpBCOQuZB1m/evVE5cip1SnYGu4uhWNtiiitXHk4yRhmp
 RbLfxBHA9/qs0Tfy+6jFiq+bzVLiHEAmsWTAknyr2usbPuRLBIpS/qpO35tywyFlvB+d
 Q/NRECYrNpZlk9NTbF2+X76tLBEeFCqqI5p4kbBSqtJPqkd5LnS36XqkeDguKSPjwQ+9
 738ITVoMGeRCXW/HCwIGHfAnSJVmPDRllOvnByDg9QpUiqxzJgY+vUabCoMfSX73O6HG
 kOmVgzIEYW9Ty7Kv0BvcACIlItg4llDVPwSG4fsncASDi0L6pwIqAV9SGdEQKusuqpIr
 uV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862664; x=1779467464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9qZPpYES+4gSkEIJyytMALF3WWjAAhWFsBoc9tpHp+A=;
 b=lGnAtuB71//LcT2F3oVyVQ7ubjeT6YuyCkwVA2kFvw2sOhc8I3rPr2DESPQ44SRuf0
 SGfUVaeZb2IH3gujRNFacPwTZi+YMKBS9oX4hOhCf7Kc7GlegZz9+F3CvjJZmBEoYVlD
 CFZb02CFh5/BOq9mKKgwDHIASckIJWiauYZw886RmnN8eowvVm9IpH3H0S8nG1mFsdwx
 KdOM/+F9xZM1hg1ac+VbqyYuN1q7kWaM9aPven5EDhbi7Gw6xOMfmE3tW6BWQQ7x85CO
 mhk+WK9uHmJ8anj7rpcbJLKe12Bx+Lnr1/flTayxG4j34KX57jki6L9RzM8fernKrXC9
 iPyw==
X-Gm-Message-State: AOJu0YxnM9hFRxhYa0+vs3AcRzbo8kJRHFmJbIPfqSApQ/r7Qu1ZZbLp
 lK6A0y3y7/S2JdCgZSif8n8PnRYi9GkYdkKo+flMRdJzoz1sv1b4CJkdgaWOfCKEEcI=
X-Gm-Gg: Acq92OEvJghbknyJET/101YyBfHLQzbViPCKgWT9VCQs4fuMBZuBy66EWN0QvXfjpp4
 LgsMnV0VxOegR0+aSZRvWBL+uTk2VfLMGD4l5F5TyB260NzcHcksgOiB7DEH/4Z29gZoQw8yw+L
 mro4+2tPwo3a1aV7v4jFYGOi218bzEpyEMlQC9NeRLtYtgpRybUx0JRB3yGR4fMB63gv9YsK+6Q
 X+Z25IW9xBCxFuANNvMf+p25ufvSc76KYLvyPEP4LeTj6fPORf+9ysA3kPqZu/61OakUSZQxP8s
 4PzO7rZhKURGKZhtBIo8E/2PE4PadkwYJYTpUNKJueOdHCX6vOKrUeQrwfjuEae9m4K04UqrHwO
 gT8jVkZIwNMrILwKS93TbTFxsgFbVi72dq7xyka+qwYHfqRE3hnK/6L87RdVBmdNH3ZCn1+Ela9
 vORaIOjjUtD/FebOBzs4qt5ms=
X-Received: by 2002:a05:600c:858d:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-48fe66129efmr43946625e9.27.1778862664226; 
 Fri, 15 May 2026 09:31:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8d39esm71940775e9.7.2026.05.15.09.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:31:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 893315FA91;
 Fri, 15 May 2026 17:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH v3 11/11] MAINTAINERS: add a section for AI agents
Date: Fri, 15 May 2026 17:30:54 +0100
Message-ID: <20260515163055.1792262-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515163055.1792262-1-alex.bennee@linaro.org>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

For completeness add a section to MAINTAINERS to catch changes should
we decide to merge this.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a1e4e4822..70789044d30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4570,6 +4570,12 @@ M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: docs/
 
+AI agents
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: .agents/skills/
+F: AGENTS.md
+
 Build System
 ------------
 Meson
-- 
2.47.3


