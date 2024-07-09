Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E50C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR5h0-0005c7-KX; Tue, 09 Jul 2024 03:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sR5gk-0005aX-V1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sR5gh-0001bt-V5
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720511698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0B+5rbNnUTcAnfUWR5+GoedIC3bWCGjQWr0Q0BF4QI=;
 b=S3ws4dkUeuvpeldD7Ntjyx3ReeAregT5AfMIP4S5cJJhOiz4B5ABsIVJJhbcS4yo0PzGB2
 TOtzmUTu30SHW62EgQjqy22PNiF4u2IjjBBCETWMMNSlFoeMoSo5AKA3LMlNEfSVlAHTio
 G7Cc6nOgK+/MJpyoQ4zPImCHCsq2RFY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-8iA_-qvsM2SAGZlM62Mn9Q-1; Tue, 09 Jul 2024 03:54:56 -0400
X-MC-Unique: 8iA_-qvsM2SAGZlM62Mn9Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee890f0cecso50105141fa.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720511695; x=1721116495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0B+5rbNnUTcAnfUWR5+GoedIC3bWCGjQWr0Q0BF4QI=;
 b=fSqAytYD55/GAqnM7KFtp/9a29+Jg5u9cVlYrDM9Vi6SXQjSmOV2GBduViUJLq+Yhn
 9CJSFnOLPgrJRaU3eJ2vIZMi5r0Rcp5h7+QMe8ld4X5sU9fNUQ+P81iqn3X6yEMCf6t8
 D+jFVvzh3u+zecOYXB7eWClb6DVCOdu4HVVflBG87oWOGaCgpj8rOq8a/4+g89UhGCjV
 LSGwE76TqqnProz8HtFyTslzOy4YZSiYOPUyrmBhhs3wjaX0R65ttowH2sxYZ6eMtMgh
 98cO2fQI3mqN0/HfnHO9WPfp9zgyEjhMFApjnCfvh3mO4POjRmGrTHfgP+dJQd6ji+9g
 kZ6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVxpLPz8lH2FV9/yJWbTYtqfF0fNdCQQlyajyPkGI2YMwPcC89wT3NVN9IWNqrrQETxBhEskdCjvbQOIdzxOubz+pR7E8=
X-Gm-Message-State: AOJu0YyB0Je/Dd5pgbJkKWSPT0xZhLfSgq0lIezSQAbJVMCb70/YuWGI
 rNWfydM7zEelPK29xNxHLaCMsHjp4hXGmJAo3ILVP4/BadzjZ/7qEVVHG1I9QywnpjFH3IM2m2u
 vTe3agx4l1IGSX2rtNgH/FiP/h6q7AQxEbSr5nMoCmObpEncD5hcNFSZPlZBKXvv5vszxANGpC9
 8tvb6G1AR0qB2TrwtxBjcZBcFAVW4=
X-Received: by 2002:a2e:8784:0:b0:2ec:4aac:8fd4 with SMTP id
 38308e7fff4ca-2eeb30b4cb1mr12072881fa.1.1720511695441; 
 Tue, 09 Jul 2024 00:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoCtJZXxBF9fcltAxUgfBKJn/vnLT40fqORs0CRoO8pIfoS+f4Z/zjPAN3DQdfRWZSRohLD73bqlUuJjGhnxk=
X-Received: by 2002:a2e:8784:0:b0:2ec:4aac:8fd4 with SMTP id
 38308e7fff4ca-2eeb30b4cb1mr12072651fa.1.1720511695089; Tue, 09 Jul 2024
 00:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
 <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
 <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
 <CABgObfa8KQOu6RPs1aqKww8qPeOjHppbH15aBCN+KvaOL=_W9A@mail.gmail.com>
 <CAAjaMXZ+Sx_+4sNFs=zy+bP0d5gbyf_Buh9JS-ixsRCfxsdN4w@mail.gmail.com>
In-Reply-To: <CAAjaMXZ+Sx_+4sNFs=zy+bP0d5gbyf_Buh9JS-ixsRCfxsdN4w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 9 Jul 2024 09:54:43 +0200
Message-ID: <CABgObfb3mmxZy_cEeUTbuGCN-3Nqs8x8dkGy7Ehyowd9LNbktg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 9, 2024 at 9:38=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> Ah, alright. That wasn't obvious because that e-mail was not directed
> to me nor did it mention my name :)

Oh, ok. Sorry about that. Generally when I say "we" I include as large
a part of the community as applicable.

> I do not want to do that, in any case. I do not think it's the right appr=
oach.

No problem with that (and in fact I agree, as I'd prefer a speedy
merge and doing the work on the QEMU master branch); however, we need
to reach an agreement on that and everybody (including Daniel) needs
to explain the reason for their position.

Daniel's proposed criteria for merging include:
- CI integration
- CI passing for all supported targets (thus lowering the MSRV to 1.63.0)
- plus any the code changes that were or will be requested during review

That seems to be a pretty high amount of work, and until it's done
everyone else is unable to contribute, not even in directions
orthogonal to the above (cross compilation support, less unsafe code,
porting more devices). So something has to give: either we decide for
an early merge, where the code is marked as experimental and disabled
by default. Personally I think it's fine, the contingency plan is
simply to "git rm -rf rust/". Or we can keep the above stringent
requirements for merging, but then I don't see it as a one-person job.

If I can say so, developing on a branch would also be a useful warm-up
for you in the maintainer role, if we expect that there will be
significant community contributions to Rust.

Paolo


