Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEB1C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbe-0007vZ-D1; Wed, 26 Aug 2026 07:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbZ-0007qm-Rf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:44 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbW-0004Jn-OW
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:40 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso1378537a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742937; x=1788347737; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HHA/L+hYwRVXnYA63QAIxg5NWEam4sD+wyU80uakeDo=;
 b=i12lNY3GEjP0vpG7wgweVTDgHAYizRD7uM2WcTCsiKceKlfKlYQhhNBrsp1W7u7Ivt
 +HZaDXq3HGE1ooY/PewsjUsPbp/BxqDoNLc87xOFpHEzptIt+EfMSw6LeNxFWCcZeafT
 yl0FlOr8/okqLrt9I3QdGph0q/zqPOe4uW9Pc8pzF5gkSYtQa0UTpH66559aUOHZxueF
 aylkvVFb/4BWji0DPM+CCykSPeaB+INyARWDYLNFTSC+tnLP3mClyz4cCAktSxsWCd2X
 h2SLm/oGpdIlczIxqicUC5Ukh8nA7kn6QuPYXCDDoNv/NsdjaTivuNrUKdciX5QvciOa
 5kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742937; x=1788347737;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HHA/L+hYwRVXnYA63QAIxg5NWEam4sD+wyU80uakeDo=;
 b=MyhgUzetR/4rb7A4nm0RKo9nDC+7hEYECfY790ksgjjv7BaBNcPCJLhFTHzjppDGrC
 5gYKHBv7YRRMFMCLZneCK12eVCzE4SbCByXaNfNv1Tz9rdbS8xaSQX0gUTn0OCwynLH/
 pUWdbxnfNMccNEkkv2QPvKOJT9YKHY5aT/xc3HNehaodnLyPj+41M1CxfVMJdl4EEj/y
 sXpvbLU4EgAtYxCEvoAB6wbgLK6lIh5UAMU0fldDo+yUM77azMsYZr+wffNEg4oH+K6x
 vTRtthDpODpwlpRbNnjYRi0SdAKrYeFBTGZGI8b0JUOVSj2Z8hI0Jy4h0G5Ar5KkFIEu
 6UAw==
X-Gm-Message-State: AFuF++lR6Srt9uaZFXpYIvRy33esQcI8CUslJfL8Q43NZAWuLM3fdfka
 UagONqLBiNtaLnnE23nfesexkzNsIVpkhcoeTNO5uP542viL9ARKhDH5ay2BwvrE6G1pkGRCsLs
 bU/WE
X-Gm-Gg: AR+sD13sYKa/1pT2+TfMGi8uYr4SfC8Zj8IRZpQ/2oCex9cPejCf3pL0yevmRa8YqJ5
 OYdxfxmYAcGu0VcKx+5HPI8sV7/JZ6Tefn0+G0XAv+OaGu+ySPkzArP+dRbUc5q8Z8Kwis0bH7O
 azeM6d7fctWeXKEAog4LEvHf8+vHbotyNuLXknJDUYJFUM0HPNu0dOyvww9OL8ZLLp/zKS+rrnZ
 A8KZaoDAz8KCmyUqquU0QcmSKS4jkDDQzhwvSIJO7uGj7ygc5G//8cxX1m6bRMZqeLBda8TvNbh
 TLvx9MyW4nJ0HcZQ2y9Ul5zc5/3KcvPn/yJgEg8O1IVWhpaRjvIDMhxgCHr1rUgpeIhbmI/Ko3J
 PqPmTPltslPn0jhlJQ6FYsC5NsloGQd/TSqVWxva2IkXPw6IEW59HBpTLtZaZh8WnjFAG7jXHmr
 0px5tk4A+YmU+5eTw1O3GB8YZP6fOaK7bi0Yb5z9n3CpvqoHz/
X-Received: by 2002:a05:6402:458a:b0:698:6084:db7f with SMTP id
 4fb4d7f45d1cf-6a5df62b3b2mr8933936a12.10.1787742936958; 
 Wed, 26 Aug 2026 04:15:36 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:36 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 07/28] hw/ide: factor out the IDENTIFY DEVICE current geometry
 words
Date: Wed, 26 Aug 2026 13:15:22 +0200
Message-ID: <20260826111524.3383479-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=den@openvz.org; helo=mail-ed1-x52b.google.com
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

Words 54 to 58 of IDENTIFY DEVICE describe the CHS translation in effect
and the capacity it addresses. Both ide_identify() and
ide_cfata_identify() fill them the same way while building their cached
data.

Move them into ide_identify_chs(), so that the next change can refresh
them in place once the translation changes, the way ide_identify_size()
does for the capacity words.

No functional change.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 292908fb1c..e5fd570575 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -110,6 +110,18 @@ static void put_le16(uint16_t *p, unsigned int v)
     *p = cpu_to_le16(v);
 }
 
+static void ide_identify_chs(IDEState *s)
+{
+    uint16_t *p = (uint16_t *)s->identify_data;
+    unsigned int cur_sec = s->cylinders * s->heads * s->sectors;
+
+    put_le16(p + 54, s->cylinders);
+    put_le16(p + 55, s->heads);
+    put_le16(p + 56, s->sectors);
+    put_le16(p + 57, cur_sec);
+    put_le16(p + 58, cur_sec >> 16);
+}
+
 static void ide_identify_size(IDEState *s)
 {
     uint16_t *p = (uint16_t *)s->identify_data;
@@ -128,7 +140,6 @@ static void ide_identify_size(IDEState *s)
 static void ide_identify(IDEState *s)
 {
     uint16_t *p;
-    unsigned int oldsize;
     IDEDevice *dev = s->unit ? s->bus->slave : s->bus->master;
 
     p = (uint16_t *)s->identify_data;
@@ -158,12 +169,7 @@ static void ide_identify(IDEState *s)
     put_le16(p + 51, 0x200); /* PIO transfer cycle */
     put_le16(p + 52, 0x200); /* DMA transfer cycle */
     put_le16(p + 53, 1 | (1 << 1) | (1 << 2)); /* words 54-58,64-70,88 are valid */
-    put_le16(p + 54, s->cylinders);
-    put_le16(p + 55, s->heads);
-    put_le16(p + 56, s->sectors);
-    oldsize = s->cylinders * s->heads * s->sectors;
-    put_le16(p + 57, oldsize);
-    put_le16(p + 58, oldsize >> 16);
+    ide_identify_chs(s);
     if (s->mult_sectors)
         put_le16(p + 59, 0x100 | s->mult_sectors);
     /* *(p + 60) := nb_sectors       -- see ide_identify_size */
@@ -321,7 +327,6 @@ static void ide_cfata_identify_size(IDEState *s)
 static void ide_cfata_identify(IDEState *s)
 {
     uint16_t *p;
-    uint32_t cur_sec;
 
     p = (uint16_t *)s->identify_data;
     if (s->identify_set) {
@@ -329,8 +334,6 @@ static void ide_cfata_identify(IDEState *s)
     }
     memset(p, 0, sizeof(s->identify_data));
 
-    cur_sec = s->cylinders * s->heads * s->sectors;
-
     put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
     put_le16(p + 1, s->cylinders);              /* Default cylinders */
     put_le16(p + 3, s->drive_heads);            /* Default heads */
@@ -350,11 +353,7 @@ static void ide_cfata_identify(IDEState *s)
     put_le16(p + 51, 0x0002);                   /* PIO cycle timing mode */
     put_le16(p + 52, 0x0001);                   /* DMA cycle timing mode */
     put_le16(p + 53, 0x0003);                   /* Translation params valid */
-    put_le16(p + 54, s->cylinders);             /* Current cylinders */
-    put_le16(p + 55, s->heads);                 /* Current heads */
-    put_le16(p + 56, s->sectors);               /* Current sectors */
-    put_le16(p + 57, cur_sec);                  /* Current capacity */
-    put_le16(p + 58, cur_sec >> 16);            /* Current capacity */
+    ide_identify_chs(s);                        /* Current C/H/S and capacity */
     if (s->mult_sectors)                        /* Multiple sector setting */
         put_le16(p + 59, 0x100 | s->mult_sectors);
     /* *(p + 60) := nb_sectors       -- see ide_cfata_identify_size */
-- 
2.53.0


