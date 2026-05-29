Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7283CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIu-0006YU-Lo; Fri, 29 May 2026 00:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIs-0006Pf-Aa
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIq-0008Fe-Dl
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeDqljhGetjIjsOuSvY7RejNRG8txoyWC7EVFVdHKNs=;
 b=fh/EmA0BMzEgIaRATi6enqSv3cmamQqAHu5/e32/GK65T+aLeUZFuIoHRs7sN8XeCtICcG
 y5TpAkmnV52jFEqnxvEFGlcCkLsnw55Gcl0iV31jC4a1u9f/p/D6b6EImPL1lZvht1c8Te
 gtf8nFvOs9KdDNCAVPvkBpM7AudoNnA=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-uCEYnhurNN65UQpIpf5Z2g-1; Fri, 29 May 2026 00:58:33 -0400
X-MC-Unique: uCEYnhurNN65UQpIpf5Z2g-1
X-Mimecast-MFC-AGG-ID: uCEYnhurNN65UQpIpf5Z2g_1780030713
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304ec73b015so845649eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030713; x=1780635513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeDqljhGetjIjsOuSvY7RejNRG8txoyWC7EVFVdHKNs=;
 b=kqyhAoLPTcSI0RrM0fltp7CmHFpfu800ScZPNsexv08zpULZ5SRh8JaNRFgB/cVjr3
 qNk+EEaE/IvPEfqhs0BLVexDfdEDkAhXggii/WsZ0lqD2dMOVNtbBZc4or6FFrBmJNCz
 WVC8/EsJw0ky1fr19B9fqawyyQEO2PyghSBvfAkS3cpVPel2on1wRTEBIyuY60APpLLf
 UF3D7PtZ+caZbDJAoG/P8YaelOCSQh/TJQvOZEHE2yIRVEYwZOwhz5s5GUNiTuMXVr3W
 fFmvTwRz/Ji47IVvtB/GQOAWMTHIhQgy3YI5ty7XtvAq38f5/yc4WHEmKtt+vyrlbloj
 x4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030713; x=1780635513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeDqljhGetjIjsOuSvY7RejNRG8txoyWC7EVFVdHKNs=;
 b=JzqIQTZ4ds2oKfZIKvh3A5QG05xu99ArlceoO+v75KutRtorZjQQe0y8rAMZgx/Yu3
 9EmpM/cp92qRNtbm69gTRyXpN8B7oOc/s0+9+zRnUFcZ2OqlcMwx/Se9jJQZ9PacGAjf
 hLx7nxmp0SjzOD/D+7t0Kp6rPT/FB+aB4k2WrAQyGzX0rWgGCuBA2YkfjK6iWuX9/6wC
 1ytQVe4EWNFPzALGoKSQx190DD7JlGaakUvNTn42LPQgug9mO4j5LLoBf0Bhmn97YTDo
 uEFsNC2ImdODfRYi/gesyeO92lT8fs1E0DV8QXDbYzeqzCunghAOf7wG55neqMenfOGx
 WMeg==
X-Gm-Message-State: AOJu0Yxmnk1XypFDJBd2pMwtkN5ZRZxrvEjdqFLdWgxKttz+zbLuVtHm
 w9FQz2zWfLL2k9KnIulCZTbwAPjS26Kz6v+370uO9GUfRpUgaqags+YVMMHaIK1pfGBvWQtButC
 8/JsnEOqPCaQHzLsY7/6awCdTYMfRFFYO4u/7v9P00lhawHdQMj3D8J+2oJMc0RdRpag39HLoy3
 LvGZ/tX6Ft1kEBGRi6/NBwUtXFv/64TWzU8+0wzi5+1W4=
X-Gm-Gg: Acq92OFerdheOnjPflvUuZ4n3hQuIJrqbMATpM0PdwFyVVFFyTfZekCqWvrmXmmx7tz
 YZCMS+rjP1/BxWT9tDEaeC1SswExzP5n6lv94wS7IN/W+UTGimG9mA61NEaloxpnZZf8Jv1Me99
 GIG0p01YAAzvnvo1i9Am6SL6OO8KzDovS3TsQjZ5IfpXAwKssmLXIw8mVPXWy4fxI6KsgE8HUnw
 VtlT1d3bmuLNxDo/hWI1RkJYYTDoXjjarEPebAYdsJ0H7Nu4bG0PFEb2TtJc0b1Bn4aY/g/ECnC
 d7qa0ObHkQqnTyxcjFLhZx+gcxPoo1fE9nRT2BEprq4OHppGzLxMTRzZimEjaI/6X6s9clos1TR
 /xYr14QlwGazLFTjUZYIGSAnlKrItJJjLBWDAotEcE5MDaalMGbFthJ9eAIBOf9ZL179x18I4
X-Received: by 2002:a05:7301:1e84:b0:304:cd60:b6a6 with SMTP id
 5a478bee46e88-304eb24c642mr576531eec.30.1780030712715; 
 Thu, 28 May 2026 21:58:32 -0700 (PDT)
X-Received: by 2002:a05:7301:1e84:b0:304:cd60:b6a6 with SMTP id
 5a478bee46e88-304eb24c642mr576514eec.30.1780030712081; 
 Thu, 28 May 2026 21:58:32 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:31 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 14/15] hw/net/rocker_of_dpa: Check group ID pointers are not
 NULL
Date: Fri, 29 May 2026 12:57:29 +0800
Message-ID: <20260529045730.90322-15-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

From: Peter Maydell <peter.maydell@linaro.org>

In of_dpa_cmd_add_l2_flood(), we use rocker_tlv_parse_nested()
to fill in a tlvs[] array. If the guest command is valid then
the entries should be pointers to TLV data items with group IDs.
However, if the guest gives us bogus data then rocker_tlv_parse_nested()
indicates this by leaving the tlvs[] entries NULL. In the other
places that use this function, we check for this before using
the value, but here we forgot, and the result is that QEMU can
crash:

#0  __memcpy_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:331
#1  0x00005555574f7137 in __asan_memcpy ()
#2  0x0000555558106792 in ldl_he_p (ptr=0x8) at /home/pm215/qemu/include/qemu/bswap.h:278
#3  0x0000555558106755 in ldl_le_p (ptr=0x8) at /home/pm215/qemu/include/qemu/bswap.h:311
#4  0x00005555580f85ed in rocker_tlv_get_le32 (tlv=0x0) at ../../hw/net/rocker/rocker_tlv.h:114
#5  0x000055555810a8ad in of_dpa_cmd_add_l2_flood (of_dpa=0x506000082e38, group=0x503000b4e440, group_tlvs=0x7fff68702c20)
    at ../../hw/net/rocker/rocker_of_dpa.c:2032
#6  0x0000555558108a74 in of_dpa_cmd_group_do (of_dpa=0x506000082e38, group_id=1073741824, group=0x503000b4e440, group_tlvs=0x7fff68702c20)
    at ../../hw/net/rocker/rocker_of_dpa.c:2115
#7  0x0000555558108730 in of_dpa_cmd_group_add (of_dpa=0x506000082e38, group_id=1073741824, group_tlvs=0x7fff68702c20)
    at ../../hw/net/rocker/rocker_of_dpa.c:2135
#8  0x00005555580f66ec in of_dpa_group_cmd
    (of_dpa=0x506000082e38, info=0x514000072e40, buf=0x5070002356c0 "\001", cmd=7, group_tlvs=0x7fff68702c20)
    at ../../hw/net/rocker/rocker_of_dpa.c:2194

Check for NULL values and return an error.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1851
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rocker/rocker_of_dpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 3190a0e75c..958f3006c1 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -2029,6 +2029,10 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_dpa, OfDpaGroup *group,
                             group_tlvs[ROCKER_TLV_OF_DPA_GROUP_IDS]);
 
     for (i = 0; i < group->l2_flood.group_count; i++) {
+        if (!tlvs[i + 1]) {
+            err = -ROCKER_EINVAL;
+            goto err_out;
+        }
         group->l2_flood.group_ids[i] = rocker_tlv_get_le32(tlvs[i + 1]);
     }
 
-- 
2.54.0


