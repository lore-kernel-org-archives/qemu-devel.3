Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B9B10AB827
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtt-0004Ap-JA; Thu, 26 Mar 2026 17:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rto-00049J-Bi
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtn-00038N-0k
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xl4BeA9TjT4adRjjwuVr5ck8x18mt6Jrccqdq1Pqh9U=;
 b=Dsv0NW9VMPdkxo9LcUYol7hlaBUiBN+UJfoO8QgMe/tjVqymEueu2HFLiI+TxY5wPqGiqn
 0krT6JhFs1i0XZPJ2G/S4AAwdZMV3t0rBsIRLKV2FJpib9jxYxuANQ17DgduOSsR28Nz/X
 y6+eNVOvxSCcptJglzikAGtUQLX+2fI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-5L501rjRPY-PKxq6YZvyHg-1; Thu, 26 Mar 2026 17:05:49 -0400
X-MC-Unique: 5L501rjRPY-PKxq6YZvyHg-1
X-Mimecast-MFC-AGG-ID: 5L501rjRPY-PKxq6YZvyHg_1774559149
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb706313beso250159285a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559148; x=1775163948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xl4BeA9TjT4adRjjwuVr5ck8x18mt6Jrccqdq1Pqh9U=;
 b=RLknSWMGyC/CqluCmFJ2jn/cghqwN4Cxtl7UNIo3tKqt+KlYcOqL+1Y7J/ywFUpEPT
 NrYx72f17Qq+N5bBkPlZGagmZ/dJaKqdwGSYq5FTjWnqz5EwTguDTvE8xWxvO7Cr/KQO
 hhnR2P06Lxt9SeIKstgVAU3Lm6GUBmh6JuNgUYBZrwzxpkrJMN64OubAOVwniTQEPVF7
 WnVleLDyuFVAGqf3OpX6U9r2Ox4ZEX8sUL6HKw+1LxnXMfeJkJqjBReSZun2fQQ6c6To
 jEAuNqVjmVNXG1lYGJyyzrwPClQANV42+DxCCD6/MuOL6HOgwXKbNrXna3j28zlSjwP3
 fK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559148; x=1775163948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xl4BeA9TjT4adRjjwuVr5ck8x18mt6Jrccqdq1Pqh9U=;
 b=L1hBtHDQD82VKVanfdQsLdVUtQOzHHrGtOa/7a9APe/S7xOtmifUtlRkWnFvEa3jsc
 EiIu2pLv7nr9L3mjmYoASY2l6dlMx0WuurcO1lgM1ZmDwTloFel5o0EqPA1W/rB8xHyr
 29VP26MIkSNJm6Bt03pJGh5h8ampL68yDalSeuqwg7bfwu3jyfU+mNmRsCkO2Didt17g
 pUdAwhU2/v0XksjzQ+jf2jleQMupUV3x6jkJmGifaYlxmiu6BbLDxt56IL/Gof2t+qtD
 AzMsJyKY/2BMld7nVMDHdpGdS1HZRxZ0EiMWSY7c0+2Z/qyUYJhKTLokYkFW2Ivi6zgK
 /McQ==
X-Gm-Message-State: AOJu0YzQwKdYM2DASQROQYJFfpbxdkZfnngIouvqEF12+feU59cXqxCC
 6HV5DaOY9JgVf5hlp6ErGaohYhrUec6y784UqB7XQUpQ92H+RXipqwEDO/4Wl4hoEZt2NtT+gjx
 Rdo3Z3O6eJe0BoEtathdu0EfCDOrBO5wqdHtjw343HAjqsz03Scrf2Ykaxg3HCZGSbuY6W6bucs
 SFZgMZPtFUFSIKZYdv/GxaPvJU9hFRlbztIMQ/5A==
X-Gm-Gg: ATEYQzzvJGi1BqOYL0P7DU30QyZaVzKEwjejNq/N/Fr9Zm9fnLl2vFXJkAWZYKYMGNC
 EVwUNEPvBdWAU5VevRKVRev/95kxm0QrFLzSfall6pDCj8RtwyV3O0qH+IifiTZVjONwuoL8vxF
 aLboWfunh0/J/kqifuQj1irZ85FGDGZ/uo3djWQ507boU2C8NVJd3k5FawX7YX+wYFhR/CFGQbe
 eV+2ujBCY2smm9yNUo8dN6i38q+m8z/qLTElKUKfeSg2djH3vgazI+ELYmA3xVOOoKbGYCNAAy/
 TmZwO3Ei9YnvIaps4mvWvxf7BVs4NRYJFejEZlb66ZpRsfl+8ndY6qkwtGvYyhlro+n5f/GkxJm
 oPfKRA9k+IwQ=
X-Received: by 2002:a05:620a:400b:b0:8cd:b61f:2f48 with SMTP id
 af79cd13be357-8d00100bc68mr1252415785a.42.1774559148325; 
 Thu, 26 Mar 2026 14:05:48 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:8cd:b61f:2f48 with SMTP id
 af79cd13be357-8d00100bc68mr1252410185a.42.1774559147640; 
 Thu, 26 Mar 2026 14:05:47 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 10/11] vmstate: Stop checking size for nullptr
 compression
Date: Thu, 26 Mar 2026 17:05:31 -0400
Message-ID: <20260326210532.379027-11-peterx@redhat.com>
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

From: Fabiano Rosas <farosas@suse.de>

The NULL pointer marker code applies only to VMS_ARRAY_OF_POINTER,
where the size is never NULL. Move the setting of is_null under
VMS_ARRAY_OF_POINTER, so we can stop checking the size.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 9cd0a88ce9..1923602f3b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -673,14 +673,14 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -708,7 +708,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
                     for (int j = i + 1; j < n_elems; j++) {
                         void *elem = *(void **)(first_elem + size * j);
-                        bool elem_is_null = !elem && size;
+                        bool elem_is_null = !elem;
 
                         if (is_null != elem_is_null) {
                             max_elems = j - i;
-- 
2.50.1


