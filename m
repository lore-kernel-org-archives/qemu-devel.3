Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A4BC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBk-0000LP-7z; Wed, 04 Jun 2025 09:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBS-0007q5-QM
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBR-0004rl-8P
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyDHQHo4ft1mccvdA/bVEPUqujwbt3FbV7OstM3AEGQ=;
 b=HXE9H+dcHLAHUXLL2Vk9pFQsZxVwWdbYcR7YKgdkGLxXIBxlQsGH2FTM4/ie+ad2d9uxHM
 5tuv70cFnmJ+QEoUy3Pc04ic5bjnXbPVYToSTLRzEp+Zfr5KTX1/6v065a+SEo2nEC7rlm
 V5LczJCBl7f3ONj0WcgBfIrMUyiCUDc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-H6lU43vbMIuf4iANQLPNZw-1; Wed, 04 Jun 2025 09:29:31 -0400
X-MC-Unique: H6lU43vbMIuf4iANQLPNZw-1
X-Mimecast-MFC-AGG-ID: H6lU43vbMIuf4iANQLPNZw_1749043770
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442f90418b0so37168355e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043769; x=1749648569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyDHQHo4ft1mccvdA/bVEPUqujwbt3FbV7OstM3AEGQ=;
 b=nClQ+Vp+ZfyPOhZYDlfa0TjVl+xjPBJbs3eYvaERTv8KkGjmgKfMcirfsN/ToJiGA5
 nZKS4W912w42/nYrKMOb1YZHflYFFMymAOGHxjS8MJpwCQecWpVXfZu5/HGA4WYC3url
 v7AydLPhLwnr0tsDO/q/JFpBOE5Swq5P+WrTmJOeLbKB423shBe9HfOD6iO/sBnKm3O+
 xV7biP2xNkayEPx3dTx1rDKHVrUmqs/ILJ3BYp/Uq9mR886c7uQKe8KDbxp/O3gXcEhg
 asQGriJZhBRQninnusAYSY6Ly/cs9uW4BUvnc/qWc0E4du13ibjvCluMhysR9Ab7PoN1
 D/aA==
X-Gm-Message-State: AOJu0YzSG3B4wF18Gl7y8Yb0Y+MJDQe5hJyN59WiUtaRWlJrctK77SpT
 0AkgkAMJC88+5ODKQ21DRosUGcYmE5lsWPLsX/PzpbKGdHeym7u9WTpIcrFYeKvHAC3Za/ev8Cl
 77/Xso6tXTW+fucP8Xap6CUIkt9p1fYPF+i22lGpOgpLMXNPPKK0wpN3H1iEJp9YT
X-Gm-Gg: ASbGncs/Uq3uXyAlpf47NdFsxcS9SviRelEWp97WcNoWgMrGP/2FAnWEAYtS4pfjJhh
 JVSNJFvbb6CxeQBPKk3vDG/7cECF7ucHPGMSr8hts8focO/vO9CxQUJb5E6mG0rVePkj9Fd7F9q
 BbMOM0dBsJbSFQxqyKfIsCwMZX3qjs93qZvTkEMexkjULVvje2zsrENDJP245FG4lVp8aYBpFfq
 djZSaOHgU/6rmLk5XStZHoktOaAX3hmhFBhEqA7toZpSGU3e94HRGVi0rMR74aHJj2BSrdKEllH
 105AIlhr64pCzWfPFZ3pZhLBzHfYt79nYbjFBuxWWPJEapinsfjLd/tElxkgHH3UhJ2rlA==
X-Received: by 2002:a05:600c:3d97:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-451f0a732a2mr28355425e9.13.1749043769485; 
 Wed, 04 Jun 2025 06:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnokjqBtgZ0nqQWxCAuFw4Glm9wlmXOSItwOs4B+TgO9FV6LkW4YaTBm1lWHlpUMa4BgeE8Q==
X-Received: by 2002:a05:600c:3d97:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-451f0a732a2mr28355125e9.13.1749043769116; 
 Wed, 04 Jun 2025 06:29:29 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c8f5sm21345300f8f.27.2025.06.04.06.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:29:25 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 19/21] qapi/block-export: Document FUSE's multi-threading
Date: Wed,  4 Jun 2025 15:28:11 +0200
Message-ID: <20250604132813.359438-20-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Document for users that FUSE's multi-threading implementation
distributes requests in a round-robin manner, regardless of where they
originate from.

As noted by Stefan, this will probably change with a FUSE-over-io_uring
implementation (which is supposed to have CPU affinity), but documenting
that is left for once that is done.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block-export.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 3ebad4ecef..f30690f54c 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -163,6 +163,11 @@
 # Options for exporting a block graph node on some (file) mountpoint
 # as a raw image.
 #
+# Multi-threading note: The FUSE export supports multi-threading.
+# Currently, requests are distributed across these threads in a
+# round-robin fashion, i.e. independently of the CPU core from which a
+# request originates.
+#
 # @mountpoint: Path on which to export the block device via FUSE.
 #     This must point to an existing regular file.
 #
-- 
2.49.0


