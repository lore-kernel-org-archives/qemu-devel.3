Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEDF105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drS-00043f-I7; Thu, 12 Mar 2026 07:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr5-0003qc-8D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr2-0000hT-3g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEp08oGIR2daG/objY3abzGvX7bGmYqXlGIxHtNO/54=;
 b=TZ3a69i7DdzqGsucx4tPE955duPdQzNk+k54sF6LiFEs3OPg1E/I3UG7Yds74TSgZsJ/Ku
 KC3/iDK1lrHpHTsMBNOCntdTRgpAqUAacfKJrvtGQMgmNWvBRVpQmSVkGX3FUYWGtf/PIc
 OQH+DVtHqrwZHdW3YvB8sVKNRZkUiW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-heiSS6g_N267n5Y1J9cQvQ-1; Thu, 12 Mar 2026 07:05:22 -0400
X-MC-Unique: heiSS6g_N267n5Y1J9cQvQ-1
X-Mimecast-MFC-AGG-ID: heiSS6g_N267n5Y1J9cQvQ_1773313521
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439c12269f3so563823f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313520; x=1773918320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEp08oGIR2daG/objY3abzGvX7bGmYqXlGIxHtNO/54=;
 b=ll4/mkqJRs8SOaDjHz3vBS4/xlGZgcsDu1PdzTIAOyP2qywz/saRahSuW3Wtg4NRMB
 7IzMKZsQnN9MddAUjfahTJMGc43m8h1U3yVUtBj7kOkc6rUn41YXCNTd25JhxYaJgA2o
 zaPZXEvn6GyVYhRaOXZMi/G6N77OmBBmKb57DWxEMWSGmC9yss7LKAIJfYH56AKTdLJq
 4T5nJzMJAjP0qwqaLIurZQLFLwfyNv1rB/IDiYOwxmgpo4ftvU8Ms2GWyph6l7xBbxdg
 Ib/il3XdW/xhkez0/WIkVSOz5K+4zJJeWANNjZdp2tHwDD1AvBYObuoM92r+cL6f2UpU
 jmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313520; x=1773918320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xEp08oGIR2daG/objY3abzGvX7bGmYqXlGIxHtNO/54=;
 b=HJfXq7xaAbtWvQ7xRwQ8kbx80hs6vzj2RmJYUt0p6nLEPmjwlWyqIrWqe4bfzwybPn
 ioiesoQ1lQv+n5uksicSCdii1UigO2PW1gRrrzod1GIpsSBR1qQXwxN80xDJGkVoyMB7
 6pqjijF+rdQXJbmwzjgBn8rA4JenM9/C+Ovq9Bv1bpNa8diuT+k1BhETqz/jGmIFFjNS
 3yd5jg17CJzDA3R0rgTlngbB5ilwv0nuSseUud3BJKSFm7b1mF6TFRBJRC31myeiGYvR
 kLuTxIK4KDHciDzed4hTTzCHW8DkHOugRx60J1Grr7QcplKi1uV2jhKtJcRioMUq+sQf
 Bq4w==
X-Gm-Message-State: AOJu0YxakOEks+YaXqvKdFttSGBgBbNGYrTrMNHbytOLpkNvtv0hvGFv
 mQfOP5GVaNyjhyUjP3/VXQfRC6K0bAsLoU0MV7KqKMU/NZqagVfBSfOwHPc2UBsxBDX6NaaPVqH
 yWEXY+xR8ypKHau5HwkwfgMpkq+nWnmiTAhRiV3HaQbmAW4cY5ALqLrLBq/1+GrvqyZlqB0LXbh
 gV5KeA3pESxe/piLq0nEbAbwtfa2fRR39XU4mXVvak
X-Gm-Gg: ATEYQzyHKzeqE9uWQKC7tArskuBLEbuj7aOpxeb42+9J/4MswG3DLGvCCAUrHTbjRXa
 HUX4591u+LU2MiOzHt98AZ5lt0xOyjNOaUyrxjKlA8PJE92trEP/D61viDMAHDOdDG5zxBEQxZb
 nCI13nrjUmUgZSxe3MXOrIwpOFlqwIxoanDq9Zoze2G+/NGtG2f5e5bKKHnYsvKJK8t2X3zD7VY
 vK5Ufk44GNlRJxvRyqMBdO04yEch7WHXNlusER4fxHogvtViMXAjUFfopjLIVcqq6lRZx7HmFda
 /T4xrpHNs8DqnHGTSWhAmTO26gpg7EHH0cOPK7PSTbBaRR0HghBAmOncyASh4UQinylmCUotzpX
 0ForHvl7QhKJ7tF7IW/gBu7cN4+49PlADPGWD/hV0OoXJ10AG+X+wNOrfi9Pc/GegPRHMLRdo7P
 UHhvAlkL6DVav7S6jPD4RhLRXQDNs=
X-Received: by 2002:a05:6000:3113:b0:436:1b1:6cbd with SMTP id
 ffacd0b85a97d-439f81bd9dfmr10851866f8f.6.1773313519907; 
 Thu, 12 Mar 2026 04:05:19 -0700 (PDT)
X-Received: by 2002:a05:6000:3113:b0:436:1b1:6cbd with SMTP id
 ffacd0b85a97d-439f81bd9dfmr10851797f8f.6.1773313519341; 
 Thu, 12 Mar 2026 04:05:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19b936sm8787225f8f.5.2026.03.12.04.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 10/14] qemu-options.hx: document Hyper-V enlightenments
 accelerator option
Date: Thu, 12 Mar 2026 12:04:42 +0100
Message-ID: <20260312110451.685161-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

This option is WHPX-specific and controls whether Hyper-V enlightenments are enabled.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260311102626.46546-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 890c4f1d230..69e5a874c1a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -325,6 +325,11 @@ SRST
         option can be used to pass the KVM device to use via a file descriptor
         by setting the value to ``/dev/fdset/NN``.
 
+    ``hyperv=on|off|auto``
+        For the WHPX backend, determines whether to enable Hyper-V enlightenments.
+        On x86_64, Hyper-V enlightenments are on by default. On AArch64, they're off
+        by default.
+
 ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-- 
2.53.0


