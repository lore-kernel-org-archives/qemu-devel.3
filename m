Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEE2CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu58r-0003s9-GA; Thu, 04 Sep 2025 04:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu553-0006Yg-Uu
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:30 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54X-0004Aw-E9
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:27 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-61ce4c32a36so1285805a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973515; x=1757578315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKf3LX74QuDicrn7aIOxjy5IHw4dOUBMKNzlJ8lYJDM=;
 b=z1Ag0651Y2v/3qprg58MVyMZb7i7n7VpPzYCIGE9cnK1WFvH1O5rsK7t7TdzaaS0Dg
 iF99L71UuucQCnA6Gw+9f5/xOTsKwqOHgQ7EsiB7ds5khgvayYhnSn7NfIUnPl+XwKWo
 PpUv42c+t2XMZAuSh+R6nwnnINkdnx+bGDlxXumwkJXPSctDb2e6o+n4gClYRq43sKau
 lmE2h+0uBo3LlOhQd/uuc51BirZImDCL+oOz3e2IxQ7CHyZJ22td6IQxvCJwYuIOt2yR
 ommf1zCYM3KmoDjOGXbtr0wl4jthG+6dEQIus4w6YnXVPrLVOrESrB61fLGdbxsbRWqQ
 eVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973515; x=1757578315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKf3LX74QuDicrn7aIOxjy5IHw4dOUBMKNzlJ8lYJDM=;
 b=CqtbDVNVlxp1EZNBPxHeGwYUFHsaI4m51By5xbuiT0q4/gb+dUIOYO0KU73EakDvLr
 GeDLxPUk/Id6X6Q3Zt3MoKBbCLbzUwJHHAt14iOxBv2RMQUaGKmXESgx1XeFbY/8yzxN
 mqu23wTb8IYpJXTD+4WEKsDkxyNtlErTTBP3pZcJGEU7t+9MnDxiPj8xkfFsaBxwzMQg
 utdzrN6WqA+z1dKwUUYLPiICU2zZ7IeHUGdP71um9H+h0N62K+gUP6bdeDjcl/TKOA3f
 6hiNfZRUCoItNvPmvoZvm/ElWQ/80LuTC+/YA8D8Tfid4nd69d1sEeE0HDHUknK8TMPp
 MxkQ==
X-Gm-Message-State: AOJu0Yxyg+oo064b09byMFGxm5YGKbKJjsufFFNr4Iqp3qz0GWqpralg
 zox5H80TGcX9lGJ2xeAFPqqiIUvnE0MhgeSiJ7+8fhitH2NtW9YQmw2cAs8p/FRxQk7AUH7pA2T
 cNXxAjgBNtA==
X-Gm-Gg: ASbGncs8qHYiGV2L6AsC66RgyVVO+0WuytxfUOQwEoohlHaNH7PScB9wUN4+hoxREZK
 XonPGESBxZGUbvetdTjS22Z9CXfUfDXzVDWHYXL3PHllJOitAdFJSp0H6UTpj6K1V5WhL+rqo0o
 2UHzlliR8IUWTAt+rLFNl35rake1AdPFHKwE5oRYHAy2bKlBDkD6UDzEEuNnjLmbv7+uVuddmBI
 1YfNWNButSAWbWJ6eQQii/lxEGDWPr/i/0hYMRW3kFw9xg9IbYhPu/DJhALu8IgIv2acAUL4YzK
 1qe7KezwIuCAxFW3bguT7U8dTAQxuVEak5VM5DcR091C36ne/9pNANx2xPuLAW8vWiMNZp4c3jp
 MI9Lsx2ojBlWvH4BRaLdOQQDLQna1p2YAFw==
X-Google-Smtp-Source: AGHT+IGx8ZJxjps5cff/PZm9JBRuTzbh2ffGQw/tl1lRzj/lZpIUq6TJ0w2xsdrM6qRT2xpIi5PODA==
X-Received: by 2002:a05:6402:1e8c:b0:620:894c:656c with SMTP id
 4fb4d7f45d1cf-620894c7c6fmr30028a12.29.1756973515184; 
 Thu, 04 Sep 2025 01:11:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc5622f0sm13427169a12.51.2025.09.04.01.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A1FB260193;
 Thu, 04 Sep 2025 09:11:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 045/281] rust/qemu-api-macros: make derive(Object) friendly
 when missing parent
Date: Thu,  4 Sep 2025 09:07:19 +0100
Message-ID: <20250904081128.1942269-46-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250826133132.4064478-5-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index b525d89c09e..a6147418891 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -85,7 +85,15 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     is_c_repr(&input, "#[derive(Object)]")?;
 
     let name = &input.ident;
-    let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
+    let parent = &get_fields(&input, "#[derive(Object)]")?
+        .get(0)
+        .ok_or_else(|| {
+            Error::new(
+                input.ident.span(),
+                "#[derive(Object)] requires a parent field",
+            )
+        })?
+        .ident;
 
     Ok(quote! {
         ::qemu_api::assert_field_type!(#name, #parent,
-- 
2.47.2


