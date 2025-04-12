Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20BDC369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 05:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3THT-0006Mv-2A; Sat, 12 Apr 2025 01:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3THR-0006MU-Bc
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:19:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3THP-0001Ba-SG
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:19:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso2561036b3a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 22:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744435185; x=1745039985; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpkPaOaEpw1G6HeSFk7Zuci3HjUQkoatM1/iGGPErhk=;
 b=H0mlDW4v5G6IOCnpmoOF8ECAxdoYvgzdBV1CiS4CduxNZn1cObvtHbiQNYVqIrmmAQ
 +bi9VGh51ckxz5p76J807wMqUxZfkBVJ38ikk8jeGYEApFi59u0+20yfGR5+pHR7mk5W
 DRmT3RCbzOFrQz0SXhMxMWTSfiAPi9hNlL65t5vjP760WP9jeT7D/IkqkD/50gm95W9l
 RArTFzlZNEKgE5VRESDs4eYKYIeX1aXfZp9wAruvGbMq4ua0TPU5BvVm/OeSiUyvxyGP
 huRgHSLqnHDLtRhkZhn63E3FiC6L3OPBU90E0fATY7UCiB+BISigQU4I/+HqqaDsxyh4
 CXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744435185; x=1745039985;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cpkPaOaEpw1G6HeSFk7Zuci3HjUQkoatM1/iGGPErhk=;
 b=Z0zuh6rOK0pV/zxxt6zjEm8+ppf6tcM0BToPslww4SGe/EPVA6vS+K+tQqRFDrgOtB
 53TK36C5MlzbYi9V3/8OBGc8kow0quQd0UbZKP+9khl2VwZHXD1irLxUz9DRoF3TbZis
 G0Llm43VGVqHkzp2Xn9Sw2A5TRwwolMmyK84C9gn8ub3z8uX0wEiGHpHkGLLZzR/vRA3
 s3x7DyJo2WnkkaO8ANQhRpaXNuGvLayGGZ/UAGVNZooivfhPlIjo6m8nwFakQtczAOFe
 MOVtBwnwq6tY3vSXaHkt7XAFW9Orukj/17dMuBKQ4J7Hif+ztXNVs0SeiDB3uud3e5TA
 c/rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiwSplgXvxDWARksh8cUE2VKHt3QSV+V3eap/2nIPRpPcZLb4TcJn/KQ6a5l0FIPUefQsxr3qq+aRN@nongnu.org
X-Gm-Message-State: AOJu0Yxa1qVB5sFcSOJVHTpLAffa+TPL0hNB7hUjED44TorrqKQ9rl5T
 GJr81cMD9objPxYSXe8BANP7TzgiJxpTOyAIl+fnJRbO9IUTdY12
X-Gm-Gg: ASbGncvmO209epNkyEQQvkRV4vIYGwl4uwcbWRZagG1PjmA45umBoNhCaKyqqNPxrNO
 Bn5pznc/knRAmfXCZBUdGImDXo9+HxBqZlRk/TKCpf6Z+MRCSHD4gbXcBtTOF4WzHyiIo/S5V+s
 eEGXovTV32bMWPe66XDTcc1vUrFJ+Wkrwf4D4fX8iTiTWAXKdJcohugyU4tEX7PSKBs1WOZejXd
 JxjyJMWaBLy+Xa6/3CngGSTU75IR1uY48m5dx08lwrUPDupb++43uCy9BgG3ucK3hsNcP7x5HHP
 T+8gXcdiMxncF7O40TuuYchmd7bKtIN49Q6WpNhxJPDF
X-Google-Smtp-Source: AGHT+IE1xR7NZkWT3J9WV/1eXQoy6C5tuGllB3zhryYY0s6t0SwCIENJK1bE7PIfaHwKjX59BGu5Dg==
X-Received: by 2002:a05:6a21:999b:b0:1f5:709d:e0cc with SMTP id
 adf61e73a8af0-201799908c2mr8243138637.40.1744435185069; 
 Fri, 11 Apr 2025 22:19:45 -0700 (PDT)
Received: from localhost ([220.253.99.94]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a081814dsm5833747a12.15.2025.04.11.22.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 22:19:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Apr 2025 15:19:39 +1000
Message-Id: <D94ENUA588DZ.2MMSB2A1AX0KL@gmail.com>
Cc: "Corey Minyard" <minyard@acm.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 0/5] ipmi: bmc-sim improvements
From: "Nicholas Piggin" <npiggin@gmail.com>
To: <corey@minyard.net>
X-Mailer: aerc 0.19.0
References: <20250401140153.685523-1-npiggin@gmail.com>
 <Z-w75P6iav82W5Qr@mail.minyard.net> <D93LFGHCQANR.1TFR56ESHUY1H@gmail.com>
 <Z_ldV8X3AXe1QDFf@mail.minyard.net>
In-Reply-To: <Z_ldV8X3AXe1QDFf@mail.minyard.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

On Sat Apr 12, 2025 at 4:20 AM AEST, Corey Minyard wrote:
> On Fri, Apr 11, 2025 at 04:25:10PM +1000, Nicholas Piggin wrote:
>> On Wed Apr 2, 2025 at 5:17 AM AEST, Corey Minyard wrote:
>> > On Wed, Apr 02, 2025 at 12:01:47AM +1000, Nicholas Piggin wrote:
>> >> These little things came up when looking at behaviour of IPMI with
>> >> the bmc-sim implementation running the ppc powernv machine, and
>> >> trying to clean up error messages and missing features.
>> >
>> > This all looks good to me.  Thanks to Philippe for reviewing, too.
>> >
>> > I can give you an
>> >
>> > Acked-by: Corey Minyard <cminyard@mvista.com>
>> >
>> > if you are working on this for your own tree, or I can take it into
>> > mine.
>>=20
>> Hey Corey,
>>=20
>> Thanks for all the review, and sorry I missed your question...
>>=20
>> I don't have anything further in my tree, I don't have an
>> immediate need for it, it was just tidying up a few errors
>> and warnings I noticed.
>>=20
>> I'd be happy for you to take it in your tree and send it up
>> when it suits you.
>
> Ok, it's in my tree.  I had to fix up pci_ipmi_kcs.c, it defined
> pci_ipmi_bt_get_fwinfo, not pci_ipmi_kcs_get_fwinfo.

Thanks, I noiced that just now too I thought I'd had a config
that built it but clearly not :( Sorry.

Thanks,
Nick

