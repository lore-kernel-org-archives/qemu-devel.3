Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3040AC04FFE
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fS1-0001ji-DP; Sun, 05 May 2024 13:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fRz-0001gr-8k
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:14:59 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fRx-0005hY-25
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=PnpACvcW7IcKgJBPfeh+nx3cyRj1I2VUIdxtNjnmg5I=; b=j1DbTNT6evTj62eb
 OehpbvXdvAg17Qxz9ums+TIVkeVgcq4DDrVQOW9vDC0G+OxmByd/7NlLl3+CaVskp6G/N/Res3sm8
 TnqXqkba7ovi6nOWIWYU1MUCPn84780zPcdmCqd56P6cfRAaPZr37Xnur+Lc0U2cBIQlZCP9WsRb2
 xoruR/eYG5ERD6YFiw/3ioe/rYCAgnrcwFPPwxw3ps2UfthpvPuAk1rVDYNMAi8/iRtFJEVK1NUHo
 bKCV5mabjQIRZXNJylf0hF8q/eOClx7ZvgLHL3VDu69ZtcP4+B/ze6rL9by0eLeFrlIerUrWwTBuc
 tZrVr6EIXoSptFJFsA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1s3fRr-004nca-0E;
 Sun, 05 May 2024 17:14:51 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 0/7] Remove some unused structures
Date: Sun,  5 May 2024 18:14:37 +0100
Message-ID: <20240505171444.333302-1-dave@treblig.org>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A bunch of structs that are currently unused,
found with a simple script and a bit of eyeballing.

The only one I'm that suspicious of is the SPARC
one, where the patch which removed the use is a bit
confusing to me.

Tested with a 
  --target-list=ppc-softmmu,m68k-softmmu,x86_64-softmmu,arm-softmmu,aarch64-softmmu,cris-linux-user,i386-linux-user,sparc-linux-user
and 'make check' on x86 linux.

Dave

Dr. David Alan Gilbert (7):
  linux-user: cris: Remove unused struct 'rt_signal_frame'
  linux-user: i386/signal: Remove unused fp structs
  linux-user: sparc: Remove unused struct 'target_mc_fq'
  hw/usb/dev-network: Remove unused struct 'rndis_config_parameter'
  hw/arm/bcm2836: Remove unusued struct 'BCM283XClass'
  target/ppc: Remove unused struct 'mmu_ctx_hash32'
  net/can: Remove unused struct 'CanBusState'

 hw/arm/bcm2836.c          | 12 ------------
 hw/usb/dev-network.c      |  8 --------
 linux-user/cris/signal.c  |  8 --------
 linux-user/i386/signal.c  | 10 ----------
 linux-user/sparc/signal.c |  5 -----
 net/can/can_host.c        |  6 ------
 target/ppc/mmu-hash32.c   |  6 ------
 7 files changed, 55 deletions(-)

-- 
2.45.0


