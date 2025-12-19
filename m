Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F43D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfqp-0000hg-Li; Fri, 19 Dec 2025 14:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqU-0000aB-9O
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqR-0006nz-MY
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso14659985e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171334; x=1766776134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXQ0JVIP0porfp6WIA5UdBF+RCWCKfVXfAFfgt7VfmE=;
 b=v7UefhSY9E48jM0jLjci2eOy3je2CNFw0qkLH0Uqp2xEspeU0ErWis1Svhub2ty8hz
 FcccUfnw4eUTF+/+KhiOSnOnLmhujkSf+cG2967vtICHjHYqMr/8JDga78sy/HnzYCrF
 THtTiWZLN4h4P9Qoi3r2tqf0xL3yuGn3qzRF/NB/wBRwr5911cvMDyCt4pBIRmu3WUwb
 7ZmdTZ1r4vIcrAgFcAPjzul3EHpW+8VTl0jnVn6vM3hTLQmQzhEDzP0HDV0zVeGXBD/s
 LIEe9sb8mHg4KQFpfGaG9GlhrV17vevcdV57pCXKIODodR6uj7D3TW1MM7gkV8tfC6Xm
 V/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171334; x=1766776134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IXQ0JVIP0porfp6WIA5UdBF+RCWCKfVXfAFfgt7VfmE=;
 b=QCUOMk30ZGwu6mNDVSpJuCDBlsLFg48AI4asDbfzxnu8A3Uip5Q9v/da/ZRkrjrddL
 ASEmgzQJ/PaksJZTVd1ILonBOJ9SyFC8L06Y96JPzarBpN2NtlgUi231v4Ji7uYeAPRG
 H1dV38sk6uGgRHTkgPm49tFrT9fNv7n4VjfWgFP9tVHoLfEjzGjpsd1Xmhm3cmVbi+fR
 mnA2VN3efgD57CtH6O9agVDgjybBJ4sDIKuknUeuiLRGxY/jZr/VWFgqf6jR98pEt7Se
 HcSqbdxsJZyUfR8cgD7uWVDqjpacmbmBY2NUnX0LFefXIi6y5fzLrjk8bMxKT8uOhI1G
 bRHQ==
X-Gm-Message-State: AOJu0YwGIAXfgh8SEzuKr6nndSpftv6KtGngu+GEj083vHGSzaA5++9v
 mnFSeUDU8KG7eLyX7wxI8maaLpQNAe5vfZL/4hOms0dC6LKSinNKj3qV9mluPWGb1t4=
X-Gm-Gg: AY/fxX5SAiTfR+MhJFwJxDfqNWbaaWrfpnyXH/UpX56tA4eD1AWA50G5orU59iXdrU9
 M8MVk1yY/GGXYswxhNaALNrfSSMYGnh7dZKJ4qPh3F0HKSKGqj7OMtBVpTv2yEgrnHHYnLDeTxm
 7ygDddp5MkQe/CWcY/ABVNtZGgKv62ap5NjWvfo2dUKkTKa5FYvxpsi96xB0PbOlMIbg+MXQXuC
 yJWcQqRrwwtzRZYQdnDGTq0DqyDdI3/xftKbfZBIhbsX9SRh4cLs5sG8REkmfNJSBfiZgI+cVqg
 wSig6fh3+nNNGVcJKAVbvtyJflA3vyMkwFt0XRcVZKdu/6Q8+nyM1veSqddbYnVaFAWy1vz9lKh
 9mIbXnCLNUwtT7KLPLB29oKizumB5B0kD+X3NEtE1MTQ/x+q6bOknyuTAETy1OxYefUxx7KQ42g
 zepOgNLN+bHH499HJQuKPeNQ==
X-Google-Smtp-Source: AGHT+IFdC0OTekt9ybDbjjAAwIH+3y/8vTzQi7VuvlPdeGli9BRRlgtAH6wvFt2VPfAiMl8LcWGr1w==
X-Received: by 2002:a05:600c:4595:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-47d1953ead3mr33912265e9.13.1766171334131; 
 Fri, 19 Dec 2025 11:08:54 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3b3a80dsm42226405e9.7.2025.12.19.11.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A4805FE66;
 Fri, 19 Dec 2025 19:08:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Bradbury <asb@igalia.com>, qemu-stable@nongnu.org
Subject: [RFC PATCH 04/12] docs/about/emulation: Add documentation for
 hotblocks plugin arguments
Date: Fri, 19 Dec 2025 19:08:41 +0000
Message-ID: <20251219190849.238323-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

From: Alex Bradbury <asb@igalia.com>

Currently just 'inline'.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <60f1ad20663f7e5c6cb00dd83fe0f1f5aa6ca4de.1764716538.git.asb@igalia.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 docs/about/emulation.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 4a7d1f41780..543efc4d7dc 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -463,6 +463,16 @@ Example::
   0x000000004002b0, 1, 4, 66087
   ...
 
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Hot Blocks plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter.
 
 Hot Pages
 .........
-- 
2.47.3


