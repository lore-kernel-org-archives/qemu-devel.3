Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4209C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu2x-00005l-Kn; Sat, 22 Jun 2024 02:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2v-0008WT-Tr
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2u-0006OX-CY
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0F40cqKCPHJRg9Bf8XAVVDWTEv30OQa6Reu6MXFFvnU=;
 b=CbQalDq9XBLxGpvEjQqMmkAXcFd5uplwUQrCJjYHRc8qeFoi/RNoPrLufzPMkggQBOd3+2
 4j8RindenXlKhbb+fifMgkMs8PXLFVYw6G3S6BX0VOiXKNJyiy/Zc5LoO9ygY1cc6zeoMI
 S8Wy4nqcgGu84cFXKVsv33P00A0YZwA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-JqOsH3VqNA2b281slafHLw-1; Sat, 22 Jun 2024 02:16:16 -0400
X-MC-Unique: JqOsH3VqNA2b281slafHLw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6fe8b2bcc4so6651266b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036974; x=1719641774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0F40cqKCPHJRg9Bf8XAVVDWTEv30OQa6Reu6MXFFvnU=;
 b=e8FJW4W8GmaghAHg95A1N49TepBob1KTEw0oF1PQxMmPgOEuNB6JeFKyIWWYca25m/
 xpZsbMuqg5tefwwDf2vLzhxm/Z8HyUA4qjNB4y0zT6gb75OHWf+jN+IVGfN5hjljARkp
 nqI6iaxU7VJqP3cT54QrhjX/DwJcuHt1Uirq6GDRkPAqJKFZE0FNDGX1v4Jw0JOpryQl
 /slfd2YPz51v8sqaHxiE6WqJ0No0ppsupRBmuA4U08RFhdT2IRiX9nYgXqddyFGy8eaf
 QG2yaRJjvjLSsY6xs1Zi70+yZiRnXrYR/fMWdLLYu/YQD/QpCH8WWbuV3tfanIfesYqO
 kicA==
X-Gm-Message-State: AOJu0Yz15LX+OPKUxAT+Ugy2S22Q7/5pVc7eP/D+l/a319s7AaX/3OXw
 1q/XTbfDUmLhGsabaV6BAKtvbrYqMSVgduupjTr3VkIjzrXyXFn5KwAY0PzEOv4kLMNx4Djz5Ww
 fKx64MQAXa5LV2MfaZXAv/A0fyidaDMm5EUYtmnz080rFiumv7rc6b4L55a+QIvBqVH23vNK1Ck
 jvsxzmi5+kKBL+weVZOMAqgpPleZ4asr3Os56r
X-Received: by 2002:a17:907:c249:b0:a6f:b67d:95aa with SMTP id
 a640c23a62f3a-a714d72bd9fmr16227366b.2.1719036974308; 
 Fri, 21 Jun 2024 23:16:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYqXklko0zhHBsxWlMphzJMtieTUJ9nAbSKQo2KaaZMQCHb4RUEzudr59F0WZyXAUPUM9wZg==
X-Received: by 2002:a17:907:c249:b0:a6f:b67d:95aa with SMTP id
 a640c23a62f3a-a714d72bd9fmr16225866b.2.1719036973955; 
 Fri, 21 Jun 2024 23:16:13 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf560746sm155618266b.156.2024.06.21.23.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/23] target/i386: try not to force EFLAGS computation for
 CC_OP_ADOX/ADCX
Date: Sat, 22 Jun 2024 08:15:40 +0200
Message-ID: <20240622061558.530543-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When computing the "other" flag (CF for CC_OP_ADOX, OF for CC_OP_ADCX),
take into account that it is already in the right position of cpu_cc_src,
just like for CC_OP_EFLAGS.  There is no need to call gen_compute_eflags().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


