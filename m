Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1F6C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12RS-0004Rl-3S; Mon, 31 Aug 2026 09:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RN-0004NN-Rc
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RM-00041c-EV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBPynONSXt50qWGPPxB8QrsPyQCuzGu7AJuh/pD4AQk=;
 b=MDHRgOQuTV0ssV+15v7m8u/UH52NpZcTef9/FGi4dDWXEjP5iawOuz7YMN0dTJa4PNOKgp
 g49R6rWuKPzNuosOsPIvRqD/yDMt6fbFi0GL12Vd6pVDvG8AMoLSJJQLURK92O0wKxL1zx
 kRuZfzvUckdD/citxB3ApSMUXLSXIOs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-xxkbcGi2OMWMMcFI_KDCXg-1; Mon, 31 Aug 2026 09:52:46 -0400
X-MC-Unique: xxkbcGi2OMWMMcFI_KDCXg-1
X-Mimecast-MFC-AGG-ID: xxkbcGi2OMWMMcFI_KDCXg_1788184365
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49b0d7a07acso34426565e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184365; x=1788789165; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tBPynONSXt50qWGPPxB8QrsPyQCuzGu7AJuh/pD4AQk=;
 b=mVKjLlDzAVnj6wanjKVpAw6zmllUZFKU/0rCjMkUrLGMv3JZS0Iefgrhhe5UUFuICa
 lOlUvdJc8H4c4HTsdQqMeNOSEwlJKtT12WWf57f7CmJWgupA4P9+mGjDAYEKNZgGFptr
 7L/LOXTjCz3CjHc+BOl2GMAgU7ddtmk31UqUPD4NYEavnUVCpcyOVSIYKauo+uwKMJXd
 F+0TPUWktgltI9oq8BXWXNhafWAsa43vnlNokS4bRmqVjGFJrhLI7BEx49ui75ZsGo4q
 YmGWtCpwogfCTxbOFH1+Ri7/Gr78hcmzD1D+KNzCJrpnz9Etl//djz/VLXnNwk6ucAoy
 mRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184365; x=1788789165;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tBPynONSXt50qWGPPxB8QrsPyQCuzGu7AJuh/pD4AQk=;
 b=E75w3E5sBBcpvsXpPfexHQBtV1UgS/eaHhEnly/6++7lAAKYz1DDr/Icl5sGk/mm//
 EuBNTwQ96ACp/JV4/ckG5WoDd1QQfQjXdUk7hS3b4bJZkwSJ2V8V+otcbNkYcYKfX5+l
 4CqYnb2pvRY9mGvk2XFyUuvR4unoysjo/rEyzMgcWGlE9mg3ItYd6AitjGUWVstGtvjB
 Gwq2kbRbzHCscW/B09yXPV2tGXg/j7ldLTLrCCZew9cdFzaPek2h96ZmbJ/B4DfKNVhh
 J5fnPWnWlW6enbNM+laJVfgX80bSru4zfhofEgPglHR458XE6A4MakZ8vfQFfKRbvB93
 63Jw==
X-Gm-Message-State: AFuF++kTIu22NhCfnDZFyinwoI4hCf6zP6QdqqXzpk8XgG2u4FDtY2Po
 ts8GJp5jn1cvzatdtxbTtJW5J4gBAO7nu8IZSCO+AcpOaJUAw7cN3Llbx5PINFS+YkxlDUWanQ8
 uIzLZhbeFzQ2qtab1mLMuQTaSgZDmtfHqXVa2tkXAm0f+t2EJlR0wd0G6
X-Gm-Gg: AR+sD11qdR/CjaXyve/yneo9wZpm4nNRZAcHgu9Vtb+GSbduEfmdsrPaXsajRcWHL4p
 Lc15+vrQbyVoNLKvfPeHDJBi8BD1eyVkninv4g/h+nTfcy+GiyOBd+mkX/b1dDMonr35eD2GntW
 ox/beUrxjJlOb4/6C4p4a1NLfkTf80hxg1km2RPukelCzgDME5TgqO1kecKsYFiEmL3/MDjpgtT
 cyqlM12R9U/Qyr1Rs+u8hl2433I2ck3/kzkMtcyWyWZEmvvuJxTItdEElSBCwT2y9hpfKersqjz
 oqRP/lrsxeES3g5n7txKQZ1WbyOb80D0cz3rYJjbs5jhKxZnxN+jFuWrTPfkb9y0SgH/xuA5+nl
 dygL/OjKa07hSVl0kD+eciIgudioEiZq/XnHSjQnwB6zvNsFJMmAaHU/Hh6Y=
X-Received: by 2002:a05:600c:1d8c:b0:49b:916f:1471 with SMTP id
 5b1f17b1804b1-49b91c1df21mr447700625e9.3.1788184364899; 
 Mon, 31 Aug 2026 06:52:44 -0700 (PDT)
X-Received: by 2002:a05:600c:1d8c:b0:49b:916f:1471 with SMTP id
 5b1f17b1804b1-49b91c1df21mr447699535e9.3.1788184364465; 
 Mon, 31 Aug 2026 06:52:44 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95018ee8sm288163055e9.15.2026.08.31.06.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:42 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 8/9] block/accounting: Move latency_ns override down
Date: Mon, 31 Aug 2026 15:52:04 +0200
Message-ID: <20260831135206.126184-9-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

I am not quite sure why `latency_ns` is overridden by a fixed value in
qtest mode because personally, I find it much better if I can
individually change requests' latency by modifying the qtest clock.

But I'm not going to change existing behavior for the histogram and
such, so I will just move this override after the latency has been
evaluated regarding a potential BLOCK_IO_DELAY event.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/accounting.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index debf1924455..223becd2e04 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -271,10 +271,6 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
     int64_t time_ns = qemu_clock_get_ns(clock_type);
     int64_t latency_ns = time_ns - cookie->start_time_ns;
 
-    if (qtest_enabled()) {
-        latency_ns = qtest_latency_ns;
-    }
-
     assert(cookie->type < BLOCK_MAX_IOTYPE);
 
     if (cookie->type == BLOCK_ACCT_NONE) {
@@ -292,6 +288,10 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
                                        cookie->bytes);
     }
 
+    if (qtest_enabled()) {
+        latency_ns = qtest_latency_ns;
+    }
+
     WITH_QEMU_LOCK_GUARD(&stats->lock) {
         if (failed) {
             stats->failed_ops[cookie->type]++;
-- 
2.55.0


