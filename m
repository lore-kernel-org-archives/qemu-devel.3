Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82622C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYsh-0000Gd-UD; Thu, 15 Aug 2024 07:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsg-00009K-6m
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:43:02 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYse-0002Ec-HB
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:43:01 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52f0277daa5so1043172e87.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722179; x=1724326979; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gZX6jsnmmIcrh3iDFhCFFrxE/sOzMmJohzr4pZkqYN0=;
 b=VeMOj+7qNuPRfHFtY9PhwZl/N1Ki0vnv3wMzylAlrcHfg7DIgCxvGoNyutbDWJ4Sfs
 TZ4s7LMcKVUfM/SuG2APsj7MV+ia1hMAQdWsOAPXs05J+xZceuhofVz0XqPdzI2xpXTr
 IvImLZF8SYNFR4XoaJygsVDwK+ZyWChwSVTTzLziLchFoOb/GtfMxMb4TOlS6ppCpyrm
 A6XZBjYeoXGkyxohpZL9XPQ/5K43f7VUcgDgvcZoBDimvGukrcNjZVjB2gVFz7TtHvqU
 4YsijK6Lhbl43ioFtZckD9AEtoLfkqmp2qmLyORYi5mC3UdgzLgz6BcDgsx2j7SkLZ83
 S8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722179; x=1724326979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZX6jsnmmIcrh3iDFhCFFrxE/sOzMmJohzr4pZkqYN0=;
 b=QzyQ1XZTWsJC3oI8GstTDQqGTvw0zwu7tyX1zLEP462v7SU+hRP18lOxMp94pC4Ib1
 k7zOYKxSGGlzDZyZptUFTLJ9sKstcelQtQQ7BLwR27h6a5QuZBKRI+fZVwYkd0ZQeiH/
 EBaz/JkCdbSRgf/Np8MLPUUBXH8xGmxWAbJRUjU7CooImtNJBknYNQpTr87mXKOqeqNw
 JPpq6bHzsJfBgr9QvOxy5uwpHNVm+nyqkEMJzrRbaOIJ9/hO+0yevwppAdRkM3qP8D+x
 n90ctiu389WcBh+h0qLb+z5Nfz+jWRv01VnaZTgIdTuMtwhaT9lYBaRdlIbklcmkY0N+
 uz/w==
X-Gm-Message-State: AOJu0YwgquLQ43yaVfwEzLPka5JgMKVIWhJVpIa8DdaEKxYCitlgvVxp
 8wL+OATt9Jvg/yO77uBctzNaJG4x+8io/8/yeDscJBFdWHAIvNmDCJOgUjn90HI=
X-Google-Smtp-Source: AGHT+IEI9gHqL41YuKcjVzBQQZmqW+wM/dAhI8Bvt2PqcS531Ch5JsqQHEZXguUxCMAJwNDQMrMy0Q==
X-Received: by 2002:a05:6512:b22:b0:530:dab8:7dd9 with SMTP id
 2adb3069b0e04-532eda8e615mr4094621e87.12.1723722178418; 
 Thu, 15 Aug 2024 04:42:58 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6bf1sm89547966b.21.2024.08.15.04.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:42:58 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 15 Aug 2024 14:42:22 +0300
Subject: [PATCH v7 5/7] .gitattributes: add Rust diff and merge attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240815-rust-pl011-v7-5-975135e98831@linaro.org>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
In-Reply-To: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Junjie Mao <junjie.mao@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com, 
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=r9fVbmhGtXasriKuB3hw4s7B3j9kUJZLR7F1C15PCwI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm12ZW11UDR4KzRjeGFwcGVEWld2YzVTeFZKUnZHCnFjSkJvUEswSWg2dGs0cFpH
 eG1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnIzcHJnQUt
 DUkIzS2Nkd2YzNEowSWZuRC93Sk9UbEYrRm40V3dpdjZEbGtrRkxMeXFCV1c5MFpkOExaQjRmQQ
 puMVF2TWU5ME5mK29yWG5reStJaFRyVkVPNXRQMEZ2eU8wQ0t1UjhYbEVsTHNnUFQvYjR4OU01N
 Xp1OTRDenFJCkZjZEQ3a2FlRTNWS0FNS05Fdkt5b1I4M0w1UUwvSEZVSWhnazZjbEhsMWh6dytR
 aXZVMlJOQks4UDZoY0xUeUUKLzJORDEzZEF3UjVncytnaHhvL1l0THMrN3N4cDNLZEIzNzVLajV
 uQm9tT1BWR0FjakxIbW1oT1VyVHlZckxxdQphUVA2NFg1SVV5T1NnUnhGOGlpZ0J6MlVTMi9WQ0
 JOMXhZNEVaUjNFdEtpdzY4QmdDZzhiVHlYZnZFbEJoZmxsCkJKb1IrZnhGZkxQb1RKaHNVYVJnT
 DBGZFJadXNkNkI3TXQzajN3VjhEZlFIR2tjNGh2Rm4wOGMrR2QvK2RmWWgKczBxT2NYUUJQUXVt
 WTE4SFpTLzQwR2I2Y2Jxb1VDVmVQa2pLVnZRVE1xS3pFNEE0RzFIVDZvTFlIa1M1ZmFGQQpkQjh
 5Q050dXdYSUx0UTh5N0gvZkE0eGRodUl5dE1mbWJPZjFZTmNPaUtobVduUVBzVm9YM1ZsaUs5TT
 Q5QUlLCjFkeCtab2FMK3VUakpFamEwYzBkRDV5OWRmL1lxVkE4ckZ2RTYwTlBOcnNlSTBrUWVke
 VhxZWp6RGgwdE8zalIKeno0L0s1R25YUEZLK3dEczNYZlpSeS9TVTFQczV2cnRQYkJqRjcwL0lq
 NUxlQ3AzRE8yWFFYdDFwaXFKYmcrbwpyV3A3NUE1aTJ0NHlET1J5YW8wZEQrT1VFU1VyTURhSVN
 hbVRhVDBneFFTUlpVcjVwSG8zTW1iZS8wbFhUZjlnCkwvb3FBdz09Cj1UQVNwCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Set rust source code to diff=rust (built-in with new git versions)
and merge=binary for Cargo.lock files (they should not be merged but
auto-generated by cargo)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitattributes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index a217cb7bfe..6dc6383d3d 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,6 @@
 *.h.inc         diff=c
 *.m             diff=objc
 *.py            diff=python
+*.rs            diff=rust
+*.rs.inc        diff=rust
+Cargo.lock      diff=toml merge=binary

-- 
2.44.0


