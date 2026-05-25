Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD59CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX2p-00062O-I1; Mon, 25 May 2026 11:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2c-0005xn-P6
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2a-0007R9-LU
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PuIu6K2USzoA8+hK/I7+F4/b0n1/d9yyrD+F5AyYwyw=;
 b=GA46ono2jm8itobYzA4PZMvvGmBJ8RKgvG5kGs3/5SzZVjfcZEJu6smq716qxRPY3kYyEZ
 JOTwbkSE2lTg0UN0i9iItluYZNRtodGV9CIAoiW8Z30YEybP1nCrOG39yuM+IVZzEdCbu8
 YB3JObF9nxXHIYqGTEbR6Ij770zAbo8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-rry1Z0rIMUCXRKw7bOh7Yw-1; Mon, 25 May 2026 11:16:24 -0400
X-MC-Unique: rry1Z0rIMUCXRKw7bOh7Yw-1
X-Mimecast-MFC-AGG-ID: rry1Z0rIMUCXRKw7bOh7Yw_1779722184
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fe40b61a3so62391645e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722183; x=1780326983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PuIu6K2USzoA8+hK/I7+F4/b0n1/d9yyrD+F5AyYwyw=;
 b=P6sD0nZzsm0/p5j9aYqIWMMtFf7/eF+MM9JglmrXXZQt0FplB7ZN4yZ+mIxzNBa9/T
 hUthPW3fxBjsyB3T5Ab9FyvqmKEH2Xc8Iz7th7nWt4QML7wKOWXuiNpLAv4j0YSFkB5B
 OdBbPTbEY+CzF8LlpuXwR0kYldihCkRDQv4ndL5aODx6vD07AJ4ylp07D9Z/kVpcXQR2
 BzjFR6QsSgYGxT4ha95nhgkjYajqy0rEoo3fK/GBoLAiaDgCTcTeSbWgBzLpK6p/rGuh
 KiFpQkxyqjfYZDRA2aiMzAhU3hWc5CYH4tJmmlCLEX+FGX68Bw/OXpaVp+8TvdY/TEsl
 OXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722183; x=1780326983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuIu6K2USzoA8+hK/I7+F4/b0n1/d9yyrD+F5AyYwyw=;
 b=kFoWzFeApY1od5OaxFcL8byYUvk8qqAfHiuEtFdjJpU39tI14JNsZEDX5VgBmIEVzY
 NFRMK5s6/todzQvsKZC9mcKmhWX6NgZuruF+tiBGTzEF1ujjYc0qd1fwdZiiEpkSIqdX
 Oo04JCxBrqvR5R5B8DWZP+ldEF4M1Uik8HW1xE4NUwrTVjfD5892BYpf6eYXHpIoldXP
 t+WaJ+9uSjPA/wBnWJyBbf0s6wzoa4IwUCjI///vCUJihfqS71YrQj5lLR/4SxZrkcBQ
 MvIG6BOGVIIlSMxom3Rix5hQ1DK/JxgJmxvJWVA8w98aoQqhaRTybfUhJWbwW4Huge6N
 ooQw==
X-Gm-Message-State: AOJu0YztTDNHuDo2kYNCJrkC42R/wEVusWGVY2MS42amOt12GZOSVL93
 PMMHqL4imKtJn0jOWcB0WCKAp2UePBNMQJ/EeVYBvEzlvRiRfo/mvxovq2ef8mSESYdC/z3Fsk/
 U5uH+Y2sRwqBjiWIpze1usWKCmyvnoilXkdWIUqCGUYe3MmD/ZNVfWXXV3W1KBcVakb8xiR3Xjl
 Gd4MLlW5mSCoDbbyFAkV8WSQnkrD4cn2d6rMwmTmq7
X-Gm-Gg: Acq92OHsFv8/6xZC38Yp3nOWRm9+pPcq54oHko9mQrS2qWudBSCfOAxMunP5fIpE6hV
 4siipVxo2NiNos7UkE4oyQ60eZ1PR8pmzNdO/77VNny5/igXWaToL3jLBD19mm0JTR8tB1SvEtG
 ZSqaLOUmnWivkJ4TKjrfwTlQyJqd+gBOM57rRn3nMrYGt+zNLCGuFVQXXZUeZ2wWy1gHvHud3Wt
 AgYzbL2iWImunzUC2iF57Yw42biqqOttSulYPbCmxbhRYWUYC8wjVO46bQ3BUV7R/fvI8KJu9qX
 Fn5ZBqIxvEa4elq2v0Gp8a5bhGCR2CA7KBFBo23L7lkpsAOtKbQIPUgRgeiv6ReF9X/kVX6hbbT
 o0Tj7iTWAZ1Ch+xZl4aQOxIbJds3yNzxrtOXbYo7lp5qvgd5cS3cxYZXco8nxpfJmVAPev/GxEw
 VNxtTDnevTC0EF3fMHUt3FYMTPxQ3w
X-Received: by 2002:a05:600d:6447:10b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-490426c5b1emr174447315e9.20.1779722183600; 
 Mon, 25 May 2026 08:16:23 -0700 (PDT)
X-Received: by 2002:a05:600d:6447:10b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-490426c5b1emr174446835e9.20.1779722183086; 
 Mon, 25 May 2026 08:16:23 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ec7fcd7f9sm14497870f8f.37.2026.05.25.08.16.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:16:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Misc patches for 2026-05-25
Date: Mon, 25 May 2026 17:16:15 +0200
Message-ID: <20260525151621.395954-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit cbf877d67a812be17a9ce404a589e1bdf722c1f6:

  Merge tag 'pbouvier/pr/docs-20260522' of https://gitlab.com/p-b-o/qemu into staging (2026-05-24 07:45:19 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream2

for you to fetch changes up to 877820be501c72665aff1af468fab87f17995044:

  json-parser: constify JSONToken (2026-05-25 16:52:31 +0200)

----------------------------------------------------------------
* lsi53c895a, apic, mc146818rtc: fix various bugs
* accel/mshv: implement cpu_thread_is_idle() hook
* json-parser: first patch from push parser conversion

----------------------------------------------------------------
Jinjie Ruan (1):
      mc146818rtc: Fix get_guest_rtc_ns() overflow bug

Magnus Kulke (1):
      accel/mshv: implement cpu_thread_is_idle() hook

Paolo Bonzini (4):
      lsi53c895a: fix use-after-free of cancelled request
      lsi53c895a: clear tag byte when processing messages
      apic: fix delivery bitmask with modified xAPIC ids
      json-parser: constify JSONToken

 accel/mshv/mshv-all.c | 12 ++++++++++++
 hw/intc/apic.c        | 17 ++++++++---------
 hw/rtc/mc146818rtc.c  | 23 +++++++++++------------
 hw/scsi/lsi53c895a.c  | 12 ++++++++----
 qobject/json-parser.c | 23 ++++++++++++-----------
 5 files changed, 51 insertions(+), 36 deletions(-)
-- 
2.54.0


