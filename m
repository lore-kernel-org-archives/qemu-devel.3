Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5011CE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuv-0003VP-QV; Sat, 27 Dec 2025 04:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQut-0003H0-UY
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQus-0006xG-EL
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ocvxYMYuNSsUpmOns6DvRZCKhkSVyDlBFI5rejQcdc=;
 b=RRMI/UIVIMpwUer+1o5OHB/cFzAxMzNxW8QLAk8WTwB49+3xENTjdg1DSzsJn5F6Zmr/sf
 /l/w3CNSBdAA8x/6xuZpELOjz7UkVWETEe3MGBkzhGLb+sAw0oYEehiwA9nfVWT1fWOjUc
 2fAahUIQpzZqy3lASVp2g/G3pN2P7SA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-SRws8fYFPzeFaAT-nocVmQ-1; Sat, 27 Dec 2025 04:48:52 -0500
X-MC-Unique: SRws8fYFPzeFaAT-nocVmQ-1
X-Mimecast-MFC-AGG-ID: SRws8fYFPzeFaAT-nocVmQ_1766828931
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d17fff653so26752485e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828930; x=1767433730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ocvxYMYuNSsUpmOns6DvRZCKhkSVyDlBFI5rejQcdc=;
 b=qPRfygVs/bOX1RoqKmMZvnPQfmrs6qTzPAASNw9/ebiPLWk1Mc8mI8k4kVyhKtoRGN
 42GLcvSVMsrAqLLRRZxwQqO5cC+b4M7nIfjPDMprn/o0PTg+SE3go7AuwDJO+yikk6m7
 c3UwEogRmG4lzW1gpJtZV+Q6+d2a33FPC7YqY7Uq71HzNmFAcoisauhRghD8IiWLIugp
 ZPGZms+hRocZZzjnB7uftGKgvQc4kiVCvd6gRXPlDZHjPmZ+p3zpRKyo1Q8ZxgGEa+Tu
 JBg9Q0+0A7sZlEQeYyQX4b1xsCkGxfAM6bAqPZIjy34E2vZDbxL/qgBYSHbbfdFcrdw5
 yeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828930; x=1767433730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ocvxYMYuNSsUpmOns6DvRZCKhkSVyDlBFI5rejQcdc=;
 b=eVktSPVAtepe6IzUxkWwyKVKXnVTU6FUfNqcJb9ZGnJYwCm59eLzgBtf+fIOgEm4vN
 IwVxp6hK0QjIZQORxRBhrB5yUNRyIkHOOyWxbsbIznkStAzjBXVj5iwqPKhaBxyFi/Y4
 ugu4AA3xGV0tn2U2JjkUI4TA4EDQ+HXI+k9IOOAHsmSbtrpjMNjE9bkclHatI4w/bo2x
 bUe6xZgHkGEFU41wpg61euRSy6+yX9XA2foMuKGzOCVqFKHyCMsQGjTRseG++AVG1w5P
 ZN3Gei6PCmFZF5YdJ7qAGfmjBvK/VSgQru3EFb0F6rlrmFer/fRD5m8dekK96/klYDvp
 r5vA==
X-Gm-Message-State: AOJu0YzFEPGQOGpHqa3yH8jLrrTqkB94wkvZEfG9VFYfbaO0nKont1Gj
 Q4MyvXg8/ck+A7NBM6k3eJRT0sTXbRbdtzXjTGDRS+femr9rm9XNheTDeu3nFhhB+KlhhN6F+s9
 Y4PJEn/Umv3hDvC6XXy6nmcGxpNilbxTC2ucL71GZiDHW7j82P7iInaTa6wsCS1yd3uXZW04fZ9
 WpONob0fAp/9tJt4mTbUMGQrbpxqSFqfu/WyL3oD1W
X-Gm-Gg: AY/fxX6C0KzLXXmhQBDSv4uBgmltSyDP7Q1cOtcL0X9BenPFRRhTM/ULdmIt0fqjED+
 TVfyZQp52pgIez2orITwQjBobudhdDWTnrF4WcaWWUX0arpsMZarGkR0twf4o5+q/gz1DgMjz+X
 Lzq5vwlG+ii+/YK6PV3qaT/emOZB3g1yyR+MA6hWhHMe64mZcH8vw6oqzpU7fCLB+JuBeZx2/ub
 bNUlfdmmXDb6440zW+c09+uLXgrNMRQ6eE3K7z4wwlKEi7Q3LHLARFWMeHzSFeO9bci2x+uffZe
 3MJdFzeB63NSXn8u+BGAzKZ1NTMJTyvK0DgpqUvov4n55B2R8+5aHXFgs2frX5yjtQxKEN2Df/G
 w7Qb3RRwBgg1RN3DgT61gMc+IpZKnmf7w4bQVPmVoKV3SoOpFqHIo6biquKDdmuEUkSeMwpYeBo
 P5HqXL85rF7Pt6Ws0=
X-Received: by 2002:a05:600c:859c:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-47d25ac3acfmr201655435e9.17.1766828930103; 
 Sat, 27 Dec 2025 01:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGouZoqF9H9Vin6fUZSFoXZ+ARcei2IT6BGynIKvp0zukdF3hs0TXpG6KT1J5Mf7uJGGto3QQ==
X-Received: by 2002:a05:600c:859c:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-47d25ac3acfmr201655165e9.17.1766828929681; 
 Sat, 27 Dec 2025 01:48:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm50570613f8f.29.2025.12.27.01.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 096/153] i386/machine: Use VMSTATE_UINTTL_SUB_ARRAY for vmstate
 of CPUX86State.regs
Date: Sat, 27 Dec 2025 10:47:01 +0100
Message-ID: <20251227094759.35658-22-pbonzini@redhat.com>
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

Before expanding the number of elements in the CPUX86State.regs array,
first use VMSTATE_UINTTL_SUB_ARRAY for the regs' vmstate to avoid the
type_check_array failure.

VMSTATE_UINTTL_SUB_ARRAY will also be used for subsequently added elements
in regs array.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/migration/cpu.h | 4 ++++
 target/i386/machine.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index ca7cc0479e7..1335abe2230 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -21,6 +21,8 @@
     VMSTATE_UINT64_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
+    VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
 #define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
     VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
@@ -40,6 +42,8 @@
     VMSTATE_UINT32_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
+    VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
 #define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
     VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 57a968c30db..0882dc3eb09 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1748,7 +1748,7 @@ const VMStateDescription vmstate_x86_cpu = {
     .pre_save = cpu_pre_save,
     .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.regs, X86CPU, CPU_NB_REGS),
+        VMSTATE_UINTTL_SUB_ARRAY(env.regs, X86CPU, 0, CPU_NB_REGS),
         VMSTATE_UINTTL(env.eip, X86CPU),
         VMSTATE_UINTTL(env.eflags, X86CPU),
         VMSTATE_UINT32(env.hflags, X86CPU),
-- 
2.52.0


