Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182E7C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7afu-0006VT-RM; Fri, 18 Sep 2026 11:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afs-0006V8-JX
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:52 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afr-0003Fi-5u
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:52 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f1e428so313000e87.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789745930; x=1790350730; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xMoDu1QpByTuhtR85NT6ecGaH4mvJ93T6FOMbhh47lQ=;
 b=NjUlBbEly2qT7u4E/LhRxGEtUIAuaxmcKEuHLe4wdR2JBdQw1c/D2OZM761GfEOwGB
 9EhjlTuzzr+Oi4FYOW+ggzCbkpwClsDp2bzo/ciYqYGkUhgv2XaOSW42/YB2ncpid9vG
 DlLUVyEMAbonKZ5GNoLFs88ZvR1CZCxytgvj+eb1M/4ZstZxbCRevEMZcOeNNQxgJvXL
 3rnCqfVDF1b1+Nd0fmTFJ3A5fBBMPtFZfOBZW6oGJ4u1aNOJNSHXFLP1YKVEt/FGvtfK
 rNjx1MAbLGnLz4kPLAb2xPC0Ai9EG5XOgv72wqltvAG5XtD9WIZiDDc3Mh0bhXTPS5Pu
 9X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789745930; x=1790350730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xMoDu1QpByTuhtR85NT6ecGaH4mvJ93T6FOMbhh47lQ=;
 b=25TKosNGSafdl1Vq7w+WEqaaVtJSMVT6yLGphXKUgeeY3GBh0ARbe8LvRKUadAfO/2
 03pxNwjd3iQOMiQV788H32ZQ86GrIN4Nlk3wBrOWbf3YOAzl2C2xxItYLF2dYDfHNoDJ
 29oV5o3dyGZQWW2X2HrQkcPZUKpcr9SMBd7KLj0mKSrju1pGTgJbC2tbSlWG1AvduYwb
 bcQ2sD6JvZEGc3v+aAIi3jWEWnqMmDZnbUdXr3ZhJhkv/DrzTEkzuuYkcI/rqL1WIFeL
 jMVvZzDDSHZoP+Zp3L3QkQCeqFJHOaUevKybfhUOy4ImnKRcB7qCeZKZvqvNmDBVW18q
 XVQg==
X-Gm-Message-State: AFuF++lvcXuZp9b0xxx6Q66dPHiaZFbJWFbwYwby75VXxm3CGACm5mj4
 nvRvdzEYnvkoH4u0zs9PAx2Bill0WTZLgnxtrwgRlrMIq44HAa5fp2Y0q9MpC62O
X-Gm-Gg: AYBFou25mQIKG7r4YOhxaRcB2/9i3xvLp0+B62o0rEg2BzvB2Ns/ZW6I6Bmwgbn+yZ7
 4eM23ueKWKKtAiu1JTULRuv0S1oQlol8VsQp1iy6bg6Rj1LX0i3VbPfr/sP7ojdm/tQ4BwKrltr
 3XKGUtMBiY9/yV0olz+zzW5zQxyBpCsHz9T+xqw4VCNbXv6VaSzaEiDTJrMwgh8n5bLw6fAge24
 +zlFZnkNC3NBAjqOBDrZC3MKoqlEoZZ1hSaDlfRK05cjsZ7LOd/GQtEE6+5m2UyX8KLmO4SSd4K
 EGyGjk2oDqXcQUhfZoZlevKk5Y3r6rq/MBv1ivxTVz5Ii/fgQoml3gfhsi2LzUGwn64IoSQmamd
 9XoZIxzHuBrTPcgLeQovq2VqY37EvspoYV03da2dySjU/FrwCQEuFB8H890Ot0NcBcDu4ySm2sf
 b4jn+cN2+EeXpF6mQvY2j6kq3aDSq/n+Eq85CZxoGPBG2x7y7C+DYbsn5LHHAOSfp/w4UM
X-Received: by 2002:ac2:4c55:0:b0:5b7:5cbb:661a with SMTP id
 2adb3069b0e04-5b8c13bf8aemr999985e87.0.1789745929438; 
 Fri, 18 Sep 2026 08:38:49 -0700 (PDT)
Received: from localhost ([213.79.119.14]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c2764436sm557642e87.58.2026.09.18.08.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:38:48 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 18 Sep 2026 18:34:41 +0300
Subject: [PATCH 5/6] hw/riscv/trace-encoder: emit Ownership after ProgTraceSync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-upstream-ntrace_msg-v1-5-16a56ad8e0ef@gmail.com>
References: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
In-Reply-To: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-riscv@nongnu.org, Alexei Filippov <halip0503@gmail.com>, 
 Arseniy Semenov <ar.semenov@outlook.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=5JAFVF/giib3mLt4b9gt4wJtuYMMVV92C3OMq/vyy3Y=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqrVoN2SxrrR81DB1JB04q0+gAxuoEaom7S9eMn
 WFcvgmJncOJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCaq1aDQAKCRBIiqVupVDe
 dsV3D/oCnp96819FhtWSaXX5rei7idGuR53pyslT7FhdSpC9v9tZazeZhiBk3lnL3Xer8FYDFbJ
 0EutWFxjEAMicEjpl2dPaGJTJD05A456RihQ4cY4WtaZdfbFqTh0idIkDd2kxT1spmt4c/vhVAZ
 YJh83WunjECzkLCKaYrgos96fCQsQJrA2adr8A1EkOd4R76rFjHFoxKrU+3FF/ugBHrA4Hutozv
 Eiu+bZPg8YYPrIQCHjCqAGLh68gTXHKfS/S5FYqSgM0O8TqCbxiuB7r0BPWYE8QWod0h3FEAFuK
 qjWOzbLDK+Q1IV9rzdjwqqmKbJH+i3d3kA7w1ddjOdxS2ChnBOrL+fOei1Dnk12C2ovG+yvbFBr
 4664iNidJlyOV3bvhoc+BEEh+BgSiL90pwNHttlYeMSRlS/D0S05DKy/HjCuKHlVsS32ovkTE/H
 Zw0TfqIfPgUYle5+CKSx0ymfvScZkvFba01qMs9JmGCwgGwgHLpwKk2zbLCdt9YVtGuCQ4irqez
 Swr/FPhPQG9+f4rg6pLZc8s6vbO64dNmhtx4OkvHI7ecaRFiPYhBj2aCbqr6X69DNx4mz5I3l43
 oHRExr9m4bYgubJQ1svJyb0rE1PRepqQNcbhsqB6eiPlvkJkQSytPsi6UR2dlPOFaTXyue9jrqo
 4Sqb9kbhp3DNokg==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=antikostya2@gmail.com; helo=mail-lf2-x10.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

According to RISC-V N-Trace specification Ownership messages should
immediately follow ProgTraceSync messsages.

Signed-off-by: Arseniy Semenov <ar.semenov@outlook.com>
---
 hw/riscv/trace-encoder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index a2a030bb83..7d8b5d4fae 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -737,6 +737,13 @@ void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc)
     msg_size = rv_ntrace_gen_encoded_prog_trace_sync_msg(msg, faddr);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
+
+    if (ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL, CONTEXT)) {
+        trencoder_send_ownership_msg(trencoder, FORMAT_SYNC_HCONTEXT,
+                                     trencoder->cpu->env.priv);
+        trencoder_send_ownership_msg(trencoder, FORMAT_SYNC_SCONTEXT,
+                                     trencoder->cpu->env.priv);
+    }
 }
 
 static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t target_pc)

-- 
2.43.0


