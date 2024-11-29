Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F966D6EBFD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGyJG-0005rl-N2; Fri, 29 Nov 2024 05:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tGyJF-0005rM-0Q
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:33:13 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tGyJD-0001UK-I0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:33:12 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa520699becso244647166b.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732876389; x=1733481189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cy9E1tkGPvaNC8VOXWREs1/OqKDZktAvXmcLeAepa2M=;
 b=GOViZBJZ2fnwfJb4ANZu4gNRW9GyLShNP6JfnUxnDImB0gzBXBKU+JbZeUNy9PIl+R
 dbXoDMM0mXgFaCeZaKZkg9mabblotL4YNrtvWAWmGN+ASLLZBY/6H4pxU2GG48E0dZay
 BbV37gm8JFjMOkRdlEZUi3Ibj68bfT3k2IZf67m7TzRz/K2ulZx7YIDNYKGWwsxQpIWe
 pzTR9xyCAEzKY5yYEHsEsp9o8Kfi2aBXGI/48GGZIhLZqI7S9iyNzQi/4uxb0iqrzQ/W
 lVQx2pXqJq8boTP8tJRM8UBJJ2nFQWancxNVq3Z3CfTsJk826f86/rpJ4HSjfWbzKHi5
 hpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732876389; x=1733481189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cy9E1tkGPvaNC8VOXWREs1/OqKDZktAvXmcLeAepa2M=;
 b=Krfa0ZvCWmg/DABjb4FKa6o3PxnDY75nBoEuE/59J2S7v12MzZaBthvzjhmrME8UNU
 6eVl9iALflkK2z7rcEzqxEvRIt5qq8jIs3avE9syWlWHMX2gkHyGs4XprFjbLEGTu+uM
 NzzynjzM2hu2PGyr04LyWrvjNw74Otcz4D4Mcgc6L5NhSTI9fCDphYg20wMyaSfD7Vd2
 A62DsalZvWNLIRoQbFV0mWo37gwwwLOpDapGtBXG1MNc+QtLJWgcwV7SdvdyrqipRVQu
 xxrBFw2pjfgSEbgotf0vB4QlYzazp4wBPmJ0CExmNsq94HUExgynmzEHeBMnEObA0pL2
 QGqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKoqAF7kEdOVtkEDi2bX6kmUzLFwSdttBXQiCkg2/IffUXvSq7MC+sb5qjUpnRYIj9Ha68YNOmzRCm@nongnu.org
X-Gm-Message-State: AOJu0Yy79q6P0CphfEg8kJlRKX4jMOO5467QD8lR+kJR6yV6TJf7fFzt
 lJF6HPDaNFJAUYlNa6Dil0U+6CFpP+HgKvo7TJDlq65xops2I4Fx
X-Gm-Gg: ASbGnctvk9EKv6YFcp3yp5/kcdNJymCS3dPbwDrC95AB9zYfJN/yxqkMCmCpFixcSgC
 cB1x8l5XaDQIMwD4fQwUPHDpZs5YSW5Ei3XUaNRDlftroqvdVUw69P8+vaigd3e9p/KQyb1KlEY
 4BVPwYFcgD5dHyRNRTX28zMDss8FFaLKgl8SM284zpKzOC30M8FCOlTyk1HgKgAAZWJX0lFX+dB
 B77/t7gaj6A0zEp0GAQCA3PWo4Fe830PmmKR4EyS+X/2dmfQWYHWXZUTIM=
X-Google-Smtp-Source: AGHT+IHPsyFb3QgYHQZqaDmBhTe3vTFOA6lVb9ds2uPNkMdmCkKdDB1vnisoVQ7txx9Tm3w/j0Umxw==
X-Received: by 2002:a17:907:778b:b0:aa5:485e:b7e1 with SMTP id
 a640c23a62f3a-aa580f01b78mr933193566b.16.1732876389287; 
 Fri, 29 Nov 2024 02:33:09 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:4166:755a:3476:5f1c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599953c81sm160300266b.184.2024.11.29.02.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 02:33:08 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] chardev/char-mux: tweak mux bitset operations
Date: Fri, 29 Nov 2024 11:32:37 +0100
Message-Id: <20241129103239.464061-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62a.google.com
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

Patchset tweaks bitset operations by changing a constant to unsigned
long, introduces a static compile check and simplifies bitset operations.
Also resolves Coverity CID 1563776.

v2..v3:
* Multiply (sizeof(d->mux_bitset) * BITS_PER_BYTE) to get number
  of bits (thanks Paolo Bonzini for noticing that)
* Rebase on latest master

v1..v2:
  * Rebase on latest master, incorporate review tags.

Roman Penyaev (2):
  chardev/char-mux: shift unsigned long to avoid 32-bit overflow
  chardev/char-mux: make boolean bit check instead of find_next_bit()

 chardev/char-mux.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)


Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org



-- 
2.34.1


