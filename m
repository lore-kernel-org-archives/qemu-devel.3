Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5366C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtxm-00045D-AJ; Fri, 30 May 2025 03:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwm-0002JA-PC
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwk-0006yo-O4
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpKZ7QUT13tOKRrNlPhN3EeYFojXUyUABlGiERfHGkc=;
 b=A82+smrACeFPmnLaoEsRCDIpCmLRM5iqtUHldMcD1yXjtHpYWo+ra8Q0QF8lBpfZBSG67b
 rOYnxB9w3tQsSLwiWF+9o4l/0r8y/YJeqMUMIt0ypJHYvN8vrWtO3KdsblIBrIqafKYuL6
 WOQUZzPK3VKQQfqajT4ChpJ8/cxYPSo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332--j-4GaWaN-aztNe0vPsn0A-1; Fri, 30 May 2025 03:14:28 -0400
X-MC-Unique: -j-4GaWaN-aztNe0vPsn0A-1
X-Mimecast-MFC-AGG-ID: -j-4GaWaN-aztNe0vPsn0A_1748589267
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-adb32dbf60bso62518166b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589266; x=1749194066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpKZ7QUT13tOKRrNlPhN3EeYFojXUyUABlGiERfHGkc=;
 b=jGaOhYNffhcmWvDtinIVIJwykVarutq+fMUVeS9HJcAG1dJU99tiuQASi1poSUtKXJ
 /QxAxcBl39x9jA/lqMaAhPfpYMYejojiFcuKhuUIFKsu6TPb5sDn8Zzs39yrPEvEbSA7
 d1mseeVbpcAvCENnxp4Zx3iaa0D5eOOaWQvKYTkPeerVwqhr+FTbDh8vM5BTTN/rO4g4
 IU2S/u4BcwuBwuc6XndBE7UDy0ape57epK1DX8WJZCfVnbHyZ4bqWhkzSGm6hsMpnf04
 M0nd+C+a/i5fc0xn1kEEQDUO+d0L+Yu3+iKqHzDk8YBjSndJKBGk93+wa35bn00x4+wK
 jG7g==
X-Gm-Message-State: AOJu0YxZPi+p6JROujF4Srstns5FDJQhQHCUcCjngSWhz6nqykTPJki5
 /PsqkcleGn87yCxBlMm1jKyE5zVuFV0hdnlUvRk5qZLXsAIVMxiBr0f+i5XsW7jlMLh4RYsmP/L
 3MMc/JDLbYtVksrqH79UjlQli5/uqmBS6piJdKrhjR4WT0p7FMuE3SS+aACZOalb8VqBcqBgzhB
 Zq69m1uGHVZgRMMcYhms9xnsS/GGmF2eAkXdceyfpt
X-Gm-Gg: ASbGncuZauki3eD6w4AuqLTKDvR85repdrm2lMWNcHv7rOPZL84ebmNWIlc4GWIDthz
 zcK3slb5CvsvLUm8SNJIdCoPZzoaxaLWnB3Ek5jU6O7CZjgQnLsaQcuJm/b36k7IidI9v3UyoRs
 61V3mdLv9Sz8+lHxPO7ehDfMwwj933THzkXSfn9vWA0P3olMdurFd6/8atZXfN0qAOHylOZA/IX
 L+n8tsAkDQYh5ZRDAAWo/btnutZH0IYUDzY4F5v49NJL4PB222KHCOaGn6ZQWbQznXe1c7qX+Ok
 j8N6ktMrLAUzKQ==
X-Received: by 2002:a17:907:9611:b0:ad8:9257:5740 with SMTP id
 a640c23a62f3a-adb322831b9mr195678166b.13.1748589266609; 
 Fri, 30 May 2025 00:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0BG5tmx8w7LURHx793IENCawF1rPyOskrjx4GuT/lQME0THob3gQPkncAbpmxhqJnMXIhKQ==
X-Received: by 2002:a17:907:9611:b0:ad8:9257:5740 with SMTP id
 a640c23a62f3a-adb322831b9mr195675366b.13.1748589266139; 
 Fri, 30 May 2025 00:14:26 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82e76dsm273912666b.40.2025.05.30.00.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 38/77] i386/tdx: Finalize TDX VM
Date: Fri, 30 May 2025 09:12:08 +0200
Message-ID: <20250530071250.2050910-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Invoke KVM_TDX_FINALIZE_VM to finalize the TD's measurement and make
the TD vCPUs runnable once machine initialization is complete.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-27-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 99d13bd8441..287bf7147e1 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -353,6 +353,9 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
      */
     ram_block = tdx_guest->tdvf_mr->ram_block;
     ram_block_discard_range(ram_block, 0, ram_block->max_length);
+
+    tdx_vm_ioctl(KVM_TDX_FINALIZE_VM, 0, NULL, &error_fatal);
+    CONFIDENTIAL_GUEST_SUPPORT(tdx_guest)->ready = true;
 }
 
 static Notifier tdx_machine_done_notify = {
-- 
2.49.0


