Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B2DD37E4E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2wd-00080x-Lm; Wed, 14 Jan 2026 10:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2wa-0007z7-Ga
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2wZ-00040t-3T
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768405077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mcnyo4z/K8zuM5H3fJ07dyGpdMXNXVDKzy7IKjPXbW8=;
 b=OuOsKsw9VL3QLTFAqIItdOrTFr87vhZOM76/82wz9s7w+SehMQOxZpvb0WhRmwd9eXrcr9
 GvyCM4BXgCevoVlW/TydNtjM5dUBkQ4zGN2hpY/WhuZFH+0a/OCrMGs8ZckYuBjAN7srV7
 l9Xu9xuV0ZZagpdSdkPA+r/fJLSxn68=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-XwCp0VHwMJiy0uzwQ_pMLw-1; Wed, 14 Jan 2026 10:37:55 -0500
X-MC-Unique: XwCp0VHwMJiy0uzwQ_pMLw-1
X-Mimecast-MFC-AGG-ID: XwCp0VHwMJiy0uzwQ_pMLw_1768405075
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c52d3be24cso191132785a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768405074; x=1769009874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mcnyo4z/K8zuM5H3fJ07dyGpdMXNXVDKzy7IKjPXbW8=;
 b=gHKCpGF2eR9To/G6jPrhdpr8gLPh8tKIV+2H/6bczqToXdNaowsa9NOKchATGdprvU
 rgdcQ4suF6NaurFJe8LfO2EG0hCayTD8k8jkCDYmGXpKu9b+WQTz66GrSiEVMHaFqHqY
 k44xIwxGBm5Ui2ZBTVtmxnCaytUwzuHliNx9nBYm/9zaIIH5J4s4c2bcISb1CjYl1ekW
 YcNVIchpz+W761KGfwKbmZZ1P4B6W4IDGb5ijI7pNMB04BsC2KzRjwjOkiJK8VPofhPa
 olUauY3xkS248a0XHOrXnv/9X+pIMkAVSvGwYa+7gvxAOjfjjYD6w1TUsRdYzfaUGkCA
 TB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768405074; x=1769009874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcnyo4z/K8zuM5H3fJ07dyGpdMXNXVDKzy7IKjPXbW8=;
 b=ii1dstSuCVxjFNo1tb8ub49myWYt0edGMHToAR5GAFcR1anrWP4AK1LPOx8UO6EERu
 ANj/Y1sh+D3ln4R5l8yvANvgmxwOh01xg+YZhAEt/lBb5BC44HFuPqHwv16mZVEUxJEi
 2Ks7R+HP6ZXxdm8xTO5V9lxO9IfwcvriYwlHg1WPMrpfNXMLUpxrr4I595TqXwB9v342
 H41lsa8zdskObs61vKjVGakBO/jJ8veYyFPOouzECcox9BUy447PgoZMDMu7tK9ZtKmO
 RCStDaYm+e+zeYyVAQDy9eRGLmfqdu8OiC50EoG+90dnP8sAC/1bFEeMcXtFVPmsZR6f
 k0hA==
X-Gm-Message-State: AOJu0YxgvPD2RkHQRryyVxI2+y4q2i4Fe8CQJGnOdnuo/TixlSOpkQGc
 sepA+3Gijl8X90NIU4K/Z+g/HespZRn+T9nCfjzwfOzA3/ANvKOUAIg18EIRMt5mqI2/742Gx2b
 gpAMiwEZ3RjwpoH4YIHhHwsc1w6Bpqoy7hhqU2TynAnt4hyC460B5Csb5maCVtmUtQqAv7UMpnH
 mHEIK8JbyHOFYSD8+usfefMeE3ZawlKlpB4Y9Msg==
X-Gm-Gg: AY/fxX7Ld7ndON2Ez+JrlXHOVKo6hwlpVmIaskWK1cCNv6e9sz/bRvy3zjOGlLgehh9
 7pOdjZ8F9FCNv2m0oOcZcUjecNzuCNqxjusb6Ry7VGyNIxAkBRgoIpB7dCozauOQvv3rohKm4aB
 ev2PC7TEPW/zl4HbiNrMTYOFTCFbt94SnQNB5qms7Jf+0uDkSBo8jn/1H/e75oLNhOuy9b5uyiM
 UaDv4ja1fpGHIbcS0kEOqcSA7kR6dcv2kWHTvAZCXjhVWaUA8Yrzt0s/3n4jZZoG7bbMq/ZSza2
 vq0cbI6MteXNRSVUy1FGUvLSO8sxTlBzUR2LsPjXibgcv8/c8+IEkT+ZCdZhwekFa5LD8n0qVcG
 m
X-Received: by 2002:a05:620a:284d:b0:8c1:ab1c:f2da with SMTP id
 af79cd13be357-8c52fbf6914mr453173485a.70.1768405074536; 
 Wed, 14 Jan 2026 07:37:54 -0800 (PST)
X-Received: by 2002:a05:620a:284d:b0:8c1:ab1c:f2da with SMTP id
 af79cd13be357-8c52fbf6914mr453168385a.70.1768405073901; 
 Wed, 14 Jan 2026 07:37:53 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530aab8f1sm184047185a.23.2026.01.14.07.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:37:53 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 0/2] tests/migration-test: Small cleanup series on postcopy
 tests
Date: Wed, 14 Jan 2026 10:37:49 -0500
Message-ID: <20260114153751.2427172-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v2:
- add one sentence to commit message of patch 2

This series removes two unnecessary fields in MigrateCommon that was only
for postcopy tests.

Comments welcomed, thanks.

Peter Xu (2):
  tests/migration-test: Remove postcopy_data from MigrateCommon
  tests/migration-test: Remove postcopy_recovery_fail_stage from
    MigrateCommon

 tests/qtest/migration/framework.h      |  7 ++-----
 tests/qtest/migration/framework.c      | 25 ++++++++++++++-----------
 tests/qtest/migration/postcopy-tests.c | 12 ++++--------
 tests/qtest/migration/tls-tests.c      |  8 ++++----
 4 files changed, 24 insertions(+), 28 deletions(-)

-- 
2.50.1


