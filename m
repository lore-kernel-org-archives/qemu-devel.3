Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8793C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9U7f-0008Pb-3t; Mon, 28 Apr 2025 15:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9U7a-00089j-VM
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9U7W-0007mk-In
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745868377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reoO9WwG9kD8Bqut2r9HmOF5uG44ei84eP9T5qRklqA=;
 b=Sk6W/cM7ng65RrFFgJZyWeat+pESkiBPb3GU8Oc3w0XN1bWrAipz3HFQ1QLqN61PtC6eq5
 hvqFCuG7GSiUAHAIK7zrC7TfjXd5V+O9SnOzU8VWf6wjaH8tM8BClxVCVLSaWWocp9Lq7A
 iycI+QovCSSQ9VL0ZtGVmoJKpcthzDk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-xhfaBfgTN5aK89voOaTq_Q-1; Mon, 28 Apr 2025 15:26:16 -0400
X-MC-Unique: xhfaBfgTN5aK89voOaTq_Q-1
X-Mimecast-MFC-AGG-ID: xhfaBfgTN5aK89voOaTq_Q_1745868375
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so30905205e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868375; x=1746473175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=reoO9WwG9kD8Bqut2r9HmOF5uG44ei84eP9T5qRklqA=;
 b=q+qe0rnyeo0rsj0n07/W0qyrOe+pVtF796Kf6Cg+swKHyYpUu1zNYSooXqTeALBB4R
 PA0wS0DDerL0xF0ulP++Jkcj+4C4U6tT2I1ferGwte3ZuATbuWuwUK4eujs4J2PywO1N
 W4eLSdaal9FKew4PrfzXdTGhRmA7wJs6eS7ur8KX75+SAkKmSLufyH9OjSOehjZOHpfz
 J7NRb5a9/DTT3Dqb2c77dfB/D1JPw0cE1LYGllTZlCTiZUdRbbfvFMfrh6uZGdFUARuF
 AiFsMe6DZnPo39q3JjbBYl7E8w+c2T613TDarGlCqjGQyn/pTByYD0hyvXzlNGLgZbvp
 IG0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR5jm1RHbIYz/nSPszm281UyjsCBRy37DN03n17iET8C6lJB7JaZBkycqjIuVV0PhISNIU6J9RK0fG@nongnu.org
X-Gm-Message-State: AOJu0Yyanc+9NzUmmadbuqxhIU42aTgUAT8MQfyBqL9SnsLTtPjdbMpB
 ZRUaiiBDyKat2yFkKrxGAGZ7km32Y1jGZ+U24uOIKGZAJsJkUNj+wk2thEJC9DwpeXGlRjRT+1v
 arrKV0+HO+KRJKExQi16eYpAxNP+SspPOcOPRATKj7k2cpS8ipmhB+MQSOl7hiy3NIzgzpgW3S/
 b1yMEKgF2RuNTiVVjD4MpDDh5ge4g=
X-Gm-Gg: ASbGnctQ0YQ/2eGv8XTDf957Q+XvnM4l5dXelxt+Tu9WySN7jdH+y5jBsKTkmu8ku9U
 w1OfOpb/zj1RSgfy384tTb3ikbACTJx/QZJ02BGaK97DjTNA3EZwEP9yVuij0Gz1E9xLP
X-Received: by 2002:a05:600c:45c9:b0:43d:1840:a13f with SMTP id
 5b1f17b1804b1-440a66abe3cmr101124145e9.25.1745868374788; 
 Mon, 28 Apr 2025 12:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN+8+06AFPnzq9z/nQcRNDLP+zLDB+hGoJmVhjB6svmaANL2nM8vizc3TCPe+nI/myhZ8CCS6U0dB56IFRHfw=
X-Received: by 2002:a05:600c:45c9:b0:43d:1840:a13f with SMTP id
 5b1f17b1804b1-440a66abe3cmr101124005e9.25.1745868374365; Mon, 28 Apr 2025
 12:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250428073442.315770-1-pbonzini@redhat.com>
 <20250428073442.315770-9-pbonzini@redhat.com>
 <30770d2b-ac76-4d13-b8f2-ca39c0b82e0f@ventanamicro.com>
 <CABgObfZX1j4N=Oeq9Y=_YeccCq7--s0=r5DaANA+iA1UnoJyVg@mail.gmail.com>
 <7cf90706-05e8-40b7-aef5-108c2d7234df@linaro.org>
In-Reply-To: <7cf90706-05e8-40b7-aef5-108c2d7234df@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Apr 2025 21:26:01 +0200
X-Gm-Features: ATxdqUEM9xEBhLhw3-g05s9vLhGl60sg_6QaFd-DQsvCMwVAuTdQcMEwgGMt4kU
Message-ID: <CABgObfZE1tqVxyVeb30Wuewp=Gna=7z7+z3kp5YD+HVzoZbe5A@mail.gmail.com>
Subject: Re: [PATCH 08/26] target/riscv: store RISCVCPUDef struct directly in
 the class
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="000000000000476f1c0633dba831"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--000000000000476f1c0633dba831
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 28 apr 2025, 17:21 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> >> Are we sure this patch compiles?
> >
> > No, you're right; I was not aware that RISC-V KVM is not covered by
> > CI. I'm sorry.
>
> I remember doing it and Daniel reviewed it...:
>
> https://lore.kernel.org/qemu-devel/20230703183145.24779-1-philmd@linaro.o=
rg/
>
> I suppose the shame is on me for not insisting getting it merged,
> wasting my own time.
>

This is not a --disable-tcg issue, it's just a RISC-V host issue. Flaky
cross RISC-V toolchains, that caused it to be removed from CI, but I didn't
make 2+2. It should be added back soon as I understand it.

Paolo

>

--000000000000476f1c0633dba831
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 28 apr 2025, 17:21 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt;&gt; Are we sure this patch compiles?<br>
&gt; <br>
&gt; No, you&#39;re right; I was not aware that RISC-V KVM is not covered b=
y<br>
&gt; CI. I&#39;m sorry.<br>
<br>
I remember doing it and Daniel reviewed it...:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20230703183145.24779-1-philmd=
@linaro.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/20230703183145.24779-1-philmd@linaro.org/</a><br>
<br>
I suppose the shame is on me for not insisting getting it merged,<br>
wasting my own time.<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">This is not a --disable-tcg issue, it&#39;s just a RISC=
-V host issue. Flaky cross RISC-V toolchains, that caused it to be removed =
from CI, but I didn&#39;t make 2+2. It should be added back soon as I under=
stand it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</d=
iv><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--000000000000476f1c0633dba831--


