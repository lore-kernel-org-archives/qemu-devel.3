Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8CFC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1B-0001wr-7R; Fri, 30 May 2025 03:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxw-0004ZC-DD
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxu-0007GI-I0
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8CGgn1CBZ1LEjyTwoXOGqxJt2LdA5Kz7+q9O2PojpPI=;
 b=WGaZFlfQk67qU94ghp4CgdLe77ToWJOtw5Kc6mk/Vad6DFU2KVupVtfSfNs4r8VxrR/2op
 8MbxE6941Ba0IucuXEmzhVobC/oyAp+Qym+klyD7eX4+cFXLFr+D/Tu4n34bVh76pznJnb
 3qFnImG3nyVYDly9IUuvbkxWDF1+E4o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-D3anXKoKMYWJlNbi7fPJKw-1; Fri, 30 May 2025 03:15:39 -0400
X-MC-Unique: D3anXKoKMYWJlNbi7fPJKw-1
X-Mimecast-MFC-AGG-ID: D3anXKoKMYWJlNbi7fPJKw_1748589339
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acf00f500d2so129794266b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589337; x=1749194137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8CGgn1CBZ1LEjyTwoXOGqxJt2LdA5Kz7+q9O2PojpPI=;
 b=mDVAmhsx+9FdBWjDNuFJeyNO4KkYtlokPri69MSgvL/i3LXbvzN/8IeQkaVonDrrKf
 JI+OXY9RVxvy6S4DAExdEsjGBTQw9xwlvYiz8oc4mKVXZ2foYWMcvwiq5psPb8M572o+
 gj5JvWTrpW41ee4gM3OgwOWv3G2gGWs5kzOubx2UqgE8/xkEqXuLzauQlg9D+FSjyJ5H
 D4WDE/t5S5d8rA3Ws3iJzVde+mSoPi/5NrYzvzcI75qR98IBxkhTdNbStd/IrzZyXBvh
 326kqQfKKjm5LUNJHgIu9OqD1iV6bD2oh956nxoLAy0q/s0Afos7bCv7cuHAfWcIkCHj
 StHQ==
X-Gm-Message-State: AOJu0YylO/ZMU1eIfqRq8wGzc1mc0yTizOL4zZ1ylpsW3zIOdI0Lt4OV
 cacc3Ftx8iHXL8H4jyQh/GtLODlgLVcLbdlkmNCo9/aKtnYtm7VRriRvLlN5H7/f3zYN12gNVcE
 dy7PNzFEASBcYk/9pPSBQ4NuStXUjuY8KP6Fvp6GFuKKTdEF8a0KkjVSlqe98zjOiUDHW9nEy7c
 8idKgS5Idf8G2K93Iaa5+VcpLEmNYJke78NeSP4Cz+
X-Gm-Gg: ASbGncuRAjnFA5G3uM8KYjaJQqhg6zNnMeSfwdxcCkRbZLSUiEYH+PEaQsUKSVS8iJB
 Vd8OKNdjbW7DcceXGt6oKkLB7AIMRenRapLga6JXXRVeRE7yDvHNeANdqCf8lP6Uz2gNfGkHmGt
 N4XcKeGp8JlbItjusb4ExMFAv+MmPP0P0nUbHDVDUsloO8ejSB2lHJmBYx/1N1e8uvpjvujs0AE
 bkCu8ouH1XvXUuIzAAAr3sv8svykIQzh6ntU/ITGyLg/xhhGQV5OzFNq6bLVEiwV55GZTzXYVsg
 M077ZhNUpbE9ug==
X-Received: by 2002:a17:907:720b:b0:adb:2d60:25ef with SMTP id
 a640c23a62f3a-adb32301642mr199220866b.43.1748589337421; 
 Fri, 30 May 2025 00:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe/dCep8yL6dql6QbksFCd+PLTrlY0UinDcSvxhZVCFZRSGACBW3TvWb/+i/R8iRebru+JJA==
X-Received: by 2002:a17:907:720b:b0:adb:2d60:25ef with SMTP id
 a640c23a62f3a-adb32301642mr199218366b.43.1748589336902; 
 Fri, 30 May 2025 00:15:36 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c5c5casm1208218a12.25.2025.05.30.00.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 66/77] i386/tdx: Don't treat SYSCALL as unavailable
Date: Fri, 30 May 2025 09:12:36 +0200
Message-ID: <20250530071250.2050910-67-pbonzini@redhat.com>
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

On Intel CPU, the value of CPUID_EXT2_SYSCALL depends on the mode of
the vcpu. It's 0 outside 64-bit mode and 1 in 64-bit mode.

The initial state of TDX vcpu is 32-bit protected mode. At the time of
calling KVM_TDX_GET_CPUID, vcpu hasn't started running so the value read
is 0.

In reality, 64-bit mode should always be supported. So mark
CPUID_EXT2_SYSCALL always supported to avoid false warning.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-53-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e474abf3a60..76293029917 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -845,6 +845,19 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
             continue;
         }
 
+        /* Fixup for special cases */
+        switch (w) {
+        case FEAT_8000_0001_EDX:
+            /*
+             * Intel enumerates SYSCALL bit as 1 only when processor in 64-bit
+             * mode and before vcpu running it's not in 64-bit mode.
+             */
+            actual |= CPUID_EXT2_SYSCALL;
+            break;
+        default:
+            break;
+        }
+
         requested = env->features[w];
         unavailable = requested & ~actual;
         mark_unavailable_features(cpu, w, unavailable, unav_prefix);
-- 
2.49.0


