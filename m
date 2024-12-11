Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67288E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOVc-00029i-VR; Wed, 11 Dec 2024 10:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tLOVY-000294-31
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:20:12 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tLOVW-0007sY-G7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:20:11 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa6647a7556so81224066b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733930408; x=1734535208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkFMQ5IUpPXHbUyHcc5o274RRCN41gtiFzl1FIq7oKA=;
 b=JSTNBM59CGpXNGcUuJnUF/XJXDo4+0xzeZkLv37XI4FARHtkaqVAjWIWk0/Stg4E/9
 aOgnjz1c9NFTYf27wH0n9vXVvPqlJY93CwGTLHCJdRsd8+YIZDPLBqhWAHbWOzfPlfCr
 TFEiNukWKHgG60qk+SDOHutq2yfE18JnX+LqHvUzlroX+wEkhA4quctIbS0H5spHlP4P
 uahiAIFZydTsaV57oRS62DTiX4feSRPNBwBdjMUQ0Rw38bT/T4lboFqCnjsFgNSbDMw1
 eSZU6mgGL6NJDVpVKphy2cLE8FREq0/yHFp/C72r2x922fXyO4GOkWlhDTQ/oHdPMR4/
 CmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930408; x=1734535208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkFMQ5IUpPXHbUyHcc5o274RRCN41gtiFzl1FIq7oKA=;
 b=GeXrZCrowT45wD8LANuAF7O+VpB2v8GC9QkOOooYQighbErfYrxQlSHVw+U3BC1EE2
 EjOf6Kb/N5CuZ9NAcSMzawpoVlNwWPhh7G+igdYoyXQflflKzsumQTL9F6HOzWdrP41v
 DjCk/apHvRtomrlqmH+RNSQcvCXRvwORFB2l22g81yWooihRBNpclIfWxPWIK5BrYxUG
 PqrhhOEmfDlQT+R8ebLaBLEyuPX2HmTibvaKxUYrviwujC/o1DzbzTeZMnqB3dkMHHzC
 iPYDvCf2maDytf43YI+2sfm1LUJTQ1/3nZ9qniEuCCj/rGe66ULeWRBkwKP20jAnf4Vp
 IqJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz9yyjioTuv/CKReYwOS6A4VwmunXGZFoffQ2mV6ccZYiNJXOAbvYOXwSlqcuYETWbHASqM//biBof@nongnu.org
X-Gm-Message-State: AOJu0YxdAV/Bn2nmlju7pG0M1ShxZA0JNApgUpc4CPBRpcVeaRlVNy/G
 a7K3Y3U4up/CUx1bsv75zkno/99lbOPt8U6GYBll8y1MAvAbFh1y
X-Gm-Gg: ASbGncuZWVC2Z2rI/1NO2pqIX6QgoPLpbam2OYlMot/L6QwRmKgg7oZmapS1wWZ9PGa
 LnsobhIhxsFd3sj4o9RV1TQ/nyGao4CGnOav6fuB0UD4ftU+I6i1MMnq/IvzJwBLfHzPDJerXMi
 tCj1bWZqaWs2tCD2hd6bCxirSqU0zDKklDpGraMeZjQPITbn4GEnz/Ir+vN8TmKQCpvE6yBOmva
 +hfTKpA/NH1tPDfvb1LcWY6o3cFoyQ4GD21lBZiuKTYEEM3wh/IkBSmtNifqqBorctsDOBsujJB
 EA==
X-Google-Smtp-Source: AGHT+IFniHNB3d5VodLCMHX2y/JoROaYvnQ5T/ieLIwv4D9dZNuiudd4wfdXKEJPEURLlfww/9B0QQ==
X-Received: by 2002:a17:907:3fa7:b0:aa5:3e81:5abc with SMTP id
 a640c23a62f3a-aa6b10ec75dmr133000566b.1.1733930408163; 
 Wed, 11 Dec 2024 07:20:08 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([79.175.87.218])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-aa68ef79bcdsm431454166b.205.2024.12.11.07.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 07:20:07 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: rakicaleksandar1999@gmail.com
Cc: aleksandar.rakic@htecgroup.com, alex.bennee@linaro.org, arikalo@gmail.com,
 aurelien@aurel32.net, berrange@redhat.com, cfu@mips.com,
 djordje.todorovic@htecgroup.com, hreitz@redhat.com,
 jiaxun.yang@flygoat.com, kwolf@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/4] target/mips: Enable MSA ASE using a CLI flag
Date: Wed, 11 Dec 2024 16:19:55 +0100
Message-Id: <20241211151955.88016-1-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112164130.2396737-5-aleksandar.rakic@htecgroup.com>
References: <20241112164130.2396737-5-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ej1-x632.google.com
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

Hi,

A kind remind/ping on the patch. Before we send v3,
do you have any comments on this patch?

Kind regards,
Aleksandar Rakic

