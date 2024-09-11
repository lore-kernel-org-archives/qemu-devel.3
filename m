Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19005EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKQ-0005vN-51; Wed, 11 Sep 2024 08:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKO-0005l6-99
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKM-0007vH-Fj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cba0dc922so24694845e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057204; x=1726662004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWL345A/XYhwQTujJIR5zrqC0G+dOw0KBObWPjO11Bs=;
 b=yC2DlJJqxXFjA23DLe0hc5xtLnuT2XYfMQ5kNlkPUl9YLU88lQ6+c3eiSTfPUjOyPl
 CFNJyLrUkLb1bG9SxLEn9ulMqIAuzkqHVflXyAH0HM9kF51tyYrczQd24Mkpf3pWhuse
 i4aQc3p6e0I6Z3vgDCHaCeKa2uoKz++xV9AzyhAb09bUT+2cMdVQmV+PixLFbpVXh/Tz
 VHoyirbq6mCe8lQGgCG/B7RDrQPkZysYR8lMN+QuUZgxbQrxkoRvKuUu3+DAmgptmaRY
 Qk8hkL8Tl0dAebPaS8ZkQjiaM4gIcDQ+xgLJPEo9XqoRLrBEkUiOmVNNZgQqB+V3Q+Kc
 J8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057204; x=1726662004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWL345A/XYhwQTujJIR5zrqC0G+dOw0KBObWPjO11Bs=;
 b=njIdqM+MdO+A3x/rCi/QKjgaV/BkWSUShhyCL4Jq3uvKrX0npyD9X79xjxgvYVIhV5
 pM7YX9utfHTagq44DkeixuXGm+pWt1P36hUaoTcZQP2AsTUWEoaOsORtZDHHd8q51QR8
 Q8NUNH/BFuH8fSq3tvMJMg1LMjA/USHxRKwVwgsNJqaRJzYhrYv8U0JViz0PBNhIWuCI
 v7ou5rrhi39y39UMeSNSXbngEuUJCTk6sO/stHF8g9ol/KpF2CRWXoYTGMWMWa4xEUoA
 0SPhq8VTwo38gD5tZ5JL8fCzocfd8xY8BHoPa6IPoN3xdIN2DElP5tfoDcIl5E/p6teH
 +SAA==
X-Gm-Message-State: AOJu0Yzog63/JxXDWVlcwVF5kIrLqhcQfAcBUpvJAADoFyaCGryGB5iM
 Gon4Fx8jZ5Wnh/Fudz4gaYitwCaYcQb3cJwGh2igHJ3MkEX/B9dAdl6vsi8Sf2CT47vX49gTjw4
 v
X-Google-Smtp-Source: AGHT+IHDyBBDIT5DqX0OpKNDzpw5vgPnq2/JN+ceKMYotw4BiRoVp9IrMtGuncBXz9/UknV9kyKpDA==
X-Received: by 2002:a05:600c:4f85:b0:42b:af1c:66e with SMTP id
 5b1f17b1804b1-42cad75ff7fmr107503565e9.9.1726057204453; 
 Wed, 11 Sep 2024 05:20:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956652ddsm11522464f8f.29.2024.09.11.05.20.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:20:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 50/56] hw/misc: remove break after g_assert_not_reached()
Date: Wed, 11 Sep 2024 14:14:15 +0200
Message-ID: <20240911121422.52585-51-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-29-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/imx6_ccm.c | 1 -
 hw/misc/mac_via.c  | 2 --
 2 files changed, 3 deletions(-)

diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index b1def7f05b..fd5d7ce482 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -301,7 +301,6 @@ static uint64_t imx6_analog_get_periph_clk(IMX6CCMState *dev)
     default:
         /* We should never get there */
         g_assert_not_reached();
-        break;
     }
 
     trace_imx6_analog_get_periph_clk(freq);
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 652395b84f..af2b2b1af3 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -495,7 +495,6 @@ static void via1_rtc_update(MOS6522Q800VIA1State *v1s)
                 break;
             default:
                 g_assert_not_reached();
-                break;
             }
             return;
         }
@@ -556,7 +555,6 @@ static void via1_rtc_update(MOS6522Q800VIA1State *v1s)
             break;
         default:
             g_assert_not_reached();
-            break;
         }
         return;
     }
-- 
2.45.2


