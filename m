Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A46D59D65
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU5LG-0002Qj-W6; Fri, 12 Dec 2025 10:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vU5LG-0002QU-65
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vU5LE-0002AK-OF
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765554358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nP046b2/vM2t9rT4AQvzTz15K181k+rWANoJc8cS6ec=;
 b=G9/KpfeukS6v4rUMWnfhMk8L2pyaDaqBQrx55Svx3ZLBRLtJo7lmyILBKwWEzyVXCPVHwH
 JoWQFjW+pGpaB/RhYnT4hQbOImiWsipkpS64hZv8UAif+pLAFr4WsT7kOd6goafnJEgazU
 l3Nc0putmnpsLmymi7o+qI02m61fBOg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-XVS-FrXyNeSF182rkVFIoQ-1; Fri, 12 Dec 2025 10:45:56 -0500
X-MC-Unique: XVS-FrXyNeSF182rkVFIoQ-1
X-Mimecast-MFC-AGG-ID: XVS-FrXyNeSF182rkVFIoQ_1765554355
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42e2d6d13d1so750371f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765554355; x=1766159155; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nP046b2/vM2t9rT4AQvzTz15K181k+rWANoJc8cS6ec=;
 b=nwznBJqMgIJ+TWh0EgBnuh2bLtokJYRIpTL97563WU4Oa5XSwKif4Moch/5VfVErQw
 yg//MgqPpFElKEV89SORQCFVLfF4vNogtBfYJ34QnYtdFkD2/qwt6QwfGIlwtFMdPWYo
 tX+4HBLCJ4I0l+aIUGPccb8XDYpKR7QSE+yjumII5ET47yMbEeYjxTKUXMyiGxnTe+AP
 E0kjVXp+m6qu7NHiSr8vzH+FxdbfocTsGTKiTtvWn9/x8fibNXRpJyWya0vf5Qqogv2E
 qpM4vIdPeV2ocl5hOIjfs7tldpF15GMme9RQrDRQB6TLrIE5G7mdNCWVqYXNQTuqHCo7
 /VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765554355; x=1766159155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nP046b2/vM2t9rT4AQvzTz15K181k+rWANoJc8cS6ec=;
 b=frgfXMRIqiLI6itNq4+DeBv7GNDTedIgqNvaesJgEph6L15bJ4eBwmu4r637mIu+Yn
 SPQcTzCb/0P5r4rbMta8HneJHbP1GVilhw1qxAq4xbPwkJgLBVWSQIZoPeQxM1qZnvz6
 AhtvmuHKPsdStqkwZCyFVqpVqee5AndQCVHlL2VheT8iRvHr9cZfQuFPnXDF2n2T20kG
 Gmc8bu8ZpJSrXVX+3iTtXpEH/R5cpkq8Ks9z5WlZVhRwkPBwCB9JAJdRIjQvPOPDKlTL
 p0hmTg7Im6zzTZAJaqvWS41hHbhnZ4yywDRqpZmMSbDCkV6gUZY+DUDMmGOiYvlbdpL0
 NCgw==
X-Gm-Message-State: AOJu0Yw2jhK+uV3pJkOJrG88ob16+tKn2gTDbCE8ZpUCqwKo2M0w/iis
 aNKqDzvtXel6QApPqw7s1zmURkUCC+V1kX3BTwKgJmb/8tSiXu7gJ20T7L5vWwWSKulxoLCUJOK
 CwrR9Kk78z0TCQYMWaT7YP0+TGqwW9s5o4+I3RLYjHRb5WHEh3H3DMtSH8UG8jxON4K8SInKIKI
 ZiowOzJ/mr0wI+dditdpWJaVFlmVR42DQ=
X-Gm-Gg: AY/fxX4XvSqryS8M+o3ZVKPdaEE3+mye2VH/0hAKpGhtwdbHR779IlkqEhxQ28cLC9I
 v7I3yINVL3qal84H946m378iDC/LnKQyV/04JJidOJ+rlp6w6eqchtsRjFdmobVM5HEjHmwhdlO
 piSj3/9DuuLhLYGEbHBmVkejuoQ8SxexYhb7kxz4T04kr4SWi0gApnP9ZBmDNbqUMMtglnc8Qi8
 RRM2la9mwAW2pULEK1JmgKwCCUzfEjl1HF46Dpx3cYyR38u28AJ49zoxqx3Y81DmBINuA==
X-Received: by 2002:a05:6000:2585:b0:42b:47da:c318 with SMTP id
 ffacd0b85a97d-42fb4912914mr2650163f8f.52.1765554355445; 
 Fri, 12 Dec 2025 07:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE652BBL1tW5QrleqADPou4pyecyXGCrigKUe2aU1qLnfF/lj6d1X9X8zg9hbhTcZr5F2pp4bd0GeZdJVdfvdU=
X-Received: by 2002:a05:6000:2585:b0:42b:47da:c318 with SMTP id
 ffacd0b85a97d-42fb4912914mr2650145f8f.52.1765554355067; Fri, 12 Dec 2025
 07:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-17-pbonzini@redhat.com>
 <f5bd56df-e586-4cce-9325-8ce9ed702e4d@linaro.org>
In-Reply-To: <f5bd56df-e586-4cce-9325-8ce9ed702e4d@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Dec 2025 16:45:44 +0100
X-Gm-Features: AQt7F2o75kIm6T_-wI0rgkKycJJ7HYEidau-DKYKqFW2Sc_x9AWJeNQRhlUAjBw
Message-ID: <CABgObfbBacG=cFv614S5CAj-pG=-x+EdaQO5G0aW_zhR8YA=Gg@mail.gmail.com>
Subject: Re: [PATCH 16/18] target/i386/tcg: commonize code to compute SF/ZF/PF
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002a74e50645c32873"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000002a74e50645c32873
Content-Type: text/plain; charset="UTF-8"

Il gio 11 dic 2025, 19:46 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 12/10/25 07:16, Paolo Bonzini wrote:
> > +psz_b:
> > +    shift += 8;
> > +psz_w:
> > +    shift += 16;
> > +psz_l:
> > +#ifdef TARGET_X86_64
> > +    shift += 32;
> > +psz_q:
> > +#endif
>
> Oof.  Use cc_op_size instead of a set of gotos.
>

I was so proud :) I will check what the code produced with cc_op_size looks
like.

Paolo

--0000000000002a74e50645c32873
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 11 dic 2025, 19:46 Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 12/10/25 07:16, Paolo Bonzini wrote:<br>
&gt; +psz_b:<br>
&gt; +=C2=A0 =C2=A0 shift +=3D 8;<br>
&gt; +psz_w:<br>
&gt; +=C2=A0 =C2=A0 shift +=3D 16;<br>
&gt; +psz_l:<br>
&gt; +#ifdef TARGET_X86_64<br>
&gt; +=C2=A0 =C2=A0 shift +=3D 32;<br>
&gt; +psz_q:<br>
&gt; +#endif<br>
<br>
Oof.=C2=A0 Use cc_op_size instead of a set of gotos.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">I was so proud :) I wil=
l check what the code produced with cc_op_size looks like.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--0000000000002a74e50645c32873--


