Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB7AD3B7F3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUrJ-0002k0-Cl; Mon, 25 Nov 2024 03:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjelen@redhat.com>) id 1tFUqu-0002bv-If
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjelen@redhat.com>) id 1tFUqT-00062s-E5
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732524794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sY88uyl8L+dMzcTqkVAm54adm/pTjybdK0hsOlCZPs0=;
 b=LJ+8E7l4r+l61vK6XcefoLNYY9kNx4M57eR4A/cbeYzyZcryd9Fcz2I/VpOTRRE+Zyg0PV
 pgeqNe5v6Vp4E6ZpTVrfKB7EcOrHhKVtSxD0Tomh1LWeM9T1GK5ji39lT9AAbqz/tQhgkL
 UitXIhJlqJbPcCMEtbBimqlrSlPZ4wA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-yYnHFcD3NCa-ls9ke_TkOA-1; Mon, 25 Nov 2024 03:53:12 -0500
X-MC-Unique: yYnHFcD3NCa-ls9ke_TkOA-1
X-Mimecast-MFC-AGG-ID: yYnHFcD3NCa-ls9ke_TkOA
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ff13df3766so25385821fa.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732524791; x=1733129591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sY88uyl8L+dMzcTqkVAm54adm/pTjybdK0hsOlCZPs0=;
 b=Qj1wFnzwikUTuvTg9Pmnj7Mf9bS/5DLJAZebyFeWwLVm4a6C8XQWbSVkYjfmKWFr5l
 Np8dyxkNIGV2mG+P4rpJfwinyIDBoIIbWQBODQJxZ55uwKkWnVYRYQKCtc524rToiYLU
 PJ9fhMKWoyCP1dGty2ynQjcfrEF3jqbrxuq1jNTQAxkuOePYhrfEf/tr+BaFwB8XxGGu
 3veRSdeEkjS1C200pk5EcgFLA4h2gxoRXlsH42tQ4MHFYKdKF0+BDnpbvmjm+zl5gFXe
 n11OvO3cBCvsDuyip5nhKwYqOIMBLaUlKTzFtC7TH2BEm6LtpHz1gCn8DNOSEbunHLE6
 BL6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0iMDr2iVBW0svHQR4b7gRuC6pErG396xbL+Y1kAVNluAdTR1CQm/wXvzLMPytZN+KkqxhXN+v9V3X@nongnu.org
X-Gm-Message-State: AOJu0Yx6568kR3eCLID5y8IKDBG4fnSu1yyFKgH3+Wox/uFXmtDl7dIL
 FK4Rv3+5kPZGIb5kzbJQQ/XDXDMDqHTshbsbTZp6hF2MOW4y72Kif5iMFCZl+TMsUY9zzSc02ob
 0hWnHF7GOi+W3kwcehZFyt/99z9cl4OKgr27Tz4Zi5JNNj5rO1qQxOupngpc1VTrkQvm+vuyQT8
 GDoDbL0l1DC4P0rzFZucnIdzxMKis=
X-Gm-Gg: ASbGncs9uvf4RqnUDprd4Eef07629WTaqwRzi1su9rvagaSlx7soL4QLuCdvMqnONr8
 VZGjMON4TLowv9N3PP2aZe/prU6rS
X-Received: by 2002:a2e:b607:0:b0:2ff:a728:2ba0 with SMTP id
 38308e7fff4ca-2ffa7282e2fmr38858341fa.19.1732524791358; 
 Mon, 25 Nov 2024 00:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrIe6IENuSASL7fud7gaCcmio32hLan5rMsSHoWc9oMuoBTrWsvXaifXohMJ5I3NjaHy1a+Uq718GVBA76MdU=
X-Received: by 2002:a2e:b607:0:b0:2ff:a728:2ba0 with SMTP id
 38308e7fff4ca-2ffa7282e2fmr38858251fa.19.1732524791008; Mon, 25 Nov 2024
 00:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20241113115000.2494785-1-rjones@redhat.com>
 <0371e3cc-1ed5-4685-835a-5378dd4dfbb7@tls.msk.ru>
 <20241113130021.GA20898@redhat.com> <ZzYVgRo_l2ZHQztg@redhat.com>
 <CAHrFiA98_icSL5WqTFN1gpWN+=70d58rH=V3iJWDf4zYApSMQA@mail.gmail.com>
 <ZzY4D7t5asZZWgwN@redhat.com>
 <CAHrFiA9tURvg0xitWK6gaA9osGF1ZoHq6d1yFv+nB8FPTg7-Cg@mail.gmail.com>
 <Z0CYiB3r8yZKw4sP@redhat.com>
In-Reply-To: <Z0CYiB3r8yZKw4sP@redhat.com>
From: Jakub Jelen <jjelen@redhat.com>
Date: Mon, 25 Nov 2024 09:52:59 +0100
Message-ID: <CAHrFiA9owTevctg=Sw2xUBVjZ41YF1+sSpxrqq4LO00BwxB_NQ@mail.gmail.com>
Subject: Re: [PATCH ssh] ssh: Do not switch session to non-blocking mode
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, hreitz@redhat.com, mpitt@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jjelen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Nov 22, 2024 at 3:43=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
> > So going back to the original issue, is the proposed patch something
> > that could work for you in the short term before a better solution
> > will be implemented or is there something we should change?
>
> Given that apparently it was always blocking, the patch doesn't make the
> situation any worse. I'll apply it for 9.2.

Thank you.

Jakub


