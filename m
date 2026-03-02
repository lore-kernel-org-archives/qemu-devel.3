Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C737C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyxz-0003j3-Sf; Mon, 02 Mar 2026 03:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxa-0003UL-Sd
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxZ-0002HX-BI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uiZ/r05wUaynHRBd4aMN6I4BhMIXirJc8H8pOXDGUGw=;
 b=MaWPq/tz+vCY2GjZKFPZQGe2cTThbhS3GvUbvUZyWnYjRNIQD6oma7F20ejpvMMrtWh273
 mWgFWqNx2jkyxAoW6qbV12U+91ODxj+g25hiYR4zW+vL3nrTKm3aN+ZFVawXCzBMj4Ar5o
 yfhTLCRdewY9zTX058RYwW9FPu3RSsc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-wEI132HuN3urry4jztFi3w-1; Mon, 02 Mar 2026 03:48:59 -0500
X-MC-Unique: wEI132HuN3urry4jztFi3w-1
X-Mimecast-MFC-AGG-ID: wEI132HuN3urry4jztFi3w_1772441338
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439bcec86dfso101221f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441338; x=1773046138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uiZ/r05wUaynHRBd4aMN6I4BhMIXirJc8H8pOXDGUGw=;
 b=uAOX4mNjj51DUfwGuNNqNOLii8AUa7TyndqgQc0oYhbdASjpR7iep3qWhrdAzbQyhX
 7xkEM2rm07n0X+8Y16MtUYptGl3ojHbdh9sYwxGROIM0TkLuGjGo58WaHrFM+ZVtXFTX
 +mlSvf3B02UpX8oPeTuBOxwdLIUfloniBUm/sXSyjheOFhlVBzqaZY5pNJk3y19eZjHc
 hDz77+bfFvHNSFdmwDbBY9T98I5xI97MquHyM+ybMtk+UN5e3fVEZKkm39f0JfgCg+hZ
 dLDpd2hg+S3yOabsxYLVcIJ9t6L3RyrBO04VqohRzrrpeDJ4Q6fNw9zgWr9mPPmxYEwQ
 m+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441338; x=1773046138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uiZ/r05wUaynHRBd4aMN6I4BhMIXirJc8H8pOXDGUGw=;
 b=H/+esJa0isdDNddsZR2XaDA7TnmuBflb16Y6QzfjWSCVRP5WmyZWZtL+onhHRWxv5t
 Me1eK+tqsvtHcaxnWMZg0RvY6Me+CqO0isGICHRApul/Zvjhz9r/zbvudBjkmvokr6s8
 D0BjH6CrMxfeDrJEM4PmBq4SEZcVzfwt9O6ZL2M85F2uIJyb8Fpp8Wn5XlGZVTu0teeD
 xu3NU1S/QMO7ObQdzmm0tv4FEHVijSyyxnFyHzWLEYiCjVL1S+DzAn8gU9kiwewSPFMx
 VP4sPaLTrj2sZ+0GIHt/r7Fj35AsrnjXiYGDzsRwEQKYKuHTCcFKdH3bRjnsLQzAbn7C
 XnrA==
X-Gm-Message-State: AOJu0YzOtCOjwYx0G0fuNTsBTqtQDoTsRN6cZUtVyJ+ZOo6A4iM/YyUP
 HgsvMj4SJOZCZgtLehB2XhJFbUZ1Nmy6tAwLSBPcQsyUi7bOkmPEklG6y8/mVTRRsUFqSZArqmg
 el7J+FMHmsRr7My7AUx0cf4mrCa2UZwuIFPEW5gm1pvnjA+LCDB3iMgxl7EFP4G90tP2KZMFp+x
 UEdCc7v+MIdnyruRXmGQZNBVrR1mgKY4bRRM8kH4VA
X-Gm-Gg: ATEYQzzbScs5kKQqKspjp8z8juF1V0HnsijWy8c0TJv2xdgx957eKAXlc4FcLdjGQQT
 Fzh5NKh8mfsU961Gf+cHysQDokJ7zoaLbRvLJSrgbia6YJAmwbYyDl99kUorlNoaFMfvlrhWaRz
 7FttorjvCqv/C/G7F+XDfnXbFc9AfZ+PnNKExNk+NiXXoRgDpMq8ADz91XWwwxCBJ9zl/5PH+lH
 v3vuifttw8Hy1tqvPCC1JUxkofiseiyIY3JVsTv2qfbaM5NOtBF+q3D8Y8uy98nO66Y4RZpxaRT
 lr3JBLdwY6XItBUpZHEtLQGcoWPQn9GovxRjNdtoPoDgyMRyy+J8obrnJG1Sol9mF8lw82Ir5f0
 5q6j2x99LHWhJkL1t3Gl/W96BE/q3ankIDCl+M4jM6WAVhkqIRnsrcMbe9W78D6f19K5288yKjw
 xcvsk3/KxjdMszKi1GCZoODbAZA/0=
X-Received: by 2002:a05:6000:1ac8:b0:439:b046:2044 with SMTP id
 ffacd0b85a97d-439b04620c1mr8270191f8f.12.1772441337560; 
 Mon, 02 Mar 2026 00:48:57 -0800 (PST)
X-Received: by 2002:a05:6000:1ac8:b0:439:b046:2044 with SMTP id
 ffacd0b85a97d-439b04620c1mr8270136f8f.12.1772441337024; 
 Mon, 02 Mar 2026 00:48:57 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ba2a5970sm3373495f8f.33.2026.03.02.00.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PULL 093/102] target/i386: introduce SierraForest-v5 to expose ITS_NO
Date: Mon,  2 Mar 2026 09:47:39 +0100
Message-ID: <20260302084749.474955-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Expose ITS_NO by default, as users using Sierra Forest and higher
CPU models would not be able to live migrate to lower CPU hosts due to
missing features. In that case, they would not be vulnerable to ITS.

its-no was originally added on [1], but needs to be exposed on the
individual CPU models for the guests to see by default.

Note: For SRF, version 2 already exposed BHI_CTRL, which would already
mark the CPU as invulnerable to ITS (at least in Linux); however,
expose ITS_NO for completeness.

[1] 74978391b2da ("target/i386: Make ITS_NO available to guests")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20251106174626.49930-5-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 987f64c5af3..2a869f5b739 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5809,6 +5809,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 5,
+                .note = "with ITS_NO",
+                .cache_info = &xeon_srf_cache_info,
+                .props = (PropValue[]) {
+                    { "its-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.53.0


