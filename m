Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7279D41D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkyz-0000dx-St; Thu, 11 Dec 2025 13:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyv-0000cL-VH
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyu-0005zr-Eb
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so4803825e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476094; x=1766080894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWQolvt16cWTZUVbyb/ELIWzQoLluK0PM6lqjSDIQio=;
 b=KVBbZ6dvgoYnZ66thjN6Ks8Mu5fIEgxypjBzlFB4SQ1MzFecjVFSXhQATJtPnxrVE6
 m+1l9yIcmR3QtnASlPPaJXTQn3qub7l4f0l5/8Z4KXkQGUUZpuTxeCo1dyZUkfdbMbZh
 pbztibhaVEPaBQ+Jjjre+2ltIyIUox76CtOPXu86MKy9p2TMSVy1ZLH6cbPdDY7skh4E
 c3iVLsYSV+DwtvFbgBKTGWg9cbaKJvussRGFNFhz2No326vLk2h3/+2+gVWY8vR2qvru
 qFqlpgXfKNssPJx9NJlbhV71QGpl7wdf3RgrIbgSlpL1azpKNl1BCmzzOqO0EmFVSIwz
 uYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476094; x=1766080894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cWQolvt16cWTZUVbyb/ELIWzQoLluK0PM6lqjSDIQio=;
 b=VDOpxPiQXTD6WpQPsc3wlO17FsF1pdgAuA+UvHD2hU0tbQIOjLS2aOfsntBZFZBLPu
 BkcwSm1Z3R5oZAx9gZrDWud7aZfePrUeuTeJV9POO1XRQg8f6mH1yqoKPrMbf8hpMhbf
 lCzsDh0wp3OrIm7Lfr10CeEruKuBgcq6yiiLQTLZ1/JriU3FBybwFfZLpw6PN2idUTP+
 FqNQwEtX54V/KhDC36QueY3BeIDpVizobxiwRU+XpsXOZ+RdaSjxYOoDHUAbO2xk+q7d
 vcSIsMDyAZn2MlUJ15Pv9yQZU2Ldw2n01Fep9nH6isViG8rQ7kalkTqoFcxp/eSYkTcw
 4x+w==
X-Gm-Message-State: AOJu0Yyn6k9YRbVv/Z2AOsXIvQ8KC28/m8KpS/aO/lCGI90hLRd0Eaqa
 kLTAS315PjC8k44qXQVf91GN6sTvwoKBQXOqX+XWnp9uTNwq5Bw/aQUpigZ4uw4fsDo=
X-Gm-Gg: AY/fxX540+LK9lRhUez625k0tSiX9g7bgwFbaRWhncu0SRLgS7/CyWx2lNDUIaDwV0p
 swjV7qBfoy5od9dqh1SlVFbwKg6qd7l80jmIn9hn5Q8KS6blNpN4i1e5oQ88ZtIU+5dhFHn8bXi
 5hFgLrHxaAY/CH32sapqm+sqNiMYO4r6sP9pV0W2k+sXUi6YNd585YoTzxSFvrD5gWz/NfOI/Gt
 eZRNAbq7cvMDHnHlJTPjevDwCUW5TAN4r2R5IHSymRepu3W8j9dWGLvSxGuHSjj+8e0y8r5Ojec
 MX22cNLUTK2vRWO5+cV800CYElYCOpADn0TRbegf2h6mAYwB0ELB3AhQkvYI+MlKe1thto1NC+b
 vx5l5444kxIvfPb8YtiB2jF+5bvXUiy49aHHGRC79Z+US2emD4PbUrSbr1e71TqVwbn8E+oaVgs
 O105TWwQqLewama8LqY7vntg==
X-Google-Smtp-Source: AGHT+IHwJ+i4OYZzT+YvN8YtMYtwn/SB5NPWYvtbE+Eg/70C4vzBzDaLSYFIf5T3mFlQ58HI+UMEtg==
X-Received: by 2002:a05:600c:3f0f:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-47a8384333fmr68800735e9.22.1765476094429; 
 Thu, 11 Dec 2025 10:01:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89dac074sm45577045e9.8.2025.12.11.10.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C07F95F87D;
 Thu, 11 Dec 2025 18:01:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 2/9] MAINTAINERS: fix libvirt entry
Date: Thu, 11 Dec 2025 18:01:25 +0000
Message-ID: <20251211180132.3186564-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

We have a particular tag for lists so lets use it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05b644cfc9b..a3fdc4ca911 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4466,7 +4466,7 @@ F: gitdm.config
 F: contrib/gitdm/*
 
 Incompatible changes
-R: devel@lists.libvirt.org
+L: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
 Build System
-- 
2.47.3


