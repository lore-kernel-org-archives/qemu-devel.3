Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1002EEE368B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXNx-0000ho-NR; Thu, 12 Feb 2026 09:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNo-0000gD-6t
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:29 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNm-0006Q6-1C
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:27 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so32424525e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770905363; x=1771510163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5ua7I8U2//YbkEEDizXTPRRQsakmeqQDlcwRr1J+aM=;
 b=xhE2kO2E3rvAgOsiccnqDLtELQGjaWNkH7thSoCSkx4ZgdTtZjdqVE8E0ylHOv/0U5
 SzjSqQJYWuPIuo3kZV//OqYj3Z78VzQDtliDq7W1nnaSEeKDm1eCH3dRO9ZjTKdYHCZ5
 aTgyOfxpg1SDcUjj42K7WcIMA0EQatOWrtVF/lzaQaJztZlkDCTUnSgVlI/JQha3Pbrj
 W+raUQ6sjpe7X2vfcs3g2mqBq1Zg+KnRXNJ/b2I7+PzuXbofwgzeKgs2s1YtrXraacL4
 5WFrRQVy49GLex0OOusYIurHgbATi1XGSgGAjgdcSM6pd/dYK8v30u+4SBm7QFP9mjuY
 FOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770905363; x=1771510163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b5ua7I8U2//YbkEEDizXTPRRQsakmeqQDlcwRr1J+aM=;
 b=NAZp+8LfLx891+4pkhQYg8oI3oUEOtjLmVSpVUg5vKyXSIUxuzH0/VurfexoT9ci/U
 uMA82XG2/w75liXD07hFbAwVJHUlOE0zvnB00gAbRlAgVAY+sHKGrahEdlWHox6bNFVe
 n7dlH9Ve5RtH9tiVJk6LGCoNo9EiqPvEXS5zEXkcGRBCfqz3EGOsa3PjYZteCrQxutWr
 1WekREqOr0/D49lmVYejCoMHshl8SwNKGqq+UcL1ygiEIjmu1h/6KwpUyW19aK209QDh
 8swwAbTsmHrD9qUT3cvS3Qq2mZ+1K1fIkoQYtYprEKwxb70uAGylIy0Kh4D1tUWC5YyD
 ztOw==
X-Gm-Message-State: AOJu0Yx86MPAVuS36Dgn2AwbG8DW57fDu82ZPB4GzRHqVygrvjKxw65B
 SndFWzBUpM6AfjHQuTWz7JLw2RcEkePMBy8oj3Za25aOKYFMs++UDeJCI6XDYW8yplEsqqmKkO7
 KtGjDYGg=
X-Gm-Gg: AZuq6aKr3msxuzTFesS0KL5kSs4zZCjxSGy2Spvyjmu3iNzIXdZCxBuVPzIXPT6l1SJ
 Z2ZcGLFsY7xZGmIkfZQGqXTaoc0vXwhj6SxL767FqkQC5Dub27RQS3Ce40LDrdIHdvUvvnP4HY1
 9TteytBmclZbI1gYg9/7yakAvJeKfvkrzOcXuNBFcgEqqtF+LOJIvoAoAd/TzxBLSoJHMQ1rSsE
 PRk+KpvYNNIdJ6KHYISwy0TPV5ZqLMIU5k1WCyDVmpGxn38QSgchB2epOWP2gSwHWz3/MxjVxjh
 e/LCysR9U/gVWO/ptZ6vCS0Tis83JkwtmVgBJdxrIslVyEeaEpryWMsD2V0GXRLj1gjOl/EsKfE
 IgWSIG24O0+Zz9mYxkdW0CzK1qi4Rt+sRsgfw94QPlEDFrsJAr/AgCnYAoOzaxusYzqldlNEUev
 cw5FYe/TgmFsNmeBabzykgX+y12cvs8p6ezhUFvuRUq3zCKYMi2hlvo59edFlfODnQOxCrw66Rx
 Usa6piGKcR6STR+9Ba0NDH834SwNsQ=
X-Received: by 2002:a05:600c:3e0d:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-483656ae35fmr43169275e9.7.1770905362982; 
 Thu, 12 Feb 2026 06:09:22 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm123266885e9.14.2026.02.12.06.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:09:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 2/5] hw/net/rocker: Don't assume h_proto is aligned in
 eth_strip_vlan_ex()
Date: Thu, 12 Feb 2026 14:09:14 +0000
Message-ID: <20260212140917.1443253-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212140917.1443253-1-peter.maydell@linaro.org>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
---
 net/eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 3f680cc033..12ec316e24 100644
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
2.43.0


