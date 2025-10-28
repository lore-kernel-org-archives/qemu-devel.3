Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFC2CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmGH-0007l5-4V; Tue, 28 Oct 2025 12:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vDmFs-0007ge-6S
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:09:05 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vDmFj-0008Am-Nr
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:09:03 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CEB493F47E
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761667729;
 bh=L13FBzb5Dbf6Zb8pqQONDrC/y/voW0s/dRyDHhZxE+8=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc;
 b=f58+jdt66/jgjSqALK8zVfffjIfMSMmmffyIJiEYpn6h+Jo/1mUC6FodmMW+qoSX2
 LBIzGhkY9gBIsqRGq0zW5wigndMzNQRbSyH3g5kJYC+zsHSNVVTNl+SUUVyJtfUfSM
 XcoIk1JIgiiTqun04TPO3QNzm6ddMiWs/8E926waSXgi8g1EWkApwiGaelQLvdTCJq
 lDwNe9HB/bGB9aoglfoDomgTy11Gv4HQoVJ6CFQvv0X40PfZcOYzG7GLVn6LLk+0rK
 CGTOZyy7aSFc1NIeYXg+genTe0gihdM9bK6ETKE5hK+fX2JX6+bgaho+jCye64JPUA
 mi3EOW5eTzqkKYReUyRPxx39L3GtTEZ8vC2LhgLci0tSKqYRtOyM28TZBShHkdEyzL
 1IKMMUCw0F0DFGFfCcappPLoNsfpYc77m4CCM4ZssKaTYLuTd+8k9rlV5kojt9Dea/
 Yi2GpAuigVYgIveIh3pc7Yxa3vZkEN+ocjDIk7F9jDPlUSEXknSy5cOygo7M9jG4UC
 uoI3p15XTeGKMOxFthrJkpNlXkuBDsF3RngsbBxwGkaYfCsm90fUo7vrxhdGivh3ye
 sdOxRWbsUC0ByVDprR9Q3ARTTI9cYi4H5d8PE5CKYQEpDIBe20T5BfxYZynQy3oupF
 7PHDaC66vpHkydlo5cEZCvfg=
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-430d7ace0ddso79976515ab.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761667728; x=1762272528;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L13FBzb5Dbf6Zb8pqQONDrC/y/voW0s/dRyDHhZxE+8=;
 b=hBxJPPlyN27xbWmedBGcPA7WpLvCqg81m4Y7U0oYxgYx5fFp+naewi9Glm0ZXKV6M4
 SMBpbzrHiKpe8L+Je5T/VGZlFoId7gglOTbava3NR5TXmNzJH5U1CvkztJLG95CEQs9b
 QdUMJHZ0hP34BodAaocnWX1p11V0SXLqWFNfd3tWLksT5BHTrLCvBRhLtVdMu4gEfxif
 T72xPdeh/pWbDN5F+Z7b7Sdi6BDGrs+XpKpJ70TH4v0GTp3oQvcs63JifWe2NCc7fk1P
 bfYz+OTrJ+yXxfEQnQvX30/PAennfkhiU66V8CjZnXnDMK9I9L7fupX87I3mnAeZkzx9
 vt1g==
X-Gm-Message-State: AOJu0Yycm7dsgIBjGOwIT0Wvtbkn/HxCYiKrWod1J6k5p2jvNh/Rb1di
 yC/AVEMQnvivjx7vel4cmqIEVkRoYM2hE4458cSSaoT9CKGBIScPmsf5qBHP5cvQdVIowwTvV/k
 dEEhudJgfsj869berEIF7ci0syxveYeevgufm3FToThU5wAgFurqrMBPf0POT3iNtAvOqDsMqrh
 4FefyexF4=
X-Gm-Gg: ASbGnctiNluVPdk86OtsPpCmkqi4KQrWyAj0hyrAm0JaoPwt/ztQAkrz6mL0VdvaN5s
 zpH7LOZuIpHnYTPlfE22MdH2hiwaxmiSkN+tMWe0zGoYdKAJta1SeXivY97oH340t6dE4/jXAAA
 GrgPlKVbn9nviUAT1nCH9ypoUPdLQT5HkMncFGX8/Sb5etB3VrZndKd8dMhZikh8tfrba3Hrg+v
 sBiYDUQOv3iZPsv5l5svk2NhP8v6w5JoG6cnb74IwNStL0zfzkaPZkhD10ggvFWJrSSNQ6dypx0
 ytewf8785+RD7JJ6ehg+FE6FpsJCVIo/oz+SH2ZJ+vf60nkgya1Tr8ueOHD0KUESzGrI2YUcRRo
 io80PpBu/4kAYivgE
X-Received: by 2002:a05:6e02:3787:b0:430:bf84:e941 with SMTP id
 e9e14a558f8ab-4320f7a65efmr64449145ab.3.1761667728236; 
 Tue, 28 Oct 2025 09:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfVf0HP0lBpu3U2jHxAiKGG/O4sGy1fzq7FbGEnw6RDfhWxGSEb9Indfvmb09HkW6YXeiC7g==
X-Received: by 2002:a05:6e02:3787:b0:430:bf84:e941 with SMTP id
 e9e14a558f8ab-4320f7a65efmr64448595ab.3.1761667727686; 
 Tue, 28 Oct 2025 09:08:47 -0700 (PDT)
Received: from resolute.lxd ([147.219.77.79]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5aea9e35c4asm4558721173.56.2025.10.28.09.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:08:47 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Subject: [PATCH 0/2] block: Keep filter children attached during drop
Date: Tue, 28 Oct 2025 11:08:20 -0500
Message-Id: <20251028-third-fix-3149-v1-0-bf3c712d2439@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHTqAGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3ZKMzKIU3bTMCl1jQxNLXVMLo7QUc2MgmWSpBNRUUJQKlAMbGB1
 bWwsA8I1ONGAAAAA=
X-Change-ID: 20251027-third-fix-3149-582fd7382fb9
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-block@nongnu.org, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=rXQAKGIbdbWAso8+EnVZQpl/vh8xDb3Z3IQesInn2jc=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBpAOqNUIsbjUmp65IAbtVbJzRIRm0yIgKc6i1Cs
 eypp+jpEFWJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCaQDqjQAKCRD5KICs4jod
 ud0KDADRQG0CgHalTKvP/w9tFeiko1/xAo8iwzV2mY1HjJDC2a3CjX6KO5rKkEV5b3VvsMv75e7
 FURA8r3pMuqf9NtrOXTnXikXToiuBiniD0i77a9RyRDmKje1ZGgZR8v42da4hnQSp2FFkiXdA/Y
 I0CH9raWP0VSQg2qdp53CmhJ+nFU8pO3MkkgFGE1xZ6XqC0WJYVHLpk6UXzTLwgsYcKJS/e4Y2G
 dCMNbn2DHvd7szFOuZMSteYsSlVHlB2+7CV19FTF+N6cXiav9OcQsDvrx70NlKN2e3Pox8dyT7+
 3jbcfExPszz/u1xeQQYqiAtfgfxLHpaTyZLpDbxDUm/sfDnSYiJAuiPrKywCO1gmpXSwfeSAJna
 lJVmhzQyFeG0CPXMe10hmS9CpDjKQEJMcXknCEm7gQQsQ+GydrSihURru11fhPQPy62bVAHRNmr
 JHJoNUOU6grsPrb8Bf3uIhNeX9ok/waj2Rov0I7S3Ys18/RAUFXXUUjydq6bvVE+dPLzc=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thank you all for the discussion in the previous thread:
20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com

I have verified that this patch resolves the issue from #3149 and passes
the iotests for qcow2/raw/nbd that don't fail on master (for me). Thanks
for the pointers on testing.

I'm committed to finding a solution to this that is adequately
understood and tested; I'm happy to continue to make
adjustments/submissions as needed until we have a solution that is
satisfying.

Please let me know if any adjustments are needed; thanks for your
patience and continued involvement.

Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
Wesley Hershberger (2):
      iotests/257: Insert missing flush during blockdev-backup
      block: Drop detach_subchain for bdrv_replace_node

 block.c                    | 38 ++++----------------------------------
 tests/qemu-iotests/257     |  8 ++++++--
 tests/qemu-iotests/257.out | 14 +++++++-------
 3 files changed, 17 insertions(+), 43 deletions(-)
---
base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
change-id: 20251027-third-fix-3149-582fd7382fb9

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


