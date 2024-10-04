Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B48CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlIr-0002p3-F9; Fri, 04 Oct 2024 12:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlHh-0001Kc-Un
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:36:09 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlHe-0006b3-TW
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:36:05 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fad100dd9eso26961711fa.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059761; x=1728664561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OORWjVjOZFqIjyOcIzgstQ5I3F8E3+RG/c415FzxU5E=;
 b=TyBD6zukJ3Kij6T6j4InFLVBuqL1a3MAlIXxjuTQxV+6Zu/i5pii/71GF6SuoJ+gHs
 6QMFLfe50P5cywZ3AfnS0b3MrU/zpe4boKYgyuQCLnhZ86zQDyUopGvPTempbvuTtX3u
 yGoHsb/NMoF7QWg0nrtr8sgTIQMqwDljtbUZkA1CWOe6mBliX7MDXl0mhwuffiatMGsy
 Gp0TqnRmuZWfmz3dtoIYm8KsW21lMB1QrvmvvYFN0qEXcXfkBwVBscjRcZ7/SFIFj+e5
 gAtkaxlPV5eyFdzv75CRKZMoZmWUeB3q86j4plAg9j1L4r/gP8E6dgH9XNs+Nz2Nm4zO
 3RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059761; x=1728664561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OORWjVjOZFqIjyOcIzgstQ5I3F8E3+RG/c415FzxU5E=;
 b=X/ur9Y0RuVSfMcEM2GTCwL8yFDVdeZydpWTkKWJiiF+uN1wuR/INrGZiBdxBgxIxXW
 /wgT/68GuTc60B7Sq+EgVKXC6nidO7/CB9pODa2pNpkj5Wf3waAb2RshQoIXiXKW8JJI
 vf1miI34CmcfWQdsaC0EMmXsmEI+YJdSZeAVJXkYSklRoKopG9rkLA6rPRfirjIhJQWZ
 wep0BHa+1VUAGEUkYTB66T1d2v2C87tKgFXLqz8y5ALiabaHCG56iRKJUV4CVa/RxUJs
 Pjp0I8+oJ5QpbzSNH079bjxEeY2GVYdf9m03xK/gmBBocfqZfVZWqDTqhe+JZbY/fsOp
 VgmA==
X-Gm-Message-State: AOJu0YxTlcj3fZHWLKNRVNuBJdMSWeKdudYtcrydEtsIuE5bbH/BTZN/
 VjWPM/bdGXmtFa/kqePTg8mZN344+Mdpu6Q8kq7Fn1Oeot2+FSZvWhmEhdjIRMRQm4xWzpDEk0/
 7Xl/RTQ==
X-Google-Smtp-Source: AGHT+IGThjDUuL9uRpDV3ZvuaVWWraIJPbDLq54yh68I9sL1Oe1J7rZUEDrM7ohnD0TaA40IBq0wDg==
X-Received: by 2002:a2e:a543:0:b0:2fa:c5b0:3994 with SMTP id
 38308e7fff4ca-2faf3c60358mr21419471fa.13.1728059760737; 
 Fri, 04 Oct 2024 09:36:00 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b336c3sm214031fa.113.2024.10.04.09.35.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:35:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 21/25] target/hppa: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:37 -0300
Message-ID: <20241004163042.85922-22-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The HPPA architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hppa/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 0daa52f7af2..537d0d2dfff 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -150,7 +150,7 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUHPPAState *env = cpu_env(cs);
-    uint32_t val = ldl_p(mem_buf);
+    uint32_t val = ldl_be_p(mem_buf);
 
     switch (n) {
     case 0:
-- 
2.45.2


