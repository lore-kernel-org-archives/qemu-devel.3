Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7C7E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQus-0003Ag-TD; Sat, 27 Dec 2025 04:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQup-0002gZ-4Q
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQun-0006wE-Jv
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXFtxzkCb7r/jg5V57qKi5t8O7nwjlm+HAbQXnotv4M=;
 b=Tu9yq910Zoloc4GK/X6udgtR/Zqbh3Yf3hGblkff0333BXzaWywrYyIcsHyVOhDj0Siv3U
 SnCOLsy3AcwsqtilejeV25w5+88OYJ0RX4vrfBy/akjZ/1uGpbUOxLzcJ9FB1zVz2SGn7T
 KqcgRI7hgDowxPlKiF3jE+Jz4CxB29w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-z-wKu-onOaCiuOWcipudUg-1; Sat, 27 Dec 2025 04:48:47 -0500
X-MC-Unique: z-wKu-onOaCiuOWcipudUg-1
X-Mimecast-MFC-AGG-ID: z-wKu-onOaCiuOWcipudUg_1766828926
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so56178585e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828925; x=1767433725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXFtxzkCb7r/jg5V57qKi5t8O7nwjlm+HAbQXnotv4M=;
 b=JisyoMVNBCNPviO5R7SG+J2DqeeuTImTGEejtRVeZtYFQDhbb5FbnDz7hebyumyKou
 PoLjA4CEK1WKb6noymaJdEpsYv/+9kqx1tBXsY/Y6qlrfaUr6rp4lS7Tz4xl7GGI7Sww
 q1ai0dmF0vhA2HLDvl0JC1h0h8qGhnwrz002dBB3+zLcw3ojM9JxTbZ2j7RY6TNSrkRV
 mM0velpyNeQfpZL5AQArpoW563jF3ChjcCG8yTgx9X73rgV/i71t1GdfdfWWAwwEFF5L
 6A9TKTVK3LOspyi08dMDyn20VOVQisg7NQ2P8hCeA5yvCE9AOIr2lTEcCmBsZu0oMorW
 9Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828925; x=1767433725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nXFtxzkCb7r/jg5V57qKi5t8O7nwjlm+HAbQXnotv4M=;
 b=sPSa4ZYuuoSKfd6tXCwFqWQUp3YQEnpZF9FYVaP1UgJXHTBb0Vi41YbfuvsWtHnNVc
 QlBrOW7Un4iwJBKq/gNwYvT2YeRNDBrwDp2ch+CW+JgkdsZ3JJga7YYPemeZNxt7u2kM
 KsoOC2x2Nmva4qtyoHtvaq4Q4Xfc95Iz2MDbMwIoGrusns2X4Oh0NDQKzDsWHjMAw1Ik
 q7U72fhRTgWucX9SYDBUyLU31uyrcSjwgF0NAzRkEsvEk9bhxIlAky/WgOe8vIztj6Tp
 UXAUhhRTx/CA67o8mM5gaQ2PID/VonoxDUgX9vYVQGv5bGPIKPrEyz+ZUEIf8JFz4NXq
 yXOQ==
X-Gm-Message-State: AOJu0Yz1coGARk33jH3dSl8r3Dc9Lnpp43LVyYFJE3kHBWO1Btg5HrlW
 yNwQCXI+ujdsTXdNIxo+3J0/UqHyv4dCyMmrr4WwN8KJm37NwKoB6ymwJxcIwK3xLDlYvwESigz
 iNYSSYnf+Lh8oFn7SZGjx84OWk8LkTJQx+WPRUAuYaFpnoERgJhjf9NDnUEtJ5/upPoWOFA+ooA
 RBybZzf01owQUM1FKRngo40Yic5X0gcQdMZ/b7Bk/D
X-Gm-Gg: AY/fxX7TQkkd2QjVwJIvjjVr/mbqIfBJX3GGTxuXzY/8sA0z4BzYb2jmh8nRkmqiduv
 iblxWPd5FCTKzvoiAqzRCptFEWnC9lfumioPKgph2mdsj7JPrRrn/qRS4dYNHPHBovjd12zcbVd
 sq1DoTHz+se5ZH6jFC9S+Gmlse+I+lCTs5MJzjO65yk8NcVjedKJ7fKh0t+Yvhl+F7ZtdqHZi8j
 Rq9KxkkiFWgskbiW4QiBs7OGKfYmNijwWrWZVXzHUeEo+iT7EDipHfusECWGuSkC0Xo9klAY5pS
 6wy9DhO/lSycCnlMwpDnNX8JEuv3aRpj6BbgZSBChCOLYma3jsVMA24a0TVFfDp9SYkkxhkM6FV
 jaGohPEdSgoP1iaS9xxIoc/f67D6id7q75VJmXFJJUk0BSx6LhPjbaJiihh6GAH5KgJR/RiXfVS
 YBVpnC6p/0P3woK74=
X-Received: by 2002:a05:600c:4e01:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47d19582bcbmr287094155e9.32.1766828925335; 
 Sat, 27 Dec 2025 01:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV6DiKb805bip74YUyS+lCXJftPejteewMRLTp7/75DdcMiAp1qGEVAGaMNmlBTmFtwsLu+A==
X-Received: by 2002:a05:600c:4e01:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47d19582bcbmr287093975e9.32.1766828924944; 
 Sat, 27 Dec 2025 01:48:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346e48sm424236605e9.2.2025.12.27.01.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PULL 094/153] i386/tdx: Add CET SHSTK/IBT into the supported CPUID
 by XFAM
Date: Sat, 27 Dec 2025 10:46:59 +0100
Message-ID: <20251227094759.35658-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

So that it can be configured in TD guest.

And considerring CET_U and CET_S bits are always same in supported
XFAM reported by TDX module, i.e., either 00 or 11. So, only need to
choose one of them.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-23-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index a3444623657..01619857685 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -526,6 +526,8 @@ TdxXFAMDep tdx_xfam_deps[] = {
     { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16 } },
     { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT } },
     { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU } },
+    { XSTATE_CET_U_BIT,     { FEAT_7_0_ECX, CPUID_7_0_ECX_CET_SHSTK } },
+    { XSTATE_CET_U_BIT,     { FEAT_7_0_EDX, CPUID_7_0_EDX_CET_IBT } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 } },
-- 
2.52.0


