Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A285C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8Z-0002QP-5R; Mon, 21 Sep 2026 06:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8X-0002Pl-Ko
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:37 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8W-0002fP-6U
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:37 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0cfb29cso1053383a34.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986035; x=1790590835;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a2CNx2yAuTJirmhz9tsR410+Iq2tLlls1B+J5RZcPHg=;
 b=JKft2VehepEqBxbTP1HKaJbTbVTBPH3gtD71aHRGHFZ+jF5o0VLoXqag6gUVKA5Yna
 GXGspgUqz5/hxllUuGIzrwXFzypnz5+hHF9GhJPc3VcF4iG0vOvmFcet+yigb3NLVPbt
 XnJO82ugqDP8v6sG61zz0fY85ErjC5A76numPJpincxN1kvx2U/SLghk+cW0VX7/Q52Y
 7TxAEushCpYs/LgprA2wyQBht/4Ygeb+teBeywWC6Cbg5dmko19Zb19thgN7JPN5QmD6
 3sd9C+An6QLmQ218EKRhBhOWoY/zKVR5jTGvvzN8F/kPvL8zz7M7W/lgDW1S0PLI0DDi
 sY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986035; x=1790590835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a2CNx2yAuTJirmhz9tsR410+Iq2tLlls1B+J5RZcPHg=;
 b=IOneG7gIpvBW24Kybj0aOXFwMDUaCEgGImd8OW8lojR95mTrRTPgH9cubEmSR+u2AD
 1b5JtK663v/1RgL3lRbtB6GqE2jY56U2hogpElG0MhjNG7Rg1HtEyMxjJggLtI+tGmgM
 nXeEw2mZ9pJ6neFsPGYJvKAxZDtymFKkbgyecbUgv90ZPlZ7LFm4Hv6i7twfty5MUbmO
 OoTonZ6O86VIoIoxped2MmadZmFK9UmyX0OUDBx6EzKS/r5RYxyILL0NYsNJw0AK6mKp
 jAzG+fjXXnfO+zAz6a1FI9wlCe92aUMD6qLA7T2ivw0wXF1dik6CtVnjV05QaEaQiptt
 bjww==
X-Gm-Message-State: AFuF++kftKcc5F/EBQYtJSBn12dHJw4PHVDIIfjfz8Bw0WQWnSPDPLA+
 97FHPfsQeyaFD7oG1yMnahFsP6lRkjSu/2MoQcZFdN4JxoBLVLvJ4wkinUqcHJSmgBY=
X-Gm-Gg: AYBFou1uueFvxksQ5Hv3UukLbupPEGpQYwB4hcT56D1jyNohMs2DK4O3g5kScVGzxpc
 nE0AhTtw1aFQWxfI6j+dsIqxqtkfE0BZWK2lgT6KEIPrYyMqTGVpmnWK+usYihXcaFhkT+IPT+r
 Y7f1T/APYp3/z9BeR6XCDl0I5l1t13t0GPqtbapYm04XKqcqdlccGy0A5bW9JAPg9u0ozUy0ba1
 iuP4gavRONa9G77x7Tm244qRCdAn9Ll9ZuylZF53R9GB9TtyDWOr6cYs7Gt2pPMdQch2AlWoQxH
 lGO2GAkB6RoV9eHroWWxMuGPQERz4/glw/tiWFFwIz7jtW2CBQhONx9RqYshgDeObaAQMgRj2/i
 SbtHjkukLcB8YbNDg++8c5IOKvQXB9h9KiWgEoxPQAV6ZVgnvk4szkcHFNEykCW6mVQo2EYrC2h
 inVLsfyjCi5EMJ14IyrcBDPbZ/fevJvAzqViaPCZfCgPndO758+36p4TCe6A==
X-Received: by 2002:a05:6830:3150:b0:80c:d34f:5f5d with SMTP id
 46e09a7af769-80de2cd115dmr10422389a34.22.1789986035026; 
 Mon, 21 Sep 2026 03:20:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:46 -0600
Subject: [PATCH v2 04/11] bsd-user: Initialize per-arch child registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-4-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=684; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=cIeaM+XjTT1zUAhnOfefrbaYQqDmbpjiTKOOb/1fUwY=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTeckVrZaJ+oyDR/GAN9yWGOSjbZX6re4r8M
 t2JeETyfGeJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQC1vhAApfjI8qikk1rN9xZIy+a6NFY3YDhjjzf
 j/9a6I4KTEhmhD36rL1+nmnREM4Gh4QddA4MrFFQ8YyFnwjPuEMM+I8+ucXFOtUa+7wvzdRLknX
 k5mc0n+T4SsSdMOWsvBMxTtKDKWhnodv9NNP53REDQqmuuZc1vV1Y+sgZoU3T+0OZaOynCg5pNQ
 Z6/uVR9gFtwQ0Xy8RL60lKjvIVVp230a1uHvvkhv/1hH87rE0sEcWqFsNsq6NZvKaXJcmaqplSj
 mC31ow/g4jJI+f0RoozEgUGOnl1y61uOJXhkB0NG9pwmo4xqAQ4bzLTQebe4qO6dW5rQy6/mrSB
 E1zHwAdonajyfHx7aTLFcdXMnn2uURVs+BUq5AZ+uTyrG7kCTICRN/pVkx62jKAAKeX94AkKzEJ
 JVif4RflFNmk2l3ZzxR9raJ/caNDEWRaY0ohH4WoY2mDqHA5hczyHg3FJNs2iNHyhGmOWlPHe/j
 80D2RPYxigK3Xq9wwUqFogmuIx9jlCUXixk2P1bW11CudqchN315Q9Z6L+vRajVeL72SrASjG5g
 QgJzs9euqY7kUAmHWOVtpQaF3gN2Qn8oZ1YcpziqNMiu5dpDfDhEyhqkva0X764e5CVBxVQI5lx
 XSaIg0/EOtcwFAhbX2so4vlgOkGFaV6Z10c0slP/+J3ADDRpPDm8=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 15872f03fd..eaab062d3d 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -1629,6 +1629,9 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
 
     new_env = cpu_copy(env);
 
+    /* Init regs that differ from the parent. */
+    target_cpu_clone_regs(new_env, 0);
+
     new_cpu = env_cpu(new_env);
     new_cpu->opaque = ts;
     ts->bprm = parent_ts->bprm;

-- 
2.55.0


