Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AF8F5A8DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSr4-0006Qf-07; Wed, 22 Apr 2026 04:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFSqu-0006NN-Hs
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFSqs-0006bK-5V
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGW6d9MttlD6p2S8pWbgXC+RAAlUoZve1q7FzTGw8jA=;
 b=Met57qBAdzwS1SkoopqTLc+qruefMDP6rNJvgjed1uZmY5XIwJhGI/nYVvt1zjNGKOZPux
 A5EHTuI3jZxHKIvDs9P0bVTDfxHgZawdT0jTVDBd6aAHjbhfUGTYT0lfPGfGBZgQkt7zNq
 /v45XCLRqTXK+8pwwCi4t6udo8v8AnU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-8mVpl7kRMCOAdd1UbmSdNw-1; Wed, 22 Apr 2026 04:22:27 -0400
X-MC-Unique: 8mVpl7kRMCOAdd1UbmSdNw-1
X-Mimecast-MFC-AGG-ID: 8mVpl7kRMCOAdd1UbmSdNw_1776846147
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35da1c703d1so6380603a91.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846146; x=1777450946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGW6d9MttlD6p2S8pWbgXC+RAAlUoZve1q7FzTGw8jA=;
 b=HonL48KzdTGZCHkQ5j5aXNfcpn4jGfipPi92OEmPZ4DWQo2tfbn8mXjK6a2yqgUwjM
 3N6FnT/GwudpMuf410Asl4rjjXK0r9zPFGaj+7KYrKhb9FWlYIPfQP+4ywTNT7rIT3Ad
 YuDXhMmHxLVrHmp1GyebjLZk5LjLCkGcCvaduXrVyU5WHtzY4vFUUPvQ+t2Kr7vNx/DL
 1hjIgqjh9HVYpzFeNs00gtbb6+JMPIZLQU/aXV2w48YjmakEiCUZ+LrKJoJber+ZMHCX
 P0cEPusKxzBLTlAPCGaSbkPISpXLXPTYnvAayQJUxUHNdIrkCsFyK/MqDnEjlyMxZYEL
 LRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846146; x=1777450946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LGW6d9MttlD6p2S8pWbgXC+RAAlUoZve1q7FzTGw8jA=;
 b=XvxNOHN1tXIjfsE1r79z53DDb+68OY7Itgn1UyCsIAhQKNACy4re6ggxKQcr3XO2Ka
 +bKWJAxoVafuEftXfsEkQPqMJ2VD4++ZaCki1wz98cMoomJYZPOW9hgZkyaxGIIefEV7
 cyUd3lrxPr4SfLLPoFYlYzvIdFILHaTAvfhWQcZoc4C5fidu5I9SD4yYQMovfnupI7LU
 u9m3RW8EQHtpOZtTDe2qBose++RxmS8Duk6FnaWhHYljkmezpvPe6evwfpGQXwMBskYX
 o2goPBzoDSGbd26FqdvTsMlC3CF7O5lODlhQ4hdXjmyVn1klAt+pm5Eey2qYmhSw98HZ
 1guw==
X-Gm-Message-State: AOJu0Yy3yGrI+HFDCO14LqSlwRn8rXbozYoocy7AYB/v3qE1Vb8CbiKr
 hk33SrzjN7dCu9v0muZTjCpzWOe/0bEXUFrCev39ab2p/5V9QKTuIdu9pmpvWt64iondQC7VytH
 zxm9UJAYncQ2gfd46UcnQ/LTm0KcV9XVhCn1IWYjnsjxxN0qfrdPWHhWSuK+j8wyHV126eE5skE
 32ovtJgw+8OuvTq1hWMRzouKHEBcU+3bqV02O/sXM=
X-Gm-Gg: AeBDies0YFXtoVmzwSRqWlMba2U8oGUbpUvk8Nl26mQ3yvaqKyLJ86YbY+5hqu7Sp4l
 a6XXHDFzJqO/LsRhQWPyGYZvrMGkFPwBldb+2lk2XWJfxFDTX5bnv8uK6ShesnqxaRgvVCvjKaC
 lVyfynjvdaOBuW4dxFh4PE22P2ZNHCfPvEH0aBXLd6qAwDT6M9MvkrfxsF8C9NLuK3h4eybKMG7
 KUTv/qpTh7mNN7nhkAsWki+mteds3YEsnyu61sP4CMP+sb0kMzGgmYRL8eVXgcrLG3ejoyfETLv
 LuRMEvATzP48LVkgE47SA+F9W7e92pm9kiJuEXCtFCij9QnAMgpgcbStgUivGUbQVeZct8gUdAa
 0Gh270JtWp6gNsuI21H00ubbt5vlZtBRM+kMUSuDk1f4LCMaYtilPn9f8ebDEndsyqgfoJe1pQQ
 ==
X-Received: by 2002:a17:90b:5865:b0:35b:929f:7e8d with SMTP id
 98e67ed59e1d1-3614046cdb7mr22915034a91.14.1776846146519; 
 Wed, 22 Apr 2026 01:22:26 -0700 (PDT)
X-Received: by 2002:a17:90b:5865:b0:35b:929f:7e8d with SMTP id
 98e67ed59e1d1-3614046cdb7mr22915002a91.14.1776846145877; 
 Wed, 22 Apr 2026 01:22:25 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fabeccesm5991459a91.6.2026.04.22.01.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:22:25 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 2/2] ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate
 outbuf
Date: Wed, 22 Apr 2026 13:52:14 +0530
Message-ID: <20260422082214.10390-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422082214.10390-1-armenon@redhat.com>
References: <20260422082214.10390-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

Migrating a GLib GByteArray is now possible directly using the newly
introduced VMSTATE_GBYTEARRAY. It uses the standard GLib API calls to
create the array, or resize it.

This is safer than implementing a C struct and manually updating the
data and len fields. This commit uses the VMSTATE_GBYTEARRAY in vdagent
to store the outbuf variable.

Signed-off-by: Arun Menon <armenon@redhat.com>
Fix-Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vdagent.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index bb0c4aa14c..9206e47000 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -967,17 +967,6 @@ static const VMStateDescription vmstate_chunk = {
     }
 };
 
-static const VMStateDescription vmstate_vdba = {
-    .name = "vdagent/bytearray",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(len, GByteArray),
-        VMSTATE_VBUFFER_ALLOC_UINT32(data, GByteArray, 0, 0, len),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 struct CBInfoArray {
     uint32_t n;
     QemuClipboardInfo cbinfo[QEMU_CLIPBOARD_SELECTION__COUNT];
@@ -1067,7 +1056,7 @@ static const VMStateDescription vmstate_vdagent = {
         VMSTATE_UINT32(xsize, VDAgentChardev),
         VMSTATE_UINT32(xoff, VDAgentChardev),
         VMSTATE_VBUFFER_ALLOC_UINT32(xbuf, VDAgentChardev, 0, 0, xsize),
-        VMSTATE_STRUCT_POINTER(outbuf, VDAgentChardev, vmstate_vdba, GByteArray),
+        VMSTATE_GBYTEARRAY(outbuf, VDAgentChardev, 0),
         VMSTATE_UINT32(mouse_x, VDAgentChardev),
         VMSTATE_UINT32(mouse_y, VDAgentChardev),
         VMSTATE_UINT32(mouse_btn, VDAgentChardev),
-- 
2.53.0


