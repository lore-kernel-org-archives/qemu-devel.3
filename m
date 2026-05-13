Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E164DCD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDkR-0005Ni-OE; Wed, 13 May 2026 13:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wNDkN-0005NG-9j
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:51:51 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wNDkL-0002i2-Hj
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:51:50 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67929ff6dbfso623062a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778694707; cv=none;
 d=google.com; s=arc-20240605;
 b=Nro0FoSFBdiBoGQN7PEVwETZqcIIp8TRaQEbQ4u0lOPRDMzPQ0cbG+fCKSi5ZC33zx
 PIwHg7r1y/7IYnEjeOK7e+e2qNPzlIwiG3A746Z/tKKr5QwnCCmd0sCq8u9VyFQMydKm
 yG7klAcig29tZuIiq0j3wm5t9IQZp5h2eEzicF2WYo2IYJip44QLv/5PayOfOxNLPaf6
 efs3/fPAZLTmmeJcoMN6Ie+OHinQoKAqaE+tHSTMWB6zotZOVrCjHyuoLzC938KCV1Z6
 Y6gHi5zJEQ8x6OV8sDmc0cAvvn+s2uSl7yMtgYjM1MZliv4LAjiTzgHpxH+t5cJDMvGK
 tPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OY1eQ8SHMEXpphr90IJ+6eSSmRkAlA8GVe58b+7u4Uw=;
 fh=vyLD8pMopYqet2O5J2rXyhfw6swrhkhZIAuA6EaEBRI=;
 b=jD3CW3xEYatutqVV1a62e/1OJCnTILQfpSuxdCkhS0oksoFMFfWShXyc6PDSCizp7T
 Hg9pEZgMwBsaNPJJ9ducv/jpy0QHUVk65us31HcL6BJb7xbtk990fcjfjP827M7NrIka
 FlFIxrr88oBVsSUFmWwmpPseYvYaikzCUIwKq3A/6Ndnr8i2jq4FMcRYaI+Dvr7KA+dZ
 td6SREFB2XGi+xxNUEJORMa1j/e4Kzf49eOzbizdcybvY5bLf3KAo/QrlvBhuU5LFnJD
 52rKp7bFg2lRds2d04UY9CZQjZVc+fD1X1aGgNjDiCLSQaRUPPZlVRPlKk4C1uNiflt5
 ZMqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778694707; x=1779299507; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OY1eQ8SHMEXpphr90IJ+6eSSmRkAlA8GVe58b+7u4Uw=;
 b=QY4gmsGd7YsRMsAcmzhGjrcb1zTTiQ+6Su0jruTTMyq49IZoSNqXQN3ta+h8iiOjZY
 mlahZ8dpCcolqgOusZoV/Fg1/UqiBv1B2Nwfa5Eyyrf3+qHn8vX5he9uJEBRzGfNUshS
 H5/JRRTUgqtAQ6idq7LqBfrPYCFuD3UaiY4vhTOoweitxWnE7bgOx5VHge1e3Aa2DWo1
 HHUW4DA3v+49vfwxXMVn5RJLsVqoCtCcbnWxVWARy1DL6ng77xhkQslcvqKOE9pATyM/
 TEZQyakST8QhWfRPPa08CwAzT8+aeDQKfbyXjtc47MIxQCvZprCMeP+mOBqSAo0WHTYn
 vyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694707; x=1779299507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OY1eQ8SHMEXpphr90IJ+6eSSmRkAlA8GVe58b+7u4Uw=;
 b=FqiqCj/+qfKa4AWeCyCZ3KlMxytx5/bKLZ2YMxv8xQT8P4diu0MkOIIH5omEaweePJ
 xG8vy6deCVwYbVg2pwN3ChnvxeYn63MtWvdFTHC85SxwCS3UmA1sJCx0iXa5oidV4VGI
 2JkxNn52TDfpqk6lsKtsTdtWq97AUR51wDpLGWQdIm3Oro1vkFA1rsJ8URaHk+c0p8eA
 78NYnTc9UsBRWdfN9TQ8DnJoNeSpYgRDYyX41y5L2jgNB9v7LYJSzqlzBv16AxvbbMXR
 A6d/4xyEE64pHNqrPAxNW9GA4KJlh2mIIwIxqAo48UzFkIQFYNEEBSsp2VRpF9o2z+Xe
 +p6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hJSNbTSE5KDqEC1X8fqGWlaVbZWwWNNyYmoIX/sJAxgTUnyff74wUk3nX84FTqjPbpwSyJMDGgw+S@nongnu.org
X-Gm-Message-State: AOJu0Yzmay8YCv/1yuhhZX7ojpEsMJHnpDXj9JP1vHrWxTRdQNKy9rp9
 HQS54E3aW8NJbhRXRKMFUn/JQoD9pMe7IjUlHe06sYoA9ns5eycAkKKzB5+IjfOgzmayt+kiBhp
 4SBq2JImhgadhdaY8oOa9B8YCSXt2FrQ=
X-Gm-Gg: Acq92OHX29UnybjMO+75LfMXI0Qq2Zsg2wTYneFML9uZIh72NmxD8hnR8sG2f4iV1Se
 zjta6UmRhQGGP0+ZK03Xlwe0XEeJmEvllMXsBWTpt0lRNJ/e7+TFZXK6e5zFnr/R+I22XW4mprI
 ZC9yLdRyhyBw2J2Rrozb6lasInPlU8h6CxYrZMJA7u/nXJLvlrVuCOYpk4/S4JKJ/667yo/JNkA
 PWVn8F6r9a/fM0v8nUDTYLqUyTutV3C6/t41D3T4/t1A6p6fTdfZh1Ixq7AZXTujGx/X7sO5+mc
 NU1W0xy20LBMn5RETlQU+rF1yxyMFPF5w2Vh5Bm6GA==
X-Received: by 2002:a17:907:984:b0:bd0:bc5a:746 with SMTP id
 a640c23a62f3a-bd3e26f5d08mr255713866b.36.1778694706668; Wed, 13 May 2026
 10:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260507154530.364296-1-milesg@linux.ibm.com>
 <87zf23nqzx.fsf@pond.sub.org>
In-Reply-To: <87zf23nqzx.fsf@pond.sub.org>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Wed, 13 May 2026 23:21:34 +0530
X-Gm-Features: AVHnY4KyyG3a5uJSLPkHo8n5ez0YsWqGvsBskg_A29r2FNAZWsgHbZ8Fn5paIKo
Message-ID: <CAEuJdmpKyg6zjcyOHYvNaWCTm5qe0HOZjyJfv9pu+BSXiPsgSw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add self as maintainer for XIVE
To: Markus Armbruster <armbru@redhat.com>
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000027aab30651b6a2a6"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000027aab30651b6a2a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May, 2026, 11:15=E2=80=AFpm Markus Armbruster, <armbru@redhat.co=
m> wrote:

> Glenn Miles <milesg@linux.ibm.com> writes:
>
> > Adding self as maintainer for XIVE
> >
> > Signed-off-by: Glenn Miles (milesg@linux.ibm.com>
>
> I'll take this through my tree.  Thanks!
>

Thanks Markus!


>
>
>

--00000000000027aab30651b6a2a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 13 May, 2026, 11:15=E2=
=80=AFpm Markus Armbruster, &lt;<a href=3D"mailto:armbru@redhat.com">armbru=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Glenn Mi=
les &lt;<a href=3D"mailto:milesg@linux.ibm.com" target=3D"_blank" rel=3D"no=
referrer">milesg@linux.ibm.com</a>&gt; writes:<br>
<br>
&gt; Adding self as maintainer for XIVE<br>
&gt;<br>
&gt; Signed-off-by: Glenn Miles (<a href=3D"mailto:milesg@linux.ibm.com" ta=
rget=3D"_blank" rel=3D"noreferrer">milesg@linux.ibm.com</a>&gt;<br>
<br>
I&#39;ll take this through my tree.=C2=A0 Thanks!<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks Markus!</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quo=
te_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br><br>
<br>
</blockquote></div></div></div>

--00000000000027aab30651b6a2a6--

