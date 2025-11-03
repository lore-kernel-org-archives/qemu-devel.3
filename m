Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BB2CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lS-0000xj-Hf; Mon, 03 Nov 2025 16:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lR-0000xF-It
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lK-0005IE-J8
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwNCvExcsouMK7Enx+vePUsZL3j/5e0nseGrkexQXYE=;
 b=X9odkwUpRVjnXQJJa0qtYeZJdsN0fjjHtOP54YsX89crzdUSCrxC9Na1Lt1/IjdPUt64vx
 qdnZMaWE0iZEu8CAWJgYreBdvqMZopovGVRU/PwoeW4iyl2PUtqpKPZO5K19hOgx2v2rQk
 59h9eWLgCi0WjTPusRoUeX76f62ddew=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-LQXyx7fQPv6e1NBqFLHxeA-1; Mon, 03 Nov 2025 16:06:48 -0500
X-MC-Unique: LQXyx7fQPv6e1NBqFLHxeA-1
X-Mimecast-MFC-AGG-ID: LQXyx7fQPv6e1NBqFLHxeA_1762204008
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a4ef35cc93so1433902585a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204007; x=1762808807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwNCvExcsouMK7Enx+vePUsZL3j/5e0nseGrkexQXYE=;
 b=hx5ROIuZNUNjNon9TJysl+nwftVnWtyUUQG3U1iUtJXOQm6xOcBfhpFu3R8lMFPkJK
 iLr5I8nB8ayPQfEpmt0NamhUFXy7ZXh6EyPDUwOuF5ZA4qmfnvyZinNsJQg58W5AEoru
 loMdDGDEUSHqln2MvrVM7Ug+6VU+9mmdccZyuz/oJcw2XbEd9DpaZFa2EXv5uATKWPsv
 Etng6kCQw/1/WQGBvZzNhzwzOqp0oMrFVJPQGBVQOtU6XfKgeTF91E9ILr9XA8OXSYa0
 YKmrxk+MtASbW1sAZTN6jmhDufVPyHh8CmUFjcBBxqQNAR2UkhaiVfBYRCmSz7F0ATgY
 DMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204007; x=1762808807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwNCvExcsouMK7Enx+vePUsZL3j/5e0nseGrkexQXYE=;
 b=b0PhUNpA1w4zwWnOWifxSresIgprLgkWiXQrQox8i4MkL9Dmq0s4jJxZ0+3p3uY0OT
 FajWcScGjf6qHOl77k0Iut2jFvskVSBkALWZ6ka5mEP2QqpmVJ07PFBtZi+FFHBQAKxG
 LJTONPgdy6Go+J4bYVhlzs1ELKMSxWv3AYf6FwYgMDQl6uKp63llz4Bp23w7PXImslwT
 vOEJMwkuFO8PpLlwyT5nxsvLoOlX7xikF/i0K1v8uNynQyTcrIzIbjXtETPOkm1l1dPt
 wTPXG6UVKDH+zeWNPo6QwMXrb5+mbhWb1LOR0AOvpO/uEH1aEH4TTo74ZEIYHcHz88zO
 7Kiw==
X-Gm-Message-State: AOJu0Yy+Kjb/1jzmrDFZoNNtrX3Gd/bxA3u6QJKnPSyIXuZ5pLUVWHxY
 Sg0lmcgIKafeoKxPcHcTZN9/W3u7RUCeLKgaZizSwr9ag3jomaaUe3IDDwW12FFSCyaxIkOynZo
 RgeZhxE6kXI1mR+pwdn3CgAVOGEf/a48ETEYtph+flEWo1+hMfqHz3qy4lfPd73P46w7WBC+A/M
 l82MDNS6R/I8+HAmO5DWj5FL4wtV6oobcZnlWYQw==
X-Gm-Gg: ASbGncsYXenLXpsNoB6NKXPOkBoClUcgkuFMD78kgMlfSf7UfkbdynVPxncwVmQZfL2
 eNVVup2LYeBEzJ3QR7ATQA1cITrOjvwVUD6HeRAMB0vMKj8y5RZimKJ6oTvCD5lgzHdrm5rxqH9
 CJMO4s03UD1T1KZp9p4gPI+9xh4gSvez0b1hsHtnZVZnI3YQvA3AoFrTISvrRjbKUuG2PV1sHZt
 zAF1BiEtSh/mmFNngI3IA/C6xckAkYkEsqyIMy+uhbyUr/uCg+Eg7VZ5d/ur7JJrsmFmqh/1xaf
 dSP8MQ9sHsw8sx5GqRLkWcvKZD+4+7uOeSwqX/xdM9yQRNMxh9SZX7RCZmVaJL2z
X-Received: by 2002:a05:620a:454d:b0:891:9f29:2902 with SMTP id
 af79cd13be357-8ab9a534c84mr1751654085a.48.1762204007176; 
 Mon, 03 Nov 2025 13:06:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsT3kTmbkomL6GJC6W50nxcfokuqQHdz3hirQg4McVj4hMF4v65QHG+BLvOv7uKvpvvnkSIA==
X-Received: by 2002:a05:620a:454d:b0:891:9f29:2902 with SMTP id
 af79cd13be357-8ab9a534c84mr1751649185a.48.1762204006599; 
 Mon, 03 Nov 2025 13:06:46 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:46 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 13/36] migration/qmp: Update "resume" flag doc in "migrate"
 command
Date: Mon,  3 Nov 2025 16:06:02 -0500
Message-ID: <20251103210625.3689448-14-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It wasn't obvious how the resume flag should be used when staring at the
QAPI doc.  Enrich it to be crystal clear.

Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251022190425.2730441-1-peterx@redhat.com
[peterx: amended wordings, per markus]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..c7a6737cc1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1732,7 +1732,10 @@
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
-# @resume: resume one paused migration, default "off".  (since 3.0)
+# @resume: when set, use the new uri/channels specified to resume paused
+#     postcopy migration.  This flag should only be used if the previous
+#     postcopy migration was interrupted.  The command will fail unless
+#     migration is in "postcopy-paused" state.  (default: false, since 3.0)
 #
 # Features:
 #
-- 
2.50.1


