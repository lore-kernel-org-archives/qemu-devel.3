Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E82C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTCw-0004mb-VT; Thu, 17 Jul 2025 14:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSU-0004ek-SW
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSQ-0004LW-VG
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6zxpl/PQRwn3jQnhX2F8Ka6KHfmWqxvN4L1LgBM5SOU=;
 b=hBec/636T7gzn81T5daCl/9suvb99jPWkYNBVjiUSIVnv9a09lSbsuHZjuGHFv1v0zWUZw
 ia6tU29I1GLsCPsLnOXwttBhADhVufqXA9vVPix1Oc7AnEHbon1Xp1enwCPlLBNvEww9cn
 e9i9/TC+PTWOwwfzrpHtw45jFocVg94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-QNbbBIw5MTykNB_5BZx-Yg-1; Thu, 17 Jul 2025 11:23:36 -0400
X-MC-Unique: QNbbBIw5MTykNB_5BZx-Yg-1
X-Mimecast-MFC-AGG-ID: QNbbBIw5MTykNB_5BZx-Yg_1752765815
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4561611dc2aso9693535e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765815; x=1753370615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zxpl/PQRwn3jQnhX2F8Ka6KHfmWqxvN4L1LgBM5SOU=;
 b=SB4LgfcOLd9wcIqU7hQQDq6jzfhWi2DRNC0G689sxXTAGYrDr9wtD5OrFPYdJ2z2gw
 jBrBF3zE+xKbIMXsBC+YZScYrm1uXXys15Ptw5/qjEQ+9OSVTyhUqDcLrxafIuoP8x/u
 76BBXkzOlBQpEzP+WZLkljR01bp/1TtqRur1ktq3/NwdWhPVAJUK1+9htKbaLVdpfr+X
 SUddx8lctDlFq5t+oPcdzg0Q/HOmn4yQaXeqbdXRt/xMmCQ/gxsVWrBQQkTcE1Jv8YW4
 DdHfy3cqVul4eh+I4TfmjgXpM6dlqvYp73CHfXbCVReXUP94duoZtZqRN3rFMtbEpg7y
 6D6w==
X-Gm-Message-State: AOJu0YykdSAmqkX6bfZUlsCp0VpW8kNoVUeu7/GpBIZQJ9Sg2ZstJvHX
 5SjhPpuGxgyhvsEkSSHju5txNHSJD5YvbBq4UuGZJIDvvPf9NZpqD+Ba6sQLbyfBYNSJGlTe2wi
 FhzG67EoZzjbJ4ORsvJwYycINFqUP8EUSoj/zYO9iBYIf10UdvnbyiJaAlHrcfKNmSfoYRnpe9Z
 XkHqu384Rpj6rl/ctncRzcfKp2yM7sdAb6Sef+xsCj
X-Gm-Gg: ASbGnctGMzGX69oPC4b499sIX8GEVjU0sx8CsRwEyx++4UOPUUvWpw+FN6i9EhXJMZy
 9tIvcanEpOyyE+xGosi76y4vAOmwNEuw7f2yAu3AhS7EFrH6VokeDdJPm7I7jVcArBUbniC73CH
 8kOn/c1TjL9I5oWsu+sJhLoumIBlB5OY0J1C1cF7q7ziu2hx5yoDJm756IVnFDJJqc9H6gZ6ZKG
 nzE8kUo8F6pD8Z+yCtsj8Zfzn6B/2E3T1HqgnjqDtIutgZQjLJ58eQx4cqOU7aUcqvqXoYEDe5r
 kkGpo7UJCKK3NmwcrYV9iqi2xQ1XKZ+09qIcCWtiy/I=
X-Received: by 2002:a05:600c:c042:b0:453:2433:1c5b with SMTP id
 5b1f17b1804b1-4562e3b9e78mr50262375e9.5.1752765814449; 
 Thu, 17 Jul 2025 08:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKXgzwJvHJ9MG6cc7Gk9cPMScI+iS2eON6imOPm/hDjRNgNK8kU9bKgAzcAcmDi365cbWeEA==
X-Received: by 2002:a05:600c:c042:b0:453:2433:1c5b with SMTP id
 5b1f17b1804b1-4562e3b9e78mr50262075e9.5.1752765813908; 
 Thu, 17 Jul 2025 08:23:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1741sm21126390f8f.18.2025.07.17.08.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:23:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/6] i386/tdx: Remove the redundant qemu_mutex_init(&tdx->lock)
Date: Thu, 17 Jul 2025 17:23:16 +0200
Message-ID: <20250717152316.353049-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717152316.353049-1-pbonzini@redhat.com>
References: <20250717152316.353049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Commit 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>") added
redundant qemu_mutex_init(&tdx->lock) in tdx_guest_init by mistake.

Fix it by removing the redundant one.

Fixes: 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250717103707.688929-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 1574e7d76fe..dbf0fa2c918 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1527,8 +1527,6 @@ static void tdx_guest_init(Object *obj)
                             tdx_guest_set_qgs,
                             NULL, NULL);
 
-    qemu_mutex_init(&tdx->lock);
-
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
 }
-- 
2.50.1


