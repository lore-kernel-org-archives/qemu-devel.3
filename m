Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B61AD75BD8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 08:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE2yM-0001oB-VU; Thu, 21 Nov 2024 03:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tE2y7-0001nX-Pi
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 03:55:24 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tE2y4-0007k9-OY
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 03:55:19 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53da22c5863so661278e87.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 00:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732179306; x=1732784106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thQ71eUxkMnOsopeRwhJNcJjULidFDN0r6R6n/b4+Ks=;
 b=LddbePr1TQFC3D3HIYDaSsZbma7N94lm04ukmz1uE0x/XhP/HZUmrPXfRKUn4Q/AFW
 AVscsBhCOLgs299GVLoSyztENMplsXT+FN3oQ8pBJ3oB3t6TAKYgaJCNHpaQ0F1D/5cq
 3Rl8KBbLS5TthiYLfxemprFU2W2k5Ay6+cOzbsjtYzB3/bbz8sGc8LA6UWXLM5K4W2G9
 g0RExqecQoB+X53by9gmJfZNdHIyh5eBlGHZJWx7UKIPJMWwLLKvEQpl6QEKxfbOzk4v
 BE4MpZOURP5fnqxgRnTc4/zc2v6kWqOq2HUo4DZ5vkY9mkCeY3eDTgSVYmtiYXXxhAO6
 Q/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732179306; x=1732784106;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=thQ71eUxkMnOsopeRwhJNcJjULidFDN0r6R6n/b4+Ks=;
 b=ixxw5TOdrV1/UkvzEwL2AJskaIE5LKsjmuUKmc8A5U4lezn4IaMeYjNQ9wPrW9lJt6
 E0oBUjn+cKYFHoj0S3XnExcoL5sVu1KCHBWkNDsej8pHBqhxqmsepl0OdOwxGJsDAf68
 pWDCpOChGt7rLIPfoYEb924sfKTQceu7dm8bq4lwEj9bcKthHoj9zInCpsgk61Dagm+E
 Q5qm6ZCuhDyhAdvoyo450za3rSVgVUL0dHRoE4gjng0cq0n9c5rRXl3UphFy0gw6FwVq
 HWgCglvftOGNageGNdLyuqGlIbMFAcyBl5OMpnQgzmYg3gbpgHdBGgrnyNfNR/UZgsyN
 mqsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZC4HECdssm+dZJ/XAHf9/c8f2WWR/RkXAt83i/w1bWdZjGa5ZFPBGchgBGrZWGAAVvCzZuNjewLmK@nongnu.org
X-Gm-Message-State: AOJu0YzKiGQ0otdVmA1vn+YtnrHgGiidMcCvIpBsG3fXV3UJBqEcJflC
 MOYFhRBLghPcriyahhexFd/vGhTmVI8AVUm5rYm+Lsfj+k0O7IEdJh4anUqJE+s=
X-Google-Smtp-Source: AGHT+IFTxDOfo97T8UuALuraGKSZkvtV8LhCQb4MhrjHyMxaL7uLbr2Nq9Qs44R111SHvZ0rL3vzGw==
X-Received: by 2002:a19:5e54:0:b0:52f:ca2b:1d33 with SMTP id
 2adb3069b0e04-53dc1339f8dmr2114111e87.20.1732179305648; 
 Thu, 21 Nov 2024 00:55:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4642b8dsm46871945e9.41.2024.11.21.00.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 00:55:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3E92F5F87E;
 Thu, 21 Nov 2024 08:55:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH] docs: Add roadmap for heterogeneous emulation
In-Reply-To: <429ae2fe-9fe7-4c45-a627-70415b3d727b@redhat.com> (Thomas Huth's
 message of "Thu, 21 Nov 2024 07:18:38 +0100")
References: <20241119161312.41346-1-philmd@linaro.org>
 <429ae2fe-9fe7-4c45-a627-70415b3d727b@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 21 Nov 2024 08:55:04 +0000
Message-ID: <871pz5m0ev.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 19/11/2024 17.13, Philippe Mathieu-Daud=C3=A9 wrote:
>> This document tries to document the steps required to:
>>   - Have a single binary to run system emulations
>>   - Emulate different architectures in the same process
>>   - Have QEMU assemble dynamic machines at runtime
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>> This is the document that was discussed at the KVM forum 2024 BoF.
>> Since then I did some changes but I figured it'd be better to
>> post the discussed doc first then comment the changes on the list.
>> ---
>>   docs/devel/heterogeneous-emulation-roadmap.md | 892 ++++++++++++++++++
>
> Meta-question: So far we tracked feature planning in the wiki
> (https://wiki.qemu.org/Features) ... do we want to change that now?
> Otherwise, this content should maybe be rather put into the wiki
> instead?

I suggested the documentation route to mirror what we did for MTTCG as
it is easier to review and comment on the overall design approach on the
list.

In terms of tracking progress maybe we should consider the issue tracker
over the wiki because this is a multi-person-year process with multiple
developers working on it?

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

