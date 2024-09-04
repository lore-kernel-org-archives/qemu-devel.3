Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B47CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 19:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slvUt-0005U7-Bp; Wed, 04 Sep 2024 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUn-0005JK-53
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUj-0006Fs-4k
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725477404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htiOERVQZSVpBgxG52L0rxJgd9c/PMsBtt67QYsVGpA=;
 b=PjFYtXJ8Y9G3CLQiAZVyfaITnCNQ/cI2mm/6JYdjLiUPJmCrPGZ+pzgp9kyCTp3HjI+cYO
 dXbVQP8unmw7nj8YiJn2iTSBWiEEiKpQ1M0/uILI1weqL3H8kJ15v0mXdWzZmRe1ngGTMg
 oN74p+Gllxc/clSssJTjk+8E6YdOfSE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-alEZp-mQNIivS8G93mIvzA-1; Wed, 04 Sep 2024 15:16:42 -0400
X-MC-Unique: alEZp-mQNIivS8G93mIvzA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a8110f90ffso945449385a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 12:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725477401; x=1726082201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htiOERVQZSVpBgxG52L0rxJgd9c/PMsBtt67QYsVGpA=;
 b=egt8mDd7iT+lLnclEhkrTQ6BzAcwuqNsXC/oMew67/WJ6wSjb356onSPfSyzBbt3Fj
 0CO8aIoujqkLMbMIO/eGht7keSZMcEwxv3UIYEy+8Jh7emvIMGW7ylMVKZLgMKJMCKrj
 OJbsD0l8XQbtHQr+HyR5RCoEG6/uCAkDk3ykK64D6FR52xj8089p7THScdO9opOtx0OB
 5k9Q+vM4Ugqupio+YPjO6a2ML/gdSZiaOjMDpIzdhj//hC3YGq+a8+2J8kTTjtJPt5y+
 Fnzz9UQtQ6Kq/0rMrc1rR58s0iQb7MKDENAfLlTHYIfKSeFM/r7kRVVR3iz6HrWEV+Jm
 lnbQ==
X-Gm-Message-State: AOJu0YyMYyAUeQwU4ljRlPND7QSZkJGzpAyAeUNgOwgqZiqP2YbhayzH
 3g2yTbyaqh59I/3LR3R+Z/JKGDUQGhB5hOJkV7bTHtAC4KSO4BPjK5mcOoEL2EZ8rhX7mcGZDh4
 jGnCPn63859BkX1Eo8dg8FHcsNJG8Z8v+B/tiUDAty/e1Yeg0xhuW9vOx9WFjeH8uJpn1ZU7mvg
 XX0rSUO2Y5VE0WPvhE9+i7MAku+z9KKWjL+I0x
X-Received: by 2002:a05:620a:29c5:b0:7a6:5c8e:10fe with SMTP id
 af79cd13be357-7a9788c4dfdmr836307385a.53.1725477401508; 
 Wed, 04 Sep 2024 12:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ6ijjOg4HjKTFMjLjNRtUFwAoyuxzBPS94V2EU2+Db9ouTeytbQ16shUwbVc3oYYtJy0WGg==
X-Received: by 2002:a05:620a:29c5:b0:7a6:5c8e:10fe with SMTP id
 af79cd13be357-7a9788c4dfdmr836304185a.53.1725477401068; 
 Wed, 04 Sep 2024 12:16:41 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef250d2sm10260285a.15.2024.09.04.12.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 12:16:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 2/4] KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
Date: Wed,  4 Sep 2024 15:16:33 -0400
Message-ID: <20240904191635.3045606-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240904191635.3045606-1-peterx@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Make the default max nr_slots a macro, it's only used when KVM reports
nothing.  Then we put all the rest macros together later soon.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 991c389adc..e408dbb753 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -69,6 +69,9 @@
 #define KVM_GUESTDBG_BLOCKIRQ 0
 #endif
 
+/* Default max allowed memslots if kernel reported nothing */
+#define  KVM_MEMSLOTS_NUM_MAX_DEFAULT                       32
+
 struct KVMParkedVcpu {
     unsigned long vcpu_id;
     int kvm_fd;
@@ -2458,7 +2461,7 @@ static int kvm_init(MachineState *ms)
 
     /* If unspecified, use the default value */
     if (!s->nr_slots_max) {
-        s->nr_slots_max = 32;
+        s->nr_slots_max = KVM_MEMSLOTS_NUM_MAX_DEFAULT;
     }
 
     s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
-- 
2.45.0


