Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcNV-0000aC-12; Thu, 15 May 2025 13:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN4-0008Hy-C8
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN1-00026r-UY
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso1188152b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330066; x=1747934866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+mqRJjW/uNU+WmqEgMnh4Q0J4iLqGLa+X8vg8xz6/U=;
 b=KKZDqRVu6WJmMaeHaTX83lcSOtJUuZKjThnNMj/deUZWxrAnBQW80FT07tCIZlEGPJ
 VVdpZRy46sFzW85KzVmy9H2ir+z8kko3ld+7zATi01uw5G2oQv5UArAkfzbOLCD0KeXG
 r2jzonIyjF+sfqUC+aYAvzH3a6lEjZM8NYvnEnINlWwTy7Mjosx+F1IZlO2x6LQWoE9B
 lIjdZ/AwK74cmQUlbRDtx6I+vUmAWsf4JBeQvZZv8aFSF3dUG8wwqin81z2QteLVIL9W
 n2n13+H8O5cUHeHZrcTWBAL/29745fmF7f+jMYkzdIScGkVli681ZG+8FvRNkr7WUWvp
 yvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330066; x=1747934866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+mqRJjW/uNU+WmqEgMnh4Q0J4iLqGLa+X8vg8xz6/U=;
 b=Pop9JEGvS/bXxempm7bzgV6g+8WMmHx3hOT9v9WzL97ZYTdzHH6zZHithP41P+Vh+i
 VXumNeTLn7CIfsYr/tqXjgi0YkbnRm+zquIbCqt/9rZbgw3a70TPREm017ObQMQAwqO5
 A0fpyUhlQHn9gr4iANc0amnIV/XoFAP/9LMIgJUONw8ilM9Hg9DfDL+mto7AlVi/ce0s
 a9BoHlC0yh+ryqxvaxMqxeSE5UyD76p1M9z40C/V9H9RA7re0l+ejX6ompYckhjSxjjJ
 sIH7CUkCUZuUXeps/n0ax/d8eIW42PRN3/XiFoWrU71bz/P/RnpK+u1tyY1KXP/AvFi+
 KoMw==
X-Gm-Message-State: AOJu0Yyqy6qnaeI0CQcTE3KpUtyeeVo71drjpLS/6qZ7FevgkZOqXjPV
 Ta1u0Bdnuz3VlIccALbrtvi9vcVK+Et2SS8lkD/APO75NvYAHT/v64yawvUdJU8kVHKqPla1Bh1
 fsmE3
X-Gm-Gg: ASbGnctOvFsNyxekU/1Rexov32hgbERkW2yz9+r+VPv6JJ/DLYp+iLCHbkIayv5tVAC
 4RNVuKOlkztdTNT/Cok2910CLc/bPVwD15VbxUJr7ufhAiKJxzhbPIYo1sHdkCKe3jkFkW6rRzd
 lXze4iOR+3GhYonaVBhfu1TjjMf+rMHFSgmiOZUEQyJLe1jAbyR5ybR7kwnFTpB6aXMKCZrzI9P
 DyiR+ENybIrcyZAgYGpvnD+2HVesQsey5mpKwJ8mysd0dKJ33dWxjygaIHB4KJkD9x7UPwf/mob
 i7pRyH14U6yAz4YHuy2WqAUS7mAYWUIi0wLfF047M6AOsGEkPTI=
X-Google-Smtp-Source: AGHT+IET3uA0fgR+OFgadqtmZBY6JMhbspU77fCKtzmBvgOpskWYCt8zJI2gt2ECUQ4+gIz/Lm3asA==
X-Received: by 2002:a05:6a00:a8a:b0:736:b402:533a with SMTP id
 d2e1a72fcca58-742a976ae04mr257987b3a.1.1747330066575; 
 Thu, 15 May 2025 10:27:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 08/12] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
Date: Thu, 15 May 2025 10:27:28 -0700
Message-ID: <20250515172732.3992504-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


