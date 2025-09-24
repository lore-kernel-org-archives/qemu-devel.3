Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02493CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lof-0004p7-IQ; Wed, 24 Sep 2025 05:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loc-0004n3-Bf
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoW-0004nQ-Hq
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6U2o/f653CpyKtbmcaZXYBHLnD9ktRk3jYJpmo8H640=;
 b=LcV5gbQ2m946vRAOmHTLGmFZ2BGdBdcDs9Cxyn4RV4oGG/QEFEwPel1G3RjEgiSuZrsFo3
 8if/eDIgv8c92W9P31VCSOC2eCXvyFn939S6z1+it9d1EsV+hN49QImVKZyMXLm1CHqUNb
 OqUGHZQ/Cdjr3QBAYF7lKh8PHSjcLbA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-iECyiTw-M0eI0HpS_fra-g-1; Wed, 24 Sep 2025 05:29:25 -0400
X-MC-Unique: iECyiTw-M0eI0HpS_fra-g-1
X-Mimecast-MFC-AGG-ID: iECyiTw-M0eI0HpS_fra-g_1758706164
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afe7b40b15fso236849166b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706163; x=1759310963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6U2o/f653CpyKtbmcaZXYBHLnD9ktRk3jYJpmo8H640=;
 b=KSEDpDTtN3wyHFs3niJgmX54QYsqxWXSPQfLgRvMfCVndbHA7hCuH6ZGKIVttwPPvA
 pQwsWzXUivHnUq7SdZ3RH40vDV8vcOiF1vQlkGItHuUnOtadhWNlHgdGO2AMYvfFzMFa
 NiJAxCWM92PkfRIVvqnHKPmpeV/q/mOPEbM1V0VbJ45PwETkWdPAE3K/MgyQr+FWn7kO
 NTKQjhTygQDfoSoRjvDXY3Feepj3jAl5xsWoxQ3fzkK2cnjTL+2pS/8Ixx5VtnFM2Eb7
 NJQq94UOGbOgFIRhFbuU2cvr8tdNWeOo4PpICHlxf1doL0oJFfDNxXX/CGgeawj8zQDu
 54Rg==
X-Gm-Message-State: AOJu0YxdmFmX/rUz86j+nOMmUWpy+wHXpa8OFdLF1S71jnVoW4+IYEhd
 w9mWRoIFQYoQAYXJEqvr8hMScnkxkLLn86zghs2DrfV8YBraZshvf0e+VRVdo5Bz84Oc5v3giGo
 LDnsaoazzoqhMTOaDanou7/2WiJkDlLq+CSrleChygq9Kq3JxuyrwdmvTMpfsVBtJjVQzLSYVDl
 LCOKI+S67Sva94sh2CJr9DsFbXPycvSLaX1V6AdwHz
X-Gm-Gg: ASbGncsOxfo2qazkbw7EKcqzURgpxyKK0VwTOzmfpf+K66adA0Mmi8gTJGKB5F1MVaY
 vftrxPAwz8v5CxavQh8hSLuq/vYfW/qbg6gLU5WqlOKK4Ho0Ynebx1o/KamySV3KbQcOKrxrh5e
 8ni6l9sCkWuahZWyjrfGHc8q0Mz1jrXgRwCB5xTsKdj4NFKadpvMk4jTQaiDlK/uBJUJTyGMEoa
 g0u6wgaRAJ09vAf3HdJEnOooPUn7trM9o3IRfl6gqtwah0zqoNz8EbpaWYX3MRAIsVA8aAFpG8C
 +pcWTzL49uGqz8hbC1/Hn0Vsxmo30bOkPDImFX4Weeyo6FX4oz3UJA1qGYr+DtAaSXsqg6ic6lY
 Te9sLcj8NKS6m0BpO82BteuhCidpoOWmj+DBotgY9DS30Ag==
X-Received: by 2002:a17:907:1ca5:b0:aff:9906:e452 with SMTP id
 a640c23a62f3a-b302ab33e68mr621581866b.31.1758706163529; 
 Wed, 24 Sep 2025 02:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiEf3wvV027g/ng3yXV4a5RdBmNcS2Pel/HMB2YYHKR+j8wiu4EcqoaqGKu2yxCQRNZLDIPA==
X-Received: by 2002:a17:907:1ca5:b0:aff:9906:e452 with SMTP id
 a640c23a62f3a-b302ab33e68mr621579766b.31.1758706163079; 
 Wed, 24 Sep 2025 02:29:23 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2a3fb3ff84sm837246266b.49.2025.09.24.02.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 10/29] rust/common/uninit: Fix Clippy's complaints about
 lifetime
Date: Wed, 24 Sep 2025 11:28:30 +0200
Message-ID: <20250924092850.42047-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Clippy complains about the following cases and following its suggestion
to fix these warnings.

warning: the following explicit lifetimes could be elided: 'a
  --> common/src/uninit.rs:38:6
   |
38 | impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
   |      ^^                                   ^^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_lifetimes
   = note: `#[warn(clippy::needless_lifetimes)]` on by default
help: elide the lifetimes
   |
38 - impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
38 + impl<T, U> Deref for MaybeUninitField<'_, T, U> {
   |

warning: the following explicit lifetimes could be elided: 'a
  --> common/src/uninit.rs:49:6
   |
49 | impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
   |      ^^                                      ^^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_lifetimes
help: elide the lifetimes
   |
49 - impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
49 + impl<T, U> DerefMut for MaybeUninitField<'_, T, U> {
   |

warning: `common` (lib) generated 2 warnings (run `cargo clippy --fix --lib -p common` to apply 2 suggestions)

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-5-zhao1.liu@intel.com
---
 rust/common/src/uninit.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/common/src/uninit.rs b/rust/common/src/uninit.rs
index e7f9fcd2e3f..8d021b1dfc6 100644
--- a/rust/common/src/uninit.rs
+++ b/rust/common/src/uninit.rs
@@ -35,7 +35,7 @@ pub const fn parent_mut(f: &mut Self) -> *mut T {
     }
 }
 
-impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
+impl<T, U> Deref for MaybeUninitField<'_, T, U> {
     type Target = MaybeUninit<U>;
 
     fn deref(&self) -> &MaybeUninit<U> {
@@ -46,7 +46,7 @@ fn deref(&self) -> &MaybeUninit<U> {
     }
 }
 
-impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
+impl<T, U> DerefMut for MaybeUninitField<'_, T, U> {
     fn deref_mut(&mut self) -> &mut MaybeUninit<U> {
         // SAFETY: self.child was obtained by dereferencing a valid mutable
         // reference; the content of the memory may be invalid or uninitialized
-- 
2.51.0


