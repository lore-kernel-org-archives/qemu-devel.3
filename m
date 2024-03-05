Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C084CC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTcs-0001an-3u; Tue, 05 Mar 2024 07:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcb-0001Rr-Cd
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcY-0001Bz-VG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:13 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412eddd14b9so3213705e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640608; x=1710245408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZN0Cc6U7kZmDYYmwDnkR5eJs9jrLVG4XEoadrQPyUk=;
 b=kfpgOXLnJNQAzZuByzuLYabru7PL1RCKr4GbiOtspygcx64QLp/QYLug0cABIYYInb
 Yx+k2iwuHaqfSDxq44p1M1/zDHiqpNLdZEASJRPSxVW/eaKV6ETE7Rhux3GqpyHxdq8J
 dMTgAmqRREvbTaNQBjWVX+SLTsjFxZdyMy4Y2MLnbrvRmGSJzlN2gPRWfmxtGFcV3xzw
 jH/eRQcGCJ5c0UbSUEVxCCvaxKVkgjIMFjEjOLmXKbdW4ZxnhFkJquEq5xgf/rNpWj3E
 4yujLsS9sViVMEdbSeufl+de4LQw6/q2OpVZ0wzdwT/MBgEU0yVL+LTZS9nNfXmZhT4k
 j7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640608; x=1710245408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZN0Cc6U7kZmDYYmwDnkR5eJs9jrLVG4XEoadrQPyUk=;
 b=Fk8poJSlzrk3mvVhDKTvbO7vDdCtEOIt0fWy7m8S1IbcV/w7zNJiB4Aqjf4KblfqFo
 q9m+8Ja94hu1qWlSpm7ypNV4PEPX54Wa/bV3zbKf6iuSG0GJt+PvQqmfTpuTMUeUUrbv
 8EW6nVHd2aOO5eFg02iU85n01gzp+VQtO5PtVnH6W0p1dehcawZC7jgrW7ShOYjDSK+b
 1eoKaS50uE2wKpxpnyLha0L6SX36mZ9k9oTkutHJ3yy8Nvzh4aJN8gDk3swlKiyynOv5
 95Guh5lyTxx+thdCcwdSPD9+gvrwtfhJB0i0JAq9O7EL3pV35VOGbeYlDGHQtBmhBSAb
 wA5Q==
X-Gm-Message-State: AOJu0Yz3aL/tfNrhqX9ohayl1s7eF30AXrD8tubxoMY3LD0VZRPd6Mya
 jLEsKDi5w+jYcc/JieSOWKdcgO/1heVzHsoAtCSWxWsdBC01Mu78xUGJVo40aX8=
X-Google-Smtp-Source: AGHT+IH/W+ykW1GNkMl2JLVL3L6gE85bzXmXTMA16C/kgMcjWXhBlpstz70b2VrLWp+WgQcxWy/g/w==
X-Received: by 2002:a05:600c:4e0c:b0:412:eddd:12c2 with SMTP id
 b12-20020a05600c4e0c00b00412eddd12c2mr1009970wmq.6.1709640608336; 
 Tue, 05 Mar 2024 04:10:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r15-20020a05600c35cf00b00412e3717ae6sm6193958wmq.36.2024.03.05.04.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F1E45F8E5;
 Tue,  5 Mar 2024 12:10:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 01/29] tests: bump QOS_PATH_MAX_ELEMENT_SIZE again
Date: Tue,  5 Mar 2024 12:09:37 +0000
Message-Id: <20240305121005.3528075-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We "fixed" a bug with LTO builds with 100c459f194 (tests/qtest: bump
up QOS_PATH_MAX_ELEMENT_SIZE) but it seems it has triggered again.

The array is sized according to the maximum anticipated length of a
path on the graph. However, the worst case for a depth-first search is
to push all nodes on the graph. So it's not really LTO, it depends on
the ordering of the constructors.

Lets be more assertive raising QOS_PATH_MAX_ELEMENT_SIZE to make it go
away again.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1186 (again)
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240304193702.3195255-1-alex.bennee@linaro.org>
---
 tests/qtest/libqos/qgraph.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index 287022a67c1..1b5de02e7be 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -24,7 +24,7 @@
 #include "libqos-malloc.h"
 
 /* maximum path length */
-#define QOS_PATH_MAX_ELEMENT_SIZE 64
+#define QOS_PATH_MAX_ELEMENT_SIZE 128
 
 typedef struct QOSGraphObject QOSGraphObject;
 typedef struct QOSGraphNode QOSGraphNode;
-- 
2.39.2


