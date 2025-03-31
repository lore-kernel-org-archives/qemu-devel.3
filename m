Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BD3C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzF2o-0006KC-UQ; Mon, 31 Mar 2025 09:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzF2g-0006Ip-9I
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:19:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzF2e-000515-6s
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:19:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2239c066347so98029655ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743427140; x=1744031940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9e/jLSNy2MFjwGCXj7IPnLmWSQoa6LNjf0+OPMzCnx0=;
 b=KWq/rm6sqtZhb6RiCi5tfhWLFCIqEJt4aXSJ2JNjkxMMpjT7+iIq/bATYSbSQiXXjC
 vGYd4ItWb2PlDb+JDLuWDN0M442fvFUc+sAgz8LToiaNuPE3OqDwrUn2tGQgv+q9jhJd
 DNQdtxpl/RipcE58qmjQIZoUESu5kqJnT8Omoy8aFekxGGWo1rK7Sstv+9lhF7ChxbgP
 PnodjiNRuJRJ3NGksoKIc4ivmMaCVACJB+GwBafpJ+vZtKy0X/aLg5DcobZpjqtViy8e
 SkkIm2nOMCPAxIcHHCsSpBAyKqEMth75pF4PP4SLS3Wi/bUS2AelTutWphN89fu6qSLV
 cqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743427140; x=1744031940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9e/jLSNy2MFjwGCXj7IPnLmWSQoa6LNjf0+OPMzCnx0=;
 b=IOmaAgaos+wzZHMZNt/2B1hHMhGgtCA3Vxj4+gq+Wq94G9c7KFlKasz93mBkeHuaU7
 lDtpUg7w2YMqkEg7XC43ft/ZEtNhgwoCPr1qktL4euPFAs50s8gA8fLxdGKRv0aWF5Du
 1A6XHyC99gs02Wqv5yHBsvwLRiBDE0S3et/Wb32cmDtyg+X92vk0nJfB0DaTvEz9dCH1
 BT5rYkGcHCM22ldTFWtdfpzmNjOIKq2vguvjiqPb+ziTzbCSiad1scdDvspIrb8qnq7Y
 X5wHocSOnRtxJwA2eV3tjACi4TqE99OWUM9YLj6XtZms7IKKxak7lOzxospmJp+d2kQu
 vQyw==
X-Gm-Message-State: AOJu0YzFaqHBVqBsoa+qOgtqK5T4jOqdsAo1D4SHztzy7Hn3AE/iP3Kb
 lwL99KP/hAEUeBd8luF0XLH4QXk9QP7mxRk26tNQtQo8LhMXWcNhaNvcug==
X-Gm-Gg: ASbGncuoATyzpv3RNOM1bZSiB7nN2JOGuWoiT/+hpuL0ln+ITLQnUaLsQ54eBbxFr5v
 ji+a/nYNlAR8nnf77BkE3kByDS+8D9HEsMCbBIqOOIoG+IJ+/Vkb0K2A4YmPNWDc9jxRTtka+Jd
 bnDxEr/KTqvXZLJAzaAJ4DklQQTJQab4IkvwoNFcISVRI2CbX2g16PzTZy8HU/PkzosHZRoHDgO
 HA/b9cvP2mcysVmpM7S7SKIZJ+ldOKL1g0pK6k40BJzLlEibgFTSmghRepWMW2HbURH8IDq/Sq4
 uOdJvRh/sQ6h0jcmm1vjTrfOIo8AdIwnCrmmOVGLjUXSgbw7AA==
X-Google-Smtp-Source: AGHT+IGRnRzWmhiE/Gi9U2x/ztAGHpnXc6XM4+mKHRCfv1KlqHA+bHriTiwCbU9QgxLbb5W8PPW/yw==
X-Received: by 2002:a05:6a00:1784:b0:736:b402:533a with SMTP id
 d2e1a72fcca58-73980324e36mr13359405b3a.1.1743427140447; 
 Mon, 31 Mar 2025 06:19:00 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7397109c494sm7090671b3a.136.2025.03.31.06.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:19:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 0/2] gdb invalid memory access handling improvements
Date: Mon, 31 Mar 2025 23:18:49 +1000
Message-ID: <20250331131852.612406-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

This adds .debug=1 attribute for GDB's phys mem access mode, adds
memory transaction error handling for it so it reports cannot access
memory instead of silent success, and silences warning logs for
invalid memory access coming from the debugger.

Changes since v1:
- Move phys_memory_rw_debug() into gdbstub/system.c and update patch
  changelog to match.

Since v2:
- Change to use Philippe's suggestion for log condition.
- Fixed flipped test noticed by Richard (sorry, forgot to actually
  test after rebasing).

Thanks,
Nick

Nicholas Piggin (2):
  gdbstub: Improve physical memory access handling
  memory: suppress INVALID_MEM logs caused by debug access

 gdbstub/system.c | 27 +++++++++++++++++++++------
 system/memory.c  | 10 +++++++---
 2 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.47.1


