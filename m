Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EEBCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwd-0007fi-Sy; Tue, 04 Nov 2025 11:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwR-0007d6-30
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwN-00040y-4i
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SUUbBX2EZskEpcmcNIBAHfIqFByPha4S0DATWUq+gE=;
 b=dLP284nQMpsyxdJAYy6GpWlYLLptMtm3AlzDvMqUpDo46/gLA5jD38oD7Zno/uaIf6SQbt
 TD+Vs3t6GYpLr4xdA5sKE8KPR6dRg0L9FgJWfcLXhadphVlfmbfQVP6xj8TpflX6eRB02d
 k7QQWHo7IrHC2dBWVHrlmH9+7QTN1kY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-35qKT4lhPRq_gEbBXtKDZQ-1; Tue, 04 Nov 2025 11:31:23 -0500
X-MC-Unique: 35qKT4lhPRq_gEbBXtKDZQ-1
X-Mimecast-MFC-AGG-ID: 35qKT4lhPRq_gEbBXtKDZQ_1762273882
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-64095177aedso4953828a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273882; x=1762878682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4SUUbBX2EZskEpcmcNIBAHfIqFByPha4S0DATWUq+gE=;
 b=qMVFfPfVOTqh6/UYakzeIA2fQ+K1qXGYVbxwzlHgS3H5Vem4mAqZxn/g5smgr2IShl
 GYZxnDaXNCCDZpnBO9OFzM7MQbShz0a1D/OAKsg04Gh0Klb3ki4EkxmcBo+Xu2Ig3t4B
 lzRPcn0/PsdPpjgHbHzK96X8v+dTOz3Yxf/2OItQcBrXeDE/Tb1dpZQQo21zymf9IuH0
 2/jhM3szmT4DGcSCzYqsMARyokwhAIg4cUgJzYc+0l4JGCvNOq8jrwvh59bwyH5eZxDY
 dAwxY9aAiLbdwkNDJw3O1g6PyNsvn2pRyDF7frUsAZqEbyqKn2v9pvId6zIa5PpEvLG0
 CtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273882; x=1762878682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SUUbBX2EZskEpcmcNIBAHfIqFByPha4S0DATWUq+gE=;
 b=VIeBss5rivLC0NPUXvmB1Pkkhcdcp2lDr98VwCtR6MQnPwTHPQhxwy7qsfK8hCHaMv
 XJjAcGHO4RW9HhDusHxjVI8EU5O5Ug/mOXIbJQ5AtNmnjflO8aymIqsdTNZT7Vlt7Eik
 TOyfgFmD28NVui4WK0waBc//7rmFs3fYmV18O7/OIaFllntW2+dYnySlAA3bofxpfeRN
 X6movKIi/YMrfCs6IrEz+Vn7tzMvBYPLEdVPFY84+WnyMaH+s0gqoVxBSfZrqWgG5pvp
 yqFyQhhmeuvuAyStjrJm7hqLZRgEG7/R5fh6CFwPEYpbh+WLKGY0cedKgMRrlq+DBryb
 n29Q==
X-Gm-Message-State: AOJu0YyfHNUunohnYXZSQwZ5hm7kcJjtdcMpSUOZW0GyUw7pKcTIoDyp
 mm9mqptgtAWIQz4WSBwiKDK1WFpOkQ9Ocn2agPXsEWjK7GLofAxCQnTbWK7CudZ2RI8mo7SgnAq
 iSq5nrdT+mFSlOnxCsfgB5ft3LXYpnhQGvOv02kQZaQXNu8FXVPWUPQyzP5oYRRlIt6Q4NXfw2d
 BGOyXuz99uVV2bgPSHP/v4zw9JhY4TWqxchlHBdxgU
X-Gm-Gg: ASbGncu84zNcw47hOoLLepvZIMErLtlt8owNsi9+9DZYots6Ys4fc0BT9q6WyUndLl6
 4YhdRHFoGjYAwL4B8415iIkaDrulKaBdXaUH3AfdZAzgQTLURRbaJ6fpXACJphCLCb41LEKFO6s
 1X3BHmsLlp18o6/oWhSq1W0saz1pFlBjhwzAjn8di1QnNluzSwKOcDPwgGerotsLkODHoBL01sa
 6FQfkLp98n14WvQ1ZRuW7vu6iPjLPrhi85cvgjQ2wN7k922xGJ7JAm0drMDwYzrs+m+po+gJaMq
 3ib5kUlbuDZ9nKvV3mNPaNcKCzBwkO11hpbU6I1vDeL2XIW6lYSdl3sB9azeE6degpqlSkAqml2
 4cI3urKWUgnGQa58TfSvpTO4emckoMprmUaRXZ2CE6YlqFal+4arSrvsyyEcQLOJDNhbyeQXwgG
 cmuR1R
X-Received: by 2002:a05:6402:40ce:b0:640:96fe:c7b8 with SMTP id
 4fb4d7f45d1cf-64096fecaaemr11152811a12.2.1762273881944; 
 Tue, 04 Nov 2025 08:31:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb0/fnCe/NNPopjB5fURIXwSmiNZihlIKKQblSgaMhB/C9jnmdXWwieqah52Y2xAE906GpmA==
X-Received: by 2002:a05:6402:40ce:b0:640:96fe:c7b8 with SMTP id
 4fb4d7f45d1cf-64096fecaaemr11152792a12.2.1762273881487; 
 Tue, 04 Nov 2025 08:31:21 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5c773sm2421232a12.18.2025.11.04.08.31.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] rust: migration: allow nested offset_of
Date: Tue,  4 Nov 2025 17:31:01 +0100
Message-ID: <20251104163102.738889-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104163102.738889-1-pbonzini@redhat.com>
References: <20251104163102.738889-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

Nested offset_of was stabilized in Rust 1.82.  Since the minimum
supported version for QEMU is 1.83, allow nested field accesses
in vmstate_of!

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 5a237c409ac..267f9c8e053 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -141,24 +141,24 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// [`Owned`]: ../../qom/qom/struct.Owned.html
 #[macro_export]
 macro_rules! vmstate_of {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
+    ($struct_name:ty, $($field_name:ident).+ $([0 .. $($num:ident).+ $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
         $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), "\0")
+            name: ::core::concat!(::core::stringify!($($field_name).+), "\0")
                 .as_bytes()
                 .as_ptr().cast::<::std::os::raw::c_char>(),
-            offset: ::std::mem::offset_of!($struct_name, $field_name),
-            $(num_offset: ::std::mem::offset_of!($struct_name, $num),)?
+            offset: ::std::mem::offset_of!($struct_name, $($field_name).+),
+            $(num_offset: ::std::mem::offset_of!($struct_name, $($num).+),)?
             $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
             ..$crate::call_func_with_field!(
                 $crate::vmstate::vmstate_base,
                 $struct_name,
-                $field_name
+                $($field_name).+
             )$(.with_varray_flag($crate::call_func_with_field!(
                     $crate::vmstate::vmstate_varray_flag,
                     $struct_name,
-                    $num))
+                    $($num).+))
                $(.with_varray_multiply($factor))?)?
         }
     };
-- 
2.51.1


