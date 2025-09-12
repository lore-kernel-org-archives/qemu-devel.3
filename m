Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE52CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3wA-0003gj-DY; Fri, 12 Sep 2025 09:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1ux3w8-0003gB-75
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:35:36 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1ux3w0-0003TJ-AB
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:35:35 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5324341970
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1757684120;
 bh=Wtwbdla0hvtqDv4IQ60d+N5uXdm5PDdjr+owUG9i+S0=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
 b=nf7xzVQfHf5mB7TWS5v5YZSp+LTZKKKNau2dpKHCO8MtOE2+v+dVCh18vVU98NNQd
 XlevpQW7MKbbAh+LT9l3l8FM/ClmFjZxIuqNbzzhTWBP4IQbvOHt+izwWP04EMvMvX
 q1g200Q7gGgG5DLQT9aeXvc4DhJ4x5VbdeuUrBFNE1iE5HeGOU5QOtZ7wDctd51zBO
 KBJReuy+c26aTLO5L3yoTSrq2qarJF3w34rP37NVHOW4nac5uQ6A9Up5IRgJG0HlR3
 SF7IgyPfXzWAWpAxFp7tipypHuLOH1PuoyVVTTA5RliPzs8Hvw4p5wb4trVlnby32B
 WVGnjQZZrKdsw==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-62efab531d8so54786a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 06:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757684119; x=1758288919;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wtwbdla0hvtqDv4IQ60d+N5uXdm5PDdjr+owUG9i+S0=;
 b=ZutQNlvjv2ayZu2qC4URVQ8Hwe8uawNp+rXchmM2K+P/1gX+LPKyyrbXITYkU81/CQ
 kV6tQ6KrL/fxT0XGNzj5j0UaFl/6d/eWvJrUAhq+vT4XeseZRuurqC2xmLxxcfxzcPPw
 V77kQvxnRzFyWxW11TlA6rQ8cCB+GpLAOwt+VTeAeuKwMG4XfZQGM3ksZ5nWNdNhWBqX
 i5pJcegDnS7E4ZAYqK/kMLtRJFopAOww71zF/MziyFZZFnzmO3346X9OMRmsfEpQfhLE
 wQo7xj7fzmxgADzq16H/rrUhL5eTl1VNjp+z/jUZij7Hk82VLCWVZAh5jo7LzIG8mVZS
 EHuQ==
X-Gm-Message-State: AOJu0YzdT5xzAx8W/PDeRgKopE2T1FoOGKn4KVIyDAOJ4edEMRe3oeJ6
 Q2Q2Nrh5ejEMXOZQZo+9BYs0LpvYuVEnPdThwWbwWS0sKVpl4usENZXzQbeklfGcs4NhhHUPnoq
 69a3aRM0XHffBdyh3y4qupsM5IU6E1FbjWpyg35FSCSynB62o3cZqrxIeoCbGMFPF2WGRAAc5r+
 WfU0IE6wEMF2GGlBeq0C3uSA6Ow0p59WZ3x7NCUSSo93imUcIlT4CBj1Wnoxa34sU=
X-Gm-Gg: ASbGnctjtwXjWInYzMfrID1DYQhs4CPRQzQU+g3/u1hdQ7NWcKnK5mTgWRn1iB8SSb3
 SCNiHbNxLF6p9KM/d86tRuJr5Mw4AWauXgnS1fATXMdzIHwamWdNjtvS/1NR6hQUP60rM0mbBDg
 jo8z7eA+G2gam2MPzVc+63FCP+eq8PmJXPUUaQnlF0
X-Received: by 2002:a05:6402:2695:b0:628:c60c:a with SMTP id
 4fb4d7f45d1cf-62ed8312b85mr3180063a12.28.1757684119183; 
 Fri, 12 Sep 2025 06:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFVfyhcBKvlKRmyFxtOYAvzQ3Yi9ytjMoiMjfmXeHKMAZj/xBMJAtUq2GGfiv9hJrIsBvlMn1WFP0BbRGqNFc=
X-Received: by 2002:a05:6402:2695:b0:628:c60c:a with SMTP id
 4fb4d7f45d1cf-62ed8312b85mr3180048a12.28.1757684118832; Fri, 12 Sep 2025
 06:35:18 -0700 (PDT)
MIME-Version: 1.0
From: Hector Cao <hector.cao@canonical.com>
Date: Fri, 12 Sep 2025 15:35:07 +0200
X-Gm-Features: AS18NWCidS52pjRT5Pf_357WnIZjOtB1M8jMUio3zyssDnADgV4ntaDX2IOQV9U
Message-ID: <CABjvBV7ehgB5P_ejyGRY1gHakyGAXwWfDUpmQeLmxJqr2TsCyQ@mail.gmail.com>
Subject: [RFC PATCH 0/2] Fix cross migration issue with missing features:
 pdcm, arch-capabilities
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 peterx@redhat.com, farosas@suse.de
Content-Type: multipart/alternative; boundary="00000000000087dbd4063e9ab9d0"
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

--00000000000087dbd4063e9ab9d0
Content-Type: text/plain; charset="UTF-8"

Thanks Fiona Ebner for pointing out (in DM) that I did not CC to the
relevant maintainers.
Let me CC to maintainers that are listed by  the ./scripts/get_maintainer.pl
script on the submission changed files.

Kind regards,
Hector

--00000000000087dbd4063e9ab9d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Thanks Fiona Ebner for pointing out (in DM) that=
 I did not CC to the relevant=C2=A0maintainers.</div><div>Let me CC to main=
tainers that are listed by=C2=A0 the=C2=A0./scripts/<a href=3D"http://get_m=
aintainer.pl">get_maintainer.pl</a> script on the submission changed files.=
</div><div><br></div><div>Kind regards,</div><div>Hector</div></div><div><b=
r></div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><div style=3D"text-align:left">

</div></div></div></div>

--00000000000087dbd4063e9ab9d0--

