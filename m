Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39A5CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVur-0003gn-Di; Thu, 30 Apr 2026 14:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wIVuq-0003gP-8M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:15:12 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wIVuo-0002Xa-RF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:15:11 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8a0ac5c1f70so1046946d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777572909; cv=none;
 d=google.com; s=arc-20240605;
 b=BSPwtgatIkvDMUHcogj8Ez+qXq3pCW9CfI7XTD6dMtBTSuE+Doop+V6EkpKSHsrqAN
 zuxgyv3HGTDSnyqKC/snQRxs4hmNI4shU8a+YFu3+z6LGfDg0D842oA7yZljGjWYgMUm
 2ddQIdsM0fyFe6zNUpqQAk1R+kSh6Lt8yw93C4xKYO/kn+ms5l41gipZojLjdMVTiWQ9
 3ckSbYnyuAVAnw21zPGYkd0FIhI3vuvPrR/Mzvyye8oC1anE80/qsT/NURMExq6eb70y
 Z2W9fJNxFb3kIb7bb4xx0ejcci2VzBQBSC2UtW1T02vj4lDcKVVwgNduJx1JLX3ozi20
 5YOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
 fh=lrmPJ0Yto0CZ98BsYiLmCZW7N+RxTbMi63WegqQblAU=;
 b=MYfqkA7bK9sicObw465kNYJcJ5bC+tsqUhNnrVzas5iVxm71WqQ2l2DXOddSoxmWn5
 zs1PlgHVY/XT/ydZdG2dTV01q9nr/xJhe005I0haPaMdPIn5OBG2KiE6kKoBWAmZ7lTb
 4H/kFXmFMKbMu+bKvonkEeq6Gf+jITdQRUO/EFfp8xb6LPxWUbQ+HVLKgp3bW1ieQThG
 eOSW5rcMRBTFDpVE2eklJBmojbwdIpr07uxICN4zWqhNuZB3x9IWY1wvack9irfPIBRb
 GJsVgwxfZHqQmxBrGJbGfTyyUMGAyt7c+V7TLcTkPGnMVeYMADKSOC1R6G0prEfCM477
 Ja7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777572909; x=1778177709; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
 b=E5hbQcy+Rr6VtKDB3wUJKoRjUu4T6JC2PKvlqBlydztIDx+6mZL/iuc9eW93sgA8A5
 ctnvnbJCKhbFKTRL0yQnFpKfzOW5srxoSNMN2qOJVrXQXHwn6G3NtMWf2tNydLU8fbaP
 614l+W83PwCclfHj8jcK94EuyPKN8872HT+Kigmiv5yAY3nps43AX1DWX3kIjFFqmk57
 4l6LkhzZrod7vUaaO92GrFz1dDMd+DgUXpU3yPzn0j9beVIAsr5pMJurLgw+U1nKNARC
 NNm2g6odDyDxfarnTNi+G9DOR3Srrw/RRqyw6ugV4/UhVId9hdfACvuvFunYQ5bOxx7f
 cHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777572909; x=1778177709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
 b=miBVB8vD+hGjcCEq+hf8PaDrVw3mqQmTxSMc4+4RBdDAaGhNt4+BhdnYtxKUgEXvPQ
 gqjNOlm+E5oaxHNhz64lEfvBC8Mewrd/nEUwtAII56+dQs+babnmfjKT6jMfMbxptrlb
 m/aMWuq3ujYxPB0SUkjaYuv8exJzv7CR59YzahaAfyTIyOUbY+Dsmk0SJ9B0pI1wzZrg
 GSf/buRGX3ekpPbOlCna1pMqEQ7u5Mh1pNWElwm2Gu4qMxRq0toha9NMOHS0dFbp6pI8
 c/CxPZJPTYhzIiS2t2MYjvwH7r0YX9TJx+Xz9LUompYf20fgRTCHO0xSyfY7vcT8YhSL
 I1gQ==
X-Gm-Message-State: AOJu0YzzZm/bXm5aLpeziFWxiY7vuCqz2T3Qp2m6+YARpQw0vS9Wtcnl
 ywi3MtERVwUt7YeAyJi0qwijiIiaLDabfna8Ys7TwrDSJ3wJLxsuOEEH4NEugWTF5UdUa/s2L0G
 BQ35WPeeVFQexjPiKOIAPQDm3ZBj+SRc=
X-Gm-Gg: AeBDiesAlyv+sYNTUqe6rOAli33wBOEOTxnqd1C5fs9dvi/OTEYt/RNIJrWq6mOGRhY
 8oyd/KfZUfPUTMLzfEOm5bBMDsVflu2YrT7LinPfR9MDBG9+v/HEG1qi+UxLIre3eelRVpARPAK
 7BJfB7nOvwzbkk4VBDdRZA/QXXD3n5WD5LeNcmqcm1QTQib1xQaQcC3g+JvwcK3p9rdVpg/BoSX
 ZbmeHg9+D/5onv59wdn8x20av3OxQPhhf2EUaq1nABTcERMYJvRI6XSTCWHZaE9QPKV35He+WMi
 V41fIs4IhaHlx7U6gU8=
X-Received: by 2002:a05:6214:e65:b0:89c:c7ee:fe96 with SMTP id
 6a1803df08f44-8b3fe7d1d5bmr37284396d6.8.1777572908585; Thu, 30 Apr 2026
 11:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260225180555.154428-1-danielpaziyski@gmail.com>
 <20260420173816.63673-1-danielpaziyski@gmail.com>
In-Reply-To: <20260420173816.63673-1-danielpaziyski@gmail.com>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Thu, 30 Apr 2026 20:14:57 +0200
X-Gm-Features: AVHnY4I3626fpItXs7zvnEnHnXEcxIgXc3eo2ivifZEOBHsQKWfOAfW9yvI5I3Y
Message-ID: <CANukVxuz3feJuiOV8s3oCYb0PrE3p173mLSyzRGdkA_7haGeGw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/intc/apic: mask LVTs when software disabling the
 APIC
To: mst@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ping.

