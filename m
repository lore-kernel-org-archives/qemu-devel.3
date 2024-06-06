Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3915DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 06:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF6fg-0002ae-Lp; Thu, 06 Jun 2024 02:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF6ff-0002aH-1j
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF6fd-0002bX-IQ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717655540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1b/BdfzSA2IoDyEC++Ll4lrKKnG8iriFCEK5xzi77pE=;
 b=IAFTkJ2bksjX+xpuXq6a2KBey9rCjFtJP0lWVrnE+0upQzFuIdcRO46SWSMmDoTrWyjM5b
 vHISbgQnrZ2UfOeZPRdMbv3sz8KcnBgxl00SdlOqnDGu9QVbvTWEYsW3Pn5UtauCRnHCpO
 WAhwQ10ucI44Ma3v7njrQJEGcuUe46w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-DZm2qodNO-OQNepZrg5K5w-1; Thu, 06 Jun 2024 02:32:17 -0400
X-MC-Unique: DZm2qodNO-OQNepZrg5K5w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dceae6283so565881f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 23:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717655536; x=1718260336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1b/BdfzSA2IoDyEC++Ll4lrKKnG8iriFCEK5xzi77pE=;
 b=C2W79Y+fN8gtKq8/ufNjpdqn494D4W1+6nKchi+l+xUNPafoFstRfz6AXFqiomCLCV
 O96OCNY4a895c4X1T+1PRTQNOF37RpSHrIC43/KojHqNQawKXae7DnnAM/sOPbRVx1eC
 VqEBqtovxFKZ9tzPOqy3ujzRjHkRIC0VGY4LlHQg/hluiVjJMpTulArvWnDtYc5DGan+
 0u1NPItxQKmQOebIB77a1UH+rXjPXWca0+UHt5RafLZHc6uV5Qj06z6p0mjhx2sG5r8H
 vz7BKgKwEIW2sC3kA6a80AT2L4+VMxUskirWxU7r+jTU+ucHuOtzQZFKQJdAShpDrXBB
 Ngzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNiOPDIRAybhKNvTMjamvOOBms6pzLRisjXhBwiPABsc5jQ1Oak2Y9h9FpiSEvUfXg7i8TWwlb+nf8IjdA3A1tn+/bDwA=
X-Gm-Message-State: AOJu0Yz9bwp2cfs1dqlrds/Qs6pALpqV2g7uw7GOFaInYTW3BnA0lGDj
 qJxpzOlRWM7c/DkhzC9WrmUd8yKN4Z0zfYPMse8Q5WcbhSKWP8dwwxny7ASWv3NPB346YyIQXCl
 ZTjkQTGcZvabwncT+ERJMscKK0ZNWn9O/CSir1RiZ18MAcGzW+PsSqDD3IMkxeE4khoIZ4hzx6I
 uC50TTavUnBhs72TDhnYninAPxueY=
X-Received: by 2002:a5d:64c3:0:b0:356:6c6f:2609 with SMTP id
 ffacd0b85a97d-35e84070f54mr3775833f8f.17.1717655536705; 
 Wed, 05 Jun 2024 23:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4ndmajIIbwlULIRcS0UAzUfHJkoe2h5HYsp0ggjQAIdq4c6bcBiJELK20Cgy2kkuhCsORuQDY/IIjniKA440=
X-Received: by 2002:a5d:64c3:0:b0:356:6c6f:2609 with SMTP id
 ffacd0b85a97d-35e84070f54mr3775790f8f.17.1717655535813; Wed, 05 Jun 2024
 23:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240605224409.2103109-1-pbonzini@redhat.com>
 <ZmEwvsAnh1lXNqhS@intel.com>
 <b930a4ea-73a3-40a8-bbc1-def8aea72c5d@linaro.org>
In-Reply-To: <b930a4ea-73a3-40a8-bbc1-def8aea72c5d@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Jun 2024 08:32:03 +0200
Message-ID: <CABgObfaX7kC3XMVp=Tvdgz8o8SyoVcyrheNFTKGD0m1Sn_+O8A@mail.gmail.com>
Subject: Re: [PATCH] target/i386: SEV: do not assume machine->cgs is SEV
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: multipart/alternative; boundary="0000000000000f22a6061a32d813"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000000f22a6061a32d813
Content-Type: text/plain; charset="UTF-8"

Il gio 6 giu 2024, 05:52 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> > SEV_COMMON(object_dynamic_cast()) looks to be twice cast, we can just
> > force to do conversion with pointer type:
> >
> > (SevCommonState *) object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON)
>
> You don't need the explicit cast either, since C auto-converts from void*.
>
>    sev_common = object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON);
>

Doh, of course. Thanks to both!

Paolo


>
> r~
>
>

--0000000000000f22a6061a32d813
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 6 giu 2024, 05:52 Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&g=
t; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; SEV_COMMON(object_dynamic_cast()) looks to be twice cast, we can just<=
br>
&gt; force to do conversion with pointer type:<br>
&gt; <br>
&gt; (SevCommonState *) object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON)<b=
r>
<br>
You don&#39;t need the explicit cast either, since C auto-converts from voi=
d*.<br>
<br>
=C2=A0 =C2=A0sev_common =3D object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMO=
N);<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Doh, of course. Thanks to both!</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--0000000000000f22a6061a32d813--


