Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E91D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3MF-0000rS-7X; Mon, 15 Dec 2025 02:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lg-0000cd-8o
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Ld-0000mw-97
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rh8EAU3Vu8iISu05eCtJPhE7/fLdZf4qcNAXE0aot+8=;
 b=CsC6PtTkeNO28d344CEuULZ+ol2T3fmtTJMqB4kJF52+BOWcvOzq6n0/FHxJSNdowirvG/
 7PQWuNfCMRzLzt62S6Uuurbs7PLCaitWLKZaI6wfJILT+qNUezCWIKUiwvUvul0Jy2FutG
 jvfcBWX/WIThL06mqjPzX9Lh0K4Kjpc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-wPIdLr_hN1CjjbcE9ooZSQ-1; Mon, 15 Dec 2025 02:50:23 -0500
X-MC-Unique: wPIdLr_hN1CjjbcE9ooZSQ-1
X-Mimecast-MFC-AGG-ID: wPIdLr_hN1CjjbcE9ooZSQ_1765785022
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so30660195e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785021; x=1766389821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rh8EAU3Vu8iISu05eCtJPhE7/fLdZf4qcNAXE0aot+8=;
 b=VDlyZAvxxyCmkT2QtWf3twcM/W5i6L90lmEZ1ki8ijVpbG1mRzBqx0I/rjlUTbMn5L
 DXyQJ4VdXu6GQlX1m3GUkPSzbuk5qeqZjeuyZ3TxO11aJiEh6X95fm57IRAWlTkAQhy8
 2xuC9lpXvZAAhWvlP59jXjLXqFS4HhUHWnzQBVGAdqsb7pZJr6Ca3z+4nDUv3ByhBp7r
 IiP9oFv8vh9pNXOeSh0AyT23xqM/TBXvaD8jXpIqT1YcTstCec7AoFj9+wgF6NOf1/XQ
 Kx9BBEH2PoS/qJXQXRIYPSJDWsn/FmWvcN0aKjomPgXhSyiQDMWB5yD/58U8hzah84OS
 bkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785021; x=1766389821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rh8EAU3Vu8iISu05eCtJPhE7/fLdZf4qcNAXE0aot+8=;
 b=KWEPGcqNfBjPsrLFqiq4DZwCowoWnnTrZGlQxrdyEO/lArqiyobLPGswGufgUl37h1
 gXwhkZZeltkHx7V+f1syDJw1UuFVb5dAxnoHKl9yz9+a4eC8AXD4uoiLZuJK/8zM5ffC
 4ZyPglVP9GNSOHOen4MY7ndGhcafI3WI1JwD/8L0rd+dD4UmPQOisSqgR5pxdOAX2b5W
 kKXpPrGy7Cymq69/gO6FXKAlW7sDQBMKOfxk6vdvPYbfdbRb0zddscMcduIDJTz1/RzQ
 73AXWp/5dL230Txsgn2aGIHkVBXwrg99TFlhRbvPQaXhlV8hZWIjLWUDokFFG9jDNUgE
 Pb6w==
X-Gm-Message-State: AOJu0Yy/xVYc8QauU8HmD5ZoI+G8eh0cnju9eBDzVXwJ6eiX2QsR7Gp6
 eImPr/S3F/KlMw4nTEhVD4lZPNvhahEwkEwen2uO8kC6KCSlmRirIHYMuxB60N6Bqs58LX7kJFb
 eWiYL4E3FjSVV+KA8VEW0f5OpkfVVuxfOLCPlXfSFSDgyJrb2TfLQbC7CcDFshDfeLe+1fi3ER0
 Ryno2TxoNJtnwanKMUX6ESMdesDZN1L8/t9q/MSwqV
X-Gm-Gg: AY/fxX5130xfmgFaiB3ZHi6i5xmKqVn+nHcAiM4oapQrq8aMnSgACrnn8y/hWOTyUxF
 1RgjL/4t4SKGOp9eKLjSol+KWjL2oE020oO8Qi9YLBLm+NK6qMbCvWoT5+AblBAjL3+nzv8TL+6
 nTBatYxM62KwDhMdjoDf6XDNbPw1nKRUkXaanhIkykug4ixp0DVV/qiERadQPNPJZwFI19Uoijv
 yQ2ruomPwI/5lsAZWEgjiAfdWApJ5l9dWjF2RBY0XmlJxitrqE1XCCVieKFTMopotxgNEOYjq2v
 59jbSP41dtOB4R2ku+U/AF1vmCWbQFwz4oJyKhF83BfjO/hE7iJzXqEFB5AsLUpZkybNIDYLA3J
 /aaZ0eyJRxQpV0NEWFbucW1/4JtLS10MGnrU8FR7whtIv9YWJ5WNhw79asu55+WgB5nAdTrGxUo
 6R/Z6myPub2GS8vec=
X-Received: by 2002:a05:600c:a46:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47a8f8a7d03mr100417185e9.4.1765785019587; 
 Sun, 14 Dec 2025 23:50:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtv9ezhZRY3pkF6AFLP3UrJmNyaVU51P3R20WD4pyhJfihgmNoXy61W823BKutfB1Wsn/5MQ==
X-Received: by 2002:a05:600c:a46:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47a8f8a7d03mr100416895e9.4.1765785019123; 
 Sun, 14 Dec 2025 23:50:19 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f33d082sm67841095e9.0.2025.12.14.23.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 06/11] rust: Meson now adds -Cdefault-linker-libraries
Date: Mon, 15 Dec 2025 08:49:55 +0100
Message-ID: <20251215075000.335043-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215075000.335043-1-pbonzini@redhat.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 meson.build | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 02738c9765f..e2de3832ac3 100644
--- a/meson.build
+++ b/meson.build
@@ -136,13 +136,7 @@ if have_rust
     rustc_lint_args += ['-Dwarnings', '-Funknown_lints']
   endif
 
-  # Apart from procedural macros, our Rust executables will often link
-  # with C code, so include all the libraries that C code needs.  This
-  # is safe; https://github.com/rust-lang/rust/pull/54675 says that
-  # passing -nodefaultlibs to the linker "was more ideological to
-  # start with than anything".
-  add_project_arguments(rustc_lint_args +
-      ['--cfg', 'MESON', '-C', 'default-linker-libraries'],
+  add_project_arguments(rustc_lint_args + ['--cfg', 'MESON'],
       native: false, language: 'rust')
   add_project_arguments(rustc_lint_args + ['--cfg', 'MESON'],
       native: true, language: 'rust')
-- 
2.52.0


