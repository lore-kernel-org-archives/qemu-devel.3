Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292CAD591A5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRG7-0002Bx-SF; Tue, 19 Nov 2024 11:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDRG6-0002Bf-5T
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:39:22 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDRG4-0003D3-Mm
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:39:21 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cfbeed072dso3850320a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732034359; x=1732639159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6D9TS0nGljTO5XNuf2sVGSDhbxQ6NUF+WSqFo6smIw=;
 b=cCrvLQMhV0fQwb6QpvYykUUsqUhSvzdNOCicvgAE4Rz0nyWcr8ZPLtDpIzR/LgsIbU
 oFP7fuGW7ysKZO5C+3Twuf1D/RWJhiCSJxWyMQ5mlQtSMXdzELHdmlWYVzCzPPpeGTbp
 82pKN43H9ERt3C2CYJoCTHKpR9sdcPF1hBv76WoVzjy9lyICOWzd1/E7K75Mdf8tQRd6
 A1aSAo56g97siRricXj4DydrYNfBH36KTVWN4kxUNrGbv0HozUkmv9KXo+HrogoOvBRn
 YDAgRPSAMb2LPy0qTBgosJopwp1bDTzOlFXjqXcFE/HhvED6Y7xnPL7o1QxnVwTwiE9R
 5hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732034359; x=1732639159;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t6D9TS0nGljTO5XNuf2sVGSDhbxQ6NUF+WSqFo6smIw=;
 b=rtLdtJhBvSCSosPDNZ8r+nHHPJsZk7WoWBLw8HRw7+8r6oHJ5BIbFuWYLV/bHrBQ7w
 8r8C/dwN8yamML5NJ0NLAGTtAblRfYQbZGorB8cGnrxsUvI+pwgKFd9lSTqdanVporyZ
 QZJrG1bxbHaoJC6ttjQJOBanV64wfULnD96ceV6POkE1OfEYTmg4NHMkGYvX4cvCKvob
 G7KYpXwF5cDzDqI8wxZKjhdTN/Fl0V4ZtHoNeWqvignaeuehEsLf3IU45uGK6m7abTob
 COBhVnUtaIha7IKvPTWjA2UbVYv5DTCCanqEcztitrA7RwCnNui41CdjE9nzNXcmtRfW
 /WRw==
X-Gm-Message-State: AOJu0YzkP2e/2lgV7NGJBGr1wSDNBE/EnnHjLll8K1gZawHHvuLoHb/W
 PRvN/7Pri0oNAUiHXuLG5n5o4Tvfpxt/g5IfJe5hpL1PtbdNh3jce+Lu1WCjsQk=
X-Google-Smtp-Source: AGHT+IGjkw7F+N3z/HspWjzjxFMnBZZNI52bzluIVexIVOIg2NGxRrSHRXDrznL6BwTLfDtgh0zRtQ==
X-Received: by 2002:a05:6402:908:b0:5cf:4687:b816 with SMTP id
 4fb4d7f45d1cf-5cf8fd49c50mr12866745a12.31.1732034358834; 
 Tue, 19 Nov 2024 08:39:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20dffd7e7sm665101466b.119.2024.11.19.08.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 08:39:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ADB405F716;
 Tue, 19 Nov 2024 16:39:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 06/15] tests/functional: remove obsolete reference to
 avocado bug
In-Reply-To: <20241119150519.1123365-7-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Nov 2024 15:05:10
 +0000")
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-7-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 16:39:17 +0000
Message-ID: <87sernnpoq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Historical bugs in avocado related to zstd support are not relevant to
> the code now that it uses QEMU's native test harness.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

