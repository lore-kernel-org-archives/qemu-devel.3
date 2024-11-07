Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C4CD4337D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95Qh-0007y7-Hn; Thu, 07 Nov 2024 11:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t95Qf-0007xh-UW
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:32:17 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t95Qc-00048w-Ql
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:32:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43169902057so9600695e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730997132; x=1731601932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rp6zAHtQed9OBgEIp52Kx6XmEGRiYdPl+QG1frjBi1s=;
 b=Dc4TkLT+CBI3HBeZvR4BMSf+1r3DP+Ko7wPkPqWdOR4aoIO6e9lSub/h3cu4ma75XG
 ZWKmcdczye9P4AxkErEerui9q5e13+XtX4BaKu4j1UO+mZ43oQL0bql9cQI2drcXmb38
 lX5tUNbp0jDd9LlLvJ8nHwU4JYtSWfxfOc9BFm87IqixHfTuE6hcSRrVPo1S3qqDIovj
 8g4XI0vRuI7aV436xLXKggWSAjsZmoSVIldvZ9dmUEiAqDKKkeD+cZRlo2duu8r0XAnL
 cWV7Hu7QLY5aopHIiRTN3wfAGXYNGgCEIwQeZw44liSHiHsxk8hxTM1bD6EqJKvRMuiS
 20aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730997132; x=1731601932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rp6zAHtQed9OBgEIp52Kx6XmEGRiYdPl+QG1frjBi1s=;
 b=LIQCXUqVoyR2xwYsePmv9vq6LfgaOYYUOjq4D7qmmh4LlNYPSQzwPchz6X3rKj0x2O
 JM8xGrToN7ZBHzBt7DqAiznE3Xa/sQU8nEu6OTS48vtiDZk/OQ79S/DYA+pYWG/dYZf0
 i7NMmTo7tztZSOOWT8Vxy0a6+5L/vMI/wQxGJwlDZJXz9mms0e+uZdQ1YXMb4uCTcy/4
 nPB2+IwrqrcPpq2Mh5InKcDZ7M6i5DYzlvSWw6F73rnjdUiwF5ZJVY/fp/iXxiCHh5MK
 PO/rPN6txKdkbp/hUMur3WPE9HltCsjDqIwYbb9ZTV556fcM3mcmwqoratgn6dke5+Dd
 Ynqg==
X-Gm-Message-State: AOJu0YxolhCwW4OhjpC+7RxlU7QxuSNXnyAVpR0HnEa7G/i+iaRa7xC4
 BuuAJ6KMTt88MzIfFKCu/o12vwsuZm43kzzC8pa+QCcS4OdHekTAHqCgxbPGTdoUaOdYec+7OW3
 9
X-Google-Smtp-Source: AGHT+IGOFJvk+jK0vt8iDV3VVOup4/5iqIZizTqQjod1IxGpafvxny3a08Uctj/Z6RNFwaAZzjqdQw==
X-Received: by 2002:a05:600c:a00b:b0:431:5a93:4e3c with SMTP id
 5b1f17b1804b1-432b5f9cb14mr5672875e9.16.1730997132060; 
 Thu, 07 Nov 2024 08:32:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea587sm2185161f8f.78.2024.11.07.08.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 08:32:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] net: Make ip_header struct QEMU_PACKED
Date: Thu,  7 Nov 2024 16:32:08 +0000
Message-Id: <20241107163210.3620697-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset aims to fix some clang undefined-behavior
sanitizer warnings that you see if you run the arm
functional-tests:

         Stopping network: ../../net/checksum.c:106:9: runtime error: member access within misaligned address 0x556aad9b502e for type 'struct ip_header', which requires 4 byte alignment
        0x556aad9b502e: note: pointer points here
         34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                     ^
        SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:106:9 in
        ../../net/checksum.c:106:9: runtime error: load of misaligned address 0x556aad9b502e for type 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
        0x556aad9b502e: note: pointer points here
         34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                     ^

These result from the net_checksum_calculate() function
creating a 'struct ip_header *' from an unaligned address.
We try to handle the non-alignment by using functions like
lduw_be_p(), but this is insufficient because even accessing
a byte member within an unaligned struct is UB.

This patchset fixes this by marking 'struct ip_header'
as QEMU_PACKED, which tells the compiler that it might
be at an unaligned address.

For that to work, we need to first fix the places in virtio-net.c
which take the address of a field within an ip_header:
the compiler will warn/error if we try to do that for a
field in a struct which is marked QEMU_PACKED.

Probably other structs in eth.h should be marked packed
too, but I am here only addressing the case that produces
warnings that I have seen.

thanks
-- PMM

Peter Maydell (2):
  hw/net/virtio-net.c: Don't assume IP length field is aligned
  net: mark struct ip_header as QEMU_PACKED

 include/hw/virtio/virtio-net.h |  2 +-
 include/net/eth.h              |  2 +-
 hw/net/virtio-net.c            | 23 +++++++++++++++++++----
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.34.1


