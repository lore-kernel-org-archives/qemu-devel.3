Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DE8C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORg-0003Cd-1H; Tue, 04 Jun 2024 03:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORe-0003CC-Nx
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORd-0005dG-8D
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Omj7V/9neG3Skvv8V7gZhHDNOP50DtvEDEa1OSvAS0I=;
 b=A0mjk/L1SvU4vLUkmMoQz6nlPNSiOt0W2xQ1rP9NEotSJJQs21EJihrk/Nf+iyOmvzcd1g
 p65+dBr0MjrNFSFpSetzIsYrfV1n8unjmPP/UR7yDd8IHvLZNUBY7e25JjlnXhhztRPbgV
 1jk6OUkWfJw/CqOhMMuOfNymjguZNDc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-JkrlGbTJOJ2yd_9XeoYcOQ-1; Tue, 04 Jun 2024 03:18:55 -0400
X-MC-Unique: JkrlGbTJOJ2yd_9XeoYcOQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a49b8a27eso280391a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485533; x=1718090333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Omj7V/9neG3Skvv8V7gZhHDNOP50DtvEDEa1OSvAS0I=;
 b=wCw5DjyC6l6rz/1xc4yjaSnFRZvIxef7obpgjOZQnIYZtuvqlBGH3X+IxKa3TooGhq
 7J+VyZ1/bXVUmXnKQXnJwiDlSr+7JcbGVylXW1JTDbYWLvJSr+eO/dd5dtMKgZ/Qcj9p
 y3Ie27X6PsxtNPJ3IfzcJFExKKY1O0cO3UGRw9iv96cbjsAoVXT1Jsddpq6AbgW0+AR9
 Yo8+V8anvyA4vRcBUhmGmPaMTrvKizUsS0MaF++sR6Q78suIYtNPzr1XHqKa9cIBcmy6
 qYlGNgapoZPL7/hbk2MNyg3DHUzA4RhwPQZc4Uk1ls3Z2NMYrQR1J8u1xQY99irO+qC6
 gIdg==
X-Gm-Message-State: AOJu0Yy3G2v8TKbExa4IqMt279CJdimCjrKOweFp/uKwe3+Y5vtnLVdC
 TQ3ZY52V/6ozrV+yaP+NzXTY8JXrNdYGO10xOxz5y4f9Vzd80nYPJfCfan8hZRlwuV9bZdOb0KU
 SEB6rej6X1o0ezdmIf4G1A2wUKL8hiGhtbs/dxKxgztMjuxl09ZUJQeF9i5oSSD0pEhSy6PWIlx
 UzS3T3uIoNJTA2+/2wRG+7gnq8I/3aZt3NMMKm
X-Received: by 2002:a50:f61a:0:b0:57a:21ac:cffb with SMTP id
 4fb4d7f45d1cf-57a363c0b25mr6727881a12.6.1717485533094; 
 Tue, 04 Jun 2024 00:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCezG3hGaTMkTnK57x1SObQ44iKILGwexCJljPWHBvebFJP7okSozYhSVbwBCwbI5SKYGCOA==
X-Received: by 2002:a50:f61a:0:b0:57a:21ac:cffb with SMTP id
 4fb4d7f45d1cf-57a363c0b25mr6727865a12.6.1717485532602; 
 Tue, 04 Jun 2024 00:18:52 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c6d301sm6731711a12.76.2024.06.04.00.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:18:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 05/11] target/i386: implement DR7.GD
Date: Tue,  4 Jun 2024 09:18:27 +0200
Message-ID: <20240604071833.962574-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604071833.962574-1-pbonzini@redhat.com>
References: <20240604071833.962574-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

DR7.GD triggers a #DB exception on any access to debug registers.
The GD bit is cleared so that the #DB handler itself can access
the debug registers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/bpt_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/tcg/sysemu/bpt_helper.c b/target/i386/tcg/sysemu/bpt_helper.c
index 4d96a48a3ca..c1d5fce250c 100644
--- a/target/i386/tcg/sysemu/bpt_helper.c
+++ b/target/i386/tcg/sysemu/bpt_helper.c
@@ -238,6 +238,12 @@ target_ulong helper_get_dr(CPUX86State *env, int reg)
         }
     }
 
+    if (env->dr[7] & DR7_GD) {
+        env->dr[7] &= ~DR7_GD;
+        env->dr[6] |= DR6_BD;
+        raise_exception_ra(env, EXCP01_DB, GETPC());
+    }
+
     return env->dr[reg];
 }
 
@@ -251,6 +257,12 @@ void helper_set_dr(CPUX86State *env, int reg, target_ulong t0)
         }
     }
 
+    if (env->dr[7] & DR7_GD) {
+        env->dr[7] &= ~DR7_GD;
+        env->dr[6] |= DR6_BD;
+        raise_exception_ra(env, EXCP01_DB, GETPC());
+    }
+
     if (reg < 4) {
         if (hw_breakpoint_enabled(env->dr[7], reg)
             && hw_breakpoint_type(env->dr[7], reg) != DR7_TYPE_IO_RW) {
-- 
2.45.1


