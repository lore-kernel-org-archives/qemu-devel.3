Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45767D30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCX-0008GA-41; Fri, 18 Oct 2024 10:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCU-0008Fm-Re
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCT-0002bu-Eb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3ZGFZCOt9HiQmv1wD8oI7UdgNkjvngz4i7GVqBANIg=;
 b=AOuQPjrsNhoDoNSNEPcFJef6DC10tU8Wt/yoil9szOaA8z2QbSDPkLh3+9EoSY8T4gpQLV
 y4UjVUPnMs1igeUfuhFYBhgLlHdsNe7t6pR/1kM0DTORB4kF+DwmLG/mauiQSVuxHRoVNU
 e9/jJWefcV4SWpfZxILcYJ1BamsMv1w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-AMYfJVEXPlSWQxN61EDy1w-1; Fri, 18 Oct 2024 10:43:31 -0400
X-MC-Unique: AMYfJVEXPlSWQxN61EDy1w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5606250aso917623f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262610; x=1729867410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3ZGFZCOt9HiQmv1wD8oI7UdgNkjvngz4i7GVqBANIg=;
 b=WurmeD0CnFEu6XigJrrfGFvPZHRfdZSiA8Pj8/7bNHh0tbm78/ICEDtR/4heBQ4QUN
 heo3r5Wd0gERFek8q8phj2xW+ePd3tg0WsAIha35q9JDUfJKk/8WcEgZredJTAKVWxtO
 CwFS3eAQ/8e8Q5f5vgicsyzdaIeSnZz6riGD0uq6KYYOv/ZOx9YfGDS3Fqbr2xf0oppq
 MUa3eoP4rQ7EqMSfiqvU6XgRPf1/PYW4+IkFdt0kQcCKR//ii/wPicQYMawFaY5wcP9V
 YdOeibP6TXU74GM6j6ARSzGr9vXOfcxiVJsLtWmCyfcCaE9da73tRP7nvhudvienREK9
 1mdw==
X-Gm-Message-State: AOJu0YziqKm5DD+5BNYq3CbtdULqpqOVBADyloSaDPzFU4yXtlPtmQO0
 F+80j45ubRH718HxD/FNvh4YSRkvfzIvyYIWom9pziDjyWF+Zn6v3PTWmDk4/9Tr84X3oOs19TC
 I3jJijm0Po+lhJiLHb+mZnesQFAeC8P97lyOxT6m0x29U3gEOs7llx8/n/1qoncj+KfDF6yUq6b
 UdGHLqHfThK0J4WnmnDGnPfYtMaFWURYPvQjtbq7E=
X-Received: by 2002:a5d:6584:0:b0:374:c8a0:5d05 with SMTP id
 ffacd0b85a97d-37eb48a0e89mr1998099f8f.50.1729262609969; 
 Fri, 18 Oct 2024 07:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGagS9xiAKzTdiLATFMcGlrIZguRVzRWLmQLtwxnyytzlSVFTD30748AR31pdmE4FdmUCEm6g==
X-Received: by 2002:a5d:6584:0:b0:374:c8a0:5d05 with SMTP id
 ffacd0b85a97d-37eb48a0e89mr1998077f8f.50.1729262609558; 
 Fri, 18 Oct 2024 07:43:29 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf11a5e2sm2084249f8f.105.2024.10.18.07.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 07/13] rust: modernize #[derive(Object)] for ELF platforms
Date: Fri, 18 Oct 2024 16:42:59 +0200
Message-ID: <20241018144306.954716-8-pbonzini@redhat.com>
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

Some newer ABI implementations do not provide .ctors; and while
some linkers rewrite .ctors into .init_array, not all of them do.
Use the newer .init_array ABI, which works more reliably, and
apply it to all non-Apple, non-Windows platforms.

This is similar to how the ctor crate operates; without this change,
"#[derive(Object)]" does not work on Fedora 41.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 59aba592d9a..be8874caea1 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -16,8 +16,8 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
     let expanded = quote! {
         #[allow(non_upper_case_globals)]
         #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(not(any(target_vendor = "apple", target_os = "windows")), link_section = ".init_array")]
+        #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
         #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
         pub static #module_static: extern "C" fn() = {
             extern "C" fn __register() {
-- 
2.46.2


