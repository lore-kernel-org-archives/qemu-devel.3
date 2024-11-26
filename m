Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B9D5A6E2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 04:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFnbu-0002LD-1G; Mon, 25 Nov 2024 23:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tFnbp-0002JV-F2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:55:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tFnbm-000891-GI
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732596928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crgtnuFSn4RKN1oCL5EUeP8sV5iqv+TSrOEjccDNx+0=;
 b=isq51owOIHNwlo31ZSqNvFxkw8aAAR8HAR365exn67bhRs3MX47YQIjxBNr1BJzrv32P/h
 WyzyA84ANNPluGt/1bAw7kTLv45dYgaGiRmlVqPRm9pzlV/0V8CzeyBn1xy3IeFv5+EO4q
 CTXDdqweUq09OkW31rUCKLftoQpOZbs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-IUvSaJ2RMZGb8N1WszEdVw-1; Mon, 25 Nov 2024 23:55:26 -0500
X-MC-Unique: IUvSaJ2RMZGb8N1WszEdVw-1
X-Mimecast-MFC-AGG-ID: IUvSaJ2RMZGb8N1WszEdVw
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-211fcbd2325so60318315ad.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 20:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732596925; x=1733201725;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crgtnuFSn4RKN1oCL5EUeP8sV5iqv+TSrOEjccDNx+0=;
 b=Nv89XaSNruNrGDwp6ujZBrgpRWIvz1cAkOAXe4Lh3aVmBASHJrJquggubJsdlUknzf
 Nm5BEQ93BMEddzsjNDb5yeNUlWCw3RX+XglXPBi6t3Aren+VwFw2ZO675hJq93taYI0I
 rgT8HHG5VsauHX1SPWY6e33XqIDQWONhzMDRGj5Y8nNRlnH+uyvX2OKggpEBLAO3q3sS
 lN/C1EjRc53VhmD5xLAl0avQYvKOqIJtIlHWP+Y+V0zKM+GJNnm3cHmQsN7aX5EqIpOz
 Yhb2bDNWvNi1AXGDz0+pCEBfmQPAQNsvhgFNBbTMBjsnrbPMiXGI8HQtYT+M/SIiNiBC
 /B1w==
X-Gm-Message-State: AOJu0YyfSlfw53QPLY/C06JtukJXhBukFyNu3QajWtEw2ZtHU8EkbiP/
 AEtnzxAK8slrYcy1e/fbsm4UolSmf8ZdMg+Bh1/DOxrnhpHj381iM1yqoV9EHw0yJi7bFiSCI1u
 fK6o7hSCXGepBfpSV31/hMFeNzvhAl+odMkoIBkxsAeYbQOAoGYdr
X-Gm-Gg: ASbGncse9RQut12yNHJnN/nhnBg108zxYxl5DA8rkgwsEP0Vx7iOLNqPoHSlAuczk81
 9DPY0Dz6wIwK66SRvRWcqoh4K0WbCIsljBS4CO4WuYzYTTnppyJQGRROw1+36feSXpzt1ukTWXq
 ux/R0QWOXqxfBkUSJK1IcI78ZIvWHmzoxcynAogfAHlbHd7g5+CiOCbRa+6FKUTkiWdor8/DQpQ
 ZytcpXNNTwwrF9H37f3C2sXxxOoo9XwDwH/gtWmR/RGE0HgK0RRJxjyuPUmWdcuPQ==
X-Received: by 2002:a17:902:da87:b0:211:ce94:866a with SMTP id
 d9443c01a7336-2129f27edbcmr208019525ad.40.1732596925447; 
 Mon, 25 Nov 2024 20:55:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFz2ag9yELqUG+xXuXAUYx7tAYW/83J251WZXJOl/xdoLISutqp874DfAHRzo2I1TPrHHRAQ==
X-Received: by 2002:a17:902:da87:b0:211:ce94:866a with SMTP id
 d9443c01a7336-2129f27edbcmr208019295ad.40.1732596925091; 
 Mon, 25 Nov 2024 20:55:25 -0800 (PST)
Received: from smtpclient.apple ([115.96.111.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dbff4basm74873375ad.116.2024.11.25.20.55.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Nov 2024 20:55:24 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 39/39] docs: explicitly permit a "commonly known identity"
 with SoB
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20241121165806.476008-40-alex.bennee@linaro.org>
Date: Tue, 26 Nov 2024 10:25:01 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tsirkin <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 John Snow <jsnow@redhat.com>, Wainer Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Berrange <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF4D6240-DB71-4111-B7A6-E95E2C5ECF7B@redhat.com>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <20241121165806.476008-40-alex.bennee@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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



> On 21 Nov 2024, at 10:28=E2=80=AFPM, Alex Benn=C3=A9e =
<alex.bennee@linaro.org> wrote:
>=20
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> The docs for submitting a patch describe using your "Real Name" with
> the Signed-off-by line. Although somewhat ambiguous, this has often
> been interpreted to mean someone's legal name.
>=20
> In recent times, there's been a general push back[1] against the =
notion
> that use of Signed-off-by in a project automatically requires / =
implies
> the use of legal ("real") names and greater awareness of the =
downsides.
>=20
> Full discussion of the problems of such policies is beyond the scope =
of
> this commit message, but at a high level they are liable to =
marginalize,
> disadvantage, and potentially result in harm, to contributors.
>=20
> TL;DR: there are compelling reasons for a person to choose distinct
> identities in different contexts & a decision to override that choice
> should not be taken lightly.
>=20
> A number of key projects have responded to the issues raised by making
> it clear that a contributor is free to determine the identity used in
> SoB lines:
>=20
> * Linux has clarified[2] that they merely expect use of the
>   contributor's "known identity", removing the previous explicit
>   rejection of pseudonyms.
>=20
> * CNCF has clarified[3] that the real name is simply the identity
>   the contributor chooses to use in the context of the community
>   and does not have to be a legal name, nor birth name, nor appear
>   on any government ID.
>=20
> Since we have no intention of ever routinely checking any form of ID
> documents for contributors[4], realistically we have no way of knowing
> anything about the name they are using, except through chance, or
> through the contributor volunteering the information. IOW, we almost
> certainly already have people using pseudonyms for contributions.
>=20
> This proposes to accept that reality and eliminate unnecessary =
friction,
> by following Linux & the CNCF in merely asking that a contributors'
> commonly known identity, of their choosing, be used with the SoB line.
>=20
> [1] Raised in many contexts at many times, but a decent overall =
summary
>    can be read at =
https://drewdevault.com/2023/10/31/On-real-names.html
> [2] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Dd4563201f33a022fc0353033d9dfeb1606a88330
> [3] =
https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
> [4] Excluding the rare GPG key signing parties for regular maintainers
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20241021190939.1482466-1-berrange@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Acked-by: Ani Sinha <anisinha@redhat.com>


> ---
> docs/devel/submitting-a-patch.rst | 7 ++++++-
> .gitlab-ci.d/check-dco.py         | 5 ++++-
> 2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/devel/submitting-a-patch.rst =
b/docs/devel/submitting-a-patch.rst
> index 83e9092b8c..10b062eec2 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
>=20
>    * - Check
>      - Reason
> -   * - Patches contain Signed-off-by: Real Name <author@email>
> +   * - Patches contain Signed-off-by: Your Name <author@email>
>      - States you are legally able to contribute the code. See =
:ref:`patch_emails_must_include_a_signed_off_by_line`
>    * - Sent as patch emails to ``qemu-devel@nongnu.org``
>      - The project uses an email list based workflow. See =
:ref:`submitting_your_patches`
> @@ -335,6 +335,11 @@ include a "From:" line in the body of the email =
(different from your
> envelope From:) that will give credit to the correct author; but =
again,
> that author's Signed-off-by: line is mandatory, with the same =
spelling.
>=20
> +The name used with "Signed-off-by" does not need to be your legal =
name,
> +nor birth name, nor appear on any government ID. It is the identity =
you
> +choose to be known by in the community, but should not be anonymous,
> +nor misrepresent whom you are.
> +
> There are various tooling options for automatically adding these tags
> include using ``git commit -s`` or ``git format-patch -s``. For more
> information see `SubmittingPatches 1.12
> diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
> index d221b16bd5..70dec7d6ee 100755
> --- a/.gitlab-ci.d/check-dco.py
> +++ b/.gitlab-ci.d/check-dco.py
> @@ -78,7 +78,10 @@
>=20
> To indicate acceptance of the DCO every commit must have a tag
>=20
> -  Signed-off-by: REAL NAME <EMAIL>
> +  Signed-off-by: YOUR NAME <EMAIL>
> +
> +where "YOUR NAME" is your commonly known identity in the context
> +of the community.
>=20
> This can be achieved by passing the "-s" flag to the "git commit" =
command.
>=20
> --=20
> 2.39.5
>=20


