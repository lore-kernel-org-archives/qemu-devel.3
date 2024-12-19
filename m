Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D641EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGM-0002aF-H3; Thu, 19 Dec 2024 11:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOIan-0003UE-LY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:37:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOIal-0004Di-Rm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734622653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gnmXuZVjxyuTXEegCNY8fAVWWSvs9DZt6Yeth+X9qsA=;
 b=a9lWFIEhVfhAZweJJz0M6TtBXc2V7n9VIZ37OVLD2pkIlj2lbg24ee3velTvZDpAZaGgg3
 OBVsWIiVOWLchnVPsfcg1riYee7w87CxB2PrDgw/L3xodmJl9wT0sbOcNCSHBfgKzerysp
 YIRsEdHS7+Xx/JUx1bn0cfC0zLmQkmE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-c7uyhogENwWrTFQj2Q-KQA-1; Thu, 19 Dec 2024 10:37:31 -0500
X-MC-Unique: c7uyhogENwWrTFQj2Q-KQA-1
X-Mimecast-MFC-AGG-ID: c7uyhogENwWrTFQj2Q-KQA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385d51ba2f5so469959f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622650; x=1735227450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gnmXuZVjxyuTXEegCNY8fAVWWSvs9DZt6Yeth+X9qsA=;
 b=OtLk+CYFFJQ+Uu8lHk6sou/3XbTd/CwyQNLSyt99EOXEQaBxqvAU8pvpJtpwL4+pU8
 4C+V/JsUbdb20/CRgsVyfHuKb8pv3bmyReScaFpsr4E2sT7x4HCSJ6/+6D/RUJdeUCd/
 rRzLnBf7RAkDvlGv3Eudo+UO6m6b2uPmzqRxjxP63mhCyzqLEZoupvwrsdSwxC4NlJ8g
 LvQoa5CJg/Vq+9rOdOgb2NirxbhcjtzVUvCxUmaFoJ59pMKOfCvJzgwxZUr/GTn7xiHV
 WO9BRWNemgEt9zpXNtUpfXZgDdTzeGNHx0Rv0OCL2Z8xmq5aDrmf7epH8bXi6XWhygqt
 /CNQ==
X-Gm-Message-State: AOJu0YzKXQuIml00ptyBGnlHwfrqjUD49Tf08Dn+fYvLtCQhkEKfaXTP
 Dh9DIcZMCWdBYqqqFg9pAOOu8D5GAVTJVn5uhg7kCmdlrvpNG7sk52IPGlPLs7gXWdGXTpCu28h
 Lz15NSxaLdFk5Ui/uwt4wphdRGDvCOL4lfLwKseM3LdpvSJfeowx2L+mVDMzXaaGtBvGR336TLy
 OHGitwCQgdtzbTKcB8qRtXwPf5Apj5zvRBUivQ
X-Gm-Gg: ASbGnct++8pjKWb7uysrTeXHa1D2wwydt1xmBFkfAeTbesRbU7zPR1PCrlo8qedixaJ
 OSDGuI1uUgbbBM2lv+G0K7SOZdWqE8V5+a5R//iIdbbKjswWvRq+C+oj8ZOC9shGtIzCsNS31c7
 UACvxEVtoHry6lUjA/PjDmdDo6Ztn02uVyfrJo6nBx7ZZirMQ93Kry+MApK6xCG8p/lw0WVl20B
 11muRxVVL/zVSDEgryt9A8Lw3xDEU8gx4o7NHjFql//5OhU4btDpCZ89iU=
X-Received: by 2002:a5d:6daa:0:b0:382:5010:c8de with SMTP id
 ffacd0b85a97d-388e4d8e73amr7582399f8f.46.1734622649878; 
 Thu, 19 Dec 2024 07:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLTGBsCemQ0OnpCyj5Gyqlz9SSwtq+lYR0YPGj1TrCF6dNtsou3s4N8KYullMYy3y+qqY5rQ==
X-Received: by 2002:a5d:6daa:0:b0:382:5010:c8de with SMTP id
 ffacd0b85a97d-388e4d8e73amr7582379f8f.46.1734622649523; 
 Thu, 19 Dec 2024 07:37:29 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c848a47sm1791236f8f.62.2024.12.19.07.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 07:37:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] rust: fix --enable-debug-mutex
Date: Thu, 19 Dec 2024 16:37:28 +0100
Message-ID: <20241219153728.460672-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

--feature is an option for cargo but not for rustc.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index bb779364cb2..0c08d2e51f5 100644
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


