Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E20FD006D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi06-0000FK-MH; Sun, 01 Mar 2026 09:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi05-0000Eq-43
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi03-0005ha-O0
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykpCYD8K9F4vTS88B961FauvZq3r+CLZlRGd7yZSLQA=;
 b=Dxol/bYZly80XxsrMX2c4NFcnV9x4f7eWvu5SlBVqaM+Fjn5DkaQT2OMwijEK2X3zcie2N
 PT4OBRpdaqKjb7EEmhgjNQbUZVzqdXln2Q4FRL5rVxhRL+YxxykxAj1psPqce89pc5IbB5
 pSiUxYh2Hy8obqxwAqor90ws+uq9VBc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-yyzZBOC9NRymh4VYdxT93Q-1; Sun, 01 Mar 2026 09:42:24 -0500
X-MC-Unique: yyzZBOC9NRymh4VYdxT93Q-1
X-Mimecast-MFC-AGG-ID: yyzZBOC9NRymh4VYdxT93Q_1772376144
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so43585855e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376143; x=1772980943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ykpCYD8K9F4vTS88B961FauvZq3r+CLZlRGd7yZSLQA=;
 b=uJP7EHWWjmn9pn7I9McfbehqZ+96FIS0U66LefcX43UY8y2kfWhApwyr2Ex49hOKhj
 edMXtta6BuLz8FASTvXQtCEOfQ54/FaT2QlqtVzbXqivprOAjn+1e3GrKdy5DUwCvWIx
 y2ZorX+UyeHbeXtZtbFQ7+ov9iFcrZmKqMmycTWQSy8KQ3PV1p759nNJWwZS5/1Vq42T
 eioaFXqDgGJ3l7zqSVhqZokWF+a8t/lvYbfz3vdWZs2Y7N2EkRfGBH6vqyReRTM+iOg1
 rY5s3T9gIL+sIer6WzZ3p4GAWkqgRVVVl3OSVTyJbiiBdeLB50DVAIrp4n5jPsI62cAp
 /uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376143; x=1772980943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ykpCYD8K9F4vTS88B961FauvZq3r+CLZlRGd7yZSLQA=;
 b=tfJzPpLmqk3GEFYlE9tc/R7cQ9Y9+xM4O0jXT09HQY+cAkdj8qSiVCbF9E/5R999I1
 HeWgCdLmuhFrRMTSUxaUMlg4zwiTEQ1lnT+AtVgVBabIiJ4ZHh4GVxLT4Eo0KCzM2M0D
 ueZO9Pu2QkPVkFKBdcZ7mF1jKnuxrehoE0htBpuX75s0wQiMulEVow56dV+2MmJLvtbp
 yMHTEpjBaVBPO2A5WeD+VJzeajjA/6bEpUQuC7vsltDA+uht6z9gQuM2sTbOe24rT15+
 TCSHvvIg6pWWDxwY98p61Y/GTUKrUwcgKi2Y71cmbjU8E9ZGnr62Xp1x5EACEZ0kRdEo
 pp0w==
X-Gm-Message-State: AOJu0Ywr944b8OQnHv5gWZY67lYdVYICRDrhYT1UZGZbP+L842f+xJeH
 8xQASDxqVKfptls0+zYU1Ck1XGkBs+VIGfMGbmk4vkYDBPrUqsDpwzbm/SvaAVpnRcySrPmSQH9
 drg4XQChtFHq3I8AysrvbZXfLk13EnEuxlLyo+anAQzZM8vis8nmWh/aQTVq+Ko90Uvc8iIkfXc
 /UD6cetGlDNFLevhTv3HXPmR5Zwmvmxg7kxY4Xv1Kl
X-Gm-Gg: ATEYQzzavaeTW2yFP2tz/shymRBYF/JqnzWvIOCbLEOUJDICPV+IYJkHz6htgZm8bNO
 p+qp4qOYfXrI7yfToJdRKJfRqP9e352evNuRlKEb/B5bi/qKbqAphgip8Sc4Z26ngTpgMpccEAu
 Mj4qpiIl3wu7gn+3cLsM8aQvWz8S3VisVt6bBT54wpsrXL+eto8Z/rl3l2Krwed4RH6/X0vi8Oe
 QM2eVG6nIT25CUuM7I5TsH+1b3Mn2oIWgU/TZIZClukcx7ccLcJf2N2ivHmbC1/6D82We+4gUya
 TppxLd8+sn7zpMxtYWOFtrEPatqwQ+W6/Hq47cFRtjGJptZ8qx3FAJH7kEfiWDlfk3KDigXd5/d
 K3oHh7LhKGvPZJSbhf20A5zVfm8s24XYMBhf9ZG6Xr1xQIqLa44lgTpS0FzazyANyN9dkEO8oWB
 /ldC5DxBjkD9ETPy+KGi1YuNF36lw=
X-Received: by 2002:a05:600c:3e15:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-483c990670fmr145979975e9.3.1772376143190; 
 Sun, 01 Mar 2026 06:42:23 -0800 (PST)
X-Received: by 2002:a05:600c:3e15:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-483c990670fmr145979535e9.3.1772376142639; 
 Sun, 01 Mar 2026 06:42:22 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcb9b97sm178113585e9.7.2026.03.01.06.42.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/18] target/i386/tcg: move check bits out of validate_vex
Date: Sun,  1 Mar 2026 15:42:01 +0100
Message-ID: <20260301144218.458140-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

JMPABS will need the W0 check; move all of these checks
together with the others in disas_insn.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 086a3bcec18..6fab597fafc 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2722,24 +2722,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     if (s->flags & HF_EM_MASK) {
         goto illegal;
     }
-
-    if (e->check) {
-        if (e->check & X86_CHECK_VEX128) {
-            if (s->vex_l) {
-                goto illegal;
-            }
-        }
-        if (e->check & X86_CHECK_W0) {
-            if (s->vex_w) {
-                goto illegal;
-            }
-        }
-        if (e->check & X86_CHECK_W1) {
-            if (!s->vex_w) {
-                goto illegal;
-            }
-        }
-    }
     return true;
 
 nm_exception:
@@ -2991,6 +2973,15 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
         }
+        if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_W0) && s->vex_w) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
+            goto illegal_op;
+        }
     }
 
     switch (decode.e.special) {
-- 
2.52.0


