Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F2CC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pZs-0005xY-2j; Wed, 16 Sep 2026 09:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pZp-0005wr-6N
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pZn-00031G-DN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kyUXjpsCO0h8p/xe+mXLGAk+dOFnGkuZb3xo2NJsxy4=;
 b=aG499D01pZqopn2L+iKLtBocImfgAgsAPGRe8SNzOQKyHibifOP7bV+F9CNfGLdEat9S9d
 R938VcvCOF9utz4ySXo9MPgrJiFSGdbQmz5HP43u8w8NAPqtvVr1w7XPSYBrR+QCM3ORFg
 RjmAzWLYVbrZGvkWvfVzsA2Z5sf+rkc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-mo0Tc7rgOGyGrXl9k8CHzw-1; Wed, 16 Sep 2026 09:21:23 -0400
X-MC-Unique: mo0Tc7rgOGyGrXl9k8CHzw-1
X-Mimecast-MFC-AGG-ID: mo0Tc7rgOGyGrXl9k8CHzw_1789564883
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486f768517dso3022452f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564882; x=1790169682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kyUXjpsCO0h8p/xe+mXLGAk+dOFnGkuZb3xo2NJsxy4=;
 b=eFyhXc3gODBMi3dAB77Ac372pKtTuSCymw+3SBq4//Pt+/23CIgyG0AA/oxZxRxATy
 QX9YggdhRvO9UjZFVqQQNE3eExJyATdaPiU+m/DVNW0MEWuJS2zehai8LgCzjDYut+Wb
 X+VRYfBjOvW/qCna0F/dZZvje4YBRFGjqjsEVSjx7bt8QuCWm1o1HkyTF6c/U3dhObDl
 aP2WdIAw7wyfqFa9ou9Q7MXiNmL5tTO+mf94HjA1U85zQhh7zeGeBS9iIBmkublECaqX
 L6v7B+X2PJKlInGwZ+7NPHX3buIUndAqQfKv22T7XkiL0WTbBbMDVtYpYd3Ibm7FEFyj
 PZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564882; x=1790169682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kyUXjpsCO0h8p/xe+mXLGAk+dOFnGkuZb3xo2NJsxy4=;
 b=voeVvv0FqYeFyF7y9mmhUf7GTjoZYrMElmGReGiVgfkMvm4faMb746Xf2FbaczNePq
 cDWuPz1b/bUAsBIuHXEcZKQG7ltn1Tx9EDXHud8tk9qOFizhdsM8BEmq90EUAHsa+cPv
 nKRURshEFhPH/ORhR3r2rJ1bAei1tXDFiPtqdwSK9KOjSbWjQG4fm4bBL7+Pihteua6P
 vu8M1nhPYvPx9AS4neJiLBBoxUwn6Oe2FS20P2ZXaP8bY3VMsudB13ECOSYxzm9u6Y5o
 EH2/loVn2aYcIRGB2zhlxbe38G9txBMrxu+gcmqu3YvlBpga+FElz/efyhpQIXd90BI0
 bH+Q==
X-Gm-Message-State: AFuF++kM8nHqDCJiccOkH9LIe+9AKf3Ms0RY24aHrUOZNh5E52fii6ez
 XHwmUdMqDsfcr7cMc0JpWTpogkrV/Cl1iwepysrZlOut27yxaLIaSP6jFiXZhs7oV+wt/9NUzMX
 ISAd/Q1PgzXQFrppXgmQyxnajZE+Bcmbiz4FMlRS8cse+dFHPqG8IPUlOaR2Lu6L5bHNzXTp2jD
 uKxyhY1DaoJTuHJIqncJi1jlZZ0XGglf05m3/7jZim
X-Gm-Gg: AYBFou3ctQCFpIdg5/6tewyBedDl3yC1MTOgN0XV6d+Tdv5POFoYDW4TmGapquLbDhZ
 +JHGyBjNT6Cq07tt2AnizViHnpvcrGp3JpfGlO5VpxKSYxxoCb0G08FJZIbOsVbJi3HZy9vRlsO
 fLpyH5Gk4XGTTg+SotRfp8GmOTWReo70xn5Tu2Jj+LSv0Qr+yNMLkBDouHNPwqHsy9PYWc42ySO
 wqyPxKZMa2xdTSf2CBE+9E0+RNqr/t+kTUwbHC/A7mlmOiMe/AQ8MAOll/9QGVPbmzYqv0SUR7+
 Bp52jqfb3yxhCTmvkwZzMp0Dnfai8aap4tWXjamOIe3rfpWwGln03yB9Cbs13FTs1kilayHdWtk
 y5j4KNKIo+V4DU/wUUANjnBNRfc1066mNDeulRnJ6ZQi+kwvH99VTqrbGQXH4kaaoVW+wyqFJcj
 xyzg6u
X-Received: by 2002:a05:6000:4543:b0:487:62d:37d6 with SMTP id
 ffacd0b85a97d-4870d062278mr5063311f8f.23.1789564882549; 
 Wed, 16 Sep 2026 06:21:22 -0700 (PDT)
X-Received: by 2002:a05:6000:4543:b0:487:62d:37d6 with SMTP id
 ffacd0b85a97d-4870d062278mr5063221f8f.23.1789564881912; 
 Wed, 16 Sep 2026 06:21:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fad3sm6480385f8f.12.2026.09.16.06.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 0/8] ncr710: cleanups and fixes for request lifetime
Date: Wed, 16 Sep 2026 15:21:12 +0200
Message-ID: <20260916132120.860910-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The ncr710 HBA code is similar to lsi53c895a, but it can be simplified
due to lack of support for tagged command queuing.  Perform a bunch
of cleanups and copy over the fixes from commits up to
d459131ff590c517bc89fa5867d4878b5eacbc30.

Paolo Bonzini (8):
  ncr710: simplify ncr710_clear_pending_irq
  ncr710: reuse ncr710_clear_pending_irq in ncr10_do_command
  ncr710: remove weird p->req == NULL case
  ncr710: clean up ncr710_transfer_data
  ncr710: do not load s->current in advance
  ncr710: remove dead message in actions
  ncr710: copy reference counting fixes over from lsi53c895a
  ncr710: unify two conditionals

 hw/scsi/ncr53c710.h |   3 +-
 hw/scsi/ncr53c710.c | 167 ++++++++++++++++++++------------------------
 2 files changed, 76 insertions(+), 94 deletions(-)

-- 
2.55.0


