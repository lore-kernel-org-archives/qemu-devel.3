Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8306CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxB-00022i-FK; Fri, 29 May 2026 01:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwf-0001rA-AP
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwc-00025W-Vi
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso78782515e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033181; x=1780637981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7reoGQZ3GCWQQqqbcvo/480edgyK5CNnTdtR2Lvw520=;
 b=rWVxmXFOvdnODimHwG3DZrFTIztnaYteBWHAgDuyvls3gfZ5dnQqZ57uMihLVBPECv
 pSmFiOeRIqGXT1bPj+cBi0NlkRJ0QrKQKqKMEDWbxkR2gJmdL4PzVm1PMt95UFAIo9NT
 PGv/W2EgX45xMU4UgNVbdXr/hhrgMzpgEnhLa29isN+mH2Xl8PJLNRblmhdKPapXfFVe
 QYCF6nu/8irI/Q+6K9Vzn2L+DPJTnm52NUXqQd/5D8sXJoO/tCBXZO8LoBFGJSvCIv0k
 7Z2iCEx1DI0yLWQXzdwJhy1tXjOQwF2nHXon19DMBsPOcyzsp4rVQiZ4fXw9+FiWU0Va
 ymBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033181; x=1780637981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7reoGQZ3GCWQQqqbcvo/480edgyK5CNnTdtR2Lvw520=;
 b=j9DUldoEzCrHoBpL/VmF1y0E7yPuDp6KAkfstWlVbKEHMXcDFve4/3tF6Jms8XDQmF
 DCS83h6Z8SLBjdoMPv7bmRkU8/JOiteGzVwZvrc2nUdQk3o051SMWj7b8xFFS8bOM0wa
 g4kRdxvn/ed3/IJq5UBUl/xd6YAnpqcJgXrhGm2vQqnnTBBnAlQoTewgmtPfnWwyTEEq
 Okjz9E7SG78t8b20slkO62aasa/dhpbx/dq4TceTDGHo3jUlh2t3BcFFok9bID9x591z
 RXQkL5Q8j2ISdf4viOyM/pihTLEwmVJDhSPOEZ06ee4YFt6mIRij06aeF+sBIH1ZBvpJ
 heTA==
X-Gm-Message-State: AOJu0YycP2gZjwwM/kPyxWz0H8VQxwYVANOqmE5a5NEbvsFtMdPregyD
 DuDk4KcB9hi3RoB5+teTYgHGEPEVtAWg7/y7wNTVNf3+2mhIp59+xKYXfXA8u0ffmrPLBiq5vnp
 biPLj
X-Gm-Gg: Acq92OE1NGFpzEEnOgA3k5W8Oc6j6k3tUcNuSoDkbS5L3/ZS69iRlNoyCGgL5gsWAK1
 Apq+qm+2yH68WcER+beqAhJkDeWajhnZmMGd/RApMIupP/jT+lok8mGWUARIP+YQg307DhsZeen
 8iLmBnw5nnzKCqZ9THKZJzbokqsMTO45cHyH5D3Za1oYFWXtm/oYUJvIN7dbHpORmrvjAswVhU0
 V4Aj0qPdbaIsI1mh824K/ywmS1a85I5lq8+Y5z1FOS7ErxVTJy/KFHz1nJe8Fkm66SoXjaBOoNy
 iySbsn4sxXk2/8uZbXfb//y044sFGH1uhSnBfZxggEL34ms5GU16dXPXF/xSGfKsJN5vtHReaY7
 Y9WCi0Vfoytp9fuJqut562L56ITtc3psToGp62Xd8OkxQ9Qqu930UU7oM1H01qn5D+LKcTHY7W8
 TBJQoWxMDwl3ARcjQqRmkUKk3JdZt3nhU3Wku28IWd+VwJ
X-Received: by 2002:a05:600c:8582:b0:48f:d1c0:721e with SMTP id
 5b1f17b1804b1-4909c08951cmr18395635e9.12.1780033181277; 
 Thu, 28 May 2026 22:39:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354bb7asm1009030f8f.20.2026.05.28.22.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A9F4660E17;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/13] gitlab: update issue template for binary test cases
Date: Fri, 29 May 2026 06:39:26 +0100
Message-ID: <20260529053931.283970-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Binary test cases are sketchy because they can be vectors for phishing
and other malware. Lets strongly hint that source bases tests are
preferred and binaries should have their provenance declared.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260526110243.470002-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug.md
index 53a79f58284..e20f586008d 100644
--- a/.gitlab/issue_templates/bug.md
+++ b/.gitlab/issue_templates/bug.md
@@ -55,6 +55,10 @@ https://www.qemu.org/contribute/security-process/
 <!--
 Attach logs, stack traces, screenshots, etc. Compress the files if necessary.
 If using libvirt, libvirt logs and XML domain information may be relevant.
+
+If attaching binary test cases you should describe where they were obtained
+from, preferably linking to the original source. We greatly prefer test cases in
+the form of source code that can be audited before compiling by the engineer.
 -->
 
 <!--
-- 
2.47.3


