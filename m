Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A9FD0EE0A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNwAJ-000639-HK; Tue, 25 Nov 2025 11:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNwAH-00061Q-N3
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:45:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNwAF-0001Ir-N6
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:45:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso24168135e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764089114; x=1764693914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RNaUZdRbiUXVUOL7MEdGN1nTKnzoXhTzml5g0OyHGvI=;
 b=EJhKnOHjuNcdQ0NkvQS01zFi9IuPMUTr1xMRrF/YAzsbZLvNTXa8Nb+pb/GyCCF5z+
 BX82Se63r/8Z1bYTrt1ZQDReCuZeCgHIkKt/8hxitzYMZSqHJCNgq73FZGXwGdS4rvZE
 VQfMcQ20uaQLUY7DfWc6JZCnRwYtCtJZ/rEtFR42ffrgSxEOt7SqFoddshSw1dR9BmFj
 cBrRCCAbl5EBFiqjul3YWJRCoptpwXELBaW8Hk0R4KlYpL09hSSnCavZcIO3un38pkmR
 3fsOgX576V/QYRXnbzEcHz+YqA4/xy3LQKz00Na5rvWujk40aCTfIA4n520a9N58tRQy
 B2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764089114; x=1764693914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNaUZdRbiUXVUOL7MEdGN1nTKnzoXhTzml5g0OyHGvI=;
 b=F1vyweGBIUPLCbWgw944nwYSCWZ/GCRFFJhC+DKIzdXyKB6pwxOp1gnZAyReIw0Xdq
 2kdByptjeyQhbp4SMjzZGsmI+yr7IhzfA59tjOU6mqKRnltov3BJ4sjfjt2ZIEGmFKiU
 2PT85Jorc3Ae2PQvcGQtZ+T7TOH9zVZopGgkR8ZaiNSEYHjnVhNvb8A/FXkuaL6RvjzL
 y/A56uvhC5VQN7/C94HcfWdi3mwORNAerFlT51Jgj1goLv4dZLpFGrLMBZwO2Gch70Wj
 CcRxq4fEcd8OPwiQaT/20KH31/DL1/STq27tJamj5t9C2ZwBcGXbtVGtpTaYdFHEFfrc
 ItFQ==
X-Gm-Message-State: AOJu0YzjedGrfayOTeoaOpANRXGbkYeD955EFnf3dFLzJFxoHYYc0d1H
 mbIZFMsxueEA5hVM8b2KRvbZ3DwsLNIGlPJBvQU6Kbkj/lPyQsL4DdPRXpCLQG0wzp4TiMBQmVW
 apnMp
X-Gm-Gg: ASbGncvQ+QcbjQi4SJOG9SZeN5jl86kDVzPOk2y8AN/P/OmEZZeKH4HRSpvIcZY9HUy
 V476ETYHi7noFTKytsR+ARITHkJVP8SfWKNQKouZJNHgA2FWy8vAmZArBM8PA7EUSpIhWBsf7Bk
 1VzP2RP3tvucDaa3lg2XKo2/bSL717S+KFWcyos6NIrZu7M68GDMx9mDO0MmxcnG+KOrLMZ3lVf
 rU172R7+mhiOqFR7S/g5xGgnh2FJoi/0GXy8+u2+xAkkg6/Lef1aFX5oolt1Vz4C1sNONpBxYpD
 Ej+FE2uhJp0N74u8mZ2I3zKcQic4gg/Ohohv5iVy6JAUG8zFXVtsamZmmHqa0yejCqwcHd0bwA7
 InZOJkISeUejOpSIooxgnfWG/vNUe4LSC/NkXOf0IDbkTfsgTcEbmYhAO98oyc1ZskYH9MElqJd
 Owp8FtaeLC3Ve7623b
X-Google-Smtp-Source: AGHT+IHPs26/fslIQayMwUzISbd7IE057PZZZ9g0YociFR+2oVE2WX/G6DKGwoF3EidRAfGjJmF1SQ==
X-Received: by 2002:a05:600c:3545:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47904ac3ca4mr31116595e9.1.1764089113875; 
 Tue, 25 Nov 2025 08:45:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790530f0a4sm19740845e9.8.2025.11.25.08.45.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 08:45:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/devel: Update URL for make-pullreq script
Date: Tue, 25 Nov 2025 16:45:11 +0000
Message-ID: <20251125164511.255550-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In the submitting-a-pull-request docs, we have a link to the
make-pullreq script which might be useful for maintainers.  The
canonical git repo for this script has moved; update the link.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Cc'd stable because the old URL is likely to stop working soon
---
 docs/devel/submitting-a-pull-request.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/submitting-a-pull-request.rst b/docs/devel/submitting-a-pull-request.rst
index a4cd7ebbb6a..e7d00808782 100644
--- a/docs/devel/submitting-a-pull-request.rst
+++ b/docs/devel/submitting-a-pull-request.rst
@@ -67,7 +67,7 @@ subject tag is "PULL SUBSYSTEM s390/block/whatever" rather than just
 pull requests that should be applied to master.
 
 You might be interested in the `make-pullreq
-<https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/make-pullreq>`__
+<https://gitlab.com/pm215/misc-scripts/-/blob/master/make-pullreq>`__
 script which automates some of this process for you and includes a few
 sanity checks. Note that you must edit it to configure it suitably for
 your local situation!
-- 
2.43.0


