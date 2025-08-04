Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5714C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiv6B-0004Ig-VC; Mon, 04 Aug 2025 09:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uiuO7-000585-Ja; Mon, 04 Aug 2025 08:34:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uiuO5-00043E-P6; Mon, 04 Aug 2025 08:33:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-24041a39005so20379155ad.2; 
 Mon, 04 Aug 2025 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754310835; x=1754915635; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7NtjfbD2pgCHSCu2rH066aEMn5TsIl+KswjmUSt3Wk=;
 b=I2Gi+Sjm2+s1lka9lW4tWitqwgNdaM+W3wXIuxM34gmyKrIuzRMCa1i4+cCNtRXmwn
 5yJMnrH3ltHb6Q+WabTRLrNY24907Y214lL+2NLH3C5YvmEBBumBdKG7Ioyg2RiYlTm9
 nvlLIbnxZYry0zx1hVk/AT4WcCpqw3vjwNAEeTYiPlfZqUwNPO0QqUf+/zIhT2dDP+tQ
 uj/SczCaJkUbrABMiOVy9GAKzLUHYiIGRR5AL3eLb3wrXXF92hmbUhrnLCf30AfTqhnP
 c03agfnO+tp/zkva3UF3D/biLcA03Ml5wcqS4H33m061sPRqGWSOHmUtKTDSPJkcu59t
 liIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754310835; x=1754915635;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B7NtjfbD2pgCHSCu2rH066aEMn5TsIl+KswjmUSt3Wk=;
 b=LjPafZT8vdpYIlKweJPTd5c6mWZqB7L4Y+JcDAJ+lkTL+Liyf6a/N9l9m0pLLkDy5W
 kpT5qos+/p6bVIj3Qc6Jppv13RLP9bml26om35vtq8XXNhGdk6Wu132VNZdCAOyRPRrU
 tPbKukN8TPNrlNTORp04IinOdEl32AcTc+F0Lus/LGlTdreYz76/o0rDBnjCGjmYzxAw
 4v19pQhPF969c8H9GxaZKn94B9d6KGxxXTnxcd0sqG2gyDb1ZQDAijSNcWzDo1Epiwqt
 49FTsAIx4pxApogYtcXkvTMg1rNgg7H6qISW+Wl9trH9qybZ+15BIFuUDNkr7N0GSGqd
 3Grg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDKhNC1BZz8czvw1MagIqVa41tn+Utzz8c5iWxvcusIi1+rx6ctgYJS+Isi2Aw2QNDPt2RlnNq7YUq@nongnu.org,
 AJvYcCWaMdLTRmN64sxVOKj4wFDfRvl2B11+miAaNQ2pQhnIV55+f/x7iwBEPqzzo2bnhYKPJtkrvPpoBx0=@nongnu.org
X-Gm-Message-State: AOJu0YxejnuJoXa5JI9pOs1YK+e4sNM043po87CFkaLuYg4I9qAwQMBf
 6dS7m0YT2sz4fXKM9aaFHldEvng53EMQiii0eu7ILyWbgfiHDeHFUJX/
X-Gm-Gg: ASbGncs9l1UXasVZoVErE3DgoAaKwe7GC0iMVgtXmtP9gl4sg1ABl//ruYBmsrbPLxz
 h+dhdMPcKqak/3lT3CAhqrAJxKPQz7SpnpzUgYIPBsUhnxghcWB9xuxxz89Xk8peFludY6fPwa3
 v6mqSnzmh2mH68zHuECo1BSyAAO2D8PKk79cRPFDjJ+vs3enOLyVaF/9/K6EekvHBtEjgqHx7Or
 E9bGugJMGCKc5JrdwScmJVUGa/MesC3/xJHMxctk3oDuxcpfVIo0+ZBlyUVmuFw8l9BiIvmNW7W
 1xlBxcLQPzZRh/9yXtLHCa+aigFUN9TbvcVlLXJrZbMGPaVJvBPhRWZWxETLv9LBRGlhhBlv5hg
 WwEWul/3jPA5ptRDPSGsVNpZ2BwWHP0riafGRsObpsfCsVkBH/4Hh5Kc1OCaGihL6
X-Google-Smtp-Source: AGHT+IFIkdxgH9TTycHi0x+UeSJbhlQARk+iVmpNvlMSJb1BHzA9jta3ADKPXYXvUbJZUDTpU8htUg==
X-Received: by 2002:a17:902:c402:b0:240:5523:6658 with SMTP id
 d9443c01a7336-24246febadbmr162537855ad.29.1754310835033; 
 Mon, 04 Aug 2025 05:33:55 -0700 (PDT)
Received: from localhost (123.253.189.97.qld.leaptel.network. [123.253.189.97])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d21dsm107764555ad.139.2025.08.04.05.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 05:33:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Aug 2025 22:33:46 +1000
Message-Id: <DBTNAC0PCPJN.9XCRXCPTLSC3@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>, <clg@redhat.com>
Cc: <danielhb413@gmail.com>, <fbarrat@linux.ibm.com>, <rathc@linux.ibm.com>,
 <adityag@linux.ibm.com>, <gautam@linux.ibm.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 0/5] MAINTAINERS updates for ppc/spapr/pnv/xive
X-Mailer: aerc 0.20.0
References: <20250724100623.3071131-1-harshpb@linux.ibm.com>
In-Reply-To: <20250724100623.3071131-1-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

Hey Harsh,

Sorry I dropped the ball on the merge window. Thanks to you and Cedric
and others for picking it up and apologies to those I kept waiting. I
let things overwhelm me a bit and got stressed about getting back to it
:(

I would like to keep helping out with qemu/ppc as time permits, I'll
try not to over promise though. Apologies again.

Thanks,
Nick
`
On Thu Jul 24, 2025 at 8:06 PM AEST, Harsh Prateek Bora wrote:
> Some of us at IBM have been actively working/contributing in
> ppc/spapr/pnv/xive and would like to step up to help with
> reviews and co-maintainer activities. I have also included proposal
> patches from Chinmay and Aditya in this patchset which had already
> been posted to list earlier to request for merge.
>
> Thanks
> Harsh
>
> Changelog:
> v2: Added my S-o-b as suggested by Philippe, Cedric
> v1: Initial patchset
>
> Aditya Gupta (1):
>   MAINTAINERS: Add myself as a reviewer of PowerNV emulation
>
> Chinmay Rath (1):
>   MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs
>
> Gautam Menghani (1):
>   MAINTAINERS: Add myself as a reviewer for XIVE
>
> Harsh Prateek Bora (2):
>   MAINTAINERS: Adding myself as a co-maintainer for ppc/spapr
>   MAINTAINERS: Adding myself as reviewer for PPC KVM cpus.
>
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)


