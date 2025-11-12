Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACDFCD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBE4-00078c-5m; Wed, 12 Nov 2025 08:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB73-00043C-AD
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:20 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB71-0001L0-PH
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:17 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so3751435e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954934; x=1763559734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpfJ4jVX8PRzGjLcbMi2UKEOY8vjEXd8DJ9mg1LwAPA=;
 b=llLavNj2I+HUAldU4+Yt5whOSYFIzXA5Vhy+/Urnv0xKjKmgSaKJKGvgf0NblRfo77
 hZBPZrMn6PLKaT3WmDbz4CX24dk5D5lp0H0gy62TZfu2fcAxyUSuYhfCLFMeHtleOexx
 gqH5pfM6CLKdUbXlzCHidvjsB5mgHxPDRw/BlxHMBYoj0kprUam1AxaVnvf9R1Gdi7LO
 7nmVdrbvWW1Sc7wNSvFpCp7qayrLoxwakjr7mRRTb1peM9ztAOVX1bu2Vb/0/PPB9kLE
 mHR2ZmcAF3vVHN7g9Y1BHnM/ivPSgJvzPPYJaTrNq6p0hjsdEQU6cmqhptn0M/fGniPt
 /MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954934; x=1763559734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RpfJ4jVX8PRzGjLcbMi2UKEOY8vjEXd8DJ9mg1LwAPA=;
 b=vM03RZ04dqsmiQtCtoqW+UKxJxu1CAaG/b8tFd5BmdtTX9fDIrdFaRVyXm7i/igcPr
 jbGMMTRU14AfvR7qXHtGoEAtWWNQPS9tG/etwXif5WiHLRZq0xWniwIjfAD/ABBpKw6S
 0oiU8ae9z3HBKLuMmBZLfzKDhoGytO4NAVRDZKJg18iPk7i3MVMF09uhGvSMSrq9Vr8O
 ZhpFjzmmhcNWsimgVnGgXgGD4ubu6GSRqCUdzie1TdC9tzP9XMxLaAwCqNN2l83Kunum
 JsVb7NC4+3vDwIBUkBsa/aiw0X3KWNA49I80F4zTTA7HXzk0MzQMrrYJz6+fVQJqLT1k
 2vQg==
X-Gm-Message-State: AOJu0YwtEziYkcyyMpX8OpJ/cwyeeGDayxLYWqCT/Ba51iCMhfnyiKSW
 OizR6mpLZqhgNiDPHW3/ezCd33XM0Dak6G0aQ/mtIfepBXLmETUqR1AR3glwp8DrqVnrPl64rV+
 MjM0nq02wxw==
X-Gm-Gg: ASbGncsQ+7k33F5YinSyhXk1putdu1s1nf07QPqUWG7V+8y1o/6KRfVT+M+FrN0r89b
 b0zh968JJB63WmgO2aU/PXKHAAjaKafXBezrux4eJjvTlfx8Ng65lXMB3x8kXPqrGUa5WrHG0qq
 fdXoI4WtLKrNh0dg+eBMyz7xIOFABkL7oJRbfv1oPv0JHq33bMlYIhNGFg/VKZIfL1oVzs2b+hJ
 IfN1jbMx/RAd6LMWQbtXxuZkgh/FjVfW+ZhJVR+IROtqdoLWxYa/lsJM67rrSUjj3lGL4DXKEwR
 zP0jouuNwvI4CjCsxuSGhmxH4PR8fPez7y5p96g6r9UIG/GeZglgwUpq16zVmvqmZmRvqQ0L9pb
 +8vKqsGI+Zw6Xya0wLpv4kBqLq39kiTpoo4waws7obveFVHJvCQBlHTHyk7V3i9rneTgZaazhoi
 JNwxTJuuDcaEt6KUzEdIhCr3238IdJC1pirR1W2UrJL45GaRcMx5P+/ZE=
X-Google-Smtp-Source: AGHT+IF8PpiXsnoKZXjUMlDZQSx3EHhpu0A7iBpsvCfG4lu3hnCWTf4ODBLCnAZOyBv47g1LjluNtg==
X-Received: by 2002:a05:600c:4f0b:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-47787084475mr23116055e9.14.1762954933725; 
 Wed, 12 Nov 2025 05:42:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm35417825e9.10.2025.11.12.05.42.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:42:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/10] chardev/char: Document qemu_chr_write[_all]()
Date: Wed, 12 Nov 2025 14:41:37 +0100
Message-ID: <20251112134143.27194-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char.h | 29 +++++++++++++++++++++++++++++
 chardev/char.c         |  1 +
 2 files changed, 30 insertions(+)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index df55c7f4e67..4aab018938d 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -223,8 +223,37 @@ void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon);
+
+/**
+ * qemu_chr_write: Write data to a character backend
+ * @s: the character backend to write to
+ * @buf: the data
+ * @len: the number of bytes to write
+ * @write_all: whether to block until all chars are written
+ *
+ * Attempt to write all the data to the backend. If not all
+ * data can be consumed and @write_all is %true, keep retrying
+ * while the backend return EAGAIN, effectively blocking the caller.
+ *
+ * Returns: the number of bytes consumed or -1 on error.
+ * On error, %errno is also set as appropriate.
+ */
 int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
+
+/**
+ * qemu_chr_write_all: Write data to a character backend
+ * @s: the character backend to write to
+ * @buf: the data
+ * @len: the number of bytes to write
+ *
+ * Unlike @qemu_chr_write, this call will block if the backend
+ * cannot consume all of the data attempted to be written.
+ *
+ * Returns: the number of bytes consumed or -1 on error.
+ * On error, %errno is also set as appropriate.
+ */
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
+
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
 #define TYPE_CHARDEV "chardev"
diff --git a/chardev/char.c b/chardev/char.c
index 3e432195a5a..105b0d53184 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -108,6 +108,7 @@ static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
     }
 }
 
+/* qemu_chr_write_buffer: Return the number of bytes consumed or -1 on error. */
 static int qemu_chr_write_buffer(Chardev *s,
                                  const uint8_t *buf, int len,
                                  int *offset, bool write_all)
-- 
2.51.0


