Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A97DC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0i-0005Fa-5M; Fri, 24 May 2024 04:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0e-00055j-P1
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0d-0000Pn-BJ
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14ZWCEFaUxfzP+sSE8uYTknx8SNfEZ//ya7oX9lpCZw=;
 b=Sm6VHOaVGojoP69mDi6NLfDNn6oYoqViYKfTqiqWZqKeTsDtna8p5/DWCv1ZqHQI6rdvhL
 d+wwsslLfD/Izh+Lf3+2HEberut/L5SxBZ87l7uxLWQvpC0cM4QzD8MF7sHsEvLn2/UXLu
 Cu6QqGOjzQNBoK14FSwFW0Zpv1eOwV4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-YixUjvb6Owa3GW2ZFP18cQ-1; Fri, 24 May 2024 04:10:36 -0400
X-MC-Unique: YixUjvb6Owa3GW2ZFP18cQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6270b93d0dso23368766b.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538235; x=1717143035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14ZWCEFaUxfzP+sSE8uYTknx8SNfEZ//ya7oX9lpCZw=;
 b=U4JCPE8UmAzLerCOV0HC5uQAKnV2Nx+u0GiwfAEFazxH3EIKWn/X+AbWB4V22vpa81
 bXMU6H5JDk3dCMeprFBfHy0hPGJXCGcG4BQI7WVCYqS0NosL0beJzt3UAl2hTOawlCy+
 w/37rmGaGRNwXblvfWBG4VvxBCRsThex0ylLvdMco0ZSHzNRdmAjmClGVxWy34DPHDly
 v71bovdQrKgFqGnDD0lXrbTj2YivhxOXHP61pY8HFM/o33W18i3vCEvPRcCm1VYy9x4M
 7GUUqRlfGkUe0Ok66h3bbr6GLVRWTc84RPjbz0YqgEfN3Tlq50jBqelc6GuTcA3dJqRl
 b7RA==
X-Gm-Message-State: AOJu0YyvdY2B7/l7KIff1YJprZS6Wq5ySb5dpNGCmZoAmChy4YX2HEt8
 6n2Di6nUgTApC9N+68SWbvy0QqXHgKXZbUz1dQq1dxyhATNmPq6ejUckxIXe48YV76sh6oKufLn
 d13lVl8m8RBFVHBe2u8KDvJYaWK/RELDvF6/TehWZLAhxF3Pql3OXro0EZEGAIvZDNPz5rjBfM0
 JBuWOjjjufm2j5nbMCLdnqBeEK2USrqve1xd+e
X-Received: by 2002:a17:906:3e0c:b0:a59:aae5:5840 with SMTP id
 a640c23a62f3a-a62651140b6mr98452966b.75.1716538234782; 
 Fri, 24 May 2024 01:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEiDuE+K8E1jszd9Jnrz4R8MMWmEUiTzckv3sgFy9FGGIYLm92VF83j5/SLg7SY1R4Ku0Rww==
X-Received: by 2002:a17:906:3e0c:b0:a59:aae5:5840 with SMTP id
 a640c23a62f3a-a62651140b6mr98451266b.75.1716538234480; 
 Fri, 24 May 2024 01:10:34 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc4f811sm90879766b.132.2024.05.24.01.10.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] target/i386: assert that gen_update_eip_cur and
 gen_update_eip_next are the same in tb_stop
Date: Fri, 24 May 2024 10:10:09 +0200
Message-ID: <20240524081019.1141359-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
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

This is an invariant, since these cases of tb_stop() should only
be reached through the "instruction decoding completed" path of
i386_tr_translate_insn().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5dae890d2b6..2c7917d239f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4787,6 +4787,7 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_jmp_rel_csize(dc, 0, 0);
         break;
     case DISAS_EOB_NEXT:
+        assert(dc->base.pc_next == dc->pc);
         gen_update_eip_cur(dc);
         /* fall through */
     case DISAS_EOB_ONLY:
@@ -4796,6 +4797,7 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_eob_syscall(dc);
         break;
     case DISAS_EOB_INHIBIT_IRQ:
+        assert(dc->base.pc_next == dc->pc);
         gen_update_eip_cur(dc);
         gen_eob_inhibit_irq(dc);
         break;
-- 
2.45.1


