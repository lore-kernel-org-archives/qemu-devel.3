Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFE1E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvf-0006WM-4v; Sat, 27 Dec 2025 04:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvd-0006Vb-H1
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvc-000735-0q
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+obehD/6XgLBmBbpDgAeb1sGrtgaFddAnzlpY2bxiQA=;
 b=JwFrHneMrbbxUp/+vXjhqPpxj9JI95eaVyFYoUlJYGGjtZsf4vKwiuMRxyjSjJm875gICB
 mN64SGw8JjySgHhqwxFI8q4cXyPO3JAXZAddl9zQE9J7V+++8LzAxc18pTErq3FFFMtVTY
 8uQpL0CMG7LBzii1upk7IN3um5I7/gw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-vF_NFMNNOD2--M12j2QpuA-1; Sat, 27 Dec 2025 04:49:37 -0500
X-MC-Unique: vF_NFMNNOD2--M12j2QpuA-1
X-Mimecast-MFC-AGG-ID: vF_NFMNNOD2--M12j2QpuA_1766828977
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so73505975e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828976; x=1767433776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+obehD/6XgLBmBbpDgAeb1sGrtgaFddAnzlpY2bxiQA=;
 b=TdHrZfuV6de8Td9JzloAq7B0/NBGm8yMd6OXdnZjxTkzl0sV4/AU31edGRxK8+viHN
 hherkt369doPcIBmkY+Ue3T5heIx61QtZ2FSKLpWNush1dg2CYvhV0bjJWCOuAgfCEIi
 uHRdpNT0DT5L1Rrw5OVOmbXV5oaK222YbMOcv+/iab3ZMWgaavG9DrMATqFS53aaOUP+
 HZipSMHc6hQDdmLrnSwvZJEkgnzD78YhMNHbAtMjXuBdCSxa/gQVSHB6kgQHIQUbZ4+E
 e2f5fU9c8W31ssGCNh/x7hUXlXjutxeQsRfo6R+4hnML8CxkfyJxwo0rlaIEnH2R6Czb
 VQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828976; x=1767433776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+obehD/6XgLBmBbpDgAeb1sGrtgaFddAnzlpY2bxiQA=;
 b=umpJXuUCAAd+c6ZGLsqSHTZYIA8ev6U7xlydgjwxLjH+Pt95uBtdkDXnyRGNSFN2Oa
 lfIHog369PPYgNLK/exshVVlp5wA4VZxYIwKof9toPpSiBtBsMLwUXTmyRRdu5DCgAFM
 x7p4rgzHViyxyi/hn82KUOi6B4zfPIQXMSYIbKZblQuI2kO6pvgs55fcA/508LbfqASR
 ABzA1/LK46Z+JXHwRbGRwjpkQD8lIfDPGrX2UJZBK/hhnmljeZJolaD0yY44rIFpbIkb
 tsESefxCvk8SQAnJfSqKk0awsndjQUzNn8p+dPhTa+Jt7NhIBpbLfrgyLJ3HDbiJRf//
 V9og==
X-Gm-Message-State: AOJu0Yz66U4RSiGBQSSVrmL2O1ZiEXSdgN4lk/RsFXNsA/SyrMzWaNFA
 CZft+YtrvM+vRXF5sQ1NngQuX4q9iUctuTYOCtnCLlUjLF8k58gMbLluiZAgm3PFSGsUaVZ/ede
 FCcylUDHi562G7nlnDgHmbQtO9PlR6kZe+7M5zzEuVk1b91XRE9ZVNHsWG5/jgpPMp8bxNzAC+B
 +G08PhXX+0fOWQIlKWB42lleoAwfTYjjcoXFFq5Cv3
X-Gm-Gg: AY/fxX4DEhxTrea/tpCHnVvqOd1ZIKmVOQZLCa5tIiWW62NYaulGGwj1coOyrRRR/gE
 tDm5T0B1GtIBCOuZRJAszlQJqH/S2R1kTdPCQDw4Im8a/FUAjEQvw1LM6U+eQICUF8OTS8qMIvZ
 q36+AjfgNzuCgt98x7AGRnkLF5PKEdtGyB93qr3YB+o1rWL1JhrX2qUs0jsJdWqZvHC1BapeKA6
 6DVSRxx8TNnUDBdt37udBogTRiyo/8h6iUeGTHB98BiHauEpCEmOJ+dQy8QjW8xmpXV4yOvFqgh
 fZ0IWcgGRKuJlwHESFwSKEeyWsWjf8fQrMo6UaOULr/xqqR40TYDEWEXiD7I82oauXFR49xRxlX
 eIjzR5/QqHJ+oEA1lOMOdwFGm3uxC9tU4qeN9T6+96c//vnhNTQXxhI538Ho4F0CFCvC/YVb68B
 rvq4vKA80VvWPB1sc=
X-Received: by 2002:a05:600c:6812:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-47d1955b97cmr294928285e9.6.1766828975969; 
 Sat, 27 Dec 2025 01:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtCex/Vs3RYDuRfkoHScDwXAlBgN8l0dmFpWVQZMwQuBRjAgnUJYDDrtER3EiXVQKiyjLwSg==
X-Received: by 2002:a05:600c:6812:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-47d1955b97cmr294928115e9.6.1766828975580; 
 Sat, 27 Dec 2025 01:49:35 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4e91sm422511075e9.13.2025.12.27.01.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 110/153] cirrus/macos: enable Rust
Date: Sat, 27 Dec 2025 10:47:15 +0100
Message-ID: <20251227094759.35658-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250924120426.2158655-25-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 0d66a14186a..177bd684ef5 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -56,5 +56,5 @@ aarch64-macos-build:
     INSTALL_COMMAND: brew install
     PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
+    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu --enable-rust
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
-- 
2.52.0


