Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C05C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuJ-0001wD-MD; Tue, 04 Jun 2024 02:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuF-0001vk-Fy
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuE-0007F2-1m
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GddOmQhfFORfG9tr7FCmbGqF9ZpbvN878cxtrbolbpk=;
 b=AvXKQ8l2kMrwdO665qkJ6STkNgliTMwuvYtX4hCZ6Tg2n+Gpj5ymzxoOA2E8SXZdoc/5rs
 WYpuEz4y3mxxErsMdnVMIsKrDdDhERXSfMWcscKhDzBsCGDCVUN5cHT58pVthAQwW90YFd
 kaaBYW2hrQNNkF6nCDSBeQDC5jyWVyI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-dLELeqeDMimLeNR7P8DAyw-1; Tue, 04 Jun 2024 02:44:21 -0400
X-MC-Unique: dLELeqeDMimLeNR7P8DAyw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a2fb28a23so364397a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483459; x=1718088259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GddOmQhfFORfG9tr7FCmbGqF9ZpbvN878cxtrbolbpk=;
 b=eezPfgQKxprucopD+lcAylV/6CWXOq/UUJB8dQK5EaVhN277btNTQXTFyM7tkTV3tK
 ld0LAr1akozAlUh5RFWrCnQJUHChDZV6NP/1+LCS6PA98OsqqcsRnMx1aNmtUD0Ve8ml
 I3+7zExOqqT+jx6upIMdYFccZQRIesHp0cOHaNmAfaO9nDnJz6ikhUIBucJ5iCfdINpo
 mtfA0MP1zz6SvYpNokvwzKW+I/BiK2fVBcuPwgGOsv02/3xPDcckpZBxa8MQqtKYd6qu
 K6JtKrK5eIyPKWfn1On7I5CPPVpyGrQBm1V35UeWzjgAPhcQZof5WNfiUhaJ1UaKH9XI
 173w==
X-Gm-Message-State: AOJu0YxeC+hyejwx/Gtupg1mbBVMqtj/Y6HZjqffcylwtLzVvHoxeCZZ
 gAV2Ftx9ciT+XEIlQP3AzCNFlO/yDA+Gn/NbtQMJ5PS7UIORv+A1t7HKBWm3CHW+F1FlsWK7Or4
 WuBqvXLxucaM/pBOCBccSiI0Hvl3rLF6tlNaRsv7AiDmKtaGbBzhYyruQDRt4DI9OStoroMmOpA
 OvvQ0DuzKpro3tkbpu1BGdBM7NY32hAgwXKpzR
X-Received: by 2002:a50:d657:0:b0:57a:33a5:9b78 with SMTP id
 4fb4d7f45d1cf-57a364496famr6712362a12.34.1717483459105; 
 Mon, 03 Jun 2024 23:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6qTOubZSr3iChSRpbVUfHkF1qu7yCO0E5Unc72e0Mhg1Q1E2SpwpSkCHAFe0ltklZoaeigA==
X-Received: by 2002:a50:d657:0:b0:57a:33a5:9b78 with SMTP id
 4fb4d7f45d1cf-57a364496famr6712350a12.34.1717483458700; 
 Mon, 03 Jun 2024 23:44:18 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c6d301sm6675233a12.76.2024.06.03.23.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/45] host/i386: nothing looks at CPUINFO_SSE4
Date: Tue,  4 Jun 2024 08:43:26 +0200
Message-ID: <20240604064409.957105-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The only user was the SSE4.1 variant of buffer_is_zero, which has
been removed; code to compute CPUINFO_SSE4 is dead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 -
 util/cpuinfo-i386.c              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index b89e6d2e55a..9386c749881 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -16,7 +16,6 @@
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
 #define CPUINFO_SSE2            (1u << 7)
-#define CPUINFO_SSE4            (1u << 8)
 #define CPUINFO_AVX1            (1u << 9)
 #define CPUINFO_AVX2            (1u << 10)
 #define CPUINFO_AVX512F         (1u << 11)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 9fddb18303d..18ab747a6d2 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -36,7 +36,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
         info |= (d & bit_CMOV ? CPUINFO_CMOV : 0);
         info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
-        info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
-- 
2.45.1


