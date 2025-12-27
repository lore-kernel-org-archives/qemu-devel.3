Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF3EE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQd-0004o5-7Z; Sat, 27 Dec 2025 04:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQb-0004bt-2s
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQZ-0002qP-GF
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ah8JPPokp8PIS242o3ghPDmvg2Xy6nZa/QiTTUPeBrw=;
 b=JrshS1yVt3bcrfIedLmlpfDcv/DtQRJ4z3vMzYMamH1iqlon732e1LL/BWPlreMLb/zskK
 rbrtOVWBlNmZ2UvBt6/rHkbv+ZaObyj8wb2hC+4jsUsmZeryPXSJVEoiLZx0ZdPVq3UNZS
 7aPh0o2nUUSUju/vM2wGvAWKrLYfXzc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-I5KM845oMQWzdSaGniXmxw-1; Sat, 27 Dec 2025 04:17:33 -0500
X-MC-Unique: I5KM845oMQWzdSaGniXmxw-1
X-Mimecast-MFC-AGG-ID: I5KM845oMQWzdSaGniXmxw_1766827052
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fdaba167so4115618f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827051; x=1767431851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ah8JPPokp8PIS242o3ghPDmvg2Xy6nZa/QiTTUPeBrw=;
 b=EwrGyLo98wRYrze4//IMPbAjDRm8VUdviMHN8mPMe4l+895OnhQCFryY2A3zJi31cJ
 1PzSNnFC5oRWi/PKTusq4OdhBdvcbs++Ap55NNnDHb/jjxYREU3caQ4PNPVw8XcpTVrZ
 J4jt3b4rHHkXlGap0nvBC7reFKPUUe9ZhJKN9r9LFKEMOkgtVALT16NMiU3Adju0n3r7
 iNZn2JyBaDhPTVdaC6D237BKIE9XftDUgOpKRUwMRFL26bAMpcqgDMbJ6tpt23mRIY+m
 vbtL3H64TuN18UVwIdQnvaWVQ+DgmzHOpBALiKsoHjOoKsfjJpsR3uQdthVD1GnjBZcv
 rROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827051; x=1767431851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ah8JPPokp8PIS242o3ghPDmvg2Xy6nZa/QiTTUPeBrw=;
 b=wqjuhpHMrZ1JFt1vdvOPFr42kXsj69hNdNc4oPFiqctym0L6YCNAfGch8P7XIjJDPT
 aV6kyq7F4tR9zaO4j4vSYek9nTnVIrzxdXTXb3xoOtVNeWy5TXgCl8AVhlIVImqsAD+k
 +ONWiZfWcP/KqWUNuSyz5r16AxfpjmsArJLDAmQMeCz9sUb95GsEZby06190vDgqKgk8
 Vu2Ly3fjMrPb9bi7sFJVOsmq233opax50VSEbxIw5RiATTd8+1A1YDDkyErlJSQCWXc8
 Y6ZuKorJf+M0FsRELG2jy5CTzLImFq15u9ItCTSBVXehGQeF+R58rMzuxQkVJ512mkxm
 6tiA==
X-Gm-Message-State: AOJu0Yyy7AyEXHAvCftKIrKoqOAayV7evTxkTvfTyuU2wWrK8cS36xXP
 wKWDs5GSxoyWEi7DJjKGf/h/26KsebpfyK4sNVMZHXZVBGVJx0E6DBGfLY/QMb/seHxoPedXjrN
 JgChN7ZBTVJ7wDQVihjvOMqaAEAMjR6SYbrfOJxUYQJprU4XIU4j3/vMx03QUzUDki7ASirWvyb
 ng7R8p4eYI0YmgI9v1I3/AOtdONBtS7CYmZZM1i9c/
X-Gm-Gg: AY/fxX7JO53Hg4Hqr8j1j9N/gFNreUFA3y+SB0lU+z9sBSqQmWBxEvxImZofistGrSJ
 llgbHfqb7QqlcuZa9Kxy8T1dZiM21qIoE/dk5mYVHhmA20cdf5FAVSE1PP+HTffilnY8fgljO/h
 BbLYPQFeq+j7SwuzHI67fTQmogtzFrIKjCuVBCbM7VzcDzlonGMK7LIRBlu87w2nwS7tcHWmTWd
 myuhsQ6C3cCuaQp3zmOTabIuoo5iA4VJc3zau1Q2sQVLSHpLVWB+sfhXc6FOy7zmqvWXma+vHe9
 AVXp6T9Fwt5Z4wnznbCpvuxgzkDP88oYi9cIKyKR899OWk5+RJMYn6Kj54RZMCJQ0Xmi5oD9Bem
 DxcoFKJ4wqR4A1s2gj1ivnnNjK5Ft/psLIFDLmd+PmHVEBkkWQ+8dSuU6B8b168y8PwQw56CRG6
 O1ybcGUSCz/AUXlUQ=
X-Received: by 2002:a5d:588c:0:b0:430:ff81:295d with SMTP id
 ffacd0b85a97d-4324e4f9350mr30589213f8f.41.1766827051222; 
 Sat, 27 Dec 2025 01:17:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHinHH6HAofe1h8KWEgYSLXrHsnp1RiKfQP3PCHdwQtKJQBy/v0i7xB7LuWLLl8EWkkEUdcvQ==
X-Received: by 2002:a5d:588c:0:b0:430:ff81:295d with SMTP id
 ffacd0b85a97d-4324e4f9350mr30589185f8f.41.1766827050758; 
 Sat, 27 Dec 2025 01:17:30 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227casm49960066f8f.15.2025.12.27.01.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 035/153] rust: hide panicking default associated constants from
 rustdoc
Date: Sat, 27 Dec 2025 10:14:22 +0100
Message-ID: <20251227091622.20725-36-pbonzini@redhat.com>
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

Work around rustdoc issue that panics while trying to evaluate
the constants.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/core/src/qdev.rs      | 1 +
 rust/migration/src/vmstate.rs | 1 +
 2 files changed, 2 insertions(+)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 4e983da28b7..c2ca17f6ce0 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -132,6 +132,7 @@ pub trait ResettablePhasesImpl {
 /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
 pub unsafe trait QDevProp {
     const BASE_INFO: *const bindings::PropertyInfo;
+    #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
     const BIT_INFO: *const bindings::PropertyInfo = {
         panic!("invalid type for bit property");
     };
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 267f9c8e053..f9d9f335b98 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -101,6 +101,7 @@ pub unsafe trait VMState {
     /// type for the length (i.e. if it is not `u8`, `u16`, `u32`), using it
     /// in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
     /// compile-time error.
+    #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
     const VARRAY_FLAG: VMStateFlags = {
         panic!("invalid type for variable-sized array");
     };
-- 
2.52.0


