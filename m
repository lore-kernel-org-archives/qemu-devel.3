Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E762C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxq-0002AV-A8; Tue, 28 Jan 2025 15:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxo-00029m-Nf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxn-0001bn-75
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436202dd730so43188005e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095214; x=1738700014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8yhgw/US2s8vhHgTXVEqFY9JXaMh/At+bqt3tqy4Os8=;
 b=Uk/N11iaXxdiTY1eAtHiloecu+0yBDHE5PW5iZQ+mvtdflQgEi3c7kfG4N0/+gcNUo
 MgFSA/TrY/2ZWxF7CAXbcpmqUpcCj3DlB2IGCE8cf5f4muuDgas9twsOtbHIMkp9UNZ6
 obs5ynBXesrrU79Ra0NfkuQIDsEJgTF7GQd0bkDH0yKnnZoH/nzT4iGsS4JjwtTmeUOq
 6Ik/2SmygADdnj/3i8nHvUVRUZVYGg+W+1p4id5a4b05cqrsPEt4VNOxOO9mfex6+z8B
 QqZtuw8PZU/L/0ez7Fo7NtqWsqwuTQV/4l8cVtWTWymE+9QA2P+yCydfhw9gQmd+94BE
 9aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095214; x=1738700014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8yhgw/US2s8vhHgTXVEqFY9JXaMh/At+bqt3tqy4Os8=;
 b=n8ww86+qi4b7vL4eT6Urj+JrjZmlyzLElm5V4WleUFEHIVKDcsq8eWcoKXq+LRR97p
 7vnfEoox9zFC6O6nuquYRHGojMv2I/PlMz6AS2r1OmwpWPbYTiwToW+BMdmepSm2d1jN
 yJyANOunfwN2Z+D7dmC+vD5iHjVNrbZbC6h+Dm7qtJY+lysor1p4/ZZiGb+4P4EimBdZ
 Kn2xQKckFABu3ortQNeFcZ215hFkK65eZvWLTT8FArImOu6cxOCv00hc+naurc6VbveJ
 XNc119Qzt3eCJxMMNPgkqLtoFpnn9xXEv/E5INank98rQ6YNIQI+v6b36Fpcp2YG6RfZ
 FSiQ==
X-Gm-Message-State: AOJu0YzNfDnMVXg7puAAkU+LbUvNoIPI/tXq7zSTL76X08zthXQsOJQc
 VJkxDYEqHsomm/FV1f+c/cjHfD+H1Zxe5mB94N8uqKs+bCoUuBNKjM7cTSHvgtwH9GGaQOPXy+e
 J
X-Gm-Gg: ASbGncsdnbtW64DU1FQMpkzksELN0l6VonGTKIAsoiyd8Jqb5iUIyiMDzcX9HhiZbFI
 wZfL30T+iEnzlM/2QdBua9NE6pV760GL6cBkQ4298PPpaVaKcQZ0e5JjKY7SZkmSJaVB8yaowBE
 e/q41mQD+lDUNeSCiUJAAlQxfuc+5oHuNOuQ8jlIzvqQLxS2soB/Y9giV7te8O9vW1qn3PDz4SD
 DF4Jt84OVktJHDjF+JVrcbGEE6fJm/a1/a3V8/Txg8ILYd1l3y7TDHZ1aOg5pYWoQ8xmeHrRb0b
 kUg6EY9h/xZTQ/2X1viMMg==
X-Google-Smtp-Source: AGHT+IF9yhNudWSq0EYGu/vCMrF245pCrXRDwetRuD6BxqpT8qOLb2B/NwrXQHYx+9Ane7wdiE771g==
X-Received: by 2002:a05:600c:a089:b0:431:547e:81d0 with SMTP id
 5b1f17b1804b1-438dc3bac30mr3113605e9.11.1738095213828; 
 Tue, 28 Jan 2025 12:13:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/36] target/arm: Use uint32_t in vfp_exceptbits_from_host()
Date: Tue, 28 Jan 2025 20:12:54 +0000
Message-Id: <20250128201314.44038-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In vfp_exceptbits_from_host(), we accumulate the FPSR flags in
an "int", and our return type is also "int". However, the only
callsite returns the same information as a uint32_t, and
more generally we handle FPSR values in the code as uint32_t,
not int. Bring this function in to line with that convention.

There is no behaviour change because none of the FPSR bits
we set in this function are bit 31. The input argument to
the function remains 'int' because that is the return type
of the softfloat get_float_exception_flags().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-6-peter.maydell@linaro.org
---
 target/arm/vfp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index fcc9e5d382e..afc41420eb1 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -34,9 +34,9 @@
 #ifdef CONFIG_TCG
 
 /* Convert host exception flags to vfp form.  */
-static inline int vfp_exceptbits_from_host(int host_bits)
+static inline uint32_t vfp_exceptbits_from_host(int host_bits)
 {
-    int target_bits = 0;
+    uint32_t target_bits = 0;
 
     if (host_bits & float_flag_invalid) {
         target_bits |= FPSR_IOC;
-- 
2.34.1


