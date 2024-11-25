Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97F2D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatq-0003ys-9O; Mon, 25 Nov 2024 10:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFato-0003xK-JV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:16 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatn-0001m0-0X
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:16 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4349fd77b33so8490365e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548073; x=1733152873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dc+EYqX0ebrk/C4YZBuFVDjzfyMWYqa1VdwvhYwR1Q=;
 b=RiiupRLJzkFjMBx2cBpFHYaHKwNOYk5S0ObtzuJL3EYWGjNtIVxHhMiTi+Dg6Y98Vt
 6wxJy7yKZBL94kaXdYblcRKWwB70MyJUW3TwweWm1lLZHGLVlzPUze5J9aLqUNLHT5D2
 eB+EVkQAPlJ3g6ni/OfoCuW3uWIjf3/O3kBf3xLf9fP3VJYNBqqG1Wvk6pYcNjPXqkiF
 KRNvaYwSZXnQ7yhnxTenq8uw/SvJjsDYM1V8Vbd8BjpWYrXNH48VmvRJgXo4Vqtb7er9
 WtMKwkEsGVYyuuTqhwXYYEOhK/dW41iVSNMP+NHLPTltJ8bqjVYPTzdlYnKof49k+a+9
 rrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548073; x=1733152873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dc+EYqX0ebrk/C4YZBuFVDjzfyMWYqa1VdwvhYwR1Q=;
 b=FNzsC4FyMDVgwBNKLiwEtR91waG0iSohR/0f9wVOkThukmg9jHjstZZ+k7REyS0l4Z
 ei+OrdnpJi4poo9vKm+TVcrA07v/E6hXbV5wW3eWSh8jPScLa0XX3C5J5GUhoULm65nO
 47a97LZMuCkW1xBwh4SNYn3X9XOuD+ST4fdd30ArJezVg99FbB4+1yvVC/MbAz/faOaO
 i5/BVojLZ3/KqZ/V6xhxyrdlYX36t8FPqbYYZmUJXXDPZmd8ij3I0gX0+IpVLYMfgfVM
 hFMytRcs4w9THcvceKh1OJI6XdqrwglfkyMvV1iZrBX6rmjBdKsoVsKy/L1PQUNq9g5i
 LXQw==
X-Gm-Message-State: AOJu0YyjAB1ieCiLoyWD9+ZkIs3jFsRQMb0brNXMUbl/kIfAF2MP/5Tl
 ozVvk8k17IJ8EB1uPNoQ1Sz4fkwOlt7o3CMBosJoctPiIBwdKXkQloNQOZIsyRg=
X-Gm-Gg: ASbGncvkF68OP84MB+kQQuVdeEQByfLWFTI+i3xfHLQJRRlsAgXkzdkSzfwxD15uDiQ
 KAIWsEpe69zeLdrpydhWTe0YFMPTGigCUpF0szF+o6d5LgHyxwB1oFfLPVcehdq7xvUkyNYNTQb
 1e+qyPThHd0OkHVeBg5Mm8sT+2kWmn/4pCgd/D3dGccI0LqtvFeXfkPt5tZ7bt+R89a/6BgpHSc
 Mu42Lfr2DSZB4TOfXazEmZHgIPXETbIsHpLxMwo/4n4X25b
X-Google-Smtp-Source: AGHT+IHWYA1pg6eHg4hP7Wg/i9+GZfgQDFoCNrHl4lrH84vZVCreA3bXaQ9r0F5SicBRS0eulQ+w2g==
X-Received: by 2002:a05:600c:3b97:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-433ce4e7b6amr125896845e9.30.1732548073508; 
 Mon, 25 Nov 2024 07:21:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349c89a113sm67298675e9.21.2024.11.25.07.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B706E60A96;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/28] tests/functional: honour requested test VM name in
 QEMUMachine
Date: Mon, 25 Nov 2024 15:20:47 +0000
Message-Id: <20241125152105.2100395-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The functional test case class is going to the trouble of passing
around a machine name, but then fails to give this QEMUMachine. As
a result, QEMUMachine will create a completely random name. Since
log file names match the machine name, this results in log files
accumulating over time.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-11-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-11-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index ca13af244b..f9c9de1166 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -164,6 +164,7 @@ def require_device(self, devicename):
 
     def _new_vm(self, name, *args):
         vm = QEMUMachine(self.qemu_bin,
+                         name=name,
                          base_temp_dir=self.workdir,
                          log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
-- 
2.39.5


