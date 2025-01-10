Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4029E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK20-0000CO-Ng; Fri, 10 Jan 2025 13:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1g-0000Ac-1P
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1d-00014e-RZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B10SRZRYGA29q+/7m3S/Wftl9lQcNQLNubrEXoeQmEM=;
 b=Vw2cJpMN/nR19nfaaa3AAQlm+UIFqd2g6mqUeR7gerwCKoC4ooT9JuAUUjxWYMvrOtI8I2
 UF209CwjGqO/MMlwp3V8vwdcehomSCr8f5Ka87Pnny4hAD1Ij2ooNPoe4YqEwfyba4y84a
 mxnJaVl+Vni3zGTUivG4H/gXbPBvGdI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-02Fb-KDwNqmPySjxmQgZPA-1; Fri, 10 Jan 2025 13:46:26 -0500
X-MC-Unique: 02Fb-KDwNqmPySjxmQgZPA-1
X-Mimecast-MFC-AGG-ID: 02Fb-KDwNqmPySjxmQgZPA
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d3d6d924c1so2459617a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534784; x=1737139584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B10SRZRYGA29q+/7m3S/Wftl9lQcNQLNubrEXoeQmEM=;
 b=FIduveJL9ghVHEp09yiZCg0LmnurUFDMEa24PJrrvdv5uuYDpXbO1ci6KQpuwybOl2
 b6DNcLR9SMje76+ihGA6HktlMpsPbNAYJUmt8oak9zNifzo+ziH6Zoa4AvdUDZRkRlDw
 iSXNqnxgIljjKIYszS8I6L0XyqDrnnwlADr0S5wrMcMd8Tkt/z54r6nxY5XE1gJdUbU8
 3Av2OoXA6jxnfuf2QKqYUX10u5wecyC4UMBxW6lBMeKCsMpDSon6eDzPsccM0FP3aPai
 uoPwgp0xjslOcEodB6FkUB5eoAVHk0znsqgi+zRrtdPr+go5zlvzDD4pQTsxctq/l5Yc
 xNWQ==
X-Gm-Message-State: AOJu0YwzHPpkXOg0unJ5GdPFGIME9FC4+I1G9KlPpuePbvDymVdiCkgJ
 /7ErN9Y1yA+5a1nLg3fWEuWo7wmoE37/yBISxj6F2ci2/Zo9Ydx0hVlz57753YZmYQDX22BqT//
 NZ3BHF063H7BVCPVpb1XKXJcpUySW56wocTWbhXrB+TE/iZyez5mrMAa6d4LYstBkBrIBU2/oPi
 jwXVMxOi9++N61FWq8nTLNXNykq71o8MBZ3g03nlI=
X-Gm-Gg: ASbGncs+xIFLQfXr0q9Oov1ZGNQ9DvfCFHJGHk/RDst3FBltN+8jWYBh7Mz9eBfk05+
 A56lyySDjH26VPoR3HSkvAycLQDKw2z5blNP+GhEf6N6EGXP7Fz7lVf7aqFd+Tf/Oy2ZXPpoAWV
 4qIUucheYkdV6CQVAJ0HnG9fGFnoCovxl6Z3SVdZIY4rYEgqZG1jaPYaeBdZXM1XJubHvYt3wkW
 Z3TZkkILzrFJkmSsl07J61tmyvNX9dRjpA1PZZEMndPwdb9QcbFiB9WSTg=
X-Received: by 2002:a05:6402:3550:b0:5d0:fc80:c4d1 with SMTP id
 4fb4d7f45d1cf-5d972e0eecdmr10426061a12.14.1736534784564; 
 Fri, 10 Jan 2025 10:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEdDNrmT5oZiFA9sw23LLLZ+h7PTot/o+XeArjlRl5ERLCBKatzG0LFomgxPoAx2u68dszUA==
X-Received: by 2002:a05:6402:3550:b0:5d0:fc80:c4d1 with SMTP id
 4fb4d7f45d1cf-5d972e0eecdmr10426038a12.14.1736534784132; 
 Fri, 10 Jan 2025 10:46:24 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903bb465sm1931155a12.36.2025.01.10.10.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 01/38] rust: fix --enable-debug-mutex
Date: Fri, 10 Jan 2025 19:45:42 +0100
Message-ID: <20250110184620.408302-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--feature is an option for cargo but not for rustc.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index ccb20f38c1d..9425ba7100c 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -7,7 +7,7 @@ if rustc.version().version_compare('>=1.77.0')
   _qemu_api_cfg += ['--cfg', 'has_offset_of']
 endif
 if get_option('debug_mutex')
-  _qemu_api_cfg += ['--feature', 'debug_cell']
+  _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
 endif
 
 _qemu_api_rs = static_library(
-- 
2.47.1


