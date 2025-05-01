Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF845C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcVK-000200-Gx; Thu, 01 May 2025 18:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVH-0001z1-6V
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:39 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVF-0002tF-CN
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:38 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-85d9a87660fso156762539f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138934; x=1746743734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fMEL/bKEw56xzMAth9BU+Ho0n9YaM0fXYJdD76Bau4=;
 b=EOQn7PDJfjdczDon3Uy6VzDSo28yCyz5oY2oE4oWwtpr6ukt+c/OJLJ24o+SQXWlAL
 7zEEVZASOWy+RrZkeaM0K0PX4lnLXGrwlY5UpSb6hKqsL+u/tfQm740IWoJWX/GJ9EH5
 O5nLRYUunkoXP5xlHrTCewLB0GkMGfgUhBujLsj3O9NiBgOY/JjhRWHw8PAzy5DaneRZ
 vhMgskuw7PjcJHDgegY2F92zaLEc/I/qcp07wKZzg8XYsmOY/FMqm4D5CWMyvJR0Cy4V
 2bCdbHa5gF7dC25uWSAiX5vXbce0wSfXWsn9lXbI76SeUHqUMP3iPAvYPhZn8fwwg2zG
 TqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138934; x=1746743734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fMEL/bKEw56xzMAth9BU+Ho0n9YaM0fXYJdD76Bau4=;
 b=pTPKDD0CIeLz9vdGySgKi9fTlPn5w5uek9V3Td4+qsE3tuZrzQAxB/kURxjIER11i/
 J9tfv39oSqYPj9Psa5cav7ZUwHKshorCGKSPSatq1ee5YF+nFCe26L7YZdha0vilA+bN
 k9G6TmTpxt4AgCqnNGShPkfFhzoy0N9YnXcjCQmdUOC+hK8H7wsBmQt1PaLaeSr28jsd
 uLh9WwKklQw5Liwf3ZjEsVwMesfyk4CDWSB7EpPHBCGxSNNTYsst2Ej3ejBMHZd4XQIu
 fZhm5cXtRhOrW3n+Iqc5O0136DtmOFqhkCFNrX1TexVAvxyAVSG52ZsSCHQJo/WCd3/8
 V44w==
X-Gm-Message-State: AOJu0YwqiV4e3AWvgEVXF1tlg7HX+vuTbUHCjdpq4pWNu0lSG8OlKjVX
 NDpX92O1/mqji3k5/vv3K7+GtFRkqd7dMzPVbcHcIULwVTB0J1UNt2WTU/hY0qP0gl8MkDSsCDf
 Q
X-Gm-Gg: ASbGnctJNwe2uecWRTzUI0aQ+v/JZKUqq9Ww0DvdIDpD08rMycPW6gW/9bvbPImyRzq
 QJQSvlQ0uESNoSgDeHCFOqvHmPTJ6fLYYIHIpEKFiFVAqAqdjHLfU/CoJF5Kcc6ojM3qnevtnxk
 8y0iJBgZP37Tlsxcq/KaIEerxLlWHq2bA7O7iqEtTzkxeB+N2HX8a9CaH15thUi7DV5DSO3CXBe
 HoGZ0JnzeEp4CzadWCvSFEuJNHWoPAlhxMKCFuxDHd7jQ1y7Q+4U7Ql4UO54sZigLV+L1+DmGk8
 hxE3VcB/mBX7qU9i5n2/6PYsPBrBjJobbSA00eCnQWLYtwq372UkcMgB7gPgAASt03hT6m+gSQv
 AHK3QJu9mQA1A8GR9EUztj/i0XYI2ymU=
X-Google-Smtp-Source: AGHT+IGre5NHqR9i3g7IZll1f2kWgnfs/k26eoluII/Ac1Pl6PWskfFuwiZX3igz/Wn3PJHJ7hUwMA==
X-Received: by 2002:a05:6602:408e:b0:85b:35b1:53b4 with SMTP id
 ca18e2360f4ac-866b4434281mr153935239f.12.1746138934655; 
 Thu, 01 May 2025 15:35:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa43a977sm27633739f.32.2025.05.01.15.35.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:35:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] hw/i386/pc: Remove deprecated pc-q35-2.10 and
 pc-i440fx-2.10 machines
Date: Fri,  2 May 2025 00:35:15 +0200
Message-ID: <20250501223522.99772-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
References: <20250501223522.99772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd35.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 10 ----------
 hw/i386/pc_q35.c  | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5c7d0c50f8e..f0f71de4405 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -727,16 +727,6 @@ static void pc_i440fx_machine_2_11_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 11);
 
-static void pc_i440fx_machine_2_10_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_11_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
-    compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
-    m->auto_enable_numa_with_memhp = false;
-}
-
-DEFINE_I440FX_MACHINE(2, 10);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d66d64b3b62..1bbf2385431 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -620,13 +620,3 @@ static void pc_q35_machine_2_11_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 11);
-
-static void pc_q35_machine_2_10_options(MachineClass *m)
-{
-    pc_q35_machine_2_11_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
-    compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
-    m->auto_enable_numa_with_memhp = false;
-}
-
-DEFINE_Q35_MACHINE(2, 10);
-- 
2.47.1


