Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A91C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC4t4-00012O-1N; Mon, 05 May 2025 19:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uC4t1-00011a-4g
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uC4sy-0001yL-NW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746486366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mITj8twvlwZ8f3BQHr+K/fqlFpVhIGDhirb1RuUwK/g=;
 b=BApR3oL1aIZJON+vMBCmj6yMBiWO/1yD4+PKeagy86DfHpvW43N5m0THPf7cHr7dBwNDau
 DfTpCQS4KyYOuXAuLvwx4m7UNwkP35kEExrqXzZL17dmtQnO5JpqIDJrnCEAWij2dC/+0b
 xHkxZVDPWEecW1S4tjECMZsIox3A/cI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-4eDXWYDHPGyysF3ppH1Aww-1; Mon, 05 May 2025 19:06:05 -0400
X-MC-Unique: 4eDXWYDHPGyysF3ppH1Aww-1
X-Mimecast-MFC-AGG-ID: 4eDXWYDHPGyysF3ppH1Aww_1746486364
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3032ea03448so4922449a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746486364; x=1747091164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mITj8twvlwZ8f3BQHr+K/fqlFpVhIGDhirb1RuUwK/g=;
 b=azT5cOv/G2A+ZiN4dQw/zJ3d8hc8LCuDhQOvDlKRJHwqBvwiigNAjWkqg1ICj5B4L1
 0QsO48+oFPiOFoXtYKBcsc64FTS41CHG/D1Pdy75O2YDK0xQktv2tfoH7XVKFUCKO9Tj
 5prcJhi+RpxLuJJj+ZJqSi7aQSNJB4q5ZMK0pQzPC9+W3c9pHeyNQHuTe9LVf1ALafaU
 5YFRtbtBK4aX1cUn9BvWjkDQBGdiwFVljp+G0yVVom+EEwpDHAuEqMf//mUEi7Gr8jQ/
 GTz5lXuMhCsvD4FV/tafyDZk7V9Z5cb/A5+eaC3GSjhhWEfVpr1V6XcTJyYI2rcgKxB3
 VmAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb4MFnroLMPRinssnfI6HqNVCCF3QWIrP5cUOZwov4ixJXNq+cU+B2r4Gra/fr1+OX87WkEUOR9z8n@nongnu.org
X-Gm-Message-State: AOJu0YzohSgpfcirgYTkgkrXYrQMvPDOPpvbSe4355iO2nMJiBVZ0fDY
 8GL5q1kFoo2wssvNrOw/VSovjuB9aiQcKohUihR7tNNWLw4ckP8A0JasSGHSYWKt4reINN8JL7d
 Uwwc1Pu7z96vYRNJr35AvUiBf0Nv7mhH4lzvfTJn4RD3H/MAUa5cYPmiQ+4PtGyjmMILIB/+qYH
 9abWC8lWGuZt3IOYZU45xEgbDSyws=
X-Gm-Gg: ASbGncvOf6EGaUVGRPlR2zPIAZk9xbP72HIJ0bq4cO48YWCxA4MaY2kSHoBg7t6IgCv
 h1V69oFA6K973y0dRw8QbMP8EHau8WfHRRJ3yjSgUbcQyRB+xS7j3mmBD1LLQvHRW3SLfd3/A7d
 k9CnidTl6lC82HjIk7iubwn5aR
X-Received: by 2002:a17:90b:548b:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-30a6196eedbmr15215133a91.7.1746486363920; 
 Mon, 05 May 2025 16:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEnBLniH0iBeFKdXvMKSImw2t+fNVgO9vwqlGnUN+zINjqWPGVxQiTgT6G9qEfvn5ZtMPGAQszuW3R7Gll+64=
X-Received: by 2002:a17:90b:548b:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-30a6196eedbmr15215108a91.7.1746486363626; Mon, 05 May 2025
 16:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
 <881635e2-8b95-4e3f-9ef0-e8cccf675436@redhat.com>
In-Reply-To: <881635e2-8b95-4e3f-9ef0-e8cccf675436@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 5 May 2025 19:05:49 -0400
X-Gm-Features: ATxdqUFw-rRnMuuYcQKG5rjGumbxVzRSBKt0WLrIDdpB9kC-FnYFdd4nAcrP1oA
Message-ID: <CAFn=p-YeHAKcSBNeKeAKdVYc_6y72tko+W1ZaQnt3pKGaYTNUQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs: Bump sphinx to 8.2.3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, devel@daynix.com
Content-Type: multipart/alternative; boundary="0000000000004f456f06346b8b1b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000004f456f06346b8b1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:36=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> On 5/5/25 14:19, Akihiko Odaki wrote:
> > Supersedes: <20250120-sphinx-v1-0-65151b4441ac@daynix.com>
> > ("[PATCH 0/2] docs: Bump sphinx to 8.1.3")
>
> Sphinx 8 requires Python 3.11 on the other hand; not an objection, just
> a reminder for myself to add a note to the Changelog if this patch is
> merged.
>

What happens if you are using Python 3.9/3.10 but don't have a suitable
version of Sphinx on hand? I assume it will fail.

--0000000000004f456f06346b8b1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 5, =
2025 at 11:36=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redha=
t.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 5/5/25 14:19, Akihiko Odaki wrote:<br>
&gt; Supersedes: &lt;<a href=3D"mailto:20250120-sphinx-v1-0-65151b4441ac@da=
ynix.com" target=3D"_blank">20250120-sphinx-v1-0-65151b4441ac@daynix.com</a=
>&gt;<br>
&gt; (&quot;[PATCH 0/2] docs: Bump sphinx to 8.1.3&quot;)<br>
<br>
Sphinx 8 requires Python 3.11 on the other hand; not an objection, just <br=
>
a reminder for myself to add a note to the Changelog if this patch is <br>
merged.<br></blockquote><div><br></div><div>What happens if you are using P=
ython 3.9/3.10 but don&#39;t have a suitable version of Sphinx on hand? I a=
ssume it will fail.</div><div>=C2=A0</div></div></div>

--0000000000004f456f06346b8b1b--


