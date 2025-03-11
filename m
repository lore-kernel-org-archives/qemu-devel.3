Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A62C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvbC-0000A3-CV; Tue, 11 Mar 2025 05:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trvbA-00009P-Tl
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trvb4-0003Gp-EV
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741684098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJxI/ZRVueyO0n8sjn5AWKSzXjyVt2i10kz6Me5oZbg=;
 b=LP5AAkcCMxyLJq3YiqikZgQsTk1uyLSJFOoCJvoICSz+Qf5R0RJWaYejFAjK+HPMJBiNKF
 4FDkEDN5vQIW5meuKWEzI3XpJn/PxQN7n0/xpehae9Svh1jDlznjnu80TbWVCXc/KwFdvW
 zNWOstA5PN/IpQPjGzwLS8YRoWyPaqs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-Zi_Hv9SpPrWLFFF0hYbKXw-1; Tue, 11 Mar 2025 05:08:17 -0400
X-MC-Unique: Zi_Hv9SpPrWLFFF0hYbKXw-1
X-Mimecast-MFC-AGG-ID: Zi_Hv9SpPrWLFFF0hYbKXw_1741684096
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2240a96112fso162907685ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 02:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741684096; x=1742288896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJxI/ZRVueyO0n8sjn5AWKSzXjyVt2i10kz6Me5oZbg=;
 b=laMG1NrDFnWEndj/kNQ0RDO1lZxrylowA2c0sPVZxegE8CTFhLklhcnWEwrKki8/4R
 fEKMtk9+ppsKQ8xeQ4gEfJHbyk9fnOjeji5majtWcFhRpLqnJJQeDEX/0QdRsvOBb4yT
 C2Z7toUcwdk0HFBI6PgDbK6PtmCenx0LSqKOESMIjwjrIuNEzuw5R+kIT3glnwVV+7b+
 M1JICElszsDv+SRKON3tV7gOh/6DaAmdKUqMA8tLgvAiexyBfNksnz4+S64B5Hcq/fFk
 uJE6GwGTZqI+89Sm7+AAFnDlel1pQ6rHnrQ3uWWKfLrOs5XWPFhopH4hQhqzUlMuRgYn
 XXlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkiqH+pgDmCdueyezNQW+HpiMF2oxPKCKyb9TC+Hke68AN0mC0BP/Qls1DYTKHddybvUprCjuqaFQX@nongnu.org
X-Gm-Message-State: AOJu0Yy9o9dusrF+9188O8Eb0xVTkTzpMipP2bdxs7SY+hiWNt5udBEy
 jI2TaQBtPQ3J4Sn++6lpIYaXBrpSrwEHGo9+zLOIe9yXMGb43LA1giR5IvFwUAHb9KND4+aF4tX
 Skr1BpL7X4UaeWQQajgI+svkJIykvSqIeaLcKoWuVm9jdjmWsRYWS573lvMXOmlboN058rAPk4a
 J9+MBqvFvFUtvmcO6mqxT6bL2TUPQ=
X-Gm-Gg: ASbGncv54CCuVLERKbKG/Pwnsf268oiK8jtelOJ4rv0/9Fm37DydEs69dUvR7OoXtnC
 MXOOEm6ESxErdYklqA5zrefS9POskM/BhoJSqeHepKud1JPJTOhTHpIH1zVDuqoaoFF9JOg==
X-Received: by 2002:a05:6a00:987:b0:736:46b4:bef2 with SMTP id
 d2e1a72fcca58-736aa9dbf8emr24954732b3a.6.1741684096327; 
 Tue, 11 Mar 2025 02:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwvJzC9V4lx5zVdwFDi4KxdLdN5XiiaE9GW00W9IebWuRD4GBdzc93lVTOWC0jmUPA8JioGqCsHwaZFXQXrU=
X-Received: by 2002:a05:6a00:987:b0:736:46b4:bef2 with SMTP id
 d2e1a72fcca58-736aa9dbf8emr24954708b3a.6.1741684095953; Tue, 11 Mar 2025
 02:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
 <4f0367df-d873-414e-96fc-1a874ee1f501@linaro.org>
In-Reply-To: <4f0367df-d873-414e-96fc-1a874ee1f501@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 17:08:03 +0800
X-Gm-Features: AQ5f1Jou4RX-6MRy8XHQm6pIwfeJzWq_Mtge16jAw4TSc5nRdLnRIzcgFBpwNZw
Message-ID: <CACGkMEu6wngc6oiyVGP7O5BUUPGS4sfWEi66cMDmteihR9nuHw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/net/smc91c111: Fix potential array overflows
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 11, 2025 at 5:00=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Peter, Jason,
>
> On 28/2/25 18:47, Peter Maydell wrote:
> > This patchset fixes some potential array overflows in the
> > smc91c111 ethernet device model, including the one found in
> > https://gitlab.com/qemu-project/qemu/-/issues/2742
> >
> > There are two classes of bugs:
> >   * we accept packet numbers from the guest, but we were not
> >     validating that they were in range before using them as an
> >     index into the data[][] array
> >   * we didn't sanitize the length field read from the data
> >     frame on tx before using it as an index to find the
> >     control byte at the end of the frame, so we could read off
> >     the end of the buffer
> >
> > This patchset fixes both of these. The datasheet is sadly
> > silent on the h/w behaviour for these errors, so I opted to
> > LOG_GUEST_ERROR and silently ignore the invalid operations.
> >
> > Patch 3 tidies up the existing code to use a constant defined
> > in patch 2; I put it last so we can cc the first two patches
> > to stable without having to also backport that patch.
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (3):
> >    hw/net/smc91c111: Sanitize packet numbers
> >    hw/net/smc91c111: Sanitize packet length on tx
> >    hw/net/smc91c111: Use MAX_PACKET_SIZE instead of magic numbers
>
> Since Jason just sent his network pull request, I'll take these
> patches via my hw-misc tree (with patch #2 fixed up), except if
> one of you object.
>
> Thanks,
>
> Phil.
>

Fine with me.

Thanks


