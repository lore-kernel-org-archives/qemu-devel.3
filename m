Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F33C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHh4-00012M-2i; Thu, 03 Jul 2025 07:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHe9-0005Tx-Vp
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHe8-0002lQ-Ci
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453634d8609so56306265e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540306; x=1752145106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9oDPnMiXj0W5tjbWJ4QNzpnf7Jjks18+DwO7DMnaVk=;
 b=urb5I51AV9Z7gl4q6iXbc/gMOJ72n9HW67hMR1KN8h+PbDUYJUCER5jTs1NqeYG/Pi
 YB8Y4jHymSvH01ymg0XTFMKashvLk6xWptR3rKzgHOwaMAUtvQKopT8UO8ky06IKQUAB
 pqq5vcSTKX5gtYg4for5ewStAvPWNOL2vXq1cNLk/Ds/pSu+BOH3Fa8g1Etjj77678U3
 XcUjQ6h5fJcAkTMVdykr0MCboVyeX/HNLDKuXtwaY6HHpuJRvL4SZgVrIZ9VTcn1B4p1
 tJfJIdJSuplB/ZvPjmKRrLc2wYH9K7FkWc4iie4f2O9CWGRqLuwV0rz1pWjpcm5VFgNX
 wfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540306; x=1752145106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9oDPnMiXj0W5tjbWJ4QNzpnf7Jjks18+DwO7DMnaVk=;
 b=fFL6t3lbcWKC5CTYCVVyHTOWC56Q4jkxzJIxgDdF/UaHpbj5P9eggMoetghVefxUGV
 gIxDbPqC/kK/L4nwSGBaoU/6dvI5vjvIGFjPAgkl+zWHIbT2aEn8sjQpDxdKkVQadhKG
 51/BIG0/6lDYspK4/rDdktv6rTSm/HhSKb2spqVlo3WoJ1WdljzRZgcz5sfTF66yINOh
 csc1W5ufdBRI3ZBhcT5xHVUk1je1xRPbvgxY8C1Ww7QYvsa/XSNl+zaLMDVRnSy8dlM6
 AdSKIEo7xbjA7ZC1Jkw/4y4GbVzt3NzxUKwhw4hF045YITzHouDxZVIpFuvTXxte4yGn
 ZFLg==
X-Gm-Message-State: AOJu0Yx4xt4BRJXqR721P/lipdCOHF33aOo347UO2+AV2SrV+Y4nJHGs
 MZjZUIz1SP6bgxW/PJaJE0MvlhXz2GZ+YVDBW3XttzF/1idc77Eu7cq1bpKe0sOFyLaQfy6cRqs
 YKdRmd6g=
X-Gm-Gg: ASbGncu21xPWZoDaEBMAhgiCF96GJdwGMytWz7etJfnC1oLKq2Hv8Igf6m8DW4VnUdA
 gEQJEXepao9geXbQnS87Y73PJ3o2fOZnjhPb9yvpdOhDi49A2mogD/aylyrWXgxnGUgnICWVzVS
 FiQPC+eR5DKT0Vd5oMoB8RwQ32FmCrSdjODPGiUOurZSoSoXNinKwvX3/tJB66mxSjmU0p1AHOm
 go0vPb5XEU56MgJ0jdnYL9dH98BmCThNWZlAxMuIm8W3kFG3zwX37RHcmAkCXGvLysuHZrobX20
 V/JiikLWRBM1aQssEGX3csSLCsod5rQeYobqtc+YykkxVfZ2fNRIV64sZn43ULj1A7hdadDK0bg
 cX82tEyre+yE=
X-Google-Smtp-Source: AGHT+IEFReRAJH2FYWXivnT7yhvwImOKEpLg7WkwUoTmJ6AuJ6pGN7l7U7CUpirT0Nc9mpI2CZnvOw==
X-Received: by 2002:a05:600c:3111:b0:453:b44:eb71 with SMTP id
 5b1f17b1804b1-454ab3a8f15mr22671775e9.19.1751540306331; 
 Thu, 03 Jul 2025 03:58:26 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99b1a5dsm23326275e9.29.2025.07.03.03.58.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 31/69] accel/tcg: Implement get_[vcpu]_stats()
Date: Thu,  3 Jul 2025 12:54:57 +0200
Message-ID: <20250703105540.67664-32-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index ae83ca0bd10..490596dbbd6 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
     }
 }
 
+static void tcg_get_stats(AccelState *as, GString *buf)
+{
+    tcg_dump_stats(buf);
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
+    ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
     ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
-- 
2.49.0


