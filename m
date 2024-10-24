Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0D9CFA457
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uhZ-0002W5-SR; Thu, 24 Oct 2024 06:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uhW-0002VA-7A
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:04:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uhT-0004hc-NP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:04:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so615374f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729764254; x=1730369054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bDjSLop2+Mv88gsL28Dq0gY1HwGEOHZaaOiGIRGhO4=;
 b=aFBnmU1GJGmmX+ONiYx0nSwfmJyZnVEvqIfxmJV3ZPDYEuz/Ws5JyJVEAneU1lkBXb
 DzwraBsVC110h833WZ+vLK6po7aAynSkzY5HkFTg5wbLF4SN0wIV2QIs8moZW6GkpR2j
 jbg3y8cO0ZsJqRe6Y1PDgaUZmyU/HxSq2gNueXtHyKCbnv5khEGt2gwViU043OiFUs3E
 omI7Q3PZKZN3T98eo8lRZC/oHP4FHauWDJto65fhyIeWZLd75pwQUoPkFTQ89/qJtQCc
 hKYBwjECj9W66Sc6A8Om/+udmyMZPdVHQs48y+lgvEO/M4/lrMBRuB4GVqhZ+4NF4bLB
 mW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729764254; x=1730369054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bDjSLop2+Mv88gsL28Dq0gY1HwGEOHZaaOiGIRGhO4=;
 b=BBcAKzcfjO70AqpFmhoJC3qv5TalZPIOnzTrAR6OKDAaEMKAZiSVuAFl3tQgumpap8
 /iVcUj08Y9JMcdWkGhwhLBSY9e56XjbfUtPUaUuwXw/1w0aZSb9eXSHLRzpa9FyM9v8K
 NODZgZa5Xuo3PhJChYNzjZPl6xgZMDeU/A5vkwRnsey4kY8NTgzUR3BnaC0q9Nnp45NV
 qFzRRYRKQkS2+vJTOjIGDWCHFczv2RYqoFezFOeaG1YXbRBL1HZIBBmTLg3QKcUiRKaC
 ZRRUME67zPqgGGhlvgibLTQpeuEesXBqDvcsl3koonF9VNk5qXK68PnRJRPs2w/zX3JP
 a7GQ==
X-Gm-Message-State: AOJu0YwTDvwp1dqGgyoTs4603y+Xb0T9+aLaC1iKNcFXJwrCGZrWSPSU
 8n5+4k489+7y1tebPHXctarYRoM0nGXWr2JdtEEdE35fJ8/S6GHqA/0WYDTGX2Q=
X-Google-Smtp-Source: AGHT+IFjUxXUDvKTBNYDbMnyfVMcNwydMZOy8lY/C9qD3+uYIbolltXGmV6OCLOM8eVIK9SvDfaRRw==
X-Received: by 2002:a5d:4f84:0:b0:37d:3e6d:6a00 with SMTP id
 ffacd0b85a97d-37efcf84845mr4685390f8f.47.1729764253961; 
 Thu, 24 Oct 2024 03:04:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ebdsm603839766b.148.2024.10.24.03.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 03:04:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62EFD5FC11;
 Thu, 24 Oct 2024 10:56:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/17] MAINTAINERS: mention my plugins/next tree
Date: Thu, 24 Oct 2024 10:56:02 +0100
Message-Id: <20241024095603.1813285-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Make it easier to find where plugin patches are being staged.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-17-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 7eea7b7954..5b6c722a20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3708,6 +3708,7 @@ F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
+T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
 R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
-- 
2.39.5


