Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F06C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 18:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpBHe-0003In-Tr; Tue, 26 Mar 2024 14:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBHQ-0003HY-Oh
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:12:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBHP-0006Wy-7D
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:12:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6bee809b8so4982344b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711476729; x=1712081529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HZk8Nee8nJnnpbhedG66t+SSqRk4eS29Ts1AFB5IrbY=;
 b=XvrozCK2ObUCsNzZWe/P5u9kXZoieua6qKkZiFcbDYlqbloKsThmHlZKTJ5Oue5QD6
 fVCBUgZMgBN0Vtq0kDbBB3eV0/yODrfNulNJ/gdjKquQeVKwbE5KEfGJnWfi0NMoa+W5
 XM4POJrsGN/rnDCcczL7Arg1hR3izE7tFG8VpleVPfGRHKIvUJs+HjT7Jf0iF284KqUk
 WH5Li17MZXJOWR80UKD25ZaH2J26TJnP2adLXEY/UHb+5jyAddoz0CwT74oRks9nMI0T
 eb8uFu/f0+nOhuyredbw7lGPs8n9p7aJGNFXT5xs5Vtxta6VA5TxTK1tsnaOZb1PWuo7
 sSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711476729; x=1712081529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HZk8Nee8nJnnpbhedG66t+SSqRk4eS29Ts1AFB5IrbY=;
 b=HsuFGh+r6Pb1dN71uruk9K7whrw/FM+f9LYGPCDNEWC/Mi8e70ZIRhrKOtijUupTXU
 WH6bh43ZO0nDN+UBNDw8OX2x3SUO3eGSHJLIHZuwTT7/lI5z7NOTn0jVcuKd9HAQsXCN
 Mcd39zaYYke9Umd71g9E05zNblmCqTKjSEsM8gOEZyaIBMP4gWdk6mMsEPwxNsnZlZxg
 2t0bjvFKIr/11kdTDbbZ8tHfo2vRESBC0UmqMp9qQaXMgYbo3C19qHeDlhYwLLDHV5+L
 Kwt9bDLN9pYl5MMGfDiSCa2uWrGTWPZFaGSOPx5m16Ft2d4hJr8XZUyXDRlHDJM4qPAw
 kQLw==
X-Gm-Message-State: AOJu0YwReEBVMltMIPDcm+rJd/w/ktptaPBW+925bECzjY2YK8s+74LI
 5j5GzGUpDLsflgSkaWfS10neufFpezV8I10vpVIpI8BnQ5kOwLlCoe4evguT76d91pl7AM5Y2QW
 l
X-Google-Smtp-Source: AGHT+IGXtL0X6exe9MOf0Gf/gKdFoCdayoFdqazHijg0COT23YGnx3vl3R81NYkJxfCbajCJiEqTiA==
X-Received: by 2002:a05:6a20:3d07:b0:1a0:efd0:b183 with SMTP id
 y7-20020a056a203d0700b001a0efd0b183mr427354pzi.44.1711476729071; 
 Tue, 26 Mar 2024 11:12:09 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q27-20020a63751b000000b005bd980cca56sm7835336pgc.29.2024.03.26.11.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 11:11:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org
Subject: [PATCH v2 0/3] target/hppa: Tidy and extend diag instructions
Date: Tue, 26 Mar 2024 08:10:25 -1000
Message-Id: <20240326181028.332867-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Don't do all the decode for diag in trans_diag; do it in
decodetree instead.  Add {get,put}shadowregs for ODE tests.

r~

Richard Henderson (3):
  target/hppa: Generate getshadowregs inline
  target/hppa: Move diag argument handling to decodetree
  target/hppa: Fix diag instructions to set/restore shadow registers

 target/hppa/helper.h     |  1 -
 target/hppa/insns.decode | 18 ++++++++-
 target/hppa/sys_helper.c |  4 +-
 target/hppa/translate.c  | 85 ++++++++++++++++++++++++++++++++--------
 4 files changed, 87 insertions(+), 21 deletions(-)

-- 
2.34.1


