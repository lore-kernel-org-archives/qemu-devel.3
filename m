Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9DBCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lRK-0000Cw-8E; Thu, 09 Oct 2025 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRH-0000CD-Qk
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRE-0004Ue-Ko
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHTeFILZi+U3w7nE87D0Nrp2o/VDEMaD0RN/V3cIXtw=;
 b=Q+wNl2wzksEgvUSOMl4/juwUk9P1AHWp0pyRM2VTFg3Z6+SlQ82FXnHL5Fym/GwZxVPoTZ
 ZvKOchpVooy3sfWgKwZRgwApFh+XZ/PuqChmcNd6NLFm4G7OtpUdxaxXyOKlSqpWrV8w12
 4o3TbbvFFvdqqchoq6aOTHUFQ2MXOI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-YDwSxAIsONChMSAAQLtP9g-1; Thu, 09 Oct 2025 03:51:45 -0400
X-MC-Unique: YDwSxAIsONChMSAAQLtP9g-1
X-Mimecast-MFC-AGG-ID: YDwSxAIsONChMSAAQLtP9g_1759996304
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso495383f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996303; x=1760601103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eHTeFILZi+U3w7nE87D0Nrp2o/VDEMaD0RN/V3cIXtw=;
 b=twg219FtYuM/DLY6QtxW9hPFT62tVjp+n9Ii1zWZrSwiv30lD+9J/Itf9hrC/O/TdM
 waRF9grxWUEoRVx0wjWB2uN6z4FzjqaBaOmNXr1xMecilkvRIWpPocoCtp0wU3tvtrTN
 Hb2Pjas5XnzyKPNSODwJSaOMWRkuVvEioJ8ccXbULw0mVtbooY7kn40nQfYdbz49wR7W
 kpjeRy8ne1v8n6KHwFql/BtDIHTtwLvekSDmvb6+3LUd5YyfLuc8tm1vZVrt/zGN6k3E
 ayfwkGQW1ebtjCgxifI0HC3V5N3PpspUlLrAUy68Kc8to1IfaYTNKIqClK0591ptTX2J
 HIfg==
X-Gm-Message-State: AOJu0Yx36oq+1fiaZvkI7dhuGO/9lQ8fQxVzZEMuPoVklI/xxbDMA0MF
 QgeGc9GGClhVBjD/Yp6g3j03rK6S87TIeS2lxSvXK5kO7vkxaWgZs5EA40Yf9FNhXAHBdf9atDV
 msVnqTvDublM9Ig6cJ6XpxOJ0ouZV0RQAG/bhSA3hFG5wgjU3cpN9aH+rjriJA9q+JQshnDB7gs
 /EEIvCLkYWjSH/O6W4/fpetQnKqXLa88V7bUBbj//KfYs=
X-Gm-Gg: ASbGncuYHY0LIlIb0UlzGRzsM1ffagQPdLD2LfQ0V3g2LBY8jgq0xk/L22UiQeCe3rP
 lujXKgGeI0js3oTwWnvgCqfPSxCXLMdWSOwHgWDmBxPghG+VF3m2sHUJL258Hy2zPQ4eGTRKSeX
 QXfzm3f0f/f58uzURek7IaJSclaLpPSyUmFiINu5lrEhH0lJuUSktkGFVC1y99d4HBBSjz6t9FR
 y7ZlEseJxVe/Y8g/aBjUNPqwnhDctMiJmKE2MwcMkJC3sOKDVPqzbmScRk8VLXDIVoITCs2nXdD
 YdSjkgxf7rnhgCPXtbTU3PY8ZerKzsfyAyRaKqu3Y8ZDp0oZRMss/RglftgNvZVktGvoAHxhZct
 SLPa0fOIVaz8emN+ffgOitC3gptnatKMayG+EoQ/UYsODtZma
X-Received: by 2002:a05:6000:2902:b0:3ec:3cac:7dfd with SMTP id
 ffacd0b85a97d-4266e7c4ac1mr4359749f8f.26.1759996303066; 
 Thu, 09 Oct 2025 00:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEny1Kb6+tcK1YO0ttNmDO6HJ2eqRlaka6CAZq/CWAjKE8xk3fiLpBJ5F8K3zf/hCG/LazV/w==
X-Received: by 2002:a05:6000:2902:b0:3ec:3cac:7dfd with SMTP id
 ffacd0b85a97d-4266e7c4ac1mr4359737f8f.26.1759996302557; 
 Thu, 09 Oct 2025 00:51:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9703sm33775035f8f.30.2025.10.09.00.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 33/35] MAINTAINERS: Add maintainers for mshv accelerator
Date: Thu,  9 Oct 2025 09:50:23 +0200
Message-ID: <20251009075026.505715-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Adding Magnus Kulke and Wei Liu to the maintainers file for the
respective folders/files.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-28-magnuskulke@linux.microsoft.com
[Rename "MAHV CPUs" to mention x86. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 406cef88f0c..645344c4faf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -551,6 +551,21 @@ F: target/i386/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 
+MSHV
+M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+R: Wei Liu <wei.liu@kernel.org>
+S: Supported
+F: accel/mshv/
+F: include/system/mshv.h
+F: include/hw/hyperv/hvgdk*.h
+F: include/hw/hyperv/hvhdk*.h
+
+X86 MSHV CPUs
+M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+R: Wei Liu <wei.liu@kernel.org>
+S: Supported
+F: target/i386/mshv/
+
 X86 Instruction Emulator
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
-- 
2.51.0


