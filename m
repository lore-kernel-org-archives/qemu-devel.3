Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48364C41513
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXM-0000b5-W0; Sat, 08 Jun 2024 04:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXL-0000aN-WA
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXJ-0008Jm-Ub
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCpaT2bnUFA6x8rHRoclpeCn7PmIy3X6pqFoqtygESw=;
 b=iHqAtoCo5bkBMDOvG4rcz5QdGPFFzbi13nhSXUwD3f/isIWSZVWMbPUcdK+dv4T3nlTHYl
 ZXBz2DGcxOXKq0TfZzQTs4Igy03ctkYQmZJbe3jgtHsUnanaS5+zzqyA5oJz3YXTCR88ng
 MqrGOvi0c8ivDUY2pdDvadvujG/noZk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-aYLR7fuqPeicYsquMgZLhg-1; Sat, 08 Jun 2024 04:34:47 -0400
X-MC-Unique: aYLR7fuqPeicYsquMgZLhg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6e8aa42033so63892466b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835686; x=1718440486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCpaT2bnUFA6x8rHRoclpeCn7PmIy3X6pqFoqtygESw=;
 b=rtlh3KtgbTuoNlnzZC118osRaTi6qwLQ8VKnv2t8dz9wixi/cf6fQNK54ZtCVL8L27
 OdIJvAYqzu/36D+w7pr05eKc+EAgDPrWU+NuaD1U31eu+yuuxpYgVVvz/0yM5sS85oKo
 Pcuug0O11KGA+FX6sBnEr6qIP0DV2UhVqhIAQXct4KT0d+E9ApE1qOpkfI9Cnwjr/OeK
 0q32uaHidRl42Cb0D3GG6ywjX2fQR77Pz29IzAE5knmede2DfiDi1IfYy3cfFWpaXwA8
 qBF4v2EQlLbhi5M7AOKs+waFZwVRiFtnLosa5lu8+73o8OZMQfDMTDDtwNWXWY/4fv/C
 xGyg==
X-Gm-Message-State: AOJu0Yz8/h36CIQlYmfdMU2DZ2H4JD6+LFgFUzP7NuoA1apTQmxk3csx
 VCcz2kfYU514HzUsvtK1N/ITC5LTTOwGVyuSnBOcmOa7DtcWrQdcK+hIbSYth9AJedlTdzQ/sPc
 LarskP3mvQovlCk6c7dZYCo2qtVhNuC58QP/v9yx6XDwx6tpwyNBOU6mpoLU5YegK3aPmFTLlBk
 RZ3sOK8EjrOmB0rYnS4htE2iSPW0VcD3kkPFp0
X-Received: by 2002:a17:907:174d:b0:a6e:f8d6:f61d with SMTP id
 a640c23a62f3a-a6ef8d6f7e5mr131838766b.50.1717835685992; 
 Sat, 08 Jun 2024 01:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuKaR8XqxTkKX7pDqb2LIgnf5sBW1RoIgLZXp1tD2puJy4vJaY3sggwx41E8b9GWpOOhAXNg==
X-Received: by 2002:a17:907:174d:b0:a6e:f8d6:f61d with SMTP id
 a640c23a62f3a-a6ef8d6f7e5mr131837566b.50.1717835685574; 
 Sat, 08 Jun 2024 01:34:45 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef83f6addsm109629466b.125.2024.06.08.01.34.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/42] target/i386: document incorrect semantics of watchpoint
 following MOV/POP SS
Date: Sat,  8 Jun 2024 10:33:43 +0200
Message-ID: <20240608083415.2769160-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/bpt_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/tcg/sysemu/bpt_helper.c b/target/i386/tcg/sysemu/bpt_helper.c
index c1d5fce250c..b29acf41c38 100644
--- a/target/i386/tcg/sysemu/bpt_helper.c
+++ b/target/i386/tcg/sysemu/bpt_helper.c
@@ -215,6 +215,12 @@ void breakpoint_handler(CPUState *cs)
         if (cs->watchpoint_hit->flags & BP_CPU) {
             cs->watchpoint_hit = NULL;
             if (check_hw_breakpoints(env, false)) {
+                /*
+                 * FIXME: #DB should be delayed by one instruction if
+                 * INHIBIT_IRQ is set (STI cannot trigger a watchpoint).
+                 * The delayed #DB should also fuse with one generated
+                 * by ICEBP (aka INT1).
+                 */
                 raise_exception(env, EXCP01_DB);
             } else {
                 cpu_loop_exit_noexc(cs);
-- 
2.45.1


