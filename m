Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E71CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxA-00022a-6f; Fri, 29 May 2026 01:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwh-0001rJ-Go
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwf-00026A-Sr
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso116071715e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033184; x=1780637984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6dV6dZVmexFcfWzAjzAvIPz/SBt8gUYSyVfzLUrKfo=;
 b=oSJZoHIuC9h5l02yqJ38wqe2sLG5MMQ31cYMfyupswpRclXcVTpnsbBXz2UFpry5NN
 jUug6/rhZFgBFbqMAPM4eicPgHsOO/nrIEaf9EQKcZaTGyGWmVk5OHu4jDhkobFF3nJY
 ShJe+tbAbr0X3wRHrUJEgtapgM0RACUJSdqi25I2brL3R4krh2orjdDLzGCxnd0kr30+
 IzGHRXK321LDxIr0l65WApCSN5cTNgYh6EXeCbsg6MZqnZdOqvtiXRiah5NnHyaXzhDH
 qbObTZh5dJRJjYTfRKCfy44aJq1oq3u3Xe4Td/cqyVWQtLAdFKXz3WX9qq2IPMa9O9Gd
 cTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033184; x=1780637984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f6dV6dZVmexFcfWzAjzAvIPz/SBt8gUYSyVfzLUrKfo=;
 b=Jj3LH/Wfq8ZNB7tcPrIA3qQ9S/1UPmpTG6YZSzkPSjS39sZY77D3g44AoV5qYldR/j
 0iZDJzKE2IOW9LKBp4EspIaOfB0SsE22teAbovXqv8LMY3nAbjaEG72s0kU0Sw3gxhpM
 Otjy8TzcEyrIDAIZwdZhgmLD8DXJkNdLlYpnvolkyJFUDiCYpEBSaIVUWGsORpRVm1C5
 C1wPCp/0N8p/lxn+mZk9R+vI11f86q3+lfOXUwqaX+6TfNoysrybgDpoDB5bc2U+eaKV
 bXOknYgUSwYoTCYYUlL0WTN3aZFZZahbBlnqehZOsxACGJT0eBFbAFxyGUizZvUn9ID6
 fwAQ==
X-Gm-Message-State: AOJu0YyC568ZulGxz2i9l6rIcw4fAL2auHWdggwZTQljv6YY2ZB08EUD
 SvKqdJiwZRjQQgGYiROKIVpwBANoPmoS5JDm5tLT2qKVRVOm0jghOAle6VuV7V4AW1w=
X-Gm-Gg: Acq92OFbUzRqC/e7oAHucFEwJXnXhyPRLTSNFYMqzLi+zcm+S8iJ3YWBeccq1WhOJto
 knA9wiWFM91Ng9jfRcoNKTV9lWVFUVilHDUG4YvF+N6wsyEOT6xADYVZlWgEON7ybjdubb2qQEV
 KwirzfeIrcrH4KCY36xmq6o4b+HDljzRuaNeIskY5rtdJh7u/mxIbjzIXYJ4JU/EjVJ42PZZIoA
 dgFTP7M/6J9rVEliWAmWbah9uWQ/DE2h+6ltHbxr420M8ZCeJCUJ7ZIOHqFdDQUoUAE27TIFnvw
 iK5V4p0+R5w6z/NeGCminYLa/szaw9sqYac57w6cWkZi+1EgzmWT280SDxNTEFHOwRTUJLMecGy
 Kzf6f3bh0oHDl+HEjGOZdcvYNuJRvNSDHl2wnQBQufFbhuSLSB7EEhRuvBLohkR51+Mqx9AlQf7
 IYbg+3mAyc1kjav8NADeSS9W2PbiKJlDF++A==
X-Received: by 2002:a7b:c4d7:0:b0:48f:d1c0:5cd3 with SMTP id
 5b1f17b1804b1-4909c092ffdmr13820335e9.13.1780033184369; 
 Thu, 28 May 2026 22:39:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909caa7faasm21817395e9.11.2026.05.28.22.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A0FE60EDF;
 Fri, 29 May 2026 06:39:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 12/13] MAINTAINERS: Cover debian-tricore-cross.docker with
 TriCore section
Date: Fri, 29 May 2026 06:39:30 +0100
Message-ID: <20260529053931.283970-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-5-philmd@linaro.org>
Message-ID: <20260526110243.470002-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 13894537aba..225bc5e7910 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -458,6 +458,7 @@ S: Orphan
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
+F: tests/docker/dockerfiles/debian-tricore-cross.docker
 F: tests/tcg/tricore/
 
 Multiarch Linux User Tests
-- 
2.47.3


