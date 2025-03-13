Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D16C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWD-0004gk-Lb; Wed, 12 Mar 2025 23:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW8-0004fP-2z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:56 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVv-0007nG-N4
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:55 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso936444a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837541; x=1742442341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKRbj+5MK3zl/OCfvVEBbhsEyjSkzG8m6y3RQx2tpyU=;
 b=xk+xBGoMun6IEgNcTa/UUb03QGtjlPEQcRvY9qKR0etaULXxZQjej+gvt8YajQ0L2n
 QCd31XMN/on+kfFXlU4KArMVBXZi9GJKi1Itcdqw6Zx7P3uI1AYdiavxef8XdnZPEItJ
 8TPPC/vaTQrIYjNuoKRDOHF6wJd/3gg688t/fC5lJKoZjGrXJEtiOr90JGplqYb+aSid
 be026yC3geHJ4y6Gl8KtE+MlPDeoz5mukALYEFkD/ap7cwgY+H/cH2CF73lDqs7oAG1t
 6i6reJRm8Wd38CiP97R3Vbf4g8kTq2F5UsGa6zG26rQp00Qzacv0ydjS/21n/aqT4O+8
 uLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837541; x=1742442341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKRbj+5MK3zl/OCfvVEBbhsEyjSkzG8m6y3RQx2tpyU=;
 b=t/RaIppZydFlg/MRWPEirnu/WA+EuecqVJUN488PcWTjUV7kYD/hfqix9vIwKmW6Dy
 ebnvQeI6w97BqKO0tl8woFBkZvCJZ82q0dr7Dbq+CR6sr8JNOspiaVbO6h5jZuMq+joU
 1olHay5dgcFln6txX3+e84NN8LYhTSptUdhU1vZlDDWo0r8F+wGZWXhNvjZP9wFK5Mg9
 Uw477agSYP4Y1ZwWYMZWTHbbP/Gmf5TDRA/4crdsh869P5PtZVR0rmh3nA3MRBXD9ccq
 +VyOIBUV0jGNwnf8X0cge1JwXJbPoWRuOpAh4oGSHmDPBNfBFgqlY1oCpfkklVTgsP8a
 AnwQ==
X-Gm-Message-State: AOJu0YxHfy+V2a0EAOPokGj0ujf8JAzkz4tJ3Q2P/ciYwOBuacry6gaS
 ughhg3p7Qn3FU6Sa2W+Ee6j5eX/OsbOq4V8xRpdnpfgzf7bHnvrJlqfHkoQ9xDAU05dbZmZ4YDk
 a
X-Gm-Gg: ASbGncv6M4o89WGRFsBeHCqv+XABqsrzYtUyT4ifGGnkLUkbjOa1FPBkAnwNXbLQ8qC
 JuUX9sSWxfsWq8Zm0j6zo+BAL9HR5oUd6QAQGEPqP1Di2m5Ofea4E4oh0BQSNW8NOOTWjb57I5u
 41mtQ63rSaqZ2sKeyVrQwdvcdTSNKqEA6ovFYGl9uaoCsDFlPa91A3Qtc3M4FfiT+kFAWv+t2Mn
 DFjgU1hDBGyl8EchqwAqPldunQ0jYYIcWOeb0q35ess3DxqEUBhujJP4C1ZObSyOAnmpy4o3GEA
 Gv2yehu79n/P7GaVqw7cEqhmC2Mh88IhOmS097cJVsO1p2ocKiyxIDnqZkd3qRL4fqE2M/snKxL
 7q5G/ZkJzt1w=
X-Google-Smtp-Source: AGHT+IHm9rZEIzqy/7iJ+HgqTe8qQQ4h8rQwDxuDVxrfXzL6mQpQzt0qX6KU8K1qOYa5MnSNlQS8NQ==
X-Received: by 2002:a05:6a20:c79a:b0:1f5:8126:8a5d with SMTP id
 adf61e73a8af0-1f581268cd8mr20328988637.17.1741837541646; 
 Wed, 12 Mar 2025 20:45:41 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 19/37] accel/tcg: Use libuser_ss and libsystem_ss
Date: Wed, 12 Mar 2025 20:44:59 -0700
Message-ID: <20250313034524.3069690-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

While some of these files are built exactly once, due
to being in only libuser_ss or libsystem_ss, some of
the includes that they depend on require CONFIG_USER_ONLY.
So make use of the common infrastructure to allow that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 185830d0f5..72d4acfe5e 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,12 +1,21 @@
-common_ss.add(when: 'CONFIG_TCG', if_true: files(
+if not get_option('tcg').allowed()
+   subdir_done()
+endif
+
+tcg_ss = ss.source_set()
+
+tcg_ss.add(files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
 ))
 if get_option('plugins')
-  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))
+  tcg_ss.add(files('plugin-gen.c'))
 endif
 
+libuser_ss.add_all(tcg_ss)
+libsystem_ss.add_all(tcg_ss)
+
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
@@ -22,11 +31,11 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
 ))
 
-user_ss.add(when: ['CONFIG_TCG'], if_true: files(
+libuser_ss.add(files(
   'user-exec-stub.c',
 ))
 
-system_ss.add(when: ['CONFIG_TCG'], if_true: files(
+libsystem_ss.add(files(
   'icount-common.c',
   'monitor.c',
   'tcg-accel-ops.c',
-- 
2.43.0


