Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CCECCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwXD-0003m2-9Y; Fri, 31 Oct 2025 17:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwXB-0003lP-Rp
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:19:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwX5-0002Nl-49
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:19:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47109187c32so14177265e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945576; x=1762550376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EBWQEu+G6aZWeAXHylufENQApXkpCx0rf9wOYW18fhY=;
 b=WF42dxxeUye2XYgkH2SqZBhY3M61XouhlqIsjGkOkS+M6brrx3TLnAjfb2axdHWcBz
 GY0Ca+W6opHtHSLWSJWy/25fvjpSYgyQR98cstzyjTGbPRIPS0ZxQvinlFBW9JHkAPs5
 BuglfcF6bFnpAvMGzKRPdH6QcCPoMEoPGnasbAHxVLkopORfgDhaKjVsZ1Yo0od5EkUX
 HP59qvPbDPuVVJfT5qZ5uNWgd/vdBtTHWb8JNvsUCuRTJcGxFVFtmwn587uzd7oIhrKM
 KihF625QhISGLDspFHV8ReYgtTW9M194bOabK1q1TeOz6B3rJfB8rVI1JSIWBAwDiSTC
 /m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945576; x=1762550376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBWQEu+G6aZWeAXHylufENQApXkpCx0rf9wOYW18fhY=;
 b=Gdb0Xz+OkxaGc1+HuVE1Z02fhO5dOBygjpmtf+kNfOpe+RLRuLYmHtKqpORj8yUEOm
 6p5mZqIfIffO6ApcBdcgjMH4q2ejrUgbtVexBPWfxYesr5X4y5p5IvzFSmPSjW6Z0W6T
 /qupwj2FSZie988qQilMcODhDpLS9R5igBDmM9IsuLqW4oNebKxjR+5ukBtSlQBigPLG
 erlajgTnjP1wZaD2u1/vo5FvJf52PK4tIfP4c/TZmmOf7I2AuVCLz+FvbybS+XFVuVeJ
 S+V+negVrnxYPzDqW0YJnedrsk+Pu/npcbKdRR+ytcuhQyvRsQ0VPgdFF1INfLA9TmF/
 99FA==
X-Gm-Message-State: AOJu0YyQSJOgL7747KVEu9NW7LeMH2ON6U4XDn0RJ9oI5Iedsrimf2ZC
 1qcXRuRldya768Hbk18fK1yDsxmvvoFTVgWIeVHgetuSGwheX4llXAxWMIFtHl1s8RdGYQNtYOu
 4Wg2K8Uw+xQ==
X-Gm-Gg: ASbGnct79RDmBoUg2O06js0RLsrY6wFztLwDdu12yquMyM4145zfQrImYyTyiPLSsx8
 SPYpXVViVn9Is3Or0wdmZeI26bUNSwUNRGwTBYilSFP9vCYi29RI0ByH2ShCe9GgjKwQoIyj44p
 U6feJA4/9eSStK+gyNjSFCw6eSWxHcv5DRy7BJwTq9YtfW9kiFMuhQImy+WFjUXMRyvpNTMu8/g
 enRVHuMQcv9Rba+fLDS8lRd8sejOGSUfqR34q0xfTYVs9VGEfygC/18Qm5efCwptfn3EWqfLV8U
 SJY0qcqYtQ+AUpKawuIfiUwrztWFHwYHj6zU2lynrejKWyc1FxGaikLIEDYT/PPByHQpUTV7A2/
 Bp2BlS4m4292Z3f8erVH0PfeSwJ9zI6Lhwm9uzTDDajXUF1bMMduF1ykvAtLIr+eka+XuVQyXec
 QDprr/cKHKnaonLkh0ZoaXxG6jGgZYK1Qj+ZRljJSK5SI1w+n1xqmYa8EKf3M=
X-Google-Smtp-Source: AGHT+IEYbSHSR5e9FmjDsV0sS9jOFHeFfpqhjswQ9b5Rqs6AVwRVv8+H9vL84svkddbk+bb+LKhCqA==
X-Received: by 2002:a05:600c:3e06:b0:475:dc58:39e5 with SMTP id
 5b1f17b1804b1-4773089b541mr45267795e9.27.1761945576398; 
 Fri, 31 Oct 2025 14:19:36 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fbeef62sm30578125e9.1.2025.10.31.14.19.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:19:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] tests/unit: add unit test for qemu_hexdump()
Date: Fri, 31 Oct 2025 22:15:17 +0100
Message-ID: <20251031211518.38503-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Test, that fix in previous commit make sense.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251031190246.257153-3-vsementsov@yandex-team.ru>
[PMD: Wrap long lines]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-cutils.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 227acc59955..67b1cded64a 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3626,6 +3626,46 @@ static void test_si_prefix(void)
     g_assert_cmpstr(si_prefix(18), ==, "E");
 }
 
+static void test_qemu_hexdump_alignment(void)
+{
+    /*
+     * Test that ASCII part is properly aligned for incomplete lines.
+     * This test catches the bug that was fixed in previous commit
+     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
+     *
+     * We use data that is not aligned to 16 bytes, so last line
+     * is incomplete.
+     */
+    const uint8_t data[] = {
+        /* First line: 16 bytes */
+        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
+        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
+        /* Second line: 5 bytes (incomplete) */
+        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
+    };
+    char *output = NULL;
+    size_t size;
+    FILE *stream = open_memstream(&output, &size);
+
+    g_assert_nonnull(stream);
+
+    qemu_hexdump(stream, "test", data, sizeof(data));
+    fclose(stream);
+
+    g_assert_nonnull(output);
+
+    /* We expect proper alignment of "s is" part on the second line */
+    const char *expected =
+        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   "
+            "Hello World! Thi\n"
+        "test: 0010: 73 20 69 73  20                                      "
+            "s is \n";
+
+    g_assert_cmpstr(output, ==, expected);
+
+    free(output);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -3995,5 +4035,10 @@ int main(int argc, char **argv)
                     test_iec_binary_prefix);
     g_test_add_func("/cutils/si_prefix",
                     test_si_prefix);
+
+    /* qemu_hexdump() test */
+    g_test_add_func("/cutils/qemu_hexdump/alignment",
+                    test_qemu_hexdump_alignment);
+
     return g_test_run();
 }
-- 
2.51.0


