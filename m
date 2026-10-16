Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B95FCCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhCS-0001EJ-0e; Fri, 16 Oct 2026 08:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xHhCP-0001DF-6t
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xHhCN-0002ra-Gt
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792154290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Ane+JbrhMd5Cs/gyF03KLLpFRYIIc3QhlZkY3uEwVU=;
 b=FiJkxIlB2b83oTSdhLXGZ6Urej2ZuwegKrDP4ZldEZKuAPzLfbKjsOX29w9N7pGiNdgST0
 c7PnCj9PXqJinHKpsLA6cb+2wrAuNIWBACB42oOW8uPu1HgkBlU+g714b9PRVNeCU0bHxX
 B+7C/eURrVWcom3iXQriwAaUdHlP3JQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-RTPcDEcRORqq3lVWH2HCzQ-1; Fri, 16 Oct 2026 12:38:03 +0000
X-MC-Unique: RTPcDEcRORqq3lVWH2HCzQ-1
X-Mimecast-MFC-AGG-ID: RTPcDEcRORqq3lVWH2HCzQ_1792154282
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a16fefb7acso48994325e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792154282; x=1792759082; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5Ane+JbrhMd5Cs/gyF03KLLpFRYIIc3QhlZkY3uEwVU=;
 b=mbX9kBa4BmqhkqTNJqV9cN927Gvz31X6UvolmuB3s+rcr2be4qEswGYKUeEFT+V5HC
 w+caGlUoh7iNyWkMXfXrMd1BbqlJ1w0VZ6uFH8yLrTYvSYquY7Au9tM7t7phSvEWXpvD
 5zqeoB+1H8/0jHX1DbCa02lmzHGpSzKJlrbDc3bwu+bPcQ992sv2cXNvMIn1MzTa8kcw
 MSYhC/Q342YJzBrSjlm51s/GxhCxbeK1gJJbCOk4275tArDgGSfUVT8jlcJBOYQlKIMC
 ppTYtDAe+7BEnpbjoOE9tfbL6lyUsNM8jluG3uzEDKW626pKuQL21mUrsXgqTvYvIiHq
 +riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792154282; x=1792759082;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Ane+JbrhMd5Cs/gyF03KLLpFRYIIc3QhlZkY3uEwVU=;
 b=12og4kwQwI9j0O/u+wp4MywH7ZdaP9n3UJh49C7V1lPLFOHChkuQg5tOUvdHBxWsYk
 e5imFuC3ltOFKWYWPRmmHjihSWFVxSgm5IieGmB4Bmc7e8z8gZJxoJwet3aBwbAdNkM2
 WzM5U2E4mBHtnI8VMCjbtT8idtFwS9vTCsLdzVeC96uiZW9JgWdd3A04t5+5l7jshSsZ
 ofv9c8mbZMLvVmIDo31iN9sU+EtAiA5KU7FH4GclhQt5tSl3HqNhyFkvk6xzW8Q9fzne
 bxlNkkLEK1o4t+aIXr1VuFPdSDJqJcFkd/P9rZ/AuOgt98Lx/aaVLYpAymBqSUtO5QKB
 UHqw==
X-Gm-Message-State: AFq9FYIjxnVrhXA9VpK4KtG6kiBta5n9N+Hx/nli0IiK8UMFXttSGHdP
 FJAf3jkLTjyZLRxusOh7rbNAmsZmdmQzNHuR9/U/NlthBhHjyugMQ+myJ4rlFVAkxXKNnxB26SW
 1Dnrk+CxnFsvzwDgK4hllKyVyGjpcbbf3kBO6QTNs8jDEfSqf4rgvIUnlLZWdRdtSq9xlVwLnhT
 MJRLfXyS3gDkmSqoc5PqukjxE10OTfHsDx41wCzDt8
X-Gm-Gg: AYBFou3smGNv6WReVMLumTebcnDRHPuLHMtmXGCQXrHn0VTlqPs04Oo3SkWH6zcMYBV
 TGwOnzkc+TEN+Xkk+dHYDsVpcruSwo2a7ejlUfN6ljzeSoAKIwHSc8myNkhaxZY63S73D5WsqM6
 nON8tXz/ony4mbe+1kIRR5By4CKSyWxBat6pmlpbtBjPg5JYl67ZV9Coax4DE9LeXJHrZ1BPGxN
 vJPENbqQiLgy3CqRC6q4YQJwjSjrEf/0uFlHrOBIAUc54BQY/AiuU70X/5DjYL0v+KdFU8+lyUD
 TN4gG5hTK3ZxwTLKhJc++J8ln+2bR+7k6sxF3Y26am3G9ay6s15eEu9q0lG+37tw2hQ8BX4b8Te
 18LskCha1EwjSO8zNrbvfjDSkoMsoipB3rnfv2ylsoM/LxR30Z+PKBUmTQT0AGxdgLIjXcQaLQN
 y34hglV5tYMeexAee6Hmso+bnKjXAW44aF
X-Received: by 2002:a05:600c:19ca:b0:4a0:2484:2800 with SMTP id
 5b1f17b1804b1-4a18e4464famr432576675e9.3.1792154282441; 
 Fri, 16 Oct 2026 05:38:02 -0700 (PDT)
X-Received: by 2002:a05:600c:19ca:b0:4a0:2484:2800 with SMTP id
 5b1f17b1804b1-4a18e4464famr432575965e9.3.1792154282037; 
 Fri, 16 Oct 2026 05:38:02 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e7889sm4730097f8f.24.2026.10.16.05.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 05:38:01 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH v3 0/3] block/vmdk: fixes for stream optimized disks
Date: Fri, 16 Oct 2026 14:37:47 +0200
Message-ID: <20261016123750.94769-1-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The stream optimized disks produced by qemu-img did not quite adhere to
the specification. This could trip up other software consuming these
disks. The goal of these patches is to get the VMDKs produced by QEMU to
better match the specification, the Virtual Disk Format 5.0 Technical
Note.

For instance, when packaging the VMDK up in an OVA archive (a ustar
archive containing an OVF, a manifest and a VMDK), errors occur when
importing that OVA into VMWare Workstation. Specifically the digest in
the manifest does not match the digest of the VMDK, because Workstation
reads (and parses) the disk contents and then makes a digest, rather
than making a digest of the whole VMDK file. Extra null bytes at the
very end will trip it up, as they are ignored in the digest made by
Workstation, but are included in the digest produced by something like
shasum.

Note that stream optimized disks, while not adhering to the
specification fully, are still useable by VMWare tooling, with some
workarounds where needed. For instance, VSphere does not have the same
issue as Workstation.

V3 cleans up some formatting and makes the commit messages clearer.

Sanne Raymaekers (3):
  block/vmdk: align stream optimized data grains on 512 byte chunks
  block/vmdk: skip RGD for stream optimized disks
  block/vmdk: add eos marker for stream optimized disks

 block/vmdk.c | 121 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 45 deletions(-)

-- 
2.55.0


