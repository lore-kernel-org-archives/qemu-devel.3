Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216A0C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOyr2-0005jE-Km; Wed, 03 Jul 2024 08:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOyr0-0005iT-2w
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOyqy-00025g-1m
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720008769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EANAFnP+Exiicoeqr8dK6P7tHqPe2XBSxpIVKTJWiHY=;
 b=LfU509bHmQACvYGF2dcQBviiUcbXHsyk3VAJNeaQAhqSQF84FEfjVHYBoVO7tsGY6SJd2X
 6BTv9/AucbV2ZicbFwk0Qq5XePDl0U2bwwn3ZjI75jjrPyZDqtR8UATgkUTon4Zk9oB4zG
 vC6GIUEyu6ggtiPsCMg+0saZtVpoL/8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-HtMk3CAHNZ6MDSo3_ahi9w-1; Wed, 03 Jul 2024 08:12:48 -0400
X-MC-Unique: HtMk3CAHNZ6MDSo3_ahi9w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36793b39ee5so419616f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 05:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720008767; x=1720613567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EANAFnP+Exiicoeqr8dK6P7tHqPe2XBSxpIVKTJWiHY=;
 b=iyPtT1+wVk0NjJR6ihg6NDH8mzQibA5PXmyb/pTRIdwOOeW7g2xAdIbwijd8QhHJ4K
 OjNIIVG3Iye5xCCk2fxzTX5OF50V+ug1g8dyZ6dSLLZzWMG9YAu3FxrtI90b/dqPCQsC
 riUQ3B7I3WpgEjGH2ezGRpy6hnxW+5pQjLclm+UT6nVr48Ac4jm8yS4Dm2LrfMEQNFVH
 BwZo/afFy/IP24NlfYeIkK1saMI14clWpp/uwhJT8D0uwiF1ETLzyqePSlT4C81llYQ7
 ILSRoThoNOcSQNlhbTiPfnz8jzrXHkkDS4eqVBvDpTC/O9fhf7IIxgfOHFmZxPSOWIXq
 lr3Q==
X-Gm-Message-State: AOJu0YzO6laaUQt6AXpD6KTXqafoNvSdwuYqlyVqlYLlLDbcTZYGudKr
 CuaZHrc9QZhxXm5tk3Gg7hIzhDUDWKLv3IH1Y6vHQoKcrp4rpRklZv7kcW1wSSv1RdlqHToQBt3
 ZhV2X0dw1i41hnkb+WpFgI0wAj3OoNDA/tUJnqYh+od4WBiT36HsdS2QmOhQ05r3z8sPnAjGDpa
 1pecxoScXWAdCCqqU2YxPcFCRTqx4=
X-Received: by 2002:a5d:404f:0:b0:364:8568:f843 with SMTP id
 ffacd0b85a97d-3677572fa68mr8201707f8f.59.1720008767388; 
 Wed, 03 Jul 2024 05:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFayl2+O/efxfMLLoP5Pjsya8l74PKxnldLmKGqEWTdtPptuaJFmjlWzDbt/rXkdX9NVxNSkmTlMD6ady58vY=
X-Received: by 2002:a5d:404f:0:b0:364:8568:f843 with SMTP id
 ffacd0b85a97d-3677572fa68mr8201697f8f.59.1720008767052; Wed, 03 Jul 2024
 05:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240702195903.204007-1-jsnow@redhat.com>
 <20240702195903.204007-2-jsnow@redhat.com>
 <e0302039-dade-43a7-8bdb-a96d1df76f38@redhat.com>
 <CAFn=p-Yqi5umFBPtUYj2EFiRRA2E6VTgDi=TbuwoOSTs+s9OoA@mail.gmail.com>
In-Reply-To: <CAFn=p-Yqi5umFBPtUYj2EFiRRA2E6VTgDi=TbuwoOSTs+s9OoA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 3 Jul 2024 14:12:35 +0200
Message-ID: <CABgObfZik_bKuZffohNO1fMss+81kTzaHPEHSPu6H2MCoJVZ=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Python: bump minimum sphinx version to 3.4.3
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 3, 2024 at 2:06=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
> On Wed, Jul 3, 2024, 4:00=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>> On 7/2/24 21:59, John Snow wrote:
>> > With RHEL 8 support retired (It's been two years today since RHEL 9
>> > came out), our very oldest build platform version of Sphinx is now
>> > 3.4.3; and keeping backwards compatibility for versions as old as v1.6
>> > when using domain extensions is a lot of work we don't need to do.
>>
>> Technically that's unrelated: thanks to your venv work, :) builds on
>> RHEL 8 / CentOS Stream 8 do not pick the platform Sphinx, because it
>> runs under Python 3.6.  Therefore the version included in RHEL 8 does
>> not matter for picking the minimum supported Sphinx version.
>
> I think I can't mandate 4.x because of RHEL 9 builds though, and offline =
requirements.

Offline requirements are not a problem; on RHEL 8 you just have to
install with pip in order to build docs offline. But yes, RHEL 9 is
still using platform Python and therefore 3.4.3 remains the limit even
after we stop supporting bullseye.

Paolo


