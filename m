Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AB606A32F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uk/Ya73g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1No-0001qA-Rq; Fri, 27 Nov 2026 14:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Ne-0001m4-3C; Fri, 27 Nov 2026 14:13:11 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nc-0006EC-Ds; Fri, 27 Nov 2026 14:13:09 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FA8540950;
 Fri, 27 Nov 2026 19:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A41F00893;
 Fri, 27 Nov 2026 19:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806787;
 bh=uroSrAqj9LH1phzTsP/8O/Nv8k16SbW9CDugRtmdQFI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Uk/Ya73gIeqWvwwczqzQ5D3cVNMEb/5NeZsR6OeLBMiw2Swf7q7SCj1WClArSQo9W
 /h+5ybhZk2K+4BblgGusEernqjBlq/bC4T4ExqEkHruHEzXBJ4UvAbkgT2xaM4C0ru
 Oyj6AaL5lFpj1zRMwDEMFeoYPIzVsPqjD3PsC+N3wWWSBJnPz0jM0K5vKJyj2ssI01
 kyEAJtzviBsMt/FASWdv9gzo/UMdxIRxPTya+DX9J0b612K/ERt2UIcZ2UEw/jEWYN
 Ga+HJQYJWiWq7F6eR5OeDoXl9BLL8PPthWI6gWcjY/t9VWzDm9OVWmoFRfrQn8M6pR
 9BKX9HiFFfaUg==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>,
	"Denis V. Lunev" <den@openvz.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 04/13] hw/ide/ahci: complete unsupported NCQ commands
Date: Fri, 27 Nov 2026 20:12:39 +0100
Message-ID: <20261127191250.3298004-5-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127191250.3298004-1-cassel@kernel.org>
References: <20261127191250.3298004-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

execute_ncq_command() aborts an NCQ command that it does not implement
(e.g. SEND FPDMA QUEUED) with ncq_err(), but does not call ncq_finish().

This means that no Set Device Bits FIS is sent, so the command never
completes. Linux will eventually notice a timeout and reset the port,
however, the the proper thing to do is to send a SDB FIS after calling
ncq_err() such that the host gets an IRQ.

Fixes: 72a065dbb13d ("ahci: add is_ncq predicate helper")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e3ae46e869..e14b298ea6 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1127,6 +1127,7 @@ static void execute_ncq_command(NCQTransferState *ncq_tfs)
         trace_execute_ncq_command_unsup(ad->hba, port,
                                         ncq_tfs->tag, ncq_tfs->cmd);
         ncq_err(ncq_tfs);
+        ncq_finish(ncq_tfs);
     }
 }
 
-- 
2.56.1


