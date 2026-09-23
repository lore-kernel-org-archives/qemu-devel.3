Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3714CC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9UEG-0004Hy-2n; Wed, 23 Sep 2026 17:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1x9UE4-0004Bn-Dl
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:10:06 -0400
Received: from mail-ua2-x10.google.com ([2a00:1450:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1x9UE2-0008R1-RH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:09:59 -0400
Received: by mail-ua2-x10.google.com with SMTP id
 a1e0cc1a2514c-97e97e2c7b3so835565241.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790197797; x=1790802597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2jZ5E27TAd+15Z/w22xWfUZE4mFmL95RTG8LK5diRaw=;
 b=aONXwwplHA6/QyPAB/cOD1KgeRGIL+iRAqzS+5WJcYSaRzxcznTcK0grahcdt/lKt0
 siPJAy45WNbDvx6gMoVJqziKlohKENyxOYkpON/OrAEzHxnNbDd30BK0NUqJNSFcoDJa
 1fKnU14t362AycgCCdgMZ1DqK9cV2kSQPX+nW5Q080WoXVh4eBz0TUxfSyD1FTmmpO4L
 eqqr4bWfWw2nqDWlf04VurcrhIQtKTXMAKZZUQDZ1aTya3onsZ1YU15ap1q1+tsHy/AP
 h54YL0i4wRqAtEwDlTq9V6NUKnIAKC9xiJVHqhx0gPOBdtKQ3XFDnGIIaPSC2dPUFiAo
 O8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197797; x=1790802597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2jZ5E27TAd+15Z/w22xWfUZE4mFmL95RTG8LK5diRaw=;
 b=f+8orck0wk4nWDu0jySDc5P9W26kBkRSvTu9tXhhSg/A99O2iWfM+oLLSdXsriK2XD
 OsZNML3don5pS/19A1h8g8my7Mb675fkfvbIoa+Lca00boZYJLoVxHOQiydwA82rvXoo
 7RUz4R8Su8P2404Zn5opDScAGTD3Acuy7uA6ovdkVBE5koUOu6mQXNwxiFXzBLKisWan
 mWVTtVbKhXl70KBEamwmLGbhgWDPhpC9BEaZo5nPVWIFB/4fwJAxEwKqt6j3uqQqG9JA
 BVWn8kGHs8Dx0JDXO5SGxS6rtPWNp3D3zs7aQb0w/0OSBFDyC/4gWG7wgXzZtO7koMgP
 9c7w==
X-Gm-Message-State: AFuF++mnFOrE2pQ82usxAjvdMl67SC55I6sHjQIT3fS0FBvrAy3NwDGq
 9GSvtRAGjp8fGMtZj+je+v+xCeaIXVpsa0P981M8ak2MATEsypFjoW7k4NUq52QVdro=
X-Gm-Gg: AYBFou0wavpOhXlhBrJ7kOMtKq6vUgrIgfxIZRV0rshsTAmYM1FexyqIGUUKiHOslOl
 KQOya+2itEcHk6KefGzsMgkRer9/T8Sg8kwUsxBoY4EQLl5Bw83qGYv56XEFhO50I+Kr9s3COiA
 /ORrXfmf9b7ZPgAdkvh+bAjqj0CZhcdWrq1DEKNE4SZqKpsfHbv9o64LMp6oABhQGIBpqxJhUgf
 UNJJyFOqPixNsLokrrvKMD9YTqUFDxu2Hcu/N5vlbmH38Oc1lzzOPgMjcePZ4kEn+zKFgywwkMJ
 LNsHPF6Am2+jwijwrM8Ae9Yvi6M5uOkyQmf/wYD3TOUSAFFKSbkuGcFOXYarkQV5JJMRHZ5cEX9
 nCNS0K2p4qXJWkhj9jmmX0rAw1bK09Nl+fVOzRCt5mGJNRLLnuVSLHA3+JjRq0suKCoBkm7luai
 NJLWt1MQPO4zlBDja04VrCYA8P0zPJ9CRmm2nTCFCMs9CPhB03K+ZlpQ7XkwHaWoMP/nAgkb3J2
 6ay1KjkwdScjbmWaSKswZg0iuDuG7Z7+7VarDk=
X-Received: by 2002:a05:6102:38ce:b0:7a3:3d26:5c67 with SMTP id
 ada2fe7eead31-7af1e4f2ddamr406952137.24.1790197797329; 
 Wed, 23 Sep 2026 14:09:57 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:8d8d:5fed:813e:d8db])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7af25964441sm455715137.10.2026.09.23.14.09.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 14:09:56 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/5] hw/arm/raspi4b: RNG200 and thermal sensor
Date: Wed, 23 Sep 2026 17:09:55 -0400
Message-ID: <20260923210956.52940-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725012635.4925-1-marcelomanzo@gmail.com>
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:39::10;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

Gentle ping on this one too -- it's been about eight weeks with no
review yet. Happy to rebase/resend if anything's gone stale in the
meantime, just let me know.

thanks,
Marcelo

