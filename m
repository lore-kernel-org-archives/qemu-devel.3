Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC446C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racbU-0005VB-4u; Thu, 15 Feb 2024 09:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racbR-0005Ul-U9
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:20:41 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racbQ-0000Ac-AO
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:20:41 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4121954d4c0so3553995e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708006838; x=1708611638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pntBR0iPUBvaqhNDr3z74lUrr+ChN2lWu7THzxvYpq4=;
 b=R1sonxoYorZvEefNcsd3Wg8c7WDAEsjUJnbWe+Lcvf4y0CoiVOaDf3GkK0et2Mg9CZ
 PJIo0o0/rKzpPzVig40PVPfHk/ILea0XQwRC7c/GMx8rlxV+aT7C+1uj7P9F2QpgnIz2
 LAQ0YOPb14PK40KsrjToyv3O0d19OSpHpA+dwT4bV8D5xnnHIV367FtaCYBPzbSX2lCc
 bw96Yjatwe5VOpYCRk27ki4cZYQ8U0GbbavfuIbjYOt+UT1iZOQpxI/XYWtSQZRUJrzP
 AJz/QbdEzyQVW7+MREp8/fJrltU8h05xFfdJYrXfP9QR/1XO47WyObdea2WHDBkpsyQZ
 d4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006838; x=1708611638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pntBR0iPUBvaqhNDr3z74lUrr+ChN2lWu7THzxvYpq4=;
 b=cy2LtgJFzdkLhN5Z7TJgStA9TMrWImXdo4GYtiAz/YhTUrJh1/fYVWP368l4rK7Drl
 fBTQ/PdGwNdUU6KHuQJVMKUj8ui0vKaxvFStio2bYsbJspoprS9ML36jtOfQjI0JIZHO
 mQwAc2Z0lr5wrxpiIsqpTLqLSrn/0Hp2T6NAHD8mar415qkwLaVmH1VwYaTr6udHLwb5
 bd5diVdQpIIieRR0GPuuH8QDOgtUK5oCTVa7n2WTKhzBl3jYme4LxYKsUu62CI+Cyunc
 zATXpFr0+5FM9oTlntisk1u0cJrlYi0jWQBXe7Ggc1Cj77LBxNCgAnTZJpRBNHyKoqgB
 FZxw==
X-Gm-Message-State: AOJu0YzAatdtQdOSsbbGZaXVDfEO1aXNO1e1lslu9BnsRq5uXbFVpzjt
 rYOuSCnS+qLwzhrfh/Okq6hgfSHFG5ZdE01AgPK9l8JASxY0yt5Mvbir5OUWd0cN3uyv/oRaTZG
 pc5w=
X-Google-Smtp-Source: AGHT+IGltK8SlqR92mQrainaw1OJot7KW5TFHa2cucezR6qPEu7mNw341XisjYF9nFUPH+3qRI7IUA==
X-Received: by 2002:a05:600c:1c01:b0:412:265:ee81 with SMTP id
 j1-20020a05600c1c0100b004120265ee81mr3043560wms.12.1708006838083; 
 Thu, 15 Feb 2024 06:20:38 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a05600c290700b00410add3af79sm5130718wmd.23.2024.02.15.06.20.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 06:20:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] hw/i386: Move SGX under KVM and use QDev API
Date: Thu, 15 Feb 2024 15:20:32 +0100
Message-ID: <20240215142035.73331-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

- Update MAINTAINERS
- Move SGX files with KVM ones
- Use QDev API

Supersedes: <20240213071613.72566-1-philmd@linaro.org>

Philippe Mathieu-Daudé (3):
  MAINTAINERS: Cover hw/i386/kvm/ in 'X86 KVM CPUs' section
  hw/i386: Move SGX files within the kvm/ directory
  hw/i386/sgx: Use QDev API

 MAINTAINERS                  |  1 +
 hw/i386/{ => kvm}/sgx-epc.c  |  0
 hw/i386/{ => kvm}/sgx-stub.c |  0
 hw/i386/{ => kvm}/sgx.c      | 14 ++++++--------
 hw/i386/kvm/meson.build      |  3 +++
 hw/i386/meson.build          |  2 --
 6 files changed, 10 insertions(+), 10 deletions(-)
 rename hw/i386/{ => kvm}/sgx-epc.c (100%)
 rename hw/i386/{ => kvm}/sgx-stub.c (100%)
 rename hw/i386/{ => kvm}/sgx.c (95%)

-- 
2.41.0


