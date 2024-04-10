Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA77FCD1299
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaUQ-0001H4-O1; Wed, 10 Apr 2024 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTj-0000V2-IC
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:22 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTg-0002kP-55
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a51beae2f13so504767466b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765230; x=1713370030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urm+Npyj3/f/E1cmlvhojimXxZbt++WU9CB9v2xORc4=;
 b=tOOc6QyIpBcgIP8g3gYoYZOb16yecid/rvj5ulN9defoMP3d8AC/czHMkyE6IPWErW
 zjbJCyALT9qxtj2dweeVHGRG/tKYE9ns1hHmbnNBGqlu0Ke012m/g/FOyvW8dQAxe7kF
 xAi70GYAXbJpOz366h5Kjgm10oLo5VrPYi3yw6hsjBNTm6R73HJTvt1HVaC51XZ27bfV
 O6kscC2e2Pid0h8K01Umx7ER/GU9RZJ5dS80wdO22jOLloMv2dQ3RfpFX8XQWCYO95cb
 Lil3ZpE/fHNa4MvsLfeqAQsEoBOQwf4fQxYR6k+cCDJCKbWaDG5ApD1Mza5z+sWN5F1L
 31Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765230; x=1713370030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urm+Npyj3/f/E1cmlvhojimXxZbt++WU9CB9v2xORc4=;
 b=DfFZDuVAB88nBTF/hGdWNxDOSDcF2ECnyaU3G9KQyYmWy1B/2DDvMDUgqrJ+eSW//h
 5T/CBFDK2LchtqbSsXWrogjj6IeujpHnIPnVNoQslA6uCmiKEI1ff75CJVamRjoXFuDy
 E+OEK/tot+toC7Gt2Yid2oYUFBuKptBaoG0LzYxA4ik6ha+vvIXjiEOtMAzh8aE0iRao
 TveEeC4bQ796RSEh6CheLPmJ5lIHf4GGKJUffthi1DIG92eJEpNn05Cq0OIJyB6ahM2X
 2prhRAbZOcjSPQhCjNsaHbdQROejh/6Kst+hcgGUR70g5I1NhvCBk3n79KtQYtZ5G8CC
 CauA==
X-Gm-Message-State: AOJu0YzbX6a9WRZ/PmLHk9cmVi0MO+RMDDeTTJ+Y5HmKvwkYqekPLkl6
 mk45fbtaA8ExpCbATiuElRY6k8mQAVxlFW7fT3bq0wVtEvPFNneDCow2hYNfMYiJpOs6yPeWMlg
 o
X-Google-Smtp-Source: AGHT+IGvlDlkhQtpm4CmaPeXKa7kCjKb1NZTMCmtYLLSNMuPIOkU/tXjcubh/5ccrqbfNyVx2d0h1Q==
X-Received: by 2002:a17:906:118d:b0:a51:913c:1c83 with SMTP id
 n13-20020a170906118d00b00a51913c1c83mr1864645eja.58.1712765230578; 
 Wed, 10 Apr 2024 09:07:10 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 k7-20020a170906680700b00a51e5813f4fsm2662622ejr.19.2024.04.10.09.07.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:07:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 09/12] hw/scsi/scsi-disk: Use qemu_hexdump_line() to avoid
 sprintf()
Date: Wed, 10 Apr 2024 18:06:10 +0200
Message-ID: <20240410160614.90627-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Use qemu_hexdump_line() to avoid sprintf() calls, silencing:

  [105/169] Compiling C object libcommon.fa.p/hw_scsi_scsi-disk.c.o
  hw/scsi/scsi-disk.c:2659:14: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
        p += sprintf(p, " 0x%02x", buf[i]);
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/scsi-disk.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..4f914df5c2 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2648,16 +2648,12 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
 
 static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
 {
-    int i;
     int len = scsi_cdb_length(buf);
-    char *line_buffer, *p;
+    char *line_buffer;
 
     assert(len > 0 && len <= 16);
-    line_buffer = g_malloc(len * 5 + 1);
 
-    for (i = 0, p = line_buffer; i < len; i++) {
-        p += sprintf(p, " 0x%02x", buf[i]);
-    }
+    line_buffer = qemu_hexdump_line(buf, 0, len, false);
     trace_scsi_disk_new_request(lun, tag, line_buffer);
 
     g_free(line_buffer);
-- 
2.41.0


