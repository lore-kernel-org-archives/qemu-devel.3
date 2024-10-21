Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A06D15DB8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vN2-0004s2-Kb; Mon, 21 Oct 2024 12:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vMz-0004l2-09
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vMx-00060J-5f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gVqNwogg5tFSmWizsqaCav54ufpUC+gxAG29oNKGkjU=;
 b=dAaMViJW2QUSOo8gbfpVLhtRrlN6+KaFxbxN+YQUSh/8QFe/74u1WPo/mOO16p2lWc02SB
 nFp0le1JsSgNpJAefzHQh+vI+rz4y42B8iuAJJ+w3/ZlhM97RwKqeZAT7Pru9U7Vz3PYLB
 zXsOAN/bx38klO7YZ1Sn/svdunAbLUo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-bk9mH3QGNOSNsUoP0fDHoA-1; Mon, 21 Oct 2024 12:34:53 -0400
X-MC-Unique: bk9mH3QGNOSNsUoP0fDHoA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d67f4bf98so2778096f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528492; x=1730133292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVqNwogg5tFSmWizsqaCav54ufpUC+gxAG29oNKGkjU=;
 b=s1U+jYMIvqRCmYUHPKfKd6oHJ2k9Gv/eXvEfxdwG8NsPBs4Ofv+6c3Q7xBgI/SaIx/
 z2oIvQzIgWwaTGoNYJgzPppeFiWagLGB8E4PYVgQ0OgqNdhysmNV14Hrw9IIKTsmr6UG
 7kEcp40ezyyN+GOj09uZHEJQ9FsG6LlK3EwdzT1IEIUjGsgBKVy9r7smKP4Xs1Bo9NFB
 6TvimDY+qW4zBt7h5An6IFHUwRQIoF1bu6qa911p7OyaDSO8NlzjYISpKZrxGaERuZAf
 MXM+DcvlmUT2oh3VgInEaUo1A5TpTPEeTsg747az/7WS56zOCgCL9tpfH8NhN9o9w0ee
 L6sQ==
X-Gm-Message-State: AOJu0YzMaxH9flsbf2XED1rQuAYeRVUfcdfUtjd0BmYm0Ptj2ivYvLVW
 RvmMJuD7Ti+FBOHMPUFKZGJHbRAuok3PGps59izQK5/YxHYanIze2+aL8f0jAQho8csmCT17M2/
 HKAoNqh2E4SYbBYdN2MQPsi1pa/O0gam1ePaBE8Oyjl9tsjgyaEBjl7QJ4B2Mqis7B9i6JIIVA3
 /QnS2LCXG6alRy2/kaOO/g4hgMw6kuqmOPES+os+8=
X-Received: by 2002:a5d:6d0d:0:b0:37d:4f1b:35b with SMTP id
 ffacd0b85a97d-37eab71038amr8808634f8f.34.1729528491975; 
 Mon, 21 Oct 2024 09:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFatUODK92GjcT/vwgjweK+cDMrcIgpDb/vnqqHAAy4SXz+2NCraqvTmugDJrTYY73dhX3/g==
X-Received: by 2002:a5d:6d0d:0:b0:37d:4f1b:35b with SMTP id
 ffacd0b85a97d-37eab71038amr8808619f8f.34.1729528491576; 
 Mon, 21 Oct 2024 09:34:51 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b944fbsm4741732f8f.72.2024.10.21.09.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:34:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] stubs: avoid duplicate symbols in libqemuutil.a
Date: Mon, 21 Oct 2024 18:34:49 +0200
Message-ID: <20241021163449.136804-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qapi_event_send_device_deleted is always included (together with the
rest of QAPI) in libqemuutil.a if either system-mode emulation or tools
are being built, and in that case the stub causes a duplicate symbol
to appear in libqemuutil.a.

Add the symbol only if events are not being requested.

Supersedes: <20241018143334.949045-1-pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1 fails to build with --disable-system --disable-tools, which I
        have now noticed in CI.

 stubs/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 772a3e817df..e91614a874d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -55,7 +55,12 @@ endif
 if have_user
   # Symbols that are used by hw/core.
   stub_ss.add(files('cpu-synchronize-state.c'))
-  stub_ss.add(files('qdev.c'))
+
+  # Stubs for QAPI events.  Those can always be included in the build, but
+  # they are not built at all for --disable-system --disable-tools builds.
+  if not (have_system or have_tools)
+    stub_ss.add(files('qdev.c'))
+  endif
 endif
 
 if have_system
-- 
2.46.2


