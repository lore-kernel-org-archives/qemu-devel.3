Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287EE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQv6-0004CX-HX; Sat, 27 Dec 2025 04:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQv4-0003za-OL
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQv3-0006yi-70
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIaH610boA68Cw25EB3fW2+vUx9RyZV3yzcJ036ng3M=;
 b=HF6hHLsExwOPTPcUnj4qwMfdKT+xQ+a4lLsZ3GHnHL1BKp5nVscKNJyAZMVgfZ8Oz1GeDp
 ORTXp5Be09EV8gNdBMJm09XA/RSFrkEt7AQtF99y/UpnBPsTIcntGdrFJZDn8sANUNAE2+
 iWOMvjEMdFl+JXDtkDN28n/eZZeGbmk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-AvYUGmFiPxqQzwsNXOAcpw-1; Sat, 27 Dec 2025 04:49:02 -0500
X-MC-Unique: AvYUGmFiPxqQzwsNXOAcpw-1
X-Mimecast-MFC-AGG-ID: AvYUGmFiPxqQzwsNXOAcpw_1766828941
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso65567095e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828940; x=1767433740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIaH610boA68Cw25EB3fW2+vUx9RyZV3yzcJ036ng3M=;
 b=nw1RqtDWxxk10uUurnY1bYJePt7mXn0wbL6iOIzkRZr7+p2BKkbo/Pi8HEmOywfv2H
 fCF1bosoI1v2Bp55umk1QeQCz98wQIMBNR8VfGXQ4p3S9VaFL0TBikQTY5e4mLw2IGQo
 qgmx+ZzDHw7+5ImyjGpV4AlF+JLY5AZ4qeax+cjDIF/jbkvCIzKKlbK67cGZPgZ4EtKv
 lnACfgJ8pbtGotS5KXKQCkmDcIv26JiAB1X8DzjbMWJIAc9xt7qmjKfbmjBiGNNoSkqs
 V8Dk7IWu84TTq7ml1xJ//x9lS+4QpXQAy82Pe4x9Ox6jTRbuaxQctajEK3OTuMIRn8jp
 2O4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828940; x=1767433740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hIaH610boA68Cw25EB3fW2+vUx9RyZV3yzcJ036ng3M=;
 b=PDnajlRsRgZnQ8/AGI2w8+QnhHSilFQpUCKcleZ7KttaS+et6ME775qKCe0FlncF3C
 eMoTur2T7NZ2wNqWEl9vWHybD/x/PjCxzAob0OgJbp3RCWs4W5Vdg9jLbqf0qj5cpoBz
 IVKyoisV05eE22sWE175O62II+Y/+uWcVpUzkYFoZnFcZe7JYldNdulDUjzh3GwIORCS
 EJC1+86pIjv0lGe5f1uXLhXTZxCE38PJsuyCuH8Z9bRN1m2uEqKH8+r1lEkGPRrfBhIz
 Vdxw6QxJ6WYsXwJrhsbIkFt3BwclFBDpovaCZgkZKWOSj78WXQUmlyZhQX04F8N6zzqr
 Be2g==
X-Gm-Message-State: AOJu0YwWZeHdcK39F+YeClfa8gBm7e/LMgA1LF9pIY5s+JDiPj81OqHM
 NrOJ2EejfiekRL+Pde40PVhC68u9Cczr6WZ+1kTPx843O5tDyDmi8y6giJW/1sIHGSJLj7UEAqi
 I7XYTJHoh/uRHwDRX+VphVTJd/ZVfNDVmx45jCAjtjOBAa8vsVLxKtSxEhHTInBKWbkqRMSIGWu
 Sjqz4lQUoSmty2ZHQynn9d0nAeKQhTdKjiLoCGL22q
X-Gm-Gg: AY/fxX5tIMzMlsC+ht+THpJ9pHyKInmZmH/DFA82/WZkpjylrOo6OmQwY53RjXY8lTu
 egUzR6FJIYS4vnxaQuNmfe72dA4dbYbR1RWvPDQBLHLICNR6Kx5cMQRcbfJDoQiF+bwysoHLLv7
 kAsRciL7roft1NOTTCqUI+aL8mOruHxTydIyoG0YJN5WSClYrezUv0GvFQ+r+P7sJT+R+zopsYM
 Md2bgWF1GXnr8mSxo7928gkAjIbmeugyFb+32zVfLZCMLAJO1xknx7tS4RkECUDcExmYM0IdMnz
 I4D2oJbJpXs9aVGorUzhjwzXUzwXtZsOHaF0fIAjfpDVEciizGhJwQawQMRwuyM0rCjQ7jWgC66
 iETBLykhzjm3gcgc49S8DQ5SeW/rLeMLsoUOrLlWgzxnu56zpDtWrK/+/FEY1f2s0nJypESVvKq
 L6ZqPGXgRQ/Z+s6jY=
X-Received: by 2002:a05:600c:8107:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-47d1959441fmr284150325e9.33.1766828940110; 
 Sat, 27 Dec 2025 01:49:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2hfAu96aEX0mwkZfxPViwFEbMDzY7xfr2oY7jQhh83oApdRpcTn+kl34I1reovWlz+REdxg==
X-Received: by 2002:a05:600c:8107:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-47d1959441fmr284149895e9.33.1766828939113; 
 Sat, 27 Dec 2025 01:48:59 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432613f7e6esm38863255f8f.21.2025.12.27.01.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 099/153] i386/cpu-dump: Dump entended GPRs for APX supported
 guest
Date: Sat, 27 Dec 2025 10:47:04 +0100
Message-ID: <20251227094759.35658-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Dump EGPRs when guest supports APX.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu-dump.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 67bf31e0caa..ed8fd363c6b 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -354,8 +354,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, "RAX=%016" PRIx64 " RBX=%016" PRIx64 " RCX=%016" PRIx64 " RDX=%016" PRIx64 "\n"
                      "RSI=%016" PRIx64 " RDI=%016" PRIx64 " RBP=%016" PRIx64 " RSP=%016" PRIx64 "\n"
                      "R8 =%016" PRIx64 " R9 =%016" PRIx64 " R10=%016" PRIx64 " R11=%016" PRIx64 "\n"
-                     "R12=%016" PRIx64 " R13=%016" PRIx64 " R14=%016" PRIx64 " R15=%016" PRIx64 "\n"
-                     "RIP=%016" PRIx64 " RFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
+                     "R12=%016" PRIx64 " R13=%016" PRIx64 " R14=%016" PRIx64 " R15=%016" PRIx64 "\n",
                      env->regs[R_EAX],
                      env->regs[R_EBX],
                      env->regs[R_ECX],
@@ -371,7 +370,32 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      env->regs[12],
                      env->regs[13],
                      env->regs[14],
-                     env->regs[15],
+                     env->regs[15]);
+
+        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
+            qemu_fprintf(f, "R16=%016" PRIx64 " R17=%016" PRIx64 " R18=%016" PRIx64 " R19=%016" PRIx64 "\n"
+                         "R20=%016" PRIx64 " R21=%016" PRIx64 " R22=%016" PRIx64 " R23=%016" PRIx64 "\n"
+                         "R24=%016" PRIx64 " R25=%016" PRIx64 " R26=%016" PRIx64 " R27=%016" PRIx64 "\n"
+                         "R28=%016" PRIx64 " R29=%016" PRIx64 " R30=%016" PRIx64 " R31=%016" PRIx64 "\n",
+                         env->regs[16],
+                         env->regs[17],
+                         env->regs[18],
+                         env->regs[19],
+                         env->regs[20],
+                         env->regs[21],
+                         env->regs[22],
+                         env->regs[23],
+                         env->regs[24],
+                         env->regs[25],
+                         env->regs[26],
+                         env->regs[27],
+                         env->regs[28],
+                         env->regs[29],
+                         env->regs[30],
+                         env->regs[31]);
+        }
+
+        qemu_fprintf(f, "RIP=%016" PRIx64 " RFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
                      env->eip, eflags,
                      eflags & DF_MASK ? 'D' : '-',
                      eflags & CC_O ? 'O' : '-',
-- 
2.52.0


