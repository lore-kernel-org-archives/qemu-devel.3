Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F3C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4phc-0002dt-Vw; Thu, 10 Sep 2026 21:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPc-0001gJ-D2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPY-00079X-QV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so3083095e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083750; x=1789688550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKVJvx37U1Ou4yt08ZBZeRtwXNpu+2B01rGqZNKxlUU=;
 b=lRbh29nR9zh7GL9sRPwJUsfIESeXgVlBfr5Bw/nSclo/jAKCuNARxWslVFRvYdb9Ly
 R2sL0xpomi5QS+t2n88V1a7qSbu4gUkZ2DQKrgwG25qnLsMGmhDhyJj9D/35eKHe1aky
 Rjg69LYe/XOFHegnNFnwjiTX0do7oSBviLua+LI8d/ZMvrE8rBWENXfsF+QppW1PK31q
 uMmc+v+IE0SpuGCeJC6g1uiBw9NnUpJB29BNA5RywQ1GV2m8EFC+jZ2qWdl1P2ysqxSh
 J3hqbQmMAdzOI99k/q4rMTdstAz6/UypConLcXv+AYaHbqND0SCLXnRSwrvMSu8mSg6K
 FlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083750; x=1789688550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKVJvx37U1Ou4yt08ZBZeRtwXNpu+2B01rGqZNKxlUU=;
 b=DjizTymnpe/+GYWoua0qPD+T0QQ4HK/oIrZ/+apYCLvSSqDqw+emUcXFg8hY4/LmXM
 Q4ShqN2Y4xdkwyDGpiVNYvaC5ZPyrRcl2VenPQMGDXw3UYWJlO26Fzk2sfqSX/auUSRV
 Xy1W7o734JPCiXj3wV2QHLSEyycnkKfeqQv4AWiOi5p0tKi69olnl7PtbmmC0ouUIaXF
 /eTlmYLPfRxyZWGZnbE+T5EvRuoM8+63Us4y24QjHY0X8BrdK1zzBPQxgsDxdWnB1WyG
 QssmO2P779wbZ17AfqzFsEODSEFnutFAojVpi8sxPus3jquOHwDA8KZfoUINqBSRJDt6
 quOg==
X-Gm-Message-State: AFuF++k5fEH4V0O4vVNnaHKB2XAdNaInv5rzMad8TNty5UCbmHgRByyB
 Lr8g31kreNTbKH0TsiGeYRB/t+NXlQNjzrcTTWGkNwskv61WLoBYvMRlybonM/Q7S0o=
X-Gm-Gg: AYBFou3utxEu6A8lYS5YrBgg/KAgzV8neTk+Rm8PiYngGvhaEIuAF8iWnwVHCoT1CeE
 z8Bzkmg6cK7/yQMyJJWLSQgo9nrJvMqzubvS6Qnra36xIGjhmLCDty8Iqv4LjRMoDGZ7f/ZNrtS
 /J1wQOg/kz/8LhY1Rngx4ZUjiKsoQTKb1+Vs7nyyRaLOSP36OghS3fS9R/Or5yUpTHhxMmXGzKD
 I2Q+EEllMpBlgGI2vJsc8TVnPiK1BKsLpW6guhSTHrDT0QVnfFkUfX1p+xtqm7DHBl7xxsYDsbo
 1+erVcagaoD+urN7hajbWkjwWxKS4UqicxM3i4UjXRzYOmdQQEEUjGe6D22CynDpR/fMEVISkka
 45LlplOARP5tzZtfy3ZtaY7Qzv2nHR7VbN+OlCegM/kvXivv7dmvw7YKxM8KysBvaodWRscxK68
 9U2KHs6ssb6ynfEji5ziiNswGF5Op/TRK1XSEAUDcxHBVolENU0DDNSBuRjmQ8tPMDPOmc
X-Received: by 2002:a05:600c:8b23:b0:49c:fa20:cc0a with SMTP id
 5b1f17b1804b1-49e619e6849mr13858245e9.33.1789083749880; 
 Thu, 10 Sep 2026 16:42:29 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:29 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 05/29] parallels: allocate the Format Extension cluster
 gracefully
Date: Fri, 11 Sep 2026 01:41:58 +0200
Message-ID: <20260910234222.3039975-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

s->cluster_size comes from the image and qemu_blockalign() aborts when
the allocation cannot be satisfied, so use the try variant and report
the failure instead.

The two are not interchangeable: qemu_try_blockalign() asserts that the
alignment is non zero, while qemu_blockalign() reaches
qemu_try_memalign(), which quietly raises a zero alignment to
sizeof(void *). bs->bl is only filled in once .bdrv_open() returns, so
the alignment has to come from bs->file, which is the node the cluster
is read through anyway and what parallels_open() uses for the header.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 63fe4d5b1e..89fab36039 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -323,10 +323,16 @@ int parallels_read_format_extension(BlockDriverState *bs,
 {
     BDRVParallelsState *s = bs->opaque;
     int ret;
-    uint8_t *ext_cluster = qemu_blockalign(bs, s->cluster_size);
+    uint8_t *ext_cluster;
 
     assert(ext_off > 0);
 
+    ext_cluster = qemu_try_blockalign(bs->file->bs, s->cluster_size);
+    if (!ext_cluster) {
+        error_setg(errp, "Failed to allocate the Format Extension cluster");
+        return -ENOMEM;
+    }
+
     ret = bdrv_pread(bs->file, ext_off, s->cluster_size, ext_cluster, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to read Format Extension cluster");
-- 
2.53.0


