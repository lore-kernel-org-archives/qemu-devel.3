Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195B9C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9CU-0002Sw-Dq; Thu, 20 Feb 2025 11:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tl9CT-0002SR-4e
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:14:57 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tl9CR-0007Lf-F1
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:14:56 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38f5fc33602so661699f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068093; x=1740672893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Smdb1C+s1cDlSOZsrFF86ZErHElhYVQWrEWtL0Vg7k=;
 b=G/ngnFDJm8tF7rnO5I0w0iHO3WuYzmFUCU1cj8ngQBnbWaSnZ0q5M3UWA40nmeijNl
 FljwJ0xIks3xwD1XBFUN0XsB4nnmAlB/ZRo1atD/pAuY8J2J2ZMZWLrqM3PSfoWYVeVd
 vxHqnSn34vpHNYs77AgOqRMSli9vmfr1kGrRtVAs0nXMpe01oc1RcpuNwVz+sKtUoQaM
 FrTIYbhYRsP8b7H3YJD+RbYwve6lbVwXxrCEW2qkmKC1asloVd4OchVtacrkRqg10Vgm
 G3eLYi4UgcFqHxSVgkzuaOQlek+MX7yoJxdenbJgFWua2kv8XG/UBcO5ybQdnFCZd9sP
 g5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068093; x=1740672893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Smdb1C+s1cDlSOZsrFF86ZErHElhYVQWrEWtL0Vg7k=;
 b=Y0H/yRqf3B8qkyf2nOJronDk9mhpwUWq9RGwL0riEx5U+Qph7Ut+6lbrJ7SI6rqG9B
 vr2SyrCB+n7my+HcmH2xnUu/IaY/S6g6F3OCG6KI4LZMly6oWD55FEMMMcHtVGiJN0C1
 ps6okfLWMcpzHCRFmfMrJD9uXll0dpaIucNPbUxKwxGfVRu9ZSMmOajXjFhmJrjvR1NB
 FGd+NTARzzDviQtgyYqro8L8041grGRZJo4xqHn5sHJuRVrHwpNHkGxdlL4TjTzX+K0W
 CdBCzGoypSO5BjwTyNORCc96VrnnxjljOE2CDxlyF42PV9x0WeLPruzU0QIlSVDuvfkI
 OcTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV8bXSCvenVvwRdTQ8KjZx3mB85JQvb+6BX+jSx+gafXbYIDekO2N8PyUD2OZ8Hk4XNBlod25EJC4V@nongnu.org
X-Gm-Message-State: AOJu0YyP5z1BWtTnOOAkNISiroCGny8WsUXgPSlMxD1dFSMpnUcbKU+q
 X/i0x9IpyOE+rzDa0DU1DypMcF4PXCKONwtWLT6+QhU811UCrqT+J3suJalvYt4=
X-Gm-Gg: ASbGncsofcCoJMjINkvhsHc8L8wkt6/1v151EpRONDQEcoB1ETGEs+/GxP7gLUs22Wa
 gBPAujFBmj1eZv/A1GqwmR9/m4WBXxe/cOI68KOeRoGvxSybVyI8NaCjU2mKbbEWtPOESvAlMK9
 7pmGTOPfjkXeZygxGGm/ihws5Flrpav7MmuvfTMIjZ4TJ118iUCFNiE9OV+JLho4O2h+rw/etow
 EXrxd2hRj1nElzxPCz+Efv78WNV/DE1Fyl+0Xl8nCBfa9JIn0v6MnAI7WyV4AYyca68EerbOrKe
 oH3+lZuVsF3gg0Kh14PmBejsstrkhl+QcA==
X-Google-Smtp-Source: AGHT+IHhMB1hyD+8SJCCK9pT6NAfUhdwnO4Geme4sMgSP+BQ/IagJLwc+6WG7lYF4Z3nWZO5tAO/Dw==
X-Received: by 2002:a5d:648a:0:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-38f6160772amr4419616f8f.25.1740068093003; 
 Thu, 20 Feb 2025 08:14:53 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fe1efsm21197741f8f.97.2025.02.20.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:14:52 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: philmd@linaro.org, david@redhat.com, peterx@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC 0/2] arm: Add DMA remapping for CCA
Date: Thu, 20 Feb 2025 16:13:19 +0000
Message-ID: <20250220161320.518450-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42b.google.com
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

These two patches will be included in the series that adds support for
Arm CCA guests to QEMU, which isn't ready to be merged [1], but I'm sending
them as RFC first to seek advice about the best way to implement this.

There is a breaking change to CCA guests, where DMA addresses now have
the "shared" top bit set. The VMM needs to strip the address before
accessing memory. See more details on patch 2 of this RFC and on the
Linux change:

https://lore.kernel.org/all/20250219220751.1276854-1-suzuki.poulose@arm.com/

Patch 2 inserts an IOMMUMemoryRegion on the DMA path, so all DMA
accesses get the top bit stripped. It also adds RAM discard listeners
(guest_memfd -> IOMMU notifiers) so that we can create VFIO mappings in
the top half of the guest address space. Patch 1 is a hack to support
GPA->VA translation during the discard_populate notification.

I'm testing VFIO support using Chenyi Qiang's series for shared device
assignment [2]

[1] https://lore.kernel.org/qemu-devel/20241125195626.856992-2-jean-philippe@linaro.org/
[2] https://lore.kernel.org/qemu-devel/20250217081833.21568-1-chenyi.qiang@intel.com/

Jean-Philippe Brucker (2):
  system/memory: Allow creating IOMMU mappings from RAM discard populate
    notifiers
  target/arm/kvm-rme: Add DMA remapping for the shared memory region

 include/exec/memory.h |   5 +
 target/arm/kvm_arm.h  |  15 +++
 hw/arm/virt.c         |   2 +
 system/memory.c       |   3 +-
 target/arm/kvm-rme.c  | 220 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 244 insertions(+), 1 deletion(-)

-- 
2.48.1


