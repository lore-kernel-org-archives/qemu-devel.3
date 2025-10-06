Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B02CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5i5j-00030T-RV; Mon, 06 Oct 2025 06:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1v5i5h-0002wz-Cy
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:05:13 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1v5i5f-00056x-16
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:05:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so2606454f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1759745108; x=1760349908;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RpjllKbLo8qaaDf2tjapMYvimhTJcElqNmiDIkjl/o=;
 b=B0IOSpdNhRel4CPRRrmlRxXOM3cduUE2MNhR+JvzN9sJzNVtpp874VOJGFzqhJpvf3
 ep/QBXF1HOyfGi0a/sJ3fNPhlpFXj8lTM6gW/wII4hsZ/ULn6gOiAboDSn5P+4rU3iYD
 rQIut2sW2D0b7cg4pcr1VCYJRi5ozBZTa/MVbVWzbt4QgfDXnx40347MN8pe8IkJucgi
 qIcjavBdbvPwKv+9o4iwMXFiCu0EViAwvEaYH3smSvuvde9kf63MXVatdLQQ3TlQPaMf
 1z1bnx9KdxqLL/WcjTU7Vf4Tx5mt3PTTxXtoZCPqNAnhYYg5NAy2y6TLO2omEHO+NsTu
 ZdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759745108; x=1760349908;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RpjllKbLo8qaaDf2tjapMYvimhTJcElqNmiDIkjl/o=;
 b=oFBI4/Zv1LryADPcQqL2ArDsVSdzz1sVoeRvwu60ITIBTxnpcKUsuvyM3nSogwmO1m
 aaDgqUXrHsYVe+UGQUpFbFxm/k17urDoF/JEgoZ8N4hInHumofjFoInvXtTLFLD0aXcL
 QF6VAtli1Yevnf/UUwuH1T6HoS7SsBHVM7zbxBa6HElFxnxI8cLdK9nxIhdwmXQYd9s5
 Qyk5NhvButQ+UmarnONZ0zE2cojEhoeeBSbDKqNPUsguFKMQqC8/7msFX86B5lc/0oSW
 4icQ6hn2uFor+HqWK0r8o5tsGh1yqoBUkcCrLbtljgF67NUiPEMiibE3OgBk/GP6iCVi
 uvUQ==
X-Gm-Message-State: AOJu0YxYNu6B+6K0CAjmZdEeTy1a5e4aLZgifUqeCQ2p7VT5hRv6wzLv
 9PjugUN88D+76vvq7UgKTP/lxnuQSZr3TnQpKwTvSovUC1joHXewPlzzvPdeb1KVUiY=
X-Gm-Gg: ASbGnct56ntsYqslPvYP1zDyiE1wGx+55A5VyH4tfwHrnoguQ28Ncq93/u+nQXnNK2h
 GJkCW6XK9ayEKHY+lIGv8USGoJXT1imL2IxlBzgXczTrqqwMpHXPrUU0+kODucHD54R3RtjhJIb
 aJQYVJzflwz9aSObBe/4JU5Gl+a9yaRvx2kEqfgf9jxJbsqVSEZ8AcjEMHFfcIIfAy+0meOpSr1
 5s/cNpGn98oZHOM4Ty8CPpTh+mQujV9dXcQupq5WqMUcC2t4v8VNCsbz5gx+BuLoUUKlhEOn/Gu
 w+TKk9s5ObLVnSBOstRSzKwJZ6WW/wLUj/1A7D0U0qXpx6ikdpoztd9YIMOZvDjAoLJQhSq6Xxz
 EAj3q8gquTa9W0upVe/zZYjpEnSRvZPsCXs41gHjzQTdnW16p0O+3lNgPAMyuwcPIfKk=
X-Google-Smtp-Source: AGHT+IEenVYHLqv7WB18pd7gWMDR+ei7FwI96DOtAn5GR0QTEJNSpEKwSxWyJ8ordITUHAyd6bKomQ==
X-Received: by 2002:a05:6000:184e:b0:3b7:9c79:32bb with SMTP id
 ffacd0b85a97d-4256719357bmr7636238f8f.44.1759745107987; 
 Mon, 06 Oct 2025 03:05:07 -0700 (PDT)
Received: from smtpclient.apple ([188.25.252.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm111334185e9.0.2025.10.06.03.05.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Oct 2025 03:05:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: qemu-system-aarch64 hangs in a cortex-a72 test
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA_h3-iWubDg++jcO6_S_o_Z1-Xm4RMHqLYq8T=1naADug@mail.gmail.com>
Date: Mon, 6 Oct 2025 13:04:56 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <84A761E5-6FF2-45AC-883B-AB441E3894A0@livius.net>
References: <9EF1806D-4C25-4980-B1CA-16616FA8E32F@livius.net>
 <CAFEAcA_h3-iWubDg++jcO6_S_o_Z1-Xm4RMHqLYq8T=1naADug@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
Received-SPF: none client-ip=2a00:1450:4864:20::431;
 envelope-from=ilg@livius.net; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> On 6 Oct 2025, at 12:55, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> Notably 9.0 is the first release which included
> commit 59754f85ed, which enforces the architectural
> requirement that when the MMU is disabled unaligned
> loads and stores must fault.

Ok, this is a good hint, a loop in an exception handler is a very likely =
cause of the program hanging.

> ... (You should be able
> to see that in the -d debug logs if it's happening,
> or via gdbstub if you put a breakpoint on the exception
> entry point.)

I'll try to run a debug session and see if this is the case, and fix it.

> If it doesn't look like that's what it's falling over on,
> you could try a git bisect of QEMU to pinpoint the
> commit where it stopped working.

Right. Hopefully this will not be necessary, it must be some small =
stupid mistake in my code, not detected before.


Thank you,

Liviu


