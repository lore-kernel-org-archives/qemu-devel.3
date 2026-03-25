Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43DB109C041
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMQ-0005AW-7n; Wed, 25 Mar 2026 12:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMO-00059c-UZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMK-0004gP-Pq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3AkzjVoFkHIfZOrj/YsNsJ8NaWzRuqCtr/53yzsJlxY=;
 b=D2WnCvSbZjtAb3/3zZnLlat6kElGjbMdM2uE9v4piQVBILTHeqX77SYq7RbRT9KjhMClOb
 RqLpHs+Z0L1S5tZ2uVPDOUGUvY3xYu7k68dqjObRBcdPFzO8qRwBWZmKhzptHmI87lqDgg
 Fzwp9ahx0gvkqPZPZ/+E1+5GLAHP030=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-E_4u33v2NtGe4cU8-qnNSQ-1; Wed, 25 Mar 2026 12:45:28 -0400
X-MC-Unique: E_4u33v2NtGe4cU8-qnNSQ-1
X-Mimecast-MFC-AGG-ID: E_4u33v2NtGe4cU8-qnNSQ_1774457127
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b8cb800f5so1256319f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457126; x=1775061926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AkzjVoFkHIfZOrj/YsNsJ8NaWzRuqCtr/53yzsJlxY=;
 b=QsUI1zNfu3cBX+PnthXGfW4/p6zFQS/xtkZy47l9NFUSN/PcA6htYW6Rk7nLL90a17
 UcUpJT1FwJpLo61+Tsd7VxCsmWnWjR/p2mCrlgvWDymr8H/KftFPgAO5dPKtrGPqz7vh
 IiwwjxeINYjJNEBnkB9LMZKOOVF2rE3zt6mCVHI8a78cv9e6sNMSbDE9AyNLrLNi9u5h
 +AI6cm/6p2tPuDC7RHfY0xyL/zkZUUEUjK9cTs7atKoynE9OnA6x6uyF0xuDjuWyKt6U
 pVUijYvG25jyOopjGqHKCmGKCw7jwmOFm8tB2sNi1Sa8Ok63YGA2bjv5B43ZrDzszhoE
 0u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457126; x=1775061926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3AkzjVoFkHIfZOrj/YsNsJ8NaWzRuqCtr/53yzsJlxY=;
 b=kevnAihXvUN5/SSE67dpKBI3J1LnBkV5jCgxoEpEzDAwEcozOxaORM2ODNSmM2Xk4U
 GMdLES34f7F7QDR7D/xT2zUpIbT4tM62q1nDS8T7RP88JzRb/fPkylAFfKnDjd4p2YSw
 MZhLSlNYfsiWxjQQbtTWz38kRvRZ7+ee4DDOSNoGeh3mzKDrfbpUNny2fSrX9MIDt2/Z
 KErUiWZZFV7KXlVUjtycYjao+2dGCSQa7b5xax1+qZGbf6teu2VXi9x2oIsXuXf0WDMh
 R0SZocpjfAZfhmIDCcC6yfmuUN6HHzJikcctPaeD5BZ2KNk9f4I8ucyJlM0H6FgQT1M1
 dJrQ==
X-Gm-Message-State: AOJu0YxS1eslxi3N+z0gnavGfPgQSHogn2dboTw3OTAzzioB/VRDsR6p
 iyrHDFV8l+7++woPpqgoAqoauVwHI/k/PAqhliBf8KIfsCKR8QppWOE5vYOvIc5cinW4RIhFO6w
 R76924Y9UNkBjabI2aOpqpxEUXylO7HP1B/DRzCCoSW8d93QILajdAqo/gqfy9Ugv9VvLv2JGzV
 AN/wXDqFOOtLQUmk7ecuM8ndAoWqcXZUjDs74XO6hO
X-Gm-Gg: ATEYQzwC4ilWCTrPljq14gWhLXiCYYbt8C8WLxif8+XNxOdzzioUbhobd3j6wHo+EjP
 qv3WcMg+cM3fOhlNFVhHdkIBfSoRg9fYnL0IMok0rTeuohtuBrzKcC3k6R5HnTVRO0c1bh5CMl4
 eABIPhZWvXp1pMu8wQiXcKJggUrH14R4izblS8WgbefMLMrlwZjPgC4Gr4ndyVqW+X6GZ6Odk1A
 s5pxw5QVLdlh72NiPIn3EiGPw28tDcf8NLffrIIORNYUwSnnoYDf36LUD2LkZ49aXrGRUlmG8oU
 RWL/nqwpiSNAop1ajLfy415swA4Z2H+r952fThabG1YQYUsJnxqFMAMzBy8EJVZouKCMWazNhvp
 eXU3IIt5/k1S5czIYlp99aSXl7/qIAxuOXYk2622KXskSYib4Ljo43Rra8rlTP9NuHBDgcGJwdr
 AHYlrZ4yiDDMR/IDcg5rk7iZB0
X-Received: by 2002:a05:6000:2c06:b0:43b:633b:da88 with SMTP id
 ffacd0b85a97d-43b88a1aa65mr5929264f8f.36.1774457126224; 
 Wed, 25 Mar 2026 09:45:26 -0700 (PDT)
X-Received: by 2002:a05:6000:2c06:b0:43b:633b:da88 with SMTP id
 ffacd0b85a97d-43b88a1aa65mr5929207f8f.36.1774457125545; 
 Wed, 25 Mar 2026 09:45:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91942f24sm1174717f8f.11.2026.03.25.09.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jenny Guanni Qu <qguanni@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 16/19] hw/audio/sb16: validate VMState fields in post_load
Date: Wed, 25 Mar 2026 17:44:50 +0100
Message-ID: <20260325164453.72127-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jenny Guanni Qu <qguanni@gmail.com>

The SB16 VMState loads in_index and out_data_len as raw INT32
values with no bounds validation. A crafted migration stream or
VM snapshot can set these to values exceeding their respective
buffer sizes (in2_data[10] and out_data[50]), causing heap OOB
write in dsp_write() and heap OOB read in dsp_read().

Add bounds checks in sb16_post_load() to reject invalid values
before they can be used as array indices.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3326
Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
Link: https://lore.kernel.org/r/20260318192918.65481-1-qguanni@gmail.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/sb16.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 1b5e452a29b..1838d3ef7bd 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1286,6 +1286,13 @@ static int sb16_post_load (void *opaque, int version_id)
 {
     SB16State *s = opaque;
 
+
+    if (s->in_index < 0 || s->in_index > (int)sizeof(s->in2_data)) {
+        return -1;
+    }
+    if (s->out_data_len < 0 || s->out_data_len > (int)sizeof(s->out_data)) {
+        return -1;
+    }
     if (s->voice) {
         audio_be_close_out(s->audio_be, s->voice);
         s->voice = NULL;
-- 
2.53.0


