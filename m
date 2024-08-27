Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03A6C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyEk-0001Am-2u; Tue, 27 Aug 2024 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1siyEi-0001AC-C5
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1siyEg-0003V1-PY
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724772957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hXBj1zpRbkovYQZaFT0xfH4IPmRYfCibUwJ+bcQKbJQ=;
 b=YfGx13I+OvNy5U82pAmXIZB+13I6zFpHhZE5kEUsPyLvn2q/SjLJkHD8WlbRd6sNqk67bM
 r7vHZSlW/LThh+1P6ajIpoV9iE0iDih+rhF5d4lhw/IlUY7h2KkDZqmZ49ImMfdSOLAfYt
 Hbhjup2s51wtts3tGK8pFhtFQ4Eiz0w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ig-nihKFN2WLGq6JdIw0bQ-1; Tue, 27 Aug 2024 11:35:56 -0400
X-MC-Unique: ig-nihKFN2WLGq6JdIw0bQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a86690270dcso542366566b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724772954; x=1725377754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hXBj1zpRbkovYQZaFT0xfH4IPmRYfCibUwJ+bcQKbJQ=;
 b=ClzpV7lRzDKlrHiSmxU4mMFJI0Glt+03nz5Jr2B4uZcooWayup6LGEQo/4vKjsyw/y
 h7X+7R0aij0TbMYXvzpuWID1BluEL/HxNJc44oVRVZyY66Aue+RIMPe9/doReFIYpiDr
 AaUEyDOS/+Yb6ibz+MnP8YbMDpXzqb0t5xo02iZ97V92iHS9X4yujQluXrJ3r1kIKOOw
 y3UNDvE3G8RwU3hR36X5AgX3MAMnSMK4HA5SEDY6V4A0seqSt9kcJ2zNbfkdh+zYVrc3
 riJNV6945TdBBaUKpGgQg7JV4WD2dcm8/1O2LSsS0F9AEaSsrzY3R/8/PKuendY5T9d4
 Ytqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNDJHOnSfWCHFnVYqB7VkMMrAgiyY7DlFV8Tfua5er/E7rX5G2NH+J3yHOTzsAy4h+2agGvQRVE0g9@nongnu.org
X-Gm-Message-State: AOJu0YzAtO2Lw0K1oEA7uxRtUX4sEyhfgMwQZMImz6U7rvHqGoofv33w
 VOdXSmIl3N59ZfVgCdgABYXNObA/YXEjGyu6CLhZtOJMhwIXvKHC9KO8bYcFDhx6ESGBZtYiZwN
 Rp47I6IZmSQp4b16RzXsYwSg7NFhCA4ke+D9FLuE3VoZIdDjhFbpiKTtuc8TBVlvfe8LdCQC4sD
 P3S4mNDMym1iGQoLFl2EA7+n4HMaEUtGGh6lawNg==
X-Received: by 2002:a17:907:9487:b0:a86:bb5f:ebbd with SMTP id
 a640c23a62f3a-a86e3d40516mr243557066b.63.1724772954591; 
 Tue, 27 Aug 2024 08:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFVrH03ygMqYp0dtnyox9CSJB2OqtA2jRh0d50Y7xj5QsIaKIk2zUL1n5zS5DbboAYfA7UIkUmhe+ailZoa1U=
X-Received: by 2002:a17:907:9487:b0:a86:bb5f:ebbd with SMTP id
 a640c23a62f3a-a86e3d40516mr243555366b.63.1724772954141; Tue, 27 Aug 2024
 08:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240827151022.37992-1-anisinha@redhat.com>
 <20240827151022.37992-3-anisinha@redhat.com>
 <CAFEAcA9Xq7S6_-hYkNYdv6-z7tM7xSgDGyC92L19kTm02qScAw@mail.gmail.com>
In-Reply-To: <CAFEAcA9Xq7S6_-hYkNYdv6-z7tM7xSgDGyC92L19kTm02qScAw@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 27 Aug 2024 21:05:41 +0530
Message-ID: <CAK3XEhPPWvRuzc=DZiP0ni-c9-KsT6=R+9_XAM5224KsiARh=g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kvm: refactor core virtual machine creation into
 its own function
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 cfontana@suse.de, 
 Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000401a3c0620abff37"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000401a3c0620abff37
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug, 2024, 8:59 pm Peter Maydell, <peter.maydell@linaro.org>
wrote:

> On Tue, 27 Aug 2024 at 16:11, Ani Sinha <anisinha@redhat.com> wrote:
> >
> > Refactoring the core logic around KVM_CREATE_VM into its own separate
> function
> > so that it can be called from other functions in subsequent patches.
> There is
> > no functional change in this patch.
>
> What subsequent patches? This is patch 2 of 2...
>

I intend to post them later as a part of a larger patch series when my
changes have stabilized.



>

--000000000000401a3c0620abff37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, 27 Aug, 2024, 8:59 pm Peter Maydell, &lt;<a hr=
ef=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Tue, 27 Aug 2024 at 16:11, A=
ni Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">anisinha@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Refactoring the core logic around KVM_CREATE_VM into its own separate =
function<br>
&gt; so that it can be called from other functions in subsequent patches. T=
here is<br>
&gt; no functional change in this patch.<br>
<br>
What subsequent patches? This is patch 2 of 2...<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">I intend to post them later=
 as a part of a larger patch series when my changes have stabilized.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
</blockquote></div></div></div>

--000000000000401a3c0620abff37--


