Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2A1E66884
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfCI-0006wO-SR; Fri, 19 Dec 2025 13:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfC8-0006vn-Jf
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:27:18 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfC7-0005XV-69
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:27:16 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e33956e76so897301f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766168833; x=1766773633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wU31SR/JT4eTFC/HWfl2NIM8RsVwLMoHP1xZxIQHUvk=;
 b=MsgkAzIsWMtceVglKgvSeH2z9sYn8D6JgClg9t/aH0uL78NpHTYu5OHva4cqVINiX+
 ek2EuzjnuubtlSFOnc3BraUYkHz/M5FPtnPxuX51BKLwUJeErA031XStPgyKoONQupbt
 U5Lry7i3cAjUMGT6P+gqK1oOyQZns6wXhiR6nYrMMEbKEuHBpUm8DtZbE6X2A26u9Jy1
 Ws2hlClAeTvoGjyj++jB3y1G7TWgWyi5YaMhNaCY2I3c6Hn4iaDTozWCqzBG9CZ73YWQ
 ELcTi+SIwCOs3jwDV5lMh+WRIy22QFg5vrUHvoaA8ckRbsDtyq3RADQ8OVadQX2rtqhM
 hZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766168833; x=1766773633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wU31SR/JT4eTFC/HWfl2NIM8RsVwLMoHP1xZxIQHUvk=;
 b=IqUI7rcV/SSDZU4bwax0D3UjLzmQL9daBYckJFaRnHAyEAmelLQpUlQmRFN1U+K4sT
 rw5A6ez3l70510YwXE9BlVj3x7myUCWZntB+GNSs3TmII9XVeD+i4F6PqNWjVyR7kQUL
 T/S0xCPtzJ30PIrnvAad+A7sjOwjOZvvnrRTvP89xrVgjzD0eUi3zA4F2PGIqnc+gA/w
 TbhtvD0wHA51/BeWAPrZ0E4ronI7MwSk+DhCc30kWQTxK4ujH7oIz1DCmZRdU6OVXISl
 IC1lV7dSi0kzs8SNbDnGZDIXrIypXVv74iUm9Id/+iD6w66wJut3X5hNQynqrGihhbU+
 qVzw==
X-Gm-Message-State: AOJu0YyAXQG8iMefVl5RCmanhbNSE1Od2SSdtGw7udGX1G4oO3rPwu8t
 PAjV9a67J6KL0iSs9i8SULjixZS0H/xT3dgx4zFcpV6xgtZbVm0u41Ol+wCtDWxmeZUhjqDhyDa
 epV9cWjM=
X-Gm-Gg: AY/fxX67Pn5mTP9E/2NZIDXxco/ZXaL8+0PXVsbUcLLLWfAwa6/c9yKVHcOsEpVZjfy
 SLt/Nu8NIT5Q/ib4dN4x/7AN3UWfSx/YtHcqFBPoZWSupeYCxGDXEht06YpZ3eYoELSocbsj4mW
 Vq9mIs8PgChfhxQ+3lH4IK6m5brf2JxIjSBiGAEcPpp9DpUwWP56lBMRYrGh7/lrNkoQudCaMK3
 HhQ6InIbM+nMeCVFLYnfCg+cwJHF+Iz4eqIsJ9xfn82xtn1Tg/GzlYnaV1SFCCbvkbj7wBqB9Lx
 gyCO7/2Y8Xd9gGeorqzPaPiZp/XBw7A1zVgRMPowytsIlndg4MQE13wD59JvWGiwa2Q/7tZLcLq
 6In4/ERcFS8pRIZDa166OI2nBvr5xqYpVxlOoh1JPxv03utXm/PyJedfmokfUDDAN9vG72FQmeV
 zFo9w16dn0Lb9QkLgcF6vvhzeNSUDx+YLOkIZkEjg2CRunAFyqZ8QG3gfPZDng
X-Google-Smtp-Source: AGHT+IEgHCo0xIkulVfgZ3GQuRaboSUWDc/oonliOn/LXy44R1ZWufYTB1uNL2TlW8tdWRe4g3WSzA==
X-Received: by 2002:a05:6000:220c:b0:42f:b65c:1e4f with SMTP id
 ffacd0b85a97d-4324e4c97ccmr3890236f8f.17.1766168833309; 
 Fri, 19 Dec 2025 10:27:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324e9ba877sm6281592f8f.0.2025.12.19.10.27.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:27:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] target/openrisc: Use explicit big-endian LD/ST API
Date: Fri, 19 Dec 2025 19:27:02 +0100
Message-ID: <20251219182704.95564-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219182704.95564-1-philmd@linaro.org>
References: <20251219182704.95564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The OpenRISC architecture uses big endianness. Directly
use the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/openrisc/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 45bba80d878..ca1592c6200 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -50,7 +50,7 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUOpenRISCState *env = cpu_env(cs);
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 
     if (n < 32) {
         cpu_set_gpr(env, n, tmp);
-- 
2.52.0


