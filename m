Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F08EE3683
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXO3-0000iX-Ga; Thu, 12 Feb 2026 09:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNp-0000gN-Gj
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNn-0006QK-VN
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso69380395e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770905366; x=1771510166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7/HOOx+I4w67JP8F45Y9oVZsaYEEhfC+iicHDh+kCk=;
 b=t+cJ19PHe34CB2lXOxf7cAlhABsUJhyBQudJyWVWG4+3XwXRabRJLjKph8o5aE6J2R
 fox8v0HuK92U0r6dmwSnN/OVbXWpmPY8btTIFTF16dZ8qxpwJNcKIT/ZfZASLmD3m4fh
 zmCGGuP0p5MpxOC7GLpT+2kh2ArBTIBeBdB1JJksfD+xwsm8PQSB7J53eNDL/3EJqQ6t
 Pyg6m7dtQ8PvyEGLhXKMlfWbG1vUBDxdQ/b52LsPMSeN4F70m5cA8deS/48MOFbbvxWo
 /plOFRDbV4qbGqtWf/ODsVdu2NMiL/IaGSogAS7lrF/rtJcOzNyVCA8reDbbOk57eTUi
 QEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770905366; x=1771510166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7/HOOx+I4w67JP8F45Y9oVZsaYEEhfC+iicHDh+kCk=;
 b=orADnXY2Hd6rK1tgbgbNMHSNoJ9b+EzFlONN1wcNoGISfz9a/xuN2ERirFHkKlGTSp
 5qkrljMMr6GWCztSc66GCFETtjd0POKQuz195scqNwnlgqNmxw/jSgFLvkjRL+EalNdU
 zF5uVX9kyqdSHYezmxVe5sNAVxq9cCgFM4CxZUCjJCFlIYg/bLlUxWocgS4r9eps04Hz
 F0NwMofEN02mE0xecCzLRJ5Dr7R+QwXOTHTf/drlKnfQM4KW2LvW01GZuxi/X+9tByVC
 QWWSnq/o1EZ2OQG/i7SDDTissoKwn9UnhBogH1oEh6+dwSHkZNiFp83qD9S+NH/vSYR5
 +DQA==
X-Gm-Message-State: AOJu0Yz8KpLQ7tBrKYVlZrkgPw3AKptPJP3nCC6GM7N8UXNKdb06O2lH
 xEct5rbUHu3SiITmxjKETd01nLgLElybkCkfGbMEdIk5QiccMu3WB3WhD2/uEtU9FVWaA6hIZZ7
 kHrAu
X-Gm-Gg: AZuq6aLyONfw2WEa5QeZzxRqidESyIDvPuOiVCYt1T1S2+DQBAOn6uRy7WkudiOM7kS
 6V49Gfo94B9G7jrDMHFLpXFsAgDS+Un7JLjW5fIUEukxJHkKgDUcSnGofDHOq7cpnYUOek9ywnL
 sBRtgGQx7LEJPjbiFV7B3fznNECCFaFeuZ8ebGey3tWNrR1pIjymoltQq8CqR5zrCthmigTI3Ia
 9LhR8310r0LO6uVArCllgMLniwGeid5accF5bkGKS1DccCHA0yhswuT5eL3vZWYAKbbTMdAlrq9
 dP71ryYw39u/HAzXda4f1Q39xqQ0tBx6aecGwe3l/9SsDXGa/mZhmHIV38eJv7f7h0D8kTtWRTK
 AlgRzGcHO5u1c1QcAMlE/iuwnHoh6DIJ7p/0ab852h15BzXEdSmqvlyXDn/hXYMkL7gvYSBMzn0
 0sAVOY0pHXEs3A2ASr3nc2cmqADdxg+TkhS6/rusBFVjwMrERs7Hnk86xnGgQmgtGFjon3hEY0H
 h47ht/JvZlDHH6inaFyQ8dIEZF+IkM=
X-Received: by 2002:a05:600c:8b64:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-483657181edmr36506925e9.29.1770905365699; 
 Thu, 12 Feb 2026 06:09:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm123266885e9.14.2026.02.12.06.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:09:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 4/5] net: mark struct udp_header as QEMU_PACKED
Date: Thu, 12 Feb 2026 14:09:16 +0000
Message-ID: <20260212140917.1443253-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212140917.1443253-1-peter.maydell@linaro.org>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

../../net/checksum.c:168:24: runtime error: member access within misaligned address 0x5b7a7f829033 for type 'udp_header' (aka 'struct udp_header'), which requires 2 byte alignment
0x5b7a7f829033: note: pointer points here
 ff  ff ff ff 00 44 00 43 01  34 58 54 01 01 06 00 85  95 80 60 00 00 00 00 00  00 00 00 00 00 00 00
              ^
    #0 0x5b7a71a5887e in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:168:24
    #1 0x5b7a7156819a in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
    #2 0x5b7a71566201 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13

Fix this by marking the udp_header struct as QEMU_PACKED,
so that the compiler knows it might be unaligned and will
generate the right code for accessing fields.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 63f598d7cd..df90ff0837 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -85,7 +85,7 @@ typedef struct udp_header {
     uint16_t uh_dport; /* destination port */
     uint16_t uh_ulen;  /* udp length */
     uint16_t uh_sum;   /* udp checksum */
-} udp_header;
+} QEMU_PACKED udp_header;
 
 typedef struct ip_pseudo_header {
     uint32_t ip_src;
-- 
2.43.0


