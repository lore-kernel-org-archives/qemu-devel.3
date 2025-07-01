Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2803FC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdOc-0006Kg-7m; Tue, 01 Jul 2025 11:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhtk37@gmail.com>)
 id 1uWdEC-0000Kh-TJ; Tue, 01 Jul 2025 11:49:02 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sourabhtk37@gmail.com>)
 id 1uWdE6-0002SQ-TL; Tue, 01 Jul 2025 11:49:00 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e81749142b3so4488019276.3; 
 Tue, 01 Jul 2025 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751384931; x=1751989731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRGeOnXiKk3UNLg/JISGg2y/jFiiBBoZUHa7JQ5/NE8=;
 b=bRUxWygqb19whbTwkNJpro2LxwTV8w9wtqsmUVY5y+61SmdPIS4aQzE1gfip+Rifxr
 dSRqKLqJf7R4a+VS0cyEuwFegyeyLkfYC3Au0x0SDVEKivNsmEj/S1GwmOnzLN5dDkCI
 txYQpl2Gl7P1wgRGCK3UoUrnEiXzpjpHaxs0SdzKtjAj68yn3qRFrcGIXbkkjWalalHY
 as4grnEeGTyYilrSB21sbwqeD6EBwTKbunFTDQArW0vcdc1EHwZjmzAKoUlZlRm8F+kR
 fcG2gkPALBK7qV0Yi1CGTw6t9UMjRkJWBOLddjYPNVsx8nrFiPiUuqnqZuDVCBiSsBDO
 vxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751384931; x=1751989731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRGeOnXiKk3UNLg/JISGg2y/jFiiBBoZUHa7JQ5/NE8=;
 b=OVvOUh0cizVsmzxiedf5G4o5e6xk9polSj7pSiAYScxfmmaR4ZanQlS+SqX1lCvnHw
 HiJ1u+ormTMZKUnBrqFJTrF7X+sN8KlIqmdzkQNUc1PqYJhgKsHTxdBuDtWKKoRebbzp
 zw0jvnWx4uSK8XRHybj5Iifn30LyyK2c8k2J5q+yG8HWhLZTI5nw7m9sxCCxmaHjbUDB
 zAEx8aBMpKAmHQt8s2mqv2EbEc0NSEEpXiKhLEVQehP1DOeMBj6TbzQPx1zPFDiEAGY+
 eYDjOskiRev1vrKYx6j9VQ/c6/PcazrgHWVn20jaGvnlrk6Ooj/GUwcWOXJMf3E3Diex
 Zrpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0wFW36nxq5oUhrRabe2rrjRLYQiOUjamQoyYZ4WU0uAKdoAGD/VJQtYwkkZb1UBfTVZjQwJ5WHcKsTA==@nongnu.org,
 AJvYcCWHmy7Mk0MpPWPZPfVvko9wbdgasyLtveI9hEn+ZnjQnMLkm3YxuFu5GatjUwzjSbCO/S9z7q9XcjS2@nongnu.org
X-Gm-Message-State: AOJu0YyGuDTH8DVKaBxvc0lL2wqLI5zNjdSQJOGTGUgKOGnbA2I/gqel
 Q8FNEV6v+/N7hewt5GANvPZdrtFWtxqZ6ELJChTEtgWODV+IgiWU5tzD0XeFFu3hsaZPLloLn+m
 64+ZVQWH+JvhW7LLaNmKCigdO9jEHhv0=
X-Gm-Gg: ASbGncthJ6gbSAYKjoo5LEBiQv5VI2fQEid76kzeGmWmQdLc9oA1nu/FKqcTe+M+naM
 p3HhyPeVlGMCYqvyRsyEhACj351CLSwmN3t43IyXFHQon8WdHP6qB89e+eiEfNqfWMcOYF4Bjum
 D/eKE9gK53w72Fdr5OUpzV/JcWPXTT0NdbhJjvfaxu
X-Google-Smtp-Source: AGHT+IG+DyxCD84w4aVceGLSnOjZYsQCaCHaAc4+2MFYdHW5KF5DwHdbWotdgnXlOR/TdsPItnLvV8F3+CUULSnAIlQ=
X-Received: by 2002:a05:6902:2ec3:b0:e87:9a73:ce60 with SMTP id
 3f1490d57ef6-e87a7b0e10fmr16014760276.11.1751384931314; Tue, 01 Jul 2025
 08:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221108183352.9466-1-philmd@linaro.org>
 <CAJSP0QVdQ=wTtgNVDChzu5U1ww3SZAa2HfXjuE4z5uOnFeT_bw@mail.gmail.com>
 <CAJSP0QVZ8D59AM_tvgHzdhqF6EUefUgmyD9WMtfPUD=nn54v+g@mail.gmail.com>
 <898348ed-a9bf-5e4a-d389-b60a456ccaba@linaro.org>
 <ZYSr456CZ0p_X9wv@eldamar.lan>
 <63af6d5b-79d7-42a4-9d74-ed533c383a3d@linaro.org>
In-Reply-To: <63af6d5b-79d7-42a4-9d74-ed533c383a3d@linaro.org>
From: T K Sourabh <sourabhtk37@gmail.com>
Date: Tue, 1 Jul 2025 17:48:14 +0200
X-Gm-Features: Ac12FXw1DJ_xuXEFCcr4aaavAbFl9qrh_2YEeejwC8vSMdY18fzd6A1W9EmkRWQ
Message-ID: <CADS2XXpNMSp6RimrM8W88QRiXHNYHPaSfqZkWeVBTLqVgF1j5A@mail.gmail.com>
Subject: Re: [PULL 0/3] Memory/SDHCI/ParallelFlash patches for v7.2.0-rc0
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, 
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=sourabhtk37@gmail.com; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 01 Jul 2025 11:59:45 -0400
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

Is there a way to reproduce this issue? I have tried with the
available reproducer but it doesn't seem to work.

It would be really helpful to improve my understanding of qemu and I
can help in testing the patch-sets additionally.

Thanks
T K Sourab


On Tue, Jun 24, 2025 at 6:43=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 21/12/23 22:19, Salvatore Bonaccorso wrote:
> > Hi Philippe,
> >
> > On Wed, Nov 09, 2022 at 08:43:19AM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> On 8/11/22 21:57, Stefan Hajnoczi wrote:
> >>> I've dropped the SDHCI CVE fix due to the CI failure.
> >>>
> >>> The rest of the commits are still in the staging tree and I plan to
> >>> include them in v7.2.0-rc0.
> >>
> >> Thank you Stefan, sorry for not catching that failure sooner.
> >
> > I was looking through some older CVE's for qemu which are tracked
> > still unfixed in Debian and noticed CVE-2022-3872 . Do you happen to
> > know if the fix for CVE-2022-3872, the dropped one above, was ever
> > fixed in another way? Or did that felt trough the cracks?
>
> Doh... You are right, this totally slipped off my radar :/

