Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD2FCA179
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfnp-0003lM-55; Mon, 09 Mar 2026 14:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnn-0003l6-I8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnk-0007mB-RV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wxPpL/2OvWS2kdiXl3YJ7yUrERPcOkYkS5msBXAXGwk=;
 b=BUJuQGNEFwlMZxUgodfVMrrFZw95wKb4T/LbabBUuO+2xOCwX4GNfWDU1V4c5vHJreFz/F
 +rmC4PbG3FzorrGCW0SWnDaaadJQy6B7KJ1SquJRM4UVsfn29L8bQQS30seS5kfQ393iGv
 2tt5TTchRsCuR3dnusK3Kgs5mgY7qZg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-0GphmaM7O6uBZbPiIWjbAw-1; Mon, 09 Mar 2026 14:57:56 -0400
X-MC-Unique: 0GphmaM7O6uBZbPiIWjbAw-1
X-Mimecast-MFC-AGG-ID: 0GphmaM7O6uBZbPiIWjbAw_1773082675
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853b00f9f5so9553735e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082674; x=1773687474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wxPpL/2OvWS2kdiXl3YJ7yUrERPcOkYkS5msBXAXGwk=;
 b=WPTUjBi2ea1wY5b0pZGXMDfLPVYXZzal4yzFhiHpK5my513ZgCmX+j5FEo44p+/RWU
 iM3Sf6J0wqpH0AxxRZ9rjz8AVv8tHv+WhVwVdv0Opz/qsz42WAvHTFHmgkt6Yf5dBmsH
 2uOkqBI0T0YWRBTFtElwt0vrOqgWneEFUdhAnLX2TU1FhDmCD+bwZ5ocm74gMnin6KJM
 mn8Vr5eR9ihVIfM7yrcuuZBzZjGloHZrVlzj+hKF2jwFbCn1lK9QkF4uwy/DODTFIimb
 +mZmkcfWWYggsacsiWwML+VcnPnd5BT63XdglIdW1rbuYNyw+ZdHVFoLSggWMG6LXT57
 4LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082674; x=1773687474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wxPpL/2OvWS2kdiXl3YJ7yUrERPcOkYkS5msBXAXGwk=;
 b=Vw3GRtW9HjwDJ44+Ip7ic+7W0Z7U0Q3vc4EWcbIKobCbnicXhqF1HK//GHuzMgaS/h
 2TOM15y+BpYzmoF8KoRXvXXWok4UloMMGfS94VHspUyfn9CBFnlt5MhbOioGgnetmtDc
 /FqNGpa5XE7UM+fjdVwxM7wEj1WJ8V/j0KjeRviky1KE9YPA8PAU4PZEUb6j/Z7IuZyd
 cRZ2jC6qg8jyvmuYfVvZ3jKoPZj+nK0+bx4uSbFGffPWgEn1tYeGnqxRT2X+wUMcpcAF
 4SU0hAAxoG9tIMsTPAPDQokTXw44Vt0nra/dVMLac+oIejOw7W8JiJaIp3KpoHgrJW0I
 Qxng==
X-Gm-Message-State: AOJu0Yytzbs6dlIWC6a3FIbu5uJZA49Ah3kAr/Djvsvre8PVm9YhJYhq
 LWufR+CIfPpywIxet3oE7GUkwMPsisaooBwKavvPxc7RpWHw0MN8TGkx2evwBG7HQcmGtcll+8B
 KZ4orrVdjzsGDSdviC78Jz1YrDzaU/ZwDFfut6kgEVz10ylO7a756ZzutKdyLtlkCXsw+aQ8H4g
 qCo6g3eFtgTeKUbFijLhymbJWAm0oQCXvoQd7L/Ths
X-Gm-Gg: ATEYQzw8aRPpW4UcQ6TxEkscmSksPjQMx00NNh+ihF7qflBPXZBusykKIgQH60SYUUf
 9zJjV7BkQh4Wg+UJh/dupxngnDHrSvNsW36OXA9VDMo+57gC165R80MhC0IXJRnuFnlCTTBS8Q9
 vSyhflHfM+WIOGo5huyQionZGgimZFZPmRFtolRgrY4QeKR/TMoPV8p73hHj4mGCSZtbYs6uKhH
 KY9xQb2NW0jTJs4EHFSCTVOpm65FA8EwCwAWkpEdG272W3wPn3AvFYBDZRGeUl2tA44G2CfLxKu
 IEuRgEIA0VX08RofDZlcBDunFpsd+bRNFNClDqmWb97p3UMOCq3o7HkAn9vPHHwGSrAp/j+Zsjf
 JC2Nl3lGIGmkvnaL2ImxUidCI2sJcBYs/1wa3+GSxEXtT5MEd5lkC93kSyyyJ+UdC4TtdecbiJu
 UPRWhKXbIAV+nSWVaifZAR6a9Cye8=
X-Received: by 2002:a05:600c:4505:b0:485:40c6:f527 with SMTP id
 5b1f17b1804b1-48540c6f6d6mr31152725e9.32.1773082674230; 
 Mon, 09 Mar 2026 11:57:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4505:b0:485:40c6:f527 with SMTP id
 5b1f17b1804b1-48540c6f6d6mr31152315e9.32.1773082673608; 
 Mon, 09 Mar 2026 11:57:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a7f20csm11491495e9.6.2026.03.09.11.57.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:57:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] i386 and NULL pointer dereference fixes for QEMU 11.0
 soft freeze
Date: Mon,  9 Mar 2026 19:57:42 +0100
Message-ID: <20260309185752.76865-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215e1:

  Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6ef6a0f04e5ea10e5c9aa31de939e5dcdfe4a58f:

  whpx: i386: remove SIPI trapping (2026-03-09 09:11:38 +0100)

----------------------------------------------------------------
* hvf/x86: compilation fixes
* whpx: fixes
* xen-block: fix possible NULL pointer dereference
* coroutine-lock: fix thinko

----------------------------------------------------------------
Mohamed Mediouni (7):
      hvf: arm: unbreak the x86 build
      whpx: i386: do not enable nested virt when kernel-irqchip=off
      target/i386: emulate: LA57 fix
      whpx: i386: enable some more enlightenments
      whpx: make Hyper-V enlightenments configurable
      whpx: arm64: enable enlightenments if asked for
      whpx: i386: remove SIPI trapping

Paolo Bonzini (2):
      xen-block: remove NULL pointer dereference
      qemu-coroutine-lock: fix has_waiters()

Pierrick Bouvier (1):
      target/i386/hvf/hvf.c: fix compilation

 include/system/whpx-internal.h |   4 ++
 target/arm/hvf_arm.h           |   2 +-
 accel/whpx/whpx-common.c       |  43 +++++++++++++++
 hw/block/xen-block.c           |  41 +++++++-------
 target/arm/whpx/whpx-all.c     |  37 +++++++++++++
 target/i386/emulate/x86_mmu.c  |   2 +-
 target/i386/hvf/hvf.c          |  14 ++---
 target/i386/whpx/whpx-all.c    | 122 +++++------------------------------------
 util/qemu-coroutine-lock.c     |   2 +-
 9 files changed, 128 insertions(+), 139 deletions(-)
-- 
2.53.0


