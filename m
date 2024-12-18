Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE831E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwSL-0006Cu-8S; Wed, 18 Dec 2024 10:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwSJ-0006CD-OA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:59:23 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwSC-0007qs-Ut
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:59:23 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862b364538so559674f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537555; x=1735142355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o7TTefP9nXOqik7RDcZbvdDuVx9jkgFOarBEq8+dT6A=;
 b=L8qGclipZYUTUnrEkDx3vS4FssAWFCFMldyg6gUnWEFBWAVloY/fYQ9Leh6Imwtd1h
 HcztumT3g/1E/ZIGNg8rYVNUM7do6SChEvZgrCnrr7/4kOyq7uOc6A8rtoYo9aFciRFv
 mJeWGwGcOsCZ5ytLee2ywHqNScOoTVkoWUK/9E5UZuUhbkLKDiNfKUa2Y4WfUN7yl8dh
 6LWZXgr3eT/I1Blzz4e4FC3eAJ3qDYuVZilAGZP9yPj67vX1DA8MuubVTGzr1rRpjVza
 EUNbscoDmoUbuWNeoq0CtooC39a60RsgVP6nHGtAAAJAiDVXytrcwq8ACpo0xI4aDpX6
 cXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537555; x=1735142355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7TTefP9nXOqik7RDcZbvdDuVx9jkgFOarBEq8+dT6A=;
 b=mUtlX+aZVNk+lP4eZUENwacwLFpez9Li9ZhrAleHD7A3GVUxHX/yKo3MX57rm/IA/O
 E8MM0nJTAxZwAeynEqna9vFJu3YE7gFJXQ15OOHtX6jNgoBL+BPEFX9pnAj1bktTUXo/
 aP1qKDxLps8fUS7TjN3M4oQ8Jws6skQNxPq8BC+P+93D0aiU/g2TeD8mjGuhae0a210A
 ykytm3A1sJhO44c8uNa5deV4WsHfGhmcBdoMgeTmAt6ts60ifSHTlcwgj92wLQBifB7n
 YnMBuk9aVIfs8twgghlajmkme8N7HE5VH6wXsj0NJWpZIKZPxMtevLycjPMVyFLjtuqm
 7t7A==
X-Gm-Message-State: AOJu0Yx/+K23X1NDpCwGlRT+TRYdV7UnNz0FsnblfKpxH4J9cEC0H3xY
 ImHfhwUtiJl7AbpWZ6eTCwuIilOF2TkRuP4lCB1z65jNnDXwKy0hyppeLV1trQKI7KIercrtFvw
 4
X-Gm-Gg: ASbGncsRgj8KHBjyBOUK0z/S5HsgetBP4Xsgli+D9rIG79lL0h7YXBsyyEZljfIQsn+
 F84M8MwKOOENVPr/TY6HuncI8TprT79A5alGa+cDC/FtTSqNXdZq/JbEN9y0RHgbGUd4H2CWOZu
 dG182HoE8Gin/5MMLKL0dct7NEF7UfbjqxX1IdK7H8O69Vjgf6RviTh2Z0QC2sLrRUzvcstdQCw
 7aEKiJmThMYI2nUjgHrcrauiUyqYarqnqndwXY6bKctbFlCfxlvhE4y0fJAHbn804GEKMsrmO+L
 DCg+
X-Google-Smtp-Source: AGHT+IELZ+GggeTZx48MEhW7+44jizCcSkYTHAep0mIEWWuSZqv0/tl8cNaTNgN3QB2V/mBJ1CUGnQ==
X-Received: by 2002:adf:fa0f:0:b0:386:4570:ee3d with SMTP id
 ffacd0b85a97d-388e4e79284mr2556298f8f.24.1734537554946; 
 Wed, 18 Dec 2024 07:59:14 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a628sm14684705f8f.47.2024.12.18.07.59.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:59:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 0/2] system/confidential-guest-support: Header cleanups
Date: Wed, 18 Dec 2024 16:59:11 +0100
Message-ID: <20241218155913.72288-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Restrict "confidential-guest-support.h" to system
emulation, remove few SEV declarations on user mode.

Philippe Mathieu-Daudé (2):
  system: Move 'exec/confidential-guest-support.h' to system/
  target/i386/sev: Reduce system specific declarations

 .../confidential-guest-support.h              |  6 ++--
 target/i386/confidential-guest.h              |  2 +-
 target/i386/sev.h                             | 29 ++++++++++---------
 backends/confidential-guest-support.c         |  2 +-
 hw/core/machine.c                             |  2 +-
 hw/i386/pc_sysfw.c                            |  2 +-
 hw/ppc/pef.c                                  |  2 +-
 hw/ppc/spapr.c                                |  2 +-
 hw/s390x/s390-virtio-ccw.c                    |  2 +-
 system/vl.c                                   |  2 +-
 target/s390x/kvm/pv.c                         |  2 +-
 11 files changed, 28 insertions(+), 25 deletions(-)
 rename include/{exec => system}/confidential-guest-support.h (96%)

-- 
2.45.2


