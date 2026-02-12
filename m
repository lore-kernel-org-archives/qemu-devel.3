Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0269AEE3683
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXO5-0000mF-Fl; Thu, 12 Feb 2026 09:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNq-0000h0-5Y
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:31 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNo-0006QR-Kc
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso69380555e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770905367; x=1771510167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umz9FaOJkrxhBScr7QTLwHMuZF/7lh+gWKhwaBjbmJE=;
 b=YixYzT5gaIROnH5xBxumfeSwjqI+mTH+0HZb8QhcyQAgrgNDjTLCwfmqGpTF4QtVOB
 3fXvKJzVn7VV/gOoJGnuUlldmRYJnD/MH8nOWhG63mNcI2QTUS48dfZd8SaiQiYMgdv3
 LLtVfagaLSbMiZ84zEscBYc5Sm5YrXTI9Ee/pTU3Xt6iNac1/QbRSv5PhkKxq7woZd6B
 KeqpPmO3w53AahF5B/sWhFIl2Qe3IYkJBnn+GQpI8D96UiC95g4qkAT9J17Eh3ba0JUS
 odvadU2qUhS30YW1VVENQd1yEe2bm6R0V6kZuY5t7zEDD0PIzqz/GahSekIq/CVqIf35
 1MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770905367; x=1771510167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=umz9FaOJkrxhBScr7QTLwHMuZF/7lh+gWKhwaBjbmJE=;
 b=mFWD3qGiV1HBqeCZEvWiUkB0ZCFVg1QyytV46IyoXgERZ93q5wlcyu3nT6Ptb5Q6hZ
 03VbQwRYqfA06MYf5a2YHewm9t9VcFbzntIIQRUi0bT0Enc0CCXP/r28BAhKVI8fPIVv
 6BWa7dg/LY9uSPZyZcjEOfppU06BP+3rDzUg51DewtnKAWS2VnQOFBI/eYtTtm/yMqQt
 oT0oH5pOLrumRFBhfwW3TdL9b57O1LRhS3jTG0EHzhNVrBp/MXJ+Jkc2a13aRJ+EemRA
 a18zM3EAdDZdjLHJMRHX227G1Js3+Xjof1j/NGECxVWWIiXmIe2Kyy5My4Oo4NXffE8o
 JVHA==
X-Gm-Message-State: AOJu0YzFdlIt/OgPrY/nCkCQ8LOtjMlL6HC3oPkBhA7QS5VQfgwqJjkZ
 KHGuFH0z3w4VkGVhFuGdl5Izm7RubY+/hqSWPBtf0xMKfnz2UsrDrASGEZUujGMHxXoFRHKHKDo
 dOY62
X-Gm-Gg: AZuq6aJj2uSv3CfyXGPhWi7cjlhHdXRsr/HL/U4heRWqaXmXe12xGIuhNKgSbplyug2
 8PDfGyYAyiObPPc3F31kKXtugwL41yporTSq+vbn4F6gZljuLKJe627Dsbni2gNFkmX4zr7D2cY
 AOsxtCD/gTViydsRouYHzVzSUpxUBV1bdDNyzjIYZi0JjJ5PMBrrWHTqadffB+AqmUO5wy/vUQK
 SKzT3jI2kg6l1/Z5og/MOT26wkcCh58+xipWqBzgUk0f+ZI+SIHOFAGUO1f+quSVpQtzU/WrZNn
 8r9CWW4LItLTpkjrgwlihsR7ekiIFPKSFLHhQHRL/BcV3YMV/mnan8O1B1s2GhlUfTEDJPpMmG2
 PfTA+J7RaiNO9Z/j99fGbOVKNhFRrf2gRTL+UHDrzE4VXS+fSehh/v2z8iMQonD2wTtuexh6QVc
 aSts1ohMzhUeO1ZKuJ6zAwgDpZfy8PTyhFoWHROcqnPsOSkjs4/3FM7mem0i+REtjSukQLGRTfZ
 tFOQRxKwBHd072tJU4SZeJJ8XXdMNM=
X-Received: by 2002:a05:600c:4584:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-483656b08cdmr44367035e9.5.1770905366947; 
 Thu, 12 Feb 2026 06:09:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm123266885e9.14.2026.02.12.06.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:09:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 5/5] net: mark struct tcp_header as QEMU_PACKED
Date: Thu, 12 Feb 2026 14:09:17 +0000
Message-ID: <20260212140917.1443253-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212140917.1443253-1-peter.maydell@linaro.org>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index df90ff0837..efe270dbfe 100644
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
2.43.0


