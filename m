Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25846C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEV7-0002HK-Kk; Thu, 20 Jun 2024 05:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEV6-0002Go-0E
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEV4-0005Sj-5A
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718877276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpqPUZHJaPcbpRvk9vYmCA3tW3K6p5mawsrXblCt/Jg=;
 b=K2jP4sNK+QilY1QGFXOlsjwYXSKRcmEidZehjaz8XCHHEu8DGChO0DK7psdw7lEMWR9Mds
 MjXBmDgaeeT/U/BUdCnjzKzpSlnn7qyFBqlBrchCYGe1t6h0WZsNMmgq2/gheNd+EKglql
 lPXnSgtdvK5BVCanhQ90kZFislb/Cms=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-OtgRw4EhM5Chea4y37aKeQ-1; Thu, 20 Jun 2024 05:54:34 -0400
X-MC-Unique: OtgRw4EhM5Chea4y37aKeQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f3f614e58so37533366b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877273; x=1719482073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KpqPUZHJaPcbpRvk9vYmCA3tW3K6p5mawsrXblCt/Jg=;
 b=RRIOg+hwAB9vmZvk1j/tvcIVJTxl7llgP0UvrduhuzlT9sNIaMwxh9qwcbGLP9EWIZ
 v68T6Z5/aLdAIp2Js5LsectTYhos1Xwt4AnahXBSXFkOyf9zPkul+HQp6WVpCWxfKXO6
 1erQZAhNQKPUM5dG1f3npQK7irZN99yZzBAHc3DE/Tu0aApk1lmRBtPnGbYJoOdZULSF
 MATvAYeYAqqCo20oohLxs8iYo7WtIw1a3z941/MkfbvWM8knaQr2fQuq0555GEph9sxz
 QFUHtx0Eg0zpkK78u9+/9JMShX9ONuIxqc8cWL+BoR9CpG2TBtti3fq9DcHEhcBYYVc7
 2NwA==
X-Gm-Message-State: AOJu0YyL2f8tPjqCsTxLMigcwaxsa9YeunC+3eWqjNAH9CsSH9fHuU/M
 VCYiPy7j14rtGSa/oB89LuTGL/25stcP82UieXqYxRQxfltH32p98eGVjOyiOMAcWKVmmYNf00n
 rnJzfDsm5tHjVzjpQ9IxP6akvVnZ9ive4boLNPeWog31mAjL7FSRWEJGxsJgtwaGkfoFzCk6+Yx
 rbXEPY0rDiBOmn4OJt1OlgJq1cGMwcmUXu84ob
X-Received: by 2002:a17:907:ca1b:b0:a63:49d3:e1c5 with SMTP id
 a640c23a62f3a-a6fab7d6a8emr274208966b.64.1718877272938; 
 Thu, 20 Jun 2024 02:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnPa8kWYdxzlFcIF8xzlOsiOrWS0SvnAB7KORyD1+Nq8cVMqjtwkBlgW+ZQYqQaSRggZdxAQ==
X-Received: by 2002:a17:907:ca1b:b0:a63:49d3:e1c5 with SMTP id
 a640c23a62f3a-a6fab7d6a8emr274207566b.64.1718877272442; 
 Thu, 20 Jun 2024 02:54:32 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd63sm749927766b.124.2024.06.20.02.54.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:54:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] target/i386: try not to force EFLAGS computation for
 CC_OP_ADOX/ADCX
Date: Thu, 20 Jun 2024 11:54:13 +0200
Message-ID: <20240620095419.386958-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620095419.386958-1-pbonzini@redhat.com>
References: <20240620095419.386958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When computing the "other" flag (CF for CC_OP_ADOX, OF for CC_OP_ADCX),
take into account that it is already in the right position of cpu_cc_src,
just like for CC_OP_EFLAGS.  There is no need to call gen_compute_eflags().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 257110ac703..08db40681fa 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -928,6 +928,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .no_setcond = true };
 
     case CC_OP_EFLAGS:
+    case CC_OP_ADOX:
     case CC_OP_SARB ... CC_OP_SARQ:
         /* CC_SRC & 1 */
         return (CCPrepare) { .cond = TCG_COND_TSTNE,
@@ -994,6 +995,9 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src };
     default:
         gen_compute_eflags(s);
+        /* fallthrough */
+    case CC_OP_EFLAGS:
+    case CC_OP_ADCX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_O };
     }
-- 
2.45.2


