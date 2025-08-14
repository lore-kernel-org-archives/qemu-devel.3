Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A18FCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbWD-0008LW-HF; Thu, 14 Aug 2025 13:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWA-0008KW-7o
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbW6-0001oD-Vb
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a1b281d25so5039645e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755191608; x=1755796408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/46L7LCx+ViKp1ECz1DIdRKRlnUT0rkmHhzvlzb9iM=;
 b=CIeBsSB37Q+cQ6Kw78p98jwy1EBB2xamF8q0QQ5aYgQdDZnmtdXFV/LDqnBg1QVjQH
 ipiFdhOSm04RxPE+GwqwHoaTwtbnjwir2WUImwhFEm6fLdGHCh/ZyDAMbt73nVW3u0x6
 93ZhFEyKS5j6O62VsNK3KSYjA7RbDrPcaX1aKaldZTqg0jWXiIPrdxDCqxKzYLOkbZFD
 qYE/fU8akBg9WVqkOyAtdfVldgkllyx8PICdx0DBnJ/vehttzlyBXBCGWcWOFBN5n19A
 fybSo3b/hed23pI6wavSLn7oyt2TUFmjoxHCNOBmzvdEqRCsZ5k/+6pssH2q2D6oQ2PD
 fkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191608; x=1755796408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/46L7LCx+ViKp1ECz1DIdRKRlnUT0rkmHhzvlzb9iM=;
 b=e1n81wzh5Bgew2PQfD67NJmjG8/gf1hKE8QEVk85uDSjBurdJfMgX9QV3hxoN89y3I
 1SEwKe94QCR6ocyozbOYqe0VA/JnwbmRlErd60LW5w3YmoF0LWEy3C8BpL0YjpUyqKXY
 eQdqKqqjLeXwEN1HuBYjqH0bNcB75ANtVMLxEKaeWB6EcGcw2L9lQ9CV0TSTGtrZqqgO
 Rj3Q/tncpN+wYAOdVgNJkut4sJGTNou5VvZqGTBNUYhHwkACXAbwlfFA4cmyuAmbDSnJ
 phKpHcUGrri9dm9hgIs+7BKCBEZKZHYMmPQJWMYIb8k2LKNjd4duSAWt8l5a0uzY4GYG
 HVFw==
X-Gm-Message-State: AOJu0Yw99INT3J4WYsdfZYR5mKzmPswRJtrVb4KDRcTlylVXpysoMSlX
 UiN1i4vYVYEVjmSccUeSrNmiqAOonHpvdL5kOqI3CBFdRBIdvvX9IfCVTL2XhPOnrT9WLiSNOmD
 XhJUv
X-Gm-Gg: ASbGnctV0/l2ui9deeHGHMgfP7eQVp7w0w3I97pGVyi7rRcHnPrLYYUUoC1NCVAfaUM
 zDE4N9+8Pz1ezYuOvwslQA8fbnqyJJDmmslAsBHwzAC89sAoeywVc/AGVVputOBDsNR5L0j3SFZ
 65IXX2GqWsCkWfy9N4cYDhPJSgRD34R0n8lr1D592/HF2i8cOjn+5rqGerTLiWkwI2m3p4bOPl/
 iH4LGL2JvhMJa3ZR2lLVNP1bdolOnPkEXb/CDJKYqCvQyF7ix9q0vSJb8tuBo5FmF/Ay3lxMTgt
 URVYd/AfV/QjIbKEQ3QVFNA9RZfL7z5d2Xf73zu8nQLXfiFA2KiIQM3kiWihdk1WSHuF32Aa9+p
 y43YYOzSNdGYuXFdTEvCJwn4kWRt+
X-Google-Smtp-Source: AGHT+IGPdgHC5HzAB1OyQkJ+vyuTysxIbwFjPG7Xz1GvCW28Eh3WKaGjaCWGvXZR0l+X3XLZndtvpg==
X-Received: by 2002:a05:600c:5486:b0:456:201a:99f with SMTP id
 5b1f17b1804b1-45a1b644a54mr37927505e9.18.1755191608203; 
 Thu, 14 Aug 2025 10:13:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm29489165e9.21.2025.08.14.10.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:13:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH for-10.2 2/8] tests/qtest/libqtest.h: Remove stray space from
 doc comment
Date: Thu, 14 Aug 2025 18:13:17 +0100
Message-ID: <20250814171324.1614516-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The doc comment for qtest_cb_for_every_machine has a stray
space at the start of its description, which makes kernel-doc
think that this line is part of the documentation of the
skip_old_versioned argument. The result is that the HTML
doesn't have a "Description" section and the text is instead
put in the wrong place.

Remove the stray space.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/libqtest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index b3f2e7fbefd..fd27521a9c7 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -977,7 +977,7 @@ void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
  * @cb: Pointer to the callback function
  * @skip_old_versioned: true if versioned old machine types should be skipped
  *
- *  Call a callback function for every name of all available machines.
+ * Call a callback function for every name of all available machines.
  */
 void qtest_cb_for_every_machine(void (*cb)(const char *machine),
                                 bool skip_old_versioned);
-- 
2.43.0


