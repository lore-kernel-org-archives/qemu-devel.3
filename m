Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1C7CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 20:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uopdN-0003EF-WA; Wed, 20 Aug 2025 16:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uopdL-0003D3-El
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:42:11 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uopdI-0000CC-N6
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:42:11 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb7aea37cso40117366b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755722526; x=1756327326; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PavMz00Ukusw4jBxHm90s1aPkYP3XxBI//gRUXS5roQ=;
 b=PEhvcIIGGWwCjI2/tMhxNLvoTamw6FfLYj+wW8Y1xfiv9ycKY6VFe52Ees9YzowLJU
 Icdv+TUffHxAabRY4kMzN6kd+Z9GXhLprGJangrvVJOgrXFF0opKPszcZKMiGQwTBmD9
 zgcHJgfxxxdsYxt3XBpMfi4X0G8307PR7TTIX4JwvZlY+18gpD7ISymyXsGG/Zc4IWZg
 AFrh9UmA/qni4bq9U5qb7hkLGWweTAFGBT360eTI/jbEz7L+n9bx9029x3x7PwdfSPfO
 I58LljTsfg6j3pSuVAmqR43jBQK+fZEXF5CCrDnHvqm+yBbCV5YOjeU0AVuMGeFMkA5v
 m/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755722526; x=1756327326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PavMz00Ukusw4jBxHm90s1aPkYP3XxBI//gRUXS5roQ=;
 b=QE5Xk+i16ZlLrCcBDHDMakjN41fvHxDMj27qsemDHs2ew2re5doWH1jQvolYqt1N+N
 yH21uExzQTins0LGcqW9GNSfNxzrOmBM4ns7q+JXp6eK/dDJzheQnJSDwcz5LEZhgeuq
 GKTHRQ5zaW6xliiD5vYWAvkgh926e1Bf2t4j+8gCZDkIPN5rfMX8zckhv49R2cjLA1Ca
 EQUTPeF01LL4gh53qM+XQfBLDzWCInY17zs4iDcXjrSIzLpyB1WRks8SDjeSetHwnxqE
 fo5hezT4Lu9O26omMD2dsC3uTC/iqHF3y33UUV9FDc+AC6vEnpQiu9EfHveoyhXfXtGy
 pWJg==
X-Gm-Message-State: AOJu0YwMjZSQNsa6IMzmHylfk68KGxgtku2HWg9pCJrIdB0k01CI4WcC
 ecCb3BYB0cZRHlSkhx0QBL+kNUzvQgsHrDr9gep6TbQwl2fahwd+X5CIFEL4mvQeYfZZXAVmSQb
 zzBdmzFI=
X-Gm-Gg: ASbGncsEFXzMCEisIYiURm4Az0/oGWz+1R8e8NIZzDcC3oYIDpxgkmMJLIOyeobGxeM
 NDY+DFN/ktm5MqjIuH2JPvStjnLweC0RxZLh2DAplwElZ7uGwheiPWcOMIATCzbCcWXpfyxD2mp
 P0eBaQEKSyV/JHOz/CWU0hsQEdWhZr7641El3qbaIFWqszGIOsvlwLP/pU9/5mthuFZo4OTKBpS
 CU4ju9N/BdO/8Ok7WtEgwk38iLl9nxjggHQzLcEa76FvhOnSOU8j0fgZlLPl1VeFF2cfsEDWE54
 5lBTv8EpJuovnVV8zSVMWjkVtKI90xgqBhacutPEU42+JBA/x7ALuvBKHfUxaex2tE3KRxDlPXU
 uBafyJRwe+KXOlbOJblw5r1nU4yKy/JAydR4jOzIVFYUbS7DhKV7t+GkBksBr8+hBEX7VGk5OkC
 UQ/xc=
X-Google-Smtp-Source: AGHT+IGm07LcjQeIABiqBE+Se/rkX2ieZkEpjrKc9AaY8GpQk6obXRVRA/RK5HoEKJgJNccJynqidA==
X-Received: by 2002:a17:907:9726:b0:af9:5366:b42c with SMTP id
 a640c23a62f3a-afe07d4c190mr12832866b.59.1755722525713; 
 Wed, 20 Aug 2025 13:42:05 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441256.home.otenet.gr. [79.129.180.152])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afded5353cdsm246888166b.106.2025.08.20.13.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 13:42:05 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 20 Aug 2025 23:41:56 +0300
Subject: [PATCH 1/2] scripts/minikconf.py: fix invalid attribute access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-scripts-minikconf-fixes-v1-1-252041a9125e@linaro.org>
References: <20250820-scripts-minikconf-fixes-v1-0-252041a9125e@linaro.org>
In-Reply-To: <20250820-scripts-minikconf-fixes-v1-0-252041a9125e@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=uI7P2gs/QiD9gXKg6HW+/la5twJi5HPTzSwCcfxFryU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9wak1icFg3cDNQOEt0QmRxS1kzTSt4OWx6UXJQClN0WU5UVnVPcUN2NEJWTDVN
 a3VKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUtZekd3QUt
 DUkIzS2Nkd2YzNEowRWthRC93UFJqcnR4YzcrVEh3Q0dFNE10cnlLMHpCNTh5Q1dKZVNVRkw3bw
 ptUmNQRFYwOHQzSmN4VjRoT2p6VnZxSCtua1ZDT1ZoM1UxOGxkQ2FPTU01aGVrdENCcmJtcFdxc
 09SUFMwL1l5ClRPa0pLRzh0YmdPQm1UVFFUVkNMZFJ6LzVVdmx0SnAvWGJobFdvTDlpcFNHRWJH
 MW1nL0pLVk5PeDBJSHNlaTcKditSUnFtc0tkZWdRaGp6endCWmVjWEFlYVNjbldOZnh5YTliWW5
 JQUExWW83Qm11cERBdmdlTHlsVUFlRXFYZgoxQW5sQU82TDg2eUszck9aVUZCMkpDM1pnN2tOcU
 Z5OWxTZm1QK3JxQ0F0S1I3VVM2dmlheTRCSXU2NjZOT0N2CnhWTHZUR21WNzNVZTJ6TGxaRnZHd
 1hZdC9WQkR2T2ZKM1RpcWRQVUdTdmVXbFpRYTFSZGNoamRJaTB5aDFDSzUKYzhLaVZtUHQ4cm9y
 S3lDZS94TjZvZnJIR0xqSjZGN1l2ZjZZbEdoRDJvVkZsOXJxZ2J6YnliRm1hS1p6aE9hTApxcyt
 DNUdyN0lqNzBSUUw5WnhiRUIxT1lIUU1CdG1kZC9Ea203SnhEOWlabDcwdzVVWnorSFdoWm9YRG
 Roa21SCi93SXJMS0NlcTRvZ3BKQzJrbmgzK2NhWVBGYWJDSEZHVHNrNHJVV3dUYW5MZWlUMUVmc
 lVuRFBsTnZvTitCc3QKb2k5VkVWS0xHZVAwY0JMd0tnT05JM0RnN2JPTjZZQS9VRG1hNklCQ3l3
 OGJuZzVLdTM3S2NqalRGZDlydW1WZgpLMytXMWtMVkV0dUFEZWx4TTNia1hsMWxPMXVJSE9oZXo
 3anJQNjhtRktxM3VqZDNYSHM1dGF1YTNMUFpzMTlrCll6RDlodz09Cj04cDN3Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

Fix parse method to use `defconfig` global variable instead of the
non-existent KconfigParser class attribute

Fixes: f349474920d80838ecea3d421531fdb0660b8740 ("minikconfig: implement allnoconfig and defconfig modes")
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 scripts/minikconf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 6f7f43b291816d2549eb85c69d253605b83103ee..2a4694fb6a3891e152342d29b37661fe964cea37 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -340,7 +340,7 @@ class KconfigParser:
 
     @classmethod
     def parse(self, fp, mode=None):
-        data = KconfigData(mode or KconfigParser.defconfig)
+        data = KconfigData(mode or defconfig)
         parser = KconfigParser(data)
         parser.parse_file(fp)
         return data

-- 
2.47.2


