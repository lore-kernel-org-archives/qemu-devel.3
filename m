Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E30CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 15:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8K11-0000qr-RH; Mon, 13 Oct 2025 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dixyes@gmail.com>) id 1v8J2c-0001N7-AN
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:56:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dixyes@gmail.com>) id 1v8J2U-0000qT-It
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:56:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-781001e3846so4147185b3a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760363788; x=1760968588; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nyVNiZsERV96aiRub84RGqjnKudix8XYyc3Sri39ZMk=;
 b=NzOZt+bwDv4N4himQlX7jOUTquMQp3xniNySVU9GE7OQRcomMudMfJp3xASg1seD81
 bOtlemMHPU1NACKAhLa3m2ZXSiYR7TKPvw19OjPR2V+r2Ks1Gl2gHBG2sxzSppSGi/Wd
 dg3SvIwEs1TRWDAcQ8fAUnWJVutLYdQsesXOkcMdtw4Vh0hi2/eM5OQsIAYjwHowLWy7
 vyp7g3Jx7VzP4vQPusadOTefinxS8wtHDhu0AWZvMEhP5I3pyMavvBwXULo48GXcgGnR
 rSZIGvRVacw0qifRcfhQ6RlpYav/UeuuTgLApqGfbA7OMQ6VIXO8CkT5SOmTHQPU716d
 +Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760363788; x=1760968588;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nyVNiZsERV96aiRub84RGqjnKudix8XYyc3Sri39ZMk=;
 b=dstfTvmGLO39+oc+jZZeBsLgh/1Jt1Y4q3pzjArTE/ahK7tBEy2SFCM4xnoqzwiXgl
 BEUVPM9IHUhX9hdvn8wc1cWWMo3401UObzvIqegUoGB7fbK4nb6E9KwbTgtWesQHoNih
 GURjffuJP3Yi+RmfhCdP0z/ABxpzoe7VKcUIZiqJfosRHy4DD5vh0gptT41f7r8bUT2U
 Q5Y/LiMQ08Fv+3Qfp4PCbjtokc/uWoNnvWvVnROO2RfTknthNba23eNZY4wLzen9tMAd
 boOcn64vPpKqtszjEIvi7M/0T2DypDSm1LtjWvmf+rjTOP+bFjcMTwDsIA9aMRnw6LRy
 /LwQ==
X-Gm-Message-State: AOJu0YxA2sJ4CNesGMDIhbriRwx899W64394CybxtKouLifPfjSWvlsB
 D92vpHY5sMcfXYb+9xzQPrMloE7Aui4sAa6ivRuVvoorLZgsiPC109Rv
X-Gm-Gg: ASbGncsS8B1iOF3xwNblH3exGeA0MfA5I3Di1SYHjNZuI/loVJ6gXCxoNiQlX8QGdG6
 uQ6SbMowopAqBOkuEN6tWisFre6r6lKVl/i1VULRlZCBMJw7KYtu0l8VNp8ZNGfoZEMvc0tDQM1
 fzQW2KKWns3roZwlXsMsiwwYlbr7L9J3Qa+HlFMr0AfKLMdYwZgMCIxxbHkjuqGqfHydIP/bG4h
 bsXx7MpqSldiqtVHmeGVChj78y03rxUnSjBIQxXb5YZ6oBgEOUtzqvc0Its/CksI8Ocohqck6qZ
 /iJe+EuZxjst/08HW/ySJmG3LX6lp5Dnz+ACNDLPpXyzgp3kO6AC4h6H20crn5HwguwqBVkgzTg
 Qky66GeLsnmYgUqcUklJxhyd4x7Fn4fi8ZjRlU8YFaQ==
X-Google-Smtp-Source: AGHT+IG/Bc0yhOCTnQj3+Bni6zOP+gnVXonQ/o51k+GNeDoVBqvdE3RTEMjouhFHnZaKTbXknGF3nQ==
X-Received: by 2002:a05:6a00:812:b0:782:7052:5167 with SMTP id
 d2e1a72fcca58-79384f489bfmr27432920b3a.6.1760363787990; 
 Mon, 13 Oct 2025 06:56:27 -0700 (PDT)
Received: from [192.168.64.14] ([163.142.81.123])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d096740sm11812713b3a.38.2025.10.13.06.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 06:56:27 -0700 (PDT)
From: Yun Dou <dixyes@gmail.com>
Date: Mon, 13 Oct 2025 13:55:54 +0000
Subject: [PATCH] systeml/vl: Accept dots in -set $id part
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-support-dot-in-set-opt-v1-1-0c57a375f87f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOkE7WgC/x3MQQqAIBBA0avIrBtIRYKuEi0ix5qNimMRSHdPW
 r7F/w2ECpPArBoUulk4xQ49KNjPLR6E7LvBjMbpUVuUK+dUKvpUkSMKVUy5ovVuCmTc5C1Bj3O
 hwM8/Xtb3/QCmx9InaAAAAA==
X-Change-ID: 20251013-support-dot-in-set-opt-3d57fe257d3e
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yun Dou <dixyes@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=dixyes@gmail.com;
 h=from:subject:message-id; bh=7X+FLarXgToAL6FSc9kYdfRZ2WwIZ1RuUTf9Cyb5GD8=;
 b=owEBbQKS/ZANAwAKAQTZaHHIcqNeAcsmYgBo7QUDO3IJnxwjsLmnC/nns75yMFdBizqvbT/Za
 74FDoEkVESJAjMEAAEKAB0WIQR72ofGPrFkwMZZUqUE2WhxyHKjXgUCaO0FAwAKCRAE2WhxyHKj
 XkS1D/4mpVtYq6RXeunnyIRKj6UDNuezBI885/2fyyg0BozquwRYVv5Vw2hurXRJBkPms+WW13x
 0Vz/9gMdQknuMgTR7FwDEjJnWH3GUKOvmUcHRGflncej8vseP4k1s3z30MFGGYR5YIeIfczy6z1
 uOSLwbkFIyk3lvcIg6Rs1dhBLx6aonYufAtnB8enkALtnbvyiTkW9UdS6c4iUXXCAV2ZaYXEATx
 ELYFvHm0iwUjVc2k+GSMuFdC7TZ2hPk1QvPaDnA2mulvcT0BT6NCQI1okbCBCP76kXXAQa8CQvi
 LoivQ91L3ffXP0IctrSlakLb9f0/3PL8d1WWJ0wxPYr04gtWYX0jRQy6ilENF5+eI846zO41LSY
 MwDWHnlzvi9A9ljkA87kHpe7VB1Uhb/ulfu8pHdDzbP/lnl32XM/kxikY1ivX5sgOhHJUZke3+w
 jz2fDdfO8aU6a3JBpFJIaHc4y7xegLIBIr5HNDPag108FYjSUiPJnEBzEYg2I7X8/cV4bHxts6M
 664XDwTmV9z/gvAotP2QOvzAyuRTZegKm/dULWTPxEtXvzfstVvP+nJ8P33vMNZG8zi0gxf1QP5
 DuPFDj1YRi9E1G/2UrpWZmSXfGJFOwc6sEGmfX0FkGOQvsdF8uP1qz5Il1H1UyFRx5RO3HyMeAo
 JbA2W4xlt4cly3Q==
X-Developer-Key: i=dixyes@gmail.com; a=openpgp;
 fpr=7BDA87C63EB164C0C65952A504D96871C872A35E
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dixyes@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Oct 2025 10:59:09 -0400
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

Devices can be named including dots like "pcie.0", but -set do not accept.
this patch will make it available in favor of -set devices.pcie.0.addr=1f.0

Signed-off-by: Yun Dou <dixyes@gmail.com>
---
 system/vl.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 646239e4a6..3c54804004 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2331,19 +2331,50 @@ static void qemu_read_default_config_file(Error **errp)
 
 static void qemu_set_option(const char *str, Error **errp)
 {
-    char group[64], id[64], arg[64];
+    char buffer[192];
+    char *group = buffer, *id, *arg;
     QemuOptsList *list;
     QemuOpts *opts;
-    int rc, offset;
+    int offset;
 
-    rc = sscanf(str, "%63[^.].%63[^.].%63[^=]%n", group, id, arg, &offset);
-    if (rc < 3 || str[offset] != '=') {
+    for (offset = 0; offset < sizeof(buffer) - 1; offset++) {
+        if (str[offset] == '\0' || str[offset] == '=') {
+            break;
+        }
+        buffer[offset] = str[offset];
+    }
+    if (str[offset] != '=') {
+        error_setg(errp, "can't parse: \"%s\"", str);
+        return;
+    }
+    buffer[offset] = '\0';
+
+    for (id = buffer; id < buffer + offset; id++) {
+        if (*id == '.') {
+            break;
+        }
+    }
+    if (id == buffer || *id == '\0') {
+        error_setg(errp, "can't parse: \"%s\"", str);
+        return;
+    }
+    *id = '\0';
+    id++;
+
+    for (arg = buffer + offset - 1; *arg != '\0'; arg--) {
+        if (*arg == '.') {
+            break;
+        }
+    }
+    if (arg == id || arg == buffer + offset - 1 || *arg != '.') {
         error_setg(errp, "can't parse: \"%s\"", str);
         return;
     }
+    *arg = '\0';
+    arg++;
 
     if (!is_qemuopts_group(group)) {
-        error_setg(errp, "-set is not supported with %s", group);
+        error_setg(errp, "-set is not supported with group \"%s\"", group);
     } else {
         list = qemu_find_opts_err(group, errp);
         if (list) {

---
base-commit: f3f2ad119347e8c086b72282febcaac5d731b343
change-id: 20251013-support-dot-in-set-opt-3d57fe257d3e

Best regards,
-- 
Yun Dou <dixyes@gmail.com>


