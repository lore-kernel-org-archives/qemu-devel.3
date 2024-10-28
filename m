Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD5D13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 07:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Jrb-0001o1-A7; Mon, 28 Oct 2024 03:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5JrY-0001nm-Mf
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 03:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5JrW-0002RS-Vm
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 03:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730099305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BubUxtxCQyeCNrGy5J1oc2vYioknEIoFlwGKvpflUaA=;
 b=fBjFeSjj3YeSznaGh/Dj6zUMsXVBuHCUdrLgqeyF5ybo1FE7pXtjSlw5dHO0pHtuB8XsF0
 mVj+GQ/wK3QtrwDZflY5iuq2053jCg+2NsVyuzqjcCDGKIOlayBniwQl31PBY+uOZAv58V
 V+yuoMuspofKhmw3VnfMqfmWWHIoBtg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-3-wOrlDhOBqmlq2gIrj6uQ-1; Mon, 28 Oct 2024 03:08:23 -0400
X-MC-Unique: 3-wOrlDhOBqmlq2gIrj6uQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so2819567f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 00:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730099302; x=1730704102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BubUxtxCQyeCNrGy5J1oc2vYioknEIoFlwGKvpflUaA=;
 b=q0YBKcqMhgAxAeOOpXIJuJUY+SHZEJJ8/lH9KGqhcfMj05ljc0CrRMuh4sqthnh3ce
 kJu0y118u1kA4SCqR8uPv1eBDLSu4QvwiqjFDo9ihpysAeeQ6u8XU+f/g1ABR4V27ma2
 6U+R3NwUODg9b0TYKyw7bhZ9KTAA3iStApSg/tewJ+PSSdCDhHwxkunlzp9m0C0ntRTq
 S40rVsPA/oGyrbBRGgiWukH6reLsZ52R65AakErqFHYEJEqYc/soQvVl8wb9IEyvjwem
 kTJQSxpALaGGCtyziPB3mIq6Vy//JdXNKgb1/cShm5AWGGrFxDyL+2DRM1iTl8sm+4Oc
 jSkw==
X-Gm-Message-State: AOJu0YzzS5ebYzOqe65q4u5Xe7z/VZdn3JuPRcGXXRxlpZRMiRvH5pC+
 u8KdPZH810D/IOB4DZL1LJ3W+JOrw5QQmWmtLYYDlCtmX39zhKS6l76/Uljm25fgGqOc6s1Bam6
 z3cnY2uZx1uie4klKv7gLcrB56lA0MHY9f9E+79Z2ZETICIobOffvGCjdcRTVcbptLahcZwPi/l
 gVpFYXL7STGpS3VcW0PDKQHbdW/XI=
X-Received: by 2002:adf:e38e:0:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-38060f37478mr5013833f8f.24.1730099301922; 
 Mon, 28 Oct 2024 00:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5ugxgWhydzGrHO6KLTvQ2umr9+Aqjg5GVLzqLv9rRLRTasHrnZm5hDlOtr2xt1EVP8xP0w+7EEM0GK8yaPzg=
X-Received: by 2002:adf:e38e:0:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-38060f37478mr5013776f8f.24.1730099300759; Mon, 28 Oct 2024
 00:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
 <f7d087fe-e9cb-4021-b816-df43656e22f5@redhat.com>
 <CAAjaMXb+zzeZyrjdxO4ZAhWUOXN_Xoi5wuPJ4vYmJMsbV=gNWQ@mail.gmail.com>
In-Reply-To: <CAAjaMXb+zzeZyrjdxO4ZAhWUOXN_Xoi5wuPJ4vYmJMsbV=gNWQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Oct 2024 08:07:00 +0100
Message-ID: <CABgObfYNQB07X2BbxiDbCCWR6d+GaKxguR4VEZJ4xnokMfSiyA@mail.gmail.com>
Subject: Re: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003f9091062584221d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--0000000000003f9091062584221d
Content-Type: text/plain; charset="UTF-8"

Manos,

I understand your desire to make fast progress, at the same time I can't
stress enough the importance of building on a shared design. Each
architectural decision we make now - whether about trait hierarchies, macro
designs, or API patterns - will significantly impact future maintenance and
development work.

The suggestions about how to split the implementation into smaller patches
aim to facilitate smaller and easier discussions about specific aspects,
and they are only examples and in no way the only possible solution.
However, with respect to design choices I think I pointed out major issues
that can't be treated simply as wanting to "do everything at once".
Dismissing design discussions as mere disagreements about style, or
responding confrontationally that you will address "bits that are wrong and
not much else" won't help us move forward. Code reviews, especially for
core APIs, necessarily include discussion of design choices and language
usage.

This isn't the first time our technical discussions have become tense, and
we're talking past each other at this point. My suggestion is that you try
to explain your point of view to a third person, that can help you
understand the patch review process and what is requested of both code
contributors and reviewers.

Thanks,

Paolo


Il dom 27 ott 2024, 23:40 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> Thank you for the review comments Paolo. I will address any bits I did
> wrong and not much the rest, it's obvious you have a disagreement over
> how things are done and that's fine. This series does not attempt to
> solve everything at once and arguing again and again over "this Trait
> should have been OtherTrait and this thing should have been thing!()"
> is not productive. Your review style of relentless disagreement after
> disagreement is tiresome and impossible to deal with; it's like a
> denial of service for other human beings. I suggest you take a step
> back and take a deep breath before reviewing Rust patches again. I
> assure you I will make sure to address all your comments either in
> code, TODO comments, or patch messages.
>
> In the meantime, take it easy.
>
>

--0000000000003f9091062584221d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Manos,<div dir=3D"auto"><br></div><div dir=3D"auto">I und=
erstand your desire to make fast progress, at the same time I can&#39;t str=
ess enough the importance of building on a shared design. Each architectura=
l decision we make now - whether about trait hierarchies, macro designs, or=
 API patterns - will significantly impact future maintenance and developmen=
t work.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The suggestions =
about how to split the implementation into smaller patches aim to facilitat=
e smaller and easier discussions about specific aspects, and they are only =
examples and in no way the only possible solution. However, with respect to=
 design choices I think I pointed out major issues that can&#39;t be treate=
d simply as wanting to &quot;do everything at once&quot;. Dismissing design=
 discussions as mere disagreements about style, or responding confrontation=
ally that you will address &quot;bits that are wrong and not much else&quot=
; won&#39;t help us move forward. Code reviews, especially for core APIs, n=
ecessarily include discussion of design choices and language usage.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">This isn&#39;t the first time o=
ur technical discussions have become tense, and we&#39;re talking past each=
 other at this point. My suggestion is that you try to explain your point o=
f view to a third person, that can help you understand the patch review pro=
cess and what is requested of both code contributors and reviewers.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Paolo</div><br><br><div class=3D"gmail_quote" d=
ir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 27 ott 2024, 23:40=
 Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org" =
rel=3D"noreferrer noreferrer noreferrer noreferrer" target=3D"_blank">manos=
.pitsidianakis@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Thank you for the review comments Paolo. I wi=
ll address any bits I did<br>
wrong and not much the rest, it&#39;s obvious you have a disagreement over<=
br>
how things are done and that&#39;s fine. This series does not attempt to<br=
>
solve everything at once and arguing again and again over &quot;this Trait<=
br>
should have been OtherTrait and this thing should have been thing!()&quot;<=
br>
is not productive. Your review style of relentless disagreement after<br>
disagreement is tiresome and impossible to deal with; it&#39;s like a<br>
denial of service for other human beings. I suggest you take a step<br>
back and take a deep breath before reviewing Rust patches again. I<br>
assure you I will make sure to address all your comments either in<br>
code, TODO comments, or patch messages.<br>
<br>
In the meantime, take it easy.<br><br>
</blockquote></div>
</div>

--0000000000003f9091062584221d--


