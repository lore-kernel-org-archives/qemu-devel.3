Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BF4CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEG-0005lz-9v; Tue, 14 Oct 2025 09:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDw-0005TT-AC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDt-00013r-Am
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7FvYGDrbnzpa7OItG1//SbTNo4zP2HPygbU6jXz7UU=;
 b=A1gMw1KbIjZiRkpCoJTd1iwxPHOt+fUbT/SLUAPU/FfUfr5NojYww1NOXa5T3fGjd9oQ+K
 zify7386umIbNuK5PPelLLm81q9C+koy/FVn9/wBdoJ+VkRaF0m5ytRlNw7Q3JXizoRD0z
 URKUGI2uxhodl5fdZvMLsiy/rEs8r18=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-3Vz6BQRHPkCLv_5LCZEUHw-1; Tue, 14 Oct 2025 09:37:48 -0400
X-MC-Unique: 3Vz6BQRHPkCLv_5LCZEUHw-1
X-Mimecast-MFC-AGG-ID: 3Vz6BQRHPkCLv_5LCZEUHw_1760449066
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-426d314d0deso2307224f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449065; x=1761053865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7FvYGDrbnzpa7OItG1//SbTNo4zP2HPygbU6jXz7UU=;
 b=K5V9PaN/yhaVMeocW0HbTyzCOs+UBuArFjsg0c4C7qfCoCWeGd76RK5drPPCodQZ1D
 d7JIIpNi/Qu0C69MMSyPYKHXaWfi3RVK1xsrtuuzh1vkb1eoOwFLcsYY1pne3hIT5092
 JWf6iOopBaH0vii063LNFWPl8WdFNk4GFr0xVN/If2JsAvahMh34JZ9KQjViguXrtUgZ
 b5oXALviuBXXtD/5pv49j5wL3X/dwzzMyLcGXLDT5Ixym9uwulnd3O8l/IPjJ8AIzQ5j
 GDT/5RyDUftnHJO3Qj5fKObIRWFhJSOYCVNHzbRVoOQSrv3W3Hb/BycbJiRgCR6EYitZ
 /oyw==
X-Gm-Message-State: AOJu0YzHJItkHf116XzYejFp4fZ4GplXsyR5mzTXseZ78nUlpmULG9Uj
 Cod0FRHAxIr7zjI+vK9UlrSAHrFcdhSp07F/958jnUV+gHSoCgioV8VrndkEqhYlYIVzF9lwtwX
 wAWgXu2G1bwUva/kkh6JCP8ScOiuaL1g1KmRXetD6HpxKSKzpc+pGRV18koPHwHkq/qCbUSmJhi
 LKN3ABpwv2BnqwlifGOz3Ypkwi/4JaFGoQMspjoExg
X-Gm-Gg: ASbGncubDnkjJrGX5Csq85QETlkaE5VvW9DpfId863FDfa2nEnaZ/kVCSRG8tLgwrpL
 kJhssqs8KNstJ3fX1AQJRNRtPD9gJs1X5hirCR8+cHrqRLP0NJweS6U5okUY4t0waRk0JZgqgXO
 ntz/alfwLOhUXe/lpJwdEZT+X5QHCaFS13zomK9X7hmFERt1KX4orRV8XfVaizE1BvBQq8cTTVe
 0agKKl0GXnhNhTJE7yKne3NlrHIdgo67Q+/zUbRJrUOlyAsvvlFrHYnEdGr0F/4hX+K42sEsPX5
 i55DeWCREsmQcXpZpad7W7hkmL/Sf/zytdelZZfBudeMYduEzaETi76zGfp4xB4SwdZB1kcHUgK
 FQuPOPrQC7bHbWg0J4BUkZdlA66obuusWSprByncb/tk=
X-Received: by 2002:a5d:64e5:0:b0:426:dbef:acb9 with SMTP id
 ffacd0b85a97d-426dbefae8cmr6225659f8f.59.1760449065289; 
 Tue, 14 Oct 2025 06:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEplO1pLbjZe1RBpX4n9mG3SzMFiTOsTTJ6T496fJkUx9SSh/t0dSNlIbQw9ibWdORIcge1sg==
X-Received: by 2002:a5d:64e5:0:b0:426:dbef:acb9 with SMTP id
 ffacd0b85a97d-426dbefae8cmr6225641f8f.59.1760449064873; 
 Tue, 14 Oct 2025 06:37:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ed61d31esm4698970f8f.52.2025.10.14.06.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/28] target/i386: fix access to the T bit of the TSS
Date: Tue, 14 Oct 2025 15:36:57 +0200
Message-ID: <20251014133713.1103695-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
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

The T bit is bit 0 of the 16-bit word at offset 100 of the TSS.  However,
accessing it with a 32-bit word is not really correct, because bytes
102-103 contain the I/O map base address (relative to the base of the
TSS) and bits 1-15 are reserved.  In particular, any task switch to a TSS that
has a nonzero I/O map base address is broken.

This fixes the eventinj and taskswitch tests in kvm-unit-tests.

Cc: qemu-stable@nongnu.org
Fixes: ad441b8b791 ("target/i386: implement TSS trap bit", 2025-05-12)
Reported-by: Thomas Huth <thuth@redhat.com>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3101
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 071f3fbd83d..f49fe851cdf 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -456,7 +456,7 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
             new_segs[i] = access_ldw(&new, tss_base + (0x48 + i * 4));
         }
         new_ldt = access_ldw(&new, tss_base + 0x60);
-        new_trap = access_ldl(&new, tss_base + 0x64);
+        new_trap = access_ldw(&new, tss_base + 0x64) & 1;
     } else {
         /* 16 bit */
         new_cr3 = 0;
-- 
2.51.0


