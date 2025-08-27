Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB279CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urD72-0008Op-PI; Wed, 27 Aug 2025 06:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xavier.pujol.porqueras@gmail.com>)
 id 1urD70-0008Ny-Bj
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:10:38 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xavier.pujol.porqueras@gmail.com>)
 id 1urD6y-0006OG-B3
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:10:38 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-886ecaf455aso192329339f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756289433; x=1756894233; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jHOYQU1bi6j/MKDoLXIojGiTfJRxcl5YJOUBmhZl08Q=;
 b=VCgPsHdpi5rKlDUzOZVJy/CMHCGiCVsdMoiVNFLxkazOyUaE3ydnYohERzTRmLKv8W
 VkkiuiRqFalzFiR//V02FhEqGRCttKH8B4vmCYWJ8k8o+bhYp7zOFmv1r4nouBkcIEfp
 J9nXt7w5/G/Kf+411osy/HfUjTArLiRmjCcuJuECyhBEFn9gjPRqYHSFtQdb/Li4dmq1
 72XQQfRprmDpA0Cgm6ti/h0ICzU4oGYujicUN3AVWvE4wwB/zI25rdcpbBbBVPjt1ze5
 ruQOndoO/UAaxys0gvgR5SXA5kDIRqGQtgeHk9rYJcWl6TYq4ycBlhgfgPkaIbPrErCd
 Pa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756289433; x=1756894233;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jHOYQU1bi6j/MKDoLXIojGiTfJRxcl5YJOUBmhZl08Q=;
 b=s3cerbcmETQqKm0RWDPMU3Oj5i153qwVrmNXxQHIlLu/pu35lZcdQROEyLQDI8Vn6M
 3tQ6FN07uWzPilvg6SMiGNclly10ROYsJqzAmkXYKeqt14Kp+/Oma2H54ay5saou0pyl
 YKh9r+lE3qUhXHegBcZC1vcidsDF+rb7C1A0Ukl9hmWe17J/wEbvpc/hM/I7jawgTrFj
 hhzxxaa433N+0eqdFgelabJIKvCxl4wRhKlUbDuvgE+VwArbAtku6bvYgmY5hOg+rmwE
 O4qRvtmACklHxNW7gDKszVUgI11lY1WwbrbK/wCtO2MV+zaY5wdbw1MDXFVKMxjFmwyU
 TueA==
X-Gm-Message-State: AOJu0YwTmAbN4TotmBw0Qf8vmHWG51906Rrp6Vgevf0j4O5UzbqLjdjR
 3BhzByQegProDF6V9Du+oD2CWtBOyOlJeAMWO2sjuyy68CzuYwquDcd9NrS/59nhjUK/4GyErAZ
 T5XJbsY0DN/yJhZhLMucW8HVeN52O0FgQ1wgnnXQWxg==
X-Gm-Gg: ASbGncvTmY7iY8J9edJ7qxKkIPmmWJ/Qm0ROlW8y/38Z7FkYJZECIfnJG+v+9CrO8OJ
 KF8zkVhdUrAbWdbDOmvMHNVr89M10pewafQlbYxt94i+OJtAr56b/CJiFgoUR86JhfZSRnTLDZ3
 dGDxP0o1le6II6Tv06ZqTxWsXVe67zIpDngOdYHDJAim0ZqUHSvtAKoOq1OUtLhXg4R5ybOKhCR
 JWHJ8sxeuXoi62IB7+/+DB33qDTaNLjqynOg5AUMA==
X-Google-Smtp-Source: AGHT+IEDZ+y4S7DcUu6ll9KaCJIlp9q7Dcpbto+pK97Jx+tnASfoFC1648HQsxn3F/opDPx/e36mOsBhTCpgwLcMqp4=
X-Received: by 2002:a05:6e02:1c02:b0:3ee:8e4b:e6db with SMTP id
 e9e14a558f8ab-3ee8e4be93fmr90241195ab.12.1756289432871; Wed, 27 Aug 2025
 03:10:32 -0700 (PDT)
MIME-Version: 1.0
From: Xavier Pujol <xavier.pujol.porqueras@gmail.com>
Date: Wed, 27 Aug 2025 12:10:22 +0200
X-Gm-Features: Ac12FXzYR3C6XGGPP2ZQLpUGfLGqwiaBqUxDm32tABBoBKEO7j2qM7qjZhuITmY
Message-ID: <CAOMVqn95BUdAOvSBCbHS-csybuHbAA3VQFbLivaRuS50qPGjrg@mail.gmail.com>
Subject: Wiki account
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c4e95b063d55ffea"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=xavier.pujol.porqueras@gmail.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000c4e95b063d55ffea
Content-Type: text/plain; charset="UTF-8"

Dear developers,

As I read in the getting started section I'll like to ask if someone can
create me a qemu wiki account.

"To create an account in the QEMU wiki, you must ask on the mailing list
for someone else to do it on your behalf (self-creation is prohibited to
cut down on spam accounts)"

Sorry if this is not the correct mailing list.

Best regards,

Xavier Pujol

--000000000000c4e95b063d55ffea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear developers,</div><div><br></div><div>As I read i=
n the getting started section I&#39;ll like to ask if someone can create me=
 a qemu wiki account.</div><div><span style=3D"color:rgb(32,33,34);font-fam=
ily:sans-serif;font-size:14px"><br></span></div><div>&quot;<span style=3D"c=
olor:rgb(32,33,34);font-family:sans-serif;font-size:14px">To create an acco=
unt in the QEMU wiki, you must ask on the mailing list for someone else to =
do it on your behalf (self-creation is prohibited to cut down on spam accou=
nts)&quot;</span></div><div><span style=3D"color:rgb(32,33,34);font-family:=
sans-serif;font-size:14px"><br></span></div><div><span style=3D"color:rgb(3=
2,33,34);font-family:sans-serif;font-size:14px">Sorry if this is not the co=
rrect mailing list.=C2=A0</span></div><div><span style=3D"color:rgb(32,33,3=
4);font-family:sans-serif;font-size:14px"><br></span></div><div><span style=
=3D"color:rgb(32,33,34);font-family:sans-serif;font-size:14px">Best regards=
,</span></div><div><span style=3D"color:rgb(32,33,34);font-family:sans-seri=
f;font-size:14px"><br></span></div><div><div dir=3D"ltr" class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Xavier Puj=
ol<br></div></div></div></div></div>

--000000000000c4e95b063d55ffea--

