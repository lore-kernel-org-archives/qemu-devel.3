Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E4ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKqa-0004g8-1U; Wed, 27 Aug 2025 14:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqV-0004cm-7M
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqL-0005l3-Tr
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDoZ1uvmrTV/DdB448feJ5ObS0XAOiDAlIQV3OW0ud8=;
 b=AMGOoxGVZ2JOma62KSC5y0kiKXOT+LN9rPQH+vdXX5Ljsvdv699R3o8MMZJPKv2IE/cySc
 AxRjnHcXXNCQjGDqiYwIuGDqcJeJupJjPGnD05b8rBYJxTybsH/aBEIL2XwdgSl8cdC72a
 f98KRf0saR4CvLDSxEEnABCsOyoUBGE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-Sn-f3-THNhGnBACRWEz8_w-1; Wed, 27 Aug 2025 14:25:43 -0400
X-MC-Unique: Sn-f3-THNhGnBACRWEz8_w-1
X-Mimecast-MFC-AGG-ID: Sn-f3-THNhGnBACRWEz8_w_1756319143
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a15f10f31so8218975e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319140; x=1756923940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDoZ1uvmrTV/DdB448feJ5ObS0XAOiDAlIQV3OW0ud8=;
 b=QMuSJg4LGFPtV/nhD3yFe/HNFMUoCmmCB7yNjgPVhmNsdRU8AmukdxJDCslDZrM6l8
 m/lQkeEAg0W5r7PoxRQaBVuT3MT5bh0F2nY4E3cRa+QPUNuKWGPLDsdylUC3JA6uuhNT
 /2Z8BZMyvkF7c086kzrCxphtZgjQA/YTKwJiM8/2MCsPw5aYZsWvRM3/Gj5XBspW8sT9
 zjEuFSrvHQ4gmzFEZ88Qt/DOXpM3H4OweSFuINF05/AQGXt+c7wRRlZczL04fvWMo42c
 bw1M+guebd86eU0wL7TCr6MsV7OKYoXSOluAEZIomYcxwGmsCfkcFvNUW9uUA9nEtd96
 r2ow==
X-Gm-Message-State: AOJu0Yxmtkl4gZvK5STmMh1+Rbm84zgLPiGWcxh1ZoQGLumNJARvnrty
 bR7w0yudQLciueAFSNpPaRigjOxO3xoJk3lq586MMojjmfpxpkfMhbHS0xaeF3Uzb4LzX/0lKuC
 BhQk+yOEvsvZPs2fYo5hvBc37mjAzp/0I0pjGaO/IuKdo/ib48Xj5RQV/k9mzciY2ftxuMWJHFs
 8aXCAWnhiBPTFKYD2OrvMk8a4yo+z/dYpsT3v0G9dX
X-Gm-Gg: ASbGncu8tTsVdpWIioeYBLpwMGtKAqw/h2pjI5heHCFziiaHh3smnURGkzodLubEDvz
 4jzpL900ido+KK2FZ16icpX/VDbzaoGQi4ft/+BBLmpdYLEi8UPJUxkgR2J7dB2HiKA5HykQic/
 v4Hd+lFgOsX6Kf+sOThU1ZI/mNboQLBM8Y0gdEokgAiQivXT3jDF9qb3Eu4HHG3IRFc/FJ5bB+D
 LLiXqoGIc41l31Y7/IGaiBthv/K2NHDVqk/FK5kOdARsoQJWGf/OY0nxk2xKGhOo1SYZE6jc3+o
 /J/vKb/EgSVRL4uIMcRt0xVbvJAl81UHA4IZ1uyomC7QD+lSMFbpZhw1INre2xTihma7OE7mRNc
 DhyaXpANswPHaU1i+5P5DudxP3KPWwnKvJls7Rzi3pUQ=
X-Received: by 2002:a05:6000:220b:b0:3c5:921a:f440 with SMTP id
 ffacd0b85a97d-3cbb15ca670mr5406361f8f.12.1756319139904; 
 Wed, 27 Aug 2025 11:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU2PCJubqhiMf/KsrL1+SM7yIijvbShakLR5O7kb3Runf/nOf9dbzLs7Z7zCzSs1gI4eUFwQ==
X-Received: by 2002:a05:6000:220b:b0:3c5:921a:f440 with SMTP id
 ffacd0b85a97d-3cbb15ca670mr5406335f8f.12.1756319139257; 
 Wed, 27 Aug 2025 11:25:39 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6b1bb9fbsm24123835e9.1.2025.08.27.11.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:25:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xin Wang <wangxinxin.wang@huawei.com>
Subject: [PULL 01/14] target/i386: Add support for save/load of exception
 error code
Date: Wed, 27 Aug 2025 20:25:19 +0200
Message-ID: <20250827182533.854476-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.51.0


