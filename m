Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2394BE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 16:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTNzJ-0004Nu-AO; Thu, 02 Jan 2025 11:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tTNzA-0004Ne-E1
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 11:23:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tTNz7-0003hq-Pq
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 11:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735835021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAMjA4h/i3mb2p8dyDW6GQM3iSBY0mi4r6nm2YML1tU=;
 b=G/p82mZzuRJ9rDlf2MqIGn0Ptn1IqQohLxjQ+OghQXc8UgLKXaQkZHXVsdHR1nKhx/boXY
 aGQrjRTzy1RWM6fWrIKPWZtSMvIPxardRKsA4RHQixJi0eyHD2NtXWMcQOS1juYisycm2G
 YmuIEBQvCQWLNCGrLcpNPYwq52LPXXw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-CYA-GKGkOoaiXbOsSInX2g-1; Thu, 02 Jan 2025 11:23:40 -0500
X-MC-Unique: CYA-GKGkOoaiXbOsSInX2g-1
X-Mimecast-MFC-AGG-ID: CYA-GKGkOoaiXbOsSInX2g
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa6869e15ebso368503066b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 08:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735835019; x=1736439819;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAMjA4h/i3mb2p8dyDW6GQM3iSBY0mi4r6nm2YML1tU=;
 b=np0yMDHLmIGehdvyWsitAx+/fbEU9TW0Iz4efKTbMATOgaQYCfiHYeHGTHPDkjipvu
 LZKCI9ST0ELAF+DhoZtckYnzYzKFNdsedJagFLgmyno+KS/n1eE1LFj7bGEAHZml7XDf
 KJ0ZwX9P2+gG7ypvfvw9sh/2CfBb6CNovEOXl2HOwxGWYKHD4GLsJmKv558adlpuah2l
 y8+Jy++sJGZh30F5MgGIMsLXJuK8MVhoOK2whcO2ogxOm5YCMhpZlCxX7hC6O7+Xdsd2
 Se5htERWfdWaNEpugweThZwUyihCLdr6OeT8V9vGaD0JUBzPOU/xG8jbbSXRdoQFMysi
 SEig==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Lc9s9yez65jPRncBHP9d7HGVhYlFc5Az3wQucYvcveDaFSBuUX3rO9NCq+jol2jmhCPVigLJtzgJ@nongnu.org
X-Gm-Message-State: AOJu0YyS1nWibePgSrlOkNw7KDFtUVbbDKXCS3BV9opGR90Tsj/PW7S5
 h/6tazodZ8NUJj2W8zGd0vg/x2anUhyrT/ZUIX/y9cNurXoB8eMzFY4Dix2vijyUs5/Kn/R5H/Z
 0Yh6m2cgaw7oRvTl2eJ0WMLWowroQ0eJw4o8+bfQ8GFJFGKf5ZWLe0GBqXEPL+y7uMUXL7X259+
 BxBN/fo7nsM4jfolWSLPIN+SCXUYk=
X-Gm-Gg: ASbGnctiEak9psYj/1WYOf+MkoLlZFYHPyiKTI3RxjYoobF9fG2Yxu6Ys/MxJHr6hsZ
 fJpXOog5tUAwnlpFWK4PhqqT92qRmFIxyyIYQ/Q==
X-Received: by 2002:a17:907:2d29:b0:aa6:50ee:d44c with SMTP id
 a640c23a62f3a-aac3367202cmr4579525566b.15.1735835018885; 
 Thu, 02 Jan 2025 08:23:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxEi9CBKed+hYe8pdjYjEGJHvO6xT+d3kQhJ3AVLj7tPhtnVdSF1j7s49//9TrwHEDKN9jbkX0pCGq4ZA8lcs=
X-Received: by 2002:a17:907:2d29:b0:aa6:50ee:d44c with SMTP id
 a640c23a62f3a-aac3367202cmr4579524266b.15.1735835018554; Thu, 02 Jan 2025
 08:23:38 -0800 (PST)
MIME-Version: 1.0
References: <CAK3XEhNkhJmHDWwJinbDd31OnXUWAPoqPS5TuykqEUyiu=Gz5w@mail.gmail.com>
In-Reply-To: <CAK3XEhNkhJmHDWwJinbDd31OnXUWAPoqPS5TuykqEUyiu=Gz5w@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 2 Jan 2025 21:53:27 +0530
Message-ID: <CAK3XEhNqHRtUt_rnV2nxqCrZLm235ifSofKS-Dir83yLdxrD7Q@mail.gmail.com>
Subject: Re: DMA interface support for libqos/fw_cfg.c
To: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 2, 2025 at 11:31=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> Hi Markus:
> Currently this library can only be used to read fw_cfg files from
> QEMU. It can not be used to write to fw_cfg files since it does not
> support the DMA interface. Is it possible to add DMA interface support
> to this libraries so that we may use it to write tests that write to
> fw_cfg files?

scratch this. I realized that DMA is from guest memory which means
there has to be an agent inside the guest that provides the buffer
address to dma data from.

> I wish I had time to implement this myself but I am too starapped at
> this moment.
>
> Thanks
> Ani


