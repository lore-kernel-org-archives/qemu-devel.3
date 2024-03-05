Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572E7C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMx-00075I-Ct; Tue, 05 Mar 2024 02:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMJ-0006Eq-RW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:13 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPM0-0005rr-KE
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:59 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so24450195ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624206; x=1710229006;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4K2x48hCLz15Z0ohdnVCY+8gn/iTK7Pup23XDb2mA5k=;
 b=B7MQ6KHRANffWda5oEemivhrpN2wQBCZ3Bp/OqASv1RsYOnBzxKroaOirqVZvDz67E
 GuELR2AaXCyp4tMWE7OM4dpwMyadXN/jVgHkXAgfD9+1pwDUuOUf9X2chLYtjEanHyEc
 vOSe06DpvjU6eeIkM4Cc+5zhdsrGMRpDdmR+bwh8Pdlwb5p7awAjLnJUDiXOfXhz6Cxc
 +csvH7ouimHMe31VhYKXsCCqXWPd64g5ocOcclh5M9VAR9ColloI031D6C17y5Yh8zgG
 gNipTWhuBzsiBDKQQ3uFF5Z+gf7f6CZwpMS7tZ1qiEZcUxAXy2VT4ngEU75Rv/uYOYUG
 dpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624206; x=1710229006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4K2x48hCLz15Z0ohdnVCY+8gn/iTK7Pup23XDb2mA5k=;
 b=nuOH86H7rQYyJIl2Nl22Ezh5KG4cLnu7iyTCcYfZaKNB+dXontQ2jCmuDGANBAJJeS
 VPXjcBNDNdj3F4Xs1N+XtQ5pOJJPosrHP4yL3GsTxeyMP9fl5cnt4XJFLSdrAV7Jyj7M
 l9zWoePwJWsmC6AJv07i+ZZIPwn94F7ztQl2zWSIoafsLs7Upt8c7mWUGDO6/41u1fHT
 MLjB+rPjtbLH9XK2IiPg/EgxNKNZm7TOCiQZ55NyBrrwUYmT/Z7H+bu3pFPTd9ZJoGeJ
 Dg3iT+5j3wQo1Ia+OQlr+R4oqjxUDP9R94yyA3J3gcDB5jZKtws8IpiwGA5Mg190qPYt
 IbTw==
X-Gm-Message-State: AOJu0YxKz+BvojeSRnuf6s5PQxpZ24HAhzvfW9VecM6sTtfbuXyppt5x
 J98f+wBcPc/ScXY1DclW1UgVones1BxogBfDB70CVIgj9HyxOpKaa/OKrrkTg0ZrfcwFUfq6Sol
 w
X-Google-Smtp-Source: AGHT+IFhBmrVRJBwrGq//M6YuscsskLRUFHK1JNrL6teAky6kDTiFNUegy77uyzKmRONX/P2Pon2PA==
X-Received: by 2002:a17:902:dac7:b0:1d5:f36c:8737 with SMTP id
 q7-20020a170902dac700b001d5f36c8737mr1042755plx.68.1709624206502; 
 Mon, 04 Mar 2024 23:36:46 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 c5-20020a170902d48500b001db693d89fdsm9801068plg.179.2024.03.04.23.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:23 +0900
Subject: [PATCH v2 06/13] contrib/elf2dmp: Always destroy PA space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-6-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Destroy PA space even if paging base couldn't be found, fixing memory
leak.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 140ac6e00cfe..25cf0fdff724 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -550,7 +550,7 @@ int main(int argc, char *argv[])
     va_space_create(&vs, &ps, state->cr[3]);
     if (!fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
-        goto out_elf;
+        goto out_ps;
     }
 
     printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);
@@ -635,7 +635,6 @@ out_pdb_file:
     unlink(PDB_NAME);
 out_ps:
     pa_space_destroy(&ps);
-out_elf:
     QEMU_Elf_exit(&qemu_elf);
 
     return err;

-- 
2.44.0


