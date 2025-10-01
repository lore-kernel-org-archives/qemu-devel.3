Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF2ACCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rdo-0006aB-4t; Wed, 01 Oct 2025 03:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdi-0006YN-NK
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdc-00035c-9n
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnXIZLFSFlS5HPrZ0BjXv/MkqoGrM9POZ0gaoNaxh8g=;
 b=BYukAVzZBiZRYj2Vd+fLkW+WT3pKwdELy10h+AHmX3qhmQfNSuqVR42Qh67us8E3MCmxti
 1htGC4MSFIaTd2zslmU4JP73+dSiLGeiTz1am0DZtcK9jNpTSjvfTsqJRhHxKfEsnXMWKK
 bibT8g2ms7ylbBeiDorHZ/u5v8se8FA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-R-d1v2TOMACcHbxcw9CW6w-1; Wed, 01 Oct 2025 03:52:23 -0400
X-MC-Unique: R-d1v2TOMACcHbxcw9CW6w-1
X-Mimecast-MFC-AGG-ID: R-d1v2TOMACcHbxcw9CW6w_1759305142
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b4626b2d07bso119529366b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305141; x=1759909941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnXIZLFSFlS5HPrZ0BjXv/MkqoGrM9POZ0gaoNaxh8g=;
 b=mWtRF5KwmpOc5fKXUp5qeN/FB/NkDxaRvqR4mxZlG1d//CBNBXsOklb613CRwDxyKQ
 2aSZxayxv5DppLFnRElXxxf7phYhf41nwwtolMPCxiVS6ALKqhaofcsiSTkMuFFIutHv
 /CQk2Jg1FJ2FkAU8j4df373J2+S2B2+K4aXuPn19D0764cNPQDkFdE0yW5HNKprBvoTy
 1jocec0h7UXQfcs+bJUTLGExKursIs6vKwUNEyyXWZLmo8g2v22Thgw3Q9RmOETVbEKy
 32FL81HAHrD2zuQqqi9rGGYiPS2Y1u7VyEwJBGFK3PC9TSpfoOJohX+4+VXdLBx8hrNz
 RPfQ==
X-Gm-Message-State: AOJu0YxNQP/uHdTSTva522FDCYAJ4eyB8auD5Yr4DTpK4dUNLSOBrANy
 9DAxHLRL6WOxNHR95U/kDAY0S68V9alUx+fRzsCp2kbzSmDGYm+WYQRMoxSyqxVPjHbULVafpU5
 qUA7zwZy+Pqa8A3Adj8MWIjVr4LztmmVmwFuEGqD5fYRlz3HJmdd/ryrq7vFq9x5DP3+xmP7SYF
 6jqw3j4sBKtiJTGZjAtkdJM4Xlyl05Skmwt4k+gl42
X-Gm-Gg: ASbGncvGNKuex51BAkaPe/nPGzw+tLxAqWWxHxOWtZFmev7c+oOa2Nzhk/EwSrk263I
 kH1EkCdswOeHU+qXncQJuzIDBe4L/w8fumydnYXakfAaNYz5pbjs6Sakz35fTU9FrUz3brDN9/G
 5eP3tAENYY3dQnUBliyx9hyjMBc+sDhcsO+YJycfejImDWsyKkUpPPF8WcaFl+6c9GN8UvGMM30
 +smryoV+l4EWC6DZ4OK0/rG74vnu1ZHpksFJs6QtcYa41jRaVD5gzejqYd8yyGBdW3PUBJHLlQX
 1LmMoOrDTXeJOaJXz/+ggu5yrpuurO9FXft86skGtxxGSc0XQqCZB6so9j2EfwyYEed5+7mAFxb
 ZyKQy+jYKvkb3wSCje/ri3a7ZXlYtpBt+xclAPg9g1MxZsjW/u2k=
X-Received: by 2002:a17:906:6a1e:b0:b3e:256:8332 with SMTP id
 a640c23a62f3a-b46e5e315famr337477766b.54.1759305141365; 
 Wed, 01 Oct 2025 00:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM+KeZCAn5ObslJS1kjuLdNwl9tFbj+zpsBOWMKBqWgWbHgnJP13pxwYG+lzARYtONYz/YZA==
X-Received: by 2002:a17:906:6a1e:b0:b3e:256:8332 with SMTP id
 a640c23a62f3a-b46e5e315famr337474366b.54.1759305140922; 
 Wed, 01 Oct 2025 00:52:20 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4762495317sm83232866b.8.2025.10.01.00.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 04/11] rust: migration: validate termination of subsection
 arrays
Date: Wed,  1 Oct 2025 09:52:03 +0200
Message-ID: <20251001075210.1042479-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For consistency with fields(), validate the value (at least to some extent)
before passing it to C.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 6a89769984f..22799dffdc7 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -674,6 +674,9 @@ pub const fn fields(mut self, fields: &'static [VMStateField]) -> Self {
 
     #[must_use]
     pub const fn subsections(mut self, subs: &'static VMStateSubsections) -> Self {
+        if subs[subs.len() - 1].is_some() {
+            panic!("subsections are not terminated, use vmstate_subsections!");
+        }
         let subs: *const Option<&bindings::VMStateDescription> = subs.as_ptr();
         self.0.subsections = subs.cast::<*const bindings::VMStateDescription>();
         self
-- 
2.51.0


