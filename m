Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F53C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsni-0003uL-FR; Tue, 12 Aug 2025 13:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsng-0003tT-9N
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:28:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsna-0003S1-Qp
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:28:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-458baf449cbso55809925e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019711; x=1755624511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbl7ajSiNJK7b98o2AX/9HHrEnoB7DYhJ//FpfdP6jM=;
 b=u9NhJHUCeUCuIDAVsXYKdi6UDFRxaSuwt9FOwMvauvClqqPAlL8dU2GllHqb+hJreg
 QZLwta/8vayWRloeZRJ1RyJJWLcvLAwITj+/BnydNakKoHWap1qBuA42VdHb7an5DhzH
 uMjII+KW+sWEMeMRqNUpMKWQL8hY4B93xX+C8vk5gNxW3VejlfOtKq3Pj/IErHKO3oen
 MUVnk5ra98AItyygnoxQ+6Tb2ARnsVt7ZJZDmhXk6TZeJhs5s9TXI82l1QYPoihWRq2P
 +JaAnEr/fn+ydwT0t4nk+X6gpW43pJWVE47KFSVJb72hA01tNsT3P5BE8AQVezoTdqs9
 tURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019711; x=1755624511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbl7ajSiNJK7b98o2AX/9HHrEnoB7DYhJ//FpfdP6jM=;
 b=aGN2T6yGk4oF/asr24NJ58xc6XP82455IPO73NtAWh6v5FRO/dCH2zVcb6P/XcvNF1
 LlcftPJiqZrRNpUB+hkX1bPcI/WizX6i82rkZKtRXCmKT8cfvWjaxfeAzCdIwQPZYTrm
 iRIqXZW1DwvJlp5eu8TP++4bgJgHU9ZZ4e7K3agoVBBKQBfk04NCSLM6YYOxWtpQTuc1
 y1EcIi9A59+AADpbVwYd4Xd/uQMpciM/5wS2v6tScnZbkrxA3SCP/DzG+hhvhki3RkvE
 ZdwDsQ7uP+9Rswev+AIl/R4tIYQF5TOLUFA/F+sT0NHs5dAeFr8Y1djRAJBR6efaTyAq
 0uCQ==
X-Gm-Message-State: AOJu0YxaPJIcjyXSi5xldyOPD+vwx2Dnmx5st6vEjWjfTt1BBsI/OGQA
 QdPN5SM1dI1VLvtZsCvTKh0//+rQdQPsqNUKqjZPnzetmdzOKI6SEspyixjxSfFrsjcbUs6PrGA
 xlw9j
X-Gm-Gg: ASbGncuRP8PcDBiw8pd0TmZxERKDpIu3d0lYcj9/a6ZmqgPsrXtEeDMok7uQ3/b5R4v
 CmSVsaE3apqOKwEBju2mJi06I9YkvLm5GOPl+3XIzfJD4BOCh9I70T6Q9HmyefClfiBCKMftQg0
 8cqStUzWo8ijMc+q4q353pHf3xWHjm+zrUboSKigeBrTVknhEXZVcwd0Pepw6ft9t97q7DArg8W
 V6UbgI4UcQqwHAdXp4k70af8CvA0ldWyzPV8GAiEFtcn+CbPiHR66SSYP84Zqjt6itgkzZMF4SS
 sv29xLR5coLAQkW4N7R7hKeN++WLqstRGH5vriVy2BpZ4Otx8t2jACRR6nE7VjoeLvSTgt7Cpr+
 sDlOrfnTYXV5ZsR02KXUhTZnhvsfnFearprB5XshGXiKFwJVV4XU98k39Zlk3zhgpf5fVA164
X-Google-Smtp-Source: AGHT+IFWwbaQHe23BReftsVg783iD02j6Cp/qQHnk8XrfTKXBUvofgvLXMly9n8OdcFF/Pl/0k18wQ==
X-Received: by 2002:a05:600c:45cc:b0:458:f70d:ebdd with SMTP id
 5b1f17b1804b1-45a165dc8dcmr54605e9.16.1755019710554; 
 Tue, 12 Aug 2025 10:28:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b4f9e952sm444632735e9.9.2025.08.12.10.28.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 10:28:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Miguel Luis <miguel.luis@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/10] accel/system: Introduce hwaccel_enabled() helper
Date: Tue, 12 Aug 2025 19:28:13 +0200
Message-ID: <20250812172823.86329-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812172823.86329-1-philmd@linaro.org>
References: <20250812172823.86329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index fa9228d5d2d..49556b026e0 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -39,4 +39,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


