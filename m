Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EE7C02191
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 00:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcZh4-0008OM-Kz; Mon, 27 Jan 2025 19:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcZh2-0008N1-Pp
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 19:43:04 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcZgx-0003TM-AR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 19:43:04 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso118059675ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 16:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738024977; x=1738629777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6DlwPPFlajfgRhVnHl7DfLUHYhqRSBckd+fMhhlX0FM=;
 b=uf7KV7IzNNAeuJUsjILryUdH6fqIX9hNJ72s39sKUSw4TMuDZo0/1gzNs5ET0VhE+6
 GVVvVvEuzUuhwqVfKEFH//UbRG4ZQSbhTR1SUmrRHGUrvthVmIV2XSvxx0XD/2Ex+4og
 HChnvO2OWqeK74BWwmd7LpCGK5Z/hMSjVo+p10OT2KmRYiU4yRbLXPIl5RoTwhHluw0/
 w6ZXBakluK+pk8TpIsgWIYfGlgmmnV2dq0EtYWILHzBaDIoA7kzE5xgEiGeuCvwW2TiT
 y2IvF/Y18GU2pQhQDnEVXbDOxFHnrVRFbHOqDN9d8OjB3m43iceY5KsSOu6UCF7M2sov
 z3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738024977; x=1738629777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6DlwPPFlajfgRhVnHl7DfLUHYhqRSBckd+fMhhlX0FM=;
 b=EzkwTj0nwZp+IdbHweIpGtWm2zsx9zPuDAsVeywodbUJCxX9hcZtwl29dzVuh9XP8Q
 0O1RPDdyl7Gz/5fR6hlDBI+bhkeJXtjBtvclXXKfp708J/vmx029aBql3O/zLT0n2CYN
 ntVNZfzyPBJcozoxMq/kkgnq9QtDo6p6qQOg6iMds4omvbpNgWbZUrTkALtaEwDaKH6n
 Kcq/LCA0dH9iQnhlj0bOKS+J4/AHnOKrWf/7h/2O4+woOBk215EQw7U713ppl0dTM0bg
 rUrR5FaMsELb7xFhkvg8ugMsVblAbLDsO2RmlTS33QmTFWh207/BiP6dN5Di3+usw88Z
 Ic1w==
X-Gm-Message-State: AOJu0YzxydClCfCTwJyVq2UUtFhxRMyEd90OoPxnedZkgr9slAc426N6
 V5AlOA1ekpZZdOYBVCVK+e4LSOVVw5N71IQgV1dlR77H5fKp2N3dH8MF5ZqCxiYN7cFf5HLfmaL
 Q
X-Gm-Gg: ASbGncsV1oV6vbhVcRbSVLgbn5YX8r+hBcwu0akpj0EK120ZuB9/T+IdpYiWhATQzCp
 W9k8jzwHQYMzc8kKM9e2mT7HpROGbkKKC6llxurlMhZAFVkgutOkkaXBMNs4gcZjcFe0ZPBVHbt
 Cs3a35jWDmGL50YQib4IQ+may6ojc8+q5poVT+4zsN/bXi1lOH6jrYx9fbT3sDpEYbK2Gtd9Xyq
 2UZU+NABDuk91SzH6eP4xNvh8geC8O2vWo0pNqP3gSigmk9VFibtQfrAm2IG75+LLCv2U/ZGD5h
 hpBXDUX6GD6DxyFQPumph793SkQOw54y3M/5dLk=
X-Google-Smtp-Source: AGHT+IFqb/hi7TPIQPQazOtjU4uk7/QzfAEVe1aMV2POSr2uNTRnWHp1gd+Xi4gYr6lIj6LRKZtvBA==
X-Received: by 2002:a05:6a20:b3aa:b0:1ed:534e:38b1 with SMTP id
 adf61e73a8af0-1ed534e38b5mr11893296637.41.1738024977339; 
 Mon, 27 Jan 2025 16:42:57 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78e0f9sm7791026b3a.158.2025.01.27.16.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 16:42:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, peter.maydell@linaro.org, stefanha@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org
Subject: [PATCH 0/1] meson: Deprecate 32-bit host systems
Date: Mon, 27 Jan 2025 16:42:53 -0800
Message-ID: <20250128004254.33442-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Time for our biennial attempt to kill ancient hosts.

I've been re-working the tcg code generator a bit over the holidays.
One place that screams for a bit of cleanup is with 64-bit guest
addresses on 32-bit hosts.  Of course the best "cleanup" is to not
have to handle such silliness at all.

Two years after Thomas' last attempt,

  https://lore.kernel.org/qemu-devel/20230130114428.1297295-1-thuth@redhat.com/

which resulted only in deprecation of i686 host for system emulation.
By itself, this just isn't enough for large-scale cleanups.

I'll note that we've separately deprecated mips32, set to expire
with the end of Debian bookworm, set to enter LTS in June 2026.

I'll note that there is *already* no Debian support for ppc32,
and that I am currently unable to cross-compile that host at all.

Showing my hand a bit, I am willing to limit deprecation to
64-bit guests on 32-bit hosts.  But I'd prefer to go the whole hog:
unconditional support for TCG_TYPE_I64 would remove a *lot* of
32-bit fallback code.


r~


Richard Henderson (1):
  meson: Deprecate 32-bit host support

 docs/about/deprecated.rst | 8 ++++++++
 meson.build               | 6 ++----
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.43.0


