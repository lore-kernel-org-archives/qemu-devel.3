Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E347C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuK-0001x1-8P; Tue, 04 Jun 2024 02:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuJ-0001wl-Hs
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuH-0007FQ-3Q
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbdPSgBMmEM0sdVEMRqo/qJllKiAjUzu7KbdlzjNJEg=;
 b=XZn/Wtxy1vLud19l5vwelTba4a8wOkiNxNS5JeGXz/0RXWyASpEz/MM3+WccV+Kc0HSrYN
 ojh0r4THYXRGSj7IHHvuNHVcgbtkkrMG0Nvm/GCKkAOoznXQJwA9l2F2h6Hs5b2CRMy9P9
 cK8Sny2vIeYUQDXEd3YGEoYojnsGpX4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-2sWfsubgOVywUv1X9ji8ww-1; Tue, 04 Jun 2024 02:44:24 -0400
X-MC-Unique: 2sWfsubgOVywUv1X9ji8ww-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a69a573a4so299879a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483462; x=1718088262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbdPSgBMmEM0sdVEMRqo/qJllKiAjUzu7KbdlzjNJEg=;
 b=BcyOC0tHRqP5h8A3vTtOQL0Fy8lEG3A0URqhsYyWbIpVWHV2DlCWyasPOhNa4p6KL0
 CtbhQtmwN0y+hZGd4uUUYwwmAfx7+2hnazuSWkaKjo/EaawrutJI0Nef20/6cF+VI19R
 M7MHNebQVeYVML0KBR592jQQUu9G0VsSJwJiJjorlxpsCNSl/tWLvOWuKuZy6a1wl1b0
 5+BUWO7rl/P8jusr3UZ4GN+0J1NSJXa68ZuRdICvBHFe/faqoEcxqlLAso8jM4cQ8m3p
 yKZDpequleZEPN5N2xe6oIejfOfAOwMlCfclDuQulfB78JCnuJtZalu2+/xWi5OPkfUI
 WuaQ==
X-Gm-Message-State: AOJu0Yz87X+Ed7kE9dzez1TPzWssIkL9w6uMW1bPzK9O3j1/WEFdVPzi
 6ITgClgf3RFPOHd5gG3tlScUqk5oaZEgRGcEz0MMECrv6S58fIS1cr+lrqdZ49OlxxBqtREpyZ9
 pN3+fx5pxyhevM1LZX3NDPPbjnLf/W3xUbuG4R6dhqoENP/uOl3SUxFACwv/LlEVkJnt/VuEEza
 8MrjJ49ZEosK6LkRVpaJkNNNZvKR4eOiERcjvR
X-Received: by 2002:a50:d64a:0:b0:578:5f1b:421a with SMTP id
 4fb4d7f45d1cf-57a36543114mr6806799a12.27.1717483462669; 
 Mon, 03 Jun 2024 23:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDb3cA0XpT+jwPEXHZBoZm8OlRq6U5je13py0Pf0K7g6DfMHwfxPrUYAsRbS+bwe39U8MyBA==
X-Received: by 2002:a50:d64a:0:b0:578:5f1b:421a with SMTP id
 4fb4d7f45d1cf-57a36543114mr6806786a12.27.1717483462233; 
 Mon, 03 Jun 2024 23:44:22 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a4606f159sm5515256a12.43.2024.06.03.23.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/45] meson: assume x86-64-v2 baseline ISA
Date: Tue,  4 Jun 2024 08:43:27 +0200
Message-ID: <20240604064409.957105-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
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

x86-64-v2 processors were released in 2008, assume that we have one.
Unfortunately there is no GCC flag to enable all the features
without disabling what came after; so enable them one by one.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 63866071445..d80203f1cde 100644
--- a/meson.build
+++ b/meson.build
@@ -336,9 +336,13 @@ if host_arch == 'i386' and not cc.links('''
   qemu_common_flags = ['-march=i486'] + qemu_common_flags
 endif
 
-# ??? Only extremely old AMD cpus do not have cmpxchg16b.
-# If we truly care, we should simply detect this case at
-# runtime and generate the fallback to serial emulation.
+# Assume x86-64-v2 (minus CMPXCHG16B for 32-bit code)
+if host_arch == 'i386'
+  qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
+endif
+if host_arch in ['i386', 'x86_64']
+  qemu_common_flags = ['-mpopcnt', '-msse4.2'] + qemu_common_flags
+endif
 if host_arch == 'x86_64'
   qemu_common_flags = ['-mcx16'] + qemu_common_flags
 endif
-- 
2.45.1


