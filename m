Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A95CDE007
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9G-0001ei-Qi; Thu, 25 Jun 2026 04:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9C-0001dv-Ik
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9A-0007sk-LD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-46db3c9a9e0so236997f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374952; x=1782979752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5n/x6pSF3+LAIywcpETq9HEYE6/Y7u5wEQRc8KXmVmc=;
 b=H/dI7FEuQPprjkku+vIJiDqCQMHV8wWbxnZT6LMPAOSKZyqlTACBs+quPUxtS1z0vj
 gXPyOuwf8SMXbCj69uCGbGYnkQYFmnJ5QyAzseyRFLBgYgx0SECK8epKkYst+UsNoBWB
 RtzfH2Qi/5y70NMvQoKCPCSfVGXM5sBEU5Iwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374952; x=1782979752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5n/x6pSF3+LAIywcpETq9HEYE6/Y7u5wEQRc8KXmVmc=;
 b=ASga0sjv8KNsmhRWptHp+zfGyEPGbDLmzzQZhcgZ9Ire95eG/3ePlrBSQkxdja7p2e
 Y6eM6vzvvpFRR/9bNSBSI1pj0oiYTloK2cbIVUBEbDh/2+bch0SDO2+GTHBC72XXgQQ/
 ZVjlfSXSQq0faTVqlnDaCbnR9eUiqTtl6eDDpsEsfAHKh0XoW+dzHfBwfL6w4fphn3xy
 rt8Rxu/QRjKfbQLCzfl3zbQeAIepA+K5I9K7bpYENkxgwNEC42/g+S2fjSXJd61cLsSJ
 nYprrRur/cn6csfnNIS8jsLW/t3kCFKV4F3ko7ZQLiJDQqsM/kckLNVizzndJOiaQMy3
 QluQ==
X-Gm-Message-State: AOJu0YwBYUW8IJylb86nH4Lk4u4V2lee/KTF0dRNvIwi9wYfJK2y6Exw
 Xn9+q2ki2Xi6fEzNPNTXahlwgFJ6QUd5e7gEUnZGotZocRiOsesX/gR40YvQzDUwZSTte98Gytq
 edimaDirBpg==
X-Gm-Gg: AfdE7cmxSGWfDBcKOJlzrcki7d7M77TfMsl1sRQhbPAzDT3fOKmUySvIsZ2FyZYZbrr
 e7eqn6yyYzuOQ++8e7DVym2+FPAacBnEBJB7MRmahTHWL2Xw29h4g3vjk+eboX/CRY7BD8su6eF
 Q1s+fHf81Sk5F2+L1cUgQSdJDdFzbHNAblNv0LggEroKaUUO47TOh/d+i5M05aHFeYHFLe/CKlk
 9xml4ab3BZ+z3hukIFFnOOC1gRCgpaXBY5w0SOApYVgXB+zqohuPzZFLHLMDI4mcMj7p2TWilnK
 uAicepoFwNguGHBVFYs6alHcJIicQynWdjgUWNtiUWbnKhbaCnPInffZ8NJH7sLveiq539ppAc6
 C//c1ryLJyD7VadwFIYfdR0ANjiO2qlXg0p0+RgTjJI0jqZJ3m96/WYMzoBGGZORk9wBDkIRTg5
 dw1VlAkg7poLe5OMFsRfjyPili8uVFen68VnKpMWEDZJTVwI7YfbbpfqWUjo2gAOa27bKZUhL2Z
 F+oKSWom3BQ
X-Received: by 2002:a5d:5f8d:0:b0:46a:d1e7:4516 with SMTP id
 ffacd0b85a97d-46dc046112cmr1889369f8f.6.1782374952109; 
 Thu, 25 Jun 2026 01:09:12 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:11 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 0/9] hw/audio/virtio-sound: basic migration support
Date: Thu, 25 Jun 2026 10:09:01 +0200
Message-ID: <20260625080910.30569-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42e.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset is aimed to support virtio-sound live migration and based on
pre-existing Volker Rümelin's patches from qemu-devel lists [1]. I tried
to ask (https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f53b8a335fc53569.camel@mihalicyn.com/)
if Volker is going to continue his work on this, but received no reply so I
just decided to go forward: take his patches, rebase and resend. Of course,
I kept all authorship/tags so I hope that it is fine.

Testing.

I manually validated this with Ubuntu 24.04 Desktop VM and found no issues.
Also, it was validated with CI (https://gitlab.com/mihalicyn/qemu/-/pipelines/2626702088).

Original patchset:
https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de [1]

Git tree:
https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration

Changelog relative to the original Volker Rümelin's submission:
- rebased:
	- "hw/audio/virtio-sound: return correct command response size"
		was dropped as it was already merged
	- "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer handler"
		was dropped as it seems to be replaced with another fix
		https://github.com/qemu/qemu/commit/731655f87f319fd06f27282c6cafbc2467ac8045
	- I had to drop all pre-existing Reviewed-by tags cause it was 2 years since
	  this patchset was sent and reviewed and I did a quite significant code changes
	  during rebase

Kind regards,
Alex

Volker Rümelin (9):
  hw/audio/virtio-sound: remove command and stream mutexes
  hw/audio/virtio-sound: allocate an array of streams
  hw/audio/virtio-sound: free all stream buffers on reset
  hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
  hw/audio/virtio-sound: add stream state variable
  hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
  hw/audio/virtio-sound: introduce virtio_snd_set_active()
  hw/audio/virtio-sound: add missing vmstate fields
  hw/audio/virtio-sound: add placeholder for buffer write position

 hw/audio/trace-events         |   3 +-
 hw/audio/virtio-snd.c         | 685 ++++++++++++++++++++--------------
 include/hw/audio/virtio-snd.h |  25 +-
 3 files changed, 407 insertions(+), 306 deletions(-)

-- 
2.47.3


