Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B1CA0EF5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 05:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoax8-0004nJ-RD; Wed, 20 Aug 2025 01:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoax0-0004mI-3b
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 01:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoawx-0000FG-Hb
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 01:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755666084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wgm99/qg4YmFqC9ol4oFzyhE9EHLjE95LAZ0H3C4i08=;
 b=hpqtbJtmzN4NBDXH3sThOtjnRFj3WDaU9x3LSgEODLbyaPjan+iuQWabM8TaJSyYSf9GN+
 VguKi3QYjB9s2Q6PIXtKjSYgI09y4GMe2Nqv0DL0gyAa0SdVa/smptDtY6KTORBSwlmfir
 yM8lYZRBqs2nChQgksodKVzc9x8i/vM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-gGGF7zqrPK27zRfQPtCb7g-1; Wed, 20 Aug 2025 01:01:21 -0400
X-MC-Unique: gGGF7zqrPK27zRfQPtCb7g-1
X-Mimecast-MFC-AGG-ID: gGGF7zqrPK27zRfQPtCb7g_1755666080
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24457f440f0so67528675ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 22:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755666079; x=1756270879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wgm99/qg4YmFqC9ol4oFzyhE9EHLjE95LAZ0H3C4i08=;
 b=BVLcl8qytEZQus7VZAMgTIruTkOXYjlIXdjULTbkoHEX+AfxYGBIySbtKla7PD11do
 bn19HKArzbszpeM6h6Jrp5RDByxHBicP5Xaet1pvC4PtVE/XA4Os7UhFPjyi1fbktgZg
 nko8LEEn6qSo7zqH82qHCJTTqcrbMji2cUBTvhTo/v8MPrvHFHDvSE+7yRu1l5u2pC1o
 hyTwF17ddPDqRj/ZeCSgW+GavQf/GuPFXqC/P00MEEgkpeWb9sLnDxvORCDAmG7sqIY4
 SdiuSspumOEjcn3k0EOBybJEptJ6iWbukOzOBwpQ1cg3w4z7LB83HnHf7Z/2hJopbEX4
 k1GQ==
X-Gm-Message-State: AOJu0YxIA14+Ptdfg32xRrUpWd8JKC3q3Ii3I/CczwaOXCR9fnDkMDin
 z8208W1hwK2Y+P59UrK5lISHXXk1p+YmsNpfUiCScpjY/+5YuM+mVfB2jMPcvTzW5XzdAbw86ct
 UFSErqKQHLDvplRa+DDwM9dh6mHOGsEqfqyxl2BQ5BQQQ4kXisB4/6Fcx6OhmTRuUJAfO34mHr+
 MRlF+B6G25x3qPUjR0tUe+zuciCz4hnAqcdjqVMrlLXg==
X-Gm-Gg: ASbGncv/dp4Y1j4PUZGTUKeGlwneQg50uwu9mEEjiGfa27HTN6M6XyODL8vTOCZpign
 cPWyzHz76ZFtQoJR9nwhk0/jFCGp00K3RRYqao65hfMa0BiDeBDK78rh1Qv270JiJS/kFViA5QE
 Q7P/uf053mcMlQl07lvoCFryA7UalFaout9j9t/MA3K8ZPCRTtotlW
X-Received: by 2002:a17:902:f0cd:b0:240:58a7:8938 with SMTP id
 d9443c01a7336-245ef0eeda3mr15217365ad.7.1755666078675; 
 Tue, 19 Aug 2025 22:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR9v2ssWi4n/DvwsmYiS4Wyk8cWGXvY94eZ6YNPyA949y7mj7tQ7jCEztwUPkHCaTuYamouRZm7Wf8QmgGGkc=
X-Received: by 2002:a17:902:f0cd:b0:240:58a7:8938 with SMTP id
 d9443c01a7336-245ef0eeda3mr15217175ad.7.1755666078343; Tue, 19 Aug 2025
 22:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250820045816.1142190-1-jsnow@redhat.com>
In-Reply-To: <20250820045816.1142190-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 20 Aug 2025 01:01:06 -0400
X-Gm-Features: Ac12FXzPKjusEPlajLJ1QEtKTEE72XDBzxIRZya-Pl2KmrlId-biXwdu2AbEJAE
Message-ID: <CAFn=p-bSh9kr2OOv0vq8H+quuUSww5NeV8LYBy2MKr-b82P2kA@mail.gmail.com>
Subject: Re: [PULL 0/2] Python patches
To: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 20, 2025 at 12:58=E2=80=AFAM John Snow <jsnow@redhat.com> wrote=
:
>
> The following changes since commit 5836af0783213b9355a6bbf85d9e6bc4c9c936=
3f:
>
>   Merge tag 'uefi-20250812-pull-request' of https://gitlab.com/kraxel/qem=
u into staging (2025-08-13 15:19:29 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 16398e73cd13c7d9f284d8ec4a440778fc2e3f9a:
>
>   python: avoid deprecation warning with get_event_loop (2025-08-20 00:55=
:27 -0400)
>
> ----------------------------------------------------------------
> Python pull request
>
> Necessary for Python 3.14 support for iotests, releasing October 7th
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (1):
>   python: avoid deprecation warning with get_event_loop
>
> Richard W.M. Jones (1):
>   python: Replace asyncio.get_event_loop for Python 3.14
>
>  python/qemu/qmp/legacy.py  | 10 +++++++++-
>  python/qemu/qmp/qmp_tui.py |  2 +-
>  python/tests/protocol.py   |  2 +-
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> --
> 2.50.1
>

Dan: I wasn't sure if you were suggesting these to be pulled *right
away*, but just in case that is what you meant, I sent this PR for
what I think is the minimum necessary to avoid iotests croaking when
3.14 drops in October. Let me know if we need to make any other
adjustments here and I will follow up in the morning.


