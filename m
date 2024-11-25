Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7ADD58D5E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFau1-00045N-B9; Mon, 25 Nov 2024 10:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatv-000430-Qq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:23 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatq-0001nM-T4
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:23 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso5064039e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548077; x=1733152877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/9NmZeUsPKrEXQM/VYYoqE8OEZ3mgV8GxzNtjGupA8=;
 b=eMFpTKkghoEv/F514X7XKCb0t//39jUVOe1J8Rd+qyOHRDE+YSVnR2GsKNFjSKUQVh
 qn5sdRNY2nsgYrCTbtkT5IwqO1Bjx8JXeHvqi0pHYPee2E/cQY1eblfm9Uwa6zkM94C2
 PKExTK/HT+IYQL+I5ahDtbJYTpp00OWwU41WTcoXm5rMajyWkA+QRZjBnIy4vkXlPZl4
 GoFPpDC2uEGG//85UjCaPsXQLN2JwdySofeFlBZZYEoEdGaPjjLrN1+237C/UIovXmoB
 0+vn5HMxGUC+LoLnzFq5oR1ylJyCv9LNeRBeSCNFmiBLZKh+kL/IDEe/U+F2ysZCN9D+
 Nwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548077; x=1733152877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/9NmZeUsPKrEXQM/VYYoqE8OEZ3mgV8GxzNtjGupA8=;
 b=wOvAw07bPh5GHAR5cWLVylaJp5jUScjSSafjYoUezdHJ2z2jeQ7TKa/87xm0xSEHmn
 uddpHBpwjd+tmAbv2hq/AMj1hNeYcqCOWZp81Okf/KusP0rsaKFOLv9Wa+G6f4poDEGA
 lLNTHAoc9qAQ8bH/xYaEUTsp4dSP/Bq+ytnS2cnVNpR4INMg7FMO1bp1cOcX3oR+B26B
 7RdA+tCbWsX6/hCZRhCUELYjXgHWQQlfTkKQ6UlLylYhg7hsGXdYxtjLuu915Qr42Opm
 GlLyOBvl4RlBpKDXSRWUgAldv+nrjFLbs3YwwcbRQUT9bFGMkVNYDpfy8K66b21UcyDD
 acig==
X-Gm-Message-State: AOJu0YxJsM+UOzWWdmDEwVIogGTNif/DNuNHixFUZ4J8m15i9o2FvB1/
 L8IjL7OKbKn6Hcv+yyJ5DsifQVngtTPEEzSPo8gv0fjfUpHWZB3HuBT5/Hbm6pM=
X-Gm-Gg: ASbGncvlzkGA2kZ6D0iT7NuGrbmRnMheg5RkW1jXkRibF6be+rbN8jDKmSwyGckc//t
 5UI36vB6BJtz1ZpRDTGFKj/BVUpJFLXJCBgByM4y9RTcoe8TeAXXgEnmpKwEgK1TzXlDsZmO/Xg
 tjLE3qbxgp/RiQF+D4bsYi0FjyfRp+86WXo6ttM5vBMnjDrWbcG4aKDayhcceaTZZoak3UALGAb
 OQOgCHJnDB+QVIKnrhMMQIOOWcTjNIbKAnqTboSgi7q9SuZ
X-Google-Smtp-Source: AGHT+IFGIPnDG14AlwKZkeVefHwuHxMCWxaAf1S8VdvJWt7eQ0/ZIjrVfSIKGexiNJ7cWPeWSxkG3g==
X-Received: by 2002:a05:6512:1303:b0:53d:ab0d:b9f9 with SMTP id
 2adb3069b0e04-53dd36aa6a1mr5702270e87.23.1732548075950; 
 Mon, 25 Nov 2024 07:21:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349b70aa23sm72514665e9.14.2024.11.25.07.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00AD260B7D;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 13/28] tests/functional: don't try to wait for the empty string
Date: Mon, 25 Nov 2024 15:20:50 +0000
Message-Id: <20241125152105.2100395-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

Telling exec_command_wand_wait_for_pattern to wait for the empty
string does not make any conceptual sense, as a check for empty
string will always succeed. It makes even less sense when followed
by a call to wait_for_console_pattern() with a real match.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-14-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-14-alex.bennee@linaro.org>

diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
index 441cbdcf2d..d5027487ac 100755
--- a/tests/functional/test_virtio_gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -80,9 +80,8 @@ def test_virtio_vga_virgl(self):
 
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(
-            self, "/usr/sbin/modprobe virtio_gpu", ""
+            self, "/usr/sbin/modprobe virtio_gpu", "features: +virgl +edid"
         )
-        self.wait_for_console_pattern("features: +virgl +edid")
 
     def test_vhost_user_vga_virgl(self):
         # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
-- 
2.39.5


