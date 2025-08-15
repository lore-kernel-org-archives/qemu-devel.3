Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8D5CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 03:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umlPY-0004ZX-Or; Thu, 14 Aug 2025 23:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1umlPW-0004Yp-6I; Thu, 14 Aug 2025 23:47:23 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1umlPU-0002n1-Fj; Thu, 14 Aug 2025 23:47:21 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4b0fa7ed37dso21677991cf.0; 
 Thu, 14 Aug 2025 20:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755229638; x=1755834438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I5iz31bFKnGcz1Q+S4hDkiJd2OtWqKI+5oGz3Fv5A44=;
 b=J5ErGvs19iIEO5D+bxLkicbBrGXCu3qdNCxa647170x0cMiqIiqlhVUQpEssCqKyID
 75v+LPPb7vTK0IGQaH4u3Qq6kR2uHRbLm+7pPG3sLr/J3zfp3/tcSJDdjU/0FOHuSyCO
 3zV+u6Am4//66T2MwMqd2uoutl8/JxYTSneOn8V6faI8aFy2uYWgtwjYlwNo4NCV1ETA
 POHG67QeJnLbAFAcHhbTKqXieSBrbupmQRa8uUZ9Buc6aRHy+AeaP6jmyayU+ANfvWjq
 bpg95B96PYRf8UD14Vnes/39OS0tTOKyZOmnLsZp/qV0pEeEnYhoGNWYA88d/tv1eGee
 m2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755229638; x=1755834438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5iz31bFKnGcz1Q+S4hDkiJd2OtWqKI+5oGz3Fv5A44=;
 b=OPGVMILglIHWQsMTEmc5TEPOMhxqgO2KTzwD3qOxBvNSxuXiGZCFr9TS4whYfPMi2K
 NTmNtLqoePQOc84qSQ2txvibm6Jq7gDn/E9m7FtAS+N3RF5Ds5apAMUKv90b5jcxHjuT
 xAzOPkB8P6H9NitLK9TGTJFZpme/l/oZWVYgFU60aQknqLQnQIyfcp3xA098GmIKa5s1
 Oqy4//ihPnrg1V/TPB6mD6oTVc+0/Po1t66NE1hBV5gNtYb0SMceH0+pvTPeFLBIAAmE
 Sdm9ovQ34VlKbxGKxXfp6kxHc/a5guOKXolpLkXZzgROq87IpXxA4aayshf9FLn3i+vh
 NDJQ==
X-Gm-Message-State: AOJu0YzXtzIVbKzSml4yLMQOBMua6Jz7XLf2ofLEL1zJiI4k27jdcRh/
 UUwdYoZdpMrPgN5UqJ2qqpCQMu2qlnYWOu8xaOx72BmvsdJkZJizRhvjtnP7Fw==
X-Gm-Gg: ASbGncuVWFUAEsb1WRBtZZjfvs3oEbU5VYNVrqpDj4MquN5YRt7YD4s+281Ev+6Fp5v
 DpbZLiJidwX19A3cXO5VzKs7tS2AuZaKsRg2v+hpHhx2VoAel3rg4lEY+SjizyZImrjzT8vKcRp
 ZBt0P3bvIDRSjMDIv4gM4BQEECM2Zm0EVgf8TLAQ9xy/j66lUKdHiP+/y/gWAf5JxM14Jl2G9GT
 wMsKAbrPt7BEanWdGzVpoDxcpAe5l0pTrnxWrUguFEzeJMLKRF5cSZl4FP9oqQmEjRd3iBIojVs
 X/Ofjd0HL57yuGa0CkBuHlTaazwLoUYKUoPgDXA6raYYQC0j2S5EC4K7DDWoibj3F4j40oOmqvt
 bzrsPis5M/m7D0PLknTclUiuCy3DlgBedLIvL546oNn4OBBsWOIvEL5rb46tnaaGYumkT5Nhp6x
 bKy5TfyjncLN+f
X-Google-Smtp-Source: AGHT+IFO38XUN7KKt8JpwvGnpSWgRmc+l6fVqUSp2jFzpUaR8W8PwRXZceu4KpdOLd/1rUbJWnmDZQ==
X-Received: by 2002:a05:620a:471e:b0:7e0:e2d7:e03 with SMTP id
 af79cd13be357-7e87db77a36mr92450985a.7.1755229638249; 
 Thu, 14 Aug 2025 20:47:18 -0700 (PDT)
Received: from zzzhi.uwaterloo.ca
 (wn-campus-nat-129-97-124-101.dynamic.uwaterloo.ca. [129.97.124.101])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba906706esm1402346d6.17.2025.08.14.20.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 20:47:17 -0700 (PDT)
From: Zhi Song <hibriansong@gmail.com>
X-Google-Original-From: Zhi Song <hizhisong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [RFC PATCH 0/3] block/export: Add FUSE-over-io_uring for Storage
 Exports
Date: Thu, 14 Aug 2025 23:46:16 -0400
Message-ID: <20250815034619.51980-1-hizhisong@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=hibriansong@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Brian Song <hibriansong@gmail.com>

Hello,

This is a GSoC project. You could check out more here:
https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_exports

This series:
- Merges the request processing functions for both traditional FUSE
  and FUSE-over-io_uring modes
- Implements multi-threading (Multi-IOThread)
- Improves FUSE-over-io_uring termination handling

Due to kernel limitations, when the FUSE-over-io_uring option is
enabled,
you must create and assign nr_cpu IOThreads. For example:

qemu-storage-daemon \
  --object iothread,id=iothread1 \
  --object iothread,id=iothread2 \
  --blockdev node-name=prot-node,driver=file,filename=img.qcow2 \
  --blockdev node-name=fmt-node,driver=qcow2,file=prot-node \
  --export type=fuse,id=exp0,node-name=fmt-node,mountpoint=mount-point, \
  writable=on,iothread.0=iothread1,iothread.1=iothread2


More detail on the v1 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00280.html

Brian Song (3):
  fuse: add FUSE-over-io_uring enable opt and init
  fuse: Handle FUSE-uring requests
  fuse: Safe termination for FUSE-uring

 block/export/fuse.c                  | 632 ++++++++++++++++++++-------
 docs/tools/qemu-storage-daemon.rst   |  11 +-
 qapi/block-export.json               |   5 +-
 storage-daemon/qemu-storage-daemon.c |   1 +
 util/fdmon-io_uring.c                |   5 +-
 5 files changed, 486 insertions(+), 168 deletions(-)

--
2.45.2


