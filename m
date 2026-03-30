Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A209AFF494F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Bxw-0003YA-Fu; Mon, 30 Mar 2026 08:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w7Bxd-0003WB-A1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w7Bxa-0000HQ-OV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774874592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XEtNlQMSURhWjr4bhW2vb9KBkhgJ/FneDSc2xchDN6A=;
 b=GfwFggwTB8oTohdg/OamnIW8PHS6L+VpuoE5c18vcqK5P+zrVPZ1okyfJ5yImIm/OqNwfi
 ay9GzhBGUMVxlzk29HL2335OgX17di/rTqOTNHcPfSZNBI5GpczwzN00rQ0ThOzu/8KKzq
 VA1gyWlggD9mxIlEFG+x7w32YsKKcQ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-w-1WT2yaN-OLDTB9gWI-ew-1; Mon, 30 Mar 2026 08:43:10 -0400
X-MC-Unique: w-1WT2yaN-OLDTB9gWI-ew-1
X-Mimecast-MFC-AGG-ID: w-1WT2yaN-OLDTB9gWI-ew_1774874589
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-485345e2fdfso26499025e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774874589; x=1775479389; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XEtNlQMSURhWjr4bhW2vb9KBkhgJ/FneDSc2xchDN6A=;
 b=Prk/8hRzj8icu5H4xF2UzNKZ/l1sp5q2sWHk4Xhrp8z/J6upYKMYJyP7817b3HUHSg
 EacyalfpHARZT3pBR2IwLM4vwevXkUUVHIcYK7uruXsTq5Ks7wiQkeloXZGZ8IIXvlss
 B+BmF1QuV8AP8o/m8Vo8TIJ4birBx1cWmZyQKC3WmUUYVaRNzUC+ZvdTTRaivp2pG2MQ
 xikmyDoW7SkIHsozHux6pixmul4dUBVGcqSZvSwnwHHHbG5quseM5Ouw9Ck86IHfk9x0
 ppF3uzVJOidkK9yS/psXDdjVT65q3QShK4rpBkbHtfRy0EqAJy3rgbG7hEkvlQk2BK0R
 /D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774874589; x=1775479389;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEtNlQMSURhWjr4bhW2vb9KBkhgJ/FneDSc2xchDN6A=;
 b=P2ZhtMyQiVo1wQ7vkVdnu5pXPO5v/wIggGMfyiAO84X3NkzvgZvGAhkzfhq3n271t9
 60RC7g0g8/J6Et7Qc/uEF+lchu1iwROP0pHb9uoxbCegzIdoe+nJAW8pNGGKWRzKyIPr
 OV3HxLpG/1KdvNQY1H1cW+BEI8rm4sYwcsqB5A1ZM5YbXUvJNikha9LjEyDAMLsWDPzw
 vRSx11sIpBAW/idpsgWAEniij6Ta2omTHtL53ieXt8PacAuqQjZE0aCNi9VqBF/ULE7+
 JPS7xmKERHQDQVpKBHYd8OpeKcsv9a0/1lLwve+V2Zi0Hqs4IuAYKKGPLdrBs7UgJmTU
 qxUA==
X-Gm-Message-State: AOJu0YxLOkmuTPHgV9NqE7KRqOO/21DTwm/gVIwZ8TDd/McVmw4XpdSi
 54REoWQ4QqYLdl9Wl0bIC72e1Nk1qOF1ditLwGBKykF2kX8vTgthXsIW+ztPkm9Uq/gipEF2ity
 mg54h6+oGSF/mLerjk0teMZz1949k9W5KQP+t6Uu+W/YLcfhQL+Aa+Kf9
X-Gm-Gg: ATEYQzyT+6GSCgERSquraM8dHXCRkVB6bUd52ClnlF2/k52vr4lt4ACZCDEhWUPwZdW
 kQlhofh14MfXicYun9prHXHQR0olaLXjh6c9swNvLOZNGKThiOJ6X13h4u0+lz5/bLwd8SwIKA3
 uEd6XJP+f6XpPY8Q2WyYIxKWaXVa0u/SCdbliAVUmK05b5+nYVED0lCsdpiLdXBLyw2ps8ONsPm
 CuNwpvDFLM5hHme+4wTJsFhBA+Mt48EzYPJ1LtiNl95Y3NmdG1k6zKA8CSLA5T3l9HHUGLSr/Wt
 UqDu3Ju1YLQn2GpVYXQbA48TIaEHyK3qenKvlYnI28DxqEIbp6YgDyw49J5Fh6jG6Bae6tWFOOV
 SuQKPYWtvznx7kHxxTJmxgB9BiDKLDLvJ6uNBGu7nAoo3D4JPdTpr/zEKIGdz
X-Received: by 2002:a05:600c:3e88:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48727ee9897mr190389425e9.2.1774874589220; 
 Mon, 30 Mar 2026 05:43:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3e88:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48727ee9897mr190389065e9.2.1774874588741; 
 Mon, 30 Mar 2026 05:43:08 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487306996cbsm165319385e9.13.2026.03.30.05.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 05:43:08 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 0/3] igvm: various fixes
Date: Mon, 30 Mar 2026 14:43:06 +0200
Message-Id: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY2MD3cz0stz4tMyK1GJdC2MTw1RDU8OkNBNDJaCGgqJUsARQfXRsbS0
 A+qMWYlwAAAA=
X-Change-ID: 20260330-igvm_fixes-8341e151bf41
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Commit 1 switches from %lX to PRIx64 for logging
Commit 2 fixes a memory leak on an error path
Commit 3 fixes wrong parent struct for IgvmCfg.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (3):
      igvm: switch to PRIx64
      igvm: fix memory leak on failed memory region init
      igvm: fix parent object type in IgvmCfg struct

 backends/igvm.c                | 6 ++++--
 include/system/igvm-internal.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)
---
base-commit: 91f6a9cb1b0f11afa74ef7fb20d5579d9dfbe020
change-id: 20260330-igvm_fixes-8341e151bf41

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


