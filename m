Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE094C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 03:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfu3e-00047k-H8; Thu, 29 Feb 2024 22:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rfu3Z-00046D-O1
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 22:59:34 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rfu3X-0005ed-Kt
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 22:59:33 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7dae66def19so575690241.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 19:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709265565; x=1709870365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=75zHrzd4FevTx04IkCTQBq243zMYl9sFxCVHF2/X44A=;
 b=U+PYHfxprmSSAYkstvzyqJlO9Djl9cfHgG6kU//3h4U+8xkLgANkbXv5ahQP0hB79i
 +LYztjsB8IrdYeJvcSsZU7I5hRbaHCODCVS7fyFXgECeDJ7wZ01UWxlm0wMvEF/u3uv2
 MG44UlPdqfTKBO3uqhnmSzFb9THeBkw5luCgChW6g9xmdSrbPD1Soir0V7AN/vkNTg8z
 B2Ojsm+V5PeE7UFsQ2Bc9jOA9HcpoU6MDO7UF/TzwvU4kbhPZUsN2+8GpRrmavLXublA
 mgPZFwb309ZlvG8eadpj7P2hAAOBXQDcefK/dH2LuYCI7j+zBtaxFQrZPeI556PH7cxb
 gHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709265565; x=1709870365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=75zHrzd4FevTx04IkCTQBq243zMYl9sFxCVHF2/X44A=;
 b=QgqofS3eOuSbdUY5PxbWoV5keNRg7CRGfvcQOjsm6R1xi5Vb2de7I6vy+PFssZ99LO
 Pn3hS9wtMyogHfslKYsnSVTVXJnHbm1PsURCIOC4VcWE1HIqeaCBytVrwAcIrCs6Iyh+
 lRm63GueEvtD5WHOmfLp6BOpvisOOsOMkv6OonG8Lu6xINwheXvdgDP1gkWMtShhxPnj
 biNJSfRoM7QmO65HSkg2BwMx01OA9URdSB7DfoDQSvwrBwA7PMPTI9fHbrG8n4hy4muY
 RcpcWgmyelai8cEeNZ/boJuvi3DIa7W8/bR+3z8rh4C9MywxSL+csuE7EiKeJsC/TXJB
 nkow==
X-Gm-Message-State: AOJu0Yxwre+8v6iIQ1XNwI0Kp4EbpKqYjOC0r783Gs3AAhAFTmygbZ8s
 0eMaxS9moIZ8dfCcwSz3PWYZ6xRA9M4TVPxITF5+A6r5qtMjgaZHzHJruywBxvLA1uspHcW5FDv
 N
X-Google-Smtp-Source: AGHT+IGJEvBVAVT8Fj3vqB7wQRNl73U/ZIOyjrWpJ6O9TmM7Ds9Co3sloSYgUZYBCCPDHl/iAgX6rQ==
X-Received: by 2002:a05:6102:9ab:b0:472:5ada:5ddb with SMTP id
 f11-20020a05610209ab00b004725ada5ddbmr277134vsb.28.1709265565443; 
 Thu, 29 Feb 2024 19:59:25 -0800 (PST)
Received: from n36-186-108.byted.org. ([130.44.212.90])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a165500b00787c6703539sm1296986qko.90.2024.02.29.19.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 19:59:25 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org,
	peterx@redhat.com,
	farosas@suse.de
Cc: hao.xiang@bytedance.com,
	Bryan Zhang <bryan.zhang@BYTEDANCE.COM>
Subject: [PATCH 0/2] *** Properly apply migration compression level
Date: Fri,  1 Mar 2024 03:58:59 +0000
Message-Id: <20240301035901.4006936-1-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bryan Zhang <bryan.zhang@BYTEDANCE.COM>

There is some glue code missing, such that the
`qmp_migrate_set_parameters` function does not properly update the
`multifd_zstd_level` and `multifd_zlib_level` parameters. This patch
adds the glue code and also adds some function calls to the existing
migration tests to make sure the set_parameters function gets tested.

Bryan Zhang (2):
  migration: Properly apply migration compression level parameters
  tests/migration: Set compression level in migration tests

 migration/options.c          | 12 ++++++++++++
 tests/qtest/migration-test.c | 10 ++++++++++
 2 files changed, 22 insertions(+)

-- 
2.30.2


