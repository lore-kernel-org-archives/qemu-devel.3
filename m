Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD86F10FCACE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BU-0004Md-Hi; Wed, 01 Apr 2026 16:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BT-0004MG-E7
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BS-00039h-2p
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9nFC8fExKGiU5GjHp52oB/dVp37pPXgo7vivdw5CVw=;
 b=aJqXC1xHk2LfuF9kulirMN90aDc+4NQBFdE8NzdILo3hRBnSh0K8dXrR/OvHoICuOjPKeI
 7jqTZiclCUjampUdl/Feck+s7UDx+z7Oal5NG6nv98ColgyILfI2UxbF12eki6Sw7R2fC7
 XW1d4Uiomi9Pv/oDfxfAa0uBEMN8rxE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-qZij9Bx5Pm6xHJpG43NQpg-1; Wed, 01 Apr 2026 16:29:00 -0400
X-MC-Unique: qZij9Bx5Pm6xHJpG43NQpg-1
X-Mimecast-MFC-AGG-ID: qZij9Bx5Pm6xHJpG43NQpg_1775075340
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd849cd562so69954085a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075340; x=1775680140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9nFC8fExKGiU5GjHp52oB/dVp37pPXgo7vivdw5CVw=;
 b=aDcUyit9vTfmsUQbgrzSbKUOaG39xzbt37CGir2rVQWTveJGkzfCbmtTXFWpJQwuLX
 CEdxosNcKCeM6y0Prxag5demdtFhi15dDSAcONJ6p8DD3qcnNwrq884jha8sh4Hjd8eD
 AFhrMYNORad/enPjToBmJhbOfV6SAvM/au5nfNxENepO0UsVqGmCWbrE2h1BsWOH/ndq
 hES1q6BAUVqJsrE+ayVS+WdZSQIxeJSUBS8NDojT7qHkMaewlLEJWbaST2zmWOLzFKsx
 sIKbzcqDvqodkjkn72WBy2USFg24CQu2TxauK8E+ilago8rYNuRX3HXrfCRKjisHt00J
 0wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075340; x=1775680140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y9nFC8fExKGiU5GjHp52oB/dVp37pPXgo7vivdw5CVw=;
 b=MXg1RIsbAb4+PWOvJIFqAOZMEv/ImXggqox++5RaRxGzvFmffcOPt1grMl6aJaZpOO
 zz0E9NX3m5Id0eq1d/rYGun5PjAaGu2TUVFmE9l0asZiZNswTjCIKrKz02obW8bLoyao
 282Llcenxjyb7pLvrEADOOkIrIvdjNKbXFZyLBLh2C4uk4sta7vRgKUTORt48hXrx6pm
 jjTDe7/22loKffhTIwdPLmk9fiped6dBNE7aklNaq9AenYOri6EevCWdAmsxeqC878P2
 +pxYUKewgOOWgSj3N5CerwSaBPrkzgYNju5BC1CEavpEZnkfRt2nOZdny1Wk2mzqbQdg
 gHvg==
X-Gm-Message-State: AOJu0Yxv69BZ0+PRiufzCSToWM0ZDM2kcLyKFcnvTM4b0xVu8Zrnr7JM
 jVRvtwN8h8sTnNnRauHECU3B9PBq0h5Vx628NvBDnEOafgQ0HARng9KJQKs0/PW5qjhe+ois8Gk
 R6bMyBfAEZVF5DtmjDJKjXSYQ7FqUy17P9oveF95iD6ozTH/imuFUhF0Lu6htAnmN1lYnbwltMs
 zq6bzyehDhsQmvNPDdsLIHQ3vrOoVyXvo+I8mRag==
X-Gm-Gg: ATEYQzzA1D6wkzQAdXMWuwdXhkEyv1+h21KiW0jVtdW/k96c7yCW/EhmEG27pH5U+nS
 ZRekedCpAUHH4E+8APhTLthC5hmO+nrX/93RD3TTmoZsiS+U/rRFSlVQ+9NbqqfCjm6ds+wSmuP
 inGJk0wPn+xxFfqokpQQwV7tWQEbQIVvzVwfFfb0lvv/MyxiKeKz9km4agjQjwkJCFdGHF+DPVg
 Y2DKDwLTEzpN9j7/duKp1qaX1+/nKi/xXV2ucD5TV7m1ducb37QqNPXud4HafKvCFVlB+LGmkUe
 jZ2t7VY7Klts1Srykk8v3kPXnJD2XpsEoSt/P3u4HqJH8x/6SLyWyphNLrcCGPCT5O3mzTBcq5S
 mHIWG1HNJTBuVTptWzNutcQapGMIWKeVhnm/S1JuP/Wc=
X-Received: by 2002:a05:620a:400f:b0:8cf:d565:fcbb with SMTP id
 af79cd13be357-8d1b5a994b6mr766590985a.11.1775075339442; 
 Wed, 01 Apr 2026 13:28:59 -0700 (PDT)
X-Received: by 2002:a05:620a:400f:b0:8cf:d565:fcbb with SMTP id
 af79cd13be357-8d1b5a994b6mr766585985a.11.1775075338860; 
 Wed, 01 Apr 2026 13:28:58 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 10/11] vmstate: Stop checking size for nullptr compression
Date: Wed,  1 Apr 2026 16:28:43 -0400
Message-ID: <20260401202844.673494-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Fabiano Rosas <farosas@suse.de>

The NULL pointer marker code applies only to VMS_ARRAY_OF_POINTER,
where the size is never NULL. Move the setting of is_null under
VMS_ARRAY_OF_POINTER, so we can stop checking the size.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index de2ad822e8..2f13b48a37 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -682,14 +682,14 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 const VMStateField *inner_field;
                 /* maximum number of elements to compress in the JSON blob */
                 int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
-                bool use_marker_field, is_null;
+                bool use_marker_field, is_null = false;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
+                    is_null = !curr_elem;
                 }
 
-                is_null = !curr_elem && size;
                 use_marker_field = use_dynamic_array || is_null;
 
                 if (use_marker_field) {
@@ -717,7 +717,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
                     for (int j = i + 1; j < n_elems; j++) {
                         void *elem = *(void **)(first_elem + size * j);
-                        bool elem_is_null = !elem && size;
+                        bool elem_is_null = !elem;
 
                         if (is_null != elem_is_null) {
                             max_elems = j - i;
-- 
2.50.1


