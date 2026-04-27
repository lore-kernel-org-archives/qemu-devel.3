Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ABDFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 23:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHVHY-0000WG-MQ; Mon, 27 Apr 2026 19:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wHVHX-0000Va-2C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 19:22:27 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wHVHV-0004fQ-IE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 19:22:26 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2d9916deb14so19058002eec.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777332143; x=1777936943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b6xf/kF/rSSXc9pPyWscRobbFDLcz+Fus8ef/OByOuc=;
 b=B2bcS9d5fhocVTN9g7O5EghScVxcF+ahaZiGDLwlYDBRQQsFjkPA/e5vjPykwRhlHh
 vklGSmOArl160eco+u4HmGo7HtrhCy3IlJ6RPuCr3YppVm/fWhXCLCGKS77uvPwWtfjJ
 P3TpMa8P5Vx/0seaVvfOlH9mrNqLTKJq3Lur2nIkHSGuOS5tf35bDHbKUDRVAcwCW+NN
 XZJBRMfDeY1+U2viljZetp9WLGRuGu0kYl/lc/DIhudaJhUjAHf9VcPqv5DEP/aguvwp
 NFDu4oMobUoTd/XOetI9WX3rOtuhpPCpzoiANYJ2GWGRf2Qa1UIi9PfY+Iu3Fj3TxNjX
 RRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777332143; x=1777936943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6xf/kF/rSSXc9pPyWscRobbFDLcz+Fus8ef/OByOuc=;
 b=dxd42CGqCLN3YIxMVN0Ev6RZYxW4HqFBBKqig/uIlq2TQf3EUXJgpq1DovkLNDyu2s
 f79kTsQ+lvSctcf7UDTtqgQhq/fPkHsCVWC0COrk01pQiQrgsx1yx8tYnOQslOukahqf
 GFKfp5FLtpMYT2pm/0ZTknSlVhk1nMy8l7klmQNo7IYPjF9zOQG0Cy1Gzz/vijBfOCPr
 6SJDmqY++RDMqDJa+EZDhxtqPQk99jXD8cXhaWQXq2tbJHOtvi8+ap6igQlvA3JYTqCQ
 lu7lfVoKGyMLiv+K06aDie21PNl6y3p4wnN2YkNosBqwqi8LmKj4aLDDlR20gvSkjV10
 YW8g==
X-Gm-Message-State: AOJu0YwfxMTpjxYERj0CqozgTFMIPsf4NajtfeHazhb7KcUcOMNakwv+
 P4iE7YEgV4Rvk7d7X8Odv6ShpDdG7wgrG9rUt7fd49xFAReWCg1Kx2CG70mp5yajjEc=
X-Gm-Gg: AeBDies3odHDL42VDvLs7v1RQl8D/4uwtD5WrfPAgAJX61NRML1nOsIxMV9IZoscA+R
 6erdhfuKn5Ocb2OZ0EZ6mrl/KASr/pEDVMC7Z1SUTBHt8drrCZLTnGPsgjGRNjfbZvSCOz0Mjrc
 t8Obf2KvQVhnvPg9s9UCu5wgZcSaCmXKvBMRgwg02uikY0rhawun1E/bkslbSaf7YyEEClodN6J
 U1y9GcMk4AuwEupJVt4GP/wtZlbVdTEDj5iPhAjj9vfS66Myrf4Ve2CRvRhwg2c2jVa3eLnki7f
 P+znRK61olT2GOY7rnYxVVB0Hd0OFHb7/thYSEckUZyEL+N1Hz4Hy+AQez9nNCf2TA5xTYsD7MO
 pdr32KAMHSMLA2x0A7lwOME3xOs9TKBz3fwOV2v3MiBne0QEdC4BJQgRKeTI8vFVlByEn8/4SaU
 GHFdVTbawYMetvI2v5wWM2wyy2tuCslssejYIfoubONkUH/A5ojVp87lTsBSymPtugkPhcLCx0J
 3x6H61tBb6UB7dtWYZD/xWR/4sW0U8RsydGsQ==
X-Received: by 2002:a05:693c:2c97:b0:2ea:5057:a32b with SMTP id
 5a478bee46e88-2ed0a11fd4emr512035eec.17.1777332142510; 
 Mon, 27 Apr 2026 16:22:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:f4a5:bd04:3ca7:5727])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed0a0ce710sm849973eec.19.2026.04.27.16.22.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 16:22:21 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, "Scott J. Goldman" <scottjg@umich.edu>
Subject: [PATCH 0/2] target/{arm,i386}/hvf: Fix HVF migration
Date: Mon, 27 Apr 2026 16:21:14 -0700
Message-ID: <20260427232116.50586-1-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: "Scott J. Goldman" <scottjg@umich.edu>

I've included two small HVF fixes that allow migration to work again.
I've only tested on ARM, but beforehand, starting the migration would
segfault immediately and now it works.

Scott J. Goldman (2):
  target/arm/hvf, target/i386/hvf: Pass MR-relative offset to
    memory_region_set_dirty()
  target/arm/hvf: Stop pre-allocating cpreg_vmstate arrays

 target/arm/hvf/hvf.c  | 9 +--------
 target/i386/hvf/hvf.c | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.50.1 (Apple Git-155)


