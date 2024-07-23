Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53851C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMKP-0001Ms-RE; Tue, 23 Jul 2024 16:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMKJ-0000i8-6F
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMKF-0004XF-22
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so2866360f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767293; x=1722372093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AGqT/HuIbzxdWkOMa17Gjd1RtMZJ6gzAqRn/Fh0hIA=;
 b=QJ7DzPGYx8lYZ7zWiSFofL/ij7iEymKpUQwaEls3qyK5rIP5NbOjsVII1nTkQ3kUdk
 W+SucUUzgg4hxi1CpsQZ/iLDTJgPlC2TcS8te7wBT4YP1tADfw1FZ1qqbJr762VpZOcN
 fdoCIvfyb7/SJD/E12ZV0x+H0NWXGVrsbI1h5SPAWn8rJdKCR929BjTeE5MTMc161Vl9
 4BXqCftbNcMD2tABzAdrQHz1/mRRLca9JJXouKA0hP7BmUC5MI5rY/HbBY3fcsYlbTyN
 Mt5vG15Y0BcfYnUvg+30ubJhhP1+xtKh7ACVBvp6ytpQ/l/6d7eA4DtSlJjTwocssdUG
 6jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767293; x=1722372093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AGqT/HuIbzxdWkOMa17Gjd1RtMZJ6gzAqRn/Fh0hIA=;
 b=MHE+PaG1xgv9gFveQ+hiPZP2rSLCw3e1BwUJ25iLn9lDFgULpjYSr1VedfsY3m9+NG
 uoLJl+CxYk7B/Pllf4gXfiG6P+B3X+D6qyp03OzrIzcWVdlTn9ZGsW6AsVOgmhLzwsht
 sqnDxF3+VnQXa/+DQVkoaM0GBggljxaQ9sPqKQbdV8c0Z5R8KRQYw7GoniDbkWm80XxJ
 th2RZtQR9Yl3JjC4uFp7Efq6xXzWWA5wXDsr9VisKdUXbRhUW3jPD6tveZTV/1SK8IF/
 AvnGMJ2ud3RjoOMtoSnY26cOgLyF0Nu38I8M7J1FkikBoiNc4vZn8ERrxb71jQ7tbEhl
 zgkw==
X-Gm-Message-State: AOJu0YyhdLY438ZD6l1VqIcPHQji40pvrZOA5oNIcskIIU3RKd6JxlnM
 VoGgyz9nk2IsPw/Qm2HySJVY8iZPb32TaaUztwC9IydcmU2DaR+5oaFRSOcwkFhLKpb00/uO1NZ
 Uagc=
X-Google-Smtp-Source: AGHT+IHpO+edb2z/rqnljhNasjGftnMbopGoGS+FoHzexXbjYv+z1EGuHf7PET4boFUtrHppf1byMQ==
X-Received: by 2002:a5d:4148:0:b0:368:3079:427f with SMTP id
 ffacd0b85a97d-369f5b2b9d1mr33585f8f.30.1721767293382; 
 Tue, 23 Jul 2024 13:41:33 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f939aafdsm523495e9.28.2024.07.23.13.41.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:41:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/28] MAINTAINERS: Add myself as a reviewer of machine core
Date: Tue, 23 Jul 2024 22:38:55 +0200
Message-ID: <20240723203855.65033-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

While working on a series of CPU/cache topology work, I became
interested in the machine core component and would like to help to
review more related patches.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240722164412.1163414-1-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c048782a6d..a8e9d1b0010 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1878,6 +1878,7 @@ M: Eduardo Habkost <eduardo@habkost.net>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
+R: Zhao Liu <zhao1.liu@intel.com>
 S: Supported
 F: hw/core/cpu-common.c
 F: hw/core/cpu-sysemu.c
-- 
2.41.0


