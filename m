Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A94C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWBO-0007p3-Lj; Thu, 01 Feb 2024 07:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBM-0007nU-QQ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:40 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBK-0002AQ-AL
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:40 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51124d43943so1279335e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706790516; x=1707395316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7ej3O0CatCEUFzw6u9SlCujsXb/1bH6cTaIS9kjyEM=;
 b=DcJVJsNwB8DCM9XbjtWJUjtpTSJKAN4jxMh5Hu6Qx94XqnfmPWI5EqqbGGbv4bdS+Z
 4jTPpIT0sDQnbaT1gwJ1aVVsQkPg4rQ+rJ6vGVDP1ZToqA+ETnu27MOI2YJVQXLkHAx2
 u3MOoN/z7gO7LWAWJj231bTdP0+qTAyXb7BASbgjhSDbFkZCVMKl6AIyK5oTrrXbV3GO
 RUwTcacYKSw0/tW8nVmWi6UUQcEDMLjse5Kixaaz2EmfQGt3J/VDbYU14Ba217S/2Mwb
 3qbPeF/iNtkFvhyjjHd+lBCem9VKHcYytyggtyqDv1HZWnxx5E3XlXGTHtf4mc60eRTw
 qIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706790516; x=1707395316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7ej3O0CatCEUFzw6u9SlCujsXb/1bH6cTaIS9kjyEM=;
 b=LzzEkuymR+lc2mtHi3WwG49E0vQ4N+Y2sz8FBrhylNoje+0sFeRKe8RmHajtFYKBMO
 Hynxt0qJgmstvyzYvN0N77t/d8gmsh3CdCdkOeSmdDUbaPZTy9jMrYdJbSPRCHEpg3Ac
 RC1Hl+WQo4sBu6oQe8svMJrXHNBlnHTz67sRbDOj5EqpU5HIDLxRrxZDT5CXHW2mryyj
 +paEPvbIVL95EnFReG4FEis4CD8l4K4NIgvPZmg+mTPYCZkI5SvYU30QR+dxLk8S/fbV
 eKZ3w3IcGv2ss+oYMU1UDPnGK2j6NGGnGSFq+C650sNh1bxQJn5uk7T51CkgQo8LnYVA
 Ph1g==
X-Gm-Message-State: AOJu0YxVp2QuBzuzGwpJiBDzq4U79blWNh3T/4f5OpUlxmz6psIJQVHo
 XYtG2B+mRZq+CYaZe1eKN/XyJktW5G4x5ALjHroRdGpcTdE0k7B1HbErXwXVzXs=
X-Google-Smtp-Source: AGHT+IHP0mABYouNTu71cKwDBRpd2QRAo8oLlojZlhwluTRNbtk02YRAxjLwNLev3VJghPf6bUW5AQ==
X-Received: by 2002:a05:6512:3108:b0:50e:7410:d5b0 with SMTP id
 n8-20020a056512310800b0050e7410d5b0mr1823269lfb.28.1706790516272; 
 Thu, 01 Feb 2024 04:28:36 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUqHmfQR05i1hUXpvu6XJ3nk3m+oD1xBJvBqXZTlf9ELO0FIzgYSIGYk2juoJHsriUZdemPFUMcsxblSldot1XjoGjQYlTEj9/cHmz1yyPhENYnoVornVoJews+UxIeaV6/UpePqE8fhlFLGZ/6IEJqnWsnxhfhi73dJIm48/qjQABeFO7BajwCy3VNFbJ6SaaFjol5GDoBU5KBkpFmfO3in53/f386MFPuqx5W6Q3xwDdguIKp4a0gwjO3g0Z8rKtLd/5Wppx/1LMLloBJSD/eXkY9GYF9XUurLbeJ8p0MFmChruyxjebOIMShFLr2gpZBW/67tWCgG9120qMIfxR9OE1y/sq7IqukHBcjy7XS/Tk+8cSlWbFGcysVnDHgZOQ/f9JUx4a6dw8PRn8n6wpfyKieCQpB9mzW500GQsf4L6rNN72LDLxcKUcaLr1uoPKHDM5cULnvpr4KcsrRxZwVnqDLujLqX9ePCzITrno6abjzt9kDmoBJT0irZgl1ui1DVSB6qJrgaRoRAIuAN/MJZry4wzHEbjJg/QNiJLQMHZKftyF28MjAYbxsFG+Q1z6hlW6Tvq8OCmbUaXs83FA4NQQWwnu10ldK8J9OWOp/sCx394tMNv01Ax9+q1fcMGuFncu/prbRhJ+KNRVOc9776KW3e9OOalrM9IodriOvzhAhSKQpVYy17EyfW2JuxPAvkA==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 vh12-20020a170907d38c00b00a3687cde34asm1335366ejc.5.2024.02.01.04.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:28:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 761A65F9DA;
 Thu,  1 Feb 2024 12:28:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Rabin Vincent <rabinv@axis.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Subject: [PATCH 2/5] docs: mark CRIS support as deprecated
Date: Thu,  1 Feb 2024 12:28:32 +0000
Message-Id: <20240201122835.1712347-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201122835.1712347-1-alex.bennee@linaro.org>
References: <20240201122835.1712347-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

This might be premature but while streamling the avocado tests I
realised the only tests we have are "check-tcg" ones. The aging
fedora-criss-cross image works well enough for developers but can't be
used in CI as we need supported build platforms to build QEMU.

Does this mean the writing is on the wall for this architecture?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Rabin Vincent <rabinv@axis.com>
Cc: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20230925144854.1872513-5-alex.bennee@linaro.org>
---
 docs/about/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d4492b94604..82922476d72 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -183,6 +183,14 @@ Nios II CPU (since 8.2)
 The Nios II architecture is orphan. The ``nios2`` guest CPU support is
 deprecated and will be removed in a future version of QEMU.
 
+CRIS CPU architecture (since 9.0)
+'''''''''''''''''''''''''''''''''
+
+The CRIS architecture was pulled from Linux in 4.17 and the compiler
+is no longer packaged in any distro making it harder to run the
+``check-tcg`` tests. Unless we can improve the testing situation there
+is a chance the code will bitrot without anyone noticing.
+
 
 System emulator machines
 ------------------------
-- 
2.39.2


