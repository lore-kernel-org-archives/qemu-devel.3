Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB95AC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdEO-0005Gb-4p; Mon, 10 Mar 2025 09:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdEE-0005Ef-FL
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:31:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdEB-0007Lt-0t
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:31:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so8396225e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741613488; x=1742218288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBpElQ4Pqj9BqrwpIU6G26s2REXnfqUkRY3BGOLO2sw=;
 b=lJPk63vCnqA6IIssNNUD87rhuViNPy/h43fxfeusEhokV7DQyFXGPXzApcUAW/NSrR
 701AVjCpvluMEZsbAoRl7eZgBLcNmNoWXoQ4u/ZkCRYuMpW5c3tbQjVTJlyC8BrDTAXi
 9YEMO2tWgmiSzU0+GLqewa8EL3+LzZFzjuN1Lm26dwEeqWg8/n3gUaDZ1l3Vo03ApzkD
 TB5/MPJq5EV1nvpxIgS6Bu0IfIbO7zfmX1vow2ZrzwkF/ttvco4e7qz7rejwYIZzX4kX
 tuZ4wMMMhSF9wM4yM4k45cGZM6DaLtP2KiSPkM9zKQZOXwyJmRRqVES55lF2xew8QcTF
 bbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741613488; x=1742218288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBpElQ4Pqj9BqrwpIU6G26s2REXnfqUkRY3BGOLO2sw=;
 b=soo9SzB7pE91bQtZyD5wh17ilnv1QMFngGNfU65rIdf7PSN3f20bT72opoIiJv/8y8
 9PhE68z0soClWUepGs10M97dnoipQJEgV4SoRRLTfz+cyYPxyipkwD7srsdz5dCiI9p3
 m6AnQXFQp4OT/JUaDgZQqiWbaXPChXDwzsvH8SDZj6QXOH7KdMdXSJNbpjFHLQCGU4TO
 H6HIXr0bPaKT+G+Vzc+joDEaK83YbiRgz+ZBMDM+SrCYg58XVIvHjUZraQTY5t2AZbge
 /9RkFkeomzjK9tWAx6Gpzvqrbma4jl+EOxjhsBs2gJOkXJw4/EFu7IEbxRbu53xIjRmo
 sIsQ==
X-Gm-Message-State: AOJu0YxqVhEjzN2xniKQM5qedRRtuLrjPkBqkYgnPuYVEk5X0XIjPZgG
 LEDoaTmoPm7r9vNM80wcgBObnHSdzP7cErG5/R1i5AbNkF1zkSklr/D3uQSX+zEBySA8Y213ko8
 D3I0=
X-Gm-Gg: ASbGncvTCCkZu4V9WF+EVlEji11KXQDm0KHDT2b4sLO9EnfBUTKeOa1ursVqWCnM26W
 a3gtQER9USxsSP/dCrS0TDOV2mZs+GhJbyZIFcELHwJ92zcBihyi3zLf/5xQ13EjtjWI3zfrzlV
 lJP7fMivWyWNLthaDrB7WwdCDFjnpbH7ymhnQVAehzaxpCBM6fxTQbKqJG0w6Mu7L4i9QNLcNgC
 yub2Eqow3rSiSzVqbsX9iPVURwFCkmPwk1rXzxYxpAGhbtkXRKgKjkbJK7edKwgVukMKNZLCn58
 bSAVjtFi9yNs9F+JzGfen2Oyky9rfdMgXsBvFwHlUVqE83VhlbtLcUm4vMUyyAq2jZc0iB2Qu4j
 3q1ohkmoJ3F/Y40ev290=
X-Google-Smtp-Source: AGHT+IG0uCuQRgyS8qdzFt5CodFi+okPBZR2avXfkOccfNZma/wJCW3RTKYIx/P1pQmbFyuH8FagAA==
X-Received: by 2002:a05:600c:354c:b0:43d:94:cff0 with SMTP id
 5b1f17b1804b1-43d0094d439mr6442395e9.19.1741613486294; 
 Mon, 10 Mar 2025 06:31:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031e3sm14690300f8f.82.2025.03.10.06.31.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 06:31:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] hw/s390x: Expose s390_qmp_dump_skeys() prototype
Date: Mon, 10 Mar 2025 14:31:16 +0100
Message-ID: <20250310133118.3881-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310133118.3881-1-philmd@linaro.org>
References: <20250310133118.3881-1-philmd@linaro.org>
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

In preparation to make @dump-skeys command generic,
extract s390_qmp_dump_skeys() out of qmp_dump_skeys().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/storage-keys.h | 1 +
 hw/s390x/s390-skeys.c           | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index 408d2815d4d..d4c7daae6c1 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -122,6 +122,7 @@ int s390_skeys_set(S390SKeysState *ks, uint64_t start_gfn,
 
 S390SKeysState *s390_get_skeys_device(void);
 
+void s390_qmp_dump_skeys(const char *filename, Error **errp);
 void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
 void hmp_info_skeys(Monitor *mon, const QDict *qdict);
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 811d892122b..686c118ebcd 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -142,7 +142,7 @@ void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
     }
 }
 
-void qmp_dump_skeys(const char *filename, Error **errp)
+void s390_qmp_dump_skeys(const char *filename, Error **errp)
 {
     S390SKeysState *ss = s390_get_skeys_device();
     S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
@@ -219,6 +219,11 @@ out:
     fclose(f);
 }
 
+void qmp_dump_skeys(const char *filename, Error **errp)
+{
+    s390_qmp_dump_skeys(filename, errp);
+}
+
 static bool qemu_s390_skeys_are_enabled(S390SKeysState *ss)
 {
     QEMUS390SKeysState *skeys = QEMU_S390_SKEYS(ss);
-- 
2.47.1


