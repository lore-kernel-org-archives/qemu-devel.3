Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D093CE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaVQ-0001vl-5M; Fri, 20 Dec 2024 05:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaV0-0001Uw-Ba; Fri, 20 Dec 2024 05:44:52 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUy-0005qx-Oo; Fri, 20 Dec 2024 05:44:50 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so1259202a91.3; 
 Fri, 20 Dec 2024 02:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691486; x=1735296286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUyed0Mv317RslXBhQnrdsiMxqOOIApYdyBw9bEw7WQ=;
 b=EEUx1MeuYPUTO2EtZyMY1RbJ7RrL2OD+m0tcqJoCboCOQrs1BsyyLxrtTAjpL9Y+0j
 80bRUUQK8zxlgeGzFblWTjp3vqazeGlZ1f7K/Cqq3nKYik7pSJdymsTakd0ZjEQu9X/e
 MQ3D9JrTmQDG58cZrAxgEkEYf9FZq1g/VQOlQVe24S1llbiJF5UPmVl3aTf8Xx43kcqr
 pHw0sKJnMSBG4uR++/9GgG0PE4PkQzQybNJ47TLVLvbyiNepG1ipZFloTF27n/vsOt2x
 ip7yUR4KnVSLuX7O3pvH3sI9m9lOS9hq3YTULAYNNCdTaLUdfm5GWGGsHDEFLodItHQf
 uaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691486; x=1735296286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUyed0Mv317RslXBhQnrdsiMxqOOIApYdyBw9bEw7WQ=;
 b=r0KJhd55ttoLA199tg6Zue+eB7pcyoJJujNw0G6d07nnJSYUOmkHzRNNCr0VGgIMCl
 a2BRhvCs+ZsG1DFfBHPh01zI/L9Hc0YDihAyRBVPem3OPpLuxoK8+Hb4L6QnU4XsXgk2
 XkZvy6vLSqC+OPV0EvjcYvWTJ7gPWi8Q1vgOhqZN373tZspxEeq4yaQmqpDzOyiTkQtj
 42lqoxX7vbWMukcm5uLpDkAgXVhQ9Ef9b1LHXQshBYbiOTjFNPPNUUcndZ1V+FMo2Ihb
 yf4BhFeRZ0f63Q/hpHXT1Qgb2cDB7djYeNeRb1ogW7BQpsG2xYSgWQnvVFhS+60Zhaxf
 42EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS3sIe8VweecTrXVku77Sqy8861AzFx3+gpAsAqYDEz7Ga6l2gyxHUEUGGeXvErgArR9jzIWFrSf00@nongnu.org
X-Gm-Message-State: AOJu0YyUk83u7O9mChqjbLizdNYgsTiHwfk7HNS6XC6wIjmZYWYlS5No
 Gji6KQgbv9kYjEvopE48odmd9q7TS4QuehhgwvXXtzWZUutWz400o+Lg0A==
X-Gm-Gg: ASbGncuewSOdE2euHNECHtP5JPe8iVvus2CNZhIh3hwECT0Hj1EyOQYZ+Qex+/9v1Re
 KPovnxysKz3VSltarUVGDwQrr3VXb6P4l1wZkZOVTYE1C/5yzv6IfSwFebn/a9Ts/j8/tJVk5N8
 7P2j83MqdUPH8PUPoRLK+wce0TBVh6CiiTQRTE94+1GghWT9IXhHG4EyxwvR9kfYyYqyWA373P0
 9lE/IJa6enjuYameoUyCKL/ozMFQG0x/BxybH8b/s+QLtYugoScO1ob+CJIzguWLS8wLQJG7Wf2
 8TFSE3bNcg==
X-Google-Smtp-Source: AGHT+IHaJWUjKlKfFU0Xe2l8iFS7/kb2KReHUIV9zbBygCXiPtl4R3UW1nNRiM5jOFdjHacHtPp/3Q==
X-Received: by 2002:a17:90b:5183:b0:2ee:5111:a54b with SMTP id
 98e67ed59e1d1-2f452eec7dcmr3095432a91.31.1734691485846; 
 Fri, 20 Dec 2024 02:44:45 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:44:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 17/17] tests/avocado/replay_linux: remove the timeout expected
 guards
Date: Fri, 20 Dec 2024 20:42:19 +1000
Message-ID: <20241220104220.2007786-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

replay_linux tests on is becoming more reliable now, so remove the
timeout expected tag.

These tests take about 400-800 seconds each, so add the SPEED=slow
guard.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Note that Alex gave R-B tag for previous version which marked
a few things as flaky. They are passing in gitlab CI now so
hopefully it's okay to keep the review.

Thanks,
Nick
---
 tests/avocado/replay_linux.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index 6c08ddaaff1..362e35c8849 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -121,7 +121,7 @@ def run_replay_dump(self, replay_path):
         except subprocess.CalledProcessError:
             self.fail('replay-dump.py failed')
 
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class ReplayLinuxX8664(ReplayLinux):
     """
     :avocado: tags=arch:x86_64
@@ -142,7 +142,7 @@ def test_pc_q35(self):
         """
         self.run_rr(shift=3)
 
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class ReplayLinuxX8664Virtio(ReplayLinux):
     """
     :avocado: tags=arch:x86_64
@@ -168,7 +168,7 @@ def test_pc_q35(self):
         """
         self.run_rr(shift=3)
 
-@skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class ReplayLinuxAarch64(ReplayLinux):
     """
     :avocado: tags=accel:tcg
-- 
2.45.2


