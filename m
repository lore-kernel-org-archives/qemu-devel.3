Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EF9C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 18:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKBg-0002Iz-W2; Mon, 31 Mar 2025 14:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzKBf-0002In-Nl
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:48:43 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzKBc-0001ky-TR
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:48:43 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301493f461eso6007809a91.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743446917; x=1744051717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9eDlJugjsdYqWgJ8IRaK2UWmwZOb0KFgmgaVvTFAiEA=;
 b=FoUv8ef64huWsqyjAfXKPNZi19sqwoCik8UHN3UBKx8L0OHdsp9Aq41s4GBIx2Kc++
 f3IK4hRkQUM2nJOfUq+GxSCCd5daWLrMG4UAoiCE+ZtxyFXCasUJARfo+s6NtF/RDEQZ
 3Gph8/rYPSRBvXIR24v9iZeQXewaniI99kvGFjjBx8UCQUB28pgGEuRk3PEII04xZ4MP
 PdVUfMTweIAV8fuZWCJv074fIVnqStdXYR/i+CmgUWaCgFMDaReN22QWnnxR3SNT6ziH
 HfzRCogdc2Cd2esZjZTY3q1FgtPoEhwRaNMH6/g9udrrVcLZI8dDcV0I29I8eZzdqF0v
 8OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743446917; x=1744051717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9eDlJugjsdYqWgJ8IRaK2UWmwZOb0KFgmgaVvTFAiEA=;
 b=VLkfmVMmCPjNHgSLEMuzmtAUS9mdEJ4P1qZGZpqhVpYdSqZHSnHDqA2rGMrE7UfXz8
 aqTXMLi+OKnDSPmOkxrfG6oZ4AkBlZqhN8+yuMieV5Ojh04AqlGuqy/bw5BGKtCiopZs
 0LSHOPxRi0zGdcDIu+sljZhrDofP5A0ngToEGhmCloveCnAPU1MLKdvR7kqmQWzylkno
 WHAoN7cdxGqYanvHdmU1SR6HSzHZvYeCNUltMTbvo3HviksegT4fuvezyqHuBxPU2d7M
 mZxm/gtQlofZ1O6jpCHQvxouvEE5RreYRvw9AspsigApWSl5I2Jr4f7z5LR9LHJ7sfqC
 rVLQ==
X-Gm-Message-State: AOJu0YyiHiEzMZY96b13bnsCPaG6VMwjc3jw2O6TtCsmPVuucjbQh5RS
 V/eoFhY1BevRpYK6Mgdn/wjLGrobG4Khu6CNzhDPc4rpk/cjHOKl7lw2UmgP
X-Gm-Gg: ASbGncsVxOG9wN/KYjtKTS/flVY1b/Tvzc+gTBAeAF1SaL9omB8vxSFLiz78jj4sK9l
 8lAb5dnldlRB5vfz6jTZuDc+cU0nktNQBZ94ot2UatWHi2GK4+bZpLJb+a3JFXpQdwrniXIr331
 aADN2k/+AK38hzr4lbDnYYYc48V12cvAcwonDNz3SKXQQD2UQO9vmCWJ0KVKFytLXn+ALWefo3T
 pjjQLJP45a/8McY0M+ZIGYM4emnYx8YAZ+x5vL0dnvZJl+5Sf4kCtSCPGGxI3W2JVI5edfrtqPq
 wnKY9Oihkj4dCHUOPRPmUQET4RqCQAoBGKOWGPRsFGL4ybo3c09E
X-Google-Smtp-Source: AGHT+IHTj5D65/6Cn+cXV5uuEsqgh9EpMd07VY7sb5eGEKcUUwSikuVJsSsujh7yEPC8oPtLofO+iQ==
X-Received: by 2002:a17:90b:4ed0:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-30531fa5f57mr18697280a91.14.1743446917494; 
 Mon, 31 Mar 2025 11:48:37 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:99be:24ba:7ca2:678f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f1d4f4bsm9928476a91.33.2025.03.31.11.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 11:48:37 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, philmd@linaro.org,
 thuth@redhat.com, rakeshjb010@gmail.com, balaton@eik.bme.hu
Subject: [PATCH v4 0/2] GT64120 PCI endianness fixes and cleanup
Date: Tue,  1 Apr 2025 00:18:18 +0530
Message-ID: <20250331184820.34673-1-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

*** BLURB HERE ***

Changes since v3:
In [PATCH v3 1/2] hw/pci-host/gt64120: Fix endianness handling
1.Set .min_access_size = 4 in MemoryRegionOps
2.Remove the now-unnecessary bswap16 handling

v3: https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06942.html


Rakesh Jeyasingh (2):
  hw/pci-host/gt64120: Fix endianness handling
  hw/pci-host: Remove unused pci_host_data_be_ops

 hw/pci-host/gt64120.c      | 91 ++++++++++++++++++++++++--------------
 hw/pci/pci_host.c          |  6 ---
 include/hw/pci-host/dino.h |  4 --
 include/hw/pci/pci_host.h  |  1 -
 4 files changed, 57 insertions(+), 45 deletions(-)

-- 
2.43.0


