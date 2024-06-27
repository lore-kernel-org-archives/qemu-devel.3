Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09003C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrz9-0002Ry-6H; Thu, 27 Jun 2024 12:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrz6-0002Kw-Uw
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:33 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrz4-0003Sz-6v
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-364a3d5d901so5382498f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505708; x=1720110508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/Nk+VBMPqpf8y4oh8kBjAzH+GIdB3yLjf9fq0VMabc=;
 b=p6VBLk6SzLc8jyl2mIYxsz2jOv2+5CE/LYekPRKVsWZuP60H+BdfPdClSvhU3JiN9T
 JonknX+PHpwWPGIyID01yIMfKG78veT/p89nNV9QONccS9pc+le66sZIw6M4+YiQhp9O
 eyV+BdB4vw7z7NjNJX6FWmE1csT31aeQOhZ6BCBqIAisjqnMqqpeDPUKlIhXWi+HuLCQ
 n3sueN1gM3fjkeNUMJcmhhop9u1XrTNezOf2MVUnrqfucEUH1i72pSzABeHouCSNqj+5
 P9nF6GV7ND++q1lXujpJkWZGpZdhsS8UY7tsJTDT+LkKWEpa9C83CSW0zbU+4XG1yF1k
 J0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505708; x=1720110508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/Nk+VBMPqpf8y4oh8kBjAzH+GIdB3yLjf9fq0VMabc=;
 b=sDfVuayQqjTEFRV0utCUlv1PCYuq7lQMxtLKJOUc0pRkcA8zt4INVj6pid8CfWTYV1
 NeARguE9/PJ9NQmCDeogZ8NVoYIca0ObEPKeuEF8nIDpHnKRSXoq0cKX9mAdX7k8UMQi
 nQtUDL2YyiW7+nDHftr5P+iz8RatNzDKABGxAyc5V2rq3Iea3TRdNfU87OGWG3ik8K/z
 Om/jkeE9KGcOcga3p80zKEqdrnj2feLw+wr0IXvMZ+6aOV320EZy6LGaPtICqLFIkLYr
 TqxPCEhIetVaJBg055dMzxJ8K2JnGmhfWX8bfW+aVxal1hPtqsd0/ksqPkl3D17pEkBh
 W0fA==
X-Gm-Message-State: AOJu0YzXfY77Ksl6FIPsdQb8TT5eLvPBwpkhfdxOXJOwtHKp3+QbT4HT
 BCVhNLLZBCa3L6ta6D0gGlNmtz1CN3nHiA977lIgxyn84eVTpjBsHRHQhtbY1IPOjbj224GW12x
 CUwM=
X-Google-Smtp-Source: AGHT+IG5j628L1vcPdAI1MoYubsqkIH0JzyX+mAL7YdndTp8skPmwkj7xE2UXVzslZPHek7/3pa35g==
X-Received: by 2002:a5d:58c7:0:b0:362:69f1:a08 with SMTP id
 ffacd0b85a97d-366e948fa96mr9537647f8f.19.1719505708589; 
 Thu, 27 Jun 2024 09:28:28 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm2402704f8f.9.2024.06.27.09.28.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:28:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 05/11] hw/sd/sdcard: Convert READ_SINGLE_BLOCK to
 generic_read_byte (CMD17)
Date: Thu, 27 Jun 2024 18:27:23 +0200
Message-ID: <20240627162729.80909-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index dfcb213aa9..605269163d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1405,11 +1405,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
                 return sd_r1;
             }
-
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            return sd_r1;
+            sd_blk_read(sd, addr, sd->blk_len);
+            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
 
         default:
             break;
@@ -2144,6 +2141,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
+    case 17: /* CMD17:  READ_SINGLE_BLOCK */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2154,16 +2152,6 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        if (sd->data_offset == 0) {
-            sd_blk_read(sd, sd->data_start, io_len);
-        }
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= io_len)
-            sd->state = sd_transfer_state;
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-- 
2.41.0


