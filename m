Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AF4C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYj9-00039L-0j; Fri, 23 Feb 2024 11:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYU7-00005g-W8
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:33:16 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYU6-00087I-A3
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:33:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d9c3f36c2so299243f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708705992; x=1709310792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdAqcPISjCpda4bvmvurEoPcFsLJ6rzzW5hX9Mb98eY=;
 b=AgbuL3n8pwiThPwqLc6hdmujdlbTDNbFajYsGuxMtvnCUnpX5IxCNtvYG2nUJdCDg7
 5iOwlKMXAvLzqW0spI8B2YRw200eazhA7mboGD3R0Zu51xeSa2GuaXiIM1jFCbw0VJho
 IFMzAtPubwu2PydRNCSNN5au+xU2S1h+W5D2ysJT4HzBMukvkCronET/khWFIetF2lJQ
 1GTIe4c+Qt03JROuxWTXsVw3j7FhbweX9KMtymYiySlWYA3e/P+4svg5YU59Z/Akgpas
 NrVDGM49toL2RiFKjI9WB247rZz6zSIABIZ2LwWqLLFsCVTmC0ahzqFWC9GOnCEkPV9E
 OLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705992; x=1709310792;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AdAqcPISjCpda4bvmvurEoPcFsLJ6rzzW5hX9Mb98eY=;
 b=Bk8FXn/MP/cBj/1H3TJFBskESMRELEMgM8LAaREz5loKsHKlbWRxs0HgGGyaWUeMu/
 FGvqZPxFeCrisNv75rtcI2GbfKLpp2TVEDrGGuRM0ZpJIvweNi5nIlm9QhA/Pxjy2DBN
 KnpdRUaP+UUZ3gPZixIyeBATFfrThQC44zMKqfVQJIxJIe5NzZlC0KKYpqN6mVw2dbWQ
 +TxIzbsmSRQhhUKxv9Bp0UCcLxQB9KzEMtylveMnesUeymorc667luDJFZJeepIYLHhK
 Ix1ASae/96qz2UdVF6qgfB41u8qa5xryqg+AcMptbh51DTGqSF02IifRYBzzwzeo57Bk
 zNpQ==
X-Gm-Message-State: AOJu0YyxTh2IeTGzQhopym36+RErq2iD2PT/9mbjrcFnchvBhG8OvVS1
 zutmeFr3p6gUrXTI+kAlpHaFsnU7m465SzwMesJbOvV2YMTVTJEb4hJzkwQr3Qc=
X-Google-Smtp-Source: AGHT+IEZnLDgNVHquA56sm+4tgHOkxe0Ul+tCfu72PxxjAQevIcsEO9BFkYzhDQxj7a60e0s5RaDtw==
X-Received: by 2002:a5d:4802:0:b0:33d:b376:89ed with SMTP id
 l2-20020a5d4802000000b0033db37689edmr39962wrq.8.1708705992627; 
 Fri, 23 Feb 2024 08:33:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y6-20020adfe6c6000000b0033d06dfcf84sm3302754wrm.100.2024.02.23.08.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:33:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E58255F754;
 Fri, 23 Feb 2024 16:33:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Artyom Tarasenko <atar4qemu@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Markus
 Armbruster
 <armbru@redhat.com>,  Eduardo Habkost <ehabkost@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
In-Reply-To: <20240223161300.938542-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 23 Feb 2024 16:13:00 +0000")
References: <20240223161300.938542-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 23 Feb 2024 16:33:11 +0000
Message-ID: <8734tj87js.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
> was unfortunately added with a license of GPL-v3-or-later, which is
> not compatible with other QEMU code which has a GPL-v2-only license.
>
> Relicense the code in the .c and the .h file to GPL-v2-or-later,
> to make it compatible with the rest of QEMU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

