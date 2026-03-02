Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1F1D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyto-0002d3-6G; Mon, 02 Mar 2026 03:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytH-0001mH-Sq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytF-0001Zj-MU
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RQTvXPDbTQKJ4rDKt+Fw9lkp8OzkZ5K+RmnX6t8yP8=;
 b=OG3p0loOWPqn/q4qScyUKANuM1Nfn9fJbAzubS9qBn3YsfVL5vZn48tGWg19y4RFX4URk7
 BPvv7YPkX2WmY8ln1LeqSUbVrcOa2vRmbGyAMuhm1K5XgxOqDz5q+xhr5aG76ilPFTmLM9
 xqBDXcjT5jmdy+/q/ixjJ5ARLjXnpVc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-2ht7Oeu3MTSfCuhpvAEudA-1; Mon, 02 Mar 2026 03:44:31 -0500
X-MC-Unique: 2ht7Oeu3MTSfCuhpvAEudA-1
X-Mimecast-MFC-AGG-ID: 2ht7Oeu3MTSfCuhpvAEudA_1772441071
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b5346b6cso769118f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441070; x=1773045870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RQTvXPDbTQKJ4rDKt+Fw9lkp8OzkZ5K+RmnX6t8yP8=;
 b=GOFfyj3wMAPfrJXmEKXS5mdtu8p+oFcS6QSw/PuHcAb1Csi9yWQdSdKhnD4Rhfl04/
 LAFr4xQWe2MaKVCEgM5fLBjCCUYWGF1mjIDw3LeAnfv6KY9GSWtnh5cZSJE0vmcDUga0
 LivKySjch0OfhU8YhyqGZlDLxohAo+L9eYi2KFG62gl77LJNCqeusjP5dR3/uFjk0gT5
 oRhnKmgrWu/CvO/5BI5bmG5ctZqoQlFZeavCF7W/xe9u1Ntl4GhwJOlJrtJIx/YTRBMJ
 DqrvRE+qVIeG1m8/nSDZZRnjSidaHzIzQ87YR1vikeNl/82hH9MGdN6iJqDNv/YMqmT9
 +Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441070; x=1773045870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9RQTvXPDbTQKJ4rDKt+Fw9lkp8OzkZ5K+RmnX6t8yP8=;
 b=qgd2kqPwI1Bl9pElOR6VBSp+UIyRu2xwov06tqlUM3zaQdkpJMpzUVOviJXekM+m8w
 ZDlUUuWTrp/0RNVw7t8fVtP440oM/XQwUvw40yMyul/tpPQZQ3HDqaWAUbD6KOK5mbbY
 K8VY757svX0dWyUdtBdKeAOqzR2dlsIEpLNasn0hJlcYidvTco+m19yK/fzlDwfdY6r9
 NDxkMyCcBKmhsBawnUyXU9X42Fnr41A8vhmflcd1bdcigCIxu6OM5GgFu/8/tWdfIGxB
 xKa5blvfG/x6slBxnTUEE0SWM/UGxoVXAkEVmmBdIH/Eb+8AtxyrJEMbRDWJbDa6U/U9
 S/rQ==
X-Gm-Message-State: AOJu0YwmnYwnbVS/zkHOr4qAxIxObohNcM40pZ1LTtD9RTjbw9CFP7wa
 j6/wFwTGP0r5vwKv2h2IxxyRfQJIOR2+iXYgpzaTmBGHj+3fa4Rpr2Se71f/LRBXXW4uFVyvEsn
 A2y5mUGFrKHSMXpdFNfxwo0TW8dgCKF1bRuXUH+t2QRNO8bUf3OEW5WvMUvjbdwBtbmYe1roVe5
 TpTZrv6WqJQ+bfnBEqGgdTyOvTcQluwzjnDKRUAjEk
X-Gm-Gg: ATEYQzwaNmaX27UCFwR4/qb7RxDFib3MkbLNeEpaHL6O4KsnEatrpBaSr/7c/cInPbV
 CuKPpfT73yn/S+dt9QrkYCIkxIxsX0f6jfswPopYyNKqvy/k3742JqmVgj2B1LPaOyPnQ7WJl+M
 TA2m4CVLOitJN7NQKJangJO4IzHD3JHH+RV4TNBlLP7EV7AC48lQFk5KGVQnuFyXb6e8ugEym/W
 /jQvW22I+7dohZqBhnH9sDFzQfNNT+AX3xqqwm1WxAKtLSDu6djUiI/rUc4FgjmQI/9JpkmaYyZ
 hwOmjErJ3KFtblZBiAuPWkSojkdeJ3wBO0sbPDGBFXOQU/IAWrz8g1TyZ6rrX9vSwB5nF/ElA2u
 gLLpe/0xaRkuHh8VAHXSAnrxI/6xDwlA7l7d5LMCYEjjKTFnju0eyO9xmqVnD4SQlAUYvHU4k2i
 T8Qu70LNpzQopliQmPdUN9MeTu7cg=
X-Received: by 2002:a05:6000:1acf:b0:439:b6d6:71a with SMTP id
 ffacd0b85a97d-439b6d60af9mr4929495f8f.51.1772441069824; 
 Mon, 02 Mar 2026 00:44:29 -0800 (PST)
X-Received: by 2002:a05:6000:1acf:b0:439:b6d6:71a with SMTP id
 ffacd0b85a97d-439b6d60af9mr4929450f8f.51.1772441069265; 
 Mon, 02 Mar 2026 00:44:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c67sm27716851f8f.32.2026.03.02.00.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 018/102] target/i386: mshv,
 emulate: move the generic x86 helpers to target/i386/emulate
Date: Mon,  2 Mar 2026 09:42:13 +0100
Message-ID: <20260302084338.473368-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

HVF doesn't use them at this point, but move them to common code as that's what they are.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-18-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/{mshv/x86.c => emulate/x86_helpers.c} | 0
 target/i386/emulate/meson.build                   | 7 +++++++
 target/i386/mshv/meson.build                      | 4 ----
 3 files changed, 7 insertions(+), 4 deletions(-)
 rename target/i386/{mshv/x86.c => emulate/x86_helpers.c} (100%)

diff --git a/target/i386/mshv/x86.c b/target/i386/emulate/x86_helpers.c
similarity index 100%
rename from target/i386/mshv/x86.c
rename to target/i386/emulate/x86_helpers.c
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index 1bb35162498..1fa1a8e8ec8 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -5,6 +5,13 @@ emulator_files = files(
   'x86_mmu.c'
 )
 
+emulator_helper_files = files(
+  'x86_helpers.c'
+)
+
 i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
 i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_files)
 i386_system_ss.add(when: 'CONFIG_WHPX', if_true: emulator_files)
+
+i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_helper_files)
+i386_system_ss.add(when: 'CONFIG_WHPX', if_true: emulator_helper_files)
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 3fadd4598a5..49f28d4a5b9 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -2,11 +2,7 @@ i386_mshv_ss = ss.source_set()
 
 i386_mshv_ss.add(files(
   'mshv-cpu.c',
-  'x86.c',
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
 
-i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
-  'x86.c',
-))
-- 
2.53.0


