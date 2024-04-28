Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71BCC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 11:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s12Ra-0004VC-MV; Sun, 28 Apr 2024 07:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s12RY-0004Un-Ci
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 07:11:40 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s12RW-0000Ym-Ca
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 07:11:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f2f6142d64so3386877b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714302696; x=1714907496;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/4YH1P7orc/Te98j0BdkDaV2/xgzpkcLw1sCbumgnEw=;
 b=1uI4YQmIv/sdW6ZtMuCb/Qjv105gZod2yS281ZdcDlHX2nn4tHHcCnjhN4WcUS51ZR
 R3YGEY/uori0IRbaX5+TwQRAjxcY/xYy9Ea/QynYHLbW8Hkl6mdXqZRzSYQm3BFHFIB1
 Wll7DT5PJR6CVLuWzBJLSdLiWIBA7YwVgQjaB++TIf6zG203ly42IpsO0gfC6Rrd9vhu
 kI7Jwk9MGPnVlR6KBGCOJqJq/+TvFIOStq9JmMDAfnBnpyEPw6lpTva0B2MdyfYX/6yd
 nbFoA6McVzhBM4AS4qzB4isSqUpqeBKRDwwGmU6LtZ1qWk64Nqx0neStZH0QTt7UzXKt
 6wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714302696; x=1714907496;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4YH1P7orc/Te98j0BdkDaV2/xgzpkcLw1sCbumgnEw=;
 b=YJAgdNgxakyEXnK3bzpaQPZpMfqAEava8DEjy6P7q3AUJmNmFZ1BlLt0ywkMB0KhlP
 xsnrGt88TLfj0XhBEt5n/a0AkefCJcB/XWHQUoKdoUsVi1ZhDPsact7XwJUU7Vqy+sU2
 4pwb+2bAY/dYbtS/cya6gOMdYWKkyfL+SPEHl2h2oRqT/0wF3W8BgSGXlNSeEXLXkkEe
 Oep20TH2zhSxNizstyg7cS3Hk8NhtT7BUnWOPWYcTjStYI0QYnbPrjt3ImkWQN5Yyy+a
 kdcIGqn7o/U4RpOP/b8sTysIhgGuIPUyCYl08QaUduaegW+0sCKIaw0+JeXpOptrIUAE
 aRDg==
X-Gm-Message-State: AOJu0YzodArkTv1fU8s/kfeh4Itrr98dtyoDBpigbHWHoNQsMsw9l59d
 cxWhlA8O1M/0hnZjQ7514T96v87CRsfWaiX57rc1M4crw3odM7isF4WnGTlMJ0A=
X-Google-Smtp-Source: AGHT+IHk9vxvmhEmjLG9oQZMMmG4zoEd0/k7bnvlpQpbrYEUvWvMKXezdHWS1KL8wMweCfCPD3OXkA==
X-Received: by 2002:a05:6a20:d428:b0:1a9:ff21:8862 with SMTP id
 il40-20020a056a20d42800b001a9ff218862mr6523177pzb.60.1714302695975; 
 Sun, 28 Apr 2024 04:11:35 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 f33-20020a056a000b2100b006ecee611c05sm17542280pfu.182.2024.04.28.04.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 04:11:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] util/iov: Do not assert offset is in iov
Date: Sun, 28 Apr 2024 20:11:21 +0900
Message-Id: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkuLmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyML3cz8Mt1EY0PzJAMjMwPDlGQloMqCotS0zAqwKdGxtbUAg265YVU
 AAAA=
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

iov_from_buf(), iov_to_buf(), iov_memset(), and iov_copy() asserts
that the given offset fits in the iov while tolerating the specified
number of bytes to operate with to be greater than the size of iov.
This is inconsistent so remove the assertions.

Asserting the offset fits in the iov makes sense if it is expected that
there are other operations that process the content before the offset
and the content is processed in order. Under this expectation, the
offset should point to the end of bytes that are previously processed
and fit in the iov. However, this expectation depends on the details of
the caller, and did not hold true at least one case and required code to
check iov_size(), which is added with commit 83ddb3dbba2e
("hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()").

Adding such a check is inefficient and error-prone. These functions
already tolerate the specified number of bytes to operate with to be
greater than the size of iov to avoid such checks so remove the
assertions to tolerate invalid offset as well. They return the number of
bytes they operated with so their callers can still check the returned
value to ensure there are sufficient space at the given offset.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      util/iov: Do not assert offset is in iov
      Revert "hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()"

 include/qemu/iov.h  | 5 +++--
 hw/net/net_tx_pkt.c | 4 ----
 util/iov.c          | 5 -----
 3 files changed, 3 insertions(+), 11 deletions(-)
---
base-commit: fd87be1dada5672f877e03c2ca8504458292c479
change-id: 20240428-iov-a317b02601dc

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


