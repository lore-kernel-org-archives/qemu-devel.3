Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433EDCFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 09:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOv0B-0003ds-G2; Fri, 28 Nov 2025 04:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vOv09-0003dH-Rd
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:42:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vOv07-0007yn-F3
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764322969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KAbRuebQpS5YcNDD4J2eZLQvWeeGyNZf76fc2t913LI=;
 b=NgYaxajAsKmEtoTLeIsIUNLW880JAhZpOWOyaINvlRz00AkBmEe7dEmWVSCefy1MMWvyu2
 DWCEUatuCYspYiCr8t20+VJMTjvcamIjEfXsKV8ZyPst1/ZpyhGzkR+0IkYqzxKcK2o92M
 N7UHZcrPjRjfecp2dkO9aP46S5CkO3g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-jVu08-GqOrGvNibzsYcW1g-1; Fri, 28 Nov 2025 04:42:48 -0500
X-MC-Unique: jVu08-GqOrGvNibzsYcW1g-1
X-Mimecast-MFC-AGG-ID: jVu08-GqOrGvNibzsYcW1g_1764322967
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b73533b84eeso133612966b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 01:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764322967; x=1764927767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KAbRuebQpS5YcNDD4J2eZLQvWeeGyNZf76fc2t913LI=;
 b=UOK7YBFpwsgTCDsn7K+QZzpoJIvmBRdGTPJXso4yw+9gHrWBeESijhXW+8J9lvoesH
 cLTSNiNSV/5mSIXytEdOXio8rAFnt9IqmFTdQOpnJpZhORw0zHqNQqxWLncEeemu1L+x
 ZxvEVwzjLC4fwUHg4Kr0t6As3LY/s+bYtDyPnMsd6VfMsCQ0vqMg5UsaUM3SIR4oJKUa
 mJ77fz2SQSq3vqpWH042ET80LaaDP1zA+7Q4QEs3Mn13tnAgTOAxnu4tGysDvcq2yvBE
 ISP2B6uHOrD64YB5lDuneq6W7KkLG1ooJ8uaNguQGlaUegBm7aNEQbA20B30Mj0Bw8r3
 Oghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764322967; x=1764927767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAbRuebQpS5YcNDD4J2eZLQvWeeGyNZf76fc2t913LI=;
 b=RKYu9K1vMc8ReWC/hko/h9hfFehtTjDHkvgk51YlzKzTn111ifNY4w6w7I3el5QGOZ
 QHL2gxCwGwMw842ZCEsy6AqKZ4yGcIwLTibBK4pB/yXFVzAfQhTnGUnUtxRc0cJSfvOs
 9lzcCzRU7qUUt6OwgXpb9hm8Y+fiq/Xfu6kOWFuvyxvcEzyOWLB8Yndw5U6in95ui8Jo
 BvPe+3H3VbRYkICG4b+GIN/AZuwO5bedQhEP/cFQCskB7EFHQgNYzxfugvt8IfMNSHqF
 TYyrK5tdrfJWjMU81S3wJntQ/GOqgS1Ehq6eO2LfrXt/teLBNYTOu56NzEAl5v9cx1q3
 lC/g==
X-Gm-Message-State: AOJu0Yx9d3W0e3TITnccL9pyV10+RH3ITK7n0BbA1pOkYHEVGnlW4/PE
 uDmvYjVBo9qwo43FUNkafCQeZdRc3EMJmtKGJfIMrAnYtllmffxPtq7WzIOwDSdp0EL51scvZA1
 4B378hUFxlXOGJuoWOC2Sa4vtS9+/eVAIkEFIwU07KYzdReNci3GgVdBbgqlf1Uc0x/XFl4MZpa
 hYVy9gZsQJpcyolbD/MWDuirJvaYhlb0aJZmCoFrXz
X-Gm-Gg: ASbGncv4affm+i9+IxHwvbP5cWg9YpvcE0XxzqNxMA5CIn5xZjAltOQRZWTw3g/YsQK
 zC3xHo6RvHqwK3/6Wyhnj+T6cr+bHahc7+mwWUEJT0wjQvB5IJulJIxvDVeA9Lz4BbzxnS9NpvK
 B7ty0vOvsv7MBb0OSHWWfiNTVOvn+Cv8ZsOFhjPT2rh/sT9swvq+HGc9i/D8NFqTe+yfcrbnYhq
 9bE3uW80cVSNE3yCu7LBOUytVgnjvpqu9Wt/yoXMqf9Z2YTeyEReHfzn7xPrrumJOT0c7nm1oAh
 h8WvusmWGJnOcWsshdmFAeia/ZOTnAJ7EVVTg26Ch869dwwqmxt2uwsPh1qjdmCJrK0CK6jn7eb
 jgWIfjg1MuoK8KQ9gYOU7bMRCciLN2yo6dJC4SW64WN4Qjgpu9403N//mxG7rLH+yA0f9yyG917
 rgoTBT8AePjhzj/R8=
X-Received: by 2002:a17:907:2d20:b0:b73:8bdd:eec9 with SMTP id
 a640c23a62f3a-b7671558a7dmr3102720266b.5.1764322966577; 
 Fri, 28 Nov 2025 01:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIOzOUuiiWm3D2OJnQklqF1IDhiXRoxgpcyZMJlR+oeevanI4Z3+lfcQasy5HljeJd8hSNSQ==
X-Received: by 2002:a17:907:2d20:b0:b73:8bdd:eec9 with SMTP id
 a640c23a62f3a-b7671558a7dmr3102717066b.5.1764322965975; 
 Fri, 28 Nov 2025 01:42:45 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59aebecsm390140966b.39.2025.11.28.01.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 01:42:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: workaround compilation failures with Meson <1.10
Date: Fri, 28 Nov 2025 10:42:44 +0100
Message-ID: <20251128094244.208571-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Prior to Meson 1.10, if the config-host.h dependency of qemuutil ends up
as the first source file, it can be passed to rustc---which gets rather
confused because config-host.h looks nothing like Rust code.

While this can usually be avoided in the individual targets, a simple
and universal workaround is to remove the sources (and C compile
arguments, while at it) from the "util_rs" dependency.  This hides
config-host.h from the Rust targets---and they don't need it anyway.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/util/meson.build b/rust/util/meson.build
index 95aa211ef0b..2aa32a233eb 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -41,7 +41,9 @@ _util_rs = static_library(
   dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs],
 )
 
-util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
+util_rs = declare_dependency(link_with: [_util_rs], dependencies: [
+  qemuutil.partial_dependency(links: true, link_args: true),
+  qom])
 
 rust.test('rust-util-tests', _util_rs,
           dependencies: [qemuutil, qom],
-- 
2.51.1


