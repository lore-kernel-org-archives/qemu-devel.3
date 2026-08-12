Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15504C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAgk-0008Ts-Rd; Wed, 12 Aug 2026 11:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgO-00086D-44
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgM-0007Dc-Nc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuW++BxckSebbVYSJky3TOCAC5NfFrDSCOlGqtDgr60=;
 b=E3DvfXouY0OLwLrUStsuTb7C24VuSy8D69Xib8p5rwgwJwYK129dYXOGMP8rv9aFACxWGQ
 7f0UKDfXoEK0n1HnZ/q/42QmofwfxliEWj327wmrigrTgFRdhcbaF1KXTrsn468O/Npbc8
 ziPiJwLniTZdq/7zJ6v7hRuYp3gU4ks=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-5eVdpf9YPqCRkfR6LRoNaw-1; Wed, 12 Aug 2026 11:15:51 -0400
X-MC-Unique: 5eVdpf9YPqCRkfR6LRoNaw-1
X-Mimecast-MFC-AGG-ID: 5eVdpf9YPqCRkfR6LRoNaw_1786547751
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d28f8737eso20521831cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547751; x=1787152551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UuW++BxckSebbVYSJky3TOCAC5NfFrDSCOlGqtDgr60=;
 b=IlPTwvaBWuNpK++N6d4uHB1swJswWrDjw1T18R6ZBkfhV1xT/wzzDBIIqNCLvbXx1u
 Ozc35sD12S5s72mciYw30LR7JULxmtamPBrLZ+btyIp7b1Kk9CYnUaNRxXQNQXOgGYJf
 7wVNb1nfdjfqRNXDzFh4V+EpWdQ+kcrS8VfxED6OfbTa2BRwvZmL8Ry0HU0+/Yczbjvn
 IqxIExSHKzhFOEVV+/rtwI7KsuzaU7AsdPw7Fp4rBypvHtV3upg5movNgS+4XP/Rkkt1
 L/KDEZSS/mBz/gm3hou/IN93irsFoppYlyVZBvHXw10xgYJyZ1l1d+ISfyeZPJxFDYri
 wawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547751; x=1787152551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UuW++BxckSebbVYSJky3TOCAC5NfFrDSCOlGqtDgr60=;
 b=Gu7CQ9H7KMKVQ6LmC0rh3tiOEAJ3U0SxZiOCfy12qkb4YoMGmF31MzqobG5EBp09w4
 /SgQicmWndOdsP5J9mKZNJrqU37n5Uhf3RXInCXC47pLaPVT/LHoRG14VDlHV7fxSvh9
 cRdMu+yHBqrusRRt4tzjnGSnxk4kzNrVq7mNHiTJdcio+bb/wjf8k+js7kYKTn3yFBWw
 grx0luIItSOAkP3xTLlhmf/3SOYTPsdBwXOS2z6M9VoviaBxsMifsa8UO3/MD93RfBbG
 qS62XQ23T5DsSTcZr1i/UM5uPlLGIMj1eZKZhWyFx7/QeMgyGPk0iM8ACeOvaH45afuw
 W5XQ==
X-Gm-Message-State: AOJu0Yy5fnyC6G+LHZrLT1TliwRxCz8Q0U2bFtoeEFTykZ9lgSSniCl0
 EnMhMtf60dfa/j/gfhnlVaDc9syeviz/imMzpfjIwyG5eqHkQg23u/eBmdeURBWkBrRoBlKRTj7
 +1qKpx6QNNkMTanVoRDGaK7DwMDVL2n54TfPZhlIV3IhbuVP5Cl6r9rW7X+tp0CLkuvDGAzLFp0
 FpgnibvjNcCurf+aHZ5qgvvDimYVLMyHa1DyQuXA==
X-Gm-Gg: AR+sD12CxzXlF/EsiQsJAIYbCFJQkNbxHsvYQn/+e+pYxIxH2YHBB1FaU48LwtO+4Pp
 FXz9+amI/lHQ5DqpIuPJUmo67XuzrGdYPG4q9F1YZAvHauw1tRvGzN/ylwAjD3uKuyd6YoTtoCA
 DTM0JIAKChY6BHq2+EVxnTT38dDTwV/CoYsThwH/RJQ/l1tkc9zlGJ5Pp5SgGDftsmRUT32l6er
 VNAbjCMhwIpCv2vsePx76VYhikJ143yioF5X+AylWwqlF3hBqet87Zp4r9CXd/N9+sHCgwFNPUY
 AACUcC3KS4gfyRH8OlEa1fmDzhOsvGaxrJdAq5LrC2GFBWuRVpox0xWRq8sS3Zoppw==
X-Received: by 2002:a05:622a:c08:b0:517:5add:e449 with SMTP id
 d75a77b69052e-52d647ec62cmr57551201cf.22.1786547750761; 
 Wed, 12 Aug 2026 08:15:50 -0700 (PDT)
X-Received: by 2002:a05:622a:c08:b0:517:5add:e449 with SMTP id
 d75a77b69052e-52d647ec62cmr57550181cf.22.1786547750234; 
 Wed, 12 Aug 2026 08:15:50 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>
Subject: [PULL 09/10] migration/ram: Check for RAMBlock size mismatch when
 parsing
Date: Wed, 12 Aug 2026 11:14:42 -0400
Message-ID: <20260812151444.2611689-10-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add an underflow check for the subtract of total RAMBlock size to make sure
it won't underflow.  It should not happen in production systems but only if
the migration stream was hijacked, which is not a real concern since
migration channel is trusted.  Still protect against it.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4013
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260728210417.1925078-6-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8918b2f03b..85feff578c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4268,7 +4268,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
     int ret = 0;
 
     /* Synchronize RAM block list */
-    while (!ret && total_ram_bytes) {
+    while (total_ram_bytes) {
         RAMBlock *block;
         char id[256];
         ram_addr_t length;
@@ -4285,8 +4285,15 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
             error_report("Unknown ramblock \"%s\", cannot accept "
                          "migration", id);
             ret = -EINVAL;
+            break;
+        }
+
+        if (usub64_overflow(total_ram_bytes, length, &total_ram_bytes)) {
+            error_report("%s: RAMBlock '%s' size underflow total RAM size",
+                         __func__, block->idstr);
+            ret = -EFAULT;
+            break;
         }
-        total_ram_bytes -= length;
     }
 
     return ret;
-- 
2.54.0


