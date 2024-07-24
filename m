Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE50C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYY8-00051o-VY; Wed, 24 Jul 2024 05:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhunxun@gmail.com>) id 1sWYY1-0004z8-Qd
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:44:38 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhunxun@gmail.com>) id 1sWYXx-0002Yx-K0
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:44:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fda7fa60a9so8000105ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721814271; x=1722419071; darn=nongnu.org;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tLMm1ELyqBPoiSzwdhDs85Up6YX4bBiuTbYzpLynejY=;
 b=cSRq8EnPVQkie+TkMa3ALJJJM+/dWFwrSGBsJjrZ5Z1yc3YVxTAvCyhGTO+lGa1LVI
 xAkwWQ/W+eIBJPLjD33Q5bl26dkiSL5OqQ+pxs6dAjNBpdgbEtilONYr0+XFryYS/OD9
 hiWMW6DWs3ROponH+CouJvkj41tYut2e3LE7hI7ufDW0LJnFJ9GxUWkvZkJE0tRPo7GJ
 r+ugtcsA1xt1jeGqoOBovCrFiQ3+xQTCaHymJMsF0H0rradfrhmiO28T+Ju/oCVNJQMd
 0DSrxGPrLvYCONOlBLzs+K72y1q5cGU97rkmdV9PA67lZ9mAI3yVjVo1U6K0EC3I3mbB
 F43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721814271; x=1722419071;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tLMm1ELyqBPoiSzwdhDs85Up6YX4bBiuTbYzpLynejY=;
 b=YsgFCpnbZ9xx6N1hsWxpJaFrJ3XcRK5EOmJSWyc3Zpg2yYjC0CMUByUFEXB6ZRrUqU
 /eaStr20XwW24wZEvAyfqfvFT9olKHWRtQ3ZxLeU3aQt9pwdVtrFVjRKfXd97CKA/4pi
 RJaTth4BprmS1q3GafVKi/XJTmgglk3GIRdLVjqzvnrzyg9+T6AJyA0XXs2rqA2OtZyr
 ULxIjCrWIQQhRJ++OSU8CZvvPqb7FdW6teCjmdywHGdLAuYC91kIp0pk3ssOX2c8Y5YT
 Wmrj9TDc3pKQVRipw5yfTfb/zI9l66baGBZsH0jA6Wzr7QaW23q3q/mb89WHtUGfmBlD
 VoJA==
X-Gm-Message-State: AOJu0YxAp8VFz6Dg5nFqONA0TdvKF2wdlzhmo0hdbr6syRTQzrRcxFW5
 uBuIY11dMvMmYo5UiHPMmBY3I81oc250DfC4bZrHsLxHE5MeuB89IQKI3w==
X-Google-Smtp-Source: AGHT+IEn4BXPQ4xyu2w5i1emK8OS+mSAd6gLqtGPijvVCL6e87tknYls7Tmtnv+uiT34X8z0KYGxug==
X-Received: by 2002:a17:902:ef0f:b0:1fb:7435:c2c7 with SMTP id
 d9443c01a7336-1fd7462543amr143963035ad.57.1721814271508; 
 Wed, 24 Jul 2024 02:44:31 -0700 (PDT)
Received: from smtpclient.apple ([203.208.167.148])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f28ffd0sm90107985ad.72.2024.07.24.02.44.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2024 02:44:31 -0700 (PDT)
From: Hanjey Jack <zhunxun@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Questions about  pci p2p 
Message-Id: <164916BB-8B04-4160-B619-239C993ED265@gmail.com>
Date: Wed, 24 Jul 2024 17:44:17 +0800
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=zhunxun@gmail.com; helo=mail-pl1-x630.google.com
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

Hello, I have 2 qemu questions:
1.  Does qemu guest support pcie  p2p through pice-switch if I =
passthrough 2 device which under the same physical pice-switch ?=20
2.  If qemu can support, how can I config qemu cmdline ?=20

 Thanks.=

