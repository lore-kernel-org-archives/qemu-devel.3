Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBDEC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTDF-0004P0-To; Mon, 24 Aug 2026 07:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wyTDE-0004OW-OD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:51:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wyTDD-0000iU-Ae
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:51:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso1944876a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787572293; x=1788177093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=89PkCCpOw+bFLi7D2eR9te11PvgGH1BvJIB0HRSCKSg=;
 b=okQ9x1GS08u0vrsf4rYVl8KY/um95hLf7JWscDbVA638bnyPw02VI/1GoYZhvtIPS0
 tAtzU+OGYVII4Wsgx3tnFDhwwLsJ0+SUxAfdUxhwYBoGiXnsEJQ/XGq0ag4F/cldc3gh
 R+GmtIhSQsPups/PBtQ3hk4cRj+y+/QZwfJGuNoB/LrP5n8ITE0pGkMAFzuTQmEyOvAl
 hcP3zfG3Y1OskKyW1VBA2gPdR9r7oOvYD9TqTYQejGZcPzBAeD0TmJOZmPT3WXTSIyt4
 2u+CArHaFU1KR/O+RIVS8WUJb7TOAFAP/+QTaXhqQYEuLxnEXc82c77X3VpKP6WmU9Ca
 HagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787572293; x=1788177093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=89PkCCpOw+bFLi7D2eR9te11PvgGH1BvJIB0HRSCKSg=;
 b=OLSa0J926b9VSOdrorUk67ETLz5mGNFc8BlYSL/qszDyXTej3DEcOel+uZVKiWRUOg
 jW/Nmc1gOmRjWr5OUmszspQMCcJzLiCtagp3V+Md91M1iixnit0yAjrazPNKQxPl8tPC
 y87uIwZsk7oDkdG5mfeqJ0wKDawr5VhhyBJq7PYNK8NTiOp8L47xTBNb7o4s1vSJFsoY
 q5Ack6VcUTSRZDnHot3ffN6uUS/qiX6wGlJIjDYO+4WjBw6QnhfzcYBzrrGGGMMlrtyK
 8AmfP2PWQ2i4HubFzLWq+m9zOeks1ZCihEAOWKQ+AUjZLfhnjcAB9+y5dFq6P8qe4SPS
 P0pw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+wBZb+F56OdC1RfmvUySSS0CTKYpxhxSt+MPaVoeyYIJpsbxcZkiGLjhIH/U6u7bUyTuRJeYzrQ+H@nongnu.org
X-Gm-Message-State: AFuF++nn132PWDby6mIkkdey/A3dKTQMfdavl656ErpC7iNk3eMwNU+H
 +qHrSpRdvznJTHPrxV1I/+3N9Q2qv6MKMtgEjvOLwsL42Onx0X6bEH1p
X-Gm-Gg: AR+sD130yzfCuuuimLxVJzrOtHTdeMQlWzeMsg6kEiKGFTHiJDMpmLvInPPhj7uygOz
 2QwhO/V9QnQW6PcNiQmlgViUJy/nIPu69uCApu0SJ1I2z0FwE1P+Z2b8Nnd62Ax9iOvtQkIVBX/
 8sihbKLL9ir31Y1P3VLXPv//cB2VjNZYzqif82was4zN6gW6PVFqa7LbDt34D+Q+cvU0ALCimjM
 0sFKc9R0KiSbz5lS5IT0PyMrdiWXrPEXrX0Z6GIwmc5aRwspVAqGgHm7kDcx8sX439lozRzv/UY
 71phrG4ihUBtegDs0P5l9Cifz8jy0hiE7ZPKrE+e97H0//mpnuZGS4nEWPq1P6lBO7qAWW6MyDT
 rROe/2O+BFryuko9JQsDaOBaF+8zYE3hji3H0l1dn3/+U3dbptG8ynfjzoHOaHyXcuMdNH4BZlI
 YsqXu6tq2WRWNJoKXXcNxXrM4gPv6UvAr+ecRPi47zCzaI/wFtmUSJbFOIBV5y6cCbtx9PIog8f
 QkFKm8NURIAej1JheMhImjUnpLYG6XddfHrlJhymUS9FrugYm9Liv+5hIufqSVAEhoAr6U6FyLY
 a0s9G/NyPP2w7wHUsUa7B1PwV4Q=
X-Received: by 2002:a05:6a21:58b:b0:3c3:875d:7053 with SMTP id
 adf61e73a8af0-3cd2febf6c4mr48902664637.8.1787572293296; 
 Mon, 24 Aug 2026 04:51:33 -0700 (PDT)
Received: from nickhuang..
 (2001-b400-e2a6-81a4-7c3d-29c5-dd1d-e725.emome-ip6.hinet.net.
 [2001:b400:e2a6:81a4:7c3d:29c5:dd1d:e725])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc199e4b1cbsm976400a12.19.2026.08.24.04.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:51:32 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: wafgo01@gmail.com
Cc: bmeng.cn@gmail.com, farosas@suse.de, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@mailo.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 00/14] hw/arm: add TI AM64x SoC and am64-virt
 machine
Date: Mon, 24 Aug 2026 11:51:23 +0000
Message-ID: <20260824115123.7089-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=sef1548@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Wadim,

Does the current version support booting the Linux kernel from
PROCESSOR-SDK-AM62X?

Thanks,
Nick

