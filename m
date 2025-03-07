Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5D4C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd5Q-0002UZ-Ik; Fri, 07 Mar 2025 14:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5P-0002Tv-3g
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5N-0005tn-Fb
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:18 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2232aead377so46299105ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374616; x=1741979416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnhPiWQ46KHFDBAFB5FNYntK+UjbBUc/XRUUAjHcGsQ=;
 b=bOK0TSNlSqbc8RsCA2uCIpa4mIkHrgE9tt5w/uV8Ik9YBl2Brkbv448iMt/CZv6QGX
 SyXfvVqmOy7Cqr92dfBfNfIe4OzkMzypaD4rulr0xpNFQSRdvOgTya/Q6hs84k+fQfas
 z9Qy4rPwIDco+IwgN9gr0AsTDEZBTIuQanYR9JiIui9JZvc/ot+272b1fbGOvqlm+vr7
 MlPGE9xOeE59va+RE5ciVqk8UB3OKXYRqazDD1frJg+4R66qKFwpHCEB1I9jLMdXXCfv
 ncepJ3061X5oioOG5HuDtDi25EUBIpzEISy3NOYMGXPNCQt/iEaKdFYfa2M9SL8UPUP2
 /qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374616; x=1741979416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnhPiWQ46KHFDBAFB5FNYntK+UjbBUc/XRUUAjHcGsQ=;
 b=sxv9YFGWxkRXQkTlyQVRTdNo3NrRiB6GmTLuJq1JIwda2nuouc6b0iuRGquVngxYu9
 iILxoSlaBDyBROBN+yf9U6GkyxojeB0ZWiGFEObYhk5vZn6BQs8iOqU36u03pm70IPah
 SNRdfhyHQDbdsUK2ES/Yrwe6ZxySdsuKjMMNtEZSwLNcXCU+TkDIVloSpeS95dgCwvlL
 OmH0bmXMtImehl11uqvPuYTEOz6RPWZIwAWLEz1oxLSojNQse+J6IgWd4+UY4FK2Iwgr
 P5Ur7AML3UJc6Zt0SixZX5STd7YGmem208FxoUZmR4+Dikm9OR463UXZwJ+sRTDhh/af
 VC3A==
X-Gm-Message-State: AOJu0YyCE91Awo2dsxlNUIfN4Ne5Pu7PaNy/AZg0xg+dZTJxhH5PdgAM
 LQWcylrl2xiMmV4E3el2WPDiHTUOIonh9NSJbw657YAj4E58JNghK/Apxdt2hAyeZ1XFvhWF8cO
 c
X-Gm-Gg: ASbGncvbZRuXLgnCc1J/Hrh4mWq0Aw0vlYOEg43suPwn4N9o6YJfarm0whAeNv/adQ9
 C48a1bU324ekJMJNOVhggqvL3bB/mOzgnxh1lPYbnC3TJuJaoHEXYQpnBLKLBAsK0R2T78vYNgn
 GXKWCNlhA9Lx5cFgUcq9eM2TmXtRifLNDrsc8mNcfb4ZjU3jXoJ/1Dw4gXBKamsEOYDLs+bBTF3
 LC+Dm9Wt1n3AO8G5sxiW4PB/Ii50l44V45TVLnraBL/nBrsc6Rz5zL9wofHMIFTVNYv+mEVW0eM
 GL49OQoXx5orbNFAV33SDKiHym37VoWhBCXHK6ye/q4n
X-Google-Smtp-Source: AGHT+IEGvvA50bGtGnRgvOVX3N9VYhhII+Do9EFRBDHvk9BNSJg0ZhWlPN1xhGl54jgDafvpI4oJEA==
X-Received: by 2002:a17:903:40cb:b0:223:2aab:4626 with SMTP id
 d9443c01a7336-22428880264mr75741745ad.11.1741374616138; 
 Fri, 07 Mar 2025 11:10:16 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b2da32c6sm1449895b3a.149.2025.03.07.11.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:10:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v2 6/7] hw/hyperv/balloon: common balloon compilation units
Date: Fri,  7 Mar 2025 11:10:02 -0800
Message-Id: <20250307191003.248950-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index a9f2045a9af..5acd709bdd5 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,5 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


