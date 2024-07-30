Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BA9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpow-000738-BB; Tue, 30 Jul 2024 12:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYpou-0006t7-4P
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYpos-0005l1-J8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722357325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oybZ3SzlEScYaHLDt76yjBBSMfXFmJeutgYNIL1YBw=;
 b=WrQAWg+uiZXmLrqvx/lCb0z+fSENdaPHLEPzvIUhjVNqUpqKNnc9B2KEr36Tk5SL8dlrfb
 jxRmMvG8Fst28wwMGFyjfyx3RLmQLxGVZ9Eq3QGJiGWUQnglAVvpWePvcLjKclYoaFHOGk
 tUk9U9MNsiGJg6Jw5JLFMt0ifU6SUho=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-8JiB2Up4MwKy6sQi1vXzCw-1; Tue, 30 Jul 2024 12:35:24 -0400
X-MC-Unique: 8JiB2Up4MwKy6sQi1vXzCw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7aa26f342cso431438566b.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722357323; x=1722962123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8oybZ3SzlEScYaHLDt76yjBBSMfXFmJeutgYNIL1YBw=;
 b=cPDm4NODaw41Hw9t7/04vOF5dymYN4HIc2xmS57fvt0fXdEDb2/6BlUWDG8RZz/bX3
 BPS/4l39IlHHryGWTGc0s2vWgkXaslf2nk5lazpdJYKNIGomYKskx31M0mKLxvdtxZ1B
 5oz5u/upCwKQsLSJJD6aDF8UdsCD1K05cNuLSWVhDdQIcE1jjWCp+1qj6AAbk+ZSy2uy
 nmtuL1XniexMH/2O1jTkNK7wZjCJMwioyyfrWeSaUWeBge3FrYpPI4QXRq4JCkjKhyYo
 lRmMt8jpeAlimaCVOwTj1Ovxp35h9rBPUx5OFy5rLlx/sgyIDRE0SJJ/XajccOTsyH1R
 DmJA==
X-Gm-Message-State: AOJu0Yx81nrSt6rAC4H/efSeLCiPpmEbi/3TaEOzu+U4iGP5Tut4npD0
 a5U4dttF9bcRgzBh5qLHM1rJlV6mhTmBjF4wuRVY8Ran9tmPsYYJmGQGLwpnxBDe6z2pD34dHaj
 FuJOzAJgeOYLnorF1kGCS3exVV1dz0b+ZLjzpb/h6V7LYCQ4yibsKbQTEbRWY6xDDk3hlDLEaWX
 4hciGnO3yYyMVZHJrvlJYtTmlCDvC6WytCKMMI
X-Received: by 2002:a17:907:2da8:b0:a7a:a7b8:ada7 with SMTP id
 a640c23a62f3a-a7d400746d3mr862766266b.24.1722357323054; 
 Tue, 30 Jul 2024 09:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmvq4Uelr00YF9mmINUcQe9XyVcrJR1KrVCD13O05oy9MV4yBmfpaM+BwcGXGIOQMzGECINw==
X-Received: by 2002:a17:907:2da8:b0:a7a:a7b8:ada7 with SMTP id
 a640c23a62f3a-a7d400746d3mr862765066b.24.1722357322643; 
 Tue, 30 Jul 2024 09:35:22 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadbb8fasm665996966b.224.2024.07.30.09.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:35:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: aharivel@redhat.com
Subject: [PATCH 1/2] qemu-vmsr-helper: fix socket loop breakage
Date: Tue, 30 Jul 2024 18:35:15 +0200
Message-ID: <20240730163516.83566-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730163516.83566-1-pbonzini@redhat.com>
References: <20240730163516.83566-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Between v5 and v6 of the series, the socket loop of qemu-vmsr-helper was changed to
allow sending multiple requests on the same socket.  Unfortunately, the condition
of the while loop is botched and the loop will never be entered.  Clean it up, and
also unify the handling of error reporting.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/i386/qemu-vmsr-helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index ebf562c3ff8..bac3ea70393 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -227,19 +227,17 @@ static void coroutine_fn vh_co_entry(void *opaque)
                                 &peer_pid,
                                 &local_err);
     if (r < 0) {
-        error_report_err(local_err);
         goto out;
     }
 
-    while (r < 0) {
+    for (;;) {
         /*
          * Read the requested MSR
          * Only RAPL MSR in rapl-msr-index.h is allowed
          */
         r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
                                 (char *) &request, sizeof(request), &local_err);
-        if (r < 0) {
-            error_report_err(local_err);
+        if (r <= 0) {
             break;
         }
 
@@ -261,11 +259,15 @@ static void coroutine_fn vh_co_entry(void *opaque)
                                   sizeof(vmsr),
                                   &local_err);
         if (r < 0) {
-            error_report_err(local_err);
             break;
         }
     }
+
 out:
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
     object_unref(OBJECT(client->ioc));
     g_free(client);
 }
-- 
2.45.2


