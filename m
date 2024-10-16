Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4373D206AB
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 07:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0yna-0001tn-IP; Wed, 16 Oct 2024 03:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0ynZ-0001tQ-C8
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0ynX-0008Ng-Pv
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729065021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UtPV3ZIdrjJh+SDwITMQp5GwPAVCo/fSnK41lNQurtU=;
 b=FtI5p0fACU6dAc5xdDY2smfN9O/Fg3NPJCky58d73Vjd2Bx3t3hkuSQyDyJ2POB6DRrvSK
 VOgt8BQFOAw1XiX+JumfMg7RGpRzQv48Pzg8eT3ae/WfUpB6qhAooanTCddBeecEM4ieaH
 yBt5dIHY2rn1RLEdhUIidAQZFA3I1zg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-b4GFMWaKPQy3TW3FPNejqw-1; Wed, 16 Oct 2024 03:50:17 -0400
X-MC-Unique: b4GFMWaKPQy3TW3FPNejqw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so2280817f8f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 00:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729065015; x=1729669815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UtPV3ZIdrjJh+SDwITMQp5GwPAVCo/fSnK41lNQurtU=;
 b=o5yeXvpypwp3ruX5L7lYzFQB6PLH61MAIu6ku0X1GwCXtFmM5gIGWk2GBSA/VIbbR6
 /JX6znowsAtNJ/yM6GwrrqNxmPdw3rDxxoV3Z+CiPhnUW642BXvhIjF915etmK8TYGYk
 lZnSm7c0hYO1WswV0+/+Ht7WvbsZ4l84tEHa+ZbtpL49VSJWPXimJM8L4AYJWHvta30m
 t2OWJSDKgAMOQiLboouSFILx22nOCidkic7Fo2nVTSmJ3cyjrLTZQJysSJrpaB+8kMZz
 7ZhG61mQXH/2N3VHynXcuIgTTemKswEzdAGj+mepSOZBXY4eRIMiqb3ccAVw275fZRcu
 EK/w==
X-Gm-Message-State: AOJu0YzYPLW9LXGPBTs0GQ+nKGtU7CGiCHF67E40SB44uWXEAyv0Ygpz
 8zU7s61fEerk+jpZS48ZsWU31E75d5Co+AhQnG/GXvlMB+uG1K2Zs3Krh6MutFIlvHM0zs15BPS
 xvTjY7XOtBMwKeUyrRcn2CLqYVSVvFYqflN4D7xVWz80W1afw3LV5cu+h6TOKTsRdrTKdExg7te
 u4OB+mKJmKLbUGC9siVAV+dnFOl1PI1bkMNnZxDw==
X-Received: by 2002:a5d:4561:0:b0:37d:2edd:b731 with SMTP id
 ffacd0b85a97d-37d5fee7b29mr9666437f8f.30.1729065014996; 
 Wed, 16 Oct 2024 00:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXdYSLuUipak2aQvz9GBErvcEqO9OoXOYzASWUmAb5ZImilHrw9uU6jmv4Ze6+5BuIJ+nxK6foFGcymwRsYSs=
X-Received: by 2002:a5d:4561:0:b0:37d:2edd:b731 with SMTP id
 ffacd0b85a97d-37d5fee7b29mr9666423f8f.30.1729065014635; Wed, 16 Oct 2024
 00:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-17-pbonzini@redhat.com>
 <SY0P300MB10263F19AD3FEB043D3D47A195462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB10263F19AD3FEB043D3D47A195462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Oct 2024 09:50:02 +0200
Message-ID: <CABgObfbkgXM5jG9-JP_BsJQk3Pw_gHMVeQfLOzVuui5TZiojtA@mail.gmail.com>
Subject: Re: [PATCH 16/16] rust: allow older version of bindgen
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fdc17006249351ad"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000fdc17006249351ad
Content-Type: text/plain; charset="UTF-8"

Il mer 16 ott 2024, 08:29 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

>
> The bindgen 0.59.1 installed from Ubuntu 22.04 apt source does not
> support the following args:
>
>     '--formatter', 'rustfmt',
>     '--merge-extern-blocks',
>     '--allowlist-file', meson.project_source_root() + '/include/.*',
>     '--allowlist-file', meson.project_source_root() + '/.*',
>     '--allowlist-file', meson.project_build_root() + '/.*'
>
>
Ouch. --allowlist-file was added in 0.60, so Debian has it. I think we
should ask Canonical if they can update bindgen in addition to rustc.

Paolo

The first two args are cosmetic and should not hurt if removed (but I
> need to double check).
>
> Removing the allowlist-file, however, causes IPPORT_RESERVED to be
> generated twice using different types and thus break the
> build. Allowlists for bindgen 0.59.1 can only be specified as regex on
> function, type or var. I don't find (yet) an equivalent way of
> --allowlist-file. A dirty trick is `--blocklist-item IPPORT_RESERVED`,
> which works but is so ad-hoc.
>
> --
> Best Regards
> Junjie Mao
>
>

--000000000000fdc17006249351ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 16 ott 2024, 08:29 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>The bindgen 0.5=
9.1 installed from Ubuntu 22.04 apt source does not<br>
support the following args:<br>
<br>
=C2=A0 =C2=A0 &#39;--formatter&#39;, &#39;rustfmt&#39;,<br>
=C2=A0 =C2=A0 &#39;--merge-extern-blocks&#39;,<br>
=C2=A0 =C2=A0 &#39;--allowlist-file&#39;, meson.project_source_root() + &#3=
9;/include/.*&#39;,<br>
=C2=A0 =C2=A0 &#39;--allowlist-file&#39;, meson.project_source_root() + &#3=
9;/.*&#39;,<br>
=C2=A0 =C2=A0 &#39;--allowlist-file&#39;, meson.project_build_root() + &#39=
;/.*&#39;<br><br></blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Ouch. --allowlist-file was added in 0.60, so Debian has it. I =
think we should ask Canonical if they can update bindgen in addition to rus=
tc.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
The first two args are cosmetic and should not hurt if removed (but I<br>
need to double check).<br>
<br>
Removing the allowlist-file, however, causes IPPORT_RESERVED to be<br>
generated twice using different types and thus break the<br>
build. Allowlists for bindgen 0.59.1 can only be specified as regex on<br>
function, type or var. I don&#39;t find (yet) an equivalent way of<br>
--allowlist-file. A dirty trick is `--blocklist-item IPPORT_RESERVED`,<br>
which works but is so ad-hoc.<br>
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
</blockquote></div></div></div>

--000000000000fdc17006249351ad--


