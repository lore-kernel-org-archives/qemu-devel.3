Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5DBC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9l1F-0003Qk-99; Tue, 29 Apr 2025 09:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u9l14-0003Lr-P4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u9l12-0006zW-P2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745933330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeGhxl9QUGq3KyGalvYR6vREk4HUFrempDi813QrCoE=;
 b=S4kOgWotZZWRYoWjaGyiD9Ibydp4l9Zy6eqMGlF9M3UyDUvtOBZI9MXPKIU5bLjpMxButz
 0HZNPIp4A0nFCMgc3T6V9gqg1ZTIFQ7GyBLPBI73H+ZiCek8fwfzRgakNYjBaO9h4/C2ft
 q0wYZvv0g08Lnfci/sMfGjkUkwN+34o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-lJIgbSUeNOibZA1AlWA-gQ-1; Tue, 29 Apr 2025 09:28:48 -0400
X-MC-Unique: lJIgbSUeNOibZA1AlWA-gQ-1
X-Mimecast-MFC-AGG-ID: lJIgbSUeNOibZA1AlWA-gQ_1745933326
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so26199345e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933326; x=1746538126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MeGhxl9QUGq3KyGalvYR6vREk4HUFrempDi813QrCoE=;
 b=rBh+FmLLv4MzH/OQD9XZkmCcacwv9YrNzFh4Nau6zHthFWr/rNPYJC5gLXEVcK52TB
 ivq9ySPAxv5G4Sdv5GGnL9i08cd9XkgqK3TyXf0JxgsilFNNdSENhYkkrrQKGW9Xxr2t
 clOMHy53+BPwLHKsOGjIgR5r0qD+gpb98ud+5s2O4tGvel4FVZzI+pdA/q3rSkls0S7+
 FJV7GKyYPZQ+rHFQUk/2mE8sGPpp44vxdhn/JgiwlLbBaG7yEbFp85eXOQqbcMnlFDQN
 +aCkeRN8VIdeT3ejBSNTws3eNXOKqmpYOUdI3vAD1AoVqQdwSZloRNj4Ndk2xdadLUz3
 MsKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIMj4QM4NnJ/lPnXTyVsSqV0vJ9Cgth6TcrsIMVZzKuQqWmhzQL8JGW5g9erX86IsKE/jd9FaO23Io@nongnu.org
X-Gm-Message-State: AOJu0Yx1g+MlDKn+VheLNLUU2g+jg3G5eAT4OxD0jPOBbS5WCpKetBsa
 iJ2f8xiWuhoQdmT1yX3dZvp0lKKF12Sf2nWii0Myu/mUXqf3Z5MIOwirpXKZ/omwrWVYwktA29I
 uZF1ZfnVBIBq8PZ1k9LYAfw8+bLunRUFy0UIB7o7iaCkVAWikqDpz5B9Fx1JHexGvVUQjPC0f38
 Phau/w3nONUEAKy/JqoRdUWexrE0M=
X-Gm-Gg: ASbGnct2DY7OfHngj6xpryRynb9MwwsuChwjlaflxKfvY53SLjHNLIcyjuvjV1LmAma
 Mx8fQR+sdZes9t5A7sQ9oyrgCX7KVnTUe9W8RGs54IKgHMJ+XtZbc9GoGiLF1UOrHRRG8
X-Received: by 2002:a05:600c:3b1d:b0:441:ac58:ead5 with SMTP id
 5b1f17b1804b1-441ad4fe11bmr22572405e9.31.1745933326289; 
 Tue, 29 Apr 2025 06:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDKenmYyveZXPzAqHk11ms3Bc+jlC7014s/6UDk917dDn/xcpdH6L61AFCxm7Z84llQ4BFiTT+GzUXH3nmrqw=
X-Received: by 2002:a05:600c:3b1d:b0:441:ac58:ead5 with SMTP id
 5b1f17b1804b1-441ad4fe11bmr22572245e9.31.1745933325942; Tue, 29 Apr 2025
 06:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
 <aBDObgL7hDQMy63F@x1.local>
In-Reply-To: <aBDObgL7hDQMy63F@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 29 Apr 2025 18:58:29 +0530
X-Gm-Features: ATxdqUG4SbJatBAz-6GG07P6b5e-lPXMZgzKv0sdUY1L5i9pHCo4AzfC5LrWYjs
Message-ID: <CAE8KmOx9yuZWWHnaA6gkC2VpeimY1=Pw+AU9iDvQ+vVpUp_vKg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Tue, 29 Apr 2025 at 18:34, Peter Xu <peterx@redhat.com> wrote:
> I think that's what Fabiano mentioned, but ultimately we need to verify it
> on a reproducer to know.
...
> Looks ok, but please add some comments explain why postcopy needs to do it,
> and especially do it during precopy phase.
>
> I'd use migrate_postcopy_ram() instead.

* Okay. It should be '||' instead of '&&' in the first conditional I
think, we want to write zeropage when postcopy is enabled.
===
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index dbc1184921..4d6677feab 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -85,9 +85,11 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
         void *page = p->host + p->zero[i];
-        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
+        if (migrate_postcopy_ram() ||
+            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
             memset(page, 0, multifd_ram_page_size());
-        } else {
+        }
+        if (!ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
             ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
         }
     }
===
* I'll send this one if it looks okay.

> I don't think we can know that - receivedmap set doesn't mean it's a zero
> page, but only says it's been received before.  It can also happen e.g. >1
> threads faulted on the same page then the 2nd thread faulted on it may see
> receivedmap set because the 1st thread got faulted already got the fault
> resolved.

* Okay.

Thank you.
---
  - Prasad


