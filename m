Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB71BFED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMA2-0003DF-4W; Fri, 24 Apr 2026 15:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMA0-0003D5-85
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:25:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGM9y-0001Ke-Mi
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:25:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so67664465e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058753; x=1777663553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tzK4a1Flm59I9Q24EcjCaEhFwt6IvDJnugZq17BuzlE=;
 b=BfH9AcvpjMU1cbIBPuHfXfx7ScBM7R8HwmSMM9ZMmU9+yN9T4rUelaDLkTpHRdqizV
 qG7Z2O02vtidG63nmYjY3n9fLgPVGH7rsr4BP2OC39ddSuAKxQ9ljizcxuB2jXXzvBse
 0U5YsIaXabt1WiVr2yt64d06XZIw3EfPs6FdryKk5WIwy1zopTKcNn8CbE/g92cdAOyc
 w4cq9OfKU64MFipt1THabJcl3pn7E+A8yahkIKCOcYmm1XER1siXIo04gUAV7dz37umD
 MOgCFV/k+yLeLI9zarnrs7lefOuLWg4/8EoAS/QUFVY5hbmjOOzsPUeYL5zyxd5pKRGS
 r8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058753; x=1777663553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tzK4a1Flm59I9Q24EcjCaEhFwt6IvDJnugZq17BuzlE=;
 b=nWJ/Fdkub6OXM7A5+vMcVudVkLTuJp+9nHj57g9/FAosgZxcOaEWARBXuzmKVyza/D
 orYeHpXZ53zj7fePLbSnCX8OveO6VOFdj8nwtVyjEMSEq9MHQTfFlJdftJ7ilvuCM8CZ
 bi98eMNKrUjI2lCEus2Jqayl5tdydU1FrMaRtWQDhgA4qix7XrkLLWUfVhLWVuV3UpBQ
 owIpX5pwkvGp/al1Go01gOKhY4yKEHaeTHS+LqKPJhrj7kqhc3SCasAD8RtDgCkht15u
 7BJqH19fV0wqRGwcyj0IE3BpZPz53vs5vGdipU+bWTu9BpO6284FKaIzDMWRukVVkS9d
 errw==
X-Gm-Message-State: AOJu0Ywq4xfowPqoT3sedlFrcodRXN6wtE6YnI2bvwFj7R76PmvEuq+b
 z66uhzTiHguz0nVKg8LRRPU3O5Aw7zDVzgpUV0z6xinj1umBYCZvQ9dVIx7qcPuutGcs/Gq9rgk
 NvMUMxGI=
X-Gm-Gg: AeBDiesz8j5sVCPuya5iOliGRMmjgKb9LW0ShjFugWaFkjzxrpCbpVvkw0Wp+xRj/bZ
 RF00X9CxH4NPehFoDJ9cnJ1iyuOyAtdmJVdNVyQFETpMild+rSKeRo5btqhY51Dcq53/XzEYCAw
 ZDJDribkgUCzACO3Z21yBomHV3sAkQHrAV+qRVq+M93I8K51zoh3tdUnzzIGIWOgE7biBmy+9n3
 IRiRdWII4zdCYbGCluReklQTnwaZVnk1U1qgdPI8YUfbc9WJNatr703Xl6lJIjApUYCizaZEMbV
 UKCYkYECbeEa0kryk9qogOA7J51DMtulLTaUtXO9UfgUltakxoPukz289ykz+EUdlSi5umrpxkT
 K+FmxB4+53ib9do7XxDbd7HHG+ref+xhN+dbzrWr66zyAE8OonKyStRoZll2RA7BkxdpwClNxYu
 CZJGrrRNn8IZkmtxbKBs2boMqU3sIizI6uJAhA77HjOF/QwaKm8Kpb+hXWHY43uDHorQ2dZN5Zu
 qY8eqISdws=
X-Received: by 2002:a05:600c:6296:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488fb7923a9mr434645455e9.26.1777058752688; 
 Fri, 24 Apr 2026 12:25:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52583fe7sm302140865e9.13.2026.04.24.12.25.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:25:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 02/62] hw/core/cpu: Expose CPUState::start_powered_off
 docstring
Date: Fri, 24 Apr 2026 21:25:33 +0200
Message-ID: <20260424192543.22614-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The comment about @start_powered_off is buried within the
CPUState structure. Hoist it to the structure docstring
comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260423170229.64655-6-philmd@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6bdae9ab707..207a7a1becb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -419,6 +419,7 @@ struct qemu_work_item;
  *   QOM parent.
  *   Under TCG this value is propagated to @tcg_cflags.
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
+ * @start_powered_off: Indicates whether the CPU starts in powered-off state.
  * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_threads: Number of threads within this CPU core.
  * @thread: Host thread details, only live once @created is #true
@@ -502,7 +503,6 @@ struct CPUState {
     bool stop;
     bool stopped;
 
-    /* Should CPU start in powered-off state? */
     bool start_powered_off;
 
     bool unplug;
-- 
2.53.0


