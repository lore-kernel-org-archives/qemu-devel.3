Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3F6CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5BL-0001OE-9C; Thu, 04 Sep 2025 04:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu55h-00077A-8x
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:13:09 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54z-0004JL-VR
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:13:08 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afcb7ace3baso137904866b.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973530; x=1757578330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arwdiSLHZSf6gZ/oJp/0pmlfrIs2tD4nzezQj8ONLa8=;
 b=mfrsU7Q6owDfBPScwGQxtT4RyEWegKmliZdTFUlePJV4WI2mkR3r/SGCTM/lIcsgB7
 FxEQohX00KbyQpDTp7uuGvv9Dd6O/B/xzniI2yRzmfdLxiUdQl91nikzdVEdGPjx3q5y
 uusgI/b/3DAviazmS1F6jeFStCQEBp/hZFI++vbv9g/BrvNLuVqgSrX5bT3t+53lniiL
 jRGAAKUUd1J9iIztP2XEcnuL1BL2yan3XFI3pMUPZbhFY08KS2hB5Llo7ZsXf0QHYzK+
 XYtQ+iOELZeBh+Nw9JDqmF/Yth72UjvZ9RlTPsCNzuHSGWJwGcZsNFHcoiIq2AQ18wds
 hAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973530; x=1757578330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arwdiSLHZSf6gZ/oJp/0pmlfrIs2tD4nzezQj8ONLa8=;
 b=W4Yu6fQ09fvPbKqUKi7gZySk2/1SHu3TWnaIT3xBXqydKJo9AeaIgj/8Hf+be43J/t
 gBx8d98yBfHpM7jnsOSHSOi6LyGPaYBwpRmYsF/w8utscKHCqtcOYdZm/P/AE/ovZgtR
 xDgwOePesdyKMAsg3Vv0XkDNxisWBQJB9eI1DxH1DGyP5NxLZgr8A19ndEZcdTviQs+P
 dfb+8ueDPLt0yOWaMUllCgkPcsOpaZHYSo2wNnG5/CONs7kFCDP8mTfCbb8vB44CZrFb
 4hqSCDkSh08PmhReYQ7w8AI2sLlLdwimKKjReQxVfsKQ5OcooiTJF+Fszwd5WQHNKs06
 R01Q==
X-Gm-Message-State: AOJu0Yz+dVdRaKemIxrI9dbGEMCajmN5U2VV+zGH9uEY7PJhuhsgLUkR
 k1tIimflUyLI5+ONqhiRDkkcqsKIEE4aWFYIY7zIUeH6lzRHLrs4ytkMPSpoM+J6jtAk/EoGnfs
 mHMHmHKUU8Q==
X-Gm-Gg: ASbGncu5uJUVM4F0eE1HAw5peZ3htICaOZfJ26Z17s0qJUSZSZ7k9pcUh6ami9Ie/s+
 bPJsNHPlE55Fhu2d8ThWjDhowaccxTJtuIhz49bmxgSPxcXcAmjVhI2KHQx34HgZRjWcAIO9h9B
 URhnYB4EN5JZwVTehb++81y99iWcwiWjOeGmTnNRJsiZmMgql5MzcdYMTkruPcFGKgjmOEb8MIR
 KTP7LSWXgypREksff0a+U/2lGp8OkknNJIYUSLQPSjbYgOSar3JkD/BjuLRpIpnDLPm6pbw64T2
 z03PLCi3z9hdnOAldVUP8rrsFnRrIZ0Cu57RPZH8tWKmQlZwNER4B28KfAVlveuRGJuxMcTNSiM
 2+6TcmTRBuoyK//rBIL9H7yHdkHSBjvj7tw==
X-Google-Smtp-Source: AGHT+IFQfEnVE3jwf+K8A9mRCuKbsvAdVucPiFVZ9gLtG5kMjB7TuNZVupCy9McVaCvmyY+uZupkMA==
X-Received: by 2002:a17:907:7f20:b0:afe:d62a:f04b with SMTP id
 a640c23a62f3a-b01d8a25c7bmr1778270066b.3.1756973529775; 
 Thu, 04 Sep 2025 01:12:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04110b94cbsm1152568366b.93.2025.09.04.01.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:12:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 694A560AAF;
 Thu, 04 Sep 2025 09:11:37 +0100 (BST)
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
Subject: [PATCH v2 071/281] linux-user: Move target_cpu_copy_regs decl to
 qemu.h
Date: Thu,  4 Sep 2025 09:07:45 +0100
Message-ID: <20250904081128.1942269-72-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The function is not used by bsd-user, so placement
within include/user/cpu_loop.h is not ideal.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/cpu_loop.h | 4 ----
 linux-user/qemu.h       | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index ad8a1d711f0..346e37ede8b 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -81,8 +81,4 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code);
 #define EXCP_DUMP(env, fmt, code) \
     target_exception_dump(env, fmt, code)
 
-typedef struct target_pt_regs target_pt_regs;
-
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
-
 #endif
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4d6fad28c63..0c3cfe93a14 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -359,4 +359,7 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
 
+typedef struct target_pt_regs target_pt_regs;
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+
 #endif /* QEMU_H */
-- 
2.47.2


