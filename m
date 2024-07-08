Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA21EC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiIo-000257-OY; Mon, 08 Jul 2024 02:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIg-0001Ut-FN
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:39 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIW-0001us-Vl
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb4a807708so26388085ad.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421788; x=1721026588;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RbcvfQTicnHYs0Rl8hdXG4yng/OPRtHTnYekAJzWw5c=;
 b=TSL/ASzMfySzCdwkGj+k0PF/nYjATDQ7OrzcqaH4avIcejerekELQ/8B+A39YkvZei
 xuSKgJXfZ7iWRb9sF4YPQpCa9pjCthOVegb98HNIOrznew/UhJnh4OUNslXx++ou6kuR
 tVhEElipNaoQY/5kDVQ0EevmqUTTOAxzhwW+p9gg+Uu4izJJrJ5gX2pdjU3yKXvB11vW
 Scv7zLLi/TqpkE9mlYm2ScpY3RrSq7NO7ozpi+Snsdq+jp+3m45iQJv2XallwicjM2MB
 5yTVlQVUg/EQ+GuR6kAS+v5HpsGEQd+UFXvpgD3PGVlR6hpzfgM/Wozw6FKoWKCqJ1Pp
 wtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421788; x=1721026588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbcvfQTicnHYs0Rl8hdXG4yng/OPRtHTnYekAJzWw5c=;
 b=lsMPh8A1YhredYf2VdxC7jzOqEYzck7CiOWal7P4FhUffLHGTGKTXVtMIaJ/7xo1tJ
 YM6FrXaJugzknczVs+SLGj6qtx/Ui2tisPi6Qp30X+FNFfU9DthdHfc7EAEVJUF3bfPx
 btCVjhLf7gXVuLm7DKIoSJUZl4xkI6eIiQ+7EqWWHQotA1nblkhftdhuEyG0JTeCfS1i
 ZjmyqzqqdCIPYiBahK7UZ1AAvfIUnsXy54nWlAOylgaaLpAuL8H0GJoZd5h0rs0Y04Zy
 FHV4eY4LpCElAsXuN4y/vU1FWWYXCy1ujufCykD4YBk1mBM7PNOlOf5m8ZclgvXb+4Ei
 1MwQ==
X-Gm-Message-State: AOJu0YzZ+9G5DW5bXBrCMtH/w0oo6QH2WS16YDgYR6eSYz8hKWgpmitH
 iMyYq38qcTcC5a4eH7dCR4NWW04cYZfv21CqS9v11DIfKp6jSVXT5utaU9hr4cs=
X-Google-Smtp-Source: AGHT+IF224MSkQyCWG97UaqlAKurNwMnUliBvemXdWNeaeRytihyIwE176LqgTxQEVJaVP5Ugh784g==
X-Received: by 2002:a17:902:e743:b0:1fb:7978:6b3 with SMTP id
 d9443c01a7336-1fb79780b8amr47259865ad.25.1720421787844; 
 Sun, 07 Jul 2024 23:56:27 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fb48c6a5c3sm53740695ad.13.2024.07.07.23.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:56:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:17 +0900
Subject: [PATCH v3 6/9] memory: Clarify that owner may be missing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-san-v3-6-b03f671c40c6@daynix.com>
References: <20240708-san-v3-0-b03f671c40c6@daynix.com>
In-Reply-To: <20240708-san-v3-0-b03f671c40c6@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

A memory region may not have an owner, and memory_region_ref() and
memory_region_unref() do nothing for such.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/memory.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e1bd29550c15..847c84c86db0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1245,7 +1245,7 @@ void memory_region_init(MemoryRegion *mr,
 /**
  * memory_region_ref: Add a reference to a memory region
  *
- * This function adds a reference to the owner.
+ * This function adds a reference to the owner if present.
  * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
@@ -1255,8 +1255,8 @@ void memory_region_ref(MemoryRegion *mr);
 /**
  * memory_region_unref: Remove a reference to a memory region
  *
- * This function removes a reference to the owner and possibly destroys it.
- * See docs/devel/memory.rst to know about owner.
+ * This function removes a reference to the owner and possibly destroys it if
+ * present. See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */

-- 
2.45.2


