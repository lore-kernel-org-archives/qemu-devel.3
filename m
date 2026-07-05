Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEE6C44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNxL-0008S6-4F; Sun, 05 Jul 2026 10:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxB-0008Jf-Dp
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxA-0001V5-25
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BKcbDf1CX3VPM01pSKKAbpI0+d2M2svaEBOIYsZZCWY=;
 b=VqNlyIab1X++F19X+7bzdV4MP8SzPGCgtva4d97NUrdl6orG6aW2HmxGqyBsjHznE43fmf
 6IpKe+V+I9qtrhQBm6Brk7NtY3WMOnoxgqEG16NJF+K1x73W8Ul8LoTecGE259WL0szEsd
 agTfEg3+P/LzE4kBLM24W/eZmeOJ9o4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-RcrcLSaDPSKmbcfblVv7SA-1; Sun, 05 Jul 2026 10:36:13 -0400
X-MC-Unique: RcrcLSaDPSKmbcfblVv7SA-1
X-Mimecast-MFC-AGG-ID: RcrcLSaDPSKmbcfblVv7SA_1783262172
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4731a357b0aso1721366f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262172; x=1783866972; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BKcbDf1CX3VPM01pSKKAbpI0+d2M2svaEBOIYsZZCWY=;
 b=dRbXPIp0RUNuzlxmsMy+uwJnVCmYvNZsqkFMzeOzOw3kCo1UzTCmvpdBZKhT5lFVfK
 IaSHsZJltX8nLUNr8aWKEIKvmPGdTzKYKvP1toX/jpaHXdioYDa0xfJhedN+C7lU1QHU
 +gjH8JVfgJJeuTVsy4VoKXyrb9BgMRg/lo0V2o6Z3ynVMUL13MVNXA/Cv8qtU17jyIOD
 TDleyw/CLwHDKkxtmuKMS3wDSWh2PpeC+ojy/4mtcHugCLKM8qek9uQncNfKLxb34An0
 +IjJPqN/vcFHsGzte9aM6t6G7nqDHELjAOnBtfbCQJlmAIiVlG2r/Rym96YXC7YQ+fdg
 yNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262172; x=1783866972;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BKcbDf1CX3VPM01pSKKAbpI0+d2M2svaEBOIYsZZCWY=;
 b=aOcHaL2KNMW+iOREhYu6DlzDdWBP7OR5N93GT9s/3d1CbnHMbg/GHevqmWCerYsWJR
 fhiIX9He9AcuQ2PZTn41WvxGj3ExhoRdPzdqQKjKuAIf7vZGXvBE99naqDNq2P3kafaO
 X9URtfKvkyWm0GK3zbEy+8+gFB0JVYVaXF0PqMUaCueQvDdKdW6b+GZYu5rCA7Wie8pJ
 fOZiOJDy+uNMv13qvrg2p9tafKF2qsK5Cef9CzVj4qTnwwSDHwVTVOQkoflOPd0zvCkG
 NoHP0cX7K6z6FZ5Wh/wjrfXOUfZlYFF6K5IfElhDQyi0zhQL5VU0uSu8yE9ly2TDoMOA
 Lmzw==
X-Gm-Message-State: AOJu0YxNOLxzaeP0EqdEUF8plFjHTt/Whk1MfbQXjQWMb8WGwZ3JL7S3
 YPohHH5t8aVKeQ+3ID7Q9hGP6H1GM3QhQ7enYw0APa3wOl6bC62RFlHaOlfVLMLRExp15v2HHCi
 UiGo/CjOy8E0W6xZlBjjYZQLaj9/jALAuQG2RKsaeax+yRNjMvm2AOzEasQfnQ5oqh8U208Dh8X
 hvPFJ+DZTAXYWTP6r6F8RgDN+3Br2J5QLz9w==
X-Gm-Gg: AfdE7cmf1/NPeFrxFYe+ib/GmR1a4PKQzNXUgzi0/Zqn4FYJt45QyC6Z00y4asePNdD
 N89Om/6qhJa8Fu3Wz5Q90MaXSMZB3tgM8RTmoEUdqgIESigLgbhh5bW1ePR1wSird7mUApDVR/K
 a+OXQoC0CFqrQvWqw/m7aL/lxYfjsz1fcUw5TDUOHG9Tagm+TY2HTtfeCQleQW1hvinUWBYLeqI
 eJ2VLOk4+XwJP7J/E0bShzE7hOSszHe2Klt7L9YEY85t5lTQDQhizrkQD5sDtcD/kP2X1+hmxUK
 8HRpl5JYyL5nh6L1hkoWYy2TrlUaVoAcURDjtYl7P87JD/ULDAwNWDC6zwjZ8CYdVsSI87hd0aE
 tlLSY2Zw66uGyjoMnrznhNdcyvfcS/49i
X-Received: by 2002:a05:6000:4811:b0:476:c622:d41f with SMTP id
 ffacd0b85a97d-47aadc0b977mr8277572f8f.47.1783262172148; 
 Sun, 05 Jul 2026 07:36:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4811:b0:476:c622:d41f with SMTP id
 ffacd0b85a97d-47aadc0b977mr8277537f8f.47.1783262171513; 
 Sun, 05 Jul 2026 07:36:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm19443056f8f.17.2026.07.05.07.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:11 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 37/44] tests: acpi: arm/virt: whitelist GTDT table
Message-ID: <01ba94bb27b003d9421dec125137c5701d261c07.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-12-imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..3e9be28cc4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/GTDT",
-- 
MST


