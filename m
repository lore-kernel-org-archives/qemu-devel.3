Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A530CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMen-0006Bn-2G; Mon, 27 Oct 2025 08:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDMec-00067E-SN
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:48:55 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDMeT-0000KA-5D
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:48:52 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78488cdc20aso59180007b3.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761569321; x=1762174121; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t4zyEMRcnSg6ZZFupcnqm9G8YRu9xpKxN+WWw0OX9pQ=;
 b=Nd4P0sBjH5yLMIagbks3cUBJz8QgC5V0EhnL2gL6TxOJ4Y8qyAnabD6zqkJWD7ALlY
 VDx6rFcrYQdtLUqfsJi2mv00S3qzWOnROkNOvQeeYA46a+m/qllJ0FzaDdE+4aBXZ/NW
 mflXXfb4jvr3KmWPqMu00C5kCEr3/0k7veQ5/eUmI0GMDpVpSgWg1W9AFHGat/ldZGBG
 gGtsyJkkiyf7ZVghvU548zToJCtYhOmkR6QM3DO3Xh8R8k1nImHVVpSKAyMSBioN/RWY
 C4kzj0IzsYGjE5K54Jj9/ehDGpGUEK9hMKeYnByofdZjrxcwccbAXiJBE99rlbt2josd
 vlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761569321; x=1762174121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4zyEMRcnSg6ZZFupcnqm9G8YRu9xpKxN+WWw0OX9pQ=;
 b=eIcw6PPtiD83fnF+74/hfnxFoBKaZQSC+hz1mpFM4StWgB5RsedHIYtBKKQFv6PiEv
 xvh4+8OCJRrnGvKHSRiPDpOfNLMNxPNdXP/4kCFq74DsJIP252W6ZoCQjHrS0uDTgUU5
 SAtRuqE8pZRl8v+HA7Dr7tbyAoBrGzV4BJwpu1uhTfJk/IGIeiEwzcnsSLYAiuOw9ZfY
 9skOAGWYIjEO+Yd1WfKbTcS6L3VsBFhKmNutxDtkhUQF5adPQ4j515WToiSojieCiYMR
 /WdERErK1qWk+EeA+MtiICFa/w2jpJ3Hf6tNm5muD/byb5vFYbbe3uaTkCmDFdH8ChDZ
 5eRw==
X-Gm-Message-State: AOJu0YzDw8WoxqmZSkzcS1OhSrQYL+Un4IiIXI0pwdRKZBXe9BV+IFni
 5ROKGIXrynFQX86sazam31FZQcACnOsvpDxh6X2G1a1y9RJR/K8nwuNq0tVs8vtoJEDm1IoZoE1
 FFV/mjlJv+CJRjpYKUVdQnA+uVCWUhqtPLdNCwPtymzJ5cDqLE0m3
X-Gm-Gg: ASbGncsrjZ62KE2IptThutanYeQ8wyrWF+MITSjzQoFHehzopFSfLa0BvoeGJ8UivQo
 S2dxuik/z85DhDMim4T8bUS8i99Yq3uUxY/dKKdNOqpkLM0EsYLJpFZJBygKVD8IAUJ9bwHaoZs
 PdbzgqNFXCbuviGHl8XsmaLtbTOOzrwL1XUrg2kjJQEu0XdvOruBLuRT+ObkOSFZVvxGO4LPeL9
 Sy/s2YcIYEPE3R1N/E0NevOt91LlNnXPJ8zJ1MTRGJZiOvaJJv92LInbfYIFaFQ3q+eYXCZ
X-Google-Smtp-Source: AGHT+IGpaAMSKJKO1jUD3h/ZsQJ68Eho5HHfARfiSEeuB2/2crqps4P6t9R8tfq3HIjl75KTHGZeHlOWyibXHsvDaC8=
X-Received: by 2002:a05:690e:dce:b0:63f:5642:74bf with SMTP id
 956f58d0204a3-63f5642771bmr4042113d50.15.1761569320852; Mon, 27 Oct 2025
 05:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251016131159.750480-1-peter.maydell@linaro.org>
In-Reply-To: <20251016131159.750480-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 12:48:29 +0000
X-Gm-Features: AWmQ_bmRaalBI0ZMlLkXylUAg8iNr7aeDyXaHbdMVHZLDDE3VIOOwKVGTzDaIfM
Message-ID: <CAFEAcA8RaZOXpav64E5-0CDhB66zQXRuLaFuz22GiyPGwGVQJw@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system/security: Restrict "virtualization use
 case" to specific machines
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org, 
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 16 Oct 2025 at 14:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently our security policy defines a "virtualization use case"
> where we consider bugs to be security issues, and a
> "non-virtualization use case" where we do not make any security
> guarantees and don't consider bugs to be security issues.
>
> The rationale for this split is that much code in QEMU is older and
> was not written with malicious guests in mind, and we don't have the
> resources to audit, fix and defend it.  So instead we inform users
> about what the can in practice rely on as a security barrier, and
> what they can't.
>
> We don't currently restrict the "virtualization use case" to any
> particular set of machine types.  This means that we have effectively
> barred ourselves from adding KVM support to any machine type that we
> don't want to put into the "bugs are security issues" category, even
> if it would be useful for users to be able to get better performance
> with a trusted guest by enabling KVM. This seems an unnecessary
> restriction, and in practice the set of machine types it makes
> sense to use for untrusted-guest virtualization is quite small.
>
> Specifically, we would like to be able to enable the use of
> KVM with the imx8 development board machine types, but we don't
> want to commit ourselves to having to support those SoC models
> and device models as part of QEMU's security boundary:
> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
>
> This patch updates the security policy to explicitly list the
> machine types we consider to be useful for the "virtualization
> use case".
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> changes v1->v2: updated the list:
>  * remove isapc
>  * remove ppc, mips, mips64 (no machines supported)
>  * list pseries as only supported ppc64 machine
>  * list virt as only supported riscv32, riscv64 machine
>
> I believe the list to now be correct, and I think we generally
> had some consensus about the idea on the v1 patch discussion, so
> this one is a non-RFC patch.

This has now had various reviews and acks, and no
suggestions for further revision. I propose to take
this via target-arm.next, unless anybody has any
objections.

thanks
-- PMM

