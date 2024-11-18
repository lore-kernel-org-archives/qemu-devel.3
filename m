Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B9D49218
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD13q-0007aN-A3; Mon, 18 Nov 2024 07:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD13n-0007Wm-99
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD13l-0004Rb-1r
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731933648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ca0cxM3UlWVse/L3ofROZ5zzW/nq8lsxvLIZ+MdO/Y=;
 b=X5XlH7p1zO7xzSes3cs/r3fwUhyyofcGE+lyxwCNIHzywRi2JX1WnfgIgngRzL5TySsHld
 tUAQWLHGazDVU+EvCTdd9BJoNjFGZ7WFlQPlCB2Zq5MY2vIN7UYnRf1mujm4sNh2MS60qe
 M4QdVkEQtpETTtOhqiar0CnvkZAWqPI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-8yB_Y87oPzKCkplO-WjyaA-1; Mon, 18 Nov 2024 07:40:47 -0500
X-MC-Unique: 8yB_Y87oPzKCkplO-WjyaA-1
X-Mimecast-MFC-AGG-ID: 8yB_Y87oPzKCkplO-WjyaA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so29680285e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933646; x=1732538446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ca0cxM3UlWVse/L3ofROZ5zzW/nq8lsxvLIZ+MdO/Y=;
 b=CmVWlmJklmNfuXHaol0ux8Zbhf0RmTOUn5lwqwmaES973R0w8tBignlFd8XDe0twtb
 WCRbecGshWsA7zP1oOGZ5Ggrm0FkE32zm3XOqH9r5wGRPcQC/gjX2z9uerdWqs3jc6Pk
 jb5TxKf/C1+CyFfRvz1ay+7aOetzGwcpqd/xFZ0NCnldxmWKZCXDtVYQapH8Ugsl8XoB
 kf3Ofhtp2UAxEcFZ6DcohzKieTOzQW7F2br/VxaZlHyKFIyPsZ08PjGZUuQwfagiAWhz
 qdKGEN1/0EVzwf5Xf3xyo00kjjkADe4eLB+yErknvbtf2KqqVGYa2p9u7y2yLxBIg4Kj
 HfMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/rp3XGZl5idUbf6h1hCAS5ZAW9bl6oj8yuxxQMcGcSmXua90ArPVjyBYHAmmk2l/uZmFd48hI4yPq@nongnu.org
X-Gm-Message-State: AOJu0YzzqZYq0fvDDTRkc+CGLDA2ZO5jO4uiUN4/DYpWvL7h0APbRm7S
 7+pX9+9yLW5dF5sTPPb7FUXsRWRiy4Kx+8T//PDqIPzH4OcWJWDgJuwgOhXn/6GK8jwFtkPA+OX
 lAPt51/v00tUYohafxHAWd8CtyIjfP2BMaTQ3yLgugXuXvpzOSIqxVMBgw0huUmRD1BXUzbd2/z
 MBTDXs1fSoLYLmUcxcz+i8uWV3fg8=
X-Received: by 2002:a05:600c:a4c:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-432df78f0f9mr115423435e9.30.1731933645643; 
 Mon, 18 Nov 2024 04:40:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY31iOEOJwmH+GNU27tX4BuZTrW5dS++r1GU9Qd5XcWwkBSRwiBKIO45Bdr1fpps5/KsEGA6HVab1+k/qUOjk=
X-Received: by 2002:a05:600c:a4c:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-432df78f0f9mr115423175e9.30.1731933645387; Mon, 18 Nov 2024
 04:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20241117161039.3758840-1-manos.pitsidianakis@linaro.org>
 <875xoku5vd.fsf@draig.linaro.org>
In-Reply-To: <875xoku5vd.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Nov 2024 13:40:33 +0100
Message-ID: <CABgObfaVs-3aXKXtQRLDbzCL56gbimWZoMchYi5G+QGu8r0AxA@mail.gmail.com>
Subject: Re: [PATCH v3] rust/pl011: Fix DeviceID reads
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-rust@nongnu.org, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 18, 2024 at 12:41=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
> This is a nice improvement in conciseness over the separate legs removed =
bellow.
>
> > +                eprintln!("write bad offset {offset} at RO register {d=
ev_id:?} value {value}");
> > +            }
>
> Is a binding for qemu_log and friends on the todo list?

Yes, see https://lore.kernel.org/qemu-devel/20241024-rust-round-2-v1-10-051=
e7a25b978@linaro.org/
and my concerns at
https://lore.kernel.org/qemu-devel/e8e55772-906b-42cb-a744-031e6ae65f16@red=
hat.com/.

More reviews are welcome; in general, we should define a convention
for Rust functions and constants (is it okay to rename constants in
the Rust bindings if their C name is ugly? should functions keep or
lose the "qemu_*" prefixes?).

The corresponding patch to move from "eprintln!" to the logging
functions is at
https://lore.kernel.org/qemu-devel/20241024-rust-round-2-v1-11-051e7a25b978=
@linaro.org/.

Paolo


