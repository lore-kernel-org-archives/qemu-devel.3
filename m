Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71CDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwk-0004fO-8z; Fri, 31 Oct 2025 14:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwe-0004Wh-0I
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwK-0006DD-LV
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-429b7ba208eso1496087f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935607; x=1762540407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kqI4MYI8GnUxg5j5Y7KOURLYQbvHppTj0TQY6qGs/XQ=;
 b=IKS7NzF8wkqIsC3dT7tdEgVVc+TaxhZ2bSFOK2ljZz+pZbAaPMvWcGslIPNMCFF5WQ
 Opf5xeZK+NZhcFyNGwUH83ql+Z0xhCvsYG6oaNPUQczsotdrvGVO/z+a9zK5xqxks8Xg
 +4R5OKhiedBbEgq91IrNK1zEIPPNAT6rXghlFHr/hhThuuudJ69YgqRFiyMNqlvrOAgZ
 OnZZfY3tp1mMrx7m+lFqCaUgBFR3xf8vLJx1qEeaoLar3cpPvF4X1LuTwUGAXat4Mt3/
 VTPVQBpVmOIGENhF0K5XCdS7sD1RKFAL981whgMFzhby2fUPmpjxVzyPMcWc7wQ4Nxdk
 Nnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935607; x=1762540407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqI4MYI8GnUxg5j5Y7KOURLYQbvHppTj0TQY6qGs/XQ=;
 b=tdp1EeLnEhQo4CTpvrKSibOh8kT7OvvVXD476C6QpoEF90ktdlkkqXPdNHazYPsWG3
 PNpsV2Lrgd5LCd6TATomqrcQyrX9qltyhrstxPOrU4sKDWWrfo8dGFZnn5LjaStU64x2
 NSY3SpX5kma3Z48Y1am9RCUFrNN87J2VH2cSE3JIRxmH7/B2BCQuCQxqN0H9J/7ddMNU
 L9P+iwolbhS1A55EqzWQJ9UPL6MvPACvLV8GiXD7a4P2YHOG58lMjE0Eqep4bbCBepw/
 dt7ZGyfW+EuKVQ7EQoI0HRHjWVB9LpCijnvvyUx5nF1Y0zAwSSgACJkFujuyDReVurVg
 7Huw==
X-Gm-Message-State: AOJu0Yw3B4Iq6KtFP1iBu/46ei6SndonHg7gkTgzg3koN1yA7+ei4Ezk
 5Cf+o5FPi2JqHWEmVeaH/UvqonTTDi3i7xkbw0jjFDMWJPhqXFRTzZJz/4IcvnjCVnRcA4pflex
 f4q06
X-Gm-Gg: ASbGncudB6LRjBgtJrXhCfYBvJebPGNb3wD5mPPdVAcKBuE+89vn/8FeNEC39BF3ZYg
 c0UsKTjPHb+KItTTBeNoCPN4S3pr7E4wiJ3OcBVBe7vimBRIFCEjCrQp7zKNXdyTlVCZ5QFxLjf
 fj25AoqQvHvhO2JZlR2GhD+bQjwHd6/ISU4wkQkUFpdsikMv9IpB7rBY57nzb/QnCoDp6HI2/c2
 59wl3ZoX04kon1xqkLD8FLSnejo66u2E8wt1zcMDtFB+v1LrBuszWBcC5caRc0UL09KBkaVniDq
 ls7IdxAr6Pg/+4OEyBQpgdTjK7JyBSss5AerqWUAg0piDTMEqCcdRrqiu8Tlp33hCrUJh3Y8FYI
 4memYwQoknGdx2xaWs1LciFS7kglcoirFja5Ze3LDMoALJZ4P5jzAPKGChFHYnUS9cga4sD5Tp4
 1mzWzHIau7E793kSysD5TGuiEmWpM=
X-Google-Smtp-Source: AGHT+IETAPeFSPquQEBM6kuw27NSHDl2p4e8UwC9WY+PzOCdj2URk+OzMM4H4FKadVNg9fUjVCnDMg==
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id
 ffacd0b85a97d-429bd676a88mr4309239f8f.10.1761935607275; 
 Fri, 31 Oct 2025 11:33:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/38] target/arm/hvf: Mention flush_cpu_state() must run on
 vCPU thread
Date: Fri, 31 Oct 2025 18:32:47 +0000
Message-ID: <20251031183310.3778349-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since flush_cpu_state() calls hvf_arch_put_registers(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f0a0e5d1a75..fdf8df09d4b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -689,6 +689,7 @@ int hvf_arch_put_registers(CPUState *cpu)
     return 0;
 }
 
+/* Must be called by the owning thread */
 static void flush_cpu_state(CPUState *cpu)
 {
     if (cpu->vcpu_dirty) {
-- 
2.43.0


