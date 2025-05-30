Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F1C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtzd-0007x0-Es; Fri, 30 May 2025 03:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxS-0003er-Rq
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxQ-0007Dr-Jd
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPaE/Hs/PsNigjRRzyvL5pe3AAD3Ei3aMlO9rDLWLFs=;
 b=JGFlUNsM+n1DBTWkuTt5UNZPGs0yfhi9qf3gjUy8Gd1/sMNWgt84Nc+HzCcmOPP5q0LfQd
 A6aA9R+BYZ6l449u/D6hIU3ziQV+C/spyT50HuVAlaCmOi2fpk/+WdBGVOupFa7rKXU3n4
 U4l+eQBoPjEtiaTGcCGcz1waCTB0mA0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-lm4kGA1ZM0SJSDCMG_0XLQ-1; Fri, 30 May 2025 03:15:10 -0400
X-MC-Unique: lm4kGA1ZM0SJSDCMG_0XLQ-1
X-Mimecast-MFC-AGG-ID: lm4kGA1ZM0SJSDCMG_0XLQ_1748589309
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-adb33457610so59602766b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589308; x=1749194108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPaE/Hs/PsNigjRRzyvL5pe3AAD3Ei3aMlO9rDLWLFs=;
 b=wJfA5UMrvQHMqHYVpXrmMbaGa2iCfZ+YTc7KshO1JS/BeaKNg9N/55IlsbCcu+eBSS
 etqn8d78/lzKuCTd8dmCVLLXfuLxs7IiUWT/sFsSHll+/ynweEASbZ3Po7IfhfuSCTqU
 j5D9+YDjvpCoMEHNGx7qPJb8CZa+G3Ybb+q4m7QkZRwvrX5w29U0TBTll+JrvbnP3SDd
 aZgNBDnITkw6/8HP4bhYoB4KkN9CYWJN09IX1byA+HDE102dp32s4BId0r69S1pebAJV
 OL8zvl1qeotWRyJ+ZDkylSeK+9gU68KZV/hq0TPykLFOhDcXNq0W4piwubqZK6zKJoXL
 U3Lw==
X-Gm-Message-State: AOJu0YwnacL06w9t9RST5mv3xOBS7wFDak8uUGbBZAQP7jNimtbaJFas
 7dChzrbZ9VvZVOa5kaot/agupqGiIWOSUOmIkCqUb68aunCrUMdaUl4TOWD40V7hjPn2q+9rYTK
 aVJi2PBptrpglfxa+DiBpSWEkPlyDEysgNy/WB60UMx6hD5XAq4CpzQT0OYGEDEZgkqa7wKLiQ/
 3hVV3hsky1L8P/V/96v/wLXQYr0afFpZQdpnVZxVdS
X-Gm-Gg: ASbGncs4Y0Nsvtjp1zxCUV3VFAxyB2cSMN0t6SUCK8XmmrVFd/DC1vOdQxRnwIQ8DmT
 XIRHHJ+K3b0D70qfR0xRdEVtfdjBlIWSxlmLlyuT+PBw9ro45idQtFwmduwue9zLaIZ+xgcd3Rd
 Je/1mBlNuGCc2HWYI/OHPa2K9UZ0DRQYyYGo5Hg8Mksbeq+ohVMqt9kT3mDSuaiu8scoLF9aN7R
 qdOnFIPiWsDnmN67tfDh5VuYjeMY4AblcGMHX3KI90gQpZ+Vl6Cfdy90uqqYdbRwkywHD3232F7
 vy5o6DXJvCEnbw==
X-Received: by 2002:a17:907:72ca:b0:adb:229a:f8bd with SMTP id
 a640c23a62f3a-adb322fcfebmr213837666b.29.1748589308183; 
 Fri, 30 May 2025 00:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/2jG0mJfcBjBBYEVAXloigB1ZSgFlGY8vyAb8Og8Go9DKCIH3jMY5+zjZS1GT15QzOIw7PA==
X-Received: by 2002:a17:907:72ca:b0:adb:229a:f8bd with SMTP id
 a640c23a62f3a-adb322fcfebmr213835166b.29.1748589307705; 
 Fri, 30 May 2025 00:15:07 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d84f2dfsm274608066b.78.2025.05.30.00.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 54/77] cpu: Don't set vcpu_dirty when guest_state_protected
Date: Fri, 30 May 2025 09:12:24 +0200
Message-ID: <20250530071250.2050910-55-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

QEMU calls kvm_arch_put_registers() when vcpu_dirty is true in
kvm_vcpu_exec(). However, for confidential guest, like TDX, putting
registers is disallowed due to guest state is protected.

Only set vcpu_dirty to true with guest state is not protected when
creating the vcpu.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-43-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 71e60604585..51526d301b9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -471,7 +471,9 @@ int kvm_create_vcpu(CPUState *cpu)
 
     cpu->kvm_fd = kvm_fd;
     cpu->kvm_state = s;
-    cpu->vcpu_dirty = true;
+    if (!s->guest_state_protected) {
+        cpu->vcpu_dirty = true;
+    }
     cpu->dirty_pages = 0;
     cpu->throttle_us_per_full = 0;
 
-- 
2.49.0


