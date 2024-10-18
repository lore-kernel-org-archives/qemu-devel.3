Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B806FD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCI-0008D4-Hx; Fri, 18 Oct 2024 10:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCG-0008CP-P0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCF-0002ap-Al
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Xom1H6H23cG8iLdLE19Xrgp9EKPUggp4mB/uXhjCxk=;
 b=CW2PofvbbDv19zvnM9QZFb1tSPD/o4jylCkvHEqxO/zS8VotCzwUlAqBTNC88K9NX2nBHL
 RqEEwSe7TFsw0eA/8MPp60+ixk7RFPFWbEb2iDqXALmK8V8xYjeI7jy3bHJh2gxIA2hoBR
 VlQboi24N/02zSD5YCVqauQZOQNERH0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-F-XR9L1CPO2eOFqusBTH5w-1; Fri, 18 Oct 2024 10:43:17 -0400
X-MC-Unique: F-XR9L1CPO2eOFqusBTH5w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso1309871f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262596; x=1729867396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Xom1H6H23cG8iLdLE19Xrgp9EKPUggp4mB/uXhjCxk=;
 b=B13nSvifqY1dxBDDXUUbTTb+nENIBcPgjzHNrkOMXB3XHKixAvbCgymGG9KzgpPCX8
 q+sSfLWryfXmY3oEG2Mv2a+psASXuCTDVq4gEvlX/xtEDKKCxRDbeJW2vtx5DlYv3mCk
 1mIws8JEBDN49TUTV9hve5oBi7EDuiwFjP64NF9VhheqIRmQeUobQmMl2tOqtnBvd3Ds
 EOZst3f9tYsNLzcfZmdLG+yRn12OvtulS+fkqys5cdYcGlK4foLzGuEoRzJ9sxQq92an
 OcsOEVP+1A/a2aVJMYNBL8zqP/H2hv37kiIlZI4wU6Hr78Mv5T+Q20ybxGW0/FX/YElg
 fsSw==
X-Gm-Message-State: AOJu0Ywmq84F2+cBwqREwFRia4OBp3iy7mHw2z+pS5MnOuChPUTa4p+h
 Iw5rQJLO7NHHqcmaO8ClUBJjJzb54SblqCXhUo2BQztusfOpkp6FABBh6+VteDfg2eY6AjSgt7G
 iyqY4rCg8mYwENdajG6Mu0bFxE0kBK9OKnwTMhr4VtvotBUZAsoun55wdkx4Yr21MXpLhGGCeJL
 6D/juMJZLUytZa7DUz4F0FPGTZ8i8je3Zml4UvuyY=
X-Received: by 2002:a05:6000:e83:b0:374:cee6:c298 with SMTP id
 ffacd0b85a97d-37d93e2492bmr4913953f8f.21.1729262595657; 
 Fri, 18 Oct 2024 07:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiNvFYNTzSJFI2vzWwu5T2zeEXAoX5XqUlpsHH7HUk4zF9Tnq3Jlf66qMF5bC/jbxDxDFVtg==
X-Received: by 2002:a05:6000:e83:b0:374:cee6:c298 with SMTP id
 ffacd0b85a97d-37d93e2492bmr4913928f8f.21.1729262595159; 
 Fri, 18 Oct 2024 07:43:15 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf06d3casm2104298f8f.48.2024.10.18.07.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 02/13] meson: remove repeated search for rust_root_crate.sh
Date: Fri, 18 Oct 2024 16:42:54 +0200
Message-ID: <20241018144306.954716-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Avoid repeated lines of the form

Program scripts/rust/rust_root_crate.sh found: YES (/home/pbonzini/work/upstream/qemu/scripts/rust/rust_root_crate.sh)

in the meson logs.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ffd78b6cbb3..f85bc22fbdd 100644
--- a/meson.build
+++ b/meson.build
@@ -3977,6 +3977,7 @@ endif
 
 
 feature_to_c = find_program('scripts/feature_to_c.py')
+rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
   entitlement = find_program('scripts/entitlement.sh')
@@ -4078,7 +4079,7 @@ foreach target : target_dirs
     if crates.length() > 0
       rlib_rs = custom_target('rust_' + target.underscorify() + '.rs',
                               output: 'rust_' + target.underscorify() + '.rs',
-                              command: [find_program('scripts/rust/rust_root_crate.sh')] + crates,
+                              command: [rust_root_crate, crates],
                               capture: true,
                               build_by_default: true,
                               build_always_stale: true)
-- 
2.46.2


