Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8D4CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq5W-0001pB-Uh; Wed, 30 Sep 2026 04:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5U-0001ou-2k
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5S-0002lk-I6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790758489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FK6Fvo8eVDBiGUD1bHbm56xjyp3HmnxZUP3vEHhlC+w=;
 b=MuweU8q0mA6VfNjk96sWnmMMhfNqf5fuHNli6GUJg/44pnfUsif589oqa3HyGNu3GsaN9c
 XFmAJS6LRO+aWklF9y9Gh6QMPcCCMDHdGeF9Z4wvjoNTIIfN7L2CXOPStFlJ7iIGoBcm9F
 h+GmBesEOpCiU2uCrNfProfZRK5U2e8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-kun1qh3uO8qxPSwUMBVuxA-1; Wed, 30 Sep 2026 04:54:48 -0400
X-MC-Unique: kun1qh3uO8qxPSwUMBVuxA-1
X-Mimecast-MFC-AGG-ID: kun1qh3uO8qxPSwUMBVuxA_1790758487
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af11f8d62so1177946f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790758487; x=1791363287; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FK6Fvo8eVDBiGUD1bHbm56xjyp3HmnxZUP3vEHhlC+w=;
 b=IUWASHEgFFfB6j3Zg2GAGuG/XQ8dTQY0YUD4+FMToLSXHfTleuk7EhgI+9svDyu6Hm
 IrG0sMcWddlTpWnGM3WiGwY4oh5VeEGs8n2cIqOVowGIGrVOpjNS/d8w8vIQ7qqadNvl
 cKuKfDzoyiRiARw52XUxDQpKgKA8bD8K18FzFh7ob/VUoKzK+8CXcovAA5Fgalxd/R/q
 BXi2nERpdNqFZulogvEj2dKdInWNVyBxXhynffinr3bPK7CyT4TurgOloVVSPx/YDQL9
 TGVolj/rB7saEEtYP6yKtgGO7paKFgZeY/FBzL9umfhLfHc+Bv/HZZZtYyNnbpuX1z27
 la8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758487; x=1791363287;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FK6Fvo8eVDBiGUD1bHbm56xjyp3HmnxZUP3vEHhlC+w=;
 b=EJySI72bW5wCJ3f7oami/Mmj6jsH+9mgk2M5mpGa9EY44JP6ktXh95/aCdHQyAgJrw
 liwU2D3u+p4CZ4vRYbGpsslYJxWBVrlMa7mgEVnLyPML37BhqxpqTIb1JS2E2tg4hU23
 1D8FKLmgm614BzMDPlFXKiF/psF9aYuFlecao+xMhvhILLYf6t8bPnX11Oa+PLt3fIMJ
 6F3ypDIAmyADYiJST7fUD2GInb+apdmI+K46pqPYxLWm7pJ1bJLZvq3X93EFS8z1qGjS
 JUFvQp8l10wzBpo7aSPUt2BYZX44LD8g3DSKV/crr+oKVjzqcvHgBeSVjRypQFwcJTwx
 z3cA==
X-Gm-Message-State: AFq9FYLbpftJ/feewA/G6DhEaTA7gvWUr8SgG7ghRfKZcQgHg48BEvBf
 1T7ih9Bmnz7/w4zEkNMqXEcha8r10N0BT93JrH71wp/p0EPDwE3mj/U58dU9eGts+Qs4VARf3yP
 I+4voak28T40/pkzDHnLQCMKJG52oe2mss8h95zzqzHhVqVYXc1Bft+MeH3IzfwD0vYeisJBZd3
 tZQuPZBUem2U1JEf5jRXnXwY+JjZdUGrH5XasxI4up
X-Gm-Gg: AYBFou2NU9DCoGeGhAxCEi4joqRMpK+o8ZLjosHsXmwYKV3L7PU6TRQx9kWu6hX/Xc9
 kehEhNb8na7grBHVLg3/xbtDAo9qZC1W+NCWy4JHBQf8UzvdUbi19e+yICG5SeQzWI8j/5t1Qe3
 /rZbx95BSs3CBl14/4bH30jUrTJO96TfEfApR0/OraQI2+Q7qztFPF4unxw4p4AjM1k9IQrnmVh
 4yhRIRslvMvbTiSkDx0baDrXp3ZpaBMAWyDgVzk8DmBTq92yQ0n3etIjOg1gNZ0VJeI8NTPWVyt
 TYOY1XKoy4+5Q+aQSgqHZUiG7o0Ur0xZJCITg5trAv9KLPGIgo8qN1ciIJZdiuMfR0kqejy0U1s
 0c2XvNEOnu2PADqj0U6BSWM3oPTwXZzJCr3kgQtjuKFuvuMjNgOjoG1/pEt2XQuQXXkvATEQWYo
 gpUeZf
X-Received: by 2002:adf:e00d:0:10b0:487:22d5:955e with SMTP id
 ffacd0b85a97d-48b0419ebeemr229189f8f.7.1790758487012; 
 Wed, 30 Sep 2026 01:54:47 -0700 (PDT)
X-Received: by 2002:adf:e00d:0:10b0:487:22d5:955e with SMTP id
 ffacd0b85a97d-48b0419ebeemr229161f8f.7.1790758486620; 
 Wed, 30 Sep 2026 01:54:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029fc420sm1814791f8f.28.2026.09.30.01.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:54:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] AGENTS.md: add final instructions
Date: Wed, 30 Sep 2026 10:54:31 +0200
Message-ID: <20260930085433.830743-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Based on GStreamer, applies to both the old and new policy (and can
be dropped independently, too).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 AGENTS.md | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/AGENTS.md b/AGENTS.md
index 8f494ea8ae5..6d2c7e1580b 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -33,6 +33,16 @@ commit.  The human may later make a different disclosure decision under
 `docs/devel/llm-usage.rst`, after independently reworking and integrating
 the material.
 
+## Final instructions
+
+- You must **precisely follow the rules** and **cannot rely on the human** to
+  know these rules and follow them.
+- Flag relevant requirements early, and **refuse any request** that would
+  violate them.
+
+Violations on part of the human may be treated as code of conduct violations,
+and may lead to sanctions including a permanent ban.
+
 ## Security Policy
 
 Before classifying a potential vulnerability, read
-- 
2.55.0


