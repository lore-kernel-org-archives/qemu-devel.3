Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE090CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0D3-0007dt-03; Tue, 09 Jun 2026 13:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Ch-0007O7-Hp
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cd-0001qh-Dm
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAvDvHwNOpZMXGaEBVC9aqY/2Ki2d+eUzFoO5QqTfx8=;
 b=XhNQvRTLSepVBGM2GfTwGIwzwqMlyhadlREq5mNG5z8iCBXe2/pyCI7mV3opvAjYl1XWDY
 iDEGqrkoXwZgtjaJ3E9uYG2WASkdv+A12mllFm53fISifl4Ae4KcnFpXqwjQsBF0u+bpsP
 8NiDoGK1EuVlQ6FMREGfaNasKlQWD/A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Izz0TyI5Ngy-e6IiNuWBYQ-1; Tue, 09 Jun 2026 13:25:24 -0400
X-MC-Unique: Izz0TyI5Ngy-e6IiNuWBYQ-1
X-Mimecast-MFC-AGG-ID: Izz0TyI5Ngy-e6IiNuWBYQ_1781025924
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51776d4355cso161051981cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025924; x=1781630724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAvDvHwNOpZMXGaEBVC9aqY/2Ki2d+eUzFoO5QqTfx8=;
 b=cCmjGo5Y5q15LpK/ZqA39f3uImeAaIxiBTZY8/oher2MSlA4RdHLgg44hYEPbJedC0
 d2mXEkPIrj5LSWDXB/3u65cAgz4m1qK/TTZN2CjUC7/Dtdd33mdvTd20nMJbttneWySi
 drtRSsiOb5oJg4ff+ftChNZcXGBPh20r5mMNKmjiJ+pLCLqCzJob6xNjdCRICZZR9rXL
 qUT/xjzp4QQFl4/Usis2+cGm2Gx/NuHG8OnIs7pmVKY97DfiDiXwbwb63vKBR8EeNj74
 X7UVl9ClO65QxZMTaUbv8MCBGqK3ajjEWjiPEzvBiE9E8qsirbFkdE/sJwzy61p91xEp
 k4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025924; x=1781630724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TAvDvHwNOpZMXGaEBVC9aqY/2Ki2d+eUzFoO5QqTfx8=;
 b=GlYZTq6d3AwOWj/9ApphmivNsUyfHTHpKcrRVTAr2MCZWizqctSf75y8ektYwrMEzw
 94zoL+dsROn4EwzufdHQOjX34VL1o7o1TUirg1nf1nFLjqWjkjeJ3fsz514DiubVSrcJ
 YBcWz4oNOHDBox5BJ5HRFIS1yLUREbIVWSVXkUEMgXj7jfmTsYbW2oUAYyQ+ITVZd2cr
 3fBSpBs1TwLqWlVhayhUwLUMT+D1I9C+iUTeppUWtxhY5xnuyxv9LYAMBi3sKFfHrA1r
 cNERCAO31OEMwD18h2e75bc58Yz4GrbOmsmbddUz9Pq1zUH9D2nFH2ZKtlpgWg+mYd5V
 +IGg==
X-Gm-Message-State: AOJu0YxSnyjTACqra78bAyDBn5TlPcCZf6xSVdxlm8bgUUgYdvdwZXJT
 1DXsuRMH7YURpzddNRNQ+pSrn9lJLalQqx0sfq4Y2o4pWvlcuH2+SqVxTzSR0ZKv4wmlxyvSs4Q
 WmcfegcLu2bSKh4tAIVCH9NnxV97Q6DdBVrdyr/WnXK5S+8dRLwIZG9r+YrqQ4h/+ypTiIL4xLT
 0R3x1ffUClgDiEnKjyEFcWiJmMwcUK4jGKYuIAgg==
X-Gm-Gg: Acq92OGoEZTleq0Y1zB7UaLGJlw9pNLxDIqIupF42LSoSM2soe3PthufflFDYv1PHeq
 y2QKU3al0ANpWANEWKQ/M31ke789amkqUB6vZ3wRgyh5lvIibj9cuzVYzg8SYtYw88KX4CPPmEa
 mFZF90Vh1o4ccLt1hZMl/MxkVeXqP1TFU7b6ySGt2ReLEwjNphQTwTjJfwa+gz+2NlJnuI4h3xb
 vX6FVQYrfFk71rEhqalLad9PRTH0+tdyFEcdl1GE9UmFVFsJmtlc6z7KSIoJD/52KmbT8ZVlvsd
 1MrTKnJ6UoT4II/F6wqnhu6HuMZM3grEe7iEZiWQYK10uhZ1HyhDDJEZIkQhkvAtt/jX/j3oSG+
 oi4mIdtogg0OSGriLzIFz/Kk=
X-Received: by 2002:a05:622a:a593:b0:517:7871:693f with SMTP id
 d75a77b69052e-51798672991mr221134961cf.8.1781025923976; 
 Tue, 09 Jun 2026 10:25:23 -0700 (PDT)
X-Received: by 2002:a05:622a:a593:b0:517:7871:693f with SMTP id
 d75a77b69052e-51798672991mr221134161cf.8.1781025923234; 
 Tue, 09 Jun 2026 10:25:23 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v2 03/10] qdev: Introduce DEFINE_PROP_*_NODEFAULT for
 bool/uint32
Date: Tue,  9 Jun 2026 13:25:07 -0400
Message-ID: <20260609172514.2037645-4-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609172514.2037645-1-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce two macros that will be used in follow up patch to create qdev
bool or uint32 properties without a default value.  Do not introduce the
rest until they can be used.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/core/qdev-properties.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 248bbcbba7..43878d1f9e 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -124,6 +124,9 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                         \
                 .defval.u    = (bool)_defval)
 
+#define DEFINE_PROP_BOOL_NODEFAULT(_name, _state, _field)     \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool)
+
 /**
  * The DEFINE_PROP_UINT64_CHECKMASK macro checks a user-supplied value
  * against corresponding bitmask, rejects the value if it violates.
@@ -201,6 +204,8 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
 #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
+#define DEFINE_PROP_UINT32_NODEFAULT(_n, _s, _f)                        \
+    DEFINE_PROP_UNSIGNED_NODEFAULT(_n, _s, _f, qdev_prop_uint32, uint32_t)
 #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
-- 
2.53.0


