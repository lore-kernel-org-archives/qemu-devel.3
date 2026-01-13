Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE80D29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfalw-0003zl-5w; Tue, 13 Jan 2026 04:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfalu-0003xu-IY
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfals-0002jx-JN
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768296783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcHx0VJQKDaxpqB74+fd+/Ne33G4yUu8ZFKA3Cmuf8U=;
 b=JLe8gBLTqQ3Gs3tHCNY27FMqlqLn72wKyI+nEnk5VWBsM0KRtR72VWtbS5fMH4RJKWcFdW
 vfHjVBflDh+q1r6/AUcnpZn95eR9CzOC8YLdJaEaYcWHmQhivW30MkM8AZL+wsQNlXdyfj
 TEO6OohCASfj4pLFLT1RvW1BhAswsQo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-QID3lwE_N8WZWayGK1hh1Q-1; Tue, 13 Jan 2026 04:33:00 -0500
X-MC-Unique: QID3lwE_N8WZWayGK1hh1Q-1
X-Mimecast-MFC-AGG-ID: QID3lwE_N8WZWayGK1hh1Q_1768296779
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ed980309aso2551855e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 01:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768296779; x=1768901579; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DcHx0VJQKDaxpqB74+fd+/Ne33G4yUu8ZFKA3Cmuf8U=;
 b=aoXNWAU1xEuiVz1u+5ahpnuk8leUeQzMcgQGtdEkKfBqDEmaHLAtSlgA0+dB6kYTtN
 vOqCbHx9sXSGhYV6uORP7RdqVklpv8ioTqQppmneiH+2oOWB43xetZK/h754xZAnzJRo
 rM8zWFAWw8QFyGgWeq1pC9EDf75wXIARQl5Q5sUnsMvcc/EHVBOfgN5VQqGuDQm7Sqy1
 Yc2KrG0TJZMQ8j7dRtxtIbV0ghl/eLPSJpkTKLtR71P5REc4JgXRTDFmJmoMy0DJNzu1
 QERZFfnUquh/1ftIl7XDrqV2mrO4LmIV/5gYbR31Y7VOQkKD3UHqfoUXSh2pkdryoFuN
 dEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768296779; x=1768901579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcHx0VJQKDaxpqB74+fd+/Ne33G4yUu8ZFKA3Cmuf8U=;
 b=qyUIU/4W/YZeUBWUayWUuR106mCWnhX33AGKmvzSUZ0pQa7rfFfQptnQmU7W5xWtD/
 +xliCfKHkqBQRnCQAJcCc8AS6O1/4AolD2IRzBQ8buAg/wnHroOda+KW2/6uns6FMFqI
 ZtBQq+lTH4OAgqCYBczx+Jmlm0PR8MRzCmPHEd7F9nzJiw11UF19aemTevWhSHJNhWHq
 LhdVYQOxxfjHuAz6GncR3yvmCuHDIVB/PHx6Sn4eHSNFIQMek+JvWOwA+vjIZxX1dNoZ
 btQvTR11wCNixCCIAI6YfJuc0+8rWAt/zl0yg3SsFciYAnqZ7Hy2cAU0HA8Gf3SU1GlE
 1A1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzOFUPjQhUNqkqydYDPGzMuVOE7dMQZCwT2iUC6agRsk50q6iqaGrQBlAoIqXnLh6OAEULKzh6khCj@nongnu.org
X-Gm-Message-State: AOJu0YyqLkSL1LOxRs6nis6URg6/MwpgWvrBhdQC9OXNAHIyHuRZ+lAh
 +qowtTrDhiCTuAncHz4StvHJkBl6pQ5Ha4/Gy9m6k2PqrL1OJe0KkWdoCXZvYySjmQfN6d5j7DL
 CNncKPeHaMQznfe416pHIZkgVfBIUaxYYFvRGNVYkzQklU5PJi0XOmwRk8oOkkuORKgX2BHJfz7
 weRTPinFcWypFYeIZiIDlvtqpWJ+ZB8BU=
X-Gm-Gg: AY/fxX6K9HxZ7LEDqbbf06j9VAo0oTwAgIXLua9p45hhTW3+Z7nQgL8RJBS4pn6MqPj
 j9ah5QrU1BRE/tVV+Kmpvsf23ELEuoqJ+96SQ3768+nEUAsQSXYetSfzPH4RCETY9rQxS2HgXva
 96S2XJvSyz5/LHW60H2ibf7o0ctE1Di7AUjmZWK1NZZx2ns29IuJlmubxiwoAZ6MKD9lpQ/vhyF
 wx4HjLmmHw8/awfUvR+fT/FOrNwqr5lP8UCuSIGKlurHAzP2zzWUKmvoAT/bqI3p2SoBg==
X-Received: by 2002:a05:600d:1:b0:47e:d9e8:2f3a with SMTP id
 5b1f17b1804b1-47ed9e8328emr15566155e9.2.1768296778879; 
 Tue, 13 Jan 2026 01:32:58 -0800 (PST)
X-Received: by 2002:a05:600d:1:b0:47e:d9e8:2f3a with SMTP id
 5b1f17b1804b1-47ed9e8328emr15565685e9.2.1768296778422; Tue, 13 Jan 2026
 01:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-3-berrange@redhat.com>
 <d3ca3fb5-e972-4446-b32c-f20fd8825cca@redhat.com>
 <aWDqie0eYZ8GeQHF@redhat.com>
 <6e60a89f-6798-4ea5-bbd0-553130786cec@redhat.com>
 <87h5spc29h.fsf@pond.sub.org>
In-Reply-To: <87h5spc29h.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Jan 2026 10:32:48 +0100
X-Gm-Features: AZwV_QjBui_AHximCMjI_GdL-uL-mZ9k7PVgUI5z8ovgrM_uzTko43bpW2TT_eM
Message-ID: <CABgObfZn753g5Ve4AHi4gX0DtKdDBWV8aCuRSha5ySv9Y_4OGg@mail.gmail.com>
Subject: Re: [PATCH v5 02/24] include: define constant for early constructor
 priority
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000055ef9b064841adda"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000055ef9b064841adda
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 13 gen 2026, 10:04 Markus Armbruster <armbru@redhat.com> ha scritto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 1/9/26 12:46, Daniel P. Berrang=C3=A9 wrote:
> >> IMHO the root problem is that it is pretty dubious for us to be
> >> spawning the RCU thread from a constructor. Constructors should
> >> be limited to minimal initialization of state.
>
> Yes!  Discussed in review of v3:
>
>     https://lore.kernel.org/qemu-devel/87frck1dds.fsf@pond.sub.org/
>     Message-ID: <87frck1dds.fsf@pond.sub.org>
>
> >>                                                Spawning threads
> >> is outside the boundary of what I'd consider reasonable for
> >> a constructor todo. I didn't want try to tackle refactoring the
> >> RCU thread creation though, hence this gross workaround.
> >
> > I see.  Maybe we could (just as gross but smaller) do the RCU
> constructor late.  Not something that you need to do now, of course.
>
> Could we use an old-fashioned initialization function instead of a
> constructor for RCU?
>

You have to do it in all main()s, which make it unwieldy for tests etc.

Another possibility is to do it lazily on first call_rcu, and just clear
the flag in the atfork callbacks.

Paolo


>

--00000000000055ef9b064841adda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 13 gen 2026, 10:04 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; On 1/9/26 12:46, Daniel P. Berrang=C3=A9 wrote:<br>
&gt;&gt; IMHO the root problem is that it is pretty dubious for us to be<br=
>
&gt;&gt; spawning the RCU thread from a constructor. Constructors should<br=
>
&gt;&gt; be limited to minimal initialization of state.<br>
<br>
Yes!=C2=A0 Discussed in review of v3:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://lore.kernel.org/qemu-devel/87frck1dds.fsf@=
pond.sub.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore=
.kernel.org/qemu-devel/87frck1dds.fsf@pond.sub.org/</a><br>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:87frck1dds.fsf@pond.sub.org=
" target=3D"_blank" rel=3D"noreferrer">87frck1dds.fsf@pond.sub.org</a>&gt;<=
br>
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Spawning threads<br>
&gt;&gt; is outside the boundary of what I&#39;d consider reasonable for<br=
>
&gt;&gt; a constructor todo. I didn&#39;t want try to tackle refactoring th=
e<br>
&gt;&gt; RCU thread creation though, hence this gross workaround.<br>
&gt;<br>
&gt; I see.=C2=A0 Maybe we could (just as gross but smaller) do the RCU con=
structor late.=C2=A0 Not something that you need to do now, of course.<br>
<br>
Could we use an old-fashioned initialization function instead of a<br>
constructor for RCU?<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">You have to do it in all main()s, which make it unwield=
y for tests etc.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Another=
 possibility is to do it lazily on first call_rcu, and just clear the flag =
in the atfork callbacks.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
</blockquote></div></div></div>

--00000000000055ef9b064841adda--


