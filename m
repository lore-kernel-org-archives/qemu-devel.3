Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC7CE6817A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIYb-0005bg-ET; Sun, 22 Feb 2026 18:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYV-0005KZ-Ti
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:08:04 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYS-00064C-CL
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:08:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-43767807da6so2714917f8f.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801678; x=1772406478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aK+ULSuJrjq6iUTZBtmAVuymd25sCvXT9HOk0d4M3v0=;
 b=NKjvDxRfGWDoiWNrsBxWIVJkezoRGcqxaWgLpsTFGQBYD0RDoInpa71dbHYLhitekF
 ouhUwtCoHU1CwdZN9Ovw3PHrrBkQLh5/WNkpATxme9UEI380eLwqe058ofUG2ZPLKC3T
 nwdUiTw3fEco9k5RIPO8d63Qbdd66CY9m9Y30QUJ1CogOHnwj2OtjoGbFUm3+dPO9P8/
 obr+CBTZKnpPx+o7aGuSwYRAnb2+SAjCls3YJgt9Aa7hBIZLWwBlXYYKCM1zPEgZRHlH
 NDMiHk5tA91S4KazmLyJPzMQqtut8Y2SuzdBFs/HZcPaCUj9nK7EY7G4FX8sPMQle+vb
 2c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801678; x=1772406478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aK+ULSuJrjq6iUTZBtmAVuymd25sCvXT9HOk0d4M3v0=;
 b=Vtba7nBBtShVBcg5qaaHF3sXPPCCuS/gXamuNjLtep9NX5/ToFH7YyZrCnZAIznvTx
 XA6qrGUELs6oqj9GMxgb1mD1P9UdDbx+80uC1jZAleaNhkniTDUP6Gvj8ynhggee2K05
 OdGAZulrsAy0Y3EMbpRpD1dPeKhw2PEvhd3f3ZJOAMAkvW1Rdf2UNsMnxaTh8vwcI5fh
 ngtUQ1mn49xGsWKuhyr4kUEUg53ZBASga1suNYL120dL79lHBJoQEg8AWbuNylsspEQN
 bys/wl3JZQ1dnlSxs7JeQbpn6m0YcNBd3JR2GK/S2umnHZWfT2Wg90DyTBHD9yQ/ON6S
 X73w==
X-Gm-Message-State: AOJu0YwXICu5C9dT3iv3WFtZX58zjpIywj8Mx/IStTRfGhag+qVDl6OF
 W+E1DUZGnzCKBzLtiS5DYnrrTItBnoa0MvcVpE4gXhQ6/Wt3eNf4Wd/FVDRAHh+hCe6fGGVhF1R
 X/NzRt+6WPw==
X-Gm-Gg: AZuq6aJ92pmSRW0jSBajDp7IyPDzsuNJwmmrfuwkFjUfG3kzZgNRYAMLOcHobvzRmQZ
 tQpzBeF497P9a/+9ODb7jHl6GcPis/gtVzQ1Sz4HDfYR2pNnXrljvU4vvFh6BAdcpRIZ+NGeYgs
 iMlccgN3f79Z3FYWVzw+BY+jMGADovdhW5YxTuYBgUf8tal46PSqt8kY03ImcIv6Qx0BI9iVAji
 CISbqs5vdpffmHxRK/x2b7bWRnPsBAjG14IXwLXVZRZq9urB8u8BVSd2URGQ0NlajMS1nMhjh93
 WhpK79CeDpEL4o5E9dSxJys1BcRqSsQmShQx+oofOeWLg3BJOFwkXajLM2OfvbYhQNpHaNCrlPL
 6htdbgiTe4UGQO/5tawTPKx4Xpk1ltA8vpRalHrkGC0jQ8LUHBnnXW1K+/Rf8WjgColuLJpXSp5
 PCkBFW9CUhS2NOptLQ03QEDdmPQd9yA6R3/r1t3cWR2/iIpdPEXDirq39h6+Uv7pTdpL/xmJQJ
X-Received: by 2002:a05:600c:190f:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-483a95574c5mr114461295e9.0.1771801678285; 
 Sun, 22 Feb 2026 15:07:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b75e63sm256026795e9.6.2026.02.22.15.07.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:07:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] hw/net/rocker: Don't assume h_proto is aligned in
 eth_strip_vlan_ex()
Date: Mon, 23 Feb 2026 00:05:58 +0100
Message-ID: <20260222230602.5756-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In eth_strip_vlan_ex() we take a pointer to the eth_header h_proto
field into a local uint16_t* variable, and then later in the function
we dereference that pointer.  This isn't safe, because the eth_header
struct may not be aligned, and if we mark the struct as QEMU_PACKED
then gcc will complain about taking the address of a field in a
packed struct.

Instead, make the local variable be a void* and use the appropriate
functions for accessing 16 bits of possibly unaligned data through
it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260212140917.1443253-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 3f680cc033a..12ec316e240 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -274,7 +274,7 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff, int index,
                   uint16_t *payload_offset, uint16_t *tci)
 {
     struct vlan_header vlan_hdr;
-    uint16_t *new_ehdr_proto;
+    void *new_ehdr_proto;
     size_t new_ehdr_size;
     size_t copied;
 
@@ -298,7 +298,7 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff, int index,
         return 0;
     }
 
-    if (copied < new_ehdr_size || be16_to_cpu(*new_ehdr_proto) != vet) {
+    if (copied < new_ehdr_size || lduw_be_p(new_ehdr_proto) != vet) {
         return 0;
     }
 
@@ -308,7 +308,7 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff, int index,
         return 0;
     }
 
-    *new_ehdr_proto = vlan_hdr.h_proto;
+    stw_he_p(new_ehdr_proto, vlan_hdr.h_proto);
     *payload_offset = iovoff + new_ehdr_size + sizeof(vlan_hdr);
     *tci = be16_to_cpu(vlan_hdr.h_tci);
 
-- 
2.52.0


