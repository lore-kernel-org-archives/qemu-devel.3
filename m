Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AA8D1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUG3-0003jU-P4; Mon, 26 Jan 2026 16:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG0-0003iK-TH
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUFz-0003L7-2f
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769463380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3fo+/iJh40GPuC54LKZ0w6MmtthE+pRDnesy7ZPeiG0=;
 b=dNRlXZFldNo+o8rmhaN6WMTo9+QfNa+l+XzufTfmrGExkTCmZAuMbPdukcFGCUjtp6JMKw
 ewxTpRQ8/8bQzxRZMFx5C5kZ/Vgx1xjBi/BsBaTfUuRUbMpM244nNGu+aelAtCKT8o+Jiq
 QsCYScnxVjv1fLMjnx1ND2BRIKdUMwQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-SkQJl97yND2wUluJ4AVgRQ-1; Mon, 26 Jan 2026 16:36:19 -0500
X-MC-Unique: SkQJl97yND2wUluJ4AVgRQ-1
X-Mimecast-MFC-AGG-ID: SkQJl97yND2wUluJ4AVgRQ_1769463379
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c6cfd52556so1335925085a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 13:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769463377; x=1770068177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3fo+/iJh40GPuC54LKZ0w6MmtthE+pRDnesy7ZPeiG0=;
 b=MASn6zMeBV1/rDb+Whxe2wH0jCKq8jxCyNgyhYDnzPl/4jWx36uYun49bTVtlKAK8l
 0JeLKYShe6vuhZDYHVfopTCLCiX5JN5fQxoqRmUsxIG1akDnnPyI4sX29Jxua9h4wbkc
 15MlfsWwJhZW/FeryAr7O7vjpQvSF83dW5yWQ9LVqj6tsEeWqb37wQZittAUvETfSIvV
 1zuY6KffX05UrBRaZSxMhiWfBleWn/QHQYqyfzgUO+YZpcFh4vNzHe1DZmY1phkTT29J
 AYUF0cj3glj9eI5EYYUc5l8fEJCWoPiuF8yAStCdPKyUlSyIx6BG/amKCmW2Oglmp2kK
 eM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769463377; x=1770068177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fo+/iJh40GPuC54LKZ0w6MmtthE+pRDnesy7ZPeiG0=;
 b=kLIcRMcB44ODRImAKbgDf9DMmFPeiACwkg07/mbitVfxxvF3ZpYeD9GyA2NCmjBuMy
 pTQNVRMr1I9Wkj3vnubeUiMIYLIawefEIKMO5nlmLS4WO5qxq/DOW+vUZ7Vg22MwALla
 o51yWJggDKWh8/mVehNQ2IsOaPfYAuTqxrZqlqLnbwAnFzzlkvOHFNj+uIbc4NECdlrg
 6eIV+ZwVYBVjgdiDldOLdFBYnur8KRSLzz1AbMX0rsOBrABh18MH1lkDLsV1dR8+jGfA
 TajUbgV7H4guvutB+KU7Rm8HmEPvVJs3gIjAgbnj5ZdZ/BpMzsguR1SLcnQmemoElfA/
 1WVw==
X-Gm-Message-State: AOJu0Yw9V1iaF5S8bpiGm1x+69xoyLjVBAUPk7W1Ckowk/Mjv7ll2W+r
 4ByyrGitGqw9UxZsyWCMivqPxNflj1jXDY00K0zNXJ67B1+DiKKj7fO3lL/qyXe4l7A9xQQ2XZS
 l4a2oQlzc0yL0fa9t7lpSi0iQm0rFlRAlTXBPzmmB0yYPYkyrT+AahqGbaOaGNIodLczEb8W/fQ
 g+d/AeZirRfTSNxajZJ8YDCgDWSYinns3t85vQvA==
X-Gm-Gg: AZuq6aKhDI8VIr5jzWqK0JHOiAE6ZyOF61ivPF24fDJcjH6T/n+itzF9LBe/o4UVxy7
 wNVG4yQCzqE7TFj/J8MMoD84hJJKfcS6J1HSpYk3Ni58+RiYjE7WJByHG0xG003K7spYAcjmvv6
 UY/MMPjyboxw8Oev3cV4TOJ9PZ9Zy4X1ALET0TlbGdM3gUgGflrY7GugcEuUtmuG7xTWkwBqsYs
 /uot1CLCu3tj1JCP32Yjiho3jJRtZkGS+UfGDQne70zIFCRm1IJaSUpq9n/ORbMmKHE1tDItHG3
 TQn9gnlr0sh+r5ZjJu7IBYATMvpFxI23Mvx04hyhiVRGCN2y1yAVPSxqlFGMTahnd8b6T+ptKu5
 L
X-Received: by 2002:a05:620a:d85:b0:8b2:62ae:acba with SMTP id
 af79cd13be357-8c6f98764aamr690538585a.26.1769463377345; 
 Mon, 26 Jan 2026 13:36:17 -0800 (PST)
X-Received: by 2002:a05:620a:d85:b0:8b2:62ae:acba with SMTP id
 af79cd13be357-8c6f98764aamr690535085a.26.1769463376822; 
 Mon, 26 Jan 2026 13:36:16 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7f9cd9esm89769281cf.33.2026.01.26.13.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:36:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 0/5] migration: Notifier fixes for 11.0
Date: Mon, 26 Jan 2026 16:36:09 -0500
Message-ID: <20260126213614.3815900-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2287309287

v2:
- Collected r-bs / a-bs
- Patch 2: update comment for possible sequence of notifies [Fabiano]

v1: https://lore.kernel.org/r/20260122230331.3543312-1-peterx@redhat.com

Two major goals for this small series:

- Fix postcopy issue where DONE and FAILED notifiers will be invoked twice

- Move FAILED notifier to be before vm_start() if the failure happens
  during switchover (where we will stop the VM first)

The 2nd goal will be needed by Stefan's ongoing work on block persistent
reservations, where a fallback should be required on src to happen before
vm_start().  Instead of introducing another FAILED_BEFORE_START, this
patchset should make FAILED work instead.

Patch 1 adds a tracepoint for me to verify this fix.

Patch 2-3 are the real changes of above two.

Patch 3-4 are some cleanups alone the context that we can do, hence
attached at the end.

More details in commit logs individually.  Comments welcomed, thanks.

Peter Xu (5):
  migration: Add a tracepoint for invoking migration notifiers
  migration: Fix double notification of DONE/FAIL for postcopy
  migration: Notify migration FAILED before starting VM
  migration: Drop explicit block activation in postcopy fail path
  migration: Rename MIG_EVENT_PRECOPY_* to MIG_EVENT_*

 include/migration/misc.h | 20 ++++++++++++--------
 hw/intc/arm_gicv3_kvm.c  |  2 +-
 hw/net/virtio-net.c      |  4 ++--
 hw/vfio/cpr-legacy.c     |  2 +-
 hw/vfio/cpr.c            |  8 ++++----
 hw/vfio/migration.c      |  4 ++--
 migration/cpr-exec.c     |  6 +++---
 migration/migration.c    | 29 ++++++++++++++++++++---------
 net/vhost-vdpa.c         |  4 ++--
 ui/spice-core.c          |  7 ++++---
 migration/trace-events   |  1 +
 11 files changed, 52 insertions(+), 35 deletions(-)

-- 
2.50.1


