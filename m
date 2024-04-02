Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F67C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 12:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcpM-0007hY-3G; Tue, 02 Apr 2024 08:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcpB-0007Ua-G3
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:01:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcoG-00034h-D8
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:01:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4156dfa8a5cso8162565e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712059202; x=1712664002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pf6iAlvC95lcmhl6PK/jcsdEbiggfdr3Doja1fwCupM=;
 b=xcSG5IT6eExeSD+bgObGZCIvOPb+OgKuNwJTvSYHRkDcyt6RGB3klBVpPMv+XDoCWx
 3CfH8VGzoXzr4MI52db8MW2xyy4o3hvDSrInunNsureF87Ab5dfsYGQ82dFHcyaRweZZ
 fas+ryo6nUXPIwTuE8ROTXMMq41JFkPsI7PjUZsnIgWYJRDz3Unoj1RlIZBPO0s3jasj
 fqp5Bwf0LaAV1/Bnc5lTRQv/BPk/t+UTjTFaEpbjM5C/ASuVQiW3k6GKqobeZFSZcyCe
 qTBvNkwoLbzmMQarBJIQUfw06bi2mqWBiyX97wvGRpBC9l+l9V5wbqRsTkf7EpaP/ttW
 9qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712059202; x=1712664002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pf6iAlvC95lcmhl6PK/jcsdEbiggfdr3Doja1fwCupM=;
 b=KbuPuZr8rWaDixvs4M5M/BvvTjG/bNAQEGTMYgfzhCO8iU73ZDyiLevEDLEJkETlmg
 F4WqGENozPIKtFqtPciKcplb+7FksQqunnKPzKNcJ41pn6IHvoBWTiFvp+kyVgT1zPfe
 mLblzgmGQPC5Jf0sj5qSn6ZTEpqQ8QvVtNpmSW/ta65PqAMDuoSijCjXe09Hz+NFVRLM
 /R+4fNry3NhJAafPBnUtRPaDgXDi71OD1KOCgRx3USpx7A1HYjWLrx/RRgAtf9Uq2fg3
 0rkwhuSQHXxAQIthXVqq7n7NoGUOD66oGieH3aXjUizaVeHpLlu4hPTG2VmFWKu7Jw/H
 gONg==
X-Gm-Message-State: AOJu0Yy1+YAML9Vmu2tEvkashWsnY0s0VA/Si3KvM6wsElzAfnFoYlm3
 uaWlghaWtsz9Zfd4jFORKtEdS36K9Cg6/FnF5X7jvVgpVYZDAPnB+zyE9l7Q2VNvjxGecrmpYH0
 5+Go=
X-Google-Smtp-Source: AGHT+IEg4VxtfFHoptXE7r87n9Ghvb4CiBIU28SZPBGwZVem9JGzPDqibtpAEYrHeLNEY3jfzGELVw==
X-Received: by 2002:a05:600c:3b17:b0:414:1325:e8a8 with SMTP id
 m23-20020a05600c3b1700b004141325e8a8mr8443095wms.39.1712059201954; 
 Tue, 02 Apr 2024 05:00:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a05600c1d8200b004156daeee90sm3482495wms.4.2024.04.02.05.00.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 05:00:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] scripts/checkpatch: Do not use mailmap and check
 qemu-trivial@ author
Date: Tue,  2 Apr 2024 13:59:56 +0200
Message-ID: <20240402115958.67615-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v1:
- Extend regexp to cover all lists (Peter)

* qemu-trivial@ is not checked
* mailmap hides the mistakes we want to catch

See https://lore.kernel.org/qemu-devel/60faa39d-52e8-46f1-8bd9-9d9661794880@tls.msk.ru/

Philippe Mathieu-Daudé (2):
  scripts/checkpatch: Avoid author email mangled by qemu-*@nongnu.org
  scripts/checkpatch: Do not use mailmap

 scripts/checkpatch.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.41.0


