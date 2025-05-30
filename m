Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46B3C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrRf-0001hy-Qn; Fri, 30 May 2025 00:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrRK-0001MM-8S
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrQt-0005Ef-Q5
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2349282084bso20788525ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579606; x=1749184406;
 darn=nongnu.org; 
 h=to:content-transfer-encoding:mime-version:message-id:date:subject
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uy+jpdZkiM+wA4w5PLJ603fVcPXKreCwswysQTAstdI=;
 b=abvPJrmu7k2VmOXlUwj9XbdH07o6yU/s/b3HuFMZRf4Xj8k/LK+niB8OaBO/sq4oEt
 bJN3RVYm/uqDs6pfd+67u04APB6I6DyvPc4AM6BbOthcJosyWruSozUlObv9cveUoww2
 HxeUdu1E6xWjNhSXSW7Jl6sn18cICC9n+cOfamPZlWBFbyMiIiNjzTFALUW3l2I1NJTd
 WeLI9x0Y+mFH+EFYRwA3xASUjFJHzXk34nLC2k/PC0pinmeSpnwvJ0knMJzkGUb9e7SI
 NEUiotuvrgNB8cVSjwBfUg/t0/UYQE2eD/cvrRPp4HDLxj6Ffca54f9ed2c6oi7hBjJp
 Ms0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579606; x=1749184406;
 h=to:content-transfer-encoding:mime-version:message-id:date:subject
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uy+jpdZkiM+wA4w5PLJ603fVcPXKreCwswysQTAstdI=;
 b=eSYIKDYFhA3gpr4MhX6+NVhnwJC0VWcre+aqdivYYAaOZfo9xgNP3X4WjEURgpypcX
 lHKa//D8nifKL+IEni67SKw4r1hhJaMEw7AT9KCBmIBIE/P/k8Qbfbd8dTDe+vxy7vWX
 t77dwRB8j8z/FNjq3OQyft1kykQx9So762nNIwABYML+npOhT6cXkxH+L7RY36KEkLqV
 U/4ich38gagpboXQ9HSC3MpK6bty6M+FQDmB5X5Vzn4ttJNyal22M1f5cMGMXCG3tTp+
 xignxPq+Ki79jo1Y9vKo/RA6RpmaKPJAGauzuzPSBoTpGcyE1RBPZPSjMGjfSICK0rel
 yo+Q==
X-Gm-Message-State: AOJu0YxjD33vu98v04LjQGzsdkDFWQGGACCg72FH9G83CAepeW6Mix/4
 h9k/qHCtBw2SnbvSRnHGUmnPCkgsyNCkir4X3fAmfyajCQ7SbXKtZb+UCpI1W1Gbh/IE4DtVn6J
 kOdAX
X-Gm-Gg: ASbGnct5fBrbYkFoZYdnIgh57QVdK1eW8/KsZzW4smQf5NLE0+3qy2oTT5+E80gnshZ
 bayGtTgkyXT2qtDDLWaWioFoU57qlHVjQyaSBoCuCGN2UW8/RQ6o3qCF8FhTA6B6MdV9bVpz0FB
 D+F1BQEiTdgAgbvAvrVUQCymb/kMqFuTflLnITyeajG1NRBBJ0PcutOGB5ivNwJI8ysREBmwQMa
 n8iJ73V7f4aVGt5udUGebElAotF5kN4ZFg53BOK88hO61NEyTE0guIyX4VytXUSpnJTwwOAzieA
 tO4YO//wut0npM1Wp3BAwsqROkplj0wXvVX1a4lnHzXWlmv28AEpykK5+QHa8ZaXg7D4jT7c1A=
 =
X-Google-Smtp-Source: AGHT+IG8pPIGKd0RmKY6MG125etllVWlMK6d8t8A+DXzvTHB9NptLrwzWm0ShhwZTFk31vPSHyit0A==
X-Received: by 2002:a17:903:234b:b0:234:a139:1208 with SMTP id
 d9443c01a7336-23528ef783fmr31174625ad.16.1748579605870; 
 Thu, 29 May 2025 21:33:25 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506bf330dsm19944735ad.105.2025.05.29.21.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:33:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/6] net/vhost-vdpa: Report hashing capability
Date: Fri, 30 May 2025 13:33:15 +0900
Message-Id: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAs1OWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU2MD3bKUgkRdo2QTC8NkM5PkVBNTJaDSgqLUtMwKsDHRsbW1ABB+fSR
 WAAAA
X-Change-ID: 20250530-vdpa-2c481c64ce45
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch series was extracted from:
https://lore.kernel.org/qemu-devel/20250313-hash-v4-0-c75c494b495e@daynix.com/
("[PATCH RFC v4 00/11] virtio-net: Offload hashing without eBPF")

According to the specification, virtio-net devices with VIRTIO_NET_F_RSS
or VIRTIO_NET_F_HASH_REPORT can report supported hash types:
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-2230004

vDPA also implements the same functionality, but QEMU currently does not
respect it. Ensure that the vDPA device satisfies the requirements of
the VM by checking the supported hash types. This also helps add another
hashing mechanism proposed by the patch series mentioned earlier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (6):
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      net/vhost-vdpa: Report hashing capability
      virtio-net: Move virtio_net_get_features() down
      virtio-net: Retrieve peer hashing capability
      net/vhost-vdpa: Remove dummy SetSteeringEBPF
      virtio-net: Add hash type options

 include/hw/qdev-properties.h   |  18 +++
 include/hw/virtio/virtio-net.h |   6 +-
 include/net/net.h              |   3 +
 hw/core/qdev-properties.c      |  67 ++++++++++-
 hw/net/virtio-net.c            | 254 +++++++++++++++++++++++++++--------------
 net/net.c                      |   9 ++
 net/vhost-vdpa.c               |  34 ++++--
 7 files changed, 298 insertions(+), 93 deletions(-)
---
base-commit: 5f90d272553ca0d18ac2457a993febdba9e840e3
change-id: 20250530-vdpa-2c481c64ce45

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


