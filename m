Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AB8C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGS9-0007a1-28; Mon, 17 Mar 2025 15:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDYv-0003TW-9g
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:43:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDYp-0001BI-TG
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:43:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-226185948ffso22898015ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229804; x=1742834604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKWGb0xW/VNXy4e+PoryomDkITqKcXXBo5BJIUKrMV8=;
 b=OouVvBVaAQfYFpJ/1dv+sGz4H1bcOjZuLE6P+RElp9a7zFhdLLmiJaGdNco9xL4RRa
 qGttgfy6tb6EGs2zwpanRcdnVEHkA63BUKc+4i5UnRNt4++QRUN+1rW6T5+S2Lg75sr/
 /ad7UREL00zQidKDgX1i5L15uB5y6QZgMv5DRUkMMlHrsINPLmuuBaSV4FV4Tdvtd6pR
 mkQPMu59Kji9zRGrrKOk2lQ+H3kghi6t7UKlqE0z9DpbGKlojpNOqcandqotw6Yv6fi4
 DuD8wSdAq0bqzIfzazMfLdfpA4/8Om9kK2s6yAF33MdgKPNkhQ8CDbJVO88GPscGKAzg
 bO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229804; x=1742834604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKWGb0xW/VNXy4e+PoryomDkITqKcXXBo5BJIUKrMV8=;
 b=vPxRIrQMJzJkQUXSfWI/2taqDVcA3kzoyYll4tY8wepVS5sKzBnCXEI2FO8Y8B3F65
 oI/GVlJXExLwpTOVR0Dx/0Rufg/HIH1UM0N6uN1GmjhB3KTEksGR0OcSLanrVtosBdx2
 iTSe05lwvpNl+S2Px6uWOplclldAhJQNEd7BuRiwEY+2nIf6lhzGZHkQ7AMeH5tS0Xlp
 DwoA7trgaAcNGcSCczlp6E7HDWrPUsVQyRQCbN7ocDVZDKmEdby+ieJstZN3tUqkgYu1
 RPTTc7ezVpU6NYCVbAKfXwxdeVRNMSWqPamJ8LzkLMwEw6Vq6FXL5NZdH95mqBpVAf79
 4XBA==
X-Gm-Message-State: AOJu0Ywr88K/XzrKCiQdoXRFzZM6Y9d90STVzig9VdxU+O4KPRXZX46P
 KHJ4aP4Pcye6Qi75L3jZhmPiHO/aZTPGOnys/If4J5w4L7+MU2n3w3RnEw==
X-Gm-Gg: ASbGncvZrskwp3CHdndoW+G2nbIg3urJYCpkw+ucX/GfNI0ilionZCwr7+Tj4rDAjpk
 aQvBIRBrZuxA43FiFAXjeAdXDYH8tduMCMIcWhd8AlN+tEMX8Om3sjYlh5hVx8FHAYk293T9gAd
 3LcBv6oIkVel3UuXEpLhBEjsZj2xBf1Ps1ce4+U7dAG95zCWMgpWybaiXKuGhjbsIcjYRk0afXz
 hmpjpUufryUxbtXcaeL9R2Ds4xF1fKHSxhAb6JH9HIo6pFMHQfyX6lwd738pI7ygT6cqiu4Btuj
 uDJrTgbJJW5leu5TaIpVwdC85Sj7HoeZyDLGTpqmB3Eh67oH9rLEm0caABulTTjRJGzarHm/Mn6
 5
X-Google-Smtp-Source: AGHT+IH9p6E0f1a89GLwu2C7cg2ESZb+bq8ju/C/Z66+M78p2Lkv4/2MGDvYhXh2yH5uQ4mdRDnvlQ==
X-Received: by 2002:a17:902:da8a:b0:223:62f5:fd44 with SMTP id
 d9443c01a7336-2262c5f0c94mr2111025ad.40.1742229804444; 
 Mon, 17 Mar 2025 09:43:24 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:43:24 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 0/9] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Date: Mon, 17 Mar 2025 16:31:27 +0000
Message-ID: <20250317164204.2299371-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:47:55 -0400
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

From: Anisa Su <anisa.su@samsung.com>

This patchset adds support for 6 FM API DCD Management commands (0x5600-0x5605)
according to the CXL r3.2 Spec. It is based on the following branch:
https://gitlab.com/jic23/qemu/-/tree/cxl-2025-02-20.

The code was tested with libcxlmi, which runs in the QEMU VM and sends 56xxh
commands to the device (QEMU emulated) through MCTP messages over I2C
bus. To perform end-to-end tests, both MCTP and DCD support are needed
for the kernel, so the needed MCTP patches are applied on top of Ira's DCD
branch https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.

For the tests of commands 0x5600 (Get DCD Info), 0x5601 (Get Host DC Region
Config), and 0x5603 (Get DC Region Extent Lists), DCD kernel code is not involved.
The libcxlmi test program is used to send the command to the device and results
are collected and verified.

For command 0x5602 (Set DC Region Config): device creates an event record with type
DC_EVENT_REGION_CONFIG_UPDATED and triggers an interrupt to the host
if the configuration changes as a result of the command. Currently, the kernel
version used to test this only supports Add/Release type events. Thus, this
request essentially gets ignored but did not cause problems besides the host
not knowing about the configuration change when tested.

For the command 0x5604 (Initiate DC Add) and 0x5605 (Initiate DC Release), the
tests involve libcxlmi test program (acting as the FM), kernel DCD
code (host) and QEMU device. The test workflow follows that in cxl r3.2 section
7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
steps,
1. Start a VM with CXL topology: https://github.com/moking/cxl-test-tool/blob/main/utils/cxl.py#L54.
2. Load the CXL related drivers in the VM;
3. Create a DC region for the DCD device attached.
4. add/release DC extents by sending 0x5604 and 0x5605 respectively through
the out-of-tree libcxlmi test program
(https://github.com/anisa-su993/libcxlmi/blob/dcd_management_cmds/tests/test-fmapi.c).
5. Check and verify the extents by retrieving the extents list through
command 0x5603 in the test program.

The remaining 3 commands in this series (0x5606-0x5608) are related to tags
and sharing, thus have not been implemented.

Anisa Su (9):
  cxl/type3: Add supported block sizes bitmask to CXLDCRegion struct
  cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
  cxl/type3: Add dsmas_flags to CXLDCRegion struct
  cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
  cxl_events.h: move definition for dynamic_capacity_uuid and enum for
    DC event types
  cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
  cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
  cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
  cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release

 hw/cxl/cxl-mailbox-utils.c   | 615 +++++++++++++++++++++++++++++++++++
 hw/cxl/i2c_mctp_cxl.c        |   6 +-
 hw/mem/cxl_type3.c           |  30 +-
 include/hw/cxl/cxl_device.h  |   9 +
 include/hw/cxl/cxl_events.h  |  15 +
 include/hw/cxl/cxl_mailbox.h |   6 +
 6 files changed, 660 insertions(+), 21 deletions(-)

-- 
2.47.2


