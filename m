Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CD2FF6E9B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlL-0003ws-IT; Tue, 17 Mar 2026 19:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlK-0003wh-7T
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlI-0006SA-7B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjG79rNrziyooP9oARcvWCdnLH3yo6F+TaDuNY6Nuzk=;
 b=UrPUDCSEB3owIw+jzKYYLg1tjVtgOKFqo9+lAnXM0DhkIKjFxDm+Z5lDP44xI0IYEVgE/c
 bTg0THVqKlVxmfGA/gBqUF6pdQ2dtNOImSAtPclL31gfk0p0ze9KgulGf1+ixtnrqD0mXF
 gEtDnd03nxWcyIcjXQ3rDigLGaw4BMU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-j_jJGZdQPeajA7uJw0OBpQ-1; Tue, 17 Mar 2026 19:23:42 -0400
X-MC-Unique: j_jJGZdQPeajA7uJw0OBpQ-1
X-Mimecast-MFC-AGG-ID: j_jJGZdQPeajA7uJw0OBpQ_1773789822
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89c3deb4185so208135976d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789821; x=1774394621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjG79rNrziyooP9oARcvWCdnLH3yo6F+TaDuNY6Nuzk=;
 b=kiklyJyJi7lp/JjFxo93vRX9ovMxF0k4imljcYR9Q7M6BZzs1tj8EbIa6VmOFK+qIP
 6Tw1fV1zcDXVYTueXrkZivNukTDk6k2Pz2VTfrTvwU/GDCBcTF9IN4DpoxSc5k5BRj9F
 F4Te7hFixheGSWuWId6RWF99/e6syfJlBElhX/D2FevA8gibTIDYORH4AoVylsgxxhNC
 1AYo6LWeDY77Mkdh/2Xg2PRc543gjNE5Ce2skWyOSONPI1ZSzR/gKXPgzMUz24iuxdz8
 w3xGOWnpWKewdl+NwGox7d298F4MCErW5Mh3VMhl+O1/PIvEOyG/cs06KJ6EZRXbhZxu
 rzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789821; x=1774394621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TjG79rNrziyooP9oARcvWCdnLH3yo6F+TaDuNY6Nuzk=;
 b=Up6K/vNYySfjOnKfdKtbLPFg8Q8hD4QpSDRee2B+21tGH5YZfzllDh1YQchYJdQm5A
 llcnRX746GBFU5Ik09nZiEglM5ElBn8Hz8xynihsfwoBmY97AN6bAy4wGoK2BpDHw/pg
 vH57uDUO+2DqN2XzGAifPk+Tqqy1+zOBVv8rmwj4NHDAbtuZM/k/X0vGN9NztYLliUKZ
 jZGx6dLCA8jPPA1/s12ebQwS/qmW5IbZiOKdfNsGMud91G89rhmp97OqWMfMNsxxnu9B
 EbVFSQgXrxIXWsy8JPesj5D1HCPsfCkrYS8lkxyvM1d1vyhIOdU1+9UGUtKe00Ton9ka
 KlSA==
X-Gm-Message-State: AOJu0YzZRTR/9nv4KwgCGXfrRohm2qoffUnXtUPSfEsCtJ6cjRS3RuOH
 yQyvkBFufZ5BWc1y10nXr1b1bAjyTHEF+QBUkZ+glZVDEY71IqbXawXszt0q7JbMtEc4m4m8CrS
 U21MFDKI+Jp0zn3sKfh0u7GPegiGRoznpF2UObZJMhY2oMjdZWsADZCmsEaJByLNVTBmex+cLYK
 23bE6qJNU19NtAHhYUwXiOhpGyA3TfYslE2zMOXw==
X-Gm-Gg: ATEYQzx+8awXeoZ0mcef6i5YAvIYiFri5xT/1aAFmL+fB+6X44GIcVRHDenJ6Tey7iq
 ChXGg+Lbp22+wTzP2YuC+Jkbxssl08wk3XSv+dDj2k4Iso5KYDogU5480CnD2Ii8xq49vjXRMaP
 4Plm0vIbiD2cMaB3GYYcUHs+ipwUhVMvCfPtqoNvnNHTIaIYOO2n6zR6pbEMuPpjM32ce1V88/r
 X29/hO5RdKfK5Vm71l2hmQOZyM+1n2VVa8c9S4w+5/2XFHWF+iPeSOGuo7DG+yfJowbBjaaB2H9
 Pn05WUwYMgt9lKKyut/pRZMbuBxB4UaK6k5drtsH0tiwdvGXydhLQBibieU6UAJx9Y3MjaUuWi8
 9XGIrhP+oITo6Aw==
X-Received: by 2002:a05:6214:d6a:b0:89c:44f9:e87b with SMTP id
 6a1803df08f44-89c6b5af971mr24014106d6.49.1773789821590; 
 Tue, 17 Mar 2026 16:23:41 -0700 (PDT)
X-Received: by 2002:a05:6214:d6a:b0:89c:44f9:e87b with SMTP id
 6a1803df08f44-89c6b5af971mr24013746d6.49.1773789820984; 
 Tue, 17 Mar 2026 16:23:40 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 04/10] vmstate: Limit the vmdesc_loop dedup trick to
 compressable field
Date: Tue, 17 Mar 2026 19:23:26 -0400
Message-ID: <20260317232332.15209-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

We have a trick in vmstate_save_vmsd_v() where we will try to compress
multiple JSON vmstate field dumps into one line with a count to avoid
duplicated entries.

That only applies to the cases where vmsd_can_compress() should return
true.  For example, vmsd_desc_field_start() later (who will take the
updated max_elems as the last parameter) will ignore the value passed in
when vmsd_can_compress() returns false.

Add that check to the trick too, it will be used later to bypass this logic
to some special new VMSD fields.

No functional change intended in this patch alone.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index e29a8c3f49..caa7b50bce 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -578,7 +578,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 /*
-                 * This logic only matters when dumping VM Desc.
+                 * This logic only matters when dumping VM Desc, and only
+                 * when the VMSD field can be compressed.
                  *
                  * Due to the fake nullptr handling above, if there's mixed
                  * null/non-null data, it doesn't make sense to emit a
@@ -587,7 +588,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                  * vs. nullptr). Search ahead for the next null/non-null element
                  * and start a new compressed array if found.
                  */
-                if (vmdesc && (field->flags & VMS_ARRAY_OF_POINTER) &&
+                if (vmdesc && vmsd_can_compress(field) &&
+                    (field->flags & VMS_ARRAY_OF_POINTER) &&
                     is_null != is_prev_null) {
 
                     is_prev_null = is_null;
-- 
2.50.1


