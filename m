Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE94FCD4F24
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 19:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slvUr-0005KA-GM; Wed, 04 Sep 2024 15:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUj-0005IO-Bl
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUf-0006FZ-Ml
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725477399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yIXGtjdt4apTvp7aqAQqeAeWTl/zN/iK/1yfxmW2xQM=;
 b=PSu3wCiTGEybQbSzitJ2jhPv4ZKfv9P+EMOh7B+0wAMyLSH/ym5UzDlCLmf8Wtao/b4xvn
 9IqOV/qMPbcu54cl211MP7wyKchMuON4D+9K0yWMn4nRmrurZ/taDxoN5g910ap/Xw7dh2
 mA9/K2MMzMdB2s6pzOlSRV+VSlllAaw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-nrWiAO-iMOKXJo1l6MUFtA-1; Wed, 04 Sep 2024 15:16:38 -0400
X-MC-Unique: nrWiAO-iMOKXJo1l6MUFtA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a7fa083271so637008585a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 12:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725477398; x=1726082198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yIXGtjdt4apTvp7aqAQqeAeWTl/zN/iK/1yfxmW2xQM=;
 b=CIjvEfFxnp7GXNEdGRHm5m5AyD+df/Qaaj9dWqbRNqcFc/QRO0DH6jkewKwTXiYxY8
 LNOr1R8FiI/VPYt+yIllfV/hfB6HIR1vhW6JSyT6lmd1e8X1NV8T67oDlgt50l4b3S8E
 GVGHvMbvbr8Z2KMpjZDJhQ4JSD64x6ZPW38PLS20950PE1D0TmBxcl0W+SCOkrWYPvec
 MrCpHo1Kb+JerPs7+z7DXwPwP8MOqucOhyXlwloOHKXy3e0yUoWJ+WwKDmP5XP+Ve1ND
 QxUQVbO0Myt8nZIQPhIXsmClx5jxYrXrSH1qfs5AkJkNsOhQmm33XN6IjJRrF6JvsmbZ
 v7Vg==
X-Gm-Message-State: AOJu0YzBw4QVmHKA8p4gfdmBEFtY4siWRGHrpqPAy5H04TpkpJyrvR7p
 wbeP4M4va2zXZr0RmMS4epAaB2ffA7VqL1RShnlCY1NfP0KuIBL6XeCU/Ow3XWv1pAxGqiZ+zpt
 z7RtomGkkrtaV8UiIRsBbCF5gP9cQ/QUtE1Om3wKHf8UFZjlVnmarhXNSJa+oTdggv/wEbX4d8C
 +fPVdnMsh4SVF+NQUm9povORwpo1aCjgbRC6b8
X-Received: by 2002:a05:620a:271d:b0:7a9:797a:89bc with SMTP id
 af79cd13be357-7a9797a931cmr804608485a.65.1725477397933; 
 Wed, 04 Sep 2024 12:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJYDZjbCtpIu9T4frG86zDBBcTFjCxIN+aLwKkiByCthh8OPGyRe/iHm+vXjPP2axsk9asag==
X-Received: by 2002:a05:620a:271d:b0:7a9:797a:89bc with SMTP id
 af79cd13be357-7a9797a931cmr804604485a.65.1725477397366; 
 Wed, 04 Sep 2024 12:16:37 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef250d2sm10260285a.15.2024.09.04.12.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 12:16:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 0/4] KVM: Dynamic sized memslots array
Date: Wed,  4 Sep 2024 15:16:31 -0400
Message-ID: <20240904191635.3045606-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series make KVM memslots to be allocated dynamically in QEMU.  It
fixes a migration performance regression that I observed, reducing precopy
dirty sync process from ~86ms to ~3ms each time.

Patch 1,2,4 are mostly small cleanups, the major fix is in patch 3.

Thanks,

Peter Xu (4):
  KVM: Rename KVMState->nr_slots to nr_slots_max
  KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
  KVM: Dynamic sized kvm memslots array
  KVM: Rename KVMMemoryListener.nr_used_slots to nr_slots_used

 include/sysemu/kvm_int.h |   7 +--
 accel/kvm/kvm-all.c      | 106 ++++++++++++++++++++++++++++++---------
 accel/kvm/trace-events   |   1 +
 3 files changed, 88 insertions(+), 26 deletions(-)

-- 
2.45.0


