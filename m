Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91592C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8y-0002ts-Os; Tue, 25 Jun 2024 01:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8x-0002tK-6N
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:55:03 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8v-0001i0-H2
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:55:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-363bd55bcc2so4213353f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294899; x=1719899699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAYGjbFJNuy9OHUJ805jrPNXsWJBhB1UqPytiuUZXwI=;
 b=H/vF1o+bAUQ7usNqJVvrFJDQXQIdCn9NqVcABKWJ8wnAsksNvH93KZPJZbbWqDimxC
 JG9YOxtPlWTmtUFe1q20dtLWwWsqsE0gKXlRmegWim5hXEwKEaneeMmWpwdqwh2PXZQY
 sJKXt3iedv2l+OJyy0yuG0V8x01JiRpDUFNDCws1hg8DUSg7hGRQCHRWdf8LGNp/ZvO4
 gmdgKVJcQ3lJ8DNb8N11ug5Kg7f9A/nY+UeHy12VPbz/bmJsKwt8FrjP17iLisBxHtjN
 EyXRIccDnvJPHIo9SBRL1K+sRDA8/yGSUBu1pE86Q7a2f4t/v2H6esqnRA81DMosm7ih
 SibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294899; x=1719899699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAYGjbFJNuy9OHUJ805jrPNXsWJBhB1UqPytiuUZXwI=;
 b=RkpXsUdN573ncezqXLzy21wVMZv+OsbwvZanHolJHBZK8DdhZqWnzHuOrOECkxtAtF
 kyJNix7LpBBtNjD1z0Kk4I19JJhYZSLsBWwMNW2AfftmscLEswpTNA7J8nmozTXHzXhg
 66N3zjwce/3Wk+CelduyqeudgjnsrWmNbInZVNtHW7oZEP917rumnfZhLXfSU6iyMdsU
 Fy+9mvB101XbzL16/aKOINFdRy+6o5EOinIuqaShGKvsuCvKl7CREcq4kERZxWSTrqCF
 CUYr4ddRqjzvHt1zkiTsX7tZmO6MqmHDtlq5uvBIi1jWcR5Nh+h0MRsosCEIJ2vPLFjl
 5Vtw==
X-Gm-Message-State: AOJu0YwYzNZqeof3Q9XOdWzCBGISY0I5VF3tjFx/ztAVQ5lhXAsa/EJg
 qYLjKaG4YHXNXt5mr/WB+P8fVw1uTHnEsbVKSLn0J6KR8G0o6Ix9z1LLx7K2uq1EilEmWO5L3si
 O
X-Google-Smtp-Source: AGHT+IEsE/HIBKeNcn1vxBxHhO61D3zn56j7hnUxGgUpyjM5wvGdrO22BtQ0nIqpxfJc6IrbEe6vRA==
X-Received: by 2002:adf:a21a:0:b0:362:8918:1830 with SMTP id
 ffacd0b85a97d-366e94ee0d8mr3348812f8f.42.1719294899468; 
 Mon, 24 Jun 2024 22:54:59 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366f624cdacsm3996960f8f.70.2024.06.24.22.54.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 11/12] hw/sd/sdcard: Restrict SWITCH_FUNCTION to
 sd_transfer_state (CMD6)
Date: Tue, 25 Jun 2024 07:53:52 +0200
Message-ID: <20240625055354.23273-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

SWITCH_FUNCTION is only allowed in TRANSFER state
(See 4.8 "Card State Transition Table).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fce99d655d..3b885ba8a0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1196,6 +1196,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->mode != sd_data_transfer_mode) {
             return sd_invalid_mode_for_cmd(sd, req);
         }
+        if (sd->state != sd_transfer_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+
         sd_function_switch(sd, req.arg);
         sd->state = sd_sendingdata_state;
         sd->data_start = 0;
-- 
2.41.0


