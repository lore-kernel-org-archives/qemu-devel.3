Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB2EC54754
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLj6-0001ZW-Te; Wed, 14 May 2025 19:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj4-0001VB-If
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj2-00034j-VG
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:26 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so4136795ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266083; x=1747870883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3uOJ9bGmUfZ/+MJDYCtssXzNui1of7VtUuGRTJFrsY=;
 b=FZTIIry/cNKp1mDve0fuU7+1M1UJlAwnbGSSaDNdNSUgwSyFUXU3bXGW+8NIveuZ2X
 +/foBqeoUhf4SLq2M3dJxB52hA7X4supCgTkOW8N/u6fswjTFyH1eesWJyX7UwFb/6Q+
 YHelknCNNoLT9SfLPxCKlORb8TcpVkr8s3YVvhR0XPKFPY5gpMcUgcF6r+h7rpQZtJip
 LnEJxW1+RML1GQVUdFS/qx/bHLtNkF/4S9B1194FwHlxqn6c0eEyzC4gR+jYrpgGn+8H
 fcA/5VFgyvKyzwsgoVKtmKBm3SJ5qAAMb6N8h6nb27ONlWEdg4ossevhlsTDADAr6pbq
 Jj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266083; x=1747870883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3uOJ9bGmUfZ/+MJDYCtssXzNui1of7VtUuGRTJFrsY=;
 b=uCfuLTdpQmYDfT1V1E8FQS7ejVxahDrfBrzuCc25JWMfEED1VXE9+6HNQfVMEsEafj
 YNIVQglvMJTIpRlnb12AlsnkXmJQCHqeVqouuI4vb7VMEEO5tXl07dWVmkUNpynSDoXZ
 lhw1UBN6MzOEUMP2LEVAgVdh0/4Sa84s59g01O3w+yFhKvQYgQBh7vkbcWe8StsdpDDD
 zfAsXaU/cQQREv8IHiP1gyypV8efhpFDLrlPQJsPEJq8a6IMYKCxEIZ0NoKnuoKgKJT6
 MdU9sPD2vJQoj2605MrB7cWx2kS5GxQQTEoIG1Iw5T0gi+P0QuDN7ypAHNFR3Lhfk0SB
 7bOQ==
X-Gm-Message-State: AOJu0Yxn8+o/sQyt/qXV3gmErclS01pHJ2BrsAVR4WV5r5TAmQk7zP7z
 35TVAaRbHkEW4gJwzCoHdExrE+TYFSt3i27reifv9c/y58puzrbYOH8j8vBBaFJEF/X3Cp2rSHD
 jyAA=
X-Gm-Gg: ASbGncvfBPM/+sfHU/B/qpPMt7dwKaHpuduFneCMzJ39QSVYp9aih8l3kt/4IxeLML3
 qDhRYXaVJxOMf6NHfYjbZ5K1ffSj7infhRHkc9B5TRbNgOV4cscngc4O4B62Isqf9r0BYUvB0fI
 fIqwt+w3IyYGzXRG+mqtBULsCqhvkNkg8GzoPfThMFv+HmcNCb/ff6FKLLCnzhZE4ZMc7Yf4RIQ
 yYZuab2oQUE0W6S4cECuJuo035y0Jy6FSY9cZ/IAHDLc/iS8n5n6U+kLOBZw3iAstDywGQOOJCa
 1GuTmGJrya7hLYKjWA7324yGtY73Xv4OIz2KU2Aro6Y7cjTtyBE=
X-Google-Smtp-Source: AGHT+IE10Ap5nnPw4DTnWCopJkuP3Ek38TaVbD6olF+kbecOHqCElUIaONtZzHUYKMk+akHOIv7lhA==
X-Received: by 2002:a17:903:1aef:b0:220:c164:6ee1 with SMTP id
 d9443c01a7336-23198129cd1mr89640135ad.32.1747266083245; 
 Wed, 14 May 2025 16:41:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/12] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
Date: Wed, 14 May 2025 16:41:04 -0700
Message-ID: <20250514234108.3746675-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We'd like to have some unified QAPI schema. Having a structure field
conditional to a target being built in is not very practical.

While @deprecated-props is only used by s390x target, it is generic
enough and could be used by other targets (assuming we expand
CpuModelExpansionType enum values).

Let's always include this field, regardless of the target, but
make it optional.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/machine-target.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 426ce4ee82d..e153291a7fc 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -244,19 +244,18 @@
 #
 # @model: the expanded CpuModelInfo.
 #
-# @deprecated-props: a list of properties that are flagged as
+# @deprecated-props: an optional list of properties that are flagged as
 #     deprecated by the CPU vendor.  The list depends on the
 #     CpuModelExpansionType: "static" properties are a subset of the
 #     enabled-properties for the expanded model; "full" properties are
 #     a set of properties that are deprecated across all models for
-#     the architecture.  (since: 9.1).
+#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
 #
 # Since: 2.8
 ##
 { 'struct': 'CpuModelExpansionInfo',
   'data': { 'model': 'CpuModelInfo',
-            'deprecated-props' : { 'type': ['str'],
-                                   'if': 'TARGET_S390X' } },
+            '*deprecated-props' : { 'type': ['str'] } },
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
-- 
2.47.2


