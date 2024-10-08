Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D859CCEFC32
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDMi-0003C4-QX; Tue, 08 Oct 2024 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMh-0003Ax-Bx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMf-00038n-AP
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d375ddfc0so358477f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728406031; x=1729010831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFPIz1m97xBQWFJEuvJDqUyJljE1qr1cdlwIzcHgEvs=;
 b=sEqfNWi6N1n+f3qhJCXyIZIxR83rm2K1cInBk0JTFsHpRvfHxff7rWZqOBz4kRu0tZ
 4xjT+kzqgVAZfOs1zWtf+zvekgaCFugyX/wagoLrVV3+Gs+QyP1/QqL3vABc7ok66MMB
 Is/czDiCjzr3AmGFrO9DLFo8W5dylu/iyc3+XDwpJ61P92S/85cH/qwINeM7pkeKwBGU
 beDRA2iBXFASsgUwBTUimcJ8wKW9ZX2tNJ3oE89KhblyO2/RLmKmNJf/Sj/je2KNMa+8
 VQe8+BSU8he4Wn8irkHAVSEnMpw43TN7MNESeeRvIETwMiKf9KZN8b3zAMc4L1EXvsVh
 cBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728406031; x=1729010831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFPIz1m97xBQWFJEuvJDqUyJljE1qr1cdlwIzcHgEvs=;
 b=Ov31Iyo/Ho0P0RNuUfWAMbhGJcJFFMHGnJbPro4JLGZ3bizhEMU1F9hdtFl6Rsi3J3
 g8vPNEaMWfX8s2EgA9KUKG8jKRNuH9z/gcLKFBNSrx0FTH3sSZpxnhN/RcpWWDaZi/Fk
 MuywxP3xF03TvnV8eSq1mdWTcYQaSGIxyopGL/hi/94ObMc2KF6N6q82t2zG780gjNu9
 vtcEulPGjYjhfHRCVkjv1EH76WmFef7vDobriq7LZkaZloswWdcEF+wwgIoHKXxmmM2X
 rTEQzCseXO6zPtMMlpuGE/glxdT7XUMdaB8v6p9Ooi0i1/qZ0NwwlS3H6eEIRXcYjAkJ
 cvDQ==
X-Gm-Message-State: AOJu0Yzefs+nV8v7ZEwLINccLBsYhmSPIX+dlbhJKB6eE7lyYkUnDqn+
 6BRsHy48lCtHkua0gsAFTWLq9sFPiNr/yTOSlKj/8zmfWu59+f37dthGcq3v3jnDCiOyKpe39m3
 N
X-Google-Smtp-Source: AGHT+IEOUfcZJocvSLAjynhu3zbxYbAXAhyyKyYaIuh3k2ecYa+iFopm1JD5oWP/QSzYZqRQaaV62Q==
X-Received: by 2002:a5d:608b:0:b0:37c:c628:51bc with SMTP id
 ffacd0b85a97d-37d0eaea1a3mr8961595f8f.57.1728406031541; 
 Tue, 08 Oct 2024 09:47:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d32ea1d98sm1490936f8f.68.2024.10.08.09.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 09:47:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v2 3/4] tests/qemu-iotests/211.out: Update to expect MapEntry
 'compressed' field
Date: Tue,  8 Oct 2024 17:47:07 +0100
Message-Id: <20241008164708.2966400-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008164708.2966400-1-peter.maydell@linaro.org>
References: <20241008164708.2966400-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

In commit 52b10c9c0c68e90f in 2023 the QAPI MapEntry struct was
updated to add a 'compressed' field. That commit updated a number
of iotest expected-output files, but missed 211, which is vdi
specific. The result is that
 ./check -vdi
and more specifically
 ./check -vdi 211
fails because the expected and actual output don't match.

Update the reference output.

Cc: qemu-stable@nongnu.org
Fixes: 52b10c9c0c68e90f ("qemu-img: map: report compressed data blocks")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qemu-iotests/211.out | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index f02c75409ca..ff9f9a6913a 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -17,7 +17,7 @@ file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 1048576
 
-[{"data": false, "depth": 0, "length": 134217728, "present": true, "start": 0, "zero": true}]
+[{"compressed": false, "data": false, "depth": 0, "length": 134217728, "present": true, "start": 0, "zero": true}]
 === Successful image creation (explicit defaults) ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
@@ -35,7 +35,7 @@ file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
 
-[{"data": false, "depth": 0, "length": 67108864, "present": true, "start": 0, "zero": true}]
+[{"compressed": false, "data": false, "depth": 0, "length": 67108864, "present": true, "start": 0, "zero": true}]
 === Successful image creation (with non-default options) ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
@@ -53,7 +53,7 @@ file format: IMGFMT
 virtual size: 32 MiB (33554432 bytes)
 cluster_size: 1048576
 
-[{"data": true, "depth": 0, "length": 3072, "offset": 1024, "present": true, "start": 0, "zero": false}, {"data": true, "depth": 0, "length": 33551360, "offset": 4096, "present": true, "start": 3072, "zero": true}]
+[{"compressed": false, "data": true, "depth": 0, "length": 3072, "offset": 1024, "present": true, "start": 0, "zero": false}, {"compressed": false, "data": true, "depth": 0, "length": 33551360, "offset": 4096, "present": true, "start": 3072, "zero": true}]
 === Invalid BlockdevRef ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vdi", "file": "this doesn't exist", "size": 33554432}}}
-- 
2.34.1


