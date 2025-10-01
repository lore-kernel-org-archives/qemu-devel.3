Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513EDCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v40La-0007y4-Kz; Wed, 01 Oct 2025 13:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40LN-0007p5-Qm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:10:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40L2-00034S-3l
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:10:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-421851bca51so32637f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759338590; x=1759943390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5B475mjKjnL257VDfD4CKn0s8pONgni7x0CEPr+OQPI=;
 b=AmzLP+twIaiSCddMFLtygcrXZ238rDnfVbzUVRlWYo8ixS0O4lNJ5pa0UNnKiO03p9
 l8rj2zyHBAvhPzoOwyw5yrz9dF5eNqzz1gyD9Nj7i4mVGGk4PertwPqyfLn+9KrmvdhK
 kQXLagVlH/wis+I3NCd5LDUjMdVLUWdDHLzJvaj8eDOGFMKrhYalLQ/MCxNbKJUFncji
 ZV4Ob6DQiwpjVetIuD4DJbVi4fhqR/UnnyUHr+XCVIdLqtTw048wSKyd4272tkHz9ugx
 zBMSmS9hE5qHemfi8ZJteWDhR/cF7kECZHWgL+op5UmdZXMu5njkQVpoLHfWBPjEe+oo
 NEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759338590; x=1759943390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5B475mjKjnL257VDfD4CKn0s8pONgni7x0CEPr+OQPI=;
 b=Jj8LsNk+BIeImz4s/npgKwVzO3n9PDnhyo+/+ptNjB0ogdF7onRGSY2hPKC/NqwBMN
 q7d+fdgscmYuNbEDdZEhE+38cAJHTqgrut1RQk2crAkYa1pKbLafjWJsuLvIhxRPe1jj
 QwJj+KhQur8+uiYJQsO8SNKgoS4BjF/RUUXEPUs17/eN4Qqs6kOvHw04Hm57fxtxrkuU
 X5Fre+w0MegUousOiBJqvpNVSCadZvcy6wMXZ7DtPPNU2VHG+t5gy2sq9rRwbINU5UF6
 S/HwAvYYXR5xdAYCj3ZxOOgmR1Kj3R+rXUqHBk3MxXVp/uFl0QgbjL/Jezp0Hc9VSGrA
 bMBQ==
X-Gm-Message-State: AOJu0Yx+/c9peEY51Xg0e0dQnvD7UfxVLK1StLQJ/omCgC1xPPpbaEQH
 pZ6UQym+wc8Lq+iMrTdAPVBvMjnE5kyDNvgVf/TzpU/qFtUudJJMS+ruGEk+vuXOXgM=
X-Gm-Gg: ASbGnct2yq5uf/xfxANbyfPXkrOsE6QMpWVdwcywly1uIb7/3Ie1ZIvv58lV5VXqk2h
 vYyIn6Fh8IBY1+szywH5aU4HPQjJ/iua94alALUojdR242fms6gRppAFwVtY1WJ729FwgGDEcan
 tn0C7p/DITna+oVn7agNcHvdGo+eNmQ7KN5rzC9Kk5jrbNuePyTI5iQ8m4b9dvCUt8H65jtjrWk
 92TBmCeYG+kUb0g0bhz7Dk9gZwyMA5ZnDODl+O49xuzSCG/tKuLwXb4ozNquoo9Fil+V9z0X+wk
 X19DvJN/ms0x8k2T2FHk2IulAuWpWjtJ3rRU2u5iTea3uvZCby9UPbScgDTPX7x1FeEjzb70BC1
 Y6CpNKF3bmnt89t015kBqQMfPYQucpkKwXE9EKROlwGRcT4A=
X-Google-Smtp-Source: AGHT+IGaFrJwAzfi1iDuklWuV5kOOr4isGuehvYhFnzuLStvk3OI9qDmME80uAv8VokIEjOUwKYzJg==
X-Received: by 2002:a05:6000:310d:b0:3eb:c276:a361 with SMTP id
 ffacd0b85a97d-4255781a55emr3360063f8f.54.1759338590204; 
 Wed, 01 Oct 2025 10:09:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41855fc661esm20270782f8f.45.2025.10.01.10.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 10:09:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A4D035F7DD;
 Wed, 01 Oct 2025 18:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/7] .gitmodules: restore qemu-project mirror of u-boot
Date: Wed,  1 Oct 2025 18:09:42 +0100
Message-ID: <20251001170947.2769296-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001170947.2769296-1-alex.bennee@linaro.org>
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

With this change also reference the upstream repo.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitmodules | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


