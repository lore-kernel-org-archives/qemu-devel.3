Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1512C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLAH-0001fG-N2; Wed, 12 Mar 2025 08:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLAD-0001eG-E9
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:26:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLA8-0001du-S3
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:26:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225b5448519so5074665ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741782375; x=1742387175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UMfE3tEvJouIbe7xl+kGrgC94NEdkyZs3CPKKHqiWc=;
 b=OtHC6zMs9uP22FJHaJgEkJAscx3UZ64mB8EJdXKqT1NqdWZze2aRZp3AvPikohDOVg
 mTSaymeUAolNZtI2DI08YwiESBwZ1NB/cUmHKAjkeQ+IMmd/rCuvvhZDiEyeR72IXKsZ
 gjbdtcbK2ozuedbBN34wNmNDRAi6P6f23aTOTzbCA/M6Od4+I4Lj3YraltvoLqymm8LT
 4Iafuk/ta68f9diH+N83lmPhYSVBaNoi858X+VkqticColcamvk5k+ZIF2vAvgeLJ0wp
 crhj59scgwSkSsEwQyRUJ0VqXOABeb2DOjocd4ym5xN+cqhL+gBV/FrhXTCUppuo8Bn5
 +eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741782375; x=1742387175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UMfE3tEvJouIbe7xl+kGrgC94NEdkyZs3CPKKHqiWc=;
 b=HOCAmbTQHoXpohDNzjEsUEVYUBqs4BKIAEmMP00zMLCFb0i2KCUovTk/9SQFbTXHCg
 gJvKcQMkjMqGWi51eyP/3GVJn1acYyrQEF/v5vAM2GVj6rZah35hFjEoNJN3dthjK2ny
 xFGg5HoIyx9Cd17iC1PU8rlPWImljGsKcuPNV+bYMIB3e3X1pEqg+iQQnSGYXq91KukQ
 78Uh0ODbrPSUw32DqjNvuxj9mOjD6TwT47nkErcTPC4CO00fFrHk58n3UNgei015gRLi
 n8YErKZk1DPCp5oKfeC3WzqVOcAMv0t7aeVuHf6RD/WId7lpaHpbv+wN3dtEzbQTIKYl
 8x+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl+GHyP95H37bLpPvavrpK/Cry1gii0GvyXPynJowuV4gTIDO1C7gEMKDvyq+M1v79tHgJ4HxnTA+K@nongnu.org
X-Gm-Message-State: AOJu0Yw7c9wWyylHMx0p3hEiZ5VIuS316a997OLKBArsJAG7Iw3LzHRE
 1iExh6pEPKfvSAvYFUoj1AmrvtN9wFd3ycBmWk/krQ6v7wCO6JIX
X-Gm-Gg: ASbGncsg9ghXe254pJW7R4po8MgyuYrxf6KCTfjp29cutQVGxwnDvP2Ufdu9R5pwxkw
 UrbXWoy6zWFWRocyWGEmXjIIM85x5kiUaoMGcEN04vWz+66czxA4kVmx8V7J+I8VZE827VP4djc
 jVyrxavJE/O66v3fJw2AJC+ZYozLgFFJJS6DhseZlupqgbGW4l1EBK+AGAGHLv8V4K1rbBL9MVM
 iRDnCUsovVOIrPRsOpAif9f91tNa0xlpHeJpUvSYc4uAu0WJDdPAYlyDVRcz1/iluBqxx2OaaCG
 w1afkA3uHWrokzrtW/gLyxcoIRv2FW7Mk8eHU83kCNWs2COvhv4=
X-Google-Smtp-Source: AGHT+IFRU7fcNB0Y/lnYGCg4K2qrIV0JA1CuPxtQdhX6JKCOfcuWUzMT/z/N+Mjx1nZsgIBtSSh8PQ==
X-Received: by 2002:a05:6a00:b4e:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-736aaa1acf0mr30387882b3a.12.1741782374705; 
 Wed, 12 Mar 2025 05:26:14 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ab33e1d3sm10842408b3a.132.2025.03.12.05.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 05:26:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] tests/functional/asset: Verify downloaded size
Date: Wed, 12 Mar 2025 22:25:57 +1000
Message-ID: <20250312122559.944533-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312122559.944533-1-npiggin@gmail.com>
References: <20250312122559.944533-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

If the server provides a Content-Length header, use that to verify the
size of the downloaded file. This catches cases where the connection
terminates early, and gives the opportunity to retry. Without this, the
checksum will likely mismatch and fail without retry.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/qemu_test/asset.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 27dd839e705..6bbfb9e1cad 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -121,6 +121,20 @@ def fetch(self):
                 with tmp_cache_file.open("xb") as dst:
                     with urllib.request.urlopen(self.url) as resp:
                         copyfileobj(resp, dst)
+                        length_hdr = resp.getheader("Content-Length")
+
+                # Verify downloaded file size against length metadata, if
+                # available.
+                if length_hdr is not None:
+                    length = int(length_hdr)
+                    fsize = tmp_cache_file.stat().st_size
+                    if fsize != length:
+                        self.log.error("Unable to download %s: "
+                                       "connection closed before "
+                                       "transfer complete (%d/%d)",
+                                       self.url, fsize, length)
+                        tmp_cache_file.unlink()
+                        continue
                 break
             except FileExistsError:
                 self.log.debug("%s already exists, "
-- 
2.47.1


