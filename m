Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D11CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvylU-0000iI-R7; Tue, 09 Sep 2025 09:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylR-0000hV-Tx
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylM-0005Dv-B8
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZIYDj47YmC+lRZsEsw2qDam9wnvXysm/Az6juMmuBIU=;
 b=cXVVwyacyPPo9dLUVm9EJSp4S/7J28wGJtoKYxLygTtsSIXmFprlSztrV4Q/j83YAmeQLq
 /isNPdA64+t/95Xl54dJXHRLVT331h1Ju5o2vItRWqRAfcmCEhI1fxmLuRg+upJTSS+YqQ
 NwBU+4VB7W98fburciWFIhm6LYtpwJo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-yT7zlcmGOoOtBCXbsJ2Gtg-1; Tue,
 09 Sep 2025 09:51:55 -0400
X-MC-Unique: yT7zlcmGOoOtBCXbsJ2Gtg-1
X-Mimecast-MFC-AGG-ID: yT7zlcmGOoOtBCXbsJ2Gtg_1757425914
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A11A180028C; Tue,  9 Sep 2025 13:51:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C0F61800446; Tue,  9 Sep 2025 13:51:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>
Subject: [PULL 02/23] Revert "meson.build: Disable -fzero-call-used-regs on
 OpenBSD"
Date: Tue,  9 Sep 2025 15:51:26 +0200
Message-ID: <20250909135147.612345-3-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

This reverts commit 2d6d995709482cc8b6a76dbb5334a28001a14a9a.

OpenBSD 7.7 fixed the problem with the -fzero-call-used-regs on OpenBSD,
see https://github.com/openbsd/src/commit/03eca72d1e030b7a542cd6aec1 for
the fix there.

Suggested-by: Brad Smith <brad@comstyle.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250508144120.163009-6-thuth@redhat.com>
---
 meson.build | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index fa6186db334..3d738733566 100644
--- a/meson.build
+++ b/meson.build
@@ -709,11 +709,7 @@ hardening_flags = [
 #
 # NB: Clang 17 is broken and SEGVs
 # https://github.com/llvm/llvm-project/issues/75168
-#
-# NB2: This clashes with the "retguard" extension of OpenBSD's Clang
-# https://gitlab.com/qemu-project/qemu/-/issues/2278
-if host_os != 'openbsd' and \
-   cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
+if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
                name: '-fzero-call-used-regs=used-gpr',
                args: ['-O2', '-fzero-call-used-regs=used-gpr'])
     hardening_flags += '-fzero-call-used-regs=used-gpr'
-- 
2.51.0


