Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620D0E8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQw9-0000Xv-0p; Sat, 27 Dec 2025 04:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQw6-0000PS-TD
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQw5-0007Jw-05
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t744vUWy2Ee77dP49UO1E2no25c9JrA3rvTNF0iTUl0=;
 b=Wu0nrk0cHNpPJqAO6ZDxeO7UPGtyPjoUU2TlHQHGtgK2jFPWbWzGztoP/gKo6XbvxIgJPA
 oXXBpgNd/JUQSJcCQFAiNzdMchh8R1OXk07hAZDUC/IwWnFo8DDoISbzh+US0BI9rLvy6c
 Vc94ZNoABihvsFCujQq8HAllI7uaQoY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-wITtALy0Ny6dQuLgbk0A5Q-1; Sat, 27 Dec 2025 04:50:07 -0500
X-MC-Unique: wITtALy0Ny6dQuLgbk0A5Q-1
X-Mimecast-MFC-AGG-ID: wITtALy0Ny6dQuLgbk0A5Q_1766829006
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779b432aecso45665695e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829005; x=1767433805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t744vUWy2Ee77dP49UO1E2no25c9JrA3rvTNF0iTUl0=;
 b=Fmqz5lCyyZfdp/VA8Aov5wU5U2KOE2Vvy0p3szXzILGfZ/a/CZNY6S6UvUSg624K6H
 /jjD6RA8ODmS1yxazb7nJNKUjzlcbzLNiBTqNu3wHu42Kn5QTDLr6d1MtWEZoPlIKaXD
 tyPseOpigtpcmXf+1m2tdAUZeQOxH33ZYgo7KQCqChcM1sB6cGKOxiW3loLqilRjPGEh
 QWqVdP46VlRPR1fb7dWxi7MxGEDaQaYZCYDAyGTm5WHtQxgqTS5PzpdSWLN46CeJJ8n+
 JC+9bDJtkwPv1581eW0QRdhJG/9dvtZxaXta7MTEjSgmbFHl5Y7TSQXoRD69URuBP8Rf
 0a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829005; x=1767433805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t744vUWy2Ee77dP49UO1E2no25c9JrA3rvTNF0iTUl0=;
 b=GFgbVBNx3whgw0mqUvzsUnz2gJU/2fHXeQM0gxHtjvDPN8TI/INaSqw82jUn2AxRc0
 KLbybVRaUTOmBObS6oE2wWd1L8zSI6ihfbkS3DXEEXccoqiFJsJUxRkySeYtI0PJjnwH
 K7j1wH0AFv1F7PN/DIzudSMG4G3Bo2xnaVyHg8nXjQftMcFXpGwVxamIitfK6GXV5iiB
 2ttWe+EI49T7HRtfunO96o4Ry3fZ0bEHidM6roCoI+dJUBh9tk2jngHwlbkaFvSVsPaP
 dDk528j4Zso8kb/sQo9R+ekJqZUPAvami5vHYbdY+Gi9Fk8IDojLO8q3u5Y/HpFbhUy7
 0UDw==
X-Gm-Message-State: AOJu0YzlzQaXLINO3VYQx0GdRTJiRRWFSG9lkbUc7V++Vt1uBfo9U3fs
 fbcg2c+N0bJE9izyw61F4wD93Y+I/6ZmAvJCVk4dQ0cyxigquLD2y5jpf9Hq1lef2ms2nnZGwuM
 /DCP5nYPe2RTGmOU1Ep8WoYjgxT3SsbZo0cEQNxAFleh4QesUY0ljHqDDyj+f3UHmpHi30rw+EL
 LLupFu75g6/rU11571VmNWP9sZC/4/wGWubqagXBL3
X-Gm-Gg: AY/fxX6klfWfSFSUqwZue+9lrJJPRZzU0YTS1IwktgxxpN8xYT9Kc6s2qaXwyD0KKXr
 bjnFTEQGu1vyfsSnxjg7PRA05jG0P3dJ/FNkUBSMbnQHNVd0mf/UkkUhbFTGXtH+52gO6NcwvCy
 DQJrnn68PTLz0+5ilYh7CjAVjk9BO0D+FdJ+FLD6UshClVfNGL+vQg1Lvqt2YinaqDvDtB/MF68
 mkbHVN+2qPCVbTgkchNwP1O7o1EP7WL3k82uE7tmcSMiiy3yZw/JBztzpFyeHhQjCccy20qP+dz
 HrjzUgMe3Z9w2K5ex4pk5EcY/hW/AayZ/WEutp+VMlI2ErbMsN2x9rhCLONTbxoaXqykV/ghdAT
 wD2a59GffH+jZWfwagRd66eI5I83YAbTlOPx+DodS+sWGeZPvIkED8M34J44CfQXXfDxdIZGj7T
 m8Xv2iyKPo7rPCnxY=
X-Received: by 2002:a05:600c:1d1d:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d19546487mr276574735e9.12.1766829004933; 
 Sat, 27 Dec 2025 01:50:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5kzhMDqxTj3/SmGWLuzKPFTtxuWKd2dXVg6OMyG1px2W6Nyka7Yd07keEvstCbgIosCP2IA==
X-Received: by 2002:a05:600c:1d1d:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d19546487mr276574535e9.12.1766829004522; 
 Sat, 27 Dec 2025 01:50:04 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be26a81b6sm499601285e9.0.2025.12.27.01.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 120/153] target/i386/tcg: remove do_decode_0F
Date: Sat, 27 Dec 2025 10:47:25 +0100
Message-ID: <20251227094759.35658-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

It is not needed anymore since all prefixes are handled by the
new decoder.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 8a1fb2855d5..d2c024ea342 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1430,15 +1430,10 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xff] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD0 */
 };
 
-static void do_decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    *entry = opcodes_0F[*b];
-}
-
 static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     *b = x86_ldub_code(env, s);
-    do_decode_0F(s, env, entry, b);
+    *entry = opcodes_0F[*b];
 }
 
 static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-- 
2.52.0


