Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E41D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyty-0003tm-T0; Mon, 02 Mar 2026 03:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytn-0002aV-De
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytl-0001pc-UK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUBrhgRgMwjvrQ/ixoEIyKXjuGoI34G02FFyFvZ4iws=;
 b=BeZ2xLcBoi85+PBgvdipXQjNDOKTFmq//Wr2XW86qE87QEjrekUjHE8K9IFVc58fq8+jXP
 2FVClgVczqAqRdhxQ3zTy2644+IQ5DegOFlFiQHe2X5jDM99cLCvmC4vBtXBPHMOiinFv6
 bMPTLjT3UevVhdZgfntdGVlhFLX7sdA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-cCvTSoi6N06cp1Lt0hU-1A-1; Mon, 02 Mar 2026 03:45:04 -0500
X-MC-Unique: cCvTSoi6N06cp1Lt0hU-1A-1
X-Mimecast-MFC-AGG-ID: cCvTSoi6N06cp1Lt0hU-1A_1772441103
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439af95a718so1175349f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441102; x=1773045902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUBrhgRgMwjvrQ/ixoEIyKXjuGoI34G02FFyFvZ4iws=;
 b=il60MUDPf7hJ3AzSJl4u9i+dnG9z815Vb5Rk1BnEV/0W6HdB2A/PdCZWu5JTgTKmZD
 IUnzumWi21mF5tt0o1vXGgylxU0lf0u49fExbfVrZPtDu6ZxXgt3bRhp6CGw/4QS/AGP
 zSU3wrmROlw98h5j8++1sjeKK2hggi5A2nqxDutYM9PI7zaha+ko/dogPppd5f2Z/xRs
 AglKIyleTVCm0oYksFiS03zNbX6+ywlmYjGth3fyPI44vDqeCHJ9Jc7c4VNHSBtYZMPx
 81+P9LADG85SHHAAq2kHzWXaMoW0igJLYRK1g8Bg5g0menOp3YTmgWRiw4/r/uf0hI7u
 5FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441102; x=1773045902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUBrhgRgMwjvrQ/ixoEIyKXjuGoI34G02FFyFvZ4iws=;
 b=tfWP8cJlOdgZQ9T/6+l5iuQF6QiDDZN2WwaPMR/TKT5pIJ3+LS54fbwZ05ldiDH8ow
 Rr/KwtBbOjjyKgZB+vRdwAFMDqhs7o7uDHeo7kjoyEChEIrCNrlGtND3ifvK9BGqhz5U
 cyw/swWGw3+4Tgb6QGaXLsdPyh518lsaxCnHsp94MqzKIIo4rUcxZ2vM5scOvClFVRh/
 E/wobNer2znL6SdDHhrK/3LaOMJcTCJ8Mr/CHhQBQxaxNzPTSJPOYuN+eyjC6UGu28dW
 ys3Mfcn/FVTZ4vc0THrC+z5aEYa3GqG458o1ZAVOFt1il9e5lXyEcW11UOlYJA0KjDqd
 Avlg==
X-Gm-Message-State: AOJu0Yw0uNxeK0M5d579V3e0DNktazRuGx85nmc6AO3ZZosuIBAkTDIS
 svcmQyIUUF7VaWal3VsvgTtL3Czc/4rCB5sJvR0KAxyWI/1HvkBqgl88J03xs7FQOT8wrjYqBmo
 pZrVuiP/3khYolbQ8YdokQ8M8fS5fOoQePon6J+BdsS7r5Q+tkUaDVkHcNiqguAupO2Ezr9gaje
 gNAH7DBpnG6J8uWEK2B5DCrRybrmrNDXsION14DE6d
X-Gm-Gg: ATEYQzyeMza3Hbj4ujz/uCq4TpFKjLWsStVNuiEFPB7kKWL/FR7jPD+tOhDV75naUWL
 ynXz8SH0ic1w+UOmd1qKlmqMaTzxYrX+fZouqYEwfb9DPmmgYxNfA6EQ3W5n1YKNo6Q1Cm9xzKr
 WeiKSfwl+FfkIwBsqIkxfH7D1Aw1lonAm/m3rL5DI7vDMEGXCtieD4X1fJ1/ej0rxOyI1oha4gE
 4I8M6aGPxPCM7j4Lx/51w/g4KpHKzaFAp5N3cE0KsEBuhCYyMwk0SE2ro+jkvoUfwu/38s/Whi9
 OPMMgkqbhEV0DyTBLTD6/E6D4OiZ5bpsgXZ20EEjrOS81OGBaZGM5gBeNPkBWaUGE7yMDcrmzTR
 JRs5aO+fRNmkzwBCxmZsiy011nPF4bIgFoBQGrMNGfgiUs1AGCdS5SHwjsgQbJRWZAsoPoJnsUl
 1XThi8B41yotV+Yt+AA74wEneTKxs=
X-Received: by 2002:a05:6000:2505:b0:439:b522:37ee with SMTP id
 ffacd0b85a97d-439b5223a8fmr5730356f8f.27.1772441102409; 
 Mon, 02 Mar 2026 00:45:02 -0800 (PST)
X-Received: by 2002:a05:6000:2505:b0:439:b522:37ee with SMTP id
 ffacd0b85a97d-439b5223a8fmr5730315f8f.27.1772441101972; 
 Mon, 02 Mar 2026 00:45:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm11253716f8f.35.2026.03.02.00.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 031/102] scripts/update-linux-headers: Add Nitro Enclaves header
Date: Mon,  2 Mar 2026 09:42:26 +0100
Message-ID: <20260302084338.473368-32-pbonzini@redhat.com>
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

From: Alexander Graf <graf@amazon.com>

We want to enable QEMU to drive the /dev/nitro_enclaves device node. Add
its UAPI header into our kernel sync so we have all defines we need to
drive it.

Signed-off-by: Alexander Graf <graf@amazon.com>
Link: https://lore.kernel.org/r/20260225220807.33092-2-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index d09d8cf4c6f..386d7a38e7a 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -254,6 +254,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/kvm_para.h" \
          "$hdrdir/include/linux/vhost_types.h" \
          "$hdrdir/include/linux/vmclock-abi.h" \
+         "$hdrdir/include/linux/nitro_enclaves.h" \
          "$hdrdir/include/linux/sysinfo.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
-- 
2.53.0


