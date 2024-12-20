Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02D8E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1T-0004TP-GL; Fri, 20 Dec 2024 09:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe17-0004NE-CG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe16-0006J7-0w
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01O/MAUKR9Ox+siVKoWDUrcgLu5PuJZFTnesxu9l5+0=;
 b=invstnIb/SCLG/R5YWJVH5wdkc/ky7aWU133k1la9s59wVHfIQ0stDH2Y8yfEbz16gqBPz
 6xGnHSZajeDo2R9xaqAYk8e/fSMu1Z3PKfsGO53u+MsHHJ9iRm+jNhK3yFwIpSPOYLWQ94
 +FnLyHM0DJQjfZeESlZRIlrU9ApGUq4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-pQ-IAVwGPEq4BUJs0qiqwA-1; Fri, 20 Dec 2024 09:30:09 -0500
X-MC-Unique: pQ-IAVwGPEq4BUJs0qiqwA-1
X-Mimecast-MFC-AGG-ID: pQ-IAVwGPEq4BUJs0qiqwA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e1339790so1217468f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705008; x=1735309808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01O/MAUKR9Ox+siVKoWDUrcgLu5PuJZFTnesxu9l5+0=;
 b=aiZMOH7YNHpspc8ssb/ww+mjl0HhzMKqvMpm9ArP58RgQuz+ls6ikYstVD3KI7qh+G
 xmyMOw7N3gc7GgMzr8lDP1IbApOmSD7VgyKR3UpThFOW5tg3y+ggVuyht4kPGSiJfvqQ
 NkIUBIdBY2BzEwi4Z1ot2aBPsFF1abONWe4b+1nngExTlsRWLNwUzDLrDR0cssheecok
 T4KXffiPnUinnyxH3VxjxFdm9QjT/sQdvA5VP+19hvRjo5pZ8NGQflpG7A2IVEWXXcyZ
 NIvk2fg/1wqM2oKW3A4sAS3ggLBqUIJcXIhfnfWrg6ik9tgdhpq6ys+LQJJkJ8Mrl7Dp
 9rqw==
X-Gm-Message-State: AOJu0Yxc7qcCUNclLhtWXHZyLa8vH+qujzmF2NH+hGkvBdKNKqby/cz/
 DeE3OMRxUlXaj/9QJqyvay2SkBeiAhd+GovwR/cJdqcuV2HN43KvTw9RvGiN2bE2CvEUtY+FYW3
 FoswNXcJ5Jpwa3X+9z7AbgwIgr/WjxiCkHAOtx+XEYU0skDVWe82BhCY8Nvx9/Wk2wjZpnU1zpF
 AIVduRwPFuoE7aSbgXwXAClLuBGQdOZe4sUe5G
X-Gm-Gg: ASbGnctb7Yk3Xis2oZRuNocnRkfhFo9mZtEDvggDMlx9VLDxxDEQxUa3gS1p1jWLJUl
 +S5js8dk/WGCNChrd8E0vPqGUa07hlFriKpfiKIBfe/WEt+tlT8Zp12U/VSqq6FgQaEHcW0AASW
 clZst7hZWoZ2tHYOcgse3ldGoXll6DtGEuCobVRK5EWnQkMqZuStRe7/rr4yLq62EHNmG3kYv9A
 1fs4bW1h5iGRTPCts8ILGK3f6WDb/gXm0yyVCyzpGrm3RPoFmtRE4oAoV4R
X-Received: by 2002:a05:6000:1886:b0:38a:1ba4:d066 with SMTP id
 ffacd0b85a97d-38a221f3228mr3301005f8f.27.1734705008291; 
 Fri, 20 Dec 2024 06:30:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiP5HukOH7GegtweRyFGDnukgtcjESvzh/R2JhHyHSyefA2NJ44dQYwNxm25grUxPwM6Ewlg==
X-Received: by 2002:a05:6000:1886:b0:38a:1ba4:d066 with SMTP id
 ffacd0b85a97d-38a221f3228mr3300970f8f.27.1734705007900; 
 Fri, 20 Dec 2024 06:30:07 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847263sm4175120f8f.50.2024.12.20.06.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 04/12] rust: macros: check that #[derive(Object)] requires
 #[repr(C)]
Date: Fri, 20 Dec 2024 15:29:46 +0100
Message-ID: <20241220142955.652636-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 778b698be45..0f04cca3841 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -54,6 +54,8 @@ fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
 }
 
 fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+    is_c_repr(&input, "#[derive(Object)]")?;
+
     let name = &input.ident;
     let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
 
-- 
2.47.1


