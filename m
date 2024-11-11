Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33250D3ABCF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 23:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAdP3-0000uj-Qg; Mon, 11 Nov 2024 18:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAdOp-0000tJ-8L
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 18:00:48 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAdOn-0001iw-Hc
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 18:00:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso44316705e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 15:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731366044; x=1731970844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2jf5eXU7OOog4JuRVBDPTFD6Bzvpvpk+NdEpqLWLXPQ=;
 b=IoE37ueuKqoPRlj3EYv5uN/MghZc6R+FKcmQc1RUcCDr9ZmcOBngUtLhdeD1NSx6xH
 UCK02Mr8aMtNExAUxyTtRrglxU1EsgJaZB1FMHoVpfLATreY0SI224SOmbR4l9w7DFKM
 86gFCK3yjGvnxaVvgaS9sR0ZRBqqvaAQX2uwN6hIoIoNTYnpK04EXEUPmhn2Sp58WmpE
 N15v7idB3Q7tOSIwgw6m9MLpxtaCJjvPF9lcJBzShCtwL11WO3WEHvbinpyu04g9s3wr
 QT4AvZrUpN9k88QNGtLRVCC7lOWsgP5W66oiUotY7P09MDTQgQrc1NmuHA3puKsDtnZh
 eS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731366044; x=1731970844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2jf5eXU7OOog4JuRVBDPTFD6Bzvpvpk+NdEpqLWLXPQ=;
 b=WH8WliFA6+dbwfKwwkyLC9mXt7ASpozEHsm2KyOI+wFpG4v7XxpRe0HQtS8ptcRWPN
 pkl/wTVqz4mH7rzvY53VYN3fEyKngGqlQjT3QZAqfd+7TRoMDHyzyv1h76C1k8WgdTFI
 Gq9xqAEhs/fM61dDJ9shSTsFGefX7EQUzNgHyXc5PPRFU8A5+jVDeCfJDxOy7011zYit
 Sq8FgxG77bmokJXWbGxU0ssJU04Pmo7dPgxPRHBEJXakiYVb0bI+3gF48guZAXQrrfk4
 x//X/W/+EzfBnFtGVI9L4sUO105uobudcPjwyn/nCViyT8V3e5R2wkA5EblDIRbwlZUr
 hlkA==
X-Gm-Message-State: AOJu0YwLrg2OtTrhSW5AUa8hbxtlE9dBHxyLtfiM8TjBqQj7/H97ZHep
 i1+I2ENOpwMDcf4ixq2ZjZp/idryka5ZVUn7PSslZcq6KudwEaj8S+S26AF1QXk=
X-Google-Smtp-Source: AGHT+IEq9GXXvNz3qT3s9LLbsuPrJX2omf/Ud09M8MWKy6b+lP70CDjxIxfV7fItTfySXEjr7D+qow==
X-Received: by 2002:a05:600c:3584:b0:432:7c08:d121 with SMTP id
 5b1f17b1804b1-432b750331emr127277875e9.12.1731366043862; 
 Mon, 11 Nov 2024 15:00:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm234004665e9.8.2024.11.11.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 15:00:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C7B8F5FA35;
 Mon, 11 Nov 2024 23:00:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/2] virtio-gpu: coverity fixes
Date: Mon, 11 Nov 2024 23:00:38 +0000
Message-Id: <20241111230040.68470-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

v2,

Fixes after Dimitry's review.

Alex.

Alex Bennée (2):
  hw/display: factor out the scanout blob to fb conversion
  hw/display: check frame buffer can hold blob

 include/hw/virtio/virtio-gpu.h | 15 +++++++++
 hw/display/virtio-gpu-virgl.c  | 22 +------------
 hw/display/virtio-gpu.c        | 59 +++++++++++++++++++++-------------
 3 files changed, 52 insertions(+), 44 deletions(-)

-- 
2.39.5


