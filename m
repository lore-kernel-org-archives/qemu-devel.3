Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559B0C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwZ4-0008SC-VP; Fri, 16 May 2025 11:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uFwYu-0008Nu-Lq
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:01:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uFwYs-0003yt-GD
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:01:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso13106175e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747407680; x=1748012480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvjWYMxIvKnpV+Olp/wLy3McCMUasA++HehRdFgl1q4=;
 b=eZXin73+yhaxLRvMp42WbufyXYPZzwgxSqxHG+DiZmg51EMy6UcXeRP6ha7R/DJdoO
 /8FWThaveEqBhPrIkveqxM+ygwRR2go8ueSnzZstSRXG5N4diCgp3ntpLysjVCQXRQP7
 NYD0C2IcZKbUzRt8xIdpopGfYDqzRF8BrZPiFxaCh4fmpE1GEIGfs0ESB0hmk9KVf5S6
 s63kIYWYKYtYDWuDyV4g6ZZ2naFgAA4M8Z0Sy9l8kAmRzmEdn0uPbvygTgLwj9AqOfo6
 qAInS7nJzxgvMtc3a89DaOgCxJgW0p2qqhbq9Ja5BT8HoejoBTMch5A8Dhxzqu51wixm
 rqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747407680; x=1748012480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvjWYMxIvKnpV+Olp/wLy3McCMUasA++HehRdFgl1q4=;
 b=VqlMPKrTSPBjN/douVqypNMeFOlmOo//jfvPF9ytSlDg4YMVhdIREJ59YM0CuEdisn
 PNzOyRmjB0FN9S3dXCDe0WTe2HZGDmE9ejuED6q7O3ihUziSlrmzZaclqtiNSbUcJNGf
 nbhPEA7yJndahPy6M3QeyCEIO1LWdMt/WaElfgP5jjMEbAxEr0Jx+Bc5vDcLYjwLSqzc
 PFCX4qN+hmv9xyIVSLpxjwpJrRU+FUlPe+tZihz9rsrRkZKLna5nKtrBb1rp7pYpDag0
 GZRI4Uu0Nh8iYhWiES5JH12AqyLtv+Mvkn8dMJ3KTC0yoAgcsHfV/S99k6ASEJ+xKxUs
 hBoQ==
X-Gm-Message-State: AOJu0YwIiCS13WmTVX9+qxwkueVCUCFvsqscYg4YJgs0vF4G5g5YCRKe
 s5lFVmQ7WZSHC0P7+s+LoBa8QyXGz9HXtEpG/ZZ3JPUWfIET58GX/QAte0Ud7EYC
X-Gm-Gg: ASbGnctmImAbzdP1/Q6oAPq3XtnMb7GhCsPUHgHEDvn7qbswmFw6oCNOGQhCkMu8H59
 efh3E18oWBGcJufOB7E38VYgnhNNmvHOxHbAKfLpACJLnybG6zlVM5kJ8ZqP/yD0pW1YQMRfEf/
 nDmIkgOoOeQSKlenm8V/StSKFQnFjthENTCIl76+n7gzMz1vYJ3AFdh5KtRa8JBD30HGM2LiugJ
 vgUl5E4IHP+WX/8kTH7yrxSeITNf6iPGNBxLfl8QTjeajClFwYj/LSCXehf7uzBMIWTtapOh6aX
 euqsSBZEBptUlRU2vjEtaWq21iaaRMXGH4fXQPXSPqtlOaRMaguXVHq0/2MZ6wbgR5w=
X-Google-Smtp-Source: AGHT+IHyDKj3Xqr7hLzQf+VDbgez0NGKBcAs0xsAVPqL38oOIrUK+3Um8O9PSdzHzOxrf/zxq9rQFg==
X-Received: by 2002:a05:600c:1f0b:b0:43c:fabf:9146 with SMTP id
 5b1f17b1804b1-442feffb5ccmr33043155e9.17.1747407679789; 
 Fri, 16 May 2025 08:01:19 -0700 (PDT)
Received: from localhost ([94.239.154.20]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-443206e87eesm3696695e9.1.2025.05.16.08.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 08:01:19 -0700 (PDT)
From: conte.souleymane@gmail.com
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, peter.maydell@linaro.org,
 Souleymane Conte <conte.souleymane@gmail.com>
Subject: [PATCH v2 0/1] docs/interop: convert text files to reStructuredText
Date: Fri, 16 May 2025 15:00:51 +0000
Message-ID: <20250516150052.30818-2-conte.souleymane@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516150052.30818-1-conte.souleymane@gmail.com>
References: <20250516150052.30818-1-conte.souleymane@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=conte.souleymane@gmail.com; helo=mail-wm1-x336.google.com
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

From: Souleymane Conte <conte.souleymane@gmail.com>

This patch converts the qcow2.txt documentation into reStructuredText
format (qcow2.rst)

Changes since v1:
- Fixed typo: "Each entry look" -> "Each entry looks"
- Adjusted nested layout diagrams for better .rst rendering
- Capitalized "QEMU" consistently throughout the doc

Souleymane Conte (1):
  docs/interop: convert text files to restructuredText

 docs/interop/index.rst                |   1 +
 docs/interop/{qcow2.txt => qcow2.rst} | 218 +++++++++++++++-----------
 2 files changed, 128 insertions(+), 91 deletions(-)
 rename docs/interop/{qcow2.txt => qcow2.rst} (88%)

-- 
2.49.0


