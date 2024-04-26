Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AEFC19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 15:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Nfs-0001ma-V5; Fri, 26 Apr 2024 11:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s0Nfr-0001mC-Kf
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:39:43 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s0Nfp-0003n0-Uc
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:39:43 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a5200afe39eso257177166b.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714145980; x=1714750780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=beEy1BaUq1ITnJ2FawCB41NknSvAad6CIwoqmqhNong=;
 b=PoiGMYI32SOmgnuH5Y5ZloNlXYQtUHYSkIEeNALVDp1OFCe+SeorPmDqXrwUvHYBF5
 GknGkv0w/OV7qaTU9zH8MxAMhNGVn1IBlIzRtx30g6QS+althLvCa17uUcu33/gz32mN
 W4KRPCQrO9SmgysU/bT1NLCdvrKNIB6YTjizbaTlZtLARcX/oadw7e3z4UYPh3cRzYjh
 P1HzNSifhci1eRvnEnF9fQ19xrmKaBSermO2jYlICe8b/IRJXfPsDADo24kD0JDaarXt
 kNSa6H3T5stIesBoNQKUlr/H+d9mr6+VkbTzdeIywLLSv0W7kmlMHQnI5a3zMKlFM38i
 cIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714145980; x=1714750780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=beEy1BaUq1ITnJ2FawCB41NknSvAad6CIwoqmqhNong=;
 b=uPPxa9EbX7Kb8lBveKYg2TqTfAbqa2Ktng7AxR4KEbit2/nXWK65fMLdtnJd1ftiaK
 gum3HbJ8Z3tv1aux33/KVOAqZ5vV4dzelqPeJgAkrfq5yj7+l0M8S3MaCTz76YCl5AKE
 BOI2Q4xaD3FynZx6wW4e0FR75Dwb3U0UBEYsJMtntWz4Qyzh+BPADtTsn0OixyfhtkX3
 XzUs7HBIfIRQtR0Pz0oNabRJnv8MNUdJ+NCLyPLrUoKnZftlr7V9p2L9rBfnnoEYlVyq
 8ExQzHECh6HO/uSV90FRohBt19nHvu9N2expqd6wZ80aNHwqyL5eAzXuMJmcwBy0wG6l
 s3ww==
X-Gm-Message-State: AOJu0YwfPaWEXCWdUKPXHELDfHLNtYnAePCT3UhrG2LgEh9Q+HrxHKAu
 bFbOvSUgs2vLfMsucJqHRj2j0URWu8OdxxBYdFvKVfXbVKSMQEIk2vp8AE3puiM=
X-Google-Smtp-Source: AGHT+IHy35rhjXSAb644NNlEWsZQxnZUNOs8iuPbE0jtQ5KItWEvHQx+rCrq5TWbHqMCVFt8zCFK4Q==
X-Received: by 2002:a17:906:aed2:b0:a58:a2f9:d795 with SMTP id
 me18-20020a170906aed200b00a58a2f9d795mr3167429ejb.59.1714145979721; 
 Fri, 26 Apr 2024 08:39:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l18-20020a170906645200b00a55bb18e3d7sm5790936ejn.168.2024.04.26.08.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:39:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3E3E5F882;
 Fri, 26 Apr 2024 16:39:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Joel Stanley <joel@jms.id.au>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/3] testing/next: s390x gitlab updates
Date: Fri, 26 Apr 2024 16:39:35 +0100
Message-Id: <20240426153938.1707723-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

I was asked to update the custom gitlab runner from the aging 20.04 to
22.04 which has been done. However I needed to update the provisioning
scripts and clean-up some of the cruft. Sadly this doesn't seem to be
passing cleanly as we have:

  - qtest-s390x/migration-test ERROR           98.94s   killed by signal 6 SIGABRT
  - failing TCG tests (on s390x HW)
     - float_convd fails against a generated reference
     - clc returns 1

There are also lots of scary DSO warnings:

  BFD: warning: system-supplied DSO at 0x7fedb6479000 has a corrupt string table index

Can I leave that to the respective maintainers to investigate please
as I have a publishing deadline coming up.

Thanks,

Alex.

Alex Bennée (3):
  build-environment: make some packages optional
  gitlab: migrate the s390x custom machine to 22.04
  gitlab: remove stale s390x-all-linux-static conf hacks

 .gitlab-ci.d/custom-runners.yml               |  2 +-
 ...20.04-s390x.yml => ubuntu-22.04-s390x.yml} | 32 +++++++++----------
 scripts/ci/setup/build-environment.yml        | 16 ++++++++--
 3 files changed, 29 insertions(+), 21 deletions(-)
 rename .gitlab-ci.d/custom-runners/{ubuntu-20.04-s390x.yml => ubuntu-22.04-s390x.yml} (80%)

-- 
2.39.2


