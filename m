Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51632C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZZj-0000KQ-L1; Thu, 27 Feb 2025 03:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnZZh-0000Js-6p; Thu, 27 Feb 2025 03:48:57 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnZZf-0000QT-As; Thu, 27 Feb 2025 03:48:56 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fe848040b1so1438016a91.3; 
 Thu, 27 Feb 2025 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740646133; x=1741250933; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyoLGRcN2Qs1kmufYOQ4ZS0muaC0RDxZDUoeISj23Gw=;
 b=jjKrrYZ57yjiD+hc/Ish9AYOX/ZXOf37GUcyI+o9LLT6PAfmce6zZSBuY9bxEYUSKD
 wXgY6BXTDDL6Gw4ehBN+63OaB6in0Inx5DU9Tm9OgiRvSBgD54w2idnRHMBwk9tVeUSr
 TVH18ImJOEu8u+4A0uAOvBRct141T+MuBtZdwLpJ9VMH5IzF/shSdIK/z8vlHgvCAnAz
 zMfaYNuFiPX04Ypca29lvcGRE0y9xJ5L5l/ucTNbCY8HZk6tGYVnFIrvYQd8jkKtGXvF
 ykCsaVoCp9dXFiNUm7Et/vnH2FBnb4WXf6V0gm/V5t48XnzELz2AgpUxrOniLnL6QEbH
 4DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740646133; x=1741250933;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NyoLGRcN2Qs1kmufYOQ4ZS0muaC0RDxZDUoeISj23Gw=;
 b=lYNAvSes+ZiVVkOPTETIsmLsqG1FoaowjAYzk/rnCzbWJr9q3io7dqPGbM3Rkrns/m
 cWB4k9lJDgaeuISg/Vm4HATTfQpb4kFfk2lljzM6DRsuiOkpKfh7PBbCEA3rK8ZADSXw
 D4kFFxp65ITe6GHGFES4/KCbZkVWYW/kpKc//oU7tQlwbnnhS37e9Nsuk2SuNZtKK0FY
 gCStXpYKBE8aHiD4VGp9Svyf93t3kjj+3je+hQqryEEGfQRFtxNqcEsHjRbOdqgQS5L9
 XUZ8rSIAM4CFvvAt+lKFVqj0s83CtBEyksSpooK3/mJzMimU/X4NbstwZ9s8XXUpp5+K
 1f3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt1gof0gR9SS1sQCC4ugpeqtIEMDXMqfms72zsj/TWaf0SdZvo4pyQhS48H+CAbDUucHwulLt0Fxyw@nongnu.org
X-Gm-Message-State: AOJu0YwDqjnHk02TqAQ1rzTO404mmG45mZXAlsvX3VF98b5i/+HAWXCc
 LttoqVJsrqjiSj5EL2dZ82PWiRgBBdI/vvEDCxEEKq2O/fVUjY18
X-Gm-Gg: ASbGncvmcwWLdP7Ti7ogUGVe4iHA6t2k80Ijl0KjzatOVqqMnnu+LYHP/QxngGxJNy0
 nCZj2GJN7h9rVKYpO36rxawdW4lMUtMhaxudTqQCued67kZJ4B34rT6Skq3aQAYTwFNdE5KIld3
 T4rIG8v6+9dE0tQG1T+zrCinNIyNjtxXmYFNo84FJ9JXQPVUggzWAA4CJPxb8VL7Xv1adFq2/Ti
 /xN65EizQ5Z8wX+gk02Nj+q6JOtChgO7Nq5LWTq+9rLLBZ2s2yDJwDg4BuIk/NvorGZKmBBu9JR
 63UjW/JBpUqYS6grRw==
X-Google-Smtp-Source: AGHT+IH+t9CoF4QNlx9Mox4V885PjyLMNf9u1YORkkdExsvCmpZwusXy/UpCBaufROitcJc23nQW4A==
X-Received: by 2002:a17:90b:268d:b0:2ee:59af:a432 with SMTP id
 98e67ed59e1d1-2fce874088emr36530694a91.31.1740646133103; 
 Thu, 27 Feb 2025 00:48:53 -0800 (PST)
Received: from localhost ([1.146.124.39]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea676bf4esm986135a91.18.2025.02.27.00.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:48:52 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 18:48:44 +1000
Message-Id: <D833JYHF1A5A.1QP2LM99MU7XE@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>
Subject: Re: [PATCH 1/6] hw/ppc: Implement skeleton code for fadump in PSeries
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-2-adityag@linux.ibm.com>
 <D82WB0T0PJ0H.3M2NGHZT4M9SW@gmail.com>
 <7ec1dc4f-e7b1-492a-8cf2-b971b11bc31b@linux.ibm.com>
In-Reply-To: <7ec1dc4f-e7b1-492a-8cf2-b971b11bc31b@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Feb 27, 2025 at 4:49 PM AEST, Aditya Gupta wrote:
> Hi Nick,
>
> On 27/02/25 08:37, Nicholas Piggin wrote:
>> On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
>>> Implement the handler for "ibm,configure-kernel-dump" rtas call in QEMU=
.
>>>
>>> Currently the handler just does basic checks and handles
>>> register/unregister/invalidate requests from kernel.
>>>
>>> Fadump will be enabled in a later patch.
>>>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>> ---
>>>   hw/ppc/spapr_rtas.c    | 99 +++++++++++++++++++++++++++++++++++++++++=
+
>>>   include/hw/ppc/spapr.h | 59 +++++++++++++++++++++++++
>>>   2 files changed, 158 insertions(+)
>>>
>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>> index df2e837632aa..eebdf13b1552 100644
>>> --- a/hw/ppc/spapr_rtas.c
>>> +++ b/hw/ppc/spapr_rtas.c
>>> @@ -341,6 +341,105 @@ static void rtas_ibm_set_system_parameter(PowerPC=
CPU *cpu,
>>>       rtas_st(rets, 0, ret);
>>>   }
>>>  =20
>>> +struct fadump_metadata fadump_metadata;
>> Can this (and other globals added in other patches) come under
>> SpaprMachineState?
>>
>> And could most of the fadump code and structures go under new
>> spapr_fadump.[ch] files?
> Yes, i can move it inside SpaprMachineState. Will put the code in new fil=
es.
>>> +
>>> +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>>> +static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCP=
U *cpu,
>>> +                                   SpaprMachineState *spapr,
>>> +                                   uint32_t token, uint32_t nargs,
>>> +                                   target_ulong args,
>>> +                                   uint32_t nret, target_ulong rets)
>> I don't know about adding a new unused function like this, is there
>> a way to juggle patches around to add it when it's wired up?
>
> Ah, that is problematic agreed. I tried to move around things, but=20
> arrived at this.
>
> I will spend some time thinking how to arrange this.
>
> Will need some guidance. How should I approach arranging the code in=20
> such situations ?
>
> My idea was to
> * First one is the skeleton: mentions the steps, but doesn't implement=20
> the steps
> * Middle patches implement the steps one by one
> * Last patch enables it all. So in future if someone checks out the=20
> "Enable fadump" commit they would have all the support ready.
>
> The major problem is "everything" remains unused till this last patch.=20
> But this 1st patch gave me the chance to logically build upon this, eg.=
=20
> first implement preserving memory regions, then add the fadump_trigger=20
> in os-term rtas call, etc.
>
> Any advice to approach this ?

Yeah, sometimes it's difficult to avoid. Especially with a new
feature like this. If you can't find a better way, that's okay.

One thing could be to return errors from calls. RTAS is a little
bit tricky since there is no general "unsupported" error because
the presence of the token implies some support. You could return
-1 hardware error perhaps.

Another option is implement the call but not all functionality.
E.g., permit dump register/unregister, but don't actually provide
a valid dump on reboot (you could ignore, or provide empty or
invalid format). Downside of that is that if you bisect, a kernel
test case could go bad because it appears to be supported but
produces invalid result.

To avoid that, perhaps you could trip an assert or just log an
error message when performing a reboot with crash dump registered.

But as I said, don't make it too convoluted or lots more work if
it's not easy to rework.

>
>>> +{
>>> +    struct rtas_fadump_section_header header;
>>> +    target_ulong cmd =3D rtas_ld(args, 0);
>>> +    target_ulong fdm_addr =3D rtas_ld(args, 1);
>>> +    target_ulong fdm_size =3D rtas_ld(args, 2);
>>> +
>>> +    /* Number outputs has to be 1 */
>>> +    if (nret !=3D 1) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                "FADUMP: ibm,configure-kernel-dump RTAS called with nr=
et !=3D 1.\n");
>>> +        return;
>>> +    }
>>> +
>>> +    /* Number inputs has to be 3 */
>>> +    if (nargs !=3D 3) {
>>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>> +        return;
>>> +    }
>>> +
>>> +    switch (cmd) {
>>> +    case FADUMP_CMD_REGISTER:
>>> +        if (fadump_metadata.fadump_registered) {
>>> +            /* Fadump already registered */
>>> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ALREADY_REGISTERED);
>>> +            return;
>>> +        }
>>> +
>>> +        if (fadump_metadata.fadump_dump_active =3D=3D 1) {
>>> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
>>> +            return;
>>> +        }
>>> +
>>> +        if (fdm_size < sizeof(struct rtas_fadump_section_header)) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                "FADUMP: Header size is invalid: %lu\n", fdm_size);
>>> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>> +            return;
>>> +        }
>>> +
>>> +        /* XXX: Can we ensure fdm_addr points to a valid RMR-memory bu=
ffer ? */
>> RMR memory? There is spapr_rma_size() if that's what you need?
>
>
> Thanks, will use `spapr_rma_size`. The PAPR says fdm_addr should point=20
> to a valid RMR buffer, I guess that means it should be in the RMA, ie.=20
> `< spapr_rma_size()` ?

Ah yes, PAPR glossray says:

Real Mode Region. This is an obsolete term that is deprecated in favor of R=
MA.

So that should do what you want.

Thanks,
Nick


