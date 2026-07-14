Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BDAC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjhXT-0006yM-Ox; Tue, 14 Jul 2026 14:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wjhXS-0006y9-6Z
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wjhXQ-0006NV-4K
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784052441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dLs3hG2GiZXkQgy/Xllhir4nGb+PU0Ye8IaBvLL5RWzbQS3aQ4A/uiy+j0s901eAHj4buR
 QS7Bobfvu3Sfutg95dg0fq7p15HWmKacgud25HLj2/mI2XFTjGU4l7Rta2jwiluWtI/cGE
 ZJsqe6COv8BNDtbZXN+1GuKIHHgP4XE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-3KT07xcTMMyoinsn-TtaDA-1; Tue, 14 Jul 2026 14:07:18 -0400
X-MC-Unique: 3KT07xcTMMyoinsn-TtaDA-1
X-Mimecast-MFC-AGG-ID: 3KT07xcTMMyoinsn-TtaDA_1784052437
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493c526df6bso11180695e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784052437; x=1784657237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=fjHlPbHuQywrgdYXa7K5QN9xPFYYUe1URCjiLid3N2FjVGKo12eXk8SVCDPy0syAka
 SaVdCiSoJ0FZN8Xvnpb0axNGlW1gNgr3/tDq9cpjH/liQSWKtZOp7/X1cljOBD8iX4GO
 ph0ycntWfVXkEB7Hqz8/Hnzsx+1v13I+HfWAlGv6ivYvxMod4BmyvV21x69Kx84mlIS4
 nZbjKPybeAr1kJvrvibsBfJbovDkb41DhiJwtzfGv7eHVX07sOfgC9RV7365JNLJe4uh
 Acwyizo9mBb+IE0KxYlGDgKQ1jSaXQkFMGUOpAlohMNh2Vvi/sJRzFTZvTU6GsuhV3iH
 8LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784052437; x=1784657237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=U1xq/cxVOFnVT0FG2hHAXUr54vgN4EEy1AI5lRooSSQ07w85jjuIAQuBTVb3CyedfN
 2t3iwR2g5PXvRdCBV2ktZ4PTbRr2s1k/AFQhK2tkXijrVRdPxLNS/x1E3uQoep9g3xdn
 arWXXnl/h5dJutQsV4W0IcHSTHzggsk1Wq+K9PJOOabxUbiLfxkirZq7y7GLmrxnzWDt
 rsJLvEEtCa3BMf3hmRY54YQuPXM3Y+XfuYIhwKwXtRygBUnc5+UceVUq/zlVn0eXMB/L
 aVzqNci1bdwUyc3/ZCZ6sdsMoMg7/qMg7drndsLVDcUNbqY7sD06f/W+FlRxjK6Md9x8
 U8SA==
X-Gm-Message-State: AOJu0YzuuPiMDhQuBrI/Hr2WvIM6hZ97d6+35oG7eg3DdxO0ZhmvZ+xR
 iXInXCWVcjEGoN1VeeHStOg6AMGljUCPUujr13QalhmWMjvej/P401xX32xrqEYhtTGzHMcWlQJ
 bmlZyeg1alomPPaB9aI7STUTnjiOSIXUypq3+vVV+dCRE5VestEOS/aM+
X-Gm-Gg: AfdE7ckwDFwYJfIJAGYZJqmbXorrlTf47TfkCSLI3CSgfhli9kSNJ/wY5QzUMtOgBlJ
 XSWem3kNqgOkkITM9IK9vRcSnwdTKnfJF0FktrC9FO7FDshErkWogZ7jW/Qq/lwyEz2DNpl2v6O
 BOiG0LyAMdDT1OU1C+ZVbf7/mdpkzv///nLVcl87rCW7U+m4tYV+Nsv3rM/XmmXGNE7bp/Ro7NA
 tx6nxkXog3iMTZLjlnRUyFIbGMqy/oVqqrxWpOStE+YIOSaM32hGnEmK3g0XVReFaG9vtz5/Zlc
 8LJ2LcvSh3+Yq39ry5Ds+pm+foA94AD+8NF4AT5iq0qLQkGpwqEJh5/Bid9TMbxHvDjbliiQOIz
 /dNw2uM4p6Vef3QY2LpIiyKINRP6Bdp2MkHQSNboD2wH4XUM0f5sSQnCcubjILhskiEnVfLlsmm
 UGLzz6mbfchgG3NQ==
X-Received: by 2002:a05:600c:b90:b0:493:b967:178d with SMTP id
 5b1f17b1804b1-493f881d05emr151984735e9.19.1784052437076; 
 Tue, 14 Jul 2026 11:07:17 -0700 (PDT)
X-Received: by 2002:a05:600c:b90:b0:493:b967:178d with SMTP id
 5b1f17b1804b1-493f881d05emr151984555e9.19.1784052436742; 
 Tue, 14 Jul 2026 11:07:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871d1bdsm91541055e9.1.2026.07.14.11.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 11:07:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: propagate qemu_ldflags to Rust link step
Date: Tue, 14 Jul 2026 20:07:14 +0200
Message-ID: <20260714180714.143726-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714021236.2361604-1-brian.cain@oss.qualcomm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


