Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DA6D111AB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 05:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7q07-0005vG-0J; Mon, 04 Nov 2024 00:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7q04-0005uY-JB; Mon, 04 Nov 2024 00:51:40 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7q02-0003tz-0l; Mon, 04 Nov 2024 00:51:40 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-723db2798caso271538b3a.0; 
 Sun, 03 Nov 2024 21:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730699493; x=1731304293; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9Oc+yfMD2aY5hBu3Js/0egPeWmhAXhud34lTJa7J+A=;
 b=KCNLJUobU9bdpSWHFh8nsKD1ifnzs3trvB51t/NcF6+3ZcwjJ1H8al2RJNjbdtZJaD
 SEZtJ+sQfM1D6+d7jqkBb/U8gt4PsMqzvsbQcUXHaGa3ovYRZKT8q4qxqgzCPHiGdU5i
 p1ifsVe+a7BQaEX//n8d+U4XWaFTCHoIwiFyvK4MjvHls/X6x03akn1CAp7VczRTj5Rb
 ISpYcejJqgYKahPT7DKCXJ3u9p3Fn3boKdK4jHNdTC2t3uouTgne+6D3zKzmzoxh1sqF
 Mdg3BeL6tWw7LpR2nLYiKiFxvsBoGLcRYmzQAkZ6n0fMkYo8P7SdBhloIrQHbj+mXoKp
 AAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730699493; x=1731304293;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N9Oc+yfMD2aY5hBu3Js/0egPeWmhAXhud34lTJa7J+A=;
 b=gW/RlovumRPxtgG7x8/jzKkKK8bwzMuJVcGQGJYB+eUh0kTicncL5P7fgICPO4R8RF
 0Hy8Hw3ddidgHzxLCZapMd7p8hR3htLpmdyr4iSPphJ843l/qmLBhE4Aj5SCW0e0Pt27
 ZpMoReP6bGQwIFhgwFW6iS0B/OHCJsycZm9+0VPTR/UZHHeIpcWBR07asgxF5xRsMm+Z
 GteRi3XD4NIt+l93zweVi5Xry0exooMztV05LsAMmsTEOEoEmiOv7/KAnt3rcNirN1da
 Y7TBQWLafrbQzC1FWbyZhWCyQrjC7iOQdSZWSFAKHYXZd8HCXwfY9XalnBpqGd2dp/Po
 sFdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYrOgWgqfgZpLSXvNIFWCYhsI1gx//qrfBMcEkowp0Z+7VDnNGRyjQiOe2mhWUe0zBJJ8oM/4REec=@nongnu.org,
 AJvYcCXaclezvq3pF0wzknGj2bUJUhrOb6qIimR88im6ouQpsWAReYFIpRIAe5Mnm9HJwjQ/VZ8GR8gG3WFz@nongnu.org
X-Gm-Message-State: AOJu0YyXHmr07C5pzU2qwCgkc6XajbRIb1ttXyJS5QMMh/O2xLDIX4+L
 IFexwRQZ4Xxv18DnALFqWQ6hhWHMVxeFmG1wmdDcUWB/XoI1la25
X-Google-Smtp-Source: AGHT+IERyTKQZKUYQW0VNt77XOSHxzJ4zw1T4L25s3JOW+Ecg+pslq9wmsnHcJ+lVucnnwy4sgHuUg==
X-Received: by 2002:a05:6a21:99a5:b0:1db:d738:f2ff with SMTP id
 adf61e73a8af0-1dbd738f39bmr4363774637.2.1730699493474; 
 Sun, 03 Nov 2024 21:51:33 -0800 (PST)
Received: from localhost (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb6b0sm6640252b3a.158.2024.11.03.21.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 21:51:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 15:51:27 +1000
Message-Id: <D5D5RKL2WBOS.2ITT02GVC3S71@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Glenn Miles" <milesg@linux.ibm.com>, "Caleb Schlossin"
 <calebs@linux.vnet.ibm.com>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Alistair
 Francis" <alistair@alistair23.me>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Subject: Re: [PATCH-for-9.1 v2 0/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
X-Mailer: aerc 0.18.2
References: <20240807202804.56038-1-philmd@linaro.org>
In-Reply-To: <20240807202804.56038-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

On Thu Aug 8, 2024 at 6:28 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> v2:
> - Cover PowerNV SSI in MAINTAINERS
> - Use GLib API in pnv_spi_xfer_buffer_free()
> - Simplify returning early
>
> Supersedes: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
>
> Chalapathi V (1):
>   hw/ssi/pnv_spi: Fixes Coverity CID 1558831
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   MAINTAINERS: Cover PowerPC SPI model in PowerNV section
>   hw/ssi/pnv_spi: Match _xfer_buffer_free() with _xfer_buffer_new()
>   hw/ssi/pnv_spi: Return early in transfer()

Note that I included this series in the ppc 9.2 PR, because Chalapathi
has not found time to finish the better rework. There were a couple
of comments about style / unnecessary code for these, but that will
all get replaced by the rework so I prefer to leave unchanged. Thanks
all for the help with this.

Thanks,
Nick

