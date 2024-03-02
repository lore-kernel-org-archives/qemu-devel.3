Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23907C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjI-0005MF-2d; Fri, 01 Mar 2024 23:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDpi-0008IE-8E
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 20:06:34 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDpg-0001ps-O7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 20:06:34 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so1965871a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 17:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709341590; x=1709946390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2QO7VbaGpkM1A+w8n9HY25Mk5OYKhiAwexs9gwOfuVQ=;
 b=N51lODTqHyC9xgROlhQnQnJhQ1J1UWcqx4GWDM52qQWyMI3/EPQjBAu61uUDIDLDi2
 vX6ZX/UphWp2h9vRFaeA3a4sBnI+PqPHnG289Mg8Bin06c0OL9Ol3GjvuyK/+VZ9i0oo
 5R3GHLDTn5FCiobXuUSSN6Tzjh18hBQEOsAUVrT2tugZ86uuTmzDdD0ZAOtgz0Ndu64W
 Pr5hMy5oKppWoUzdy4vzrvZufgs01iu9EAp37aQUKCekdTn1/iFKwuoT2Hb5xuKQ+MVa
 XjSznQaRoctJXtzDgP3ToeE4oukgUwfhWti2GgK2+Sj0yeCn01Nr4eMvuZf8h0qTJIql
 hCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709341590; x=1709946390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2QO7VbaGpkM1A+w8n9HY25Mk5OYKhiAwexs9gwOfuVQ=;
 b=JqQGrapHd0jwe+2bNIaUEvJOfJejOtUuSA7FUTWe10svOUGQPTuhnT85D7k68cTV1y
 6OjPl7RlVa/BsAwik47tkKMeTs3mkHrSas8UAF7eaHt975KIhfokdJlhJmo685B9ynMN
 44mzBwY/Lyo5GJ8PMyCcPgLPvVtS6vinBmuqD0QuBQ40X8RusBe9zZzwJ0VI70fvILYw
 pNHHzzp5ERliWS3HIlU1EORfhIq3vOvbseXzcObEp+/HrJ/sGL9dwec1jkkguIMogzyY
 IyXFWdAvVBgp5G5JwX7qejGOxmNbNKJspmlFG6ypB093v2UwZBU9vVDoQ8lO81u8DWIE
 705Q==
X-Gm-Message-State: AOJu0YzYI/NfsDKpJ1oUVMxXwjB7Qk+yloBDBhKBLM0jc+/JJ+DdpLlL
 PLIR9Oujh+FCali6nstQ5F6ecPrkh2XkrKu05rqALicKbs2cO6NRe387uviP8NUllxB4bmU+8Yd
 H
X-Google-Smtp-Source: AGHT+IG0w4Tz5vM4FsjTFoB5WQf12zcnzCYlUz5JMemr2Pjy99fd49zFU0+sfEU+Rmh75Kye/glNIA==
X-Received: by 2002:a05:6a21:3983:b0:1a1:44bb:da3f with SMTP id
 ad3-20020a056a21398300b001a144bbda3fmr1131879pzc.53.1709341590338; 
 Fri, 01 Mar 2024 17:06:30 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lo21-20020a056a003d1500b006e5acdb5c94sm2399881pfb.176.2024.03.01.17.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 17:06:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 0/3] linux-user: Implement some prctls
Date: Fri,  1 Mar 2024 15:06:24 -1000
Message-Id: <20240302010627.12998-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Once upon a time I marked these TODO, which apparently
meant that I inherited them.  :-)


r~


Richard Henderson (3):
  linux-user: Implement PR_{GET,SET}_CHILD_SUBREAPER
  linux-user: Implement PR_{GET,SET}_SPECULATION_CTRL
  linux-user: Implement PR_GET_TID_ADDRESS

 linux-user/syscall.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.34.1


