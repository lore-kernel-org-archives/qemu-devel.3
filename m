Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F381093176
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Did-00048h-GV; Tue, 24 Mar 2026 22:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ihanzhzh@gmail.com>)
 id 1w5Dia-00047a-Cz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:11:37 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ihanzhzh@gmail.com>)
 id 1w5DiY-00063C-OH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:11:36 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12a71ade78cso2522933c88.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774404690; cv=none;
 d=google.com; s=arc-20240605;
 b=bh249yPYS24fjL+s4/23xjdBUwKmn6jiRQ3F876MOkm2NtAThqoWOui7Oa0Sr+ZZ/2
 2kwstqUBOtY6iDHxxY3fE9J+g/C4horU9ddlzis4IBeBn+Sp3ywxWGhS2HKEa/Q/bUQp
 vuQQBq3tXKqoiTKEXnnOEXcsWovrwAYLZRKFlJ3jQlmyb90mPoVjmEO12LxZjjiDvOhL
 TFelBsiV9LhzEkVHUw5RfFyTK6yVgUDrKWQFBvWqdfaVmLhN2lkfEC4YChPRjoe8PNk2
 I+BTskghmKlTt5By1DMjjnFCv2jCVbmPOvj2284pJkwNpS6oUdsSG1ppuBhKDw15oAjj
 VJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x9s1+USFW1cgr2zZCDwis+WmhFpc+u2jTsZAMjxK+6I=;
 fh=WlZ0NOPX9VRCtnVf1GW4HH+o9vTsrrZz9IxsJTj/FN0=;
 b=Ky11dSJZKii+3ptI/ObDxZn7fRg8P5Ny7LEOn+IhjuUkeA9+DDoDXjWTFo1C5tNi5c
 8ZPYrRjjU20nw8J/TvyKFIvgclkSgmbAxpywFGamF14kBT1GLxwfYLy2ntwljcvA11K+
 CVTPJ2KeBsA0y7+BlC/OEqFUdJyMfyzIUYqfm17MkW4jHEW3qMAuzgT3a2Ep50YyWiJ2
 Sf1MbDvzzj5CaAzaJ3JtkRR6fbJ/minmTdWGmHz8sjqBU3WJyDmFAvmo0HTqKpdK7Cfk
 tQptPO/E84iaLlCZFA+Bqwrug2dHQxACKj1OYRGf1jcXfW9Oxb0b2cz87b5hLon5g0Zm
 QtYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774404690; x=1775009490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9s1+USFW1cgr2zZCDwis+WmhFpc+u2jTsZAMjxK+6I=;
 b=QjliHuzD81sg4bW+DJK6m9dj0DQC1wezt91vdQNTZlQcDAHNg31a/F/DrL9zqFJ3nQ
 aGuKto2hhagxUR7VyzcSx5qfYSpQ+k/myIK2Ahf7bD3F8z8rEJszCV67zFqxWurejZAE
 Yf21Mt0bh5JucvlBxqTGbaRgyRXJeoFLxemzZrst/17khzC8JK4jHLvHe2ZncM2le3H7
 3NOSo4lPj6+9d9OWBf6G3pFwkS4L4YBOv6nf+5TMdvcit2bfgiSVM8ygzVNEy+tUyQnH
 XmPPlKg3VwKVP9iAuN5GG+PHGPyMz0uF1pco5mcsfpMMLBB3tXPND+vMnuTEulQpVKFO
 zFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774404690; x=1775009490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x9s1+USFW1cgr2zZCDwis+WmhFpc+u2jTsZAMjxK+6I=;
 b=jxvkXjxoGWwelXk7vdt8gG6kfClX5QqDD4kyxwee3RUtuThk/7N4qaJ9yLLAXt0+PN
 ak8sigFuKEjPoIb3D5IQJw7U4kqNeHsXC2RyJpAfX+h3zPy4mr6N6CvsFSg6e/RXe7D3
 13kTco2F0OqwTMtVy+G9A7M19jJ4efvhzcC5rJOj7hJwR1420318/DgiYEilCP5K889V
 w4LcX5TCmJyNzk1OUWoIyciXPz5uNv7ftiQbyTF1/n3my/4SJghs2g46M413ZfQ0aVHP
 B1WKPEUnkjQCYE+uvTBvxOCQ2oJ0pEb0yISAYnlszWdmqncscmHuDhMPnY2kmiPHXPPB
 EPBA==
X-Gm-Message-State: AOJu0YwLj5BUnFKNQNmolSz3NtoXl8IwOoUjPe0bajtpymXPTqLGshIr
 aVQF12FYNn7ZV1EdGu44Rwt5Q5PqfFAYSETASUPSYfpF8p5foWbx3DzS9Hu8epfR1PoUxej88KC
 e4cRx79dtkheTU1QGmBzcVmpfoMLu2Q==
X-Gm-Gg: ATEYQzyuYyCKsJHpyRbO5inwT4bm/TiNwlMgxJOKdWoVr8CAI4Ge1zk//iqAPPLkg6k
 XRz6/C0m3kgmcEYrxr4vYaHBdrWwzviBgQRZC9M4kx9uwezSxvt49Vu1JHsqeOFwVE1jqXrAzMT
 AKKyCgnuJj0NH+O1Q62sKExrEWfw8rmfMaiqeEttWj1fS9tVUmusx71zLGXhbck3dd6ceHpexqY
 O8aAD+7cSK509seWhiqjnIl2NUjg2dy4C5pr+mqfwieyRerLK1voPdSdYJf8N6DbYQ4XRY6Hnk2
 ln6Xvm1aklj3eQTP0Q==
X-Received: by 2002:a05:7022:438a:b0:119:e55a:9bf6 with SMTP id
 a92af1059eb24-12a96e73d7emr797427c88.18.1774404690304; Tue, 24 Mar 2026
 19:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjCdDAJomXwQ8Z0kkiDGn_8hLWredsby3Nwy4rRgeC9sywc8A@mail.gmail.com>
 <cf2e482e-65fd-418e-bdda-9948c2b39ff3@redhat.com>
In-Reply-To: <cf2e482e-65fd-418e-bdda-9948c2b39ff3@redhat.com>
From: Han Zhang <ihanzhzh@gmail.com>
Date: Wed, 25 Mar 2026 10:11:19 +0800
X-Gm-Features: AaiRm51noEd9mnwe-5GgPU9nsQUhJaE27cy8f1JtO4mwzrshbzxUIAJkoOsiGLg
Message-ID: <CAHjCdDAju_svU-RHMP11JYM3G+yu6gwNFTHrAEP3GZnRGLodyw@mail.gmail.com>
Subject: Re: [GSoC 2026] vhost-user memory isolation proposal feedback request
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, tfanelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=ihanzhzh@gmail.com; helo=mail-dl1-x1242.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 25, 2026 at 1:26=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> Hi Han,
>
> I=E2=80=99ve taken a look at your proposal, thanks for submitting it!
>
> It clearly shows you looked into the code and the vhost-user spec and
> made yourself familiar with both, that=E2=80=99s very good. I find it a s=
olid
> concept. I also like your clear separation in fundamental work and later
> optimization.
>
> I have one question: In the optimization section, you suggest using a
> memory pool. I fully agree that=E2=80=99s a good optimization, but it mak=
es me
> wonder what model you have in mind for the original implementation. Do
> you plan on allocating a new buffer for each request? (To be clear: I=E2=
=80=99m
> not saying that would be a bad idea for the initial proof-of-concept,
> I=E2=80=99m just asking for clarification.)
>

Hi Hanna,

Thank you very much for reviewing my proposal carefully, and for
raising such a precise question =E2=80=94 it is extremely helpful.

To answer directly: yes, in the initial implementation phase I plan
to allocate bounce buffers per request (more precisely, per
VirtQueueElement) and release them once the request is completed.
This is a correctness-first approach.

> To help make these detail questions clearer, could you lay out how an
> example request from the guest to the vhost-user back-end would go
> through all the layers, and the response back?

In the initial implementation, the request path from guest ->
vhost-user backend -> guest is as follows:

1. Guest submits the descriptor and kicks the queue.
2. QEMU intercepts the request in the SVQ avail handler.
3. QEMU allocates isolated bounce memory for the request and
registers it to the backend via ADD_MEM_REG.
4. For the guest->device buffer, QEMU copies data from guest RAM
to bounce.
5. QEMU constructs shadow descriptors pointing into bounce memory,
injects them into the shadow vring, and forwards the request
to the backend.
6. The backend handles the request: it reads input segments and
writes responses to output segments as needed, then updates
the used ring.
7. QEMU processes completion in the SVQ used handler.
8. For the device->guest buffer, QEMU copies data back from bounce
to guest RAM and completes the request for the guest.
9. QEMU performs REM_MEM_REG and frees the requested resources.

Once this path is functionally correct and covered by tests,
I will prioritize evaluating and rolling out a memory pool approach:
pre-allocate and pre-register a reusable set of bounce memory
at device start, then lease/return during requests.
The depth will be decided based on
implementation complexity and measured benefit.

If you think it makes sense, I can also add this "request lifecycle example=
"
to the proposal text for more clarity.

Thank you!
Han

