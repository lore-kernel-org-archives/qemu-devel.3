Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8E9C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHTu-0006Cy-C4; Mon, 14 Jul 2025 07:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1a-0001yd-Ek
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1X-0002DH-BI
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iwwKGi8Hmz04XjriQPgEvnyWduNEXOBdPyGuoBdR8c=;
 b=V+r8hAAy17+J4Qo6qkBCOLUoFApPZIc/LcTnmC7rcgl4hOvZKEhZny9JYeJcxW7k9vjPWq
 +DINjBlcm+Cxy1TTJqhTsh0JTj8ttWklYAqyjdkcX0AEHcOGvZI6NchWPQ9Ibub5GRYkbl
 JlMtUcXX4qRxD2xa7cIxNOrVj5t5GC0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Bv9sYeoCPrGYNed9Z8B5nw-1; Mon, 14 Jul 2025 07:07:04 -0400
X-MC-Unique: Bv9sYeoCPrGYNed9Z8B5nw-1
X-Mimecast-MFC-AGG-ID: Bv9sYeoCPrGYNed9Z8B5nw_1752491223
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-455ea9cb0beso21452875e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491222; x=1753096022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iwwKGi8Hmz04XjriQPgEvnyWduNEXOBdPyGuoBdR8c=;
 b=W6dK2f1o+bbXFrAdppoiGpoydCNeMyQ6ApiUXKsH8OHb2LJXgYyy/Rzl8g/ZIgGTGI
 g94iL9iqQgfhxrn/ePlt0kA6+a3gYioWJnXXo+LSS/MluBHYd6eOgmXB//FPmE33nCta
 RDymgABm57fFHxsxmzO2l+SUeYJgfhVN4EAR9Jlc98Yb+1VCGMaxm6LGZRtS0DIQnUgj
 61HeAZDFstw7oxA/s6JqRx6sHv/wHcK7uipLsqCOpWHs9tsqOPo1vPftLMmQGHfTLtZJ
 XJ5Qy+rIqM0T/l5EVbIXtjAM334L62LZrIjeb2zJ+56zcR1/1/afT4+oPfHhSrFngwC/
 hJeg==
X-Gm-Message-State: AOJu0Ywoh6jg2deFwfrygeVhi7R7mlnc3qnGIWgW3VIB5sPtXsFJl79E
 g1CujMMOCS9tshIGGU78UvotGDTQoPR08pYA9DlHuyNgFDWHFLbzqXVd7IfNnhfEURPLRrt5J1n
 EQksNN5KORqevRupxhwsWXXEyWLCK7u8Kdj5TMx1vQHyZGJq4nXElnPtpTgTQsLw8/0S+gTgnAl
 GIbwajk8cU3vD2QHkmLhhA+p6bv30hZuUD+2G1NFcM
X-Gm-Gg: ASbGncvoP+iOmpcsDTQE66IAUAHnUd6SXAl9LGG+S+VD/h66By+rM31081UVuy8hPwJ
 /sxJNAuA3kq/szypE1SCWamEJrgxNpFQa0H9/WOafhPnYNfCDPL3RKYGtWGE591vccdwV9+MiWs
 TIaD8Jh7Qw4G9cDiF85568U4Ct696R3szvU1QuElhl2R0KGKqRYVDBoATTXqP0fkC1X7kOVXhDj
 JiwovVgVrwMtcOf/jmAe6ntxbqhkDe+Wp3zDKoBgrpMrJuDITsNRXgSE301rX1mloDYxyhh6iLC
 mPRr8VSel+TgNAyajCKskAwjPj9CKlgvK+LToH3bcN4=
X-Received: by 2002:a05:600c:46c8:b0:456:1dd9:943 with SMTP id
 5b1f17b1804b1-4561dd90c6fmr20936705e9.3.1752491222045; 
 Mon, 14 Jul 2025 04:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMn7YO8uQs1khaKFeeknkibc9dw6LlNSrF3jxMVtMU75VRfP2Gev9P37K1Xb3eFXyMFdmYOA==
X-Received: by 2002:a05:600c:46c8:b0:456:1dd9:943 with SMTP id
 5b1f17b1804b1-4561dd90c6fmr20936255e9.3.1752491221574; 
 Mon, 14 Jul 2025 04:07:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561d19a21dsm19903675e9.24.2025.07.14.04.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 67/77] i386/cpu: Enable 0x1f leaf for YongFeng by default
Date: Mon, 14 Jul 2025 13:03:56 +0200
Message-ID: <20250714110406.117772-68-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Host YongFeng CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 216e0232df4..4f0c9734461 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6548,8 +6548,12 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with the cache model",
+                .note = "with the cache model and 0x1f leaf",
                 .cache_info = &yongfeng_cache_info,
+                .props = (PropValue[]) {
+                    { "x-force-cpuid-0x1f", "on" },
+                    { /* end of list */ },
+                }
             },
             { /* end of list */ }
         }
-- 
2.50.0


