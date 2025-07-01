Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC93DC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZRp-0006hp-3G; Tue, 01 Jul 2025 07:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQz-0005fi-H1
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQt-0003eP-94
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rxoquqbsAfv2DglEJ+FeqUFKqD3/UIqhsvayd1Gi3Q=;
 b=YarJuQjXoKEY8fb7RilPVRw1hB/NsDddiOELNL4nJrmA+r4rYcmGK44crTPA9AJK7zj93F
 R0KDRfgFvIDS3UDTtx87PESM/NMcExpp8qIBEou24z/rNfbWK7tb93QKdIfr0oHhBxEGM4
 9OruUAM/5ErQIUGMethOoC1dF1Hp+/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-m88-_0UiMO-YUjA2xe1hWg-1; Tue, 01 Jul 2025 07:45:46 -0400
X-MC-Unique: m88-_0UiMO-YUjA2xe1hWg-1
X-Mimecast-MFC-AGG-ID: m88-_0UiMO-YUjA2xe1hWg_1751370345
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a52bfda108so2620197f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370345; x=1751975145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rxoquqbsAfv2DglEJ+FeqUFKqD3/UIqhsvayd1Gi3Q=;
 b=Ns/5teczRnu1e1n7q8l0kQoxc54SwJMc/f++uNUJOf7STVSV6nz3upM1f5j/+vCxC3
 d4R9s10BLMGvgjkUZRS0w0jAJNRfNQv1cSu+591N4UKNrHtx98KPTxckyVcKZCeRrgx6
 RTXHgMBDUJWjruLKc0Qp/uGefQQFyPxV95Bs9ukhz2A1Yw7+kKjbr/oi0Ig1tVgXS0aQ
 UOA3Qb3HdIsNy0K07FcSZwexg+yJGNzjD47OYsgenDd2b57dclM0hoWWOZCxDXvQlLqk
 T/MmXxso0a4rx0I+ngTmdpNbJYeMN84a4axHg/Tt64QB2Z+tlAOJ/ofW2uvG2kL8EYuM
 CI5g==
X-Gm-Message-State: AOJu0Yx1D5IE43b4EqovK8cvgnuZiDHnNyivhJINIHUYJfJdcHYlNf3Y
 U8fmUyzn2gidNB6OgljxO8Dn49BvcWyxNHlVJ+IIkECnFDevOWRlvJQv4L+gObOiAIKNarxB5hQ
 j2V1hEV8M78j2KDGqOrWbm7qywJIB7gult35RqyOwuF74SngHYKp1PW9V
X-Gm-Gg: ASbGncuMiQqE0QQ1ypw7yDeZ4CTUgp+ovOqOUenLkeiZSTLKDjAN97AlWBej+n3G48N
 ZEGEfiuJ9tYiuIFJeTNc8/sGB4KgRpSc/GexEJp3/2pyyyY7WFmVbzP7Uz1ocnCrC8t8gSB+viR
 aUBlPA8FbFpkxjWOOZjkdIKBxXvr3gyIkNn7Nijaruw5tgE4nMPb5VD8okRbYRYKvXqeJlowdtj
 H495il9DmCiG6g4KGW9GmVrOyaopOr2VzreWKj/PGG3nyZSaLx/WMeXLf+M9MfYcVTdNRNS8f1Z
 BWjEHCKWzrnkOJ4GbVt1uaXEUj3r+RemPjKU3YbFzjzEy7CsDV1bHO1Bf6uCTAlZwdKgxl7kytI
 Vzub0
X-Received: by 2002:a05:6000:65c:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a8ffdbf0b1mr14234523f8f.31.1751370344849; 
 Tue, 01 Jul 2025 04:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSW9bEUOXnOKFHKpkrkm3rildAF2jAmF6FtAz4xLYpXhOgQUw/4Vr59an2+e5eas35ixxLKw==
X-Received: by 2002:a05:6000:65c:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a8ffdbf0b1mr14234504f8f.31.1751370344423; 
 Tue, 01 Jul 2025 04:45:44 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a306a01sm171978155e9.0.2025.07.01.04.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:42 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 19/21] qapi/block-export: Document FUSE's multi-threading
Date: Tue,  1 Jul 2025 13:44:35 +0200
Message-ID: <20250701114437.207419-20-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Document for users that FUSE's multi-threading implementation
distributes requests in a round-robin manner, regardless of where they
originate from.

As noted by Stefan, this will probably change with a FUSE-over-io_uring
implementation (which is supposed to have CPU affinity), but documenting
that is left for once that is done.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block-export.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index ee30606680..9ae703ad01 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -163,6 +163,11 @@
 # Options for exporting a block graph node on some (file) mountpoint
 # as a raw image.
 #
+# Multi-threading note: The FUSE export supports multi-threading.
+# Currently, requests are distributed across these threads in a
+# round-robin fashion, i.e. independently of the CPU core from which a
+# request originates.
+#
 # @mountpoint: Path on which to export the block device via FUSE.
 #     This must point to an existing regular file.
 #
-- 
2.49.0


