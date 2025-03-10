Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892DFC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVUe-0008Lw-E2; Mon, 10 Mar 2025 01:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trVUY-0008KJ-Kh; Mon, 10 Mar 2025 01:15:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trVUV-0003UX-Hs; Mon, 10 Mar 2025 01:15:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22435603572so30166365ad.1; 
 Sun, 09 Mar 2025 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741583749; x=1742188549; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqscwxC1/15aB95zsPv13agbtqon+y4YdpwoAPcCFSA=;
 b=QLn8PyxJ9KHVJsYgvEas6hVxrRtUhond9a9usp5aymyFUpt2tneX1R7Yo3WDlUnUhj
 cvYfVGKUujlkbbaa6iqFd0K5FLAntP+NKvgfhVJsWBvTf7pSinkhZC5aQEm9ZmaEtSjx
 C9vl7ThuH7/tcK/SFRWSeRHNPQ23uvXucx+3MMS7zFQW24VU/xFVfuvJO9Fe7SBb7FQx
 JQK9raJ5SD/YHZgB697aX0ejr56d1xY8vVfCsV9728lPtj6xMvZbl26blIYiftYaoY5x
 sG3jw27/wom2fJ6C9r5jZB1Y++WOa0JVpGzIIE6zBFYKWu5Oikw+hdE0C/Gu+el0t5w6
 OEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741583749; x=1742188549;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LqscwxC1/15aB95zsPv13agbtqon+y4YdpwoAPcCFSA=;
 b=U+oNRqYMGBVJ/u6mAsu9TCaPTjsE/egpnvn5MRds65QWCljbzJO9kp7pIzl1cFe7N7
 6kXXAQtaMoac7znn5kWHY7kvp5F0zqLZztyiWV7ycQRr77PNyb0C22AFvdKiC3qR0N1I
 SdMReNMmFgJLJylTe6YPWPr9F0ScJ4Ch4mCMqB+CMecR7FiOEgtPJhSFvahNgRr6DkWK
 gB6L24Hg9iVkCIDWCo8NXKvfDyyo2nPBA+nPTCXQ1CBd4R7idNBEAo0Qd3HnM5OFyj3+
 z7M032rErGaMBNA9LrO3b9ZOcpCKtwheQKJ86Ovg20PC0SJXt8ECkDNNKFc/lyBzAJ+s
 +cJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjbbHpqJTFTuh2BsdkjMw2TLwsRZavfDsNLlGCZWTf0UAszGSLmIjL2k+K2ZSKoN4UGDzMKeLm0tJ0@nongnu.org
X-Gm-Message-State: AOJu0YzzJpMTotZxf/RyzV+KoYa3uIcpyWt7qvrLPqrFD+Fumv+oclHe
 Z1KVHoX1o2jFH+viHeD4ThiLp75TOr5swOsGQZocvEEA+h2qjaBH
X-Gm-Gg: ASbGnctEulKeWZJZciPG3mMoUwvW7qOztZhFC7DEbQFA7WdoFL341YJj6aLaLb1p2sP
 c7rKMYtqnwngzymXSpu6yQ5mzxCqFcwM+sYw8G5vlZpbEKGXQLkkcxuHSpEAGD+7q4E7ZVa9jfD
 0ZG1zYcff8jfGbyQ7xopZ6qaP3IbVZvWsHbp8h9sGRApjKpIT9R3a/GoZW3x0IgvCij/9COd547
 8TrDDuSgXE0KE1kYFXNmHLlnXfLSrzAv4ZeZi1I8D2lEGgeXPRxWN2z/j5ryvpp/7NKa73uxf08
 zFXf3vG5fmCOd9MtSq29EVoAxFa8TnKmuFU/MexdMqtNOGe1pWQ=
X-Google-Smtp-Source: AGHT+IHH3PkWapUOIGr2oNEYYoFDeCIX3A24N5mvUKuFELe+ltYRTTb1vHO57amuSMDqGo3A/I89gQ==
X-Received: by 2002:a05:6a20:4393:b0:1f5:77ed:40b9 with SMTP id
 adf61e73a8af0-1f577ed417amr5358072637.40.1741583749536; 
 Sun, 09 Mar 2025 22:15:49 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af40411619dsm4311417a12.14.2025.03.09.22.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 22:15:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 15:15:43 +1000
Message-Id: <D8CBWUFRY8SC.3QZQ4P3K236GE@gmail.com>
Subject: Re: [PATCH v2 11/14] pnv/xive: Only support crowd size of 0, 2, 4
 and 16
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-21-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-21-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

This one got folded back into the crowd matching patch, so I
will take that version but LGTM.

Thanks,
Nick

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>
> XIVE crowd sizes are encoded into a 2-bit field as follows:
>   0: 0b00
>   2: 0b01
>   4: 0b10
>  16: 0b11
>
> A crowd size of 8 is not supported.
>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---

