Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267FAF3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbS-0001Cj-G2; Tue, 24 Feb 2026 09:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutay-0000Qu-PS
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:05 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutav-0001JA-E8
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:03 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4bc9e48bbso2193000a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944060; x=1772548860;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A3UwfgmeBU34nmXJh8BJRshXGfUCeBCvBGsRHIzsgGQ=;
 b=bZN2Ji1jOqHkVgVdTXuh5rp0yyg38u+GtZDIbVvIXLj786KjnhIjwzuieyGdCGvWq/
 /QbwcvRarWdiwosxvnaFwOs4hHeqF1M48bHpFRF0ItasT0ywX4zsqJxaik1GlYGmjrpj
 4BhEPJQikt5RGO0UMp7rrkiNkUDvLaILXqFQgBkswHIdZhs7U2ss4qOAdGCTIoFoTBkD
 tLzawpuPGTJLX6LkUea0GNJtrWOYef7+3RYnaewgQ3lWIuelYmFhikm6P88C+68OQt46
 sJ0ecmnwlu2tT60qm8XynlKdKq6G6g+mRjVLVu8YBqINOgcQ4rV1j5p3F7tEq+Lmm2bp
 VgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944060; x=1772548860;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A3UwfgmeBU34nmXJh8BJRshXGfUCeBCvBGsRHIzsgGQ=;
 b=XHtP4WJj84/jq6EcDT2lXkplmOLD1SWN6HSBM/j/FXnfoIsj7tlAv5BLVHXJa9h/mA
 td72PRkEz6GOFygonFETqMpmY9vyFZSga1RABNOGvbLobtbGAdjDRVYwjsX0yNxictJv
 pFe8Ok230CKFGjNREAIavCaxXDPw+FJz2yljhr7avvVFw+sX1RF6M2ZGw2AaF7/9x8Fk
 Bf68IQrEw+ePv37gdfWQgRgjxOdqqGN7bp3Tm49Nl4gPHgcNc9OaSaC9qtXlCNaXkbX7
 Lfgg4BH2SJiIxHp9CccvHsVAcM7fSAMD1sSiO7oL2XlAqNSw8Em4lyAQdmvpEziYsWX+
 eFJw==
X-Gm-Message-State: AOJu0Yyq3mlX6u8ZtLBGVANjhyn3OV7Xvzddu5BK2jRtSiaVUwGS+qTa
 fuJZZigMiKEBczueTwPlZNSvbOkWJJhajMuGlGiT/CpZ7m0QFN9r23/6gQIwnOmAqelFK2XznwH
 8fJlvlFQ=
X-Gm-Gg: AZuq6aJ8tHglrqF6iqM9AQwxLZkyv+q35NcyqpW2kqLLJ0HfXNEN8ds9ce5n5MNPAw8
 b3Bb5zvogHaD36jk4kLbRGpTK/MnpyXLSW3YjKtgMK5LueGh9nlUlmnl5ZA/ysn19P9Kz9btAcf
 41v7dCKCyrDnRGBrnm+2uL/yURrR1DKdwL2L1/KQVqh2Kyjkvw8/JDjh5qzOW7UE8lTWyN9DB8x
 xDI2QYlcCsbqm2CFaXPHzhG+FFHQGhz3ihewmCJQin1QFqQOlOqGBWVO6J/HW5QxcVY/K50i1jz
 NhLIpNRKVPJ8Z4RgLILHq+ljPZvoni4zbKeu7zYyzqxa6+vYVOtZkmzCSqe7osogxYhbwY0Vt54
 RHdTQWo/hQOWToaHaRtvtJEDlV+6dwpsuljizkTTZT8WAcofyDF7AHKOOOb1qPui+y6tt42qDpt
 Ho5XgcVH/8oA==
X-Received: by 2002:a9d:6c09:0:b0:7cf:e41d:f0b0 with SMTP id
 46e09a7af769-7d52bf3ecafmr6426643a34.18.1771944059693; 
 Tue, 24 Feb 2026 06:40:59 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:59 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:39 -0700
Subject: [PATCH v4 15/24] bsd-user: Add do_bsd_uuidgen implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-15-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=u6/MfK56Y5oDxiiGMsgHlq41F1LzCcN51k906mlfNRE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhnkNqTk3vYfb7fitdvRt795aW/g6XPQuOTh
 biIRLPU7RSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 ACnaEACr7je7W5VzVdCeud4sXn3ct4xaXhua7xR4n3UQoz0y9f+0+N3JvJaoqffhv5FJBgkqv57
 Yu87Zhj9cZZtBLi6X2m6ECHOygMVSxQGH2LdgX81YV33c95GTKZMKSJvsO/TBe3HyBH7+V1ERH0
 CcERU2sBGv1ZoZj76yMWEBgXZp5mLP/Vu36ndLBM8KaD56vYmGfDLKZw+PrBVSenghvcUT8DNa4
 CggsKqx+MexbKp/plFkkF6W+clP45Y7XTaO94Y28Wyrk5DcJps8I1DEBa6b+FG6npl+QbUTmJMN
 AsB2/3JeMXqK+7GIqY6lOYdWnPwIXjpwafYxoixHI1/KaoQypplcPab3+iYxkymBCFm3sgAHort
 NUZVqcv4x7oq+yjP9tbu+vYp8upDTHn3OQbbm59I4cBZFBhku9Hvz/rKCUMNk5JBkGudIICShjK
 71wRgnOpMWzMiX3OyfmBUYvVrxB7IrCNROmgnU2/HzfegPtGsslhTROGSKtnhGAQxWL+OL1x3rF
 gsqBISP9AvMlbsxbizwHApGlGV47jNPdQHEaXCB5GRHkE9zJIPGgj0qqF8kBp71SQvN96q5/YrA
 X/HqcHq4n/OadfmHIS1V8IrVMf6sQlZp0fYTbLX6orTQ5M+GOylc0yz1E2KFWquFvodYCbSPZUp
 t/T5IDbdZXnfz9Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Stacey Son <sson@FreeBSD.org>

Add implementation of uuidgen(2) syscall that generates UUIDs and
converts them to target ABI format.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 7587ffd605..9f1cc8a0cd 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -32,6 +32,39 @@ static inline abi_long do_bsd_reboot(abi_long how)
     return -TARGET_ENOSYS;
 }
 
+/* uuidgen(2) */
+static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int count)
+{
+    int i;
+    abi_long ret;
+    g_autofree struct uuid *host_uuid = NULL;
+
+    /*
+     * 2048 is the kernel limit, but there's no #define for it, nor any sysctl
+     * to query it.
+     */
+    if (count < 1 || count > 2048) {
+        return -TARGET_EINVAL;
+    }
+
+    host_uuid = g_malloc(count * sizeof(struct uuid));
+
+    ret = get_errno(uuidgen(host_uuid, count));
+    if (is_error(ret)) {
+        goto out;
+    }
+    for (i = 0; i < count; i++) {
+        ret = host_to_target_uuid(target_addr +
+            (abi_ulong)(sizeof(struct target_uuid) * i), &host_uuid[i]);
+        if (is_error(ret)) {
+            break;
+        }
+    }
+
+out:
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


