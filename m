Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEBED1F9A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5ke-0001ff-9e; Thu, 04 Dec 2025 04:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k3-00019d-6w
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:16 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k0-0003OW-LO
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:14 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-640d0ec9651so1234317a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840909; x=1765445709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYKOAMZxGQEu+IKZWOj4QK/Xu0CKwD6MX43mJOeXe6Q=;
 b=h+b5+rxxZAK4N/oAANxPfbezh9Bjcv+EwWJYryW+GCWSWDxcjctEpGPTfSH/b44LKP
 vOJQI0n4NEOIymBa7QDMXTmmsLo1xq/6PwSDBtMj6znjrrgSLP1MdAPAQK4bwE6cVdB/
 TR7ThkGlwCHEk1SKIz3AJ5zwQ1PVBwr/jYBEpNoT+49Sk5+P1oh1Z3DoT2XNaUnY2a/F
 vwX8/PWyMvG4f0gLG2XjtzdDmJ0NvXHvY6zwgRm4oadbhRO4hMa6yp8B5sjbzl6hrn4v
 bk6DA1ftNg6xg6/2i6RpwItypfq6U6vTFLtMMHFtaMjDke9x6eMgHTOC9/d4XinEh27I
 6h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840909; x=1765445709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GYKOAMZxGQEu+IKZWOj4QK/Xu0CKwD6MX43mJOeXe6Q=;
 b=cuBxmTg5MTsAFtDbJIKh26TyDyISZiZKwyI6VlNcg5ANVzbTqbIT7Rp2Bwb5BzkHKi
 V0v/Jak8wBsNQVkp+nbuXGm3HcNIOKdOYtpQbWayOaITM8JOUSKJEu5CzeyUBT5d/4F+
 QYRycdtBlBfYxhS0Q7XKCQn3HId+/qo7lcRtYaCr0wa0Two6Ey1z+VvCUdoeYRHXCrBo
 Jtox1AiJkQccpNPMdBPqbzl1ZTY76uI9p3RV7mu0uFIaI97G3diE1ayENTBW7x58Gm5g
 WYEeaPQy36tKi/86SfDCE8TvkasCgn7jH6xlw3NzncCWs+QwPc405rAhZu86BaCPVTku
 SCGA==
X-Gm-Message-State: AOJu0YxWzJ9Uy1Q4lMQJGy1UJ4wZ29mJcPnI9MCaOZ/714Gp3WA6idaq
 Y0E7IHcYa7e1Y6n7XtmdrK+dds0NbBuWilUMGzYo6Z9uohJzKG7DHzct5Q2Fv3ax
X-Gm-Gg: ASbGncs41qMn3yB6QUOi79rimeSRHYeL8vOt1loek65WAMbJSQxCPi1ultrQ/gh47R/
 Np4rgu3QZznPpbxgHWpoQewe4Z1p41Irl7bAmvy/E/RdS7tcWLuV5o0VZk3xdAmYE9nfaqbFaLd
 nzTAGOyUetXEa6Bjvbpb3GZ8J5iejm3eChEaT9GyWVw11cGyjeKGcW/0ExbFWhd+6MONQDEY54k
 4yVyNEmT8JJ6KdP9wzofzOBQSx5LLPF1pBmxGfAzp9/VDVk22Jyra0huf8cAjq0Fli41ru02+jM
 AJtyct4/FGNjPFeFfMpIXw1OdS28sJGdlulRpSxhvIyrAhZzSSxZ+1LFitdUU2RWcTSMiOGovEO
 ee4FDS8AZM4PdJnL1JPSl8+v0UqQ83qjoHvy+eCCBhTg2lXq0U+/aCnUm/rmlGPqQDkZ9GM+fA9
 OZEtcHGUjhGSy7cZxuGa9csoiE2FyxTZE=
X-Google-Smtp-Source: AGHT+IHRWE58FcvoPJ8ZSmwaHY03rwwe2vOUSoLt2uGh886mo3Qht6opR13pKJXbn8T91+cGXeqOsw==
X-Received: by 2002:a05:6402:51c9:b0:641:8644:f87f with SMTP id
 4fb4d7f45d1cf-6479c4f7003mr4697998a12.17.1764840909049; 
 Thu, 04 Dec 2025 01:35:09 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:08 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v5 05/15] hw/dma/zynq: Ensure PCFG_DONE bit remains set to
 indicate PL is in user mode
Date: Thu,  4 Dec 2025 10:34:52 +0100
Message-ID: <20251204093502.50582-6-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

All register bits are clear on write by writing 1s to those bits, however
the register bits will only be cleared if the condition that sets the
interrupt flag is no longer true. Since we can assume that programming
is always done, the `PCFG_DONE` flag is always set to 1, so it will not
never be cleared.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 0c06daa6b9..72f7b1f170 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -188,6 +188,8 @@ static void r_ixr_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
 
+    s->regs[R_INT_STS] |= R_INT_STS_PCFG_DONE_MASK;
+
     xlnx_zynq_devcfg_update_ixr(s);
 }
 
-- 
2.47.3


