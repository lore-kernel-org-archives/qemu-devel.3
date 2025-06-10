Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DBEC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 21:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP6Wa-0005Xr-Gj; Tue, 10 Jun 2025 17:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP6WY-0005UJ-GY
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:28:50 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP6WW-0000gy-V6
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:28:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso6973577b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749590927; x=1750195727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw4SDBwHRc0pP24V+cqKFVpB8AcIfnhpGa4QGcJ4RuE=;
 b=TTKn4Bn9y07bkhjw7gYEumbQFaz20+RNXNulaTGZTk5/RfBwxQxDuN+gdR70keT+Jx
 5GLG53OT8aOQS7+VCnXT8mhU8XoBvD1leL34gL4SOi6CYnnDCsW9AlcHbmkWR4MBCZEB
 LfeJF3NEsDcl29FVz4ew0h5tjVvau7uByBemQkaA92yEWJYhzip8CD8257QfgKFvMR4v
 vaw3XRPIgC8HBhxA4kqKLbNDycku6ZANqvkoSwik48cwUA6KVxzzXWuD5GBd6ztKuWnQ
 MxYBAnNzWP7HekgXRN/UZnRBqpdkA7zs5bCWSfKnhzh8E6xYEHVpV3HRIIkEpTXB42s6
 +CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749590927; x=1750195727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dw4SDBwHRc0pP24V+cqKFVpB8AcIfnhpGa4QGcJ4RuE=;
 b=rLhxhsnF6G94cR8H+m/zNl+vgCuAx3Zor2uldBgx8XTO5ROsq7oyn+kDPNciF/OoSV
 Q/iXJfyyBjWLkLDyz2QyR6RkpbS4cLsYJhROQY9uV4I3OEwD6qO9DNt0emn4IuB1sT5V
 9byORYLxfA/vGtf9FXBkl9f+2plMhk83aw9+dUVKV54V/weqLhvNJm4e+FDxpFTstQY+
 RSju55AK2rn8pLayFq4IQgnNqnvocLiVcChQOi97kO1n3xEUs66sXmz/IHDaYQNKnZfy
 IzNFdbDpT8+uOVL8HEsRLQiPoVDzu087op8g0+2DsmVd50wNX7OlZrmNasVflTXE5GGK
 SS0w==
X-Gm-Message-State: AOJu0YzQGgBDkDWv43Or8o9R3+IV4k+9v+7OhQFGF2EYkJm4/KuD/jg1
 n6FK9GcoTA6D0moHmPDOvjayIZKyQ2qoX/doSjTAfX/Gks7aP+TVEQgy0qJb7VAHjyrZKCgxg1m
 20v8+
X-Gm-Gg: ASbGncsoINugiLicCQNb56CekN8cP6LXeBzZZa/qs38YQJnwBhKiqTl1FLpiLfj5b8Y
 qYG6g2fW2hahQPD6xaqzpzLPRVmI9n4ScCLCOpr4f8IEEtUUp2X66QHnxF0MUSvb5C9jxVmboBa
 WItcRVfMspvUDJbtCPNurJzgsOtYzg7aZU0kH6nfwh7FEO/9toP/vbKZHRi38sBsiLYmgec47Ji
 BXhB+nKqKp2+yc+TWrpmY8931u/InEUpqp7O78zSof7XfdHzZrn6zwZd7NJfEBu5DvDqZARXMvX
 I1Ekgey27BVvLHNElAqptxSVOZMX7ggsLKouP67ZmWdA05++aAm031jYsb08eA==
X-Google-Smtp-Source: AGHT+IEEm2eSzna45fW+Z6bG6DDugweOaQFn4jfV4WhBQDnpO56XPxI8rSRni8bB1rc4WSAca3JaPw==
X-Received: by 2002:a05:6a00:124e:b0:740:595a:f9bf with SMTP id
 d2e1a72fcca58-7486cb722bbmr1369500b3a.3.1749590926856; 
 Tue, 10 Jun 2025 14:28:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0c0613sm7864225b3a.122.2025.06.10.14.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 14:28:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, berrange@redhat.com, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/2] control guest time using a dilation factor
Date: Tue, 10 Jun 2025 14:28:27 -0700
Message-ID: <20250610212829.2818792-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Depending on host cpu speed, and QEMU optimization level, it may sometimes be
needed to slow or accelerate time guest is perceiving. A common scenario is
hitting a timeout during a boot process, because some operations were not
finished on time.

An existing solution for that is -icount shift=X, with low values, which will
roughly map virtual time to how many instructions were executed.

This series introduces another approach, based on faking host time returned to
the guest, by applying a time-dilation factor. Time will go slower/faster for
the guest, without impacting QEMU emulation speed.

It may eventually be used to fix some of the timeouts we hit in CI, by slowing
down time in VM, to be less sensitive to varying cpu performance.

Pierrick Bouvier (2):
  qemu/timer: introduce time dilation factor
  system/rtc: introduce -rtc time-dilation option

 include/qemu/timer.h     | 22 ++++++++++++++++------
 system/rtc.c             | 11 +++++++++++
 system/vl.c              |  3 +++
 util/qemu-timer-common.c |  1 +
 qemu-options.hx          |  7 ++++++-
 5 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.47.2


