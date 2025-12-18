Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C510D68BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW87Y-0008Ao-Ud; Thu, 18 Dec 2025 02:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vW87X-0008AQ-AF
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:08:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vW87V-00048T-Pa
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766041695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfkP4jLE9uLc3zaoXYzsnDB4cFPyvbOkRNRGwCMQE5o=;
 b=b9AU+Uj7eGLAMr+ckC7wLAMe78iVb+duzvFBMzP1bTkyUo5QYNq1Ea1fLyJjT5lxCXklZa
 8CF7+tUKWJXweRkRXbA/T0ZKwRzyJ+QcNZyAyf8EXYq2Cc8yF9cumXkWQJD25nn0aa1INC
 QPvZ8mfq+cpZy5WllDU5NtWhLLjz3kA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-fs2t57k5Pk6PQkMDY6aW0w-1; Thu, 18 Dec 2025 02:08:13 -0500
X-MC-Unique: fs2t57k5Pk6PQkMDY6aW0w-1
X-Mimecast-MFC-AGG-ID: fs2t57k5Pk6PQkMDY6aW0w_1766041692
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34c387d3eb6so354880a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 23:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766041692; x=1766646492; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfkP4jLE9uLc3zaoXYzsnDB4cFPyvbOkRNRGwCMQE5o=;
 b=N8HsGIiqMn34SiqjrvcOu5IGJeV8xXyFWUPdepuH9+bj8BlGEIpYX3PazZvWeeNx6i
 kEJgHuLUr1zECN0t4VJEHDad6tZDasEIV7OkIm6s71K4fi6tcW03/LboXOnUFnnF6egx
 PuKt251KtP+TSld91Xpka1ypK/nBLaFmgaPwjoC/DUN0yqB59OOqpO4m14YTXtWuXgig
 tARivODui6yB5ta17wfUgnGDqu5m6/xDAzhrAFNxzoodv346kKyMCu/iN6BaWqWA8J2t
 qr+7ijfWxtIQVu9v72n0F1w4VUZCOpnC5gB2iRiKSerSqNQLs3lje32Wyjj+Sp+8njVh
 D48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766041692; x=1766646492;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qfkP4jLE9uLc3zaoXYzsnDB4cFPyvbOkRNRGwCMQE5o=;
 b=FzYkNOeIKgI+XUXGEoO37bcqaEXKwdj7u9/9mWLjss3zhFEKRrdtJ57PRRotoIbQST
 7/IXNHwZsD+kQHv6gj0KYihzWIzzF74ORhB6WKGQl2ithdpEOeRJcKTtoqpqJ/SkhfC3
 Cfpj0JnDzMuT4ux7bkGu+0d0eveu09KZrJUlLG/jLo06VQDoz1oC9QSYKnkqnbcSFN0D
 vflgJgP4GrdiEM3uoSMgS5I4lLw5TslXU7Z9iHc+LUvDy7DePYBErB3BvO5DKb5hF7Yl
 zfoZCpK7jPrT8JFI50WdVzyDfwMg5wK5cS8h2Jm76gdar16FrR+Z2glRxMLB6RenbE/1
 1Mjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPWCaaHHJBVSGWhnXdWOGy2RYvfa3x7KsJ4vEmGJzCTPM+FP4PeI5nMR0WlQ+gcLHNPPPomqOfJIno@nongnu.org
X-Gm-Message-State: AOJu0YwvD7WKFuJJTxHMZIN9SC7YQx0BaJeQmR3xu0iMILvIt78Qj/Gk
 sxzbfm2CgB39P8q4xCO3ZmIGIMXv0RZJoMfQwN+nXQG6u5z1pKVZH5vzBtIKCrrjAs2xSGMZNcN
 QA9U5nQbAE4v9i26NVOuBI6t/I1fEdrjms+x3UwoKYpzNwvWyf9oR9mo3
X-Gm-Gg: AY/fxX7+eTY4Y17X7i3EqtzgXnbSXQWlSNfV8bZntrCF/Su1fqqtNIW4xDDaF/RjKlc
 NOYXFqHnk+wc0HvrgNEc2Eub51s464uT/asfkFn65sCyaKtI9nddm89uzgMuTEmDQtLYBPDgC//
 25kYO5nSZSKEJdh2yPW6Z/z3zyrBP0K7Wdts10rI2KPycibLHX1eaSjwjknn6L3cUNdgeYQY3l+
 Uzufd4oqDAFnFqmgpx7STyVq0WtPIRQdfbCRTO8Q1KLwxaFnfe7EkejvzxSW3/QqTds59FeNQF6
 CM4vfNGSJZ/hDr7sZ2yHtWBRjlGyd0f+QjDpnCYc1ZOD7dF7UejxKB6C0JEF++uGN19T9EbyUTz
 1e8r/WdysmHAtvdzwBtxtZ/zr2lRJUenT2u+uNu8fAlItE68//J6/4A==
X-Received: by 2002:a17:902:ea11:b0:2a0:92a6:955 with SMTP id
 d9443c01a7336-2a092a60bdemr171681775ad.23.1766041692406; 
 Wed, 17 Dec 2025 23:08:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWcZCex+AE4xRf0tBw+b3dYwKTFOl94+nxi7g7rtS9mhcSAmsN76EI9+7wq4JL2IKczc6ZOQ==
X-Received: by 2002:a17:902:ea11:b0:2a0:92a6:955 with SMTP id
 d9443c01a7336-2a092a60bdemr171681615ad.23.1766041692017; 
 Wed, 17 Dec 2025 23:08:12 -0800 (PST)
Received: from smtpclient.apple ([27.58.53.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d1926bb0sm14260335ad.76.2025.12.17.23.08.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Dec 2025 23:08:11 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v1 21/28] hw/hyperv/vmbus: add support for confidential
 guest reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <6z23v5oawxmjzby5yv7mpbnupnv3dgayjg424hxseiqcrihv6z@yx5dfg7c62wu>
Date: Thu, 18 Dec 2025 12:37:57 +0530
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17BAC02D-F3A2-4DE5-9FEB-D5F9AB40C821@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-22-anisinha@redhat.com>
 <a0cfba30-8571-4153-a5a3-572cb2fe514f@maciej.szmigiero.name>
 <FCE31E2E-19BA-43AF-9525-B99C45ADBBF6@redhat.com>
 <9cb2723e-4132-44ac-be32-857c7933d27e@maciej.szmigiero.name>
 <6z23v5oawxmjzby5yv7mpbnupnv3dgayjg424hxseiqcrihv6z@yx5dfg7c62wu>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 17 Dec 2025, at 7:38=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> On Tue, Dec 16, 2025 at 02:38:10PM +0100, Maciej S. Szmigiero wrote:
>> On 16.12.2025 05:41, Ani Sinha wrote:
>>>=20
>>>=20
>>>> On 15 Dec 2025, at 10:34=E2=80=AFPM, Maciej S. Szmigiero =
<mail@maciej.szmigiero.name> wrote:
>>>>=20
>>>> On 12.12.2025 16:03, Ani Sinha wrote:
>>>>> On confidential guests when the KVM virtual machine file =
descriptor changes as
>>>>> a part of the reset process, event file descriptors needs to be =
reassociated
>>>>> with the new KVM VM file descriptor. This is achieved with the =
help of a
>>>>> callback handler that gets called when KVM VM file descriptor =
changes during
>>>>> the confidential guest reset process.
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> ---
>>>>=20
>>>> Have you actually tested confidential guests with VMBus or is this =
a change
>>>> "for completeness sake" that can't be exercised in the current =
state of things?
>>>=20
>>> No I have not tested the changes with VMBus. It=E2=80=99s more for =
completeness sake as you have correctly put it. If you suggest, I can =
drop the change.
>>>=20
>>=20
>> I have mixed feelings here: on the one hand this support could be =
useful in
>> the future, on the other hand we probably don't want to add dead and
>> untestable code to QEMU.
>>=20
>> Let's see what other maintainers think about adding such code in =
order to
>> be consistent across different subsystems.
>=20
> In any case the testing status of these changes should be noted in the
> commit messages.  There are some xen changes in the series where I
> suspect they are untested too ...

Yes all the Xen stuff is untested. I was thinking of dropping those =
patches but posted them for completeness and suggestion from =
maintainers. If we think we should drop them, I will be happy to do so.=


