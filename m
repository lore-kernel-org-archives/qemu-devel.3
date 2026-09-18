Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F33C982DC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Wxr-0001IU-KY; Fri, 18 Sep 2026 07:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WxK-0000el-MF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WxH-0001uE-Vt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJvHfKiX7PEwhtXR3zEFacUgadXzigtW25CODwRwitc=;
 b=OpHFN0ItEIiFPYCjJKz8WUR+siSxwHzpzmaS+6RnecCbcVXR7h8ISEMl2VJ5Ofm+MsGMWE
 J8hKaLtfeHV1WDNdOfC7J/LZDj4dfY3kdFOO0GaNVxofAtmfqnJnTcsyB+AytKGWHmGGYL
 6l9FbrdL5pD4DOFxW7Oos1bbN9zKceY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-5ApGmaluNOmZBNBo-jOhMQ-1; Fri, 18 Sep 2026 07:40:28 -0400
X-MC-Unique: 5ApGmaluNOmZBNBo-jOhMQ-1
X-Mimecast-MFC-AGG-ID: 5ApGmaluNOmZBNBo-jOhMQ_1789731628
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939d6c515deso133827385a.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731628; x=1790336428; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yJvHfKiX7PEwhtXR3zEFacUgadXzigtW25CODwRwitc=;
 b=Vc0KoHfsmD6bA/s1g3mFgb6FK9+zIPNaxXombhrAvfEYRFynII8k8N46XZEJSLESCs
 gSoyR9CuJYx2qEXM6tECEjMhj6M9J2qhsErpJeKTjsngtyFnxemjElptL1OtSZGrEzat
 wt6HqgWPqPHWNPbj075/WdruuIc+Ioak9Ya/Npm/M/EMadkRER1C/c6eits7YZ4ZbpAi
 dqxWd/sZSwT48EOQEys9f/N0kKpumiZXZGIKVBXTGvx3wE3GazsBgJrnorjVteLCuZVa
 oYFjSus0sn6fSNeUF3Vx3m1TK0oI0A6zl00s4+x/+ohCzn9j8Di64iGPAlz8iE+rl25P
 gBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731628; x=1790336428;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yJvHfKiX7PEwhtXR3zEFacUgadXzigtW25CODwRwitc=;
 b=07edrFNQrRuYUaPGMh5AkxY8Pt2fl+fs480V0zaLNdu7foyUUozmKg6qdX5jHJLIxE
 FmDWPwKKmNTNTocv1ELkKHbhVgYmWELBLtCZjTHuZtSqPSvmOXgOF2whCd7qMO2DZeMl
 F3QtT6+pVuO6n1uzidecNyWkTlwyGzx+/Cpquue+3yby0h+yc1e0oIIpWTw+gCRNYuXJ
 NTVhtGKV56PivOXjFvpqeVPzdRIp5B3nmd5DsIzUO89/QxQ1Yh5G/YF2IsorK/i6Fl5I
 oVP3S4cqDBE4wiPpKGylOhzfzhDDj0EpdO8YmlAHFAQ0n7wZu6HsAcpKDlEgoaE5+HT/
 I9iw==
X-Gm-Message-State: AFuF++nBBqvRH7ZQ8nQdy5R0nntPzRL7wmq2ieh8fl0MRsM3PkcSeBoB
 8WpOBEff+5/X+YuJc5SdO8Ib2ZV1iqbDbau38hKLCyNHBOoU7VQ1pIfHShPe1L8KdnplsgHuvno
 TXZEugRA6sXkZKCkg4mzbatvSmCo/C7Vh+eAK06crcHUf4GZORxoScAN56nBx/xRhC8yYXTOvS5
 GEpnZUTfwUVLBzJ2cys5EI89cZrgboyfEuhdGxPX+H
X-Gm-Gg: AYBFou3aWh22RegZeixxP+JALiMkB7/s2hgfohskyvcq8EMRrLDNRS1p4+Log18b/lc
 pn+UOYzTaeZYPT4fGWlMEig7J+gahJ/jQcAulCTHU6vl32P2NMX2pCugmhCcUX/LP5CmdsSnlSH
 vcWkWtgyhEjyR08dY365SF9CFirSbmQIRjCuZ5ahr26AjqyAG/BUgfh7KvwfTtwnREaZ7dyh1L0
 WqvxzJVxpjoppY00EoQNnGcVayumT5O3W0y/rpTxh4xEP9BLC2y4iGnMjba6cth/QJdW2Bn1fyf
 GUqUnyCU2ryWyTjSDRUknVX0QarzENHqrPlNLY7M+VrYW61pD4KRrfu9tQeiWwW1AuZwDa9m3xn
 Xc12zlVVMG4HYP52emiJoLZkaoK+j3b0/I3vK1EojYBH9a1to6TmHaveRYK4=
X-Received: by 2002:a05:620a:4591:b0:93a:129b:5368 with SMTP id
 af79cd13be357-93bdc6d5ac4mr277008485a.36.1789731628120; 
 Fri, 18 Sep 2026 04:40:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4591:b0:93a:129b:5368 with SMTP id
 af79cd13be357-93bdc6d5ac4mr277002585a.36.1789731627421; 
 Fri, 18 Sep 2026 04:40:27 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91257f2d2fdsm10904636d6.5.2026.09.18.04.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:40:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-arm@nongnu.org
Subject: [PULL 08/11] hw/arm/raspi4b: Drop board_rev for 32bit hosts
Date: Fri, 18 Sep 2026 07:39:23 -0400
Message-ID: <20260918113926.831204-9-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QEMU has switched to 64bit-only hosts for all system/user emulations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260818172012.3052821-9-peterx@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Philippe Mathieu-Daudé" <philmd@mailo.com>
Cc: qemu-arm@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/arm/raspi4b.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 7d3eed9630..566d64572d 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -110,11 +110,7 @@ static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-#if HOST_LONG_BITS == 32
-    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
-#else
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
-#endif
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->auto_create_sdcard = true;
     mc->init = raspi4b_machine_init;
-- 
2.55.0


