Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6306CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu54H-0005tj-0C; Thu, 04 Sep 2025 04:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54F-0005se-87
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu549-0003vk-3n
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ad681so1148827a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973491; x=1757578291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNEGVA0a3lSomvk/RYtnyV9U8MhQRFndjMqEzv6fEMo=;
 b=B5L2x+xNWWu/ohVHcXzYS6SoLd49RKD9rv9CHikeDtt2hXBIrk8r+rflRrfvcXmsEq
 /7xkFVW+HjZMfVrxhWN5CccdHnXtsu3XjrP6Y/zb7TEAQHLsZgUoWXR1mMHPsOy6IkKw
 5MVoW/w9uwiPUdlsNf8m36Jm5zTJdYM0GCC1z7T11gXv8LpmIoN+53hvfO8DP0ppe+ZR
 KKWHYmaMzBKwsd8JnCdSEr4oPfKTccTFEinPm5jsEpbQyibNKYvm0nRCsUroGFbOK/Yq
 QjyVbnVjpM89OShLMhXaFngbxVTe0LoFkOxZGtAhUv7Yig3gwGtW042M0O5mWalf3ZNf
 nQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973491; x=1757578291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNEGVA0a3lSomvk/RYtnyV9U8MhQRFndjMqEzv6fEMo=;
 b=sQ3b/+p31Mb9Ay5i9CBxWiBNfd3IxMduU1GOy/rdJJ52AtLrai19kaa4/BupYQe34M
 dSoT1zzpA5Il/ALbqMb9JOjRpAexEPQehs9a+ACTySqY2vlvH7nfMUmFFtiRNq2dafDB
 oce4Lb307SGgzxcFVAmlWJ5ZvQ8+YjgZRL2O0hGAwZNJQQ6E1zhOAnlca8S3CHeHjPO5
 aKaq6zKH2m11lulFvwIHY7Kxknmi3iUojENaQPIKe8mg2hwNezh13FKBxmxi3XjmKJJ7
 DM7CHU5mn4XqUKLYLgQ01zF5/yIsAG1kcMx2Nfv/Bd6FBHhbKZuRwnplZRmH5RwxFjRn
 KrZQ==
X-Gm-Message-State: AOJu0YyBQw5qQt9VvebGL1Z5AInMF7ng1UrgsZuWA0BVhy61MCNYGY/v
 P9EsGmW8ZD4L69XW+UpNFLmdoBDlUZO8M4FIDycNHl8gaDGf5pkHeNitLFAURnNjmpY=
X-Gm-Gg: ASbGnct+gflVV0WSxrYENGSyRYIUWOIWge136YSD3IUKyyOiInbomuhcVNNiOKvAMoU
 uRb+YlmloBdNskVF2Qmth2s9thfoQIIZiIunSEH5La2WrSLLFiVoltaN8jPXfxHNHCMSF645nSK
 88UgDEyzNKHPF4y09E2j0ZOEKDJIN2Ah8y8fh1II382f2WLGo1rRSZzUDTaNpyFpPW8dhClkpDj
 lMy8GNzPzhgYQ5SbkTYPlt9d8sX0tVAmuh1tsRpKl/gP3aqXpDjpyvfOQumQFp7FSQpcBnnLAjW
 fUI5Q+rXkw4E53XghfgInhn9dFMkwyQtf7JsTj0heJ+vwhOJp9jPRwdAqxE5hk69qC1lE09KH62
 0wU2kmQChWCmbw7rOrwTGQgL1H5tg+Bmj9g==
X-Google-Smtp-Source: AGHT+IHexK94NPWoWCrwjuk3gIAjHKSuKZUcH35FtgtMhup7hPhQojKoYZ1y3LzApeF9bdhKrTjgdQ==
X-Received: by 2002:a05:6402:1e8c:b0:620:894c:656c with SMTP id
 4fb4d7f45d1cf-620894c7c6fmr28663a12.29.1756973490788; 
 Thu, 04 Sep 2025 01:11:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc5575dcsm13745805a12.49.2025.09.04.01.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4CE8D5F900;
 Thu, 04 Sep 2025 09:11:28 +0100 (BST)
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
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>,
 Xin Wang <wangxinxin.wang@huawei.com>
Subject: [PATCH v2 001/281] target/i386: Add support for save/load of
 exception error code
Date: Thu,  4 Sep 2025 09:06:35 +0100
Message-ID: <20250904081128.1942269-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

From: Xin Wang <wangxinxin.wang@huawei.com>

For now, qemu save/load CPU exception info(such as exception_nr and
has_error_code), while the exception error_code is ignored. This will
cause the dest hypervisor reinject a vCPU exception with error_code(0),
potentially causing a guest kernel panic.

For instance, if src VM stopped with an user-mode write #PF (error_code 6),
the dest hypervisor will reinject an #PF with error_code(0) when vCPU resume,
then guest kernel panic as:
  BUG: unable to handle page fault for address: 00007f80319cb010
  #PF: supervisor read access in user mode
  #PF: error_code(0x0000) - not-present page
  RIP: 0033:0x40115d

To fix it, support save/load exception error_code.

Signed-off-by: Xin Wang <wangxinxin.wang@huawei.com>
Link: https://lore.kernel.org/r/20250819145834.3998-1-wangxinxin.wang@huawei.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/machine.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index dd2dac1d443..45b7cea80aa 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -462,6 +462,24 @@ static const VMStateDescription vmstate_exception_info = {
     }
 };
 
+static bool cpu_errcode_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+
+    return cpu->env.has_error_code != 0;
+}
+
+static const VMStateDescription vmstate_error_code = {
+    .name = "cpu/error_code",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_errcode_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(env.error_code, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* Poll control MSR enabled by default */
 static bool poll_control_msr_needed(void *opaque)
 {
@@ -1746,6 +1764,7 @@ const VMStateDescription vmstate_x86_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_exception_info,
+        &vmstate_error_code,
         &vmstate_async_pf_msr,
         &vmstate_async_pf_int_msr,
         &vmstate_pv_eoi_msr,
-- 
2.47.2


