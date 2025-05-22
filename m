Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D8BC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBFA-00012V-8d; Thu, 22 May 2025 15:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBF1-0000x0-AA
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:07 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEz-0006TQ-AH
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:07 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30e8f4dbb72so7053792a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940757; x=1748545557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XV2dpKJCVW3TNJuJ7PWcXDJO5Q/G/L9iomsm6uOsHOQ=;
 b=ASd+clK+tumlkKfjra188wYk0qpokMHK2zvML79jhPc/kvE48q57Vi1iz4VB5Ki6p+
 1kN9VKYTNHMcL1NAONgIrqkjmLQCNth6oGLNnzoPYLtn+RHTQpvrfDkG1kiELrrPIqlr
 stjBlHa/DsT2OZRl04LXKCmCH0sXday5Av6l9SJM6iBQ6/NTIAIk/1pBgTs2EQh2m/Qm
 ri3eaDBbXTAf4Lhs23xL380Ez2U86RDpKlEh7fnJvv9170aPFGDH+/sYf2FQn3bqIMhZ
 MyeZ6Q/cJXEl0LAY70TXFTcqkCUBr/t5BXAi22l5rMBUzO4PwrPHG8mXg2rohKqp8sk8
 tn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940757; x=1748545557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XV2dpKJCVW3TNJuJ7PWcXDJO5Q/G/L9iomsm6uOsHOQ=;
 b=BlDfFQFe1YGeIwjoF/LIvQNNWarL05zdnXaNK8BkAXeiiuzsslayh06ckS9SafCI08
 Pp3Hoellx9HkyqM19vS+nQ08htLnbDeZ/UaTRn9kK6MCuJeakwErVBuRgwyq2Doaa47q
 ioUEQ5ASf1x71vih5c+XmcgvPQNT3TlUMxEGdaDq38hQ548T4thoVn1TzdrIa+Mn5W7m
 9t/JdhjztpXUql59Jv47qJiKGoT7Y6hUmitTKbg6usgd++D5JT/BWR9SRajohXyk/qXz
 Lxb1+W5neP2kk9ziMZxS8huRYAaAOCTqiwVOuLMWiQnPepFys30gPKEFW1wM5aB3MhFv
 Fy7Q==
X-Gm-Message-State: AOJu0YwuWELPTel+6Sl3H0UDa3wXBE1T3odG9q9m0u7V/bWIPmXyun8e
 t7jT64newdLfME5Az9sxExs+RWuS/Hxq2BISLa/9YC0ISq4NtGxRo9SWbgZHePG8ZR6B7E5AXPE
 yuQmG
X-Gm-Gg: ASbGncttWbhE3akQmzCNJwQ9LTAh5RbKvSzGT6sd690E7L9TA0b3QDq33GFeeEFZ/SU
 OBwCWmua6dttYbjD1YZuBVz13xNCtgBMPpJJj+HFuaTjtvSQBuXqzMHoLzgFsU5UZ0vXM6PFYPv
 ZRBLZ3p8nHLtzuf7ajvKHNDNMhjlwlHLEHuFMKACupF+9FWta9qDfIt+iSSCA9Is/h2+Ee2YcH/
 v62thdaXcAqtAf8J7Z2prja6leNlAmvoxc7drXMOrbW0c9n1VQS5zGEtmpKkN6vu6vkL1Ce+f2t
 sQvKkSL8YKP9VV2UpZcecaRPWU+pTms2WUkf1pk3X9Vb49CYT2QP+7NWKfISvQ==
X-Google-Smtp-Source: AGHT+IFZiUAsImfg52FPXhLDlkhE/JQ/g6vo462GCQiEctRXhvv9WpJmjSyemMq1w16nm2WtJzdg+Q==
X-Received: by 2002:a17:90b:54d0:b0:305:2d68:8d57 with SMTP id
 98e67ed59e1d1-30e830ca02bmr31782095a91.5.1747940756942; 
 Thu, 22 May 2025 12:05:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 08/15] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
Date: Thu, 22 May 2025 12:05:35 -0700
Message-ID: <20250522190542.588267-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Let's always include this field, regardless of the target, but make it
optional. This is not a compatibility break only because the field
remains present always on S390x.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/machine-target.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 426ce4ee82d..d8dbda4b508 100644
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
+            '*deprecated-props' : ['str'] },
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
-- 
2.47.2


