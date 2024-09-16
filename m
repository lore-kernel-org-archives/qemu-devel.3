Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A1C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7VZ-0001of-8c; Mon, 16 Sep 2024 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7VD-0000ps-LQ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uu-0005F7-GF
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso39669845e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476855; x=1727081655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWhpWDyIZgZQNjk9OdCuUgywH4MF2qEBFr+67oTYvJA=;
 b=DmMnDlOL3I0RX9ozBGc/MI6CrqvDC/IoEUA+2p9DIMNQDBZ3nKChnWdVtdXbX9ArbC
 C13UsPs38xYYVQEzYfQwBKH0DM9eD2tEIOsOlfurpyjpd4AyhLgRAZbAkcQVjPIv9WN/
 PDTGDHI4A1pouRYHgD+5DgRwyKQjixzgJDBqMBpww5dsagPmRXqEFAK/JZ3ocTEVMM0Q
 ROYufXHg/9S5kv6pJwJC1pVQt2FPdmYfFTzl2Pxhe5tGlQH845gpnXIBcFrlW9HY91Ne
 uowSyhA1Kg0q/fIehbTDfRAS1+VBytbuaXAg9QqlIyovnftVyMjmorZ6zYjFKY3Lwbzl
 Tggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476855; x=1727081655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWhpWDyIZgZQNjk9OdCuUgywH4MF2qEBFr+67oTYvJA=;
 b=o5JTCuzqZ5B9L5mV6dYfdn+p+ZHrU8afIx//qXpf5b/zElDjcMChuUG29mJghyxTsr
 GM4OmxSupmM/V2O7CsGCPdsWfdRCAnGR0ngsoVIDgHc0/yPbhJVuQZKaiUWVOHJWlOzs
 emfP1iiYeAGGszLa3brnHoHDwToEAckP0NnVY1eTm4BBLzCDpNqo318W12oJEV3xP2dU
 INV/XKWXUGvoAI3Vffgt3BhXP7XdORORHpaePnhe0CJ1Df1DNy10a20GrlIXGt1snDLq
 mUw2OjqE+5+u/+6fEi5T2ROFFmyPyMmmZ8s514Hda7dzC7znZX7c6xGXupH08eCC4pVP
 czoA==
X-Gm-Message-State: AOJu0YyLp5Vt0F8U4Kh/W2FNVec64lIH4G5oRK2V+9adLUekwKapT2KA
 fwf3VR3CMNwviH2J1PGVORk/TCvDmT/BKpxcOg4Qrg91JyUYqkmOJ6on4SLNjFk=
X-Google-Smtp-Source: AGHT+IEsOHCq9fWYmjKXebt6b/Cu+oKL3YCXyXi6X81L76TQAUrtgkITumA4HrdTIuueFVEC202jXQ==
X-Received: by 2002:a05:600c:4f01:b0:42c:aeaa:6b0d with SMTP id
 5b1f17b1804b1-42d907205a5mr105040045e9.9.1726476855029; 
 Mon, 16 Sep 2024 01:54:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05da47sm106194315e9.17.2024.09.16.01.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 124CA5F8F2;
 Mon, 16 Sep 2024 09:54:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Elisha Hollander <just4now666666@gmail.com>
Subject: [PATCH v2 18/18] contrib/plugins: avoid hanging program
Date: Mon, 16 Sep 2024 09:54:00 +0100
Message-Id: <20240916085400.1046925-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
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

Although we asks for instructions per second we work in quanta and
that cannot be 0. Fail to load the plugin instead and report the
minimum IPS we can handle.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Elisha Hollander <just4now666666@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 contrib/plugins/ips.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 29fa556d0f..6f078689dc 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -152,6 +152,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
     max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
 
+    if (max_insn_per_quantum == 0) {
+        fprintf(stderr, "minimum of %d instructions per second needed\n", NUM_TIME_UPDATE_PER_SEC);
+        return -1;
+    }
+
     time_handle = qemu_plugin_request_time_control();
     g_assert(time_handle);
 
-- 
2.39.5


