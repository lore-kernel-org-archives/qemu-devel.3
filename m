Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DA9C27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORy-0003Uw-TN; Tue, 04 Jun 2024 03:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORx-0003UF-Dt
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORv-0005fD-4S
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmcO4ui07BBe0FjQAMjYfYJsiVn0613DcSvAYmLll7I=;
 b=MRakWEHPV3LNTeajKE6B4eiSGxZL9NB8o3+N4mC6g8GIU4WcigshvyXe4PhU8WSpyPe0Oa
 BER9AYZwZqERvFXbwpsaV/bVWqrF7ZEksaEIJZ2EhCmSi0wabslYux8GkYDcB2fynJdaJ4
 MFfkTs/1PtkZlaHx/gsWRMKjyogFNdA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-FNWUItZzN92CUqg5shIWUw-1; Tue, 04 Jun 2024 03:19:12 -0400
X-MC-Unique: FNWUItZzN92CUqg5shIWUw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a280de2d2so959023a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485551; x=1718090351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmcO4ui07BBe0FjQAMjYfYJsiVn0613DcSvAYmLll7I=;
 b=PeuWuRlgZSae7oHxMugPjJe0RQIBTQ9TcqSnU5DnDY9hvYibVJGLl4rxS3xQbswXoH
 HVO2k41kiJ1/GLYmTnsQQBNV534LbFUJHVSLnSEbJ+Ge2qGefV1aHgifzYCaIzUl5D4P
 UdOXX4T8TGZpbye7gq7uG6DM7Gr3sySeEvgarh7zA1xxdwSd8vn6/mMc/0pB30U1OIzU
 3YeVlEljRDdiBcgtCKYzzMQLgRqwcFfJLEQFNjPPGx4/0DI0AiM/TJD1UHiwE/LQ84Mm
 AzpXhUtP/p/+6z+BN/emzqC0LPUhipiprSp9RYJF0HRc32wGjl7jVowJKBP04AZ7wlSu
 MbDA==
X-Gm-Message-State: AOJu0YxiMRBzBGHRgX7mziTiLp2p814XIxHBVPB9RPfTSrQE33PraqUI
 /5BTB6HEDOpZFH3oWPoAaTR5+MF+nVhkgQXVkWKKSetUiEZPhfczdGsBQVrWgCtvZ6WNXWW3WsJ
 jogQaIG2GWyiaDKfpBYJ8W3oJcb2m+OUbZr5girob62+3CHEBoileBIXOgJY699p2zaYosvW01M
 JVKUVbZpHBw36sziTV4CRmHeCYUYpPCCFW6Lmd
X-Received: by 2002:a50:a455:0:b0:578:649c:f7f0 with SMTP id
 4fb4d7f45d1cf-57a361ad344mr9758312a12.0.1717485550915; 
 Tue, 04 Jun 2024 00:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYb4sk77q6MLomxoIGFTwZAm3Y2EODdLD3YlFoe+WcxlIYFBaiI27cGyOsjYacJpJCkuql7A==
X-Received: by 2002:a50:a455:0:b0:578:649c:f7f0 with SMTP id
 4fb4d7f45d1cf-57a361ad344mr9758296a12.0.1717485550556; 
 Tue, 04 Jun 2024 00:19:10 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb841fsm6900380a12.34.2024.06.04.00.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:19:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 11/11] target/i386: document use of DISAS_NORETURN
Date: Tue,  4 Jun 2024 09:18:33 +0200
Message-ID: <20240604071833.962574-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604071833.962574-1-pbonzini@redhat.com>
References: <20240604071833.962574-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

DISAS_NORETURN suppresses the work normally done by gen_eob(), and therefore
must be used in special cases only.  Document them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a9c6424c7df..2b6f67be40b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4761,6 +4761,17 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
     switch (dc->base.is_jmp) {
     case DISAS_NORETURN:
+        /*
+         * Most instructions should not use DISAS_NORETURN, as that suppresses
+         * the handling of hflags normally done by gen_eob().  We can
+         * get here:
+         * - for exception and interrupts
+         * - for jump optimization (which is disabled by INHIBIT_IRQ/RF/TF)
+         * - for VMRUN because RF/TF handling for the host is done after vmexit,
+         *   and INHIBIT_IRQ is loaded from the VMCB
+         * - for HLT/PAUSE/MWAIT to exit the main loop with specific EXCP_* values;
+         *   the helpers handle themselves the tasks normally done by gen_eob().
+         */
         break;
     case DISAS_TOO_MANY:
         gen_update_cc_op(dc);
-- 
2.45.1


