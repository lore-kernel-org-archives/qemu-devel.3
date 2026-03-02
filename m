Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CECD58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwysn-0001US-LO; Mon, 02 Mar 2026 03:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysm-0001TY-Ej
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysk-0001VX-Mc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVarAN+0/DWoyUB8MLOubIRM9lTM8zyfCdEzEfZYXbQ=;
 b=OBDZ0aUH+5+SZdUejqqhsR76dChMOJRI7m6Ye6dF4FC28ctBRYoD2ybMmDwLAUqPd3kud9
 GLzHkUu5Cn0VE3wUJogrb4ej/JETY6Dci575IfLSEAUMbURG1GictxvK2y4SA9ajqOibVd
 0Tb3X8cO1x50yLbXV5e8V1gCJir+lDQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-7uWcxhPfPr6qN9w_t163bg-1; Mon, 02 Mar 2026 03:44:00 -0500
X-MC-Unique: 7uWcxhPfPr6qN9w_t163bg-1
X-Mimecast-MFC-AGG-ID: 7uWcxhPfPr6qN9w_t163bg_1772441039
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43999e04921so2653738f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441038; x=1773045838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVarAN+0/DWoyUB8MLOubIRM9lTM8zyfCdEzEfZYXbQ=;
 b=cxnbPjCAPyEjy5YR3mjC9fbEnz3urzIohHGZHv5wpR5AuxO/E+KckYwAZqCB3ROK8w
 oM29NVnwxv/pibmYg8ZCEGueto/T7mqbXPfjj/rgWCS46TUDJcBtZvESlovj3LYzVuDh
 BtKVQykQNpbGLHUYNbIWMekm43rFn9vceIA3TQ2mAr8eYRM/vX8IGo9bMQ3lZ8VRHnwn
 4C9EKK2MCB7Ca52tGA2XDkEc5Bh9RrlAGU1c+XHRjyJW2mltZKKb/HT76cPgd04NH//c
 c857DApjuZawUm2oCTdBsHGIFqMjKdN9s41BA9kbCCCIFXKUFctWawv22/AYEEtAe6Jm
 HIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441038; x=1773045838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XVarAN+0/DWoyUB8MLOubIRM9lTM8zyfCdEzEfZYXbQ=;
 b=oWcC/6Ijq3W8ouFokrKggxEfgdnhc/kKD5feqVFyFfFu+dyNaGZaztLAmIq6Qyjng/
 OenfeXONJ7nYCtl3Q7azX0SIDg8vvQSVH3gKyKsAtqCviLWQ2l5Awi/uI1ryG5PDds4w
 rEYKtE4y/VPRZ4U9lofI0kEcZKsfeTGo8WVWqOYRCKq1NvnK/eXnywtgdlrwPuH7s++/
 oD01IrqYKzwQszVcJgRNWo6cW2Ic3QIAGuMaYSHXMmelWn3v3YD8HGKPPqRwu/EHG8Vf
 czOQssA3uadjcyZuoX1cOuPnD34gpaTR3jWhv1t7YZn00gG1krT4LhIBPhI5PYf0juAw
 PFRw==
X-Gm-Message-State: AOJu0Yw2BvhPBBNwd5fafl53WiPfwGFlosEYmA9XrUlY6ld02ddXeP1I
 3Tbwkk3sNX3S6N0UVB2p/eLyVDBhm50VtGNZpe3Eyq2DPMV/QIcuBYD0KYlqCqVcpZN56RjUBTY
 fTPtNBWAvPEZ6E5M1ugcudRbUh7qxoD91HjX3YvgFEieUhEAobeiV9c1shBuD96Pqh0BhDFuzgM
 uAHNUYyT2y884Up6khv4JOOfT7GEv7BXp4ErcllQXA
X-Gm-Gg: ATEYQzxKQ6qXz8OVKq0dT7WZS+bQIy5/qm0bc4IZlBxG4cuFNNaA6PioWAiJRu4FXGQ
 NDFx8U5RUYRdct+WJOh8udyIK/2t/4I+ndpNInFKYjBpi+DSE8AYzPrZdRrxPiZfjQBN6xng7r3
 aJgTqVDduapYrdEPKI3t4mQFxxSYIRWVDoQ7CL46qZdHsvdO8VG+XWK+EOiDQFQTzzKCY5UjDtQ
 Hn3lJqo5RRysxZC03QksER0ea4AibMIUskrAOc3W+2fB+GBhTbVDGX4PW1VMXCD85W5LkRWhJoc
 zRay2te6qZB5XoYS4K23/pwSV1/JkZCW+Y41MmEjWCIYovRa0h5wcy2EoG5GR10kXr2b4ijja3y
 iPHaLUy8fVq+TiQACYmZIvl4hbg6PjxbsEhViUKBxdd0ZwjOwh6vrhorK0uKSqu1oXoNyYjb59p
 Olpbs1HYfBPv8MM2R91qCAt9j3Lns=
X-Received: by 2002:a5d:5d85:0:b0:439:9465:906f with SMTP id
 ffacd0b85a97d-439971a5d45mr30147751f8f.2.1772441038420; 
 Mon, 02 Mar 2026 00:43:58 -0800 (PST)
X-Received: by 2002:a5d:5d85:0:b0:439:9465:906f with SMTP id
 ffacd0b85a97d-439971a5d45mr30147703f8f.2.1772441037962; 
 Mon, 02 Mar 2026 00:43:57 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b4e771basm10753590f8f.0.2026.03.02.00.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:43:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 005/102] target/i386/emulate: rework string_rep emulation
Date: Mon,  2 Mar 2026 09:42:00 +0100
Message-ID: <20260302084338.473368-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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
Link: https://lore.kernel.org/r/20260223233950.96076-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 4409f7bc134..bf96fe06b45 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -466,18 +466,25 @@ static inline void string_increment_reg(CPUX86State *env, int reg,
     write_reg(env, reg, val, decode->addressing_size);
 }
 
+static inline int get_ZF(CPUX86State *env) {
+    return env->cc_dst ? 0 : CC_Z;
+}
+
 static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
                               void (*func)(CPUX86State *env,
                                            struct x86_decode *ins), int rep)
 {
     target_ulong rcx = read_reg(env, R_ECX, decode->addressing_size);
-    while (rcx--) {
+
+    while (rcx != 0) {
+        bool is_cmps_or_scas = decode->cmd == X86_DECODE_CMD_CMPS || decode->cmd == X86_DECODE_CMD_SCAS;
         func(env, decode);
+        rcx--;
         write_reg(env, R_ECX, rcx, decode->addressing_size);
-        if ((PREFIX_REP == rep) && !env->cc_dst) {
+        if ((PREFIX_REP == rep) && !get_ZF(env) && is_cmps_or_scas) {
             break;
         }
-        if ((PREFIX_REPN == rep) && env->cc_dst) {
+        if ((PREFIX_REPN == rep) && get_ZF(env)&& is_cmps_or_scas) {
             break;
         }
     }
-- 
2.53.0


