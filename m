Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08856E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwX-0001L8-2N; Sun, 15 Dec 2024 14:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwQ-0001I1-Qx
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:10 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwM-00014t-RO
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:09 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-29f88004a92so2209574fac.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289563; x=1734894363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwkWrdMELqfgScEhjfsq064CDq4CkYokaCr7swwpQFA=;
 b=JTSSr5ZkD/M7BeRScRdMBF8HnjnYH+9wX9eKcOGZA+L1/4bf458daDbPM1pvAzzaov
 K9RzHqOFZATYL3DozRNLudBnX4RyDrKX5ZkEiCF7hn0sDGMkgeAE5va6vFbkHTszLNv6
 lPI5vpjPmeD5eZg9sfdsOjutnk1zLFTh3UiyTycS1cUnXkjg704mzr4jZgunxqDGfftU
 46Pl2u8T1v7Gphp14E90rfszB5d5orLxRB83GgCOjPIUBtq8NzwkOvWREVCUERuMU898
 E/PZ2CF0T1v6joS4MaA7xTUA/87hBsO4MLzKPdCX+gsztGdzAi6OwoGT/OUFFznfSBmG
 8/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289563; x=1734894363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwkWrdMELqfgScEhjfsq064CDq4CkYokaCr7swwpQFA=;
 b=s3cO87XT4PrYfJdrBUN5fJIxo3nOTJoDzdELWY/g/Z/EoGVsYqyzvQI/K2pZ63Tsd5
 bOPCmMoNgt1xzGqSoOs2x1EDKOsCVvZR92hvBFp3mzFmCGkkbpncxraEE0DwkNESo3Q6
 bcpg327l893Esk9euTEzCkvhRbdZPMTUDNLIU8yu65KJE/k7XYmCgvNafeh5IpexH8LV
 ebJ8vhpvbh9Q1iULKNYfucBPeClhhnTelm5YpzvAW4HsfMiJntynLb7fTVvCR5pcfory
 av1haOH4ts37qQN3HJ14EI/H45R6QjGVlSApYvT+w/9JMpLOvXkAcEM319OXa4lVPyiC
 4H1g==
X-Gm-Message-State: AOJu0Yy0s3ysgIAwUCifU77FKhyN1mZdg3PY74eV3/+ri2sQA8v/1iB2
 x1PqMxfOcW/VCcZXJtxbpbde+44xxIc66D0gHlQct5U3D9PfztLw1M/phIycywqkYjpFR//RikT
 an4j82URn
X-Gm-Gg: ASbGncs38VqcecX+JUrhv9wjdnQGtYpLX71/UlEyz2lW5QVu6IQQamdw5W91dWxgoDJ
 tGEXq+l3TZIT8upnw3OtLtmL4WqDHQ39r5wInYcNKjdVtmpQxneBGMd8XIOyDNXjBa5H0WsgHeB
 bgXfnkctvwxNi4do7YcUdbHQkTzmx2Q7KXrmDLMMwWzA7GwOQTUJaUgBMTytM7BsSd/5dIBJGfo
 WxAZK5DeVr+s4kjnFq4da/lN2u4iPuwQoJ+IyhXIFoe7Ka3LxuvPpPgLumoj3+lqEIuKfSZuefv
 uJKZ0Ny/F5k66FxqgLrwgac+ceRTh64hznpPYFSJ1E8=
X-Google-Smtp-Source: AGHT+IHHnoXHcQf+F15QZnpMXxwwFSRi6wy/JIRZWqfiAjLHn0uT9LUsJP0Jjb1xA90/955EEQj9uQ==
X-Received: by 2002:a05:6870:1f15:b0:29e:80d8:31a9 with SMTP id
 586e51a60fabf-2a3ac491170mr5418090fac.2.1734289563398; 
 Sun, 15 Dec 2024 11:06:03 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Andryuk <jason.andryuk@amd.com>
Subject: [PULL 17/67] hw/block/xen-block: Unexport PropertyInfo
Date: Sun, 15 Dec 2024 13:04:43 -0600
Message-ID: <20241215190533.3222854-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

xen_block_prop_vdev is not used outside the file.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/block/xen-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aed1d5c330..72cfd6893a 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -659,7 +659,7 @@ invalid:
  *
  * https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
  */
-const PropertyInfo xen_block_prop_vdev = {
+static const PropertyInfo xen_block_prop_vdev = {
     .name  = "str",
     .description = "Virtual Disk specifier: d*p*/xvd*/hd*/sd*",
     .get = xen_block_get_vdev,
-- 
2.43.0


