Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A41ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfme-0005Qb-3x; Mon, 09 Sep 2024 10:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfmY-0005PI-81
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfmW-00071d-9c
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725893658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2LJHrkMFkVqUqwCRKMfyXGti6QS9Ge6bXTyXZ1MCtBw=;
 b=aMiYzUPhZIFOC+1xzsSo9K61/NS94J6/8FrwdV0k/E6sTgv0a72fV7/Hf5/SJCMyuttRPQ
 EV/oWhT+O39GJ6Fn2bwYfUY9PWvNtjAIF2QlmqHiC5Rrfiu0mPNg/d2DxYdDC7udIOHI51
 kkIaqenfFM10GYvOxjyrI0FZVL6ISaU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-0E6gpztZPIS5EpGWssTpOA-1; Mon, 09 Sep 2024 10:54:17 -0400
X-MC-Unique: 0E6gpztZPIS5EpGWssTpOA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a9a74d39b5so547373985a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725893656; x=1726498456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2LJHrkMFkVqUqwCRKMfyXGti6QS9Ge6bXTyXZ1MCtBw=;
 b=TSF12rQF+VFkbi3g0KF23y+8Y/d/SmpxamsmjteT4fy7KpEaoDL9xR7sjI5NP8BrF2
 eo9csNvEAiJE93nGeoRXxZdc+N00IabdnJsPV7SzsmoeUBH2nI2yCdxJadwfQYVm/FKK
 EFkcN692UFF9jIOQ3tZW8yHypRnw5GWOfKKcU8Yy6duBWUkX7G5wduFMCc7gLCVWjf2b
 BHpWlPCFjj+mCeKx6yEhMDT/+t9SWjvWjtc4GRQZRsH94eYN9UC/ZpJHdDf5GA6XaOll
 2cBwctn6Jwl2CDDYxVKfc0CsS26toiWD0Amram07vwnc/17KR543I4zBCiUNPodWUaNO
 L9Fg==
X-Gm-Message-State: AOJu0Yys8scxurZITI+PHdKxR2Zm7IcrKEX6WOFA3cTHh0R9T20Cn1VM
 l/FfGJ6mp8nrUiIew2xL+CeQ3nfw4OmnlWZlb97IlgBHZ4njrvMb1Fn4o+rztb8c0d9I3u1zysL
 EGDQ2hB81tivtyT0DQNDi0dKmrHhu/DbHpxjCA9BYL5AbU9i1h+TQRQzyQ77QZSNb1pqhKRGIbF
 iKeIWfqzPnfC2HPPTui25VA/4sycTLHRx/rdyc
X-Received: by 2002:a05:620a:24c3:b0:7a2:bb:31d3 with SMTP id
 af79cd13be357-7a9a38847d6mr1371758685a.22.1725893656548; 
 Mon, 09 Sep 2024 07:54:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0lo25OCxjsA4r3ErLnp6Liwr/CRHB3B/i1Ho/SH4Nbo+c1TozjtAsvbHtVpFF4YggOtncQA==
X-Received: by 2002:a05:620a:24c3:b0:7a2:bb:31d3 with SMTP id
 af79cd13be357-7a9a38847d6mr1371755085a.22.1725893656159; 
 Mon, 09 Sep 2024 07:54:16 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a79455b1sm225387585a.19.2024.09.09.07.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:54:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 0/4] KVM: Dynamic sized memslots array
Date: Mon,  9 Sep 2024 10:54:09 -0400
Message-ID: <20240909145413.3748429-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v3:
- In kvm_get_free_slot(), avoid re-search when slots array grows [Juraj]

v1: https://lore.kernel.org/r/20240904191635.3045606-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20240904223510.3519358-1-peterx@redhat.com

This series make KVM memslots to be allocated dynamically in QEMU.  It
fixes a migration performance regression that I observed, reducing precopy
dirty sync process from ~86ms to ~3ms each time.

Patch 1 is the fix to the problem, while the rest three patches are
cleanups.

Thanks,

Peter Xu (4):
  KVM: Dynamic sized kvm memslots array
  KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
  KVM: Rename KVMMemoryListener.nr_used_slots to nr_slots_used
  KVM: Rename KVMState->nr_slots to nr_slots_max

 include/sysemu/kvm_int.h |   7 ++-
 accel/kvm/kvm-all.c      | 117 +++++++++++++++++++++++++++++++--------
 accel/kvm/trace-events   |   1 +
 3 files changed, 99 insertions(+), 26 deletions(-)

-- 
2.45.0


