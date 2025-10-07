Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792B1CCA472
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Im-0002jS-9Q; Tue, 07 Oct 2025 07:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IO-0002XM-05
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IA-0001J7-0f
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so58171925e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838130; x=1760442930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUMZanu+fNDUlmwUPlkORZjFmvkzwi0xxbzJ7zLpfd8=;
 b=SeB49+VtU7hDNxTI9sQ2L89jw+7pU+VD/Kl3zi/nIaKWXcRNG0OWmH8QSFWD8jtjLW
 +gzfDAlBY57zlq5HiWuhWrIkAlDLDdMd52budato+ep9jQJvh53Z0SvthVkY7ueeDpHp
 Z/c5tronsVoCtio1hvDPjwYyTJrImeHn8Z/XbT8YMDocLFMjP1+SUMVf7E8Q4XfVoWF9
 fD8MtJs6s022VK/VmLU+SYwY/o54ACpM3nbYH+HS1mP/Pylh/dXZHqOJThGXTdeeKHy1
 uulVHgvONvXSUlMqNmtUbSv5cjz5KGT4BserDvEffjkIHedhwPbvmR6amnk7nzGP2bRX
 TYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838130; x=1760442930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUMZanu+fNDUlmwUPlkORZjFmvkzwi0xxbzJ7zLpfd8=;
 b=feWqgWpGa97kDQWW+xeJEAGOaoGifuQ3U9np2tAoTZ62GRdkaE0c4bw22mWsLvkb6G
 oOXEa09vrxiHnarQJ5UE5II3FmJlINzSDq/PKu5myr4FRxdylwCx7dibJNoFUYLA7Z1k
 0HhwJI1Dn1lWCo4tz25XDre0JqeSOpnH8j5cYl+bGYui4eoBx7jgPVc18CXxAaW/pZol
 q+qz7K4uXYm6Y+IMbjEK/bfOW19Kr6iQvsrqIT79oIYSDpKiAwqq5iaBf7b+PyrBtm+D
 HsQjfEw+VJnwelglkFWUxGtiHnGeyuqrtBuTcwbnXDD69TfGbRxytHQRW5eQUhFwfhTl
 0GVw==
X-Gm-Message-State: AOJu0Yw7hOWajzJKGP1urlg58KI6iUxhM+4eNTvh1t9qc2acuksc1OVY
 qF6432rJ306bXPrUr3SZHjN/D+3T/Nk5GDs+NwecdQQBs8CS5IL7Vu3vnnVc7srl6+s7hjlobqQ
 qBCgN
X-Gm-Gg: ASbGncsjRYyUUcbqx5fADiYCsqqGB1NuDzKBjsaxnixVkxMx3exm/0qM5DQpjlkJsp3
 fSWVJ9QBufWt3WHKN/MjnjfOAvuinTqVJZGadlUXwHsvSn6leY1pW4xD3dRhvgjRv4qWwB8u0uf
 IRTzjUFSDzT/qdoDg92MGaG7KAEikdO6ivtPqBPZDvR/JGJsQbIvZD8UEv8ZqqVJiSMwa/z2Qd9
 f8SqixQdJV7YmUVbNCrnpvRXKKYCOxXLfSLHBfHS/FLUCunY8d48Br4MJGGUt9iPEJid56VFBNS
 KKjlCB6bTFILxps5wH1Vc8BNxNxeUUadtyiUTehOibNylbfFWZ0o9ffSG6Ddp/0E2o292c0CXiz
 vFJiZ7M3aoYZaZf8QkLI8cfjSE/M/1JTjQvqmfwmqHoG4bMymQfg=
X-Google-Smtp-Source: AGHT+IG+NDIKAhaQgWX1QoCh3PJ0Sn/Z5H3bGK2aXEH1n1p7fZiSFn8pAk/su3yVCufivW15ElTvvw==
X-Received: by 2002:a05:600c:1384:b0:46e:4580:c6c5 with SMTP id
 5b1f17b1804b1-46e7115cac6mr90558025e9.35.1759838130475; 
 Tue, 07 Oct 2025 04:55:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e675b557fsm301406395e9.0.2025.10.07.04.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FF825FA33;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/17] .gitmodules: restore qemu-project mirror of
 u-boot-sam460ex
Date: Tue,  7 Oct 2025 12:55:11 +0100
Message-ID: <20251007115525.1998643-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
Message-ID: <20251001170947.2769296-4-alex.bennee@linaro.org>

diff --git a/.gitmodules b/.gitmodules
index e51abe65258..c307216d173 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -28,7 +28,8 @@
 	url = https://gitlab.com/qemu-project/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
-	url = https://gitlab.com/qemu-project-mirrors/u-boot-sam460ex.git
+        # upstream is https://github.com/zbalaton/u-boot-sam460ex
+	url = https://gitlab.com/qemu-project/u-boot-sam460ex.git
 [submodule "roms/edk2"]
 	path = roms/edk2
 	url = https://gitlab.com/qemu-project/edk2.git
-- 
2.47.3


