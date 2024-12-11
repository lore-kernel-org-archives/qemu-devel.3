Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D99E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZI-0003BH-Ja; Wed, 11 Dec 2024 11:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZF-0002v8-05
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZC-0000Mt-La
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/gPO2yFneY2SAFLMqoaZO1g8ZLO9OFPO/sZ1iMHfZo=;
 b=iNEr7Bb3ZFzGvp8rWusW+EF0VScGlPLDUyYxvXHNWqRFiUByeFMYJgZ3gWbsiAKFM6XRqG
 ltVOcJ166nUlLMumSRBpEdLPMsgwDLhwBRTk0uf2YICfqznnoA5Zg6ep36gYby3w/nf0Dw
 qXXhw/DP34clJnuSjopebCxIPu3snuk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-fMWhQFAIN-m6QewmsL3XTA-1; Wed, 11 Dec 2024 11:28:00 -0500
X-MC-Unique: fMWhQFAIN-m6QewmsL3XTA-1
X-Mimecast-MFC-AGG-ID: fMWhQFAIN-m6QewmsL3XTA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6c51069f5so598028785a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934479; x=1734539279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/gPO2yFneY2SAFLMqoaZO1g8ZLO9OFPO/sZ1iMHfZo=;
 b=DXh2fakpsyYIrvD7o5oUzeE32ZtX64n48wHs3N+7HVetPTqyVLcGmr5E9Izf6doQIR
 4p+emNJ1XGdIxCNfNQK3aBliuCM3ps/1ymiZ+VPkour8eNeeQe3kySuZlTLkfBNQNZaG
 ccfBQkpfJk9GcYBzT3gHf7nCvQse/Cqzh7Ib8XQWE1gNyBy0lIrJY+v+uZRaf32nhbq6
 lSso4EdCT+JMr+QbES1vQcxb217WoWBY1mBpUwcAXPKtGwpHqHvE18saA3SWNKaQQa1+
 E53D2Dwi2SPjU4I4kyZRA7KrEaLOXw3n7E9iPsm9vt8l5GpiTVw55ZiH7pDFerYm+eFG
 Fyew==
X-Gm-Message-State: AOJu0Yzvf0hSQJYXIHy5v2B2xEwvCCGeKOAv3gBfIKpEPVUWRc5i3sAh
 DCqvOvGoFCI85DvOQ6sYUxjTq9m3rKAgIfdv2CYGt9RgLV08XHWgOKBnSoYWobXTOC+ePCxkS6b
 GbGosA9ogrB+36v4c9kFB8fsH21tq7kbl98O8aXvMljw0RCoFpAkbDfeaPP8hBYtTaub6wEE23I
 DcqHL9vA0iuP7Jkb+oMSyEraKx2GHOAq13wnWd
X-Gm-Gg: ASbGnctmQHil8k0lP9OguEOIg/5wFXL6agipadnAVv1SlC1g4KUHeFDNmoB8asWsoHW
 SSltqyqJORlbxP7Js3c/WPod77C3d5HWvPB9cF8FIH27dJsJI+h2ndSLBpKkl4lI1VjuM/Cn+5N
 f4JQ4C9tja8ZX/zUx9KsI90WP2P94in5baNMbBifizLMV1CboCVdpJ6MonMPBxtHJGudi2JTp/0
 Iep+RjLbvcAQFgwsIl9723FCSGs1vHCD8PpKYFBpHU3zj4selfJifLP
X-Received: by 2002:a05:620a:191b:b0:7b6:d273:9b52 with SMTP id
 af79cd13be357-7b6eb4d86f2mr540882785a.24.1733934479480; 
 Wed, 11 Dec 2024 08:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpohvuDi1xtSCheyj9p63ZFmjUYzmt3Bgcpvj+6T03bsNvqZaHmQ+p1DQO6Bkt4ffC5hIbfQ==
X-Received: by 2002:a05:620a:191b:b0:7b6:d273:9b52 with SMTP id
 af79cd13be357-7b6eb4d86f2mr540878185a.24.1733934479079; 
 Wed, 11 Dec 2024 08:27:59 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6cbf228a5sm400514785a.105.2024.12.11.08.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/49] rust/qemu-api: Fix fragment-specifiers in
 define_property macro
Date: Wed, 11 Dec 2024 17:26:44 +0100
Message-ID: <20241211162720.320070-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Junjie Mao <junjie.mao@hotmail.com>

For the matcher of macro, "expr" is used for expressions, while "ident"
is used for variable/function names, and "ty" matches types.

In define_property macro, $field is a member name of type $state, so it
should be defined as "ident", though offset_of! doesn't complain about
this. $type is the type of $field, since it is not used in the macro, so
that no type mismatch error is triggered either.

Fix fragment-specifiers of $field and $type.

Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241017143245.1248589-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/device_class.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 0ba798d3e3c..922bbce1bb8 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -27,7 +27,7 @@ macro_rules! device_class_init {
 
 #[macro_export]
 macro_rules! define_property {
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
             name: ::std::ffi::CStr::as_ptr($name),
@@ -38,7 +38,7 @@ macro_rules! define_property {
             ..$crate::zeroable::Zeroable::ZERO
         }
     };
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
             name: ::std::ffi::CStr::as_ptr($name),
-- 
2.47.1


