Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FB0D33994
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsQ-0005Zl-5E; Fri, 05 Dec 2025 11:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsB-0005VQ-EO
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:35 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs9-0005kQ-LV
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42e2e47be25so1244633f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952892; x=1765557692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTkoAjKCUBridh4kO1yTFB0m3sS2A7k4Ps41pTywrKU=;
 b=Fiz01AsZIWIvXiOyhwvTlfa22GwnCwqrAALQqWDb4OShLow9IZkrPQ3bhztRJyRcpT
 WfJJn30XKtrZUebQBpJThW9DmefukshDEeoR75vKVPFuVJCcOlEP+g3Nrn+f0M50b2/9
 5zut/99fsRmUtUYoteIpRFrD8z3Xl3vW25y3N7JjW/YOjoD6xhaq8ABhbAxGs0hJuDL6
 qkcwLfgZSPUW90jYpqM2QK+pXqjgEiYy0Yr2FD0Yvpw3dTuq3gjFQKXWGH3MBrlspXYi
 bCMH4zSzt1nPhQeMdw1oMQZT2EiD/hOO3r/WnJoB3RZkW5PIkAtUtCZcGmTD5/WGljXH
 4Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952892; x=1765557692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MTkoAjKCUBridh4kO1yTFB0m3sS2A7k4Ps41pTywrKU=;
 b=mruprTaYGOb7J6jii53EffxTmS+Rvd5iFLFgKXyfsNdIEg8jsS3Q4tH2Hc0eZVAEI0
 hPO1JqQ6JPDnzL/LYRWcNXNvLhLSkbp/bfaShF6/YKDgwRpTBjnQuOgH5v5NKODv2VEz
 RjpOFy/LzeLW7JSlhiQ+9ElU52vOlbV5LLhxmebQ1uggzHAUTT6Vxfol+zOxvNywRgSl
 P5GnC7BRY55z+0/L41XpTdpa35Ug2kU/hJ/BbX1CkE4sNUBkfTXRqAOENxPALexdv26T
 YDj3RoH0kYSAvrNL/K5ykVFpEcJuGb0g3ea/XwYXXOql9EXthHU8TUCr8twlm/5NueOS
 t+Kg==
X-Gm-Message-State: AOJu0YymhNFCZDOpCAIt/lPXUsKI89HF2skQX1YEv+KbPjuVD5a0VHB/
 g6gV6d69b1N2xkzc84HbZUCpblvlYV+jlb1BqNMC1qV1R35Ud8g7SmlgdkGJ1wGt4hg=
X-Gm-Gg: ASbGnct2p+1WMKnW3CICmgTJqldFWrhxQAmgeZ4XbBSMjVgsO3tvVphlI0nMWFsXnX3
 RiPHgzkZ0WguvbkXTgj6Jr0elJ+dy/cfFwtv5z4pQgX4W9Vig4W2PvXN6kgHvIxB8k7CQgHdm2F
 mYKRgTxTJpJVkDuA8AV1cLxJZVAP0H1uIb9p7+9qAj4aik5sGjNbrRFceTPPqp/UPX11XKPOyLs
 SqaALcrYst4w020rHwVWJoGWONCRZvwXGHJf12VmjkPZ1oDdk0/MgXMvIe8qvLmoPEmwEl4BUMN
 k5UOcJG9RxN9QfX3HCn2eMjaqUaE1yLqmyOGi3qWBstrm+tFqNj+n1pkA8TfmyZsO6lDa7EBvb5
 KWza0I6XlE0+eekgBF+lKdL1Z3Od98ODxZu0dA5Jqt9csqNKXS3JpLHMf/kutPAjM0aT6c1VvpG
 lEguSPWn2PCgg=
X-Google-Smtp-Source: AGHT+IE+eYARKQBbDqI+s9qzilPgfO+AwlcAV1nqeY8L280xPN3OaWlkILmDZbI49uzeD3c5nYApJw==
X-Received: by 2002:a05:6000:4383:b0:42b:3c8d:1936 with SMTP id
 ffacd0b85a97d-42f79804059mr8230759f8f.26.1764952891604; 
 Fri, 05 Dec 2025 08:41:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331e29sm9893343f8f.32.2025.12.05.08.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 885065F8FD;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/14] tests/lcitool: add bzip2 to the minimal dependency list
Date: Fri,  5 Dec 2025 16:41:17 +0000
Message-ID: <20251205164125.2122504-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

You cannot build any softmmu targets without it by default unless you
build with --disable-install-blobs.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251204194902.1340008-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
index 6bc232a1c3e..2a1ac51d402 100644
--- a/tests/lcitool/projects/qemu-minimal.yml
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -4,6 +4,7 @@ packages:
  - bash
  - bc
  - bison
+ - bzip2
  - ccache
  - findutils
  - flex
-- 
2.47.3


