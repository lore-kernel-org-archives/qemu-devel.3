Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C91CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7a-0006BS-9b; Thu, 30 Apr 2026 13:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6v-0005NF-5K
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6t-0004Zb-Bx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfdehV+v0vmeOCbIYBt0V6h9RQqUv06JzQT0cRmQQvA=;
 b=iy5OXXWpvsppPzGBjOurcOdI2vGDRu/gaeMIXIDxT07H/PoUNtoUzWvncSqKJ7i/EVvcVD
 8fcQ10WWTUqEcGaz5isdKS0Bti6hZvmJ0XpHc2sj/jgRdEdrludYiZE6/CLXcGkFatWbGw
 4iAQku690UhdglbRi2zSuCTh8Yd+BZQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-5qlyjkpGNDaMYOTQEhc7Eg-1; Thu, 30 Apr 2026 13:23:33 -0400
X-MC-Unique: 5qlyjkpGNDaMYOTQEhc7Eg-1
X-Mimecast-MFC-AGG-ID: 5qlyjkpGNDaMYOTQEhc7Eg_1777569813
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca3b7b536so34564096d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569812; x=1778174612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfdehV+v0vmeOCbIYBt0V6h9RQqUv06JzQT0cRmQQvA=;
 b=NDpZMVKHCRaGnVq82lGDpC4m8UPSmr0yGGLmnmjOCHLFMHUzNc6vW3aU6ZLQbbEX4e
 vTX4ETz6DrWua1+tjhMpWRg1KWRN9vUQLqaeVvt0BDd+5DeRAoIKQH+6HD3hMLgtIUbx
 la6n0yLbfPpj/gKQnVvtAbeJhZi3Xi92bDKymqAdk1D9y6acisZHj3DBmgJBDSiV6QS8
 rZNk9ihTp9EVazn9//Ml50xN+kPrhx826xp6XXCRBISKff85tG+8afPlHRCdjzblVTRp
 OIKJGupZ4y++DdGcEpRQQcW+QDGEFtcl+KY1omV8Atk3nJh51Aqd+e/qfJ4CEfxk8nx8
 bONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569812; x=1778174612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hfdehV+v0vmeOCbIYBt0V6h9RQqUv06JzQT0cRmQQvA=;
 b=KLAeGn+6dxC9yeliQYLmHbud2ltTKGxA8LZ4UYbGNBYtWZHkitrqZX2eZmX9iufrU0
 1Yv2ptprQ3us+D5buwjE8RR6c9/dKIap1aovkZV4goks1nFdIolPGhUP654Z9PtaW7HV
 MPaTpR2aLZ8EmsJjd20qlD7VGSgVPcTNprUH1TADP3pCVgCUwXTRVg5x77OtagFsTi1D
 3qkfsP8cPTuHgiDpt7DYGjDDkpu7xm3GHRCDGkcwZ2lHAC7k+bbr1g+2AYjM6hopNx5v
 4bSvLx4GplOGyn4dhDJVG0IC3rIq72RIyK3iNLcOqgWtsMs7kxLs/HD4uiKb/Iyp0+/N
 s7gg==
X-Gm-Message-State: AOJu0YwJn/1fxzXjW3gx2v9OBZDSvDGIwKb+a1L9uJKUh2ROnKNygtBM
 HzWeBK0Awmbxw7AwRJRTd2LyOefzT0vf9wMMl58MnFiz3CJ3Xl33En1xChIci+FxQiBqRL9LTKj
 1E6ATSafe5oKImQP5dtaC/oeAoFAWVe0EQ5eckUNBCEhld4v4a78EtkEwVVbiVUdIaxBQ0b5pec
 AkMLnezvD0mY3nCvsH+1179knFlJVsznZ1YQ0x3Ayv
X-Gm-Gg: AeBDies7Lt7Qi7hoqW876S2PT5fgBNFhIZtVpi1qx3EraPPdG/2LKVxp3vNF+PSgg6L
 Qe1c7qbePsyCkVBm4lndbatsO9QJOIGfqdC6LLUQM3lzCZoNwBrHwyA1g1Eq1avSB4GuyVk23uv
 /LpsqKfoT4naWByjClxilB2HPocnYmgyZCs8PCQCghXT2L5rI7/Js31af9fekFFSw0vWvhS1/bO
 7N4XecFQuszIQqYBjalmOmVvL/Kr4PMfoaRx/E9XKKjel87YUgpeyv9P0DPkr2+/IH4G44indWc
 3LdRsEXdF8p6vrTQSEyKjjJjYW9Uw61VI7p5FGQ+1Tj8rtgACSbs/K4+8Ca0psbayyHiabeF5ZY
 9cu1R6+bKuNh8nGuQleKdB5fmOkXntvLpKufa9qjkEarnr0qyTvE94Mv70OBbGUrZZ0S48qntgW
 ESYX2sIgD+wCmKX5sCFF4x0ClhJMG1SRYLsdE=
X-Received: by 2002:ad4:5aeb:0:b0:8ac:a2db:5760 with SMTP id
 6a1803df08f44-8b3fe7f8c82mr53504716d6.33.1777569812221; 
 Thu, 30 Apr 2026 10:23:32 -0700 (PDT)
X-Received: by 2002:ad4:5aeb:0:b0:8ac:a2db:5760 with SMTP id
 6a1803df08f44-8b3fe7f8c82mr53504316d6.33.1777569811787; 
 Thu, 30 Apr 2026 10:23:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff43b896sm23077126d6.25.2026.04.30.10.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 27/58] whpx: i386: enable x2apic by default for user-mode LAPIC
Date: Thu, 30 Apr 2026 19:21:33 +0200
Message-ID: <20260430172204.1006673-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-6-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8f03616cb97..4954e0557a7 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2366,11 +2366,18 @@ error:
     return ret;
 }
 
+static PropValue whpx_default_props[] = {
+    { "x2apic", "on" },
+    { NULL, NULL },
+};
+
+
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    x86_cpu_apply_props(cpu, whpx_default_props);
 }
 
 /*
-- 
2.54.0


