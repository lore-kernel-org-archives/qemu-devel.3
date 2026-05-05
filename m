Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D03FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKKsi-0002xx-Vf; Tue, 05 May 2026 14:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKKsH-0002hZ-P5
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:52:12 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKKsE-0007AK-G8
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:52:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so1311685f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778007120; x=1778611920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZnBv5rFSKGwhe+faoJren4bCvjBLrz7mCkkLHBPgiE=;
 b=PL2HtD09yEzjPj36uZE7oGQ+Ho2hvGJkPxM6h0BravV3oOf0ss4U5EASYJRa+8Phic
 +4wWC0Qdz2zOGU6OUexj56PojiakxO0s552zbWUzhoi35WCK0GrhHIzBpPzjm2nk81SA
 NzL8hgRBFlTipON8bEpdPg08DAtrsPy8F8ZkD5I/ULUetQnvajEtTDFyXYVOEDQv1uGq
 ARXAIqFEzZzaVwy/qJaLmzQ8VAHJ8UsW+dGrz+wIATkxDIJVzwPQy0/4pf0UWP7Oxr9W
 HbHpYTOLvs9nwvJWau4g+bmywiDMSvZLG38s1WQCJbmbEYeRUfLD7hfs4ywOHs0FMimG
 KPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778007120; x=1778611920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YZnBv5rFSKGwhe+faoJren4bCvjBLrz7mCkkLHBPgiE=;
 b=tWmjJF3VL8wtPNh3u4wjBVPijsbfx9ocQWPsnrnD/4eIlxhClUnz/bB1vYDW03CeEt
 dNHC1yxbBGrEMvTiLxiKnBtITWKzT/uejeQJ8nmsbvCfCZxmh5b7s0fY2jcV6gng4gTw
 6it8piU3JayTrABS1FSon6NgtraJIkN8bzk+yd7aDEGqqjzmxIfgAp9RgPrbbCm6VyYd
 mQBOF2BvhVFGCj5lZhEUkCbHAmsr+kAOvkB136DhY2/G5hyUngCHvI+kcS1q1PaGbSyz
 cgbZjZ6nV4dqJx8fX6nM6Tqg91pIUXO+wqkNoYEXhNFijzfb/nJtiunqKAV4bVyVvm2G
 n/HQ==
X-Gm-Message-State: AOJu0YwjxY5ecndIerKjSYfwQ87AaayIuNQM9nla8kiFgg3XdQ1Xpc03
 ygL85pJ/83AXOfWyoQdeoJIsEKUjGQKnefdDzuDFNkXmh94SPCZNwsDBM3EMLL/6B+qkWEv4nYJ
 M5HM3
X-Gm-Gg: AeBDieupNqKT3HbXbpn+yvlJ29ujQM/OhHyb4R59DcbDBjd6QX2RazCflr32H4TREsQ
 ThM99B7hfIkgQciQ6iu1d4HP6j6GREKCCqvwyiiqC/87/sqhi1WYjKMlXpd02IVjTFRg0h1Mpsy
 vJhEqMil3JD1BMrQPqwqhiAdlttdpmaSkOTc3GIFtWFK68NAdTiGcexQfS/KRXnudnXSVUgPJvm
 cFmDA4skb0sqE5r9a3CtIVCM4VE96I2QgJSFkFz20U39H/hhUb1EMqEcQn17gaoWM51hbayoaPZ
 BlJAjVvowoMPsBWMH3lUye/Y42VDaWWCQdcgxmBR46eF35pzRNKv/KM1hs81vyczx4gYh5sHJhV
 1U65jBC2HNvK/I/owYBAg2Y0OzTND+UC7VXQfbK7/x3VkxTGQSDyZkUWRawD1OfATzQpDsroHp8
 ySiogacAKYhV1PCGw/4c1wAcrcuYs2PMB5MFjz4QGDZwQKuhtbSigpkoCH+5t9Bgk4TALVbBYgE
 vLrSaasA7u7iKQklwJIAtwARIEQZCKVpRxjPdXP4SbS1bjafuH/
X-Received: by 2002:a05:600c:c11c:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-48e51f5398emr5175595e9.7.1778007119839; 
 Tue, 05 May 2026 11:51:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6ffb7sm377086675e9.5.2026.05.05.11.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:51:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/2] hw/net/rocker_of_dpa: Check group ID pointers are not NULL
Date: Tue,  5 May 2026 19:51:56 +0100
Message-ID: <20260505185157.608910-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505185157.608910-1-peter.maydell@linaro.org>
References: <20260505185157.608910-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
2.43.0


