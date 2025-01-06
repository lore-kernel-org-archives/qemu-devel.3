Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEFCE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 15:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUovA-0002bj-S8; Mon, 06 Jan 2025 10:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tUov9-0002bL-Nv
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 10:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tUov8-0004Vn-9b
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 10:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736176892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlJ4+Qy6GgfCO5yiBUzos7Dl9d3hIVivSqa8SZuW7Ig=;
 b=Kucuia/D5lmsGljH7+GK29t+fResCmDUm1xCM2ysB/d0QRhoWdEvq51mK7T2Diau9m6UO/
 63TjaeNibrvyYXeOBDy/9B1bY3EFueHk5bHjmy0MM7PTYW9aRDcHIoGGlrpvwrsZ2Xdzve
 qjlR1P8UGWEY/Lv04QXv8ps7H0T+THc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-rbG0K4msNVWNwOG5qCxF1g-1; Mon, 06 Jan 2025 10:21:30 -0500
X-MC-Unique: rbG0K4msNVWNwOG5qCxF1g-1
X-Mimecast-MFC-AGG-ID: rbG0K4msNVWNwOG5qCxF1g
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38a35a65575so6721584f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 07:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736176888; x=1736781688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HlJ4+Qy6GgfCO5yiBUzos7Dl9d3hIVivSqa8SZuW7Ig=;
 b=hkHxwxfdGvesnWw7MxmBJkowaRNaL6pNmK7BDaqK3ASyuBuk7sUPO1JWu6VNiKHUwi
 KwipSPw379bycD9euqZH/cHzwcOSFQeN5XwLLyOF5bTB1m6Hr7V1YwZWpL+TD+a5I7CI
 PzDaRBGmZAiNO2fRSkQcwrDzdo+60LABEVwq/bDYRuiTjNHYxODgJJJxigpb+ypFeEEU
 KmfzykFoRqe6n74WbGg+9yD/I7qZbeEIxI3m0D+w2spx1Jp4oyfXqlGgVe41zq8Tc4Nz
 XHmg+hHua+o1DEochAxD0bTQ+kAHGuXSuyvswUITOT/lgPmWfhCOBvY3f+4v+4k5CNwp
 89BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmnpE154zvwOVTcbExKHj6xOOhOZp5Q/MV5ca3W8J9PYTdx3h6H+VDBKxppZeb/QUmzfvlEWJYhtfv@nongnu.org
X-Gm-Message-State: AOJu0YxqeUBHmcIcR0oLj2yYY5n5BdLPRJ5yQEoh66+GA2Y8lgZSugKa
 1QO9VWYsl65RvjhyKxlIfk8W3w2mf6OZPrWu+wPSXS2jwEwXYmwcxMDE9rOJbAtnYcVauS+oNw1
 eDVX8DhYUNnGu0rr6pdyAZeWbkqec0TY9IbL7fRIskeIfrbf0jTpyi/H77+HuE86bJBjLJNssys
 KcnRm20YGjirEErwZelDEDrpsCbDI=
X-Gm-Gg: ASbGncvmy6pyVrR2txNOlrtYbO2uUdWFLCQAuftcNKDZ8huC6JHrRiC2mf7Gr4wR7vz
 jmiIppeAUTlNnLSTOEvWYh0TjtGdzZasdcukcbA==
X-Received: by 2002:a05:6000:18a8:b0:385:f7d2:7e29 with SMTP id
 ffacd0b85a97d-38a221ea539mr48530050f8f.15.1736176888549; 
 Mon, 06 Jan 2025 07:21:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOovEQZm3ht7n5+nHRPhWRFImJWCNuQcSHrPn6DtSZ2iQTaACqTmB/MmBO1URglumKAFbZkaObRVddsJB4HKE=
X-Received: by 2002:a05:6000:18a8:b0:385:f7d2:7e29 with SMTP id
 ffacd0b85a97d-38a221ea539mr48530031f8f.15.1736176888170; Mon, 06 Jan 2025
 07:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
 <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
 <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
In-Reply-To: <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 6 Jan 2025 16:21:16 +0100
Message-ID: <CABgObfZ7FFW5yhA2u6Rt5=MndrLsF=BnNhgE73LAyUWUGF=yXQ@mail.gmail.com>
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000afee7c062b0b2e29"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000afee7c062b0b2e29
Content-Type: text/plain; charset="UTF-8"

Il lun 6 gen 2025, 14:32 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> I think here I agree with Philippe that we might as well
> provide only the new API to Rust devices.
>

Ok, I wasn't thinking of doing that because there isn't right now an easy
way to add interfaces to Rust-defined classes. However, all devices are
Resettable and Device isn't defined in Rust, so it's not hard to add a
ResettableImpl trait in rust/qemu-api/srv/qdev.rs, and initialize it for
all devices.

If anybody wants to do it as an exercise, I am happy to help, otherwise I
can prepare a patch too.

Paolo


> -- PMM
>
>

--000000000000afee7c062b0b2e29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 6 gen 2025, 14:32 Peter M=
aydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">I think here I agree with Philippe that we might as well<br>
provide only the new API to Rust devices.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Ok, I wasn&#39;t thinking of doing=
 that because there isn&#39;t right now an easy way to add interfaces to Ru=
st-defined classes. However, all devices are Resettable and Device isn&#39;=
t defined in Rust, so it&#39;s not hard to add a ResettableImpl trait in ru=
st/qemu-api/srv/<a href=3D"http://qdev.rs">qdev.rs</a>, and initialize it f=
or all devices.</div><div dir=3D"auto"><br></div><div dir=3D"auto">If anybo=
dy wants to do it as an exercise, I am happy to help, otherwise I can prepa=
re a patch too.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000afee7c062b0b2e29--


