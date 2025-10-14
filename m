Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA2FCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kZ0-00061n-Lu; Tue, 14 Oct 2025 15:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8kYy-00060X-Vj
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8kYw-0007Z7-Jm
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760469595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuPOCIy/RPHCF/8+cQhbwLAooQJNz3B3/YsEPxih0A4=;
 b=ChvEihdMUjgv758/dcyoNfuiA0WUNbQmc+SdxAfN4TYkIwmz3IjwtA5ex1U5v62dPA63Ep
 ihoMSJkoqoCpm9PaARuoI6kB0tJWgUST7NtQbkBLRTmdyIwcE6a4dTIVGV1gIkIvmvh0c8
 cb43Wpr5BX4bVUg60HFh/2c4c9KzPbs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-g0eXpgR0OviiIZfnmX9qig-1; Tue, 14 Oct 2025 15:19:54 -0400
X-MC-Unique: g0eXpgR0OviiIZfnmX9qig-1
X-Mimecast-MFC-AGG-ID: g0eXpgR0OviiIZfnmX9qig_1760469593
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8635d475523so2735514785a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760469593; x=1761074393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuPOCIy/RPHCF/8+cQhbwLAooQJNz3B3/YsEPxih0A4=;
 b=aFP61W/qYFnnu0hcmjslR/ipjZ+I1MdVfFGhxOqs2yQMSbm0MDj+0eyrWG9rJO3rmX
 Auyyr71Jb/G9OcTs7hsez/AavALbQIlZZpJuUEdkTO2Ylsxr7u+bcgHqrh9WO3wiFhrK
 RN1O+rA95NhKbYfxIzkGNfyqGcVVjx7+5460PucH4dzVczGvVQnknBN42JAHwKzb8Spx
 BpN4gONenLPAkuMkhlssVENWSgCe59z2EWsUIEl178PTqdYrHmu5KVTzKn5nHoYRIrKt
 X8Lx2604vDn9riy4oJsGAQMgoECp1WVm+GMHxtC1X8Kgb1X/i1lp/e8ufHE85slfH7zy
 cw+A==
X-Gm-Message-State: AOJu0YzB9zw1+/D/sFZApw8fltq4NCeetGp7dL/9fkuyZvieFPs4hiuC
 XxHQMrDhuS08+GZqGHFP/Xpgx+X6g3SgRn0B3dWr0IZA/mCFX39oQvTkqlH/BLZwMeiiWahf8xY
 C+weWM5o+gRMXofpLEUG/oju6858flrsNIbEpZSW64Azb2WVEucdpfiFXqXPYLdQq0pOa90fXyl
 fpE3GdBEw2D5FTy0/MCcw1L6JjaaFzSwpkFw3SiQ==
X-Gm-Gg: ASbGncsRJYgaU14Lx6CHqMtUHS0WBghwY3v2YM/JylsWVcPV9yNw2sDTPzhG0qEjob+
 t7A9F2xwUaZkadQ53oFf4xzESS4NYkr+foCgg1U/PKZ64ru2q3Gh2cve0yXZzrhYA96m9uSNUQQ
 EvYA9ZDBBhvBhvFYgkMsURspu5wVvg5lvls66weOb6kz0ewnTLnwM1Bc9/W6QYa/9kqA1ifBtDW
 WIZxZy5RIz/RggDTV941cTzlySjWs02MqvL33sfTLdDHbSCVOYmHd3EoG7MreipwfXpQMVc3HAM
 ZZZRRU16lHVYQSj182oP3obzcsdq3w==
X-Received: by 2002:a05:620a:3185:b0:863:125d:dfe3 with SMTP id
 af79cd13be357-883504a9873mr3477284285a.24.1760469592985; 
 Tue, 14 Oct 2025 12:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUsoowF8eNFQ/Es6f3sLwoAiKfNb1YASzM96/fL0YyxnuzyJ6Q9tM8adLUQPKGAXPbn7BOEg==
X-Received: by 2002:a05:620a:3185:b0:863:125d:dfe3 with SMTP id
 af79cd13be357-883504a9873mr3477278085a.24.1760469592321; 
 Tue, 14 Oct 2025 12:19:52 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-884a22744f2sm1256602585a.44.2025.10.14.12.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:19:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Richard Henderson <rth@twiddle.net>,
 "Emilio G . Cota" <cota@braap.org>
Subject: [PATCH v2 3/3] rcu: Catch rcu_head misuse
Date: Tue, 14 Oct 2025 15:19:44 -0400
Message-ID: <20251014191944.2225735-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014191944.2225735-1-peterx@redhat.com>
References: <20251014191944.2225735-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Trap call_rcu1() to make sure it won't be invoked twice for one rcu head by
accident.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/rcu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/util/rcu.c b/util/rcu.c
index b703c86f15..fc4b18812b 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -307,6 +307,11 @@ static void *call_rcu_thread(void *opaque)
 
 void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
 {
+    /*
+     * Avoid accidental reuse of rcu_head, e.g. enqueuing one node twice
+     * (especially, when the function pointers are different).
+     */
+    assert(node->func == NULL);
     node->func = func;
     enqueue(node);
     qatomic_inc(&rcu_call_count);
-- 
2.50.1


