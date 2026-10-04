Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15763CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPo-00086d-IB; Sun, 04 Oct 2026 06:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPa-0007Rk-1y
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPS-0003Kj-O4
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eHiVSXP0JJKS4SE8GYfjwfY3jJhEVSnt+584IwtYzs=;
 b=FlnI+G0PQ3nxY0EPNij4faiWAoXjesm9CZLPV2V69/kfd6RNG5hA9tL3uNJkLCrbJK/47O
 6Jg/bJH0nuQa7yK94vRzuAZEDWXeUInpNeo2s/QQwzWmnF5qxOUNx6GV63L5tHP2GvVpmK
 +WmODmlN57PynBg9We2VZNcqDVA3bSU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-lrYTvhNTPqit1jLKeAbYpw-1; Sun,
 04 Oct 2026 06:25:32 -0400
X-MC-Unique: lrYTvhNTPqit1jLKeAbYpw-1
X-Mimecast-MFC-AGG-ID: lrYTvhNTPqit1jLKeAbYpw_1791109531
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC05B1954204; Sun,  4 Oct 2026 10:25:31 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3A191956089; Sun,  4 Oct 2026 10:25:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:46 +0400
Subject: [PATCH 32/63] hw/char/exynos4210_uart: enforce 32-bit MMIO access size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-32-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RRC1VnHNo8Sflj+Tz71gXDStmH7EKMovY4BEulPSyH0=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGrCKSOgZcJ04hmuSNhhcez+AtLP6Tcj9dFxBrFYSyL/jUEm0
 IkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqwikjAAoJENro4Ql1lpzl1T8QAJDR
 fzc4iwyRhDn5UNpoFkmZaYB5GlmJDFRF3j1qkwbpv/TQLbJTlcyPYBwpGYCnlaxygckB0r8NUB1
 LOSSZFZDmIPRVvpfP0YySOlc2cYNqBQWJBXTMjBqAYVxtULWiwKrQJqHZeteibGMFJOmQ1vLSfO
 4sPEdiZ0Ct/B5VxDdmJGLtPRP+C/7qAlLqRWggVc51QE5TC0R7RBgWeiyVUDv5HMaXlkJVsve28
 TQLiAfGy61n1COjdlVCLtBZLyipTwKteMsy9agiHe5T6IbrrgCy81qLDiHJT1nr1tviQlg/2Ndd
 THsf7iCoXtLMiN4Ld2buizQN6ijcjFlFT3FhcnEE3An+4TOPvVT05TO+QhxaBVGay1Ud1my82Wv
 ueNBUypwqgZN8VglblKBdhViG0VYFEDXYGU2w759SgIffymjmj7kifXXlfECWZOMZaTmA/MJA6q
 6g4ROPChSvGkxYLpui361kGF+C1QYR/nA8DqxaIXW9G2OpOmvK69f5ejkDIBzLYxs7AlQiee04Z
 JuKG+8oo/e6k9Km6zR7K5dFrzBCOIA9EtlsCVy9rOOpFoKgSC+iQPAVcEsSam9wEmj4dU9AyHt6
 6LkjU0pGZyVc2XeV5fJGCofACET+SFoXBCczaoRVTuDzr4sLueFxmu6EviPmkBwc8epNTTyGqZr
 Ezn/d
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Set .impl min/max_access_size to 4 bytes so the memory subsystem
synthesizes sub-word guest accesses into 32-bit handler calls. The
read/write handlers ignore the size parameter and always operate on full
32-bit register values, so without this QEMU would not extract the
correct byte or halfword from the result.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/exynos4210_uart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 7240ff7b5c24..8774d4bb43d7 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -506,6 +506,10 @@ static const MemoryRegionOps exynos4210_uart_ops = {
         .max_access_size = 4,
         .unaligned = false
     },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 static int exynos4210_uart_can_receive(void *opaque)

-- 
2.56.0.rc0.29.g47ce80527c56


