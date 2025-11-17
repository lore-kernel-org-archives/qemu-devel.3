Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C29CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpd-0008Q7-W8; Mon, 17 Nov 2025 06:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpb-0008M6-JE
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:39 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpV-0005iU-HZ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:39 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso2504906f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380531; x=1763985331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMVC5qM83p1dTusMd1y9CVJYzPl/PVF7PvfxiCc/j5M=;
 b=S3vSxFAjQfD05hixokfSumxeBt2k8vf46eLaOlbFxV8J2RF+5depiatTnX3U9++uDX
 gOh9Y2nQASCCqrEvgQ6SuO46pq+U27FPoGUo2vQ40D+/BY6KM/PAnG7CGVKNR6E05zJQ
 948aPsuNnCMFIRyS3jwDicHkvK806EkvhCFZ1vpHPBZs6SxrFmbtna8DkKYheWFh33Ac
 FpOLmqnrQulrurEmNehYx+mACL+Rn70eK3vx7l8bdnaIGqG8csNvgRk8YYcj0QOrGYxz
 sbSvcpmC24zbPgegiQi4kywp5e7Q4R9whil59l2+h7ypFpUCMW3U1xU+PmJgD6WY068o
 POxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380531; x=1763985331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mMVC5qM83p1dTusMd1y9CVJYzPl/PVF7PvfxiCc/j5M=;
 b=JuPuGR1PnGUwFRAQuDPDxLA4ccaphoey3UIHsXU+OvQ4cGbXshWUw8BSKWLLanBcpb
 6CZ/fDGVsxbftiXfzePCPXhZ5Nkpywi9310wzNe8z6qpNkqf/BwXjZx47y43Shmdntei
 ZgcTM72EOYWEoP5w6MKgXNC/SoOhcuZ2aOduX1xO4OW4ee6Hfewdygn+addvjAKmqSi1
 r9QP5Fr5g+MnrHqpVlovtGj5leDcH7Dc4a3Z0z9qDrQjfh9t8CEUMl63mRwEZZgBwKM2
 9tdOQKuZI6El2sjcfGEtatgpxn8ZaPLPC8J9jvkQdFhvGFN/AT0kXbYQnl5ie6bCLFd0
 WvGg==
X-Gm-Message-State: AOJu0Yws6zFRsakrrzOtoEd6YT+cJ4+ZrWATNg6890rrUdxnTSqZ0Wky
 GDZCFAaalnvBX3660FNoQtMSX5h0J6GjuZW54TDL4JR+5UTqGofwW7+VE1Q+2lnx8hE=
X-Gm-Gg: ASbGnctCB0Bxbb2zfEWqnjN7MTDAB2E9wVtJw90M4k4Wy7ozz3jynOu9wTMKUCG2LyB
 5vhCHQqCzxdaLiafGUSIz8D2XghIw4Oflwdh+J/pVFPfYyuH83DZNW00EwuWP6+DNjOEmlwpDIu
 hn4iuIlkrA6GQ2/lccVteNKJqlowHayXyGj50FZHp8CbBS7wIcg3cI3MhM6gHWoZr8d/paNWXSi
 NYfHzV+1TVkv+ucpSbQelqVn352LHhb/oAmZM+QxLmBm14w6fa5bpKy8aZAMw1KI3frgxaAiZAV
 jsZdwHXa+YBZxbtGd107vORcwuq+vP1lyOTcOqU7vTJofRDvCkuorlXvfKT/zNt6sQHv+drhGlh
 PBa7KoYMetlFiDiKr2J26IAH8rjb1BCXovE8Wy/2ajfJ7VMLqpnrjL+hJA64XTpHc11cQcRiBBA
 vVeWykCAxaubg=
X-Google-Smtp-Source: AGHT+IEnzswHRDKa9HZmYVfFN2pSSZmgqp37Fck09345tiSibHF8eCJhfom94Qnr5vZ3euNT3kt11g==
X-Received: by 2002:a05:6000:248a:b0:425:82b4:a099 with SMTP id
 ffacd0b85a97d-42b5270bd10mr16671689f8f.0.1763380531213; 
 Mon, 17 Nov 2025 03:55:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7aea7sm25804997f8f.1.2025.11.17.03.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D8C465F932;
 Mon, 17 Nov 2025 11:55:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH v3 06/18] tests: move test_xen assets to share.linaro.org
Date: Mon, 17 Nov 2025 11:55:11 +0000
Message-ID: <20251117115523.3993105-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20251113102525.1255370-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/test_xen.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/functional/aarch64/test_xen.py b/tests/functional/aarch64/test_xen.py
index 261d796540d..d90595cad35 100755
--- a/tests/functional/aarch64/test_xen.py
+++ b/tests/functional/aarch64/test_xen.py
@@ -25,8 +25,7 @@ class BootXen(LinuxKernelTest):
     XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
 
     ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-         'download?path=%2F&files=linux-5.9.9-arm64-ajb'),
+        'https://share.linaro.org/downloadFile?id=RRahAWwAwYKTZQd',
         '00366fa51ea957c19462d2e2aefd480bef80ce727120e714ae48e0c88f261edb')
 
     def launch_xen(self, xen_path):
@@ -55,8 +54,7 @@ def launch_xen(self, xen_path):
         wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
 
     ASSET_XEN_4_11 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb'),
+        'https://share.linaro.org/downloadFile?id=ALU4n2NGGYbE4fO',
         'b745c2631342f9fcc0147ddc364edb62c20ecfebd430e5a3546e7d7c6891c0bc')
 
     def test_arm64_xen_411_and_dom0(self):
@@ -66,8 +64,7 @@ def test_arm64_xen_411_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_14 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb'),
+        'https://share.linaro.org/downloadFile?id=os4zSXPl7WW4lqX',
         'e930a3293248edabd367d5b4b3b6448b9c99c057096ea8b47228a7870661d5cb')
 
     def test_arm64_xen_414_and_dom0(self):
@@ -77,8 +74,7 @@ def test_arm64_xen_414_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_15 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-upstream-4.15-unstable.deb'),
+        'https://share.linaro.org/downloadFile?id=jjjG4uTp2wuO4Ks',
         '2a9a8af8acf0231844657cc28baab95bd918b0ee2d493ee4ee6f8846e1358bc9')
 
     def test_arm64_xen_415_and_dom0(self):
-- 
2.47.3


