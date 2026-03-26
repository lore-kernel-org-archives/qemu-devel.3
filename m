Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE3A10AB829
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtl-00048F-2B; Thu, 26 Mar 2026 17:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rti-00047S-O4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rth-00035w-75
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhAUULl4qMWtcriJZslSelYi7+LKHXIebTcjt2KeKTg=;
 b=XFci+OH38VjnIzycQlYKsNGN89ZHEVLCf570AsevZHR+H43Ql/asJXx4vFSk9ySnEVOXIt
 cjJjUytNSLbSpOBzjQ/3YlPVNNn+JKlUREeh3h6Ih4OPG5p/BFe+8X9pW3fJ5DCTKNIVEb
 ObeUSFwhPafwx8IX4choMJ/E3amb9FI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-wpuKSBOTOGWt_Faie53Rag-1; Thu, 26 Mar 2026 17:05:42 -0400
X-MC-Unique: wpuKSBOTOGWt_Faie53Rag-1
X-Mimecast-MFC-AGG-ID: wpuKSBOTOGWt_Faie53Rag_1774559142
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd827a356aso353776785a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559142; x=1775163942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhAUULl4qMWtcriJZslSelYi7+LKHXIebTcjt2KeKTg=;
 b=pjGdl4yfSRUU5G6GDqSS++c0vpezSFiyENIBpWV/0UCqEu3+JWw5hauy0jvZ8qwkxj
 olI1L4xgHT2XOGiUFvr5PdsL/hPjV2pawuaL3cSCpy17moXPwMNsJkOiOagA0NOQV0Iq
 yIbdmdfkLJvodwU6uGwGOoWhzpfj7UE/Dsnne+XdxHd1jJM5aDEQb/vycdpTgIAf2CLB
 srO3lktIv53X6wJ/bhoS4c19hYpR2DdXS/yWTaa3+1ogpH/ro5mRvYvIdW95noqT4Nrh
 UJdR8UcXmzOzmatyK4j7PPGzndzU69ri3aHhU/zR9riYwzW8ZRpYf6ixvgH7BnRFw1f7
 dFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559142; x=1775163942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NhAUULl4qMWtcriJZslSelYi7+LKHXIebTcjt2KeKTg=;
 b=O2Se81z2mDYKX4/6BrG030BvVSr0hqAxisWhPSfApLJmhLAml76UFlGTRj2OgHUT1f
 sgjls+dhqocdpVJKMgq73Jd6UzdbfAn1E35H5yNWyPORFZQKN86vNTi4Dx+qqF/7L6Ug
 wdS1bCQGCWJvtsi3vYk30ir+DWPa0Eff6jXzWTbZ2TI6dWsKlT6yqobrfqamSWVlZpT1
 aEYCyLv/yQodghAuYeTg0Zezesvuavj9k1pgB8B16sdFkH1fhgjFXvAq8U4u373r8hEA
 8JqeT75yf0kFuZn3AIAFp2l8LVeoALiPNtPaMjqXy8v362G2QR1O8hqA4hP3mqSn1xT5
 wSvA==
X-Gm-Message-State: AOJu0YyR2CDSCQ9AkW5LJnLK/XUojI33Xqv5wknTP85zx31SjXSbg18L
 g5dxhQL7kDGgeZfC+Psi4t4c85vcMGOni6wRhVuuEsqncUMMkxZNUz/eiVtgnXZcBvAG5H0n1M0
 dvbUhieGXh1/cmBftKGgevH6yNQQyZfDY2KU/OXmuIxgaFQiNaxiN36UbeO2VzM/y9taj893dy5
 qZ5vESbCrv4zybrd/h60MLYGgiHccMThEFPvH2YA==
X-Gm-Gg: ATEYQzygKDLhzRUteUrmyRzh1xldSfZv3QrAP0+RR0H7CKHUokFNy/pKgFb6uPV1lri
 Xnc2/DR3/BLx9JtuEzhyRWgzBaXSPaDzgL9ah806EEMymOUtwKtXqQXIxN8JozwuE4dadkRbiJj
 wFzhQWdvtC13PBnTl5NN9pbEoleLsXUAJxow5l78BnG1byrtATZUhPP4MrF4l3HL0cBt77+fCuD
 N1yWKAlCj3GssbkJiharx1oN/fpMZHRkeJP7mO+1dA+1LSitxQANnU0jg9YcIXeDJ3ayhuNHIlr
 Q0ULMC9WyYEwDrIWGnnxhHlc+aMl2R5aLidRN6PcaYC640+lR8Uu8owYChJNZrKK6e+DkE1pHDi
 873YJXDaZK7Q=
X-Received: by 2002:a05:620a:4591:b0:8cf:de7b:42c8 with SMTP id
 af79cd13be357-8d000f1dbabmr1302952485a.24.1774559141748; 
 Thu, 26 Mar 2026 14:05:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4591:b0:8cf:de7b:42c8 with SMTP id
 af79cd13be357-8d000f1dbabmr1302946085a.24.1774559141193; 
 Thu, 26 Mar 2026 14:05:41 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 04/11] vmstate: Update max_elems early and check field
 compressable once
Date: Thu, 26 Mar 2026 17:05:25 -0400
Message-ID: <20260326210532.379027-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

QEMU has a trick in vmstate_save_vmsd_v(), where it will try to compress
multiple JSON entries into one with a count to avoid duplicated entries.

That only applies to the cases where vmsd_can_compress() should return
true.  For example, vmsd_desc_field_start() later (who will take the
updated max_elems as the last parameter) will ignore the value passed in
when vmsd_can_compress() returns false.

Do that check once at the start of loop, and use it to update max_elems, so
that max_elems keeps 1 for uncompressable VMSD fields, which is more
straightforward.

This also paves way to make this counter work for ptr marker VMSD fields
too.

No functional change intended in this patch alone.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index e29a8c3f49..05badef42f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -556,7 +556,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
                 bool is_null;
-                int max_elems = n_elems - i;
+                /* maximum number of elements to compress in the JSON blob */
+                int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
 
                 old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
@@ -587,7 +588,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                  * vs. nullptr). Search ahead for the next null/non-null element
                  * and start a new compressed array if found.
                  */
-                if (vmdesc && (field->flags & VMS_ARRAY_OF_POINTER) &&
+                if (vmdesc && max_elems > 1 &&
+                    (field->flags & VMS_ARRAY_OF_POINTER) &&
                     is_null != is_prev_null) {
 
                     is_prev_null = is_null;
@@ -626,7 +628,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 /* Compressed arrays only care about the first element */
-                if (vmdesc_loop && vmsd_can_compress(field)) {
+                if (vmdesc_loop && max_elems > 1) {
                     vmdesc_loop = NULL;
                 }
             }
-- 
2.50.1


