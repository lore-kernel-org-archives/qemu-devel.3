Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9AEC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRc1-0004NJ-Gj; Mon, 29 Jul 2024 10:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbz-0004CJ-5Q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:31 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbr-0008PA-Uq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:30 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso653652166b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264262; x=1722869062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GENiq4e8KZQrz58joiPbir+V04pOx1NyhbMnGqm72qs=;
 b=TnCSR4Md/GxcZyni38dY5d2R1F1Y8UPR2aZp3JYXwZDsdNs1xu75Ulqi2/EWkOXYG8
 RrX7cFplt30ozV/M7BBllGr1bErmZQ2f8Dbwhr7aPC3LggphUS+oIW0U9HmWy7gamASi
 4Gtylewpt/nyX2xLcuWSC7EAY/QtMOjKfins9Td5760Go5+lGwe+Kxpl2/a1B/5kWd7E
 udNrf9zIVLYxsukE0sHd7r+vHJoGULnePrJjn6sBZICzi0urFN6JReaPa69ig9muVNc6
 G4BA1ncwzpcXESjNY/G7K2dmT0FwV4lGRbVO14lhUrilZmRVz7d9lYxvx4plp+zLZIWQ
 IPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264262; x=1722869062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GENiq4e8KZQrz58joiPbir+V04pOx1NyhbMnGqm72qs=;
 b=ClIWLbP0MZIW4Vyu4NLT72ntirZQIGo6Xt3G/I1/Qp51ftHua28FhChPEq+soB5evs
 NWSL+89EA9zT+dEahqhB/4HrJ2V6i3gppkr02aHa7BCNXbcXsAFLRXJayn9WJV+uLriX
 PCOWCvwf1/8SMui4QAofzPJ1LvsmIKcFVz02a8lgFO5vHiWyLlBUpdtrz5kVgM15O8hd
 O9YV11zpIpuGzgynVHLERtt02wfk4tfOEJkiopUgeRw+evIIFaO5Ryjl95SNTMofAHdY
 mZmoo35JobyGqijccwPJOZCZaInjOd0KNV0zW+5nmSgmYJ7s6Kj0MUTzSy3NDJX4P4d5
 GgHg==
X-Gm-Message-State: AOJu0Yxlwu++2LkwGal/80fR7UL/IjfEXckWuzwBuvw++CaLLjdfQwMc
 L9a9LeFrRCK77/r5rLbp/BqjZuqThYltFPdQKij2Lq0pMJClba6qn90ElNgpqA0=
X-Google-Smtp-Source: AGHT+IG0/8LbXJz3R5yJW31iuocEeDzsi0u8V4yfCpH41bAtspf5nJ+467kKd1hi8/985d+hriSNzQ==
X-Received: by 2002:a17:907:7e9f:b0:a77:ce4c:8c9c with SMTP id
 a640c23a62f3a-a7d3f85b7b6mr879809966b.8.1722264261746; 
 Mon, 29 Jul 2024 07:44:21 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4de85sm515866566b.52.2024.07.29.07.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4C765FA06;
 Mon, 29 Jul 2024 15:44:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 07/14] docs/devel: document how to run individual TCG tests
Date: Mon, 29 Jul 2024 15:44:07 +0100
Message-Id: <20240729144414.830369-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Since 6f6ca067d2 (tests/tcg: add some help output for running
individual tests) we made it easier to run individual tests for a
given architecture. Lets reference that in the developer
documentation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index b984c5dd26..af73d3d64f 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1490,6 +1490,19 @@ And run with::
 Adding ``V=1`` to the invocation will show the details of how to
 invoke QEMU for the test which is useful for debugging tests.
 
+Running individual tests
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Tests can also be run directly from the test build directory. If you
+run ``make help`` from the test build directory you will get a list of
+all the tests that can be run. Please note that same binaries are used
+in multiple tests, for example::
+
+  make run-plugin-test-mmap-with-libinline.so
+
+will run the mmap test with the ``libinline.so`` TCG plugin. The
+gdbstub tests also re-use the test binaries but while exercising gdb.
+
 TCG test dependencies
 ~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.39.2


