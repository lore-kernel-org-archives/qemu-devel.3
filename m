Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AC2C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp43i-0000aI-LL; Mon, 03 Mar 2025 06:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1tp43N-0000WO-KN; Mon, 03 Mar 2025 06:33:48 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1tp43L-0000G5-Ap; Mon, 03 Mar 2025 06:33:44 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-abf3d64849dso347596266b.3; 
 Mon, 03 Mar 2025 03:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741001621; x=1741606421; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3YWGqCjMsqbuBMTbeQg8hk0RfRKpSHKO91ZYZKobOUw=;
 b=cTXMz/h0vh/U/isM/y9WJOK7EjiTYH7QaXhcfh58sbujxsMOoj5ILMuLIWxvrA7zFl
 FhVRHpYmHxrdpvdq97oZh3oW1nR34s7irqVYEBsxEW51meodGQAINZejqQD0fr4XfM/c
 EW3mazAckUe8o43W3ZgkMW2Op+6LBh7D48bg5F4GfJL7/ixFlIJ9k43FBtT8YgIcmT9q
 5ZDAr5cEHI7s4eqfFVZS0Ha2b4vO+NVDpMagdPqEMtZIzgBw1VZyEhnfFHIOgGgrRMYA
 c0O3DAnz0CCTCnYFGi8Sc2XasSBaCn3bzeVMJid5g8QkbAAwtS3s9jzgtsVfOYk1Sl/A
 x+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741001621; x=1741606421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3YWGqCjMsqbuBMTbeQg8hk0RfRKpSHKO91ZYZKobOUw=;
 b=w9O29SuVyoj5grXWKErDg9frtfnPYdO4cVcwgAEfpLHGed4oqB2xEcN9DfXNwpBzxB
 ieD0SsWgPXzUCKhhinwse8bj5XVzBD9JT+wfLSdPGZ+29bindKw2wOYquyugM/zHfQQy
 U9H3ft6UhHUuUUjczXFlzL7fHjqhfbHBQ/pq3wAl7phKoGjQNkvPhDaOTcS1nOLVzsgt
 kQSK9RD2Wk7gSF0Ck+Ddv71rykkVfr26elZLlMPeUxchE55gh0xbDIJ1co+pTZ1AwGcJ
 2wAvtVHN6boBRrQQWEHpnMUU/qoGbCmRTsGNqOgOvpL2xGBkqZqvCzroLkcp4uu96PrG
 ISZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPaKchvmubmCSGRHKX5tD45VKHVHHECKiyhZ7HPxa87605jvpLGNokTF4OVCYkuPh84j4o9H4I0j+0@nongnu.org,
 AJvYcCW586ZoXwe3BrJszF4pbyluosrh6QSRC8GMfayqeXbQnN2y4zxAGQlR/cncfcxoolcdh9hUzD2gtqI=@nongnu.org
X-Gm-Message-State: AOJu0YwpgUyL7JjmzJNboq6ddNXgSotER8yjp8HQDxs9cioqyeyJrumB
 Lejh9T8KbYV/XFfGcs1FiT7hnMRCvaBDhsTz5dXCwPwnvXdV4MeB5nUrb1Dz8U4CNsn12SkzZ9e
 10pk1LSgnWFb3FfHbROvcG6JkR73Gu/IqJPc=
X-Gm-Gg: ASbGncvvNmhV1xZu/eXolNMGsk9SjT3BLYESAnw0lMLHat8Fxhsk5L1DvNdAIpUw0eJ
 SeRRm0Yoq7Yr3AsyjXQzwIkBlTdWF9ewYa1BxH/2MX5XcxCkRZ8UO9rG1sB88YtFbagkqRQ45Zf
 DDNnraUqTc7htqe6NONit3pTSHcQ==
X-Google-Smtp-Source: AGHT+IFIwufXwB2DulDlJZMLuMowC4rQaKIReyOHX515qMS1soFLYQ3izHHh5l4ALb4E8v17AqjoLfmJDq6WZv69C24=
X-Received: by 2002:a05:6402:849:b0:5e0:8c55:50d with SMTP id
 4fb4d7f45d1cf-5e4d6adc6a1mr36366000a12.14.1741001620427; Mon, 03 Mar 2025
 03:33:40 -0800 (PST)
MIME-Version: 1.0
References: <CANDMsCp3wH3xhEvHz_DvnPbv7NLCdGb2LDaECOG=yJqfKObLkA@mail.gmail.com>
 <0f927835-62e6-a2a8-7de0-262657edb638@eik.bme.hu>
In-Reply-To: <0f927835-62e6-a2a8-7de0-262657edb638@eik.bme.hu>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 3 Mar 2025 12:33:29 +0100
X-Gm-Features: AQ5f1Jq5bZvPY_Y5fwiTdWpZ57gm30IdU3fvBXt_zo3lQetREDose6XkxNdFT30
Message-ID: <CABLmASFQby0KpR646Vp=7JGsw40_2cvW-gFa49f2G3iMCAz14A@mail.gmail.com>
Subject: Re: Adding gamma support to QemuMacDrivers
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Hab Gallagher <hab.gallagher@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000239bce062f6e87fc"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000239bce062f6e87fc
Content-Type: text/plain; charset="UTF-8"

Perhaps this is also of interest:
https://github.com/SolraBizna/mac_qfb_driver
The nubus declaration rom supports gamma correction.
Best,
Howard

--000000000000239bce062f6e87fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Perhaps this is also of interest: <a href=3D"https://=
github.com/SolraBizna/mac_qfb_driver">https://github.com/SolraBizna/mac_qfb=
_driver</a></div><div>The nubus declaration rom supports gamma correction.<=
/div><div>Best,</div><div>Howard</div></div>

--000000000000239bce062f6e87fc--

