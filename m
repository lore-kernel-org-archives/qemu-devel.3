Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C3FC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwFou-0006Q3-89; Tue, 18 Aug 2026 05:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wwFos-0006Ip-B1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wwFoq-0007yy-VW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787044156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rtR8jkeiSp/UP6IO/666zkBTv+Kr+v6jVALl4FiEUK8=;
 b=PgEa5m7d6jR0fAOthJ9fPvIefaJsBCvpEq3udZ9XDTLY5TYBAw1Ux1diJY/G6vVIsak9GO
 0jn8kF5Er0R2a+NKc0bZ2t4E1hL/JrY2ybqEiBA/Sj/IXF45FTRNKiaKKQbM99mBNKNqHu
 2xEilM2qeTS0x7CNSsQGzWZe5tUIVVo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-qNao7ZBCOkyzij3piiW4HA-1; Tue, 18 Aug 2026 05:09:14 -0400
X-MC-Unique: qNao7ZBCOkyzij3piiW4HA-1
X-Mimecast-MFC-AGG-ID: qNao7ZBCOkyzij3piiW4HA_1787044153
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso5219293a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787044153; x=1787648953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rtR8jkeiSp/UP6IO/666zkBTv+Kr+v6jVALl4FiEUK8=;
 b=XkHHsHwNsE2WL1m9B4aCtjXQN/3JtpnqzVk1GGk8yrPAmTPu5NFh7qW/qE7agB9aV/
 /GQxZDIyLEwAtqFzB13BKQbhtnXuWRoznNsb6FISgxPRz4xgRQ7oddWFo4k+V0DqQ63n
 C23xMFSfmIQXs46atU30xyMgIk6wz5ZijkXswmsU3Lkpr8HuM3RKpTKSUsGeXTgrXLNt
 UNoIBx1hy87R8414LFPs1kzW1ql+raUILIcFau8kqejlVQfd4KkgjaJDXM1FWRidyLj1
 0HPdS6hpevPuskmAih5lje64nidQ0cbORdpD5PF6dEJqfN20wKKFPX24elibHyrDlDnZ
 8ULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787044153; x=1787648953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rtR8jkeiSp/UP6IO/666zkBTv+Kr+v6jVALl4FiEUK8=;
 b=hmtMfCkIl9wUhs/W0DDVnhBfb1g7fzVFXd5pNCjKFF6CtDgYymDiJhYdMSgBLrPJ/x
 aXmIw291H/h2XmRrnSj+HjPyzu95OgkqpKZWbouRr8A+T32Rlsa9X9kSAPaLdqmZreB9
 1ASWZzxeqg8u/ZPnJVF2pWQrOW0aXfQLP5r9feNlsKOiXyIlRYRt0yclsjondBE7ZzfW
 fKYtnmvk/njYcBgCqt4TZ/3NdZLhXuHAwTK60Bee1du8SsQoyuBnqBnpC/vhYV1E0avX
 Fb0eTNnsSpL9MkAQNgNcjMGHNKHzlcpXh8sVCJb2x8C6FgEuIjMHXqfRY9a2LPEjZlyn
 FtWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiCpJbNZRNNDbGbSsx8IOGiW/CNd5kXroLXV0YyonuouXHYKbeHw8Q4uiUtU9n+UFr8zMpP9+wM7bW@nongnu.org
X-Gm-Message-State: AOJu0YyODW1Ke2R4pQfIWx4Z8llpHRuF1MfsYUnv/agrPd2emuIp2V0+
 ZUMkeRiGGmCmZ4HA3JgA2VsjyhGLyzrRsJVgAiELnn3VU95rHJ7S7HyQmyouwo2Z6LKRitSJAhI
 txRwYlVb0ZX8bdvyHHaEq/9BGdkmbO2YQ0AMB9FZTvWqHEGmvn9KsX4vk
X-Gm-Gg: AR+sD10UbMMu+vUPgdqY4Trp6Evw+8x8+mA7sYDKNoXd0KTS3erTGMHcaq2qgno2/O6
 aWvtSMcNhDGKd5mPhk2BOP6agryWv4TDQwtazQl5Jq1C9ZKfofKwCny3h/F6mA9BGuEX8Qh8bBL
 LMSM9mrgZ1UwMdP4rucONcIo92bAK0eVAl/pCNXyvgRhl1NxCH0PQB4bTaVd3JlfuIa9ViAxZdu
 jCAry+l1n+IojGS78z4BE3qnHQ0MXP6MhwWmXEXiN9fFG7pbAHPDQRgFgaxQvHzFCH9V05D633b
 o+mVoqZORdkTKQSkhwJTTlzahjPXlHy9gMYtNtW2LxMzcqL6KSOJhDx1wPcLrNC+p/OFGi824vw
 EY7v3FnThtx5eX0KTc7YMLO2lorfh53Juug==
X-Received: by 2002:a17:90b:264c:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-3933b714f34mr34139120a91.1.1787044153448; 
 Tue, 18 Aug 2026 02:09:13 -0700 (PDT)
X-Received: by 2002:a17:90b:264c:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-3933b714f34mr34139026a91.1.1787044152986; 
 Tue, 18 Aug 2026 02:09:12 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-39531fbb41esm7870063a91.10.2026.08.18.02.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 02:09:12 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] MAINTAINERS: elevating myself to be a maintainer for igvm
Date: Tue, 18 Aug 2026 14:39:05 +0530
Message-ID: <20260818090905.87090-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I have worked enough on the igvm to be confident to elevate myself to a
maintainer role.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

changelog:
v2: fix typo

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..9e0a2a656f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4118,7 +4118,7 @@ F: tests/uefi-test-tools/
 IGVM Firmware
 M: Gerd Hoffmann <kraxel@redhat.com>
 M: Stefano Garzarella <sgarzare@redhat.com>
-R: Ani Sinha <anisinha@redhat.com>
+M: Ani Sinha <anisinha@redhat.com>
 S: Maintained
 F: backends/igvm*.c
 F: docs/system/igvm.rst
-- 
2.42.0


