Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3AECCD185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66IC-0002Vq-H1; Tue, 07 Oct 2025 07:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I9-0002VJ-Ic
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I4-0001J3-Cd
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso40542245e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838130; x=1760442930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfKzT3g7Sn7qm7b/Z3n563XJAu3grg1Gx+XkESNMRc8=;
 b=K0tUye3sP6qw+QpvMS0Wn++OAOwNX2JNIbLfLLI/1vVA0zQfcuqFEJl07FRl9Bv0BD
 ZN+YDmXIBohyM1oLQZiEHGZnnP91Xw6QgfbliVlQ64pl2HctEwr6ODet8XI1b8cPsz/Q
 mhOO49kyKm9G+ZOniRRxzqKdryQkz97Tp3Tc0xlyG9Y905jkkdDr09yEU2LZi1lWKymP
 MZ16jQ61RC/3T7F/CAiZS7HzgugstsZbTVBtkOuqToKG4zCf+1kPriEtfVh1WQIm8fmh
 wST90HR/xDw9QK/WRIoZpgT+1I04dg7P2p85N5WtahmKv8PnBzg8el6DGeNIyo+T9ZVk
 dVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838130; x=1760442930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfKzT3g7Sn7qm7b/Z3n563XJAu3grg1Gx+XkESNMRc8=;
 b=CnOqRtey1xdZjEIroMZUHHd42M3camjoGrwOaOXnMuvIjW4xJU7h6QW0WJLVyywmRb
 QTNH1jT0kbyvHvQjxsXjDhLkPw3t3tCFsdrSSTNZcLjUfOyQlasce7Fep6cPzIW5oEUX
 RiVYfby3QXyVhUyKnqRISCncZyWXmVd7qhtROLgIfbfJnelxvjPvDVFMvYokXNnkrqKI
 4MBpEyaXlaS0Ay/ku2N0xHHQp1NjTDceBf2h6gBBsWdPGnkFhuNR1rQjPGd/1aAUNz6e
 B29mj7GJ4bkyMjHCkPJ4+H/ttky4E2jGtYAD19jzWH8YniNCbE9odxUG2AnxKKFM7pLi
 P+KA==
X-Gm-Message-State: AOJu0Yz7cpCJ/d72n+cdcTxMcQsqtJddLAPwD7HLrapYONEyVr2pExFn
 Jde17hvG4Ejpm8PG6KvA4jIUQfekMDqJALIYHwt7/vNjfN+g+J9E+cm1Xvuq4yg1PwU=
X-Gm-Gg: ASbGncs2Qzk5FdnLQtcJnrHQ/lvETU9b1yBtRXJRmafEx2eGP4TqdEgMgerye8IhgDd
 RJOtzSC2fYKdKhGjF49JISje2pL6qudyPKtVY2hm2TH1i5qRHBfOd/A+JaTl4n8h4FAEUn8qlFx
 crELHiaOu7drXTqt2SAjnb75N/KdO7neVWtD4SgVNaXe7820UbeD8zVYDXhHnqUroi6KzDwhJT+
 QZVHMHJJrUQJIWzncFTwKW5LdV7sUaK7wQC5FVby0/U/fK+3iQlaLx7GXvIlQ3N3yCeGuyzYB+T
 1C/oJjBjEILQaCU9M2kcrHSDtuSAz3EsvT6UvVSptuj/fblXes9vhyho2rKmQSN7K4i+jA8QEz7
 3rXqOkm3KypnHJGXtaCJx4pT1DL+yljliwVtZf0/wrZRm4RczdX0=
X-Google-Smtp-Source: AGHT+IE8D0gOVtcXzNM933+TuUEyd/ukvbijt2lbFY5cmEuyR3ISzu0yNdz9iazXlIsHTs5RsQSvKg==
X-Received: by 2002:a05:600c:1f16:b0:46e:345d:dfde with SMTP id
 5b1f17b1804b1-46fa81cd1e1mr4558435e9.16.1759838129726; 
 Tue, 07 Oct 2025 04:55:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a25dbcsm323942845e9.19.2025.10.07.04.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CCA85F8B0;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/17] .gitmodules: restore qemu-project mirror of u-boot
Date: Tue,  7 Oct 2025 12:55:10 +0100
Message-ID: <20251007115525.1998643-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

With this change also reference the upstream repo.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20251001170947.2769296-3-alex.bennee@linaro.org>

diff --git a/.gitmodules b/.gitmodules
index e27dfe8c2c1..e51abe65258 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -15,7 +15,8 @@
 	url = https://gitlab.com/qemu-project/qemu-palcode.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
-	url = https://gitlab.com/qemu-project-mirrors/u-boot.git
+        # upstream is https://github.com/u-boot/u-boot
+	url = https://gitlab.com/qemu-project/u-boot.git
 [submodule "roms/skiboot"]
 	path = roms/skiboot
 	url = https://gitlab.com/qemu-project/skiboot.git
-- 
2.47.3


