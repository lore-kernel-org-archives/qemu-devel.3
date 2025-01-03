Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11573E77198
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 19:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTnck-0000ZF-Ae; Fri, 03 Jan 2025 14:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1tTnci-0000Z2-HK
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 14:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1tTncg-0001Go-OJ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 14:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735933575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p83MjaGlcXEDyx+Ni16wYf30AG959q/0HJeOs16rl44=;
 b=NhwF9AoZtHuH/cWumlB1O8inL9LXfh5ace+2ssG+oSTatSPvMMxwXNHCDutaMogB6YCnqD
 5q1Q0YFnrMfIkUpSJUR0RVVvFK8ZNqs2DBbgjNG7mEeWlKB4mNwIBWGWZzVxGH+Am/bmQK
 e6Ln9aNbAK12n88MF9ko3t2665vb134=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-xv9pFCK9Mz-bauUf6Q2eMg-1; Fri, 03 Jan 2025 14:45:01 -0500
X-MC-Unique: xv9pFCK9Mz-bauUf6Q2eMg-1
X-Mimecast-MFC-AGG-ID: xv9pFCK9Mz-bauUf6Q2eMg
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2efa0eb9cfeso16796565a91.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 11:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735933500; x=1736538300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p83MjaGlcXEDyx+Ni16wYf30AG959q/0HJeOs16rl44=;
 b=EuZUQ4X4FF576iFHL5laA25z5ej1FCWDKUuOo+5CEV/0W7eB5sCErjPo4+lsgOzVqQ
 AFbr/cH4LVeFXMQ8JRTVG8it56G4WZ6yU/hteGaSJrRc4drVHlqPLB/uQJby4/+UptKH
 RJQNQ8FwZ93B1amwkGmvc1KmZzCXxk9C1u4zd6/IbpwaHsnWpagjqIiUBP6CcGLqVTKQ
 5Wz3c4nwLq8luvOtLbaU3/shUzov8zIC1mTPxxNSFmtV1u/FG3k//oJAnGv29yMCcTVt
 alqbOqwpgt2OP/2EY+5nA5qUtT2NsWKW35X5RAt+lhP9S0+jyXMc1Ay2G7Enp3mPjQxv
 68EA==
X-Gm-Message-State: AOJu0Yz227ofHkYzCknhfWxq/igozW+T7XRy7MG/pBgvcvlglqWmr3QY
 PNhaup9JBaS1RMGpntd5ZA4kfAtEw4/KKe1SJD7DDETOJmCgXj2+yUrPwlI9t39+HShP40b8GKW
 7FxD28fqrh1rJJ25189JazNonQgx6RSX2+DnbgbBLNCCsDGZDFlLz
X-Gm-Gg: ASbGnctNCj3YiMrvIp3cn4Orodf+6nd8YfF48kVAMUSZz9t1JUDei/zezZafZ2wV+ZL
 arZ1k3cdidv6qrUWjDukgJ0hTO9gC/H0BxaKp1vZvm6MKzEXRYlpE3o11Ab4X8nBq4FP2ZDBYr8
 YjW72/5dWtvVu76w6I2ZM+b1eeXuzh4K1fFxTh9jnvpbX415zV9AT3wAm38m7ABCKUEgpxQ7Q3r
 6KPw41+fw9WK6lLvxosF9WXrhsZ85pLvpIQH3umhqfjJRbwR6EVWETwM1sZA0N4Oc6XXhkNLlhk
 +z8S3Ub16n4=
X-Received: by 2002:a17:90b:5208:b0:2ee:7e53:bfae with SMTP id
 98e67ed59e1d1-2f4536531cfmr69319029a91.10.1735933500191; 
 Fri, 03 Jan 2025 11:45:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+dFAajW+wzr7nnqNMvDeOYxGwnG5PzWvvXBqXmu9j4cFUR0VywUdZ3qgJI2G2DjBtps+1kA==
X-Received: by 2002:a17:90b:5208:b0:2ee:7e53:bfae with SMTP id
 98e67ed59e1d1-2f4536531cfmr69319009a91.10.1735933499870; 
 Fri, 03 Jan 2025 11:44:59 -0800 (PST)
Received: from wmoschet-thinkpadp16vgen1.rmtbr.csb ([187.23.176.81])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca0282fsm248261695ad.259.2025.01.03.11.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 11:44:56 -0800 (PST)
From: wainersm@redhat.com
To: philmd@linaro.org,
	thuth@redhat.com,
	peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Remove myself from reviewers
Date: Fri,  3 Jan 2025 16:44:49 -0300
Message-ID: <20250103194450.360789-1-wainersm@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=wainersm@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The time I spent contributing to QEMU was great, but I've not been active
for a long time now. So removing myself from the reviewers list of
"Integration Testing with the Avocado framework" and
"Build and test automation" subsystems.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2101b51217..b25070a31f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4151,7 +4151,6 @@ M: Alex Bennée <alex.bennee@linaro.org>
 T: git https://gitlab.com/stsquad/qemu testing/next
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Thomas Huth <thuth@redhat.com>
-R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4197,7 +4196,6 @@ Integration Testing with the Avocado framework
 W: https://trello.com/b/6Qi1pxVn/avocado-qemu
 R: Cleber Rosa <crosa@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Odd Fixes
 F: tests/avocado/
 
-- 
2.47.0


