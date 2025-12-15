Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16BFD41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3MK-0000wM-SI; Mon, 15 Dec 2025 02:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lo-0000f2-So
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Ll-0000on-Ae
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+obehD/6XgLBmBbpDgAeb1sGrtgaFddAnzlpY2bxiQA=;
 b=HIbGYwnaMtAqP1ZwBxidMW2B9pEex2jSR14TOJ8t3VQPTTsumxDxxFBIKBTsD0C8BVTbeF
 UuqAcGFzLo6gzwW7FrUC9NS2s8w/boZQvPLaThaAFSYtu/bc6F9CGMUlVa1RvrADTEUWN+
 afFhlF5nyJQL0AqO5CGO3Lgkn/KXWOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ESNps4AIPF2d9_fw3vvWPw-1; Mon, 15 Dec 2025 02:50:31 -0500
X-MC-Unique: ESNps4AIPF2d9_fw3vvWPw-1
X-Mimecast-MFC-AGG-ID: ESNps4AIPF2d9_fw3vvWPw_1765785030
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so30660945e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785029; x=1766389829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+obehD/6XgLBmBbpDgAeb1sGrtgaFddAnzlpY2bxiQA=;
 b=KyiCE5BbegeSOq1Qz5//KmSqir+0t97a/ImtgvVIQbf8Ba/NjgilEzBCFU4wXIXoyL
 sicWCsbq9cf/b2hq6u9fkHYvdsIJvufnIlucb2MMqZqKj/VjPwSGUrRuCBPAkVbldl5P
 5btc8gCJzmSgyAyDZrMgMAVvD9dev6L9MhAUBN1MdPM7PkcVHVWzMjhYw/t2Q7aoszUa
 t1WCzsN3agitI9nGS2NeD7twT7bCL1xOEao5zgI8MvA2twlR1wZa3/d0Ib+IEQCHDP+E
 B8nnNzPgHm4fZreq0g6y3nDoW6kK0S/6wyUI/+f6jjFXQbHmCCr6ArmwiBeoY/iPSbag
 hhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785029; x=1766389829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+obehD/6XgLBmBbpDgAeb1sGrtgaFddAnzlpY2bxiQA=;
 b=DpdNJpJFgxjYfjJ5YiaRFz9v4U+yJRJ0sMnNziVUIErw1HibLBGdAlcsAGtFxdyrAN
 mjbiwHcyGI/7zajCXeeSyAJ2FGNBs7pSij6rKtASJZJJz9IRxjcchz4NPuhUu+e2jjyZ
 hH0jH9pc4BE41Pq3/lYraswz7rzctCmYC4unVbkqo9ADPXPLswHv+9X3lVBxYUMUylZz
 1IJuOp19CVKpGtVA3BxWMFMvhBI0d8a5gaK4ddA9DhPT5sggReNrsKPdp5OIX9YETuU+
 Ytqn7Z24c9kjudAo9Z5PwFI0bmxc+goUJ5xPkl+e+eDcreVTCdIDdC/+vTm+Lvnxf5Fe
 z9xw==
X-Gm-Message-State: AOJu0YwiZlLx2mI3PMuHquk48BX+d7CDGjmTdwQoyWXO8EUt8mk6C/xJ
 bdf606IVyqe81gZ+Cmw72cFkeujH90JcIS5A5C4lr3+fHqpAuJ4iRU8mhc9kLeTfamfhuDv/AVp
 F0GetYNNGDc64LGStWPNpv31ydYWpWxiTuT4fIBPxxNMXys61X79d7ZY0yal+SR+755Pz0fkYks
 zEnDqYFe7Kjgcui40LTPwZK09bIA+lel6qc6X/UAMG
X-Gm-Gg: AY/fxX5kLzbgrXiY9cCF+yhtdEllJAsxPWwaXtPqjPQsUhBSapTpMpoFic4HPyDYgG+
 GOvCJ5hdiYDygaT75H9R2ayAj6Ls0t6uE5YdstAduMeALu5yZk/+9sAztspas6Yq5LufNWjSZ0Y
 JWctPeYaYsKDVn1x5Pg5GSM2PaC461Nci52gGpInY1w3EWMSK3NZ5Tdai/MrIHt6EpgHV6ScDTf
 D6yGiDIuIgWKKhcrh20qvyXuYd+lIqaH66FXpjrP0QpSPb7zlnAUZZCMSUTsWooKT7Sy2b/xyWT
 JDW0COBfrxmhpZJkhppsSZ6zW+opj7X5R8X7GsXNAi0+dd6qQYaPs++V2dubTq+YRv5wrG8NfkT
 At3Cld4enqIkaJ2uKqA8noa0MoLjwX/HrcEIityDQ/aS+f5FIOA6Pa9dUTBJXYKubDVd5Cc32ue
 OoO6JNo2S566J/ZwA=
X-Received: by 2002:a05:600c:4595:b0:479:3a87:2092 with SMTP id
 5b1f17b1804b1-47a8f9145edmr92097575e9.36.1765785029012; 
 Sun, 14 Dec 2025 23:50:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrx0ba9CwEUX+fwZExSNytgQwqx1DduT4Ue2KjwyJkPcnfv3FiGzbPtjiXH4eP9ylbR/tn8w==
X-Received: by 2002:a05:600c:4595:b0:479:3a87:2092 with SMTP id
 5b1f17b1804b1-47a8f9145edmr92097275e9.36.1765785028444; 
 Sun, 14 Dec 2025 23:50:28 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f38a4b7sm173665475e9.3.2025.12.14.23.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 10/11] cirrus/macos: enable Rust
Date: Mon, 15 Dec 2025 08:49:59 +0100
Message-ID: <20251215075000.335043-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215075000.335043-1-pbonzini@redhat.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


