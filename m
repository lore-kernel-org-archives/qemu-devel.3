Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35090E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEtt-0004g9-FU; Fri, 10 Jan 2025 08:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtl-0004c9-Py
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:01 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEti-0004hE-Tw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:01 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so1301891f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515077; x=1737119877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgCVflE3T2z9uiLtV780jQoSuOa9fTKuCFke1YDN4fw=;
 b=njjVKWULbCTR/6c/im0t1qx9DkFxiD77PFDCeJV9eEQthJjFMIrEpa2/H5ypaG2oyv
 VfdRhePtqyFnRWwpDiqtPHDCH7NaeqZhAlkDQPFKRh7bq+GV8RZHPSGbcUfVTwcqcBLc
 FmDYrUs1PrhwTeyAMu2b6IkKbxmAOU8WLs0AFiRG8T/4aCwSdR7TVhRTuwe4tgUqTMZM
 Dq8/95pUL/fCCbqDeCpCb18BstMSmBtWupXRnC4AnWSFdgITUFiyhCU0/Dck/xjZwPCB
 uCaV9rsWfR7I6lUFUfyngs1yfPBRu5mbP4PRHiidXX33TnbaAHxNJp2fJ8X6bJKarBMS
 cm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515077; x=1737119877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgCVflE3T2z9uiLtV780jQoSuOa9fTKuCFke1YDN4fw=;
 b=qE1TThOfwcGRv46hp3d8ulfg/fGelDVA5KdXU0Xtrsd9Yb6R7SzydBFkhHmw9nKkZg
 1nr4i3TBFHtZI6yh5kLGlA610YesgPK6rBq3ctnonLEG/yw/lcxpQ0m0TcsjUfkItN4x
 o2AhLiEH6cnB+ce1S6GefmRcfjM7t3b2HyLMmxTQWwoYtAkKn4soX0Vp+Uve8GyoYWnH
 9yyrJzfWik/S/ly68EU//0LWVeDx1B57EJCmLPLDAroPZRJ/xdUM8GAbV8VsDyNS6sGu
 zBQ7IiXjNrmrKIZfVp+kJ0+oL2pOwys/UlXfFTw3beJwAgEhLFvLPxFucYa6lqAwKBtn
 ElQA==
X-Gm-Message-State: AOJu0YyP0cFatXWxjGJVwebzkel9+Pu7ipPTDJtye3eXGZCEnvY/4MF1
 PQgH+71QvuYCoWJC68N0qsVJnSunYyPM4thYaNyuThdlARWpUKiLYUcOYAa1T9whzXnFWuOUyMz
 8heM=
X-Gm-Gg: ASbGncsghIIbAmhfkaFUaR0fe/xMl+qg5U/hm/M+VAEEz8mYEGsxTE4ZrqKVTTFlKRS
 wKFnwVTux4T1bEtOHLEdvRqKQGQbergAy2IfK5r1Dj1mq9V21bH4u3wpkemHQL6yiwPG8RlEUwP
 FmoONFUvp3T4+w9l4KdOqLbQcHylZr7wvmvYxAOr5BKn9iMQpjD3W6Ncn/7Ald/IjhbO3uG5rxR
 AhzvpfaddUxRCj/d3kYI4EuLNwLwOxycAOt3oLtf9X2VOcpPEneKZo=
X-Google-Smtp-Source: AGHT+IHkkjEbZwAieGlQiPYa3uo34DMjxhfaMT/Z/MbZz2BNUqymPZjRGU1ePjWcRV3x1evZikGdfA==
X-Received: by 2002:a05:6000:4597:b0:38a:88bc:bae3 with SMTP id
 ffacd0b85a97d-38a8b0ffe8amr5246121f8f.31.1736515077541; 
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bf78sm4482638f8f.48.2025.01.10.05.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 74CC55F9F7;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 04/32] tests/functional: update the mips32 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:26 +0000
Message-Id: <20250110131754.2769814-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-5-alex.bennee@linaro.org>

diff --git a/tests/functional/test_mips_tuxrun.py b/tests/functional/test_mips_tuxrun.py
index 6fec44c2bf..6771dbd57e 100755
--- a/tests/functional/test_mips_tuxrun.py
+++ b/tests/functional/test_mips_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMipsTest(TuxRunBaselineTest):
 
     ASSET_MIPS_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips32/vmlinux',
-        'bfd2172f8b17fb32970ca0c8c58f59c5a4ca38aa5855d920be3a69b5d16e52f0')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32/vmlinux',
+        'b6f97fc698ae8c96456ad8c996c7454228074df0d7520dedd0a15e2913700a19')
     ASSET_MIPS_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips32/rootfs.ext4.zst',
-        'fc3da0b4c2f38d74c6d705123bb0f633c76ed953128f9d0859378c328a6d11a0')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32/rootfs.ext4.zst',
+        '87055cf3cbde3fd134e5039e7b87feb03231d8c4b21ee712b8ba3308dfa72f50')
 
     def test_mips32(self):
         self.set_machine('malta')
-- 
2.39.5


