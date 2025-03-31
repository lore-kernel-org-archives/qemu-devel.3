Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB30C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL9i-0004v0-8q; Mon, 31 Mar 2025 15:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL96-0003d3-GL
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL94-0003UQ-Gt
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so33391145e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450604; x=1744055404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5ZHjqmLDaEsy6AfHhvBBwdmYQrv+nX9DlxuV6Wd4ws=;
 b=CrKa71OCf4qF3PHdRFLFbzYB+JlfP39bg45Ge/1Bn6ixCep9rd1EfVHQ8n7u2dym8y
 FGeUXtXDXIeevoykdQEsjWzJpKfhupnemzHRkHEyYAf3RFpAhJuBK6h52208dIopv3zQ
 /G99DM+EB/tsbWavkTINC8XGgdnwjlGXYvFKiTS1lpYlSa4cBxKJvz4T8di2p+b3gSib
 nkfiS1jTi2M1N7Z6BJapcwL3+owIILWAoipDvHa+p6bSGu/JjzcibGeraNFtCtP1XICM
 dBBoGBMYtA5CgdQG1KcrjptpwBsMmYj2rj5cif96jKJf6A2LSuQ/szgJQbYDsIeRU9xK
 Uj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450604; x=1744055404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5ZHjqmLDaEsy6AfHhvBBwdmYQrv+nX9DlxuV6Wd4ws=;
 b=X5l2Ru3n3iDZh9KVJv1VsFfBVgmVOoImRCuZKprWP8q2CmYO5PUvt6EPZbGks//fcp
 b8WmvRM7JHnNcZ7ItUlXE0bPiqX7Yq7o/c70yW88VvjidJXhrUxoZLRkKFXhW3+k9mPP
 lFokLcKdfskhC/aJlxpl7s7t0HqlDwD4fL98g05rGbFlh+u2G/JVZbta49f0lOYREx7i
 Dd5GCB/WyZRaEL+LB7vSo4EpIa7wLULd9i1aWI3uAtw2hMjF/wkZnN3D/TuLZ438xBnV
 j5Ipb7suR8zSIX+iGrZzfpv14vvnUyhkNXqa3sHfYvw0PGoOBJuQL8tpxxr7DCaenJM5
 rrwA==
X-Gm-Message-State: AOJu0Yz2LXIypz1uINe1jS/trhp6nnZ11qUN0iTdPzkrTIIPNY0nm0no
 glugssjsKffRIF2mKMh2VT5DUZKhO9saoyFstFCRoup0GyqW/NC7nQdv8dCeHJvbCMdQGe1PPJA
 9
X-Gm-Gg: ASbGncsliEykFWr9Ys/J5T/RaHRitMfOT0UfKxrrWEWSqmvKtFU1nLArNQZhgPZhuDb
 jzhjrV54yIz09FpNzgpfRbuhb76BC1a1TY4U2STLYAMQ1VWrJdH/DHTL7puVUEWP9ocUCAAXLLp
 XxtADll+Pqw7NQVw7CCmShdgUYNI/pcrtQ/MAnH7smNGAbRdEXa/fh5/3SISqzhwcEqKYGg0OL3
 X5qgqg3ctrpm7Rm9+TjSSA/WACx/s4rr2GSeWzmJJKKcf1F4kqIaIIMzFmOPrnt/PWFfokEP3n9
 mmoDHBWOI/lQUuuI/Pyx5QICJ4RAgCa+DPBRRDJUwlbdSMQoiBBYRClMUyCdTVPqUWeUBt7U/F5
 roHnuieHG3+4QomhfR+o=
X-Google-Smtp-Source: AGHT+IH2Dsz2O/HyegmMzYX6SMS8/upMl5C4BT42F6CaD0c9wA50VYlh4PHDqDG8TyUp449d2sGKpQ==
X-Received: by 2002:a05:600c:3b0d:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-43ea7bf5717mr6007835e9.0.1743450604564; 
 Mon, 31 Mar 2025 12:50:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314f5c6sm179823485e9.40.2025.03.31.12.50.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:50:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PULL 20/23] target/sparc: Log unimplemented ASI load/store accesses
Date: Mon, 31 Mar 2025 21:48:18 +0200
Message-ID: <20250331194822.77309-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

When the cache-controller feature is not implemented,
log potential ASI access as unimplemented.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Clément Chigot <chigot@adacore.com>
Message-Id: <20250325123927.74939-4-philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index b559afc9a94..45882e25db1 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -600,6 +600,9 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         case 0x0C:          /* Leon3 Date Cache config */
             if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
                 ret = leon3_cache_control_ld(env, addr, size);
+            } else {
+                qemu_log_mask(LOG_UNIMP, "0x" TARGET_FMT_lx ": unimplemented"
+                                         " address, size: %d\n", addr, size);
             }
             break;
         case 0x01c00a00: /* MXCC control register */
@@ -816,6 +819,9 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
         case 0x0C:          /* Leon3 Date Cache config */
             if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
                 leon3_cache_control_st(env, addr, val, size);
+            } else {
+                qemu_log_mask(LOG_UNIMP, "0x" TARGET_FMT_lx ": unimplemented"
+                                         " address, size: %d\n", addr, size);
             }
             break;
 
-- 
2.47.1


