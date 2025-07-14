Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9B6C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubITS-0002Tl-Bd; Mon, 14 Jul 2025 08:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akshayasankarr@gmail.com>)
 id 1ubHOu-000129-PQ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:31:20 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akshayasankarr@gmail.com>)
 id 1ubHOn-0007qT-NH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:31:16 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5313a2566f9so3762018e0c.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752492665; x=1753097465; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xci01p+bdv9GczRaA1Szy6g2SQG7ExcQewr9MaOHAdM=;
 b=WA6Risp8hNBgehKsTaHMXcWROBoohWUaO8bACCQs2GFiNwhnJZZ6JWz4M1oYLaXO4t
 1rvqPVh4mnZK1EkOvzLz9fn0xGoPMx7snloNaaBp9Fsv/Ogm5wsf/Lnt+VJMaefDrgxs
 4dXf7Ef/M9WIV8Kgt7nMTiOj0cNdsvqlvtoyII+U/fNZGcUvQqjVdxy3NWvnCI3WJg0a
 2s+I7V+M4UcFV3uj8Zd8FpRWbEBKiIBKqBQBzm2Y8qGlU+u+aOVBqXYsmSfvOHh/cuXu
 x/asodAua/ng7sgLpQeBVCCWeW4P0aO/CgUGKBFKBhMGCtCE+Z98vy6Zb8CgyBoWMCXB
 vrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752492665; x=1753097465;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xci01p+bdv9GczRaA1Szy6g2SQG7ExcQewr9MaOHAdM=;
 b=Yw4idYsB6DgjkC/nGeyvBFh4dQdCVTo4daeDHSXRpjzJgyT1ia/+Dx5808vCOQW3pa
 /9TsJjgWmHkx/UwYNgUKmRdbK2ER4UE0LJFgI5KQN8KEFh+BJPm3SUqDzdBYxB50TXwG
 ON8ZaWAD9iC06+WB221j1MW2Vd7neVG+qmlyJlb63MAm6mHWnQafOzdzdwv+KTVFdvvv
 3q0TOuwgNV/rZCKroq1E4KAZ3NcoWFCinsaq1yF5hFbp/4S0FETggc5yhJKkBrjVOoMZ
 g0GP/PgGW3xh251XtoknqkAZom1IomyDWO4vyV+ir7eIexSJqunK0vcHuuIPIqZD5wQi
 ZPfw==
X-Gm-Message-State: AOJu0Yx+93nFxVI2y6pZYmyjdCiJL3YD5h5qChOqPkbN1G0p+Oagiaga
 WXjl6fmwwZVHKb+9Mv9f2h10LH+evy/tfZqs24xkoxNKk+5/WyHAbHoIBhZtTSrEN4Z53TygS/m
 4yZGHMpBwwOswL9io3PPbXaGFKopYAYmiGGs5
X-Gm-Gg: ASbGncvLtqaMzJWaBnzRIMjun9gG4IEsFBclZd8yZIlHK9C/elZ689QaqEuz7P6b/25
 glRc59YGZg+pu30tX6AaLQ9+9P8xclkwNW12uauFkmUZw5zBFxU0zGHcvl8FLWS3mmnJ6/jCngv
 hJh9Sr35jlJKFiqk5LoNuwt7V05r/iKukOVJTFHXgsKCFty1Dy0m8FupSa4TKwFOYDGBaZZ8FIy
 nVv9B6aqxvb7DmMhaMdFFRxqT3ugHVEl4LF5GyRsw==
X-Google-Smtp-Source: AGHT+IE6ILSLZOiCb0ATFdyYVBKYrhXkayDSVvoxBDAuTk0omuGak/gqiwGSLpVuPsHv0Cm2cyh4ihW/nrkVtjLu5Mc=
X-Received: by 2002:a05:6122:6609:b0:523:dd87:fe95 with SMTP id
 71dfb90a1353d-535f4a02e12mr7061571e0c.9.1752492665284; Mon, 14 Jul 2025
 04:31:05 -0700 (PDT)
MIME-Version: 1.0
From: Akshaya Sankar <akshayasankarr@gmail.com>
Date: Mon, 14 Jul 2025 17:00:51 +0530
X-Gm-Features: Ac12FXxfszG2c1BQ3fIV0hdMGaqJ75touRdoq3GrgfIva_2zb2s620tSbmv6_VQ
Message-ID: <CA+A3OQ3jcS=r0n_gEMAxrtTDHkCjibL9SPWY37WDBq2tqC-1SQ@mail.gmail.com>
Subject: Regarding the TODO list for contribution
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c92df10639e1fe91"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=akshayasankarr@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Jul 2025 08:15:11 -0400
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

--000000000000c92df10639e1fe91
Content-Type: text/plain; charset="UTF-8"

Hi all,

we would like to contribute to this open source community as a fresher /
less experience, and would like to know about the small contributions to be
done as initially. We have hands on experience on embedded, c, python and
c++.

Kindly guide us if there is any TODO list.

Thanks and regards
Akshaya S

--000000000000c92df10639e1fe91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hi all,</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">we would like to contribute to this open source communi=
ty as a fresher / less experience, and would like to know about the small c=
ontributions to be done as initially. We have hands on experience on embedd=
ed, c, python and c++.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Kindly guide us if there is any TODO list.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Thanks=C2=A0and regards</div><div dir=3D"auto">Aksh=
aya S</div></div>

--000000000000c92df10639e1fe91--

