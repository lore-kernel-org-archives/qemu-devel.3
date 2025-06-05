Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F186C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 15:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNCCM-0005BQ-EC; Thu, 05 Jun 2025 11:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNCCL-0005BG-GY
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 11:08:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNCCG-00053o-Kh
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 11:08:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d54bso1987373a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749136079; x=1749740879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8KIjqTrSb1gnM1Xlts3+FGg0Fp4YHSTgKT3RYUjZiQ=;
 b=EzLqUN8Arz6JlPBw+fLL+Uaj1/Y+u5p7s+7NE22t5RKiBpItumFQ/NpsL8db3ppZSY
 JOWAv42OEF+r9p7EkCyIysluBU1R6vKu4eCYIQcm0Zu8hkts+l2SoBSiVWOEj+E0Et3d
 0i4Qjsbc+0zOPXVZnSQ/1uFNBY+Zmv4h9GJN7mKhuvT2NfAlCZfEVnh9H/33hYqVa1z8
 8SfjbSeg4V5zU6toKxK3sDqY/7GCcoDQmFAVUMOm/BDG16enmuPJtAP8g410ChOtqexr
 YTNoBSG7ZCG/tHcxD4ond5CBShcvC4A8cWtmPTiWWxh69uXxUOeVQ7FQeA0a9Pp+I1hs
 ZCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749136079; x=1749740879;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t8KIjqTrSb1gnM1Xlts3+FGg0Fp4YHSTgKT3RYUjZiQ=;
 b=tDUmp6+tzIl/N+4CPLKnmWExblEV7C4IYIUHg/+WvGHCr3E8orf5kn3kqEKFpvKBhU
 ShpiwIbjlX0qo3oioxfOl+oVqhwcR2nkFVP6qiiK/zJoUi1tEK12FyrDC+NmqIFwpPYR
 uAJf6T59OAZvHz/h8QmOlkaTRqTdkujnsKGkqlQtsgElUeakskc8XzXiFxGUez0SzH8n
 IWcG/WSO5X7AvW91Dy8cp27sgow2ibqXRfwi5/YfabOUzuAilB/HMnfAc4FrNUrTPS1l
 jJVuvVp/azCEo1T4+c8DgRw3Q9zgKsMs/C92kLZwIeb4/oqdpibdqN9Jyz/Kafpnu1EL
 Qi6w==
X-Gm-Message-State: AOJu0YyB13akf0Q0BE9MzhuHb/cYJNVX6qlDSLL9z3x/FOdeyOt/sFyU
 oVRsfKDFYxCCNPQSGUfTezz4uUJqJaqYYKc+UjMoq9tzF476A6i256Qpv9BJ8ySADVo=
X-Gm-Gg: ASbGnctbVU80Te/IX9RJ5NNVXggweTNHa9qnH4nd6aWy+Qw9g+cnh6eBJrObKZiqR6x
 t8uzGu8yL8ANka7d4AU3tl9jvMnOo75CY0RLovmf34/jxOAmYIq+WFXGjuQqzZy7A/aDczkOUWF
 bsxCWrk/wOKKIja7CDLMs1X7+8lcoKm8EwpQljrhvfYcfODCivXc+Tr0jTp+rjhbcCO9NkzPcky
 t/HiQ82ym8uZr026jnFWgriQdH+lSHRoTNIZKb5/eMVTMuMMuPcnuXiA1kgr/HCEs+8kZ8qZJdF
 /8NlrwUuk/6+nyCiY0+AqNyPfwupeBeQIe9UytfQC1A70RYneKab
X-Google-Smtp-Source: AGHT+IEfPtomfzwRAb7vHQpT9spQT77cz0Q4F2OwhcNvmPYzPUK5RFxx5pqNz2+iYRcs+Obyq00Dtg==
X-Received: by 2002:aa7:d842:0:b0:606:ef9e:c711 with SMTP id
 4fb4d7f45d1cf-606ef9ec815mr5354603a12.30.1749136078689; 
 Thu, 05 Jun 2025 08:07:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-606bea242d3sm3540899a12.60.2025.06.05.08.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 08:07:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 700CE5F782;
 Thu, 05 Jun 2025 16:07:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/3] docs: introduce dedicated page about code
 provenance / sign-off
In-Reply-To: <87sekeckba.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 05 Jun 2025 16:52:25 +0200")
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-2-armbru@redhat.com>
 <87a56o3gxc.fsf@draig.linaro.org> <87r000ypi0.fsf@pond.sub.org>
 <87sekeckba.fsf@pond.sub.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 05 Jun 2025 16:07:57 +0100
Message-ID: <87msam5ir6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> [...]
>
>>> We don't mention the Link: or Message-Id: tags.
>>
>> Yes, but should it go into code-provenance.rst or
>> submitting-a-patch.rst?
>>
>> You asked for guidance on use of "Message-Id:" in your review of v2.  I
>> understand the practice, and can write guidance, but I wanted to get
>> this out before my vacation next week, so I left it for later, as
>> mentioned in the cover letter.
>>
>> How do we use "Link:"?  What about "Closes:"?
>
> I didn't address this in v4.  I could try in a later revision, but I'd
> prefer to do it on top.

Sure - no problem.

>
> [...]

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

