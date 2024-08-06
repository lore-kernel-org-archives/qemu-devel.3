Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE838C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 21:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbS2Y-0007W0-CU; Tue, 06 Aug 2024 17:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gkm@rivosinc.com>) id 1sbS2X-0007VL-D2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 17:48:21 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gkm@rivosinc.com>) id 1sbS2V-000897-B8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 17:48:21 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52efd8807aaso1721255e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722980896; x=1723585696;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=syzepl4SjgrdYUW0tFvUjUq1128Ibw/4sc3lcdby8+c=;
 b=jhzyprCiBbE47KUlVJtLgSLrTFNp2RDHLKx3l2nDy8TzxSX4kVwm04uK5S4a3onUOH
 P7CXObJ2zB3RxTXQaKOF4TCjsaLOPvzORudbpeFmnTZRSQjHXW9c1lfQBHD83IbTuXjd
 4ewQRoNUy1zWcx9Xkoq+HPaGO48ukJpj0xl4rSSeg5EmAGrJXSFUwft/b267M+oaV+Wr
 5MRTGx6ZPaAIEw7ICm+3vm+apla+IjwN0qqVvOUQpAhufLL+oGlRDqHwqMfZFQJjaAgk
 m7Fp2Ac+vO48thyiYoH0SbxbUHzhO6UMTbrUYDBODkHEqfz6LPcqi7KCZkpt0H0RpjQ7
 E2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722980896; x=1723585696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=syzepl4SjgrdYUW0tFvUjUq1128Ibw/4sc3lcdby8+c=;
 b=YEcpNqoxaSJqTzua5QKqeJ4vN5/ZtfEGUfPXTO11FayFkD9LmsvHJJ97yluzFLa4FS
 yC7HEPpMR7PidxkQU9+o5eHEubbr8Wjj7KBrlbOWXTj4mGZmeyF8JEVUaMPQMDbG5BpW
 j8qSV99gc3ecSZ3d0P7PBjJn50PIFPpT0EUOrfxjYkqpKoX53MgaM8H43XfXX4L0wKBz
 iX+dvKv9QrMj22Ha6FimN8nbApbWxqFX7oMtgjrtddZUDiKudKXXDPBHo11Yz7APxleC
 /9c5hvtenrND1f1obLO0qcEtaz7twjob7UhFMw6wiNWVOBdXnA/4rkohhITyog15XaI7
 jcEg==
X-Gm-Message-State: AOJu0YzyMUFokH8IJRzKBBgys5OVgYDfNgYxFmTP8fEqESYWKcyWrhu7
 dmlcHa7Jn+TCPlGodxSnSVwak0/N6LqtCvUiK0YSPruhbnDZlJDohrWryF446riYA1mtm9ECUPm
 MF4KX/DhAe1AGzwdLNbB6F+CYRrEbDc/oGat07A==
X-Google-Smtp-Source: AGHT+IHPmXyQDoHUEWyzbMajqiK7GJlamTjPGGlZ6U5PlDj9KBS9uOBPaAp+ErUqNlLdiJZ0tlJv0bzBb6dyfYahk6c=
X-Received: by 2002:ac2:4e0b:0:b0:52f:cbce:b9b7 with SMTP id
 2adb3069b0e04-530bb3307a6mr11520714e87.0.1722980896151; Tue, 06 Aug 2024
 14:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240805161951.2701529-1-gkm@rivosinc.com>
 <87a5hpsvno.fsf@draig.linaro.org>
In-Reply-To: <87a5hpsvno.fsf@draig.linaro.org>
From: Greg McGary <gkm@rivosinc.com>
Date: Tue, 6 Aug 2024 14:48:05 -0700
Message-ID: <CACe4iF2eCFeN7qxfa8Uk_850adb3K31RGSAyxq5hPGRxFrwekw@mail.gmail.com>
Subject: Re: [PATCH] Add plugin bbvgen: basic block icounts for topblocks +
 simpoints
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004530cf061f0ac069"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=gkm@rivosinc.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000004530cf061f0ac069
Content-Type: text/plain; charset="UTF-8"

> Are there any tools that consume this data?

Yes. I will post one soon as a follow-up patch. It takes the bbvi.json.gz as
input and produces a report sorted by icount of disassembled top blocks.

G

--0000000000004530cf061f0ac069
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; Are there any tools that consume thi=
s data?<br><br>Yes. I will post one soon as a follow-up patch. It takes the=
 bbvi.json.gz as<br>input and produces a report sorted by icount of disasse=
mbled top blocks.<br><br>G</div></div>

--0000000000004530cf061f0ac069--

