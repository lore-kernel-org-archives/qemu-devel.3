Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0A6D1CDB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ATC-0003PJ-Nq; Tue, 22 Oct 2024 04:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3AT4-0003Jx-6a
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:42:21 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3AT2-0002BJ-ES
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:42:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9709c9b0cso7040760a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729586534; x=1730191334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uh7j+EizbCP0JHjQXeocUObfK4lkOlcXe69CFo/+4TA=;
 b=DTqWwqi4DMCS0R463RJbFRG5g2IXF09veQ9AbN/jMULM4R1WhPZ/ny1llfqcEy0aDh
 oEJpDfLm9GOJYh+1LIj+CpfSlva/QWZEuG7hP3AwV2/W12h9xxL2/cXMlOABB/LGRaDs
 QYWskrziZywixsuJLQ63b1nSoSF/tNc32lTmRadWYlXCaMQ8dzb5JnoonoxS9PheS8wN
 WYz0Eb+krtEnnPUCp+Y7PHqqWDglpZdqcyXd95xEqu81reEbb+p8m/tw92975NeZQTzp
 py5R1mF14TzKS47803oi8Hxvi45m9FLI692e24zdb06W2cjVoqXrmOL0fpSQm3yY1IH6
 o0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586534; x=1730191334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uh7j+EizbCP0JHjQXeocUObfK4lkOlcXe69CFo/+4TA=;
 b=G/6cLaKBZf5uKP/9TG6G2v2vECZS15R7OTMQ2qEX8+8HwePRchMrJRWwu75XiT+RED
 fSc0AJu+UVhILTQH6dRyeiqCguvpIRoMYrg8cveIW/yP5e9ZlZprV4cpMuQQ+JHxOAHi
 qdvx4zQoxe6qVRRH/oHpjBKjxQEg0XxwUvPziR0ghtjEifwOvnwAa7uXW4ez8cDUWk+j
 du2AohFzOmoU/vr3JDSASSwxmw1mB4e7VogLWMpGI0+kXYawXEEjebXAyFonnW4p7uSS
 qMZqg+r6fs/lUbMbHmliDGxw8cxbMs33KBQkiZqy2q/UPvqURhxhoRqEiCGfSxn5YJ8H
 pYYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZm6EVgZfYwN1kRxbGfTLV7wVAeYoqZtTl9qMO5/CxWm2cI6rZUVB3zNxMiJNZ8U3uMul/Gh84UTAr@nongnu.org
X-Gm-Message-State: AOJu0YzjvB1fb0BFXAYJkgM/y4ddWNfGRwEUUN7xlGX8NDEUZH0WqIYT
 zRxmay3jlKrIZ5HrxGHoNHPfBiQlT8f4hbhlnCyvMCAcZAXhVxyRlsh6miKelQD2BT2gMeoueiB
 5RbFMHStIdaz/KkJFCGxySZyYmq2elu+Urt8JKA==
X-Google-Smtp-Source: AGHT+IGh2y2uVGL9swPmjgZSxgFyOqF+nmgLP9rHt6Tnhg9raPD2Cf2dNg8AvgxHEzFpUpS1HOjco4AGOY/Y7aZSQOk=
X-Received: by 2002:a05:6402:3511:b0:5c9:709c:247f with SMTP id
 4fb4d7f45d1cf-5cb782b13fcmr2537355a12.2.1729586534602; Tue, 22 Oct 2024
 01:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
 <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
 <ZxZwwe1ULIUqEdKN@intel.com>
 <CAFEAcA9E_-J3EJ+izeErnHDAwaP1LoctRaihu=5xTYrMSnqVig@mail.gmail.com>
 <ZxZ2KS6hi3Y2HdtC@intel.com>
 <CAFEAcA9V0yUCOkAWGumoOD_SMk-saS4OU5gL67gj7SRT0v4cPg@mail.gmail.com>
 <ME0P300MB10401C7825D982CE03574134954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB10401C7825D982CE03574134954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2024 09:42:03 +0100
Message-ID: <CAFEAcA9m=zy3MMcE+tZwpms36BUx+DsGvt7h1jSuqidFOx0aeA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_What_is_the_definition_of_=E2=80=9Cprivate?=
 =?UTF-8?Q?=E2=80=9D_fields_in_QOM=3F?=
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 22 Oct 2024 at 04:24, Junjie Mao <junjie.mao@hotmail.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > For Rust we get to make a fresh start on these things. If
> > we do mark all these fields not public, what would break?
> >
>
> The only thing that breaks today is std::mem::offset_of! which respects
> field visibility. Defining a Property const structure requires getting
> the field offset outside of the state context.
>
> To me properties are still private to the device state and must be
> accessed via their getters & setters. A solution to that is to keep
> properties private but make their offsets public in our alternative to
> offset_of!.

Yes, conceptually I agree that the fields underlying a
property are private and the public interface is the
prop get/set API. (In C the prop/get set can if it
likes do things like enforcing value limits, so looking
directly at the underlying field would bypass that.)

At any rate it sounds like it would be a good idea to
at least mark as not-public all the fields we can do that
way, and have a comment
  /* pub only because they are properties */
for the fields used by the Property structs, even if we
don't yet have a better way to deal with the latter.

-- PMM

