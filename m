Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BBAC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFCm-0000NJ-57; Tue, 08 Jul 2025 16:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDqx-0007Dm-3M
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDqp-00086k-WF
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so3936448f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002355; x=1752607155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uhVIR4sw1LKXp8X4qJMA2ohyVT8eTwoLU5Z/JJ5IQag=;
 b=S+YeUMbAAPPSP2AqYw58ddfHKwHXwSijhiOPns9Cdj/MbOIAWTphJsxCX0GTfpntwX
 MVnOU7uNwHvZ0Eviprz7HmJ959396qgDcjTKYhY/7LXThSISxhHxQFwOJbufjJGjMwUG
 qIA6PTWfeaj9vtht+gW0/xoyF31Xeonbdena4xLXz0muyRmEK9xUFFf37iQ+GyrC2NI9
 fXCTtEJ/yN6xGQw3qwKCj1X0P1MZ7Yva9T0EpaP/eqLxeXPgB6zmuWOEuiAjNBrmMTlR
 BuvYMrreCm0unPsRH9IcRu7tSSxhvuEaxc5yJrEJEBQsx6WpjXYolXLK8LtfHEECewUH
 yFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002355; x=1752607155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uhVIR4sw1LKXp8X4qJMA2ohyVT8eTwoLU5Z/JJ5IQag=;
 b=SG6PRXyGC37eWewbHV1g7zvDTjpD+JjRahpLZxXm3jZW6j/0UKLVQ8e4JKs5FNm57C
 r5/ZN+zaoTMd5Ro5nkJ9aGpamwrWf36FShA3Wu9jyIRdOn8n5cj0MaUUa1ba3mhnTN7s
 o3FEzJksxm29u07RZxLHDfDzt6+X118LEL2NB5WSpngB9UpwYylMzeehs38AiXLRtZkq
 BPZ1Y5EuFLQWbLPSSHq85mOB1ShuSJj3opTtJXPXi0YnSTOJMvi5k57Dz7PwmKzLNzj/
 XfNGbl89NMUniEN7MDYoW0e5sKF4LoOgpE+nu/QR/Ip5vrANhvu/4/WGjZZl9GZIRVpF
 ecQQ==
X-Gm-Message-State: AOJu0YxvlXS3Nh/MaKmGrIPi09+sZ3nXNUc+lM9RxgjDtktZDopvoHGz
 yj4TVcuB8hjv4ulkPO30tZBUWmKfr7PfP6v5uTnQp68w8kFsMiAGNrweXuDyykfCcfHNcnyQhHV
 tzFm8hYg=
X-Gm-Gg: ASbGncuLlocXy7rNgxonno63udpHOvk4v1/TZ0B+vexBjbHeVwSCaTZgaakHcrmycU7
 PGB6DGHeAKIc/TLvvpQN+AujzoY+2Kx3Wsjj5KHgRb7UUw3Pj99BsExTna9/CYvQQJsifJ7FJKt
 xnFAW3pL7WGmsEQDvwBPr1ddHZ2httqkAFCIjGJRypawduw7xrI+PiJYXXBr1ynV4Tk62kejdee
 e1jFmo/MR2UHyNqcDmKMR6EPCseWQvWynaXGZfQWvCCgH0cbRghnjY/Ic2EYEnYR1e5E5mgc9ol
 PWqhrQj+MtxwsBjLE/nLuz77MKhykqkbol5Nas77MkJgEXIH3pv7Ihh59CklBDSeVbv28U6Xiz6
 M7VOJ+6J9LZpYjdK/H15DeXxOVtywsGQlJABa
X-Google-Smtp-Source: AGHT+IHxniCBMjA172cQ3Ofwy0rCeL9kZ6B0Yr9Csb+JqIzztNQO5SBWs1VLd87B1pwbGvGZB8EPgA==
X-Received: by 2002:a05:6000:4205:b0:3a4:f70d:a65e with SMTP id
 ffacd0b85a97d-3b4970315damr10968490f8f.37.1751968668545; 
 Tue, 08 Jul 2025 02:57:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b470caa1a2sm12336301f8f.42.2025.07.08.02.57.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 02:57:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/s390x: Cleanups around s390_cpu_[un]halt()
Date: Tue,  8 Jul 2025 11:57:42 +0200
Message-ID: <20250708095746.12697-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Trivial cleanups around s390_cpu_[un]halt(), split of
a bigger series which consolidates CPUClass::[un]halt()
for re-use between accelerators.

Philippe Mathieu-Daudé (4):
  target/s390x: Remove unused s390_cpu_[un]halt() user stubs
  target/s390x: Expose s390_count_running_cpus() method
  target/s390x: Have s390_cpu_halt() not return anything
  target/s390x: Extract system internal declarations to s390x-internal.h

 target/s390x/s390x-internal.h | 231 +---------------------------------
 target/s390x/s390x-system.h   | 215 +++++++++++++++++++++++++++++++
 target/s390x/cpu-system.c     |   6 +-
 target/s390x/helper.c         |   4 +-
 4 files changed, 222 insertions(+), 234 deletions(-)
 create mode 100644 target/s390x/s390x-system.h

-- 
2.49.0


