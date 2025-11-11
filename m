Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8CFCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlcd-0008HY-Ij; Tue, 11 Nov 2025 05:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcI-0007XF-Lh
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:50 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcD-0000GJ-41
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:50 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b72134a5125so589543166b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762856922; x=1763461722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f25omtBgfs0TevR7//KmvifCDlD013yaB1K85NENVXU=;
 b=hwGYPzfz7On4nfK2oK6FrJgcTp90bwvpIkwJeJWySxKLB5SMwLlCRqLMROOmnVUxvO
 zdU/1QY8uleY1JYDMQ/whWAg5Dz/2ixjLH5s5lXfgOlk/GdsR/ce02Nu6BRX5sH6ELfy
 m38To3CGaitX/5NInxYBn4+L7AHoK+ZmkUpSTq2YxUxhFbuA8qPFfUlPUoTVFi+eqEIZ
 kYfkrCpXhKZURcIuolIaZNG0v7iYgI/qIk/4i0SLSu+h56stXBN9MqBfG9g0mWMyqLqo
 s92aUCIRRWLmB49KLsSICqgRnQiyRTZ9Nseva1OQSh6NHTXGZZPKBjFtYKXAmDudahgV
 sYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856922; x=1763461722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f25omtBgfs0TevR7//KmvifCDlD013yaB1K85NENVXU=;
 b=l3RFE6Xle/+ziR5d+pU56B/p9B7/ud7ab2fh579m5gEHQZ9PddBFupAK2MoSGOgIuT
 +5RNWFVwZ933KRYtffd5F6kE/ucHJXsIb6DsjFu/s8ILv88Muq7R1O1ExiSc2R9Z66Qt
 ZWrZMlmYS7DaJhK24wOI8S+WlEf7MEgfIjTHGIXy4oEhv5/3GbwoWOAmHbxbiiOsFKx9
 g6J0FxYNn5T6V2Yh5M0Jt7Us6KE9eEscK8IQgwT9T+AviSk50Bir+MVU7MeJ8C42mn6t
 mF14PVbxKmI8AJIgbeU33/LhYyHkFxtqaXjTftQNGxRtoOQryDZDnmUx4MaTH2J3Pfn1
 sGWQ==
X-Gm-Message-State: AOJu0YymnIT+JbEpzq6uXcnfhcvVqMWAQQCuC0KbaR4o55pwoBojtU5S
 B4JmPDBWkpmV8GmgJ8VT4HajPhAXG/kGIznuaP8/aT+31S5zJuYljavXf/Vow2XP
X-Gm-Gg: ASbGnctDB0qi0fk8RgyWxYY/hIgTI8+ymhiXcibKlqVg6a4z63V94qID+vCUAnQegZV
 0cgCFqgAKIHDA6GhQC+49uNkUsBMxkDfmmwDblR1DVUrOBz/cXSirgpl2bcHoiww1KfTJkVdgnC
 SacfgXBK5896BD0SVho956z76h3qfC7iC0y8CKsxMybxPC3VjSQ2CQDRN0YgtbLkXnBU+1AGE26
 0RijsMd8bLYeL3J2JA6CPbqkGRgMWzlE10RBETw8H/CZQuEi4cJQS60ognbZgbtDT03T3x93sJB
 igOc06bNSvv6dFSt3HUbquCRFF+vFwXBKOfq35M4Gu1G4vwAaldgmshyxy4GAN5ZjmgAfRUJRH1
 cO9jtMvBApc4waaiPLqsCsgtSvoyl9/5RMQum5FbtZU/zqt54yx6JwBkesvsqnfrS4+BYHRfNl6
 WGPJSI8xuBS12ydSF0PV5UGZAYRrHkhlwB
X-Google-Smtp-Source: AGHT+IG/DF2YjzTNfFm4f4hlzcdh5/CzFCiTeGXost6wpPq4FqBWreDCamev1Vp9QhJhsTYuerNBAQ==
X-Received: by 2002:a17:907:7b83:b0:b40:e687:c2c with SMTP id
 a640c23a62f3a-b72e0562db8mr1112914766b.37.1762856921585; 
 Tue, 11 Nov 2025 02:28:41 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc12:ce00:ae91:a1ff:fe8b:15a7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbd1ecfsm1290619366b.10.2025.11.11.02.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:28:41 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v4 04/15] hw/arm/zynq-devcfg: Prevent unintended unlock during
 initialization
Date: Tue, 11 Nov 2025 11:28:25 +0100
Message-ID: <20251111102836.212535-5-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111102836.212535-1-corvin.koehne@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x636.google.com
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

During the emulation startup, all registers are reset, which triggers the
`r_unlock_post_write` function with a value of 0. This led to an
unintended memory access disable, making the devcfg unusable.

During startup, the memory space no longer gets locked.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index b838c1c0d0..f28d0015e6 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -221,7 +221,9 @@ static void r_unlock_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
     const char *device_prefix = object_get_typename(OBJECT(s));
-
+    if (device_is_in_reset(DEVICE(s))) {
+        return;
+    }
     if (val == R_UNLOCK_MAGIC) {
         DB_PRINT("successful unlock\n");
         s->regs[R_CTRL] |= R_CTRL_PCAP_PR_MASK;
-- 
2.47.3


