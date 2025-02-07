Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABC0C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL7A-0002uR-K3; Fri, 07 Feb 2025 04:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgL79-0002tm-2O
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgL77-0001CI-2b
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738922252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvaWgedovhL6qvDodJtc27J/k74HSE3JQmFk9FPCRRI=;
 b=SKd3DDZxC5VqDbPE5Y7DUclvzPf2UW3iiJNgu7goqIwWqI6efSzJIDwVBSHfpS2EugvHWF
 qAe/034CaB4exvHQLkdwb2ApeSkTWuJx1CLH6EoZIegB9B/qfCH4JMIfeurkw+0pgkVhFD
 OcE/LGI+ZOhQA1H75CXkNMg4J9aHAtg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-GxLiMnGLNkaFT9zfRGQdjQ-1; Fri, 07 Feb 2025 04:57:30 -0500
X-MC-Unique: GxLiMnGLNkaFT9zfRGQdjQ-1
X-Mimecast-MFC-AGG-ID: GxLiMnGLNkaFT9zfRGQdjQ
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f9f2bf2aaeso4122309a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 01:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738922250; x=1739527050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lvaWgedovhL6qvDodJtc27J/k74HSE3JQmFk9FPCRRI=;
 b=YTz1//I5E3fpFZpSsDMWMRKCKSkVSy3ZSd/qTt6CFBwtQZreRTQ3UUjACUHU4OD09Y
 p68WM6Siqe1r3IIrm8GxYZs42FCJnYqZoAJvmPxgowEqpQWl8x+Q/bCH0v7XAUoGB8+u
 9Zj3uFGYyT5t4xPN2SeDo1ucfWGUQY4wrqIvsx/D+yOgDmlnqlrOYtBX1RIGOTyNTYOC
 pwVmlm+Hg9ilvNqoubFim+G75zo9JAQtd0/iDHtKKXXWNNSK/NZf+QyOQjSnmM0aFwFN
 tcjUL8iMkKDjZ/OekqShi7PJoyijZubi+Cwxx0+gUHeDGevyT4pT08dGeU0HeDYnu/9n
 CT3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqDIC7k/rvGVOhUhVZDlTNpm/hj9Tcm7utQVUrn+RrYj2abl9Nov9DodbN+vj2PjPGDEvPqBydbBeI@nongnu.org
X-Gm-Message-State: AOJu0YxBqhK+Ye5FIX8wi23V5CsZNMSEUk22znX2S91aWkskzdnFZ6jA
 gTWVeccmkVsUKt3QvpSt+Q7+f3OT/mBh00p3/z8aD3NL7qS1tvGAR+41gATXQMuyPT8vIPIqR6r
 v3uvXmpinFe1VSccwCialJ4AUL6RvnqmfydH3PA+pQ0rnXyoSI9DzgtWGKs3Rd4hysHAlfjBMxv
 YFNgRc28mH9RJHHRYZTt59MMosHl8=
X-Gm-Gg: ASbGncuA8/myLbmd6q3EtGXx7CpIGbj8Y2S2kBnS4Ny6wfKly9Qj9QLvsdOBb7+nApZ
 XFhhUfJkWXJsP9FgBYsslSaj2agDuhqGNVUJBUHfc4nJyHqbxy3uQGKuM9etX
X-Received: by 2002:a17:90b:4b:b0:2f4:47fc:7f18 with SMTP id
 98e67ed59e1d1-2fa2406b9aemr4303376a91.10.1738922249798; 
 Fri, 07 Feb 2025 01:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8vg7sO/fnXGSX1pcn/6c7jld/122tubULgKnf5kYhDaNVh9PRJuH9QAaxWY/wP0GsOFXCRDVI+e//iAVUqOk=
X-Received: by 2002:a17:90b:4b:b0:2f4:47fc:7f18 with SMTP id
 98e67ed59e1d1-2fa2406b9aemr4303343a91.10.1738922249487; Fri, 07 Feb 2025
 01:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-4-zhao1.liu@intel.com>
 <17907481-89d6-457c-bcd3-66a444b1325d@redhat.com> <Z6Wx/RGBIElMaeZy@intel.com>
 <Z6W56AH3J1qOx18m@intel.com>
In-Reply-To: <Z6W56AH3J1qOx18m@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Feb 2025 10:57:11 +0100
X-Gm-Features: AWEUYZn2gU4VufkLk8QEyRFVx4vlcD4ak9JuJiEFz8GxxeARNPiPzUJNMBAn4Po
Message-ID: <CABgObfa+_VVQWvrGWf6fJjf39O0AkoNB5aoptDrhk7dDx_SNXQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert [InterruptSource]
 to [*mut IRQState]
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?UTF-8?Q?Alex_Benn=EF=BF=BDe?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?RGFuaWVsIFAgLiBCZXJyYW5n77+9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f9210a062d8a6265"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000f9210a062d8a6265
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 7 feb 2025, 08:25 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> Just to confirm, I check with `cargo +nightly clippy` but it doesn't
> complain about this case. Should I switch to another version of clippy
> when I do such check? (currently I'm using v0.1.63 clippy as well, to
> match rustc.)
>

I don't remember exactly how I noticed it=E2=80=94I am pretty sure it broke=
 in CI
though. Maybe the change to add rust_version hid it.

To answer your question, generally the idea is that we use the latest
version of the developer tools (cargo, rustfmt, clippy). In particular old
versions of cargo don't support retrieving clippy settings from Cargo.toml.

Paolo


> Thanks,
> Zhao
>
>

--000000000000f9210a062d8a6265
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 7 feb 2025, 08:25 Zhao Li=
u &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha=
 scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Just t=
o confirm, I check with `cargo +nightly clippy` but it doesn&#39;t<br>
complain about this case. Should I switch to another version of clippy<br>
when I do such check? (currently I&#39;m using v0.1.63 clippy as well, to<b=
r>
match rustc.)<br></blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">I don&#39;t remember exactly how I noticed it=E2=80=94I am pre=
tty sure it broke in CI though. Maybe the change to add rust_version hid it=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">To answer your questio=
n, generally the idea is that we use the latest version of the developer to=
ols (cargo, rustfmt, clippy). In particular old versions of cargo don&#39;t=
 support retrieving clippy settings from Cargo.toml.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--000000000000f9210a062d8a6265--


