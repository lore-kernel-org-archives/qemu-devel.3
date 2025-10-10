Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30548CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ElT-0008MZ-3e; Fri, 10 Oct 2025 11:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElO-0008MA-P9
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElC-00043i-TS
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/xFnT8f0DpAhs4XBkL1hdT97m682bWgM6Ej0zAVW6U=;
 b=JAKTQU26QnL176D79P97teq0uatmaSrgeA1fEnWegMpK0FJpnE4j3ByJ2R1QCsMz98Hdcc
 r5Ok0+cQvI1tF71deBFwJSBRgnGD026WADTae+Q6l4JGW98hCzU4Pqkar0XL/dhlAEUMaD
 fLNAYbG6XfP6eDQQJo8UZgqU1G2bPzs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-GVmbAhQSNcuY4FR3Jn1R0A-1; Fri, 10 Oct 2025 11:10:18 -0400
X-MC-Unique: GVmbAhQSNcuY4FR3Jn1R0A-1
X-Mimecast-MFC-AGG-ID: GVmbAhQSNcuY4FR3Jn1R0A_1760109016
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b4635c413a7so169305466b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109014; x=1760713814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/xFnT8f0DpAhs4XBkL1hdT97m682bWgM6Ej0zAVW6U=;
 b=KOoHZ++G3osLIrx7YOWYDIsZ+buwLhfG5X2TiDgoW74V+0DwIGSEMBXpJWTxfAB2SY
 ycyOAKa96LRTmZNRDoCzNHz0mzbcK+Bln64l7s5PVjyNXDS1Z+BISdZOBeoofgNC4bNi
 2nLN3zHHBhl2bWvZyCjDdni17T4qKLu0VP0UO5b55opI7+4ckNJZI5X7Au63zfIJk6rJ
 cnD9yFWJr2odPlpnyL5ax0OTxeEqs+dfNqdcFKwsa4akyFdjGk/bMd/uZrRp1j9RWcbo
 lCh7x8y6GeVofAff8j6rY4L+2A2DRSe7qE4AiO7Mk60PtJiy5gynVMjOcaKLvOzFKrxi
 ZBhw==
X-Gm-Message-State: AOJu0YwLzquLm7oSJvD97KVCnTQrhDOhLntEscLmyfKSwLUYuxvrpq26
 H5cUbHMEYaxAqDZbiG4eOLMKQZAU+5PlOC659EJLPMaBG8AKlm0Y0IoJJJJE18z7SLXLqS54701
 qtmJWQArJ1bBIPGXbUo6ooQ+7I2se774PVHQODeOfUAYfcNRMVwFVEV7DUYn730Z6doe2+kPh3X
 na/WKVmSw1Wmrp/029L6ZeNe+NGePmJL1j5E9nCh3H
X-Gm-Gg: ASbGncvYZmpv8ijXDxtEp1mvNjnO5VEwlWT/q6gmRXUWqhFumayA8rPYUcU6hrtJOrz
 k1N/urfZN32RuS7KBWt80OZ2luXRtjdBGub9OwSbsd+aPg2P7zhuVVSrpSrMXg7mWh2i5hFzRgj
 0IHij0KtAtN9xzL81NnDPzDSAJWFBS4r9A+Qr5VBpqbUj3PLsMq7PHIGtsZvo0Hpa9Zd+fz/srq
 BbYqNSCIbIoQZu0sQ6f/tM9/wRUYwa8RWYJG2HuXwKq95u4N+al60W3sBDJOqxNkfEg3skwIwd8
 Edm/KIi6Sso4dfCv1H3lsBL4BtNstlpCKAm3WfhTG9Hj9jb402lVBfRHmcuWkxWv6bV6qYUS8jB
 1W6m73yAeE2GUZpfm+GLu7bCuibLIzc0Iu/gf2RrMV1jg
X-Received: by 2002:a17:907:96a9:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b50aa491efcmr1327481966b.1.1760109014428; 
 Fri, 10 Oct 2025 08:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWpvnoj2yV3OFPQlzNEULVZJYZM5xsvAJtnsLekGyDi5wRdbb2YipTV1Uj1mIqqNmOWjNRwQ==
X-Received: by 2002:a17:907:96a9:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b50aa491efcmr1327478766b.1.1760109014021; 
 Fri, 10 Oct 2025 08:10:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d900e2bcsm248932966b.64.2025.10.10.08.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 03/19] rust: do not add qemuutil to Rust crates
Date: Fri, 10 Oct 2025 17:09:48 +0200
Message-ID: <20251010151006.791038-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This fails due to https://github.com/mesonbuild/meson/pull/15076.
The config-host.h file from the qemuutil dependency ends up on the
rustc command line for targets that do not use structured sources.

It will be reverted once Meson 1.9.2 is released, or replaced with
an update of the minimum supported version of Meson if 1.9.2 is
released sooner.

Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/chardev/meson.build | 2 +-
 rust/util/meson.build    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index d365d8dd0f4..36ada7c4546 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -39,4 +39,4 @@ _chardev_rs = static_library(
   dependencies: [glib_sys_rs, common_rs, qemu_macros],
 )
 
-chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev])
diff --git a/rust/util/meson.build b/rust/util/meson.build
index b0b75e93ff6..8ad344dccbd 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -43,7 +43,7 @@ _util_rs = static_library(
   dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
 )
 
-util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
+util_rs = declare_dependency(link_with: [_util_rs])
 
 rust.test('rust-util-tests', _util_rs,
           dependencies: [qemuutil, qom],
-- 
2.51.0


