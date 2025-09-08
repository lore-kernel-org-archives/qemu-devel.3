Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E0ACA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSf-0006Au-Ch; Mon, 08 Sep 2025 06:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSX-00066f-8T
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSM-00061T-8g
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b00FNNkCtcPTVffVnAjfLt7b399bE5PDP2Asv/moViI=;
 b=d1hWF0+bJOjlIHh929leTcMmcu0iLA2ZjFn5pkIIctFMGCkDG3QnMx6Tw7Hl1qBQQGiBgV
 +8IbrIcupmNi8DTRlVo1WZ78Q93Lct2gm8nn+KUldZHom0u8ZQibcqRAt5wHT7H4Y/28Ub
 NxhiQzsVfUaySnYIcuSfN7t2xXbc5mg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-B7XM337wOT6UIBWYGAwXjw-1; Mon, 08 Sep 2025 06:50:33 -0400
X-MC-Unique: B7XM337wOT6UIBWYGAwXjw-1
X-Mimecast-MFC-AGG-ID: B7XM337wOT6UIBWYGAwXjw_1757328633
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b990eb77cso30329915e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328632; x=1757933432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b00FNNkCtcPTVffVnAjfLt7b399bE5PDP2Asv/moViI=;
 b=DOiUDSRQ4ufMg9naMgRO5KIwW4YNoA1ZqJbbqkDA3UVpEmV07Oc+vd3U159JVjYc12
 sU9+btpglB3WrbJcM8kDGoOa2dHdts9P95xuPNqkTvAuH2YmUVMwFCN/fQtF+d1GyFLG
 VKUYDjVCqWFM68HK+UENHZqyJe4Fv7Z5WLB0fMA+8bE/RlJKNIglueH75rJP/s38JiQd
 FTC2Afrrwl/o59sD2oJIhc3Q2qejY4LPOjN1CXUpD+XjOR9LhI5aD7F95RM6qqa1Z0J2
 UBfVpYsFMwkOwiAhPEmG7R8mhBhkgakK9COElXNPMAnHIao0EhAakvVKWwXnMj2TIAJ7
 HfgQ==
X-Gm-Message-State: AOJu0YwnwMBxaHIl3HaxVkqP8TKCGGwufixWv57IBztmkg5RcjS3/9fY
 kKymolDTNsS38fwi54hWbdW2XtdPbjGQsZuPog557vaWkcIMWIHlW4Mi7bPqE9u23eLcmqbOFhN
 pobmbm3YEdeq7ZKAjtLMoo16WFm1AJzrESWHqpkoiU3SjluNvP25vvqk3F/4I5ic7AqgVbBRgXA
 KVI0s/fFkF1gwp+eyUaUPzlEG9AlqiO6zM4T4jLdJi
X-Gm-Gg: ASbGnctvswYf3sOzkW5ggJiiA0h+YFPRNzG7wEmbbamI8xbfV2G/NawBOdDnfXNGa6d
 Cr0tRfXoqV3BuF08kmA1CSkuLY/FhJuQ7rl9FFPYvRuaAnVaBVAbixzfRlJyyT2cXmUdNvJuj6Z
 e2cfuI7hkeG16fd3S2T8GCjIy9ZpNa79NXPJEIBxt1rBcsZOzZXV7r51XpyRFXu4tIM4pEtzTMt
 wMg1c5AuwLfQE90V4ZY2KunoeXMKXtniT3e3b7lOm8Ezq4DGziKGmoHb4B8CQr2Wp5jiwDkUXy5
 d1aHwAtKd+8Ts49Zr2xg5jwCXeUaNrKFdvcIAQLmxrybXxQ+M79JhpJA9XwI/zs3g5BO7E1Xsh9
 jmA2az6MIZNWk/Kq/3H6dNniT3scVo03uejPaOQHnc60=
X-Received: by 2002:a05:600c:8597:b0:45d:e201:1603 with SMTP id
 5b1f17b1804b1-45de20117bdmr33178795e9.15.1757328632179; 
 Mon, 08 Sep 2025 03:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc0Ok4yxV6QEz0ivoEDTUmcZ69gJoABYXuJGvd2e7BT6Ijuf3K7uPDyIjzSCoWyqW2UmAmJw==
X-Received: by 2002:a05:600c:8597:b0:45d:e201:1603 with SMTP id
 5b1f17b1804b1-45de20117bdmr33178585e9.15.1757328631776; 
 Mon, 08 Sep 2025 03:50:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dcfcc2f54sm88116605e9.2.2025.09.08.03.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 10/33] docs/rust: update msrv
Date: Mon,  8 Sep 2025 12:49:42 +0200
Message-ID: <20250908105005.2119297-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-2-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 2 +-
 rust/Cargo.toml     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 10b0590b56c..20d15347def 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -1,4 +1,4 @@
-.. |msrv| replace:: 1.63.0
+.. |msrv| replace:: 1.83.0
 
 Rust in QEMU
 ============
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 99c275f2d9f..9b26aa07cec 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -13,6 +13,7 @@ edition = "2021"
 homepage = "https://www.qemu.org"
 license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
+# don't forget to update docs/devel/rust.rst msrv
 rust-version = "1.83.0"
 
 [workspace.dependencies]
-- 
2.51.0


