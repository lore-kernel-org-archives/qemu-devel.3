Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1181EC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHXL-0000YJ-Gs; Mon, 14 Jul 2025 07:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1V-0001xn-Ab
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1P-0002Bt-7A
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84v5GMox428L8Z2lGKdNxuVp+eJI5ucAEsNT/SLxcFs=;
 b=iIV9RLtj+/pV8bc6gOAPvtyj7Cf4y58SJpmye27CCVP3R+gaTGyoJ/Kh4Gs9kYFoyazCzo
 S0OVH+n6GpN0/CsqxMBB/76jeq6+UVPEQf/VYxjN5LJujXbfYIKp3AgOfonOo71tlh8hMx
 Uc5L2sfioGzXSSFWNhRB0z3QoFH2AyY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-jiyigXauNS2BNyFo1oe9dQ-1; Mon, 14 Jul 2025 07:06:56 -0400
X-MC-Unique: jiyigXauNS2BNyFo1oe9dQ-1
X-Mimecast-MFC-AGG-ID: jiyigXauNS2BNyFo1oe9dQ_1752491215
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso1834083f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491214; x=1753096014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84v5GMox428L8Z2lGKdNxuVp+eJI5ucAEsNT/SLxcFs=;
 b=FdswvxFC5fLrR0HgbIGbpkTnO7Z6KBFFajYLsFJZYqi0L+Jq6HC+uxnPJ8bzcvu2jM
 Q0XFXI31kkwg1tZqjNp+e5rlHcMVowJobGrkOF2x23oJ09bWca7WPFz+8FAaVlMmYeaz
 kWfwlvZ1uq1Fd9GNBb3HZzfslfIGt8QFfYWQ16u4kXddbpYQJQug3QjlnezhWt03Qwws
 sm+WeGYUdDG31pVkrRGqXEiDaLz7BQlpMm3ZSGyTo5qpruI20XfyB1WH7+fVfPGxNXoM
 S/rwehA5j8PrTSCQDqedExHtYPMkQbxbEeES+KC0xUs71x0KQfbTAOK5Ptv/LFQ72nfR
 wWWQ==
X-Gm-Message-State: AOJu0Yxi2Ke46AcGjCADM6BrH54CNath/xODC4c6W3FLS4gufsY1Nkgr
 PsH9USSPu4CJr08dw303NPIeLtHmGZkQV9hztuFbnQSEaFycr59ZzPsS3cnAwYoY9rxJ7h6ubpn
 u68CtHwgmz7WMyy8jKFwoIshsqQGvv2BAslqqpDiJc4Xu65bTBQ+cWs6QzThwthXFspbz5O2dyg
 r3OxDCIjU4Dq42PJ9LYarESQGaV4xCjnUMCgMaefDi
X-Gm-Gg: ASbGncvnKScsnc0YHMdLbRbjScxi8jCjIlf/JmfI5KXZ3XywHX8L1MMuDNSAs80Meax
 u/XTvLM240SX5mOvFcwuDJi4oHVCHvlNSOicPtkTZellXUtS9N9J/CQ0kpgCkn8yvfnGWTg1Txy
 qOWQ9rRA0GIGh3WxrddHEBjqCty4vou5DV7rx8bePQYMjlPBqiKB1mMtdW7fEhjX8jO6Fr593X/
 g8GUAmQDCbrV4DhO6rA0JjMReEj1rwT9UdtlsgfIu77AmyDIwuvzcgyIwApk5OSnLiK7t95Ii85
 zqEnLUFLSnpwEmN1CHIXz0SzS23zLgJQ7ykVMPx54OE=
X-Received: by 2002:a05:6000:2c09:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3b5f2dc2becmr9584386f8f.16.1752491214001; 
 Mon, 14 Jul 2025 04:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVcspJNQHPtRlUemC6njmJYF/Eg9SFzEzJ81zURpNKGu0W/N+/GmmXytL3LxUS7ZVMkb7FjQ==
X-Received: by 2002:a05:6000:2c09:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3b5f2dc2becmr9584355f8f.16.1752491213563; 
 Mon, 14 Jul 2025 04:06:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26f45sm12230405f8f.92.2025.07.14.04.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: [PULL 64/77] i386/cpu: Enable 0x1f leaf for SierraForest by default
Date: Mon, 14 Jul 2025 13:03:53 +0200
Message-ID: <20250714110406.117772-65-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Host SierraForest CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 668f3e63b7b..c15082e8afa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5393,6 +5393,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 .cache_info = &xeon_srf_cache_info,
                 .props = (PropValue[]) {
                     { "x-force-cpuid-0x1f", "on" },
+                    { /* end of list */ },
                 }
             },
             { /* end of list */ },
-- 
2.50.0


