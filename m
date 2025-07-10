Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53E1C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvOF-0005gr-Mx; Thu, 10 Jul 2025 13:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZujr-0008PT-Sn
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:07:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZujq-0008OZ-5D
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:07:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so692417f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752167232; x=1752772032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XxLajNnEOgzn/U5YhS2+NClHEe7hBurz/mJ58vDCYw=;
 b=rP2Ovl0LN8w7S8pHVPAGLWlar6a1WKfLCgFARIx6EFQ49fDmLVLkCzF0jM7U+LtvH0
 cGUjXPH0fO8ThDuoE3DKvCGlj8XXHgcs+5QtlRVIkF0GQyaLUOF4X3A5C9chR7YEvhoC
 lbXZFlT2qdOBk9yBjFzMHYfJnPsloxHXOcH13HmnVmQeBYOzL8u2NIFElFzBGTrJsIyn
 dotACC6t9on53JMYYzWOYst/ROioMuMbBtH6XuuX9OGLjISBqOZ34Yl4U6UCR4hV/6OP
 qIAE+rCMDPi7hPod3HZRSw2f6StCx728grthjTgCSDlxBAIrJl02vGZJv+TFZgxkPbUE
 Fitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752167232; x=1752772032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9XxLajNnEOgzn/U5YhS2+NClHEe7hBurz/mJ58vDCYw=;
 b=k8qgL8rWorCsmN0oRHmLaNlSrZSwwVzH9tkSyIjYP0/RM0LH7t4fpOe/+J6z+3hoaO
 1cD0GeAhstwCiv9/R56yIavcTGznuj4aDR5ZpDQYDA9YV+FxjNHF6OXiVwhzploFIGgg
 Vghwk/l62+qJG9iFxcVieyip0H7KPa9z2EX9elaGQX6lAl0adD8vhNnMp24C4bSaSCQc
 OdhWNRnNouapXi/U4OQI4QMRx2HtRy0SotidFqQLUp4qs9DZP+CAmQh80VIEsmUb57RJ
 XMmJ34v4QlSDO9JEjeunVTxQv5GETICLTTJPF1xzUT6F+PTtbvrdm3zIE7MAE0V4WGAI
 uInw==
X-Gm-Message-State: AOJu0Yy3CsRYeBFuT8ZHy0E/Qt2+h3lzoiZ3SCvFmpkdtZJbT26H+cUJ
 Aib6lUPTwWnl1dkNcsn0hy48NK3q4tPTk72NZ8hxig15ugFHXEN7DccmQduCz6uwRl9Is+V14Yi
 iPWMr
X-Gm-Gg: ASbGncvjwKMEEEM7/PTZiYGV9zAQbmQRu03LZv37gnpisoLHTZXpc+OIPLM839rp4eZ
 oiGSHXnAGh6WGJrqTsN/275j1Gu8aCL4/JnqSs435/Ljcg/+EE1argUjZD/p5Ue+3MzFDXhAj3Y
 Swv2s7x5ek7tkfg5M01MEf8nFltdC3G7BYf6wps/QW/WktX52tV3orko1wGthqKUgDls0Ntie5q
 G2HFWfc4BwGLW2JvXGCV9Do5+EkZ8bLK2I9fAfIbZG1nob355lq93YDb5exUJT8DKCZmDCU4IdC
 74iefuGN9HUQnRN+thiHaX6AiUTN2jWAitZgFTBDRSOCL8CWeLk4ANpTySDfIYHY7qkj
X-Google-Smtp-Source: AGHT+IF6wdyzel+pJKvTekPtIacF7kb0VNo03aq+EHs3rJo3cAAnRLvs9B8N0Ce/CRjRlmJ8SnWADA==
X-Received: by 2002:a05:6000:21c9:b0:3b2:dfc6:2485 with SMTP id
 ffacd0b85a97d-3b5f187ebcfmr216275f8f.4.1752167231644; 
 Thu, 10 Jul 2025 10:07:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1924sm2392681f8f.16.2025.07.10.10.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:07:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/2] linux-user/gen-vdso: Don't write off the end of buf[]
Date: Thu, 10 Jul 2025 18:07:07 +0100
Message-ID: <20250710170707.1299926-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710170707.1299926-1-peter.maydell@linaro.org>
References: <20250710170707.1299926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

In gen-vdso we load in a file and assume it's a valid ELF file.  In
particular we assume it's big enough to be able to read the ELF
information in e_ident in the ELF header.

Add a check that the total file length is at least big enough for all
the e_ident bytes, which is good enough for the code in gen-vdso.c.
This will catch the most obvious possible bad input file (truncated)
and allow us to run the sanity checks like "not actually an ELF file"
without potentially crashing.

The code in elf32_process() and elf64_process() still makes
assumptions about the file being well-formed, but this is OK because
we only run it on the vdso binaries that we create ourselves in the
build process by running the compiler.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Hardening all of elf*_process() seems like overkill, but this is
an easy check to add.
---
 linux-user/gen-vdso.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index 1c406d1b10f..aeaa927db8f 100644
--- a/linux-user/gen-vdso.c
+++ b/linux-user/gen-vdso.c
@@ -124,6 +124,11 @@ int main(int argc, char **argv)
         goto perror_inf;
     }
 
+    if (total_len < EI_NIDENT) {
+        fprintf(stderr, "%s: file too small (truncated?)\n", inf_name);
+        return EXIT_FAILURE;
+    }
+
     buf = malloc(total_len);
     if (buf == NULL) {
         goto perror_inf;
-- 
2.43.0


