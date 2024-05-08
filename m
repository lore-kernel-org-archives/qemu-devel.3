Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DB4C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNI-00016j-7c; Wed, 08 May 2024 13:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMO-0000Md-VT
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:00 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMN-0007Mo-7C
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:44 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e271acb015so393671fa.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190341; x=1715795141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MM3UbV0Lmc+hoeU+fuxpwFUEKRXI1CPAUdZ2U052B24=;
 b=TmMrKTP3UlqGea3lw7v7gfF1+3ga6Ar7TIomHOEIOfv92v9BPaWJm40mQZyYd+4Nj8
 FsGYPQy3OkC0N94xtfi+eI14SL44YNN9OVDQs68QIsWr6rtnVYhM0TAt8d0RdqWnphcy
 LgHHoekAJreWl7zh7mr18MPy0BYkX1XvvjEo19qyhpAAuNEEsXHAED8G4LI5YXK1v0it
 gntzk/VUJkiatJqrcpJenAmdnkS5+Ie95s/Q3BsuJgxKu6TVoRkIIC+pSv7FQNlsv3MX
 OibztCIs+rrJmkvtA18uRLHkbD9nYzb4x6LqW8wNr29sI7UtjInot6vTYnWigLO8uRDP
 HkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190341; x=1715795141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MM3UbV0Lmc+hoeU+fuxpwFUEKRXI1CPAUdZ2U052B24=;
 b=wZsw3BVxM/yV/rRgqWQETZi5W0aVUjXGle/2r4cEUKmjamldqdvzhzKbVxfFR/XJuK
 fbCFXk/KULBJ0Dn0Knq7Lalm5GB6EnUaqbULzCssgKeA1+nDJExAYmLwC7x8cCs+fPuj
 ZU1ZHyWOgdQnT3lNe1MjBrj0v9PgR/X0JBnGBDJI+sC5rFxlIIEWLa/B4Ig59/339ozU
 esH4CeN0ZIHfyUnRBpD4XeqYm6u/TyyIWDV3hOjGEaJxxSTZ6Qp7QCbW4onax0BTmZDl
 kNuM0Fp//f6hu7v6uqyfFaAUtPdFeWMyElM0FeJGPMPj3GxfXQc6pvVglZmotgIUzZny
 OXaQ==
X-Gm-Message-State: AOJu0Yy6QMnnwNOJDgZNkGTSBBBq0O617RUjLZVufypWF0XP2xr92LU0
 crY5/qaLGgyLLTVN6uFZU6pFVXO2xga8EQrW+iuIWyhGXyXAlNewdXx9nrinPG9gFpeZ3dYpDEJ
 a
X-Google-Smtp-Source: AGHT+IEhUfXu/rlXvYTc5hrbD7X+lpAUoFFF1d7ns3/ARc4tSoJSaAlrmYlUn3fjcqxxu7uSQhjIeg==
X-Received: by 2002:a05:6512:ba3:b0:51d:2eba:614 with SMTP id
 2adb3069b0e04-5217cc455c7mr2542247e87.53.1715190340781; 
 Wed, 08 May 2024 10:45:40 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 co22-20020a0564020c1600b00572a865af10sm7834857edb.44.2024.05.08.10.45.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mattias Nissler <mnissler@rivosinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PULL 05/26] hw/remote/vfio-user: Fix config space access byte order
Date: Wed,  8 May 2024 19:44:49 +0200
Message-ID: <20240508174510.60470-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

From: Mattias Nissler <mnissler@rivosinc.com>

PCI config space is little-endian, so on a big-endian host we need to
perform byte swaps for values as they are passed to and received from
the generic PCI config space access machinery.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
Message-ID: <20240507094210.300566-6-mnissler@rivosinc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/remote/vfio-user-obj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index d9b879e056..8dbafafb9e 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
     while (bytes > 0) {
         len = (bytes > pci_access_width) ? pci_access_width : bytes;
         if (is_write) {
-            memcpy(&val, ptr, len);
+            val = ldn_le_p(ptr, len);
             pci_host_config_write_common(o->pci_dev, offset,
                                          pci_config_size(o->pci_dev),
                                          val, len);
@@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
         } else {
             val = pci_host_config_read_common(o->pci_dev, offset,
                                               pci_config_size(o->pci_dev), len);
-            memcpy(ptr, &val, len);
+            stn_le_p(ptr, len, val);
             trace_vfu_cfg_read(offset, val);
         }
         offset += len;
-- 
2.41.0


