Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245A3C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh76-0001KA-OI; Mon, 26 Feb 2024 14:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh74-0001J3-UD
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:58:10 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6x-0004vN-JP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:58:10 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4cbc49dacc2so1893375e0c.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708977481; x=1709582281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+PTBS3KKeQY3OK8H3H0sBlsb0C06FUYzlAVrOFK09Y=;
 b=jwxwwBFPxwHnukQ2veUsNHzbBtBEG6F7OFiEXAIM8IHG0MVGEC7PzwakYOByt/rEdM
 ysUDtyD4gq0gv8MP/bc/1gFXIDWWELC0dkVId9GCg8DN7ddxXf0b9lc7kVMCh7otUVXz
 JfCnKP2fAijiB9DUxYPVlCtnY4KYFDnCT5LwGLi5XPp7Q9ivG4o+tPcKyAnGwFlKMzJ+
 rWZqbHhajLPhKTlcp0FK8eu9EtIcpyjajDl3h3xru9n/K8fw7H6BY33deIWQEsH647tS
 grisAM4y76WflhqrX1wWS9z3iK4ihp3YaFdrGMT8Hldoz9Y4BaOgQnRVrEzNpUPl03FQ
 QhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977481; x=1709582281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+PTBS3KKeQY3OK8H3H0sBlsb0C06FUYzlAVrOFK09Y=;
 b=hhUuREJmSpGjyPnjMTm0F5hSG+QGMKaIi+Wj0YYZOk1wxWysrhYvRMhq5CmoHHQLSa
 zOl6H2zOmCbn+PRq1YuRNoVfBNIqviJYyiw5XZdBJhCxIlgSwneQK1pcn6YngnHjM0lY
 /hVctnjbLQmT2F2vgQyKORmVcygoebWg15efZcLsydMFh3dZMjway67z+BlQJsLIiE4j
 qkPPC/2nfXjV22opgTjYDP4OF8mhDw36wXJyaTynGc73KEmtw8qkpZaVmVsNf+1yWXfZ
 FUn0wSVK/B+UeLqXCRy0rzNDRR8LOFXjrhJu9mo+IIjyO4OlnhC7puKXz93xRGYMNf5I
 UkrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwQ8GPthiBFvUXY+K4HFSJFwQOd9PyrgNEC/5KxyQ9kPhWwxQTmKOr67hbsvoZwAHyhsrnYUTVhAr3omlL/taEEd16HNo=
X-Gm-Message-State: AOJu0YycI3D0Kj9KN8FzYrp8/qtVG9iOdua/6xlQ5aKYS/Dfdm9QjjhQ
 LTnst0QLkF4PVi2XJE60ktJVr3tyGlBWKRbH5bd5QSMF1iOtvXMr4ASrpDQZmMI=
X-Google-Smtp-Source: AGHT+IHtxxekvVzB/trJeF2/orsW8jpD2AX84jZC+UwDYMCwJW7WI/gNPwWleeX6kf6ZaQhlWChq+g==
X-Received: by 2002:a1f:dac3:0:b0:4cc:b98:43d2 with SMTP id
 r186-20020a1fdac3000000b004cc0b9843d2mr5944422vkg.4.1708977481510; 
 Mon, 26 Feb 2024 11:58:01 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.95])
 by smtp.gmail.com with ESMTPSA id
 ej5-20020a056122270500b004ca3dc45886sm712738vkb.47.2024.02.26.11.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:58:01 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 7/7] Update maintainer contact for migration multifd zero
 page checking acceleration.
Date: Mon, 26 Feb 2024 19:56:54 +0000
Message-Id: <20240226195654.934709-8-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240226195654.934709-1-hao.xiang@bytedance.com>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add myself to maintain multifd zero page checking acceleration function.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 992799171f..4a4f8f24e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3413,6 +3413,11 @@ F: tests/migration/
 F: util/userfaultfd.c
 X: migration/rdma*
 
+Migration multifd zero page checking acceleration
+M: Hao Xiang <hao.xiang@bytedance.com>
+S: Maintained
+F: migration/multifd-zero-page.c
+
 RDMA Migration
 R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
-- 
2.30.2


