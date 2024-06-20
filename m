Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB76C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 16:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKKZn-0007o9-5V; Thu, 20 Jun 2024 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sKKZm-0007nx-8l
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:23:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sKKZk-0002Qv-Co
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:23:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f70ec6ff8bso357465ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718900630; x=1719505430; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puNEomUppI0lbgfiSMvHjV5koJDgqVwAWVy5Q7cT9j0=;
 b=A/Xt5ktkWaoL5HecMkk/LmyaI39ELRmuObbuWb4wAa9KU5jikGpghWCNtjhs7ao5Jr
 8EFa8j3YcP4fEEljjJVMuWgsRlebFzBBVOKc0ChX9m3uytw1xe0NoGbUy+myHp5Xrukc
 cfwbfymiVFrWUVeX8WVlK6SbVYdcAQyPdOMgqlEyNcGLeIcOMDl1QaXqsn26ZqcoS0VV
 LBNyxm9oRajlOmmdOkaoRNQM/RM5tdNIIjwxK6ujbTe8V8cPvANxX7FD1jU9PG5FrW8M
 yMfp3qmcLLQswgScbvnY/QzpKXmuosVZsFKdHt72WA+afZk6bwMRjBJpLdadNI7ag9C2
 nu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718900630; x=1719505430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puNEomUppI0lbgfiSMvHjV5koJDgqVwAWVy5Q7cT9j0=;
 b=wLsdv/qA2bpClYbNK0XgTmFZbb1DAi2/pKY6ffcUKvq6ypJv+UBsWbnwlYkrvTUGqF
 10JsSQN26x7s9nljp4dp1R4fHgwGo8jWXENxVEDub/xBaT0185/c3gwJ5MXrZ6zuDard
 6O03bsuMXXxqJdy01gbj2tqGObhU7B+1/mVSc3Vyml0sl0/jDb7WXDsIfGda3jQgTmcP
 61ys1FFP6m2uWGzA95NDYeWbzQh8pKvEHzb9O+tUVcHstA2TxB16Yz0DHadczi/uUS7k
 VIDcykou+iutod7fNvWPvSEUyEiL5L7WrN8pdmG1RtApNkjMOiMd3cXmgvtZ8Ir0OUEe
 qzcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4nX+zCSEWlhjvL5Nznhn3csqX0WnZP1lQQS/fleFCqPqkQTdY7Un7qIHRZ+7bNDARx+fS0bXskBqK3V3MO9USWCvnyec=
X-Gm-Message-State: AOJu0YwnEzn3sl7RBpTT1h3DGCQAZjzQC06mxOiIVKOHKDPsCyWnPLYw
 YWYpC7zUcFRH1r7wkShS8Mr/8lf8ffz3LIvkvzSIo5yV+GF0p2k7/5mcKuSUsTDhZUSjDnNowtY
 LVlzbtT3pOVRPLEFXJ8pUWwSqwCpxPCVnN1NSbfMQ291y4K6j6Q==
X-Google-Smtp-Source: AGHT+IHf4Ku/qoS5AK41BCMqSaVUWGMM55ts1tmnUjbfR4y6ZTCgFbN5keHEqocJSu3QJ43pPS86Hw1WOKBlh5WQaN0=
X-Received: by 2002:a17:902:fd06:b0:1f6:f96c:4a44 with SMTP id
 d9443c01a7336-1f9ac1ec02dmr6192335ad.22.1718900629725; Thu, 20 Jun 2024
 09:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240618224604.879275-1-rkir@google.com>
 <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
 <ZnKRLj3usYxmAIOE@redhat.com> <87le2zbqfx.fsf@draig.linaro.org>
In-Reply-To: <87le2zbqfx.fsf@draig.linaro.org>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 20 Jun 2024 09:23:37 -0700
Message-ID: <CAOGAQeov7kwbopVPyVZwS3mYvWqMb_0=K4te09ENdtg-P7M23g@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 jansene@google.com, mett@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rkir@google.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Daniel and Alex,

On Thu, Jun 20, 2024 at 8:10=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> > NB, QEMU is explicitly *NOT* targetting the C standard, we are
> > targetting the C dialect supported by GCC and CLang only. IOW,
> > if they have well defined behaviour for arithmetic on void *,
> > then we are free to use it.
>
> It looks like GNU C does support it:

GCC does support void* pointer arithmetic as an extension. But if you
decide to use other compilers, you might not have the same luck. We
(and maybe other developers) would like to use the QEMU headers with a
C++ compiler where this extension is not available.

Regards,
Roman.

