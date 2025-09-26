Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16033CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 11:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v26Bb-0007JH-1l; Fri, 26 Sep 2025 07:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v26BW-0007HB-Vr
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v26B6-0007RX-U2
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758884374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pNGmeCKi0JX5n5aFPGBFhsDMn61iW3r5CBkFK50MvDI=;
 b=hELAxOF66g44L3QNYbAvlbLnOqVkWmg/sNpxf7+uQw54b0JwMl2bY2TKWpyvzASv4Ps34x
 CmuAmXDl+6+tCQCN1JWtQLfNLvf9uQRhjfkxEyRaqTLG/Kl8COBHs2OKWovv2ot7knY6xf
 jPnsFEmqSIxo/xe1UYglj21p8SP1oqc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-4lSU-2nfMoW3T0geyfzZww-1; Fri,
 26 Sep 2025 06:59:31 -0400
X-MC-Unique: 4lSU-2nfMoW3T0geyfzZww-1
X-Mimecast-MFC-AGG-ID: 4lSU-2nfMoW3T0geyfzZww_1758884370
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E9251944F05; Fri, 26 Sep 2025 10:59:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.43])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67D6D1956095; Fri, 26 Sep 2025 10:59:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E2F6F180009C; Fri, 26 Sep 2025 12:59:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 0/4] igvm: add support for igvm memory map parameter in
 native mode
Date: Fri, 26 Sep 2025 12:59:22 +0200
Message-ID: <20250926105926.121890-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

v2:
 - add support for loading the initial register state

Gerd Hoffmann (4):
  igvm: move igvm.h file to include/system
  igvm: add support for igvm memory map parameter in native mode
  igvm: add support for initial register state load in native mode
  igvm: track memory regions created

 {backends => include/system}/igvm.h |   7 ++
 target/i386/cpu.h                   |   3 +
 backends/igvm-cfg.c                 |   2 +-
 backends/igvm.c                     |  76 ++++++++----
 stubs/igvm.c                        |  26 ++++
 target/i386/cpu.c                   |   4 +
 target/i386/igvm.c                  | 179 ++++++++++++++++++++++++++++
 stubs/meson.build                   |   1 +
 target/i386/meson.build             |   3 +
 9 files changed, 274 insertions(+), 27 deletions(-)
 rename {backends => include/system}/igvm.h (64%)
 create mode 100644 stubs/igvm.c
 create mode 100644 target/i386/igvm.c

-- 
2.51.0


