Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43516C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuD2m-0000xw-HE; Mon, 17 Mar 2025 12:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuD21-0000On-Ri
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:09:43 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuD1y-0002uj-70
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:09:36 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7be6fdeee35so823637585a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742227769; x=1742832569; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RjZ9cgbEqjD6FBG4KHuHgodfx5fllrheU0SjlXI8SQY=;
 b=FrbXjDhQKWczz3b5QXftHUVc9iJSGH9Hc9Mv8BZ+XT0LQRgb8w52U5Sg4+tmpgfZRQ
 ZuFHRRhVyj3Ovmwec0bF6ik+QN6RX3DaRLuMeGzzaI/IyiJ4O7PX/6sW6eDf5hGAtrye
 bItJCohfv1MM0/C98/gtw/dvOZzK/lilEJoaqgRViD51KpaNj2BLW3y/Vz4Vzcl9WgxP
 vn50sk+leTJXI+uv3v9ZZRcK81HTuUZGXUOwDGAuYT/fdlS/W/7ziFhITU4lXIA6yTSX
 XVoZFKS9lqpjRg/sdP88k+w/0m36HumrHU7CsNFPz4V8fj8eMmTEdqwn1/x62vXoq7Kv
 YyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742227769; x=1742832569;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RjZ9cgbEqjD6FBG4KHuHgodfx5fllrheU0SjlXI8SQY=;
 b=NbhG5edZdRiNaD7lDDWFKcSkasyeEP/80SThDpmAoQ4ztVtuAwSgGCV7OD82QvCQpw
 vBXrPVsU7VcfNMb9xh7BgUP2j9ZPbb+/QDcX7ItPuhDs+2QFuskPbvFOWsgR/E5arTSq
 fJKh1Wodjo5uzycitOvKn/oM62BqS+2ek44fK+fgFs3rPmHCufemICLdkQGkyhIUXoht
 KC48PVXybG5/ZcqjB31N295VYFwyF25aRxvSUMFGjnpDN8XKdtlRpM1onvaKTlHbW+KN
 8BYWmaKjk9YA4FSu9IUMmyaIo9ZmDGV5tt3FGbR+QtdJqPoecoFMzcI/4ja+5al7FHYJ
 WXTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX73JCQIVLp+iP7EGokhW2/3dgRIMbPQlxEhNYSHOghnWQlXRpAocUdDwzY/hWMBlvitpETD/X3uzOf@nongnu.org
X-Gm-Message-State: AOJu0YwxFh5qAjj2hMz3Moa0hVvVeeebv24u6K0Jhd5v9YAAbNjpZNB6
 T1aHKxiUgMM1QAfNJC6c5NjHNJ7KuUgK03vmFnldC1mLoX+6DjHa
X-Gm-Gg: ASbGncsmX7vhtZwpKZn/ea8o6ATkq2wpwcnTtPX08K603SzuTG+KUc+8elcVVwyr+31
 +SCryl2KkOzyEXsINv4TgotXSvuipy+GrC2ftpkYh/2syKSthbi8bDMobx18qH0xQY1j0LpDAXX
 GGCiLoy7AFdbdZyIZ9Y1gsvk5Pa68pzAqASnoexk6EQ0fGc9V2eO4du5LcPbCHK24AgyFZymbSH
 casDBHI3LN9iyVCxpTim7F0SvVhLAPyBsVtv1wtFoNt+z13e1H6veM262iHk69U3qzBLKK9/2E1
 1v7FrJDutmQkY2lvqImjJipobkLJcpiDwJgAvQ7KnQ8u+4BAbX7LdSDlclS2EhU=
X-Google-Smtp-Source: AGHT+IFRhT2YJQ4ReX6haAC2qGgW3wFnIYiVEui+RCKB2D/C7HZ8NHa7plNK2I268yeDKVx5RD7zIA==
X-Received: by 2002:a05:620a:400e:b0:7c5:6c02:4c25 with SMTP id
 af79cd13be357-7c57c80e2bfmr2194745285a.25.1742227768855; 
 Mon, 17 Mar 2025 09:09:28 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4e8b9sm606149585a.2.2025.03.17.09.09.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:09:27 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-3-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 02/39] target/hexagon: Implement {c,}swi helpers
Date: Mon, 17 Mar 2025 11:09:27 -0500
Message-ID: <016301db9756$f5c7df60$e1579e20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQJSr3yRsu9ySmA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-2, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x731.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 02/39] target/hexagon: Implement {c,}swi helpers
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> {c,}swi are the "software interrupt"/"Cancel pending interrupts" =
instructions.
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


