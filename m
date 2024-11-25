Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9CFD3B7F5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 09:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFVZD-0005HA-9F; Mon, 25 Nov 2024 04:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFVZC-0005B8-16
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFVZA-00048Q-HJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732527575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkAqJT9HP0Flub/HnesEuOlwBQ8lAvokj1P23pmzfUw=;
 b=d7kF311KP7FOoaUkqFei7SX1B4TTY/+nuzvtfINZwf+S4AHnrIMnrR7gsu1l1Vr1N/WM9T
 DMfg7cXmunoCQU2zgrwPaQcf8sIqqNpGBHAtI/AC8bkDf6AJMIWFSHjyeNW8aGnzdlUhny
 y2/PLeiF4oUOjcdakqAlp6IRVRm+id0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-fkoois5QPl2hKqWfq8TnbQ-1; Mon, 25 Nov 2024 04:39:33 -0500
X-MC-Unique: fkoois5QPl2hKqWfq8TnbQ-1
X-Mimecast-MFC-AGG-ID: fkoois5QPl2hKqWfq8TnbQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-382480686f2so2623491f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 01:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732527572; x=1733132372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkAqJT9HP0Flub/HnesEuOlwBQ8lAvokj1P23pmzfUw=;
 b=RBx+TSwzKyTUecnz8xBtocUkJKh/DX276p2mHj1yPqD53SgIDrwawbE2Lde1Rh1aFh
 LNrgaI0NGaudZwoirFe2GY2wM/k3lu4r+IuojGWg0CXoMsNimJYT5B1qBNuwdlD/bkDt
 wgXsmqLhIkXiuhvZ2uWSlX9icGtpJ+Swgmf80RSUdtYUfg6On30sxnKhZ/Si6J8mZ0an
 EhILXVYZ62u2aD0t7ItMX16YyoUVIqW8M6VQYPni8mE8kII0gpnrq6QJyTicAL3Eh+Gr
 05BtYJ/Azpck00JkSYtAeadbRzd/vzTFo6e/WmLBJaUK0SqTYdQ8U7BlD/lZhPUEIJ9r
 RTLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL0ob41FxlTavVBEso2/zhvRj1xre/uY7Bs6khvGpbe/Kg+Zt831eiW/ixRvtCVyH/HnzNa1DsGuGw@nongnu.org
X-Gm-Message-State: AOJu0YzXDBNzo4BF/1YKdKTwnBuR8mNaPSLtOl68F09ZFln3eeuEuGfH
 jEZCOZ+hL9r4Lq+fA3utMcxK10ZvHXAxeByauWzBOzeox0TTr7xJlb/I+qS9OsHL0cKGvsP+C0U
 kUwk0qFySOkSfiLRo9YWeUpwTP1Nyg+i+k5wNTXVXYQC6Py+zF0Jsq4sHGGyfrzIcAila3rHar+
 rl3b+1wDd0rmJItgmrAkSJVL+v8Lc=
X-Gm-Gg: ASbGnctZZlFs5uC6ea+WprTC+KtSqhc6LgmGTIBbhb1aBxNMZMsEd2kLtv8rlQ8ehe6
 UaRGjV5Bwmu6S1TaP+Aed6lFDJWPfMaLh
X-Received: by 2002:a5d:588f:0:b0:382:4851:46d2 with SMTP id
 ffacd0b85a97d-38260b45c95mr11155412f8f.1.1732527571887; 
 Mon, 25 Nov 2024 01:39:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGizQbUUiTbGBN23TGyz4G/06K8gKdTMkaChLYv9AfVcEhdfcGqK0Dwxfnpeh3aHHAi1MBUHYrsNvK9l5dTGi4=
X-Received: by 2002:a5d:588f:0:b0:382:4851:46d2 with SMTP id
 ffacd0b85a97d-38260b45c95mr11155394f8f.1.1732527571601; Mon, 25 Nov 2024
 01:39:31 -0800 (PST)
MIME-Version: 1.0
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
 <Z0REl6xtaYuvP876@redhat.com>
In-Reply-To: <Z0REl6xtaYuvP876@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Nov 2024 10:39:19 +0100
Message-ID: <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
Subject: Re: Supporting clang on windows
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Nov 25, 2024 at 10:34=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> IMHO we need to have confidence not only in the current state of the code=
,
> but also that we're not going to accidentally regresss it in the future.
> This is what the gcc_struct attribute gives us confidence in.

Yes, as you say below the "solution" to that could be simply to avoid
bitfields. They are problematic anyway for big-endian machines, see
the commit that Thomas pointed out. Unfortunately it's a
human-enforced solution, but then it is already human-enforced for
endianness issues.

> As an alternative is it practical for us to eliminate all bitfields
> from our structs ?

It is (at least for guest-visible structs), but it is a lot of work
and I don't think it's reasonable for it to block clang enablement on
Windows.

Of course it is possible for future contributions. Pierrick, would you
like to contribute a patch to docs/devel/style.rst as well?

Paolo


