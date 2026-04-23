Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A8CF99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtS-0006Kk-JN; Thu, 23 Apr 2026 06:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtN-0006J0-KR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:41 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtM-0001yn-7f
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so5190295f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938559; x=1777543359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P91enuvCUzt6TPFUMJ9daNLwhYClu8JlGSNhfTMG02I=;
 b=K1+q2JNq3IWhCOzgHfTtEE2uRaY956RCtCMY9kEOypz2DHECxmokMm9RbVLRb36+Xe
 VjRq4inDEKRl0NHKhX6weLjWoC4jJZ98CEB6ZlyWz20zjRVtVubAZmc+v4WGBZJyGZ8x
 iI1vKoQrAwzNbqI+INKMXc3J7x3pEbda3NkKKl8T0aJNqjacZlyY7RJgt0/BGPfaR7SK
 HZO6sbWBviHSmElSLvmLBmkrLKTMIVFHMEeOMzZQ1qMEeRrmMdsTKQ3n1eSYeJL9XJtr
 8GTR+lZ2sox8BS801Nt8YIEnp918l4gHZ65UqnDWAhZ4fCXafW2TIEbzTjUJaDET9RD8
 AF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938559; x=1777543359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P91enuvCUzt6TPFUMJ9daNLwhYClu8JlGSNhfTMG02I=;
 b=FpqYxYwWZ6gZl+RDdKXldcHz0D56T3kjk3esbJo8+cWWyYLasS16t4iBONkitmQu/e
 ylu25rGywte0ge/f6PTBLc9UBqDdU1MUhtgoV4UquDzc7W39/VEilDM31kUwJoY45OLE
 QG9mszKqBEZQ3OwDa5E6S7sgnEpqvvmGrQEw52eVwC3ivGjKQwdyyA0f/m0q3Gk9Mybp
 l2YCvUbGASbv8GPsx+dPOCQO8+u754Q5fllUitJdQWPby+dSn507VNN37Q4B3A/qbWz9
 vJJJzMtACazF7ko7yQ6nw0+xm44FUAquvEQvisoAudlFPt4YcE0XghN/pQ/hMOF5QgLH
 SFdA==
X-Gm-Message-State: AOJu0YzxuYXLjVAeSwD5JWCtrPwKT0L5f0SIx3Q89k+uPln8jrChVf+t
 oeOl0siBs5yvBvJy15qApjAafTGV14V3LKZ9ARHZ15qbgb969fqFmCwK5anyJsT/12U3cimlWaQ
 XjO8I
X-Gm-Gg: AeBDiesmPpggccIkF0AcuD3CtUjtWBTxMwfZ08bb5/gMBc2CrbcxLrEHoKqGE86+53f
 GMgHNEO+2Oog4KQnyMhpFOYDXyWLsOAKyzb45FxCipghrqkc91aeTe3ndNgkwRCbVPXGk4jetk+
 yi+yxFqht0HER7S7w8Vuuyqr+xvb1JAqqNDgjUCaS+0uB/aDhkpMAf/203b6UAAtPZCfllQ2PVs
 IeOrU0vLTOV71KTUgBDv1+ERtDAp+dsNOGo8q+wvKz3ojt7Tv8K15G9G2mzKhnru7dhsacZOUap
 v1AVusko199zHdcc9hFVpM/zl/xerKIgQjlpqooerx6BmXwDsue3YhBssKZX/1vDaFCn/aCGQ6p
 ocdG/TdmdJxplllU3EFQiT0WmSBrD7qTh5WYqjxtcnA6CGIoUKC9vPCqVdgGguhXu6z4IT3sUEJ
 6YdqGcTu4qstE5GxF4VGh4MtuxpIpyw9e6nGK4xY/+MKnN8Jo1U6sQMwa34HOg4hN2WzIZoKjCD
 jNyzKmRD8J9KPRzRyqerC4W/v1XfCav4vySG8BOV7e3Eg8sovYJ
X-Received: by 2002:a5d:5d0e:0:b0:43d:7883:87c4 with SMTP id
 ffacd0b85a97d-43fe3e17215mr41297679f8f.41.1776938558568; 
 Thu, 23 Apr 2026 03:02:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/59] tests/qtest/bios-table-test: testing new ARM ACPI PPTT
 topology
Date: Thu, 23 Apr 2026 11:01:37 +0100
Message-ID: <20260423100229.2941820-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Alireza Sanaee <alireza.sanaee@huawei.com>

Test new PPTT topolopy with cache representation.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Message-id: 20260311160609.358-8-alireza.sanaee@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index a5a5b8807b..510751799e 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2229,6 +2229,10 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
     };
 
     test_acpi_one("-cpu cortex-a57 "
+                  "-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=cluster,"
+                  "smp-cache.1.cache=l1d,smp-cache.1.topology=cluster,"
+                  "smp-cache.2.cache=l2,smp-cache.2.topology=cluster,"
+                  "smp-cache.3.cache=l3,smp-cache.3.topology=cluster "
                   "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
     free_test_data(&data);
 }
-- 
2.43.0


