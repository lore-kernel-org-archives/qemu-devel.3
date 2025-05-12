Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A136AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETe1-0000aQ-JU; Mon, 12 May 2025 09:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uETe0-0000a8-GK
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uETdy-0003S2-GJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747058193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2S8qbU+2NGgmIfRGiXccyMZ/bzzJTT6VcJFwaAJMvQ=;
 b=MmXEpnA+A6f7WWFqY+MReHZLJvfMrzXhe/cRadK+KZG9yGFNDdKTSY7Gc2gPY9Gupa+uP5
 lqcZL4JeTd4Ma4JFAGdVQM7iO3os9teDuCHM2EqCI9GIG3mCscjj3APk+Pg5fDG87ENX8l
 7m5W2f308RCTaqU8XqImiysSMlWHurY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-8oxFY7YYMOSZMBHHdPN8tw-1; Mon, 12 May 2025 09:56:32 -0400
X-MC-Unique: 8oxFY7YYMOSZMBHHdPN8tw-1
X-Mimecast-MFC-AGG-ID: 8oxFY7YYMOSZMBHHdPN8tw_1747058190
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b115fb801bcso4902438a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747058189; x=1747662989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2S8qbU+2NGgmIfRGiXccyMZ/bzzJTT6VcJFwaAJMvQ=;
 b=UJ88qXshg4uirSJ6ucJfADOBIgdnEgilEAwtBU/MTd1s8XWmEIOCP3nvziTVsZWst3
 pet6hCBaoLUrmYMm8nalPtMu3WwE0/FRNYjKaw5CThOHXwJUL694QOSSRJwHHQ22HKso
 //x1TZXAHZHP6tlrgRj6p2Y+OpqEF1VkljQUHgekvMCEqfKFrlT0O1/i4ZMwqW0cuFtT
 L/LFWK+IYzF0DFQpuEtqMDnFyahb64DUO+nI2OyTwh0IUugVs82EZ8k8irlOcYZ3RFrO
 IBYRL/CHymNHzJFC+vvwIExtHosVHaYJPeWR6n19FOnKX5RFmaSpT0aGQ8GMD2a6MrZd
 zmYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjI73vRbv90uIX2O1/bujaTGeBynK8dqcH+o93se2sBkKGN7p1KKymcAeRwOvjQCXyiaIN2SjoeE3J@nongnu.org
X-Gm-Message-State: AOJu0Yw9sjueuSAX24Mr02Szv6JoB4euh9y6wVlIA408GT7AWrM+N122
 dVs+Zy0JjEv9G5ZPEX/zRUrXFcH0R3bbYxQo25FwlB8QroLJyLU2ozB9f1JxGQEtASbbVwLr4K/
 TKzREfzC1PCPK03k4SnftcVsYfLhHe62+71y+SBJNbFV/MaTurSt9fk7Hm7k5
X-Gm-Gg: ASbGncuYEVxcpIzulD3mhjfewKlRIWdTYmKW8q9ycMHxS7pmBmuTBFl704jzpFE7uXM
 cmnbbdYS4uryXyGKJaTWp8MKTShq7ifZfB+jdHUI+jDAYu0ouGBYwSYgZZG5NU1GcwOKCNaoP5+
 IKV1s+n7anDpNAeOuSga8/ydiCAZftGd4lhAVLq2/CXydobW5M2+Zt3NiWmA88bBS8nFbOKdeth
 m11n8w7cE3qIenAcovQncOarwFUe7RctGGPQyfs+FMTQQtTmlDPhVX3ApnEb5IZhXZV8XalV6jl
 Dr0=
X-Received: by 2002:a17:902:f708:b0:22e:8456:b77d with SMTP id
 d9443c01a7336-22fc918c130mr220570485ad.44.1747058188616; 
 Mon, 12 May 2025 06:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjYtzTrNzE2fXXce4XzwmaQP+ZJ+CrLyEFa3djqA0JfPSXD7GNhHT9ziQGku1hwfVydeHRbA==
X-Received: by 2002:a05:620a:3715:b0:7c5:4001:3e9f with SMTP id
 af79cd13be357-7cd011189dcmr2379878185a.29.1747058177310; 
 Mon, 12 May 2025 06:56:17 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00fe61edsm548440885a.106.2025.05.12.06.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 06:56:16 -0700 (PDT)
Date: Mon, 12 May 2025 09:56:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH v3] qtest/migration/rdma: Add test for rdma migration
 with ipv6
Message-ID: <aCH9_RDIgLzEbeG6@x1.local>
References: <20250512060135.2068282-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512060135.2068282-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On Mon, May 12, 2025 at 02:01:35PM +0800, Li Zhijian wrote:
> Recently, we removed ipv6 restriction[0] from RDMA migration, add a
> test for it.
> 
> [0] https://lore.kernel.org/qemu-devel/20250326095224.9918-1-jinpu.wang@ionos.com/
> 
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Michael R. Galaxy <mrgalaxy@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V3:
>   - skip unsupported rxe interfaces: lo, tun, tap
>   - setup/reuse both ipv4 and ipv4 in one setup shot

It still fails the ipv6 test here...

# Running /x86_64/migration/precopy/rdma/plain/ipv6
# Using machine type: pc-q35-10.1
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-334248.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-334248.qmp,id=char0 -mon char
dev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-10.1, -name source,debug-threads=on -m 150M  -serial file:/tmp/migration-
test-2TUX62/src_serial -drive if=none,id=d0,file=/tmp/migration-test-2TUX62/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-334248.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-334248.qmp,id=char0 -mon char
dev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-10.1, -name target,debug-threads=on -m 150M  -serial file:/tmp/migration-
test-2TUX62/dest_serial -incoming rdma:[fdd3:4fdc:97c9:ca4e:2837:28dd:1ec4:6b5a%wlp0s20f3]:29200  -drive if=none,id=d0,file=/tmp/migration-test-2TUX62/bootsect,
format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    -accel qtest
qemu-system-x86_64: -incoming rdma:[fdd3:4fdc:97c9:ca4e:2837:28dd:1ec4:6b5a%wlp0s20f3]:29200: RDMA ERROR: could not rdma_getaddrinfo address fdd3:4fdc:97c9:ca4e
:2837:28dd:1ec4:6b5a%wlp0s20f3
Broken pipe
../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
Aborted

Would below look right to you as a fix (I also adjusted a bool input):

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 1a67a9e2e4..a62d3c5378 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -197,12 +197,12 @@ static void __test_precopy_rdma_plain(bool ipv6)
 
 static void test_precopy_rdma_plain(void)
 {
-    __test_precopy_rdma_plain(0);
+    __test_precopy_rdma_plain(false);
 }
 
 static void test_precopy_rdma_plain_ipv6(void)
 {
-    __test_precopy_rdma_plain(1);
+    __test_precopy_rdma_plain(true);
 }
 #endif
 
diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
index 404ce63a90..6ef61b9917 100755
--- a/scripts/rdma-migration-helper.sh
+++ b/scripts/rdma-migration-helper.sh
@@ -14,7 +14,7 @@ get_ipv6_addr() {
         head -1 | tr -d '\n')
 
     [ $? -eq 0 ] || return
-    echo -n "[$ipv6%$1]"
+    echo -n "[$ipv6]"
 }
 
With that the test runs.  If it looks good to you I can queue it with that
squashed.

Thanks,

-- 
Peter Xu


