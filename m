Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED5CC35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 05:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsETg-0002n3-83; Wed, 12 Mar 2025 01:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsETd-0002mc-ME
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:17:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsETb-00070i-OC
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:17:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22423adf751so92748995ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741756673; x=1742361473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyrjeqgt+D2Pk5pIxLejPmxWNak0WTTJI8f+RFyfGJk=;
 b=NyZvg7VYgitZyCtbOl/hBNPD608xyhdfaXBKmO0lwW21o2T0DH7Gfa4/yuBL00eiyZ
 ao9Bks5rvhFVk4cSVCTY1c1iVHgbQt/NY0aypAkEViuc2hhbOYYikUYp3VZfiGpd2heB
 GTjGdJ4EfE4rQk2fkiZUfusumoDPv3imRH66dyyxH8jQvTPBQkYb3s3iLlISIbuJrFoZ
 UBiBxTDPPgrAi29+RMN2Y4ZqH43KPFhEmNoGvEwRG9Z97rLsTEe1Esfzpzm9gn44rrrp
 WaZ5eLblN6ZHG3RTeS1d5wUUJ4/ixdG+79ezf/8r30NZi/uNwXuZphhQxvgnafYbBLLe
 9jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741756673; x=1742361473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyrjeqgt+D2Pk5pIxLejPmxWNak0WTTJI8f+RFyfGJk=;
 b=JG+ycohmzakqEM08heRcT4qEeiCA1M1TgGSfN5WNRrvF1B5KlGffRZ9IUzfmDq6YVl
 r5/IU33F7201onfzf6da0I3gTXvSAISzL0nchWsEUxr4uNF/f59kzv8/J6RyV25iUdAG
 TgVuKvn+w8H6JQCUznOgFpBWooe+Yf7ywo5mMkQaHGh3qMW+7m5trziZHj79wIbMTQKp
 MxLjSO3LBVivrrj7w6j9BQ/n1iTn5PMC3P3m1iukxUnNws15x8mvDGqHbnOIIjpfOycT
 Iu7PkvULtI+o8TXwiX1S4GIcZi/XzvgxQyHeIl3/NrQomPbqsq+VnM+D6FyCgCRL18t2
 zaag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW16GOhy/qqsMvP/FLE2B/xj18OVAycpLCA7q5R2qtKh0KH+hHe6fWAaYsGjWLZCwutU7SYdvglYyIz@nongnu.org
X-Gm-Message-State: AOJu0Yx6fEWWCLD4oJ7Kwsm45XSuyZ7D0eCHSt8gY1JDWvt1q7yFei3z
 Zr5GvX3e/NzupAR32wR/oV1tEugOwK69mYQGumX0MKSDPLtqDIxmmpyEhQ==
X-Gm-Gg: ASbGncv7/7uNIjgrpmEUxn/mlUGqTKCCbaF/yoeWBvl9K2gzqpD8oNoNhYhsOCynluL
 8R9sjNWVjCEUWNUBuXp8nzN517/jKHTbmezuiFVaM+G09xWTmztx1CDXgPhI2N3+g9A6fTTW6EL
 7GQWaj3Ie/prLXr+OZ5r63J4UKFoIlWoK17GKgWUTlPtj9bdfoaXDQ4/IplSWlxkiutHoncmqYT
 /5X0ijLG57yxltQ18PbEQYbvBUmETivYVf985eVOcqwTr+lOFugfKapue7mtSWVY+pwMc+JPKBD
 QKLnpRJZwk26CsagR1O68xGljyFED3ccFk3w8kgdSraaC3lJSFlkNc2AFwlYyg==
X-Google-Smtp-Source: AGHT+IH8Uc8dFo6t0pzPk/eVuxmlY2/O9fXN4Hk5vPqpJFXtC/Io5mn1NCreOUZuH6dU3JYorVYBbw==
X-Received: by 2002:a17:90b:2e42:b0:2f7:7680:51a6 with SMTP id
 98e67ed59e1d1-300ff0a4593mr7767104a91.6.1741756673525; 
 Tue, 11 Mar 2025 22:17:53 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a925ddsm107557475ad.203.2025.03.11.22.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 22:17:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/functional/asset: Verify downloaded size
Date: Wed, 12 Mar 2025 15:17:37 +1000
Message-ID: <20250312051739.938441-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312051739.938441-1-npiggin@gmail.com>
References: <20250312051739.938441-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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
 tests/functional/qemu_test/asset.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 6a1c92ffbef..d34e8f5e2ad 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -124,6 +124,22 @@ def fetch(self):
                 with tmp_cache_file.open("xb") as dst:
                     with urllib.request.urlopen(self.url) as resp:
                         copyfileobj(resp, dst)
+                        length_hdr = resp.getheader("Content-Length")
+
+                # Verify downloaded file size against length metadata, if
+                # available. dst must be out of scope before testing st_size
+                # because # copyfileobj returns before all buffers are
+                # flushed to filesystem.
+                if length_hdr:
+                    length = int(length_hdr)
+                    if tmp_cache_file.stat().st_size != length:
+                        print("st_size %ld", tmp_cache_file.stat().st_size)
+                        self.log.error("Unable to download %s: "
+                                       "connection closed before "
+                                       "transfer complete",
+                                       self.url)
+                        tmp_cache_file.unlink()
+                        continue
                 break
             except FileExistsError:
                 self.log.debug("%s already exists, "
-- 
2.47.1


