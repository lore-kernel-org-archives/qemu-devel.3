Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E1FC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp97E-0008Go-OA; Mon, 03 Mar 2025 11:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp979-0008GE-Eh
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:58:00 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp977-000676-I5
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:57:59 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e609cff9927so2980802276.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741021075; x=1741625875; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JDdNNDIGD6qLkCEwUDIPfxwbiUHlqGMxKq3J34rqtM=;
 b=cyoQVq4VjFWfUew6X3TgrX9LYK+YuidkqcZfRpHusL1zg21OgwP91MdunwNDEhu4L8
 nulzYvRem8tOLCI1T4iXPDqDRv53H3oj92QknR6ISTm9ywGEfsHseUHuaw+GSVE0xSsL
 NE+n+elhUgIfIpBhzFOquNVhXc682d3Q6vgHcTdVoDJClmGkSNsMBSqgcII/oMAtdjg3
 GushS68mkTbYxiFfhiq3yY6Q5uLWXWD0vsHngZ38IjFIaP3zuqHsofZ9VMJ7WiVERBUA
 E5q+tbRRekyXSwWCwjvbvgoQ9HyjxB9uPw8tWjy9rUPOz7uw/R0NP3O3+GKuuktkfxIR
 BXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741021075; x=1741625875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JDdNNDIGD6qLkCEwUDIPfxwbiUHlqGMxKq3J34rqtM=;
 b=w77vcbGTKEaS9kL+zN+Np0e9tZRoFYMCcOvZTR5FFlsXRFxmfNYXN7VPxnkfkb22WA
 hV5mJAFIGLxx9LwZKV6fO8xQCTwdzkKE9Gu6r2P4QC5q91JJRx6C9KBBTExtgu5QEs0A
 Nbmer0HnE44rrba1RuOGdRp5r56K2EuuHlN2iu1L8jKkGZ2bcJre8f+Tozt7JhZrmtfI
 PERb7diXIkpLd7uV8BrjCESX1u4A1reX93TbICbXO3Xe4aZsL74AbT1cgKjLFaFQ6OMI
 jS0UHFC1GFAhCBR7c4ytsMnY8kLnS1SXxjnotlQui1LSURllknEJIVsvwG9xaVV2TomF
 PPxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw+LBko2reSyPO8M9VN7bsTDzkxV8ptgRsQhfRYz1Yynvbi9SGjrdPJ0X6MyLPg4dmSWL8Him2ck5h@nongnu.org
X-Gm-Message-State: AOJu0YwsDDG7z3nkCQXH9aizzOD9fv3PuOjdkIqyZ2OpJ3v4Ox/j3upm
 CfVLWOeKpis7586OcuNAYxdmD2h/sclKpZ2FMAazV0Tmj1rWMwbxXXeZBbUQFQlr54uiHEfk9mg
 DdOVud3KB+PTLKyi12fYqepUI5SfYeRFWpvuBiw==
X-Gm-Gg: ASbGncuzVZ84EzQ2A35JJvnYov3hz4CigEgbgUojjxELzcTUBz+2IzVP1vlTF/caeOK
 aqMVTjNb+CjG/IWvboEkJlsHoAVpXrG5eEiqZnCJWQDZGddSeqhokCjmlJTCf8IBApvtvT3Q7Fr
 WGuB13BumUJOHhQGRRCIlquSTMt3o=
X-Google-Smtp-Source: AGHT+IF3HP8y5PIgfaQc4kYwSMzm0MHqYC66idD7nLwY3EVQPw+WaEK5dJ/gLXWZLysXe5nQeWYHGUnDopToISTnpTk=
X-Received: by 2002:a05:6902:2745:b0:e60:b17c:4252 with SMTP id
 3f1490d57ef6-e60b2f2ec28mr16199359276.44.1741021075410; Mon, 03 Mar 2025
 08:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
 <8e3a5810-accf-1f77-8692-4e077c3ce327@eik.bme.hu>
 <b0b56480-0b5a-4f32-af27-13394795b58e@redhat.com>
In-Reply-To: <b0b56480-0b5a-4f32-af27-13394795b58e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Mar 2025 16:57:43 +0000
X-Gm-Features: AQ5f1JrIdEnKfauDwnBlDbwIPnQf8QBVpZQaY-NkamLCUjc_FJ8BRJ7BKUzxD-s
Message-ID: <CAFEAcA8FRyuuPxZQhLM8Jq4iD6TEMqN+E=iTNfNOeafTzTBeNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 3 Mar 2025 at 15:49, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> Why are we keeping qemu-system-ppc and qemu-system-i386, and arm,
> since qemu-system-ppc64 and qemu-system-x86_64 should be able to
> run the same machines ?

They're not identical -- for example "-cpu max" on
qemu-system-arm is a 32-bit CPU but on qemu-system-aarch64
it is a 64-bit CPU.

There's definitely a lot of overlap but we can't just drop
the -arm executable until/unless we figure out what to do
about the corner cases where they are different. Plus there's
a lot of users out there with existing command lines and
configs that assume the existence of a qemu-system-arm
executable.

thanks
-- PMM

