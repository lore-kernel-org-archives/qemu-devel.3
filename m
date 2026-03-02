Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD816D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyyw-0004RZ-3q; Mon, 02 Mar 2026 03:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxc-0003Uw-3Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxa-0002He-9M
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfwgliMDX1wluwfnPRNeDZFvWD6kZBRIIMqtQM7FJWg=;
 b=icm0grbQhCDE27Vf9zxG604Y5jX9fSma3v5me4UMyGRyjzDliHMix6+Mnw5I/c444OJEKf
 1cjmSNhg+ntfOj6hrQ05hVpt31M8Plf+fEW/QCVx2XVmqO1DTkiXOnO46Bfxhu3W8Oewhe
 wEWSwMuS+o1l4scy8r21+mbWEvUNj34=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-87pcQ4UFNAOIb95BpnMLNg-1; Mon, 02 Mar 2026 03:48:54 -0500
X-MC-Unique: 87pcQ4UFNAOIb95BpnMLNg-1
X-Mimecast-MFC-AGG-ID: 87pcQ4UFNAOIb95BpnMLNg_1772441334
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so1168639f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441333; x=1773046133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfwgliMDX1wluwfnPRNeDZFvWD6kZBRIIMqtQM7FJWg=;
 b=rmTyWnqxk0h7tt/4VgElX/Cn7y9lXHLmnrcOyjOiyIjuteLJbkUpvczKeWmemSodhY
 LVtnuJMDxP80mlIFDYdT5v0Le9xLMUtAtosEhbNh4PQrY1lT4Ba0vuW2lvByHMLdvdY5
 X7pJpJ0whVILisE7X2Y64F97U4/3Y5EipTUVy6mPFHtTFNu4LkUuaatnl3UN8XfNRIIF
 YiQjcslkYJkHGfXP+Kvhu7GOFo2gvSeO7W4q8fKcxoiD7ekuI6sE6QhIYMQ8uNltxc11
 kaIRU8umCZE0/bAKXdyiMMkPvw8bjK+9SiX85gEMYyzy6nXiwua1xl7FsUqCBgf6r4HJ
 79+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441333; x=1773046133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qfwgliMDX1wluwfnPRNeDZFvWD6kZBRIIMqtQM7FJWg=;
 b=qOPjjAwH80wZggDVeutylqenPqzAMyRcOOVPXbaEQdyq2NTe0kA+1+SBo8SfSx3ekG
 QA/LGKd5CCVfN1c92RdT8Fs8nFM0EHf7wh6WykZ+mFaRntHXd2slbRWR2mub1+sthTnB
 p/VLxKTJUtbkdGwkjei87C7dVvIR1Ito9ow5OrNLrPrV/LqXYrfY5F6PTECYNixA/eQw
 WDX6PY6H8OiWATus870B89nGXcM7Fqa8l/pw1IfUTFlW1AqjmSZfzWUOQRjBWLLghiGe
 JtJ6Qy/cKuLYQnmKNaSjoO6asehezlszWGcsak3VHPffFKYxNrCSnn5ANSIvNaTDVhn0
 0eTQ==
X-Gm-Message-State: AOJu0YwxRPvZ/Vn7JizR7Jgd/QYabfYR5zU4UQqKFfjlM3FRrCpPzMHW
 +Ufjk9Z80XS+PZyw/Q4DZOo/l6um+FdUqNoG2jkJhQSIgRnIiZxMym+u3RC7hmEXkiCNivgD2rv
 fMgQ8Ufog6Gv2BjQ1JUdYgEmWfy8/VrPbBralNSFxz5NNSNUqB8hXeCjRyzR/PXmXDUJ4hjmi9j
 8diZ8iq2q9OmnIlgXtZD7q//HTSpypeoqZcjGSEQqX
X-Gm-Gg: ATEYQzxFdCZd5MF4L3yXkTQ4EvR5Nd7hUds4bpKeNGpCO9MQeeUdqypOYC2f9rjGsdZ
 wYgREnw/rloQIXI9u+213n85OizQ7q6ashCRXwWKaQukGKHiNnT3ak+KzFrYG5JMcftDi833L6J
 jWz3qCMKtRYVsW+1LbmK1gLPzKSDBH8Lhab0zZSgfen1m3lwEyVViTey7Z39tRbNWEkzmzXEy4z
 Gf6CXlxivntNPHUq2Y2og//qKQmwUXZo6KZSqpwd/VymdF8gZo13iQGbo5QpPug37YFDWQ1MiGd
 x3mOz+dfDoCtjyNGPcIb7rOXI2DDaHUj/w3XV33qH3f507QkDsUF14So5aNGv9j+cV7d5sRwx56
 yuIx6d1qxLGPW25EMtfB1PT9O4CZabodD2UNf3YcIZwfhI3cNcwbqESfoMZQnANO+GoYwZDiaP1
 EOLKzO17fml2HR/yBFUNcpnx7rae8=
X-Received: by 2002:a05:6000:2f86:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4399de2c5a6mr19175220f8f.46.1772441333147; 
 Mon, 02 Mar 2026 00:48:53 -0800 (PST)
X-Received: by 2002:a05:6000:2f86:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4399de2c5a6mr19175172f8f.46.1772441332625; 
 Mon, 02 Mar 2026 00:48:52 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55d15besm8996326f8f.30.2026.03.02.00.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PULL 091/102] target/i386: introduce SapphireRapids-v6 to expose
 ITS_NO
Date: Mon,  2 Mar 2026 09:47:37 +0100
Message-ID: <20260302084749.474955-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jon Kohler <jon@nutanix.com>

Expose ITS_NO by default, as users using Sapphire Rapids and higher
CPU models would not be able to live migrate to lower CPU hosts due to
missing features. In that case, they would not be vulnerable to ITS.

its-no was originally added on [1], but needs to be exposed on the
individual CPU models for the guests to see by default.

[1] 74978391b2da ("target/i386: Make ITS_NO available to guests")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20251106174626.49930-3-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 619ed0de322..81779483d31 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5261,6 +5261,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 6,
+                .note = "with cet-ss, cet-ibt, its-no",
+                .cache_info = &xeon_spr_cache_info,
+                .props = (PropValue[]) {
+                    { "its-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
-- 
2.53.0


