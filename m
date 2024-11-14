Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D34D68B27
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBaVh-0005D1-AY; Thu, 14 Nov 2024 09:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.kusmierz@gmail.com>)
 id 1tBZob-0000Ea-2r
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:23:17 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.kusmierz@gmail.com>)
 id 1tBZoZ-0006Q8-KX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:23:16 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so537733f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731590593; x=1732195393; darn=nongnu.org;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4NWxTU67+y7xbEvR6RI9xd2CrruRv7TdSes4VBcAVLo=;
 b=ZsFkPRs1n5lreG/4GykRwO/ua8IvufK25xIj6yDopcd2JvyMNVbRoeHmHedgriBz+k
 ivtnYsm2YMpcijkCQMGu9TEaGAHEG0NvlFLcQrxOuiL05aOMe/9+vjxyyv3wy+bCCTea
 Ucqfp4MLCjsBOjVRCu8ObsWmicoU+7Ev8PEEfq++g4zVIICOmfuW2Y2mlma//5jxmB3a
 jpAgOy++yR+LnaEI3JEuCX8afqO2Az2+imCwrob/8jOodXVcn5BkQC9SO7pKejqvIjIR
 NEZKdZc3JmemNfdP9B9Gi77+J2llXezRQfV873ywoColJLStyqXxNkwvdIK9M+8noSUO
 gTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731590593; x=1732195393;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4NWxTU67+y7xbEvR6RI9xd2CrruRv7TdSes4VBcAVLo=;
 b=uT0ydwcmV5FWs3lA7iLbn1VWDgdWhHdtFUXmwbkc8LSh5uN9Odv7KXrsnNZsEVpMCG
 Aa99hqI15GA+l3O/dw3Rz7sl5slIZFJ1r2SBV0nizCeEld1DtB/wK7aNO5Yng0E/0Tzt
 ST8pBvm0hWWjX3qfxOWIjay2iilfM3qXMaf2ksX61qg6LhgBDm/5cjmbPOQG9WZkqR0k
 6pKMi7jhp8YUxnPEi0rgbJi2Fuo2feSQOLlrejqeeu6dwTW0CI6u2bZDUj2pIR792lS/
 ACWhn5E3BoxD9eywp9fjWVtrbIlKDrifamNEmYRcrM3eIyEN50kC5okD20x3VFz9QRrf
 s6ug==
X-Gm-Message-State: AOJu0Yx9XUrUfgZCoZklUxAua7AOmjyPcZ0/AUKyfK6//cN1Z1VWvVP2
 PBfimodiYY2l7sTybF+UE79Oyck7Fy/2Fpb9jIpBat+5OiZg8ZYmAcca0Q==
X-Google-Smtp-Source: AGHT+IHRwiNTVK452MxKXFY2NdJXHL5YKyYUDmLKVTcGxbOnrfUtXY082gOicw8nFv4zsi2pE4LCiA==
X-Received: by 2002:a05:6000:1888:b0:381:f5a7:9a56 with SMTP id
 ffacd0b85a97d-382184ff2f0mr2014919f8f.10.1731590593539; 
 Thu, 14 Nov 2024 05:23:13 -0800 (PST)
Received: from smtpclient.apple ([2a00:23a8:43c6:6a00::1e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada408dsm1451787f8f.10.2024.11.14.05.23.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Nov 2024 05:23:13 -0800 (PST)
From: Tomasz Kusmierz <tom.kusmierz@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Qemu agent RAM reporting improvement - provide info about buffers
Message-Id: <937BB866-17E2-40AE-AF78-AFF4EEC7A5AD@gmail.com>
Date: Thu, 14 Nov 2024 13:23:02 +0000
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3826.200.121)
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=tom.kusmierz@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Nov 2024 09:07:47 -0500
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

I=E2=80=99ve tried searching through the archive, but with no result. =
Not sure whenever this question was asked before but here it goes:

I wish for qemu guest agent to report not only RAM usage, but also =
report buffers. At the moment, most linux distros will stuff free ram =
with buffers, hence real world statistics will be obfuscated from vm =
management point of view.

I=E2=80=99m not saying that anybody should implement that - this could =
be a fun little project for my self, however I thought that I would ask =
first whenever this was considered / implemented etc etc.=20

I=E2=80=99ve tried searching doc but couldn't find anything relating to =
that functionality.

tk.=

