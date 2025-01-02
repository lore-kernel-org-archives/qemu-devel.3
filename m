Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59883E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 12:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTKYS-0005M3-G7; Thu, 02 Jan 2025 07:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tTKYP-0005Lp-SN
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 07:43:59 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tTKYO-00075P-BV
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 07:43:57 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5401bd6cdb7so12020693e87.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 04:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735821834; x=1736426634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ULqI7xWl2Dkc143gH5w3qXup34DaGTXMcEAVWthWcI=;
 b=CLvdY/a+CXDeOuSE+MwEFyxf6DWWpqFkfRb5qkC2TcKNnkhwrhxxnmqhfEWDR97wvL
 +sn6RGAF6e16GgldrAhkASJGPzUO1/lhC1LEMRANIR/BfKUsqgycd+6XqsPRWTMhTRWN
 WxCRKNaTmY4NZ2xjLcF3j7ZSC+CpwRVWf750x6dzzlw/LcCMIYX8blGdKt8j0fak7VKo
 C2gMkJajyxNwDgGeDg7xLrw7EJHzSAfUL5xQR5kOCazbcs7THXKBikX7KQ/h00jtP23K
 OeQ8pvmNaqndvXbM3LVxe4dH5G4D59M5kxkpJen6XSowhkz7IZp2VoaIrMuDOXdRdyYr
 3Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735821834; x=1736426634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ULqI7xWl2Dkc143gH5w3qXup34DaGTXMcEAVWthWcI=;
 b=vZgzVJERyjPjOKEhdfRm70CQ0FxorfOs3o663okfeu/Vtx4dZTqgE1x+KrFIP1u1/h
 Thz3/mXKi7t3dH7q+Rb6ZM7DNNIS4Yo6AOXyUXmMc6UE78ADFgy33H4JkK03l+uTgvDQ
 1CEvLm7k3hhuERTB+JeTh2Vm0BO5W3+MT5KDBE1f4UrHY1dcjdsOhUGKluvCnBjQLVuZ
 raD7Nno/XFANQ5EYFzKh3HQEzpiU71MNRO5c/4Q/0cEuAhUeaEbj4zox1t9nPem132qy
 Y7A8yT1vzYN3Nr2lP/8m80hk6ieQCKSsdfEwsE+BbKUihp0yKiSfjRUyzKDcSPytww4J
 tRug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnvPWTIqWMmx+YnivhpRULU3GlVSb3PCwqU3ehl78nnYY4UD5U50s5mK28JDBbMgNl5mRMlkvmK976@nongnu.org
X-Gm-Message-State: AOJu0YylIY1fQx8Cz5jzInIJtVKBERUHIequJnkPBsSXj5N5NVff+Qvy
 WxCz3E/dxw1DFQq2kp7zX4PxU98m+YwRGiHzJrTAi9kdBEybrlKt3ojl6toxmw+s6e91oJgYvxo
 fSLpH1UOb94iZ27JZJMbwRDw6Jps=
X-Gm-Gg: ASbGncuDbqhSqhj6luV5OPESobPXtXhjffalCaECAmfCylC4UlP+4wXr5iTOhFd8luS
 Lx5ffpR1B23CvAGhgkI96jOZbUoc1Mq8Sh8R/oQ==
X-Google-Smtp-Source: AGHT+IHb4VGvlobR9DuQHt5n3oSZ2JUu6R4TMHbq9Njb9kT0GaeEM4R9SI1e7ZGZuVMS7JPtP4B1IPtegv0vQS1IMgw=
X-Received: by 2002:a05:6512:3a90:b0:53e:3a73:6ddc with SMTP id
 2adb3069b0e04-5422953c384mr14868059e87.33.1735821833415; Thu, 02 Jan 2025
 04:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
 <CAMxuvawN_=oPYVy5ZkWV1q514ZXV-MHVoQvdExFAZ34_s4X2UA@mail.gmail.com>
In-Reply-To: <CAMxuvawN_=oPYVy5ZkWV1q514ZXV-MHVoQvdExFAZ34_s4X2UA@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Thu, 2 Jan 2025 13:43:42 +0100
Message-ID: <CACZ9PQXt2e8MntqC=pQr7_FdUQLnEx=rHt8HN0ZUVvXb1O-D0g@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] chardev: implement backend chardev multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x12a.google.com
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

On Mon, Dec 30, 2024 at 12:35=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> That looks like a good compromise to me, thanks. Markus, wdyt?
>
> In your patches, please change version 9.3 for 10.0 (next release).

Ok.

> btw, for some reason your series is not caught by patchew or
> patchwork.. it's a bit annoying

That's odd. v6 has disappeared. Will re-send once we discuss the mixer
matters in another thread.

--
Roman

