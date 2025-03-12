Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73BEC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLhI-0002ih-Pg; Wed, 12 Mar 2025 09:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLhD-0002hB-LT
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:00:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLhB-0006T9-L9
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:00:27 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-219f8263ae0so124582395ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741784423; x=1742389223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1CyWLvFz1tx/rdu7DL2wB5x36ElQ2/oE3A0m7I2EJs=;
 b=mzELpP3n6lbvU/JWfXkbBVjSInJRxNwHIwWzWHVjCGDYdbAJOrMlMZhNsdrBDIZ0KQ
 VAI8p70y0nft6mNXPW0Y4LnudRYdRoNCewq3axsn1m0v+FH1x9E21W/gzD8LwVWDSaqe
 MP26R86Y3F1yD/sny7v29wA0tFnYsrhpk2B80vC6+BGJO70DP/JKVYotHidwsfjXK//u
 oELIBdWY8hb3igc/3mq2rmA4mRyzbAubzbg6ZXIz6JFpFhPhzA2VGo6cwCemhFcql5y2
 TdcEHNAS58piKAaeXrfIqeU8XJp1m7DoZtGiTAAACn+kMYqCSHa9BpyMO4awg8CyzwOt
 axrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741784423; x=1742389223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1CyWLvFz1tx/rdu7DL2wB5x36ElQ2/oE3A0m7I2EJs=;
 b=DYwJNUaRzxfXJtTw60ZspgSN9IwjuxXFa5qP9bK1J3IlPZOfszchE1M6H7Jfl8DqwD
 yc0lNGI2NHGYG6DclJC0nBUNkXE9lCYDr2V7Phxt+E8V/uNNbDm/2YzS6Lg00PN0zsRq
 Yf69kBMpTQ2e75PlVOFucQqxdboCWJbzCvBoDIpmmMGqHhE0pzN07Gw6oy66mbW6/5ic
 sVAZm+EaFKCLUjYuxlWc6idxSXD3eSsqBU9z8ZLUrxroAVj0LmX3faRYOXeAq8NSImTO
 KI99uDyTknbp60b8wSGa56Uun70uFD8PcG/xnM/uyesDjRoeounFfeG5cLYrmtrBTKdc
 tFdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfnitb66FlITAh+xaJvMfe6/7fTGcoCWcVyhhlgH2d+kwuzaTP31MdlyiQVMJoweaRTbWaufIPoosA@nongnu.org
X-Gm-Message-State: AOJu0YzxoYP8nV00JHUvhqJVZxhlrcgHijP8vl6UT2QXV3IZamKt3At7
 x/DTNbkY4JaAXczNX4M8YsAVjglA/NiQL12wizREAVW12+j1xYVpUnGX4g==
X-Gm-Gg: ASbGncvmAtdiL28+CAnGtmAnGsP4sRihoN5NYpQp0fLwnoJeEGvZtQw4iNfs3N8KYB6
 hlbSrqf/upiD3rMK5KQDhZ8Z1GxrtYbv0g4HzmnbromAkNeS+LbEz9lmAoDwUaE+khGYOoOmbgA
 TJswU1AwostbAxuP+xSlx0xHVBbLRDrbLSVroCqy8zeuLQIFxU9Ywa5a8zrJs1IIPq2gtKpTNk/
 t9BDqjq9XyTMXg3Vky/+R/KRkXNjHiDr5692CqsEnRQ+95XD54TIKfibqBiPtPOpLUk3bdce0RI
 rZ61AgBaIKXrrKF+en4bOix4bjJFG0iSR+ybxZj4paHHNEQyGOw=
X-Google-Smtp-Source: AGHT+IGDlsMVYnZxpvy35LFqyNJa8Sgoz1Qv6tnN5NMO82VVImv3BL9HBp1XU69blKC5ODNu43cO4w==
X-Received: by 2002:aa7:830c:0:b0:736:5486:781d with SMTP id
 d2e1a72fcca58-736eb87c1f4mr7766597b3a.19.1741784423419; 
 Wed, 12 Mar 2025 06:00:23 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bee078fasm8868407b3a.139.2025.03.12.06.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 06:00:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] tests/functional/asset: Verify downloaded size
Date: Wed, 12 Mar 2025 23:00:01 +1000
Message-ID: <20250312130002.945508-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312130002.945508-1-npiggin@gmail.com>
References: <20250312130002.945508-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


