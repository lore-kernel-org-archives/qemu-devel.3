Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF5F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtYR-0007zH-Ms; Thu, 09 Apr 2026 13:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wAtYJ-0007yO-V3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wAtYI-0005Mx-9h
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775757145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGW6d9MttlD6p2S8pWbgXC+RAAlUoZve1q7FzTGw8jA=;
 b=bBKZcwTssLKOaZvHKbtTof/Yh99hE2vnqfWfImtixCAppTQ+7jrLcw6RiY/Fk2poyEQLpp
 kgM61GX8HuIoOyMvcSjQxGaS57/g5QgrOGKU4ZbP39mjlYFBw2jdm7oG1SxiRX3lI2R1Tr
 Syp4OGI8RcNpZj8ctxH6ByUGlsmw17M=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-VYcm7fs6NOG2jOMi3KslXQ-1; Thu, 09 Apr 2026 13:52:22 -0400
X-MC-Unique: VYcm7fs6NOG2jOMi3KslXQ-1
X-Mimecast-MFC-AGG-ID: VYcm7fs6NOG2jOMi3KslXQ_1775757141
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82cf8dcd079so740301b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775757141; x=1776361941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGW6d9MttlD6p2S8pWbgXC+RAAlUoZve1q7FzTGw8jA=;
 b=YtW+B2IZLZq6/UfhvixdNxBddnqsBGzIy34ugcSwScDFp8t9Djy1uGTm5lwC6DVpRA
 wOn8Vl/qQYbAPRm4dh3ZTxHHf6rCPbUzz/DG1eKldKFY1vnmvBylW9J1TkwEOjSWV/3Y
 Ue3v+AOj/VYS+MZ4IU2qHiLFt7g5KUiF9qJ0PeiwzYkSMefI7MlsADVfB9HoADusnj7N
 GzMIWKYGCIJTci+hUPhIghMLsShK++pHTTfRbUH7IO8PvMcbUKM1nhlCgKpe4LGfIoh8
 Y++ceH+jPJUUVyDjnQAP3FZqHZIS+j6HaEDmgGDiFsvQKyaiZlgcw33HivzoiBSKnic4
 mPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775757141; x=1776361941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LGW6d9MttlD6p2S8pWbgXC+RAAlUoZve1q7FzTGw8jA=;
 b=HC+BdgM5TT20Bqc3CHtpcFF5Uu0lr1LhIHQ5pbJIySnpTLvyLxM2emYAh8cwnTqZ4Z
 3EkQXZsNcKBD88Iusg4YcEGczS8Ep80fhxy6+Qhc+ch6DA1uqKPKnum9gnEkEzu27O1V
 eZp4/Ah9Da/ayuK9uS/A/iXrXivzWuim2fDsvdTSTyMXtKjmyMICKOmv4cVSVLvLzlDJ
 2HJFTTWvHQzcozojaZWb244sWzgsozqtDWUO8mcD7TB7wxSgLhd6fXQlXUNeeYfj6h/n
 v4Rwsm+kw/BCiOfB/jnMvMTZZlABerW5cFc80Fui6XEoxwFqCSGZ24U7pYTiv4l3dAXa
 pKeA==
X-Gm-Message-State: AOJu0Yw137L70SDujFbOb/N0P51KVfWMSYRIKhz/OP/7qkgv/VebC3JJ
 6keTvpxyCbGYgm7D1eQig8veo3TyUeSoyHm3CMph2FNyyIaWp0t+L3xakLyIEEwoAjoQLTOiLRi
 vwWwmlIvf5BrD8pBYY89SJmQarjH+pNP/odWE27py3Hw9v0evp+ef6R8nyYc1zbjQGhrK/FcHUu
 AJXWLeLFz7Wt95V02oUVZHQOQpICe7OIsOBWOnRdo=
X-Gm-Gg: AeBDietyAkiuJumQs4MFMYIbU/C7ZEv0yDlQzxVMcBI2TS7Bz2lD8L0bUCvyD5xZ2rA
 +ArCyzS4iCy1R3oedm0eXoRwNUXhl6McPNSvoo7F9IQ0sEv/BqOdtaVQ+KCy86rN+AuBxfdLI7y
 l8du/WpfnXMWUce/aMoRg0HJ0aw5GLpMD2uME2qZnd4NszhsfgNwk6yR60kihDFeODmoUkbTK1a
 G4h8YL0ePTXb7E6iwL18R6+C52MENO+TZ2UbHpBOkSHd3mcPTvw8qTM3n+82UON1HLhs/hQoPg9
 XO2GJo7nATCFNejp95p7pzlbOy3b5rlaJLPZXHiB1clgfcQYGIXVdKoxA60mXWNv4P9L6WW4XVz
 HcE/b5Pi6hVEfy95CzoNtMCx3cXZq62eE2YZj3b/jV8F4HZNIcWcRhF/1hnPmnqU=
X-Received: by 2002:a05:6a00:369b:b0:82c:2468:a163 with SMTP id
 d2e1a72fcca58-82f0c22190cmr148701b3a.34.1775757141094; 
 Thu, 09 Apr 2026 10:52:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:369b:b0:82c:2468:a163 with SMTP id
 d2e1a72fcca58-82f0c22190cmr148667b3a.34.1775757140390; 
 Thu, 09 Apr 2026 10:52:20 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c52cf05sm27736b3a.61.2026.04.09.10.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:52:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v2 2/2] ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate
 outbuf
Date: Thu,  9 Apr 2026 23:21:25 +0530
Message-ID: <20260409175126.5921-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409175126.5921-1-armenon@redhat.com>
References: <20260409175126.5921-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


