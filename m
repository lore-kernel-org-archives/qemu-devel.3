Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EA8C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 06:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua7MD-0007AN-9Q; Fri, 11 Jul 2025 02:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua7MB-00079Z-AD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 02:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua7M8-0004iQ-HD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 02:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752215734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luclihnm42xg3dXz5nOTFOCtqSVaSFHbPTtBJWm+Rns=;
 b=RUrzduUJLmz8IXuFyHB8j+WEKOuWV62rg5liNT8qtIRhb/TLdQDT6YApi9PZUFouYb55JT
 hx+957fWWnLnvgOU+ro8fvfKlPpxX2gknq3Av48P6R0k9qzWU6Icn9rcZ9MR1HnOCZP0FF
 J1V6FKe1Yw1Ann7Nyz9ua/zRrRYrVjk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-s8bVZA73MS6qBlqm7NUySQ-1; Fri, 11 Jul 2025 02:35:33 -0400
X-MC-Unique: s8bVZA73MS6qBlqm7NUySQ-1
X-Mimecast-MFC-AGG-ID: s8bVZA73MS6qBlqm7NUySQ_1752215732
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31218e2d5b0so3277806a91.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 23:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752215731; x=1752820531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=luclihnm42xg3dXz5nOTFOCtqSVaSFHbPTtBJWm+Rns=;
 b=ObcNIIa7igCK+EHC3DtuPWEg35A6/KPaa5anQKs+KkpKwmhSLPYWcf1CULYdWPgOEs
 YKfwWlmS26U/sD6Vq79YqhT5tke+DltSBKboWOqb9srrOQBruBbuBiN0OxyaosYeAggQ
 enJ26Rw8ZNg4j9i0HyFCSnaKlZzwHqNrhO1A0XmfCkPwIzMdzz5Wc2NeFLkomI3ZBUYw
 sFLWE3J51nTv29br6axHuMqpjWngM2a19fzw5qrgOnuN+VW0GYv2odjaUXIZLGWUnWKM
 24BbgjEuCKiolOX2d9qt/Jf92LqitFkg6KyLqDOTT8Ypdi3NZuPdiN9dUhtyJOyp0rSK
 bqbA==
X-Gm-Message-State: AOJu0YzJnH9HtahiXVch8h6Dc0KH76576ctcHGGuA6SHtvdKU67i1php
 hlRUffsCnyM6AvMZJMDYFLhuUlmEqLR7B/EsQCBYpx7ftXHPKraWRzQJ8tiNkwL4RLEJYbawOB2
 0+yuOgThVQ+WdrKtC3ddPJXejuW5s2eDsH0UMcveYRCVMecpeoJUOQlktS5hx6j9spahoNNKkp7
 D1BlQsbaaiUGQl8HqmcnCl33EPwpBWaOvjvk7BJZQ=
X-Gm-Gg: ASbGncuwvuQRLeB1f99BLmXduC6ugzYRAZaXCK8lnbk/aLBFRE+3uIQA9MRvgo8sf9V
 3I/eQ0U9EJI+01FjAB2y3xuXYyiTeJk2KCop5IbygDhKB9mIUyLNnKSYLWkl8tR9pclsIXSOUzu
 vbtvrJB3bSMvqvDHtrk4vXAA==
X-Received: by 2002:a17:90b:58f0:b0:311:df4b:4b94 with SMTP id
 98e67ed59e1d1-31c4ca64d62mr3236437a91.4.1752215730647; 
 Thu, 10 Jul 2025 23:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdOruhuqzLEswbR2q/aHeON5cLQSF6tkQ9DCmXOYK5asi8w+YvOH/7ebZk38VaTMzSYo7hgeEPfdvHBzvXau0=
X-Received: by 2002:a17:90b:58f0:b0:311:df4b:4b94 with SMTP id
 98e67ed59e1d1-31c4ca64d62mr3236406a91.4.1752215730279; Thu, 10 Jul 2025
 23:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-3-pbonzini@redhat.com>
 <92d23086-7866-44a0-b54e-7690c0306248@intel.com>
In-Reply-To: <92d23086-7866-44a0-b54e-7690c0306248@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 Jul 2025 08:35:13 +0200
X-Gm-Features: Ac12FXxgID-OCbApCCmL4-wj6m0l9os0s1yT_Jq1CLtHhcIqCUCOHFBXiwdR7v4
Message-ID: <CABgObfbPXmBLrScC3nQMT5A7mf1xz0hSnkLdrvcFS=hGr3dxSg@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/i386: nvmm, whpx: add accel/CPU class that
 sets host vendor
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="0000000000002c76f30639a18422"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000002c76f30639a18422
Content-Type: text/plain; charset="UTF-8"

Il ven 11 lug 2025, 04:18 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> Besides, do we need to call host_cpu_max_instance_init() for the case of
> xcc->max_features, like what has been done for kvm and hvf?
>

I am intentionally skipping that because it would not have any effect and
there is no equivalent to KVM_GET_SUPPORTED_CPUID2 implemented for those
accelerators.

Paolo


>

--0000000000002c76f30639a18422
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 11 lug 2025, 04:18 Xiaoya=
o Li &lt;<a href=3D"mailto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&g=
t; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Besides, do we need to call host_cpu_max_instance_init() for the case of <b=
r>
xcc-&gt;max_features, like what has been done for kvm and hvf?<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I am intentio=
nally skipping that because it would not have any effect and there is no eq=
uivalent to KVM_GET_SUPPORTED_CPUID2 implemented for those accelerators.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
</blockquote></div></div></div>

--0000000000002c76f30639a18422--


