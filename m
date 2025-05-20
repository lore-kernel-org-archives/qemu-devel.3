Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A447BC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRr-000093-DZ; Tue, 20 May 2025 13:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRi-0008S2-EF
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRg-00016D-HY
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cK2Qrag8lsMimqo4w6ggG/jQzApxY9jejaQoEEkbUak=;
 b=ehQ/Vybav/7YKrmVqcLpGoDojYWkoDsLidIBI4Ie3bXTkJmzmZ8aMMp9eBG84c9Vr85cmo
 6Ef6b0x7J0o1zEZYuzNPY/coW5JFnOz1e4902gZD1YQR2oLsc4abLHUldqRvm1a/02EX7D
 C6iYM70Q9h3U8NZxySObKoQNo3l6jfI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-hq69AJzvOH2kWTlm1eGuAw-1; Tue, 20 May 2025 13:08:02 -0400
X-MC-Unique: hq69AJzvOH2kWTlm1eGuAw-1
X-Mimecast-MFC-AGG-ID: hq69AJzvOH2kWTlm1eGuAw_1747760882
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c579d37eeeso916967385a.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760881; x=1748365681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cK2Qrag8lsMimqo4w6ggG/jQzApxY9jejaQoEEkbUak=;
 b=Pa2R1/oIXNSL+Qn3pdutHTIPLgYmFNfKs75CSFy5/Uf2DYPfRsBSTMVV0jCiWN62Gg
 Pdiw9mm7JImTpcVIslhVP2Oq65SwvV3a1rGJRq9MawqpHGxUAKemTh8xlDpQHEU7BdJN
 YWZsxtvuP5Vk0M/e8bMIwAgIOkP1xPjVSDDtotRfSEDHWFC77K6YJ6pBv2SVCs/Twej1
 cFao3WZ7heY9s4wD/Kp3rOhXiVA4WiOk1UwfkIagXiDwpAQncs+wniNlJg28q6fVD3Rd
 Mb5p0K+b8FFBfxVba4YEg/bqbbQSN7YKwJdPN1dgI8eb1cN0QRhmgJXa8sSX4smlzk7Z
 lQ2Q==
X-Gm-Message-State: AOJu0YzguC90OOJMNh809gGNG76Yy1zqGko2HgzBI+eGJhtQBY4PNECK
 crGZS6OqdN9+OnDAC13yzIQ5viDsYiJMPazdsu5AIpYs+kc8rnlQCdxEXiPuv5x1IuJSzMupj4q
 2ImZ7k7yR6D9YgBGMKdPqZ7gpoD+1aFy3Ms2zjT4lAJBXNFQN7Dxs2wf2V0qMQ1gZtCcqo8i6zs
 7JJRc+fv4HmebHH3uiEqJpMxl66YdS5OG5P3CaLA==
X-Gm-Gg: ASbGncuqOCNHCkM+iZPUcXTQVY+GEdFBVxtV5sDn+dhHLgpnWGDklTzMbfK0wurahWx
 0ZzuB/lCj1N+yfsm83LPqwZDM5VnMFOy/KGDeLe4xKPaif/KoQZEFddn2T7108LRznKKBEgtPcg
 9AvZIZx9kI8X/LhrjW6Kd1FetgfBdzPNZ+8Phxg/q+0wUw0x2AYCH5QfTGtzH+jFdDT7xgBBED2
 DCSu6nzjK9lGz4k+CY+6Xe1hH7Y70holkEnMDLt+ipilKJqfgPJRhQxVxFFb8dz8B8tK8o4p5mz
X-Received: by 2002:a05:620a:1793:b0:7c9:256d:f6b6 with SMTP id
 af79cd13be357-7cd47f0f301mr2305922185a.2.1747760881176; 
 Tue, 20 May 2025 10:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkKLwIkorKdzOcSpiP4fteKVOeDjGU5s9tyL22DM/26CHeQLU8oy8w/gxo2dhYyVPWRdSPoQ==
X-Received: by 2002:a05:620a:1793:b0:7c9:256d:f6b6 with SMTP id
 af79cd13be357-7cd47f0f301mr2305918085a.2.1747760880768; 
 Tue, 20 May 2025 10:08:00 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:07:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com
Subject: [PULL 04/12] ci: Re-enable python subtests in qtest migration suite
Date: Tue, 20 May 2025 13:07:43 -0400
Message-ID: <20250520170751.786787-5-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The migration compatibility tests have been running with the PYTHON
variable unset to avoid running a broken test. The faulty test has
since been removed, so we can enable the python tests once again.

Aside from the broken test, only one other test uses python and I have
been running it locally ever since, so this commit should not expose
any new bug.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250513133353.23022-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 248aaed137..fbad34138c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -227,14 +227,6 @@ build-previous-qemu:
     # testing an old QEMU against new features/tests that it is not
     # compatible with.
     - cd build-previous
-    # Don't allow python-based tests to run. The
-    # vmstate-checker-script test has a race that causes it to fail
-    # sometimes. It cannot be fixed it because this job runs the test
-    # from the old QEMU version. The test will be removed on master,
-    # but this job will only see the change in the next release.
-    #
-    # TODO: remove this line after 9.2 release
-    - unset PYTHON
     # old to new
     - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
           QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
-- 
2.49.0


