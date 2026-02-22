Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A9DE68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIYs-0007aQ-Pt; Sun, 22 Feb 2026 18:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYn-0007KF-FP
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:08:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYl-00065v-Oa
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:08:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso26497205e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801697; x=1772406497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eG1Sb5LxM37W6z2kdxQTI7JotgScD5A/jNfnafdk044=;
 b=XnFtPXV7RKXjswTupGBxEasVKsMu+o+k8TNr6UJ8eGbnCbu1LkQnyKyK8wXByPDl5h
 8mmdrclE3bT9AxFjdYG1qmUzmjLolM5Alda4KOi3QvHWZ/99k0XAHPu4FFj1UQL1xLSU
 8CF0povij1vqMxmLJhmD46b/nT8hR8aGgpmRDHif01QMiAJqzMeWBOpDxycleW+72uY9
 IB/fneemGkOwU5Ax8/7Bx35KjeJwtdqiky7UiD3XyHQj9l27dFCKMkUCnd2eJ7l1k3IR
 ThmO3JAquOUTJ5FMk8x+L7kzLHKKX73hNL09PFQ5ZFx4l+Jy0Q+yADM08C0BnqVO7r/Q
 C7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801697; x=1772406497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eG1Sb5LxM37W6z2kdxQTI7JotgScD5A/jNfnafdk044=;
 b=SwL0CQ9YOaKhR/CRG4A4ukzV4cGKUzL9nu3LANiHhFeEzVgHpax3gKN3kSn25Yoq9g
 XX6+93kYV7LIWQDWvj/AQq3CPbewVIFlCcvKvZP0nZa2o3rBNmQ+tfT+DtmPrI4Fp0Zp
 WoR/RWJB8XX6eu+jy8d+9oazF9rXthpM95dIXtsgSeRHNlqiJCexP72hSnhV7ore85Qe
 xux1/qQOu49u70bUamnbzBnZ1t90nNnt7iVevRzuM5JUwxYYh2k5tTZrQJLUU6JWQTlE
 sB2xqPOTucQZ0LIKaYb0miq0moMapCvzw/DSbXdV9NvXU/vnizgIvSjEY56KR+8PL8r9
 imFQ==
X-Gm-Message-State: AOJu0Yypw+oKreZ0DMh1t5edwjNFckCvXyru/Z5JXuSqzYjdkjRpj2pl
 s3mvZ1sVCnz8K2QwBo4nbbZwjMAYK06UyoHGQ11qTn148vzMEEA6tuhskMMqvLFJ5s30Wmn/zMb
 RY6kJq8I=
X-Gm-Gg: AZuq6aLd3Ymnf2KsBreQVUD0DkW5yHb1BC6CIpKAjc7Bs4JjdjCFWAsRzUvawM2uQMh
 PUrH5TswLXiY/r90ImSupQ5tHtSScp3Y+t1KJrbrH/dCyZQnmOdiwuoGvwDhEGw6Hx08qYXKfYJ
 p9ojRsNqtMsTdDQsC4cp6voOXZErvRwEmb2x/XlTasjsIVdOkAGFYutWIghtx88bZ5yV/mhkJC2
 gE72yCAg5Fc7b0Wk3xqbkgMO5v+/utNX5KvGIxR7B61rTGHG5KoTr+mQlTHUUIr7QGO1fWdCViW
 3HoMvSeD2HUC+vZvib4jynLfCKVW8ArkWC7s15CDG8JkQZOvZpn1hjOc0BHtBODjJEWi+VB7eOs
 YEujXHweQpYaTIcf642EPXdbBS8uF1A2JZNjx+GHez5Q/fuk3ZTihLI16bCqwVFGK2WudhJVVng
 LXWWGM3/SWPwPyyO+0TRV67/YPDQBVHwYmSUZYUtfDfFMaDlxZw1otjjm4QAaeVmYhfXYz52RB
X-Received: by 2002:a05:600c:1d29:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-483a95eb521mr122970295e9.5.1771801697561; 
 Sun, 22 Feb 2026 15:08:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9cb3f31sm144097035e9.13.2026.02.22.15.08.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:08:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] net: mark struct tcp_header as QEMU_PACKED
Date: Mon, 23 Feb 2026 00:06:01 +0100
Message-ID: <20260222230602.5756-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The eth_header is not actually guaranteed to be aligned.  We attempt
to deal with this in some places such as net_checksum_calculate() by
using lduw_be_p() and so on to access the fields, but this is not
sufficient to be correct, because even accessing a byte member within
a misaligned struct is undefined behaviour.  The clang sanitizer will
emit an error like this if you run the sifive_u_mmc functional test
with sanitizers enabled:

../../net/checksum.c:144:24: runtime error: member access within misaligned address 0x619a74c32033 for type 'tcp_header' (aka 'struct tcp_header'), which requires 4 byte alignment
0x619a74c32033: note: pointer points here
 0a  00 02 02 86 aa 00 16 52  c1 d3 70 00 00 00 00 a0  02 fa f0 00 00 00 00 02  04 05 b4 04 02 08 0a
              ^
    #0 0x619a6ba84794 in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:144:24
    #1 0x619a6b5940da in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
    #2 0x619a6b592141 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13

Fix this by marking the tcp_header struct as QEMU_PACKED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260212140917.1443253-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index df90ff08374..efe270dbfe7 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -68,7 +68,7 @@ typedef struct tcp_header {
     uint16_t th_win;            /* window */
     uint16_t th_sum;            /* checksum */
     uint16_t th_urp;            /* urgent pointer */
-} tcp_header;
+} QEMU_PACKED tcp_header;
 
 #define TCP_FLAGS_ONLY(flags) ((flags) & 0x3f)
 
-- 
2.52.0


