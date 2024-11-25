Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1449D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatl-0003vn-Il; Mon, 25 Nov 2024 10:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatj-0003uL-CY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:11 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFath-0001jo-Hu
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso57922335e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548067; x=1733152867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvK4bKDeVOpZ19QqnWXbDR0Dq2nUudgpqwsRQwj1P8o=;
 b=i326yPNlZkAnnHQDFCJJo2ix6J+FDhs0AMhphHZaZ/L7sfEuVWKOXWKUtZKLIXPbw/
 6LMzKRVxvoIKXgCDyna0cVZG9o7/1BBKFRW7JDAhDpAKC7gFHPJG2Rf6B34Cz4OrFmfw
 A3GoJuT9CSJY5n67JBp6k5RYvNjXBnxw0sk0jQNqlIGszEyKm+RyAadPir7PSSVSjBf5
 878fnXM2R97hVprmj0LmcWWxphhsr+i58hyWEGbXwI7VUgL8XzqCLFQqrcdhsnJ9kdE+
 5hZwY+iFi/oL/7CrCi5dPMPOLo8ocTE3c5cbh/fWxrWm3HiUXU2truDviemJAu4iyxQL
 yBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548067; x=1733152867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvK4bKDeVOpZ19QqnWXbDR0Dq2nUudgpqwsRQwj1P8o=;
 b=lsiaIrcH7ITwDDE86wN8e0xe3D7NtYXa7TFQvJ0mc8qycc62owX/dyg44EeCfTBQam
 soJlvbVhvT/9TOs2iFWa8hPdTaavL1lLKn4h4KdyneQ+El8f3BHYROn1t2wyVQLmszQu
 9ztiZPY4hh2Ie7o2eDhUlZGg16eCbHFg/PgkYZkQ8Wx1jFsIhXvWF0uKwV6QxZBRQmFH
 lllz5g5Z66zyXR0L2xBI6CgH6GO/wYwtRzeBS6EpiPMqqoVSA0AKmAhzBhX7UI2Vq8zY
 YMyteVCfZUG3Sb1jrUyRGEHK2d0+9fdxA2hlu3mSHam/5gMM8jGO1IUrZFokVUB2Dtfn
 F6pw==
X-Gm-Message-State: AOJu0YzDi0CSud16ORGICsxc6FC0O/10CZUHmkeQeYxVb5H2oOGnZO2t
 20r7yr1t9uBba+bPWlZmveIX/8/wyIC4Aak/ZSCjA2/lTdkY5xsTZjEZrGtNsCs=
X-Gm-Gg: ASbGncsHGFOzFfR56xYHD4sf6jotk6+JWLzsn2DmHtq1Y6NQEVlsyoPw4KWW5w6/oEG
 uzn9/pMs1IX5QYt83FWz5IJIlgn4l4gUtsPcfPvh+42GW6YEu02Bm4MW3+qP4M13211Ffswlevl
 /QVklYKGrMctBZi9N39mBGASA5dzkZmEwSMNQqGedZe1k2W2bVGHsgSv4WMtOTBCKIHlxZdGazG
 kZu8ei7V0986OsmLSt502c5tqj0lTeW/fqPRpfIohG9gqp7
X-Google-Smtp-Source: AGHT+IHhtr/o/AxUlCIDcMq3Epmjf0JFVpX4ctuvVRGb2YCQb0gqHm+DHZx5+8ejNe1XDz7duOpOkg==
X-Received: by 2002:a05:600c:3b12:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-433ce426874mr154669405e9.16.1732548067192; 
 Mon, 25 Nov 2024 07:21:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a14ace5asm21584425e9.9.2024.11.25.07.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFE6F5F8B7;
 Mon, 25 Nov 2024 15:21:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 01/28] tests/functional: fix mips64el test to honour workdir
Date: Mon, 25 Nov 2024 15:20:38 +0000
Message-Id: <20241125152105.2100395-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

The missing directory separator resulted in the kernel file being
created 1 level higher than expected.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-2-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-2-alex.bennee@linaro.org>

diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 6c6355b131..24ebcdb9c1 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -129,7 +129,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         screendump_path = os.path.join(self.workdir, 'screendump.pbm')
 
         kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
-        kernel_path = self.workdir + "vmlinux"
+        kernel_path = self.workdir + "/vmlinux"
         gzip_uncompress(kernel_path_gz, kernel_path)
 
         tuxlogo_path = self.ASSET_TUXLOGO.fetch()
-- 
2.39.5


