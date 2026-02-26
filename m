Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93458FC591C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 09:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvY8h-0001KX-7n; Thu, 26 Feb 2026 04:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvY8b-0001J4-0b
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:58:29 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvY8X-0008J9-2H
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:58:27 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso669419d50.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 01:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772099904; cv=none;
 d=google.com; s=arc-20240605;
 b=Ogk8iqG1CGAXtyQfgrYRG0dlKrIB/XwO8QLHm1H2i0zj0IJ6eTO+p+n/RVhdWmf2m8
 NhO/TNdaPqnmGWJjO3docntuROTzHIk73iKcG/k2qqi+07Z4tdvpGCfMe7AGJ3CZIDUc
 pqEeJMq4nESnqXCn5JJ2WCDDit6asTTXob2GBs8VsjwBY9NGk7yMZxJdfC8Ejb8oca8L
 5P5oZEJU0bGE7i2BsjEzlUQyLvPLIR+ikz0ccD05SE+IIpG1BCtOdEz06np/OxyQHStc
 meQzlcMNI6DoUwvN+ZtVXC/mC696JGu4QWwFr2AKE5wh7tevZP7lLX/xQkwsD+fgrjxK
 5nLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VFATZ60XCCL4boFSmWZz5qWIVUbuhEjyvMqowhC/Ah4=;
 fh=kUbveSOUup10kivE9YRaKNPXso946Zr4aMoS8+2ZZpw=;
 b=GGSfkBgpmdtX3kF7HmuA4uaEyypwpyHM+cXcyjZogpN2ZiN+bwiRbpa+9aNwwQvl6+
 m/5o63gks0gbo9j9KJqhYesWNRwpqh5iCY8rlotdX5NlVBXiL35cUvYh5ssIPg7Pvrp5
 Fera6xLqnhsVhHg7Se7WydV1Z2t/rMA2WTLx07L7ynQMRcpYASe/A6mZjpj/4lNYuM9n
 NGs7jG3DqSgxh1LdYIA3az15PiJ2MLNa9gR6JJXh2pNkl5rMWPefyDpc1JAzef75XkEa
 QhmNuUbLulvW5fBdRwdk3Ji4M4e8ydLcws2AWjaS2jEVOCoYxZuznNi/x9svoWPRrEkG
 9RnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772099904; x=1772704704; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VFATZ60XCCL4boFSmWZz5qWIVUbuhEjyvMqowhC/Ah4=;
 b=xpNxXO9Uk2JEuQuTDBTNvUVjIPy2NIHyxQ9vbhYWQhu/28lkfA+jRs1yh58TdA4enh
 tbuIkUCQZB+lkOIpKgg4hFclJaQpEx7nhfTthxgMpi3UyG+kMVPn4K/KU7dJW3o4MR9n
 T/QTNLp2QUc151vljXW42DrxB48ja96/lPt84fh2x9nrIqSs58uBThkVdjavZKdtDtPs
 RSmk/OvQKu9oIZqQmVGTY1Ho5GY85rGHbDs7YMW633dqFVS7Qj2BPmn9/OkyO0AxGy2j
 lJ/SwnGQeEJACsL7/Wb6Y6xa6/cRAZOsGknC3B65iWIioZN/kxgFQX6jvMtoXv28y54T
 fLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772099904; x=1772704704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFATZ60XCCL4boFSmWZz5qWIVUbuhEjyvMqowhC/Ah4=;
 b=leROubBP3ZoHkUBqXejZykXBfagef97gmMQQAaogLaPodKVTN5FTlrhCRr6kzTzMY4
 cdCpYja4JmC2+O59IMsyg69tXejwRnoMNQQkzNz/Vt79thn1Z/HDiKJbZYI/EAZfSDN1
 4ux5nptiJEBPAKfu6T0b9sfRnQuB8jsZqwdasfzURGhSZ9IB5p8u7J4lxICX85YGLwD5
 xO9r+YXgTfpfFt2vVJQdvzq3R0Li5EOKlSVZ8chKdvSwUTG2oJBNPW19vgetX06Ob6Bh
 9bFsoMU9kLpMH4SK0N2d75r3QoUIOEc31fjFVBjedRrlY4qgPTV7/nCqGL0N7XTKkhMu
 mGtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrhioD61r6TZF/nPY88JQm374ZY2W3QVsA0Sr2+Vz0u1Xu0Gm4vc7wbBd9Of+gzRYrtjb/neo0RvGC@nongnu.org
X-Gm-Message-State: AOJu0YzY6R1V1jXX4BoOHX3WOyAX0Od3Gc0UEt0+PM+RWFgqgOXkZgzN
 DrzqxGB4ryRSd5KX/lgZxPMd7Im1274jbnjnU8NwrhKK5/3s2Iu/h5jWQoK296uYRwAwTlJncKZ
 B+1YC1AcmF5FWOvPfF8yApMyWa+2sw6EqCJRmigpr+g==
X-Gm-Gg: ATEYQzwUxNNQiQvszTosKD5AA3qJ/O3irasgPi19Xas8SLOKvlwvevDfpEiN+HzBCQm
 zGkagz477EPo2cEtNxJI3Ou9s4R8qizMdyyPuQ4+2QQtmXVwQvWIcy7qRVVJJze0LjFwACT8+xT
 CisyyGOtuN9rzSWbaKlmSebOQEj/mAOQe5AAjRnhNhgX5E86dSmRm5T7JJtxD6sL5MDnwyjCm4V
 FxS+uFnYS4TeU71evKV2GI5s+dOgGFeRxetGwEKPo1zlyjGNKl7ZCx+yToadb+OsNVmxIvBdZLG
 vmPh+MLKdODkSNz8xYBaal0PfkvF8V9XuCVp4ZSpmWNgywY36jrpJNorFccc1p2xG1iF8RghGDj
 xUg==
X-Received: by 2002:a05:690e:e89:b0:64c:975b:ecac with SMTP id
 956f58d0204a3-64cb7c7b0c8mr1324173d50.74.1772099903604; Thu, 26 Feb 2026
 01:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
In-Reply-To: <20260225081037.21990-1-shivangu@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 09:58:12 +0000
X-Gm-Features: AaiRm51RmVDEemboNWXvql4kvoytiCF37IeHeTGIW4Xj7JgNOmNTEnScoCU6zIk
Message-ID: <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com, 
 milesg@linux.ibm.com, qemu-devel@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 25 Feb 2026 at 08:11, Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
>
> The '-machine dumpdtb' command line option stopped working on
> PowerPC/pnv systems after recent design change [1].
>
> Fixing this by generating fdt blob in `pnv_init`.
>
> [1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Thanks for catching this. I would suggest having

Cc: qemu-stable@nongnu.org
Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")

> ---
>  hw/ppc/pnv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1513575b8f..9861714ad5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1261,6 +1261,10 @@ static void pnv_init(MachineState *machine)
>      if (pmc->i2c_init) {
>          pmc->i2c_init(pnv);
>      }
> +
> +    if (!machine->fdt) {
> +        machine->fdt = pnv_dt_create(machine);
> +    }

So we now set the machine->fdt in pnv_init() (which is
the right place: the centralized dumpdtb handling assumes
the DTB is set after machine creation but before reset).

That means that this code in pnv_reset():

    if (machine->fdt) {
        fdt = machine->fdt;
    } else {
        fdt = pnv_dt_create(machine);
        /* Pack resulting tree */
        _FDT((fdt_pack(fdt)));
    }

will never take the "else" path, and that code is dead.

It also suggests we should call fdt_pack() in pnv_init
before setting machine->fdt.

This bit code in pnv_reset():

    /* Update machine->fdt with latest fdt */
    if (machine->fdt != fdt) {
        /*
         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
         * the existing machine->fdt to avoid leaking it during
         * a reset.
         */
        g_free(machine->fdt);
        machine->fdt = fdt;
    }

is also now dead and can be removed.

Q: can the generated DBT genuinely be different on a
subsequent reset than it was when QEMU first starts?
The comments in the pnv_reset() code seem to suggest it,
but on the other hand the code as written will only
call pnv_dt_create() and update machine->fdt once on first
reset, not on later resets. So perhaps the comment is
just confusingly worded ?

thanks
-- PMM

