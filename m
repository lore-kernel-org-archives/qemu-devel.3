Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876F4D597A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 20:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAxem-0001LC-2G; Tue, 12 Nov 2024 15:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeY-0001Ha-99
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:23 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeL-0008T9-CY
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:20 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so3825307a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 12:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731443887; x=1732048687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=77EDcqqX9a5GfiHvqq5TNPelFIgzWuyhNUEmQuL3org=;
 b=sFhFvfhlDdXfau31+BvCaSc8PAT8lw3K2VcSafE8YF8bMhRqhiwajoHyEMo7n3xJq9
 iz5X9alsIgpYW5MW/DNo3DQca89oeuJ7QInz51uKzvyBfV7NuezITao7OrTEBtx2WVPT
 Sh3K0otg1gYIreV/X8Tvy3FSf4p1Ylj3kNa8LUYbGQYwTH6BKxP2MXBbXc7AR35a7JZw
 fAvQP8yksnUMBVuWjY9EcFofLhmfkx40W4VyoTJScd/oKFQDYkEj4IKqHcyxP2ZYFLU0
 Saq24geoKkRcevTmAN78bb01JLUIQdjUa7hmE+b9UvXcvvvmg2MHNMBKFK+wAWHeKZxW
 IJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731443887; x=1732048687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77EDcqqX9a5GfiHvqq5TNPelFIgzWuyhNUEmQuL3org=;
 b=HU2se/2eagKTcpRYPnoZCZ4c/rpExsZghq4W8Sj3mr2z0DJXmOmWfqnKmga+w5PWUj
 fc1g0n/KB4Qs6joWYmZX0nAdUEfhZ0aHCEUFFBSWwEQTCB73X/90OECUKZmyZYfzqtqK
 zLE46Wp+bTRRjr465QMEH+rWnpe5ZGkriILZyzMGMN4A4AeVdl/+PCKsZPM0A2GxuOCK
 4lWMYxBFvkrubMQ1OI54ZzaBWoaQnHEB1CB1E2q2RndeiCBkrNySlDG9CRNrmnpJgFXF
 3KozrklYnZMTYxm/EalchKMKnR9TsQOqEZ9OTk6LY9zRHsSVD0x0vTNL7BgmnACdAWsb
 FQBw==
X-Gm-Message-State: AOJu0YyRiCB50z5znkYg+4ne/1RZ53dTNDxNgkl4MxgQPp8JiysJsweO
 kxvDOmhSOT7ZMEQXudjQlRZLYNPf33N0xFYKvSFEpbzAB040gO7wlPNE91l81Mnnh51uXH4zFYM
 s
X-Google-Smtp-Source: AGHT+IHRJsRJkKSnQuPZ+mEvBkBR/WUcdtxWnP3JIaoiLg06i9MoTpOsZeTP2FFkuLQkTfiJfFVj8w==
X-Received: by 2002:a17:90b:3b4e:b0:2e2:d879:7cfc with SMTP id
 98e67ed59e1d1-2e9f2c9062amr348877a91.21.1731443887247; 
 Tue, 12 Nov 2024 12:38:07 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3894192sm9860a91.21.2024.11.12.12.38.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 12:38:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] linux-user/loongarch64: Reduce vdso alignment to 4k
Date: Tue, 12 Nov 2024 12:37:56 -0800
Message-ID: <20241112203757.804320-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112203757.804320-1-richard.henderson@linaro.org>
References: <20241112203757.804320-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/Makefile.vdso |   3 ++-
 linux-user/loongarch64/vdso.so       | Bin 3560 -> 3560 bytes
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/loongarch64/Makefile.vdso b/linux-user/loongarch64/Makefile.vdso
index 369de13344..1d760b1e47 100644
--- a/linux-user/loongarch64/Makefile.vdso
+++ b/linux-user/loongarch64/Makefile.vdso
@@ -8,4 +8,5 @@ all: $(SUBDIR)/vdso.so
 $(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
 	$(CC) -o $@ -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 \
 	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
-	  -Wl,--no-warn-rwx-segments -Wl,-T,$(SUBDIR)/vdso.ld $<
+	  -Wl,--no-warn-rwx-segments -Wl,-z,max-page-size=4096 \
+	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/loongarch64/vdso.so b/linux-user/loongarch64/vdso.so
index bfaa26f2bfe1aaa01d9a349b8b030ef6323e1f8e..7c2de6c50e706164225e82f652d4becc04c71ff0 100755
GIT binary patch
delta 37
tcmaDM{X%-eN=AW+tM-YA3hb&jk8@2<QS14Vzx}<pii5+a%{7cUJOC|W51jx2

delta 37
tcmaDM{X%-eN=Ao?tM-WmX?HPm)y|eS*?us!At};x;l^g2%{7cUJOC+;4-)_Y

-- 
2.43.0


