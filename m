Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61635C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhH7-0000H9-Fv; Fri, 21 Mar 2025 14:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhGq-0008Dw-Ed
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhGk-0007S0-Ku
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDALIBM4gMiaNAApgGYrdP8RMIx4DhGMy9icvxj4R64=;
 b=b9LI33Zz2Cs7O55GsgZdtHXQi+GFb3E/32qIa56j3Sn0OMm5dbCEkfYTpkyteAnunWxfLG
 Zod6+Naf4K108NhLYCuf6lztyCknKqoy/y670UvSQD9tadOziXpsFm2Pp/2Fa9OaTvtMC/
 Fyp278F1oyuUKPQPnORwSWHFXdo/5ng=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-TCJPBSN1PNyff7mt85Gz8w-1; Fri, 21 Mar 2025 14:38:52 -0400
X-MC-Unique: TCJPBSN1PNyff7mt85Gz8w-1
X-Mimecast-MFC-AGG-ID: TCJPBSN1PNyff7mt85Gz8w_1742582332
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso1024285f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582331; x=1743187131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDALIBM4gMiaNAApgGYrdP8RMIx4DhGMy9icvxj4R64=;
 b=rZDzoJXNShMy8YoEl8fjBwPpea3GglS97sEibMdjwderA7idlr4sjXnXyiyP07oFn8
 tMiK498r3IUf6sxtZBR5Ek8ht/UxEULfUJD5mms50+lNOr1uFStQ1/Zz1wQjmWkqrXQ2
 v0mmfrOXG2gDackMrTSKymBZkrpHJuV0UmuJZeqBlQ6JKR51BwQZNSlxdfIiHp3LVRan
 kMZhj+WFTLk5fdZgOZEzhNZE8M7Xfi+jq2qqr1X+KZCgoFBuucRioc5ZFP4a0SDrjKgK
 vJZKlZMCXNW7eVBU5FKBAwALStF2JKD6A28Q5tDxB7BHIVy9wdzRJsFQ0eCxY7B02aOP
 0TLw==
X-Gm-Message-State: AOJu0Yy+Fif5JaTDi3xE/G7Svpnml/nQiSj7wMUqiCN/OG0LMjfrNLVc
 6YUBA8YGx1z+kZbu9hibmy9kbSg/5Uud5igXlR38UZYVdOv0vsgUh4jyeBZAbHfEZteH3H3M5zN
 bVz+miq2kcX7sJHHUqlvFjNM4+L5NYxVnVsmqok857YIZOTIblT1dpN8w/f+9TdUdqpA0f9j/DO
 Hi5zBsWDljd1V6Z9Tjc27YbnkQk4ia+W8gUyY=
X-Gm-Gg: ASbGnctZar7lFRnXXIo9aX94moQ4hPlmGYEDOY44Bu+ARlEiMn5zV1eQ8rRUtVv0/Tm
 x/wHowKBiwiAbb6wDWp3vW4a9VmEg3BpAEE0UhdBBb5e0i1hLtRf2kyi62R6UjD70HWMvtZh5sQ
 ==
X-Received: by 2002:a5d:47c6:0:b0:391:2e31:c7e8 with SMTP id
 ffacd0b85a97d-3997f8f607emr4457097f8f.2.1742582331200; 
 Fri, 21 Mar 2025 11:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCIlqlX66izdOh82aBOqkftva00zw5ORRhrwFy+i8UHhmqXKIrXVNggEq6yecqGglgLRpzjm9PnSGb9uorCTM=
X-Received: by 2002:a5d:47c6:0:b0:391:2e31:c7e8 with SMTP id
 ffacd0b85a97d-3997f8f607emr4457080f8f.2.1742582330845; Fri, 21 Mar 2025
 11:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250321133339.116081-1-pbonzini@redhat.com>
 <CAFEAcA_h6VDA6E1=DHN5LyuekhmXcD8JpEUEjsHboPSDK-VdAg@mail.gmail.com>
In-Reply-To: <CAFEAcA_h6VDA6E1=DHN5LyuekhmXcD8JpEUEjsHboPSDK-VdAg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 21 Mar 2025 19:38:39 +0100
X-Gm-Features: AQ5f1JomymMNZMaM7aFWmAs-fBOdN18RWYlADRdUPTgJsz79_irnBF8E-K8umhQ
Message-ID: <CABgObfY3hEAUvUjEZg5cgF+-sNhZdQmBCKpDNyYBdtR3e23Obw@mail.gmail.com>
Subject: Re: [PATCH] rust: hpet: fix decoding of timer registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Mar 21, 2025 at 3:26=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> Tested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> If I understand the code correctly I think you could also
> write this as "addr & 0x1f" which might be a little nicer
> as it then lines up with the "/ 0x20".

Yeah, I was undecided between that and 0x18... in the end I went with
0x18 because bits 0-1 are clear (due to alignment) and bit 2 is
cleared above, and the TimerRegister enum also has "0x18" in the
comment.

Paolo


