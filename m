Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBFFF01827
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySm4-0005h7-AG; Fri, 06 Mar 2026 05:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vySm2-0005gJ-Hw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vySm0-0008Cp-OQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772794271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qg/sCSLNNFSekErTQIoLqHn/ybY7uWsDmjr8lRCats=;
 b=gObQMq5LH/tVijeE5RTZbcOR0i+w/RobqZzaraw5snjjyZdANr+QAfed7Cmm0YuwcrwMM4
 V+ZK5uKV6X3wR1gAuQmXTRjXA8HRpiPzw59BBWoTUyWhRNFW332ImMHDnzVW7QVULtPMHs
 UdThqau3KqJr+n4BPmAvUKxns7QIAqc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-HG6YfksWOY-cpQ24FCF3VQ-1; Fri, 06 Mar 2026 05:51:08 -0500
X-MC-Unique: HG6YfksWOY-cpQ24FCF3VQ-1
X-Mimecast-MFC-AGG-ID: HG6YfksWOY-cpQ24FCF3VQ_1772794268
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so72060165e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 02:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772794268; x=1773399068; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=/qg/sCSLNNFSekErTQIoLqHn/ybY7uWsDmjr8lRCats=;
 b=KdLcK9bsnGk+jDsNdtzHtCijYIiwaZtD8HzrmlKdC/p1W6wXhXkd+jlDSuj7+pMXGQ
 D847DzvMfzeQS69M71wsjeGOKkI0sUBwq0YFuRn3+S/gOmxcvhBWjFslInzomMTMJmyX
 FVJb19zkk8WaXT2wv0CAa7zCQskHu9EE1TxDpRQ2Ph9QB2IjgNGj3hcb6xoPqf2ILcFr
 tCZBrIo/hkbc4HtSEYhdK+p8AI3fnojdOEW0o/8nuULTowZPpG08OmsSR5leD6L2IuQA
 TDOirHKZn8orfSzGAAlROIlD8O1n83qw0heX8Zrn0s4vUVJ3jUopSHBSI2kiUvfiSXWT
 pBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772794268; x=1773399068;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/qg/sCSLNNFSekErTQIoLqHn/ybY7uWsDmjr8lRCats=;
 b=msTQN0Mvt2Ek7ewmqsWnebo9xW+IAZEJGJ+KMh+5zrtK7dWey9tOpSbMTe52TRa8tk
 Q/Rbyocguso1OIue9QNnr0NUSMVu7tR6pE5Wsi1nBeYg9LW3oNk2BJa9ETEgxopp8Wbl
 Tj0qYabCXfflKKTwoYpxBIBkpzZ57XvthfVJYexb8c8bT2sYDBaigjxCbrKQ/Q2nNgvc
 vrY1lcm87tBfY3uRE6UHV9IWsjP6bpEC+mK5fMztfpRv1i+wjFGRI0TMctbjZC6TtkZv
 f0RTx29xc85E7YUDw+gPnZPhPzCoPSkuk29nBf4s2wQXq58i1uakPFGOY+EuUMLQqyYI
 3Ftw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdUCbkGp+iaIsRDh3SzLzNXRbHGY50dOw77QCFSuI7cWmKisgRBxWMs5a2ylZ95NxdOf4APAUGyiMW@nongnu.org
X-Gm-Message-State: AOJu0YypimQd/NO73DinYGG34rB54ZHh/UhMrqw2Dbl8Tme0+3gHg4df
 gP4ciyFdzKMZKMi3Xex6dyBfQ+fxPinMSDXGYbom/81/rnpjKwGbqKOUz5VEzscFepoYZWezGo+
 92nMkr1fNhisV5DsfXnKbdQ3vsl0vyaT/kFRDvwRdi3jUod7GW8xieR0p
X-Gm-Gg: ATEYQzxBPihAyLP7hdqfutuWZYzoHgYVbNG5RqrK42/b8t9h9EymYSiIenHFfEfvz74
 fDf4mLNVgKqXoWrs9G1peDZkJtDqKhLwH2lsdnmX5rRmYnmQCvWA1pJvtiZ7XCl7lT1mbypyowH
 1ik53a2SHfSVgRe7IJBR3J9RoT2ZKQHv2pDffjnJSxgeuJNBpJtGMI1dhcefg0Xv9wQE7f3x4Lp
 IPBBTYiyIqH9N+gromJLU8QoyIiy/ojJG+Rv1tA1SnBeMC6rBRPDpqrGhsEiEmvM15mlPzQjrZl
 13Hm1VcCNuQXYIrjyKkX95xf3Hf6kFO9VN4rcJBUn3IiglwwzvQPGtdjLKZcd3MC2DX00zhk5DC
 JGX3+FsKevy2hNkZRKB3sBDMW7UcRTknaUnxlJe8stPKuqr+XnRKgK2zVbQk8osO3aCU+
X-Received: by 2002:a05:600c:4708:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-485269587c8mr23574305e9.20.1772794267509; 
 Fri, 06 Mar 2026 02:51:07 -0800 (PST)
X-Received: by 2002:a05:600c:4708:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-485269587c8mr23573775e9.20.1772794266894; 
 Fri, 06 Mar 2026 02:51:06 -0800 (PST)
Received: from rh (p200300f6af4a490003d6f56739ca055c.dip0.t-ipconnect.de.
 [2003:f6:af4a:4900:3d6:f567:39ca:55c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb277e3sm98492625e9.10.2026.03.06.02.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 02:51:06 -0800 (PST)
Date: Fri, 6 Mar 2026 11:51:05 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v8 2/6] target/arm/machine: Take account cpreg mig
 tolerances in case of mismatch
In-Reply-To: <20260304102249.1963784-3-eric.auger@redhat.com>
Message-ID: <5ddefbe2-3514-fda2-a933-e2df46b4db89@redhat.com>
References: <20260304102249.1963784-1-eric.auger@redhat.com>
 <20260304102249.1963784-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 4 Mar 2026, Eric Auger wrote:
> If there is a mismatch between the cpreg indexes found on both ends,
> check whether a tolerance was registered for the given kvmidx. If any,
> silence warning/errors.
>
> Create dedicated helper functions that print the name of the culprit reg
> and analyze whether a tolerance is set. According set the level of traces
> and analyze whether the migration must eventually fail.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
> target/arm/machine.c    | 30 ++++++++++++++++++++----------
> target/arm/trace-events |  2 ++
> 2 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 476dad00ee7..13b8a0b2220 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -1065,24 +1065,34 @@ static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
> {
>     g_autofree gchar *name = print_register_name(kvmidx);
>
> -    warn_report("%s: %s "
> -                "expected by the destination but not in the incoming stream: "
> -                 "skip it", __func__, name);
> +    if (!arm_cpu_cpreg_has_mig_tolerance(cpu, kvmidx,
> +                                         0, 0, ToleranceNotOnBothEnds)) {

I don't get this. You apply a different tolerance type than the one
(potentially) registered. This check will only fail when there was no
tolerance registered for this kvmidx. But this can be changed by someone
registering a different type.

> +        warn_report("%s: %s "
> +                    "expected by the destination but not in the incoming stream: "
> +                     "skip it", __func__, name);
> +    } else {
> +        trace_tolerate_cpreg_missing_in_incoming_stream(name);
> +    }
> }
>
> /*
> - * Handle the situation where @kvmidx is in the incoming stream
> - * but not on destination. This currently fails the migration but
> - * we plan to accomodate some exceptions, hence the boolean returned value.
> + * Handle the situation where @kvmidx is in the incoming
> + * stream but not on destination. This fails the migration if
> + * no cpreg mig tolerance is set for this @kvmidx
>  */
> static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
> {
>     g_autofree gchar *name = print_register_name(kvmidx);
> -    bool fail = true;
> -
> -    error_report("%s: %s in the incoming stream but unknown on the "
> -                 "destination: fail migration", __func__, name);
> +    bool fail = false;
>
> +    if (!arm_cpu_cpreg_has_mig_tolerance(cpu, kvmidx,
> +                                        0, 0, ToleranceNotOnBothEnds)) {
> +        error_report("%s: %s in the incoming stream but unknown on the "
> +                     "destination: fail migration", __func__, name);
> +        fail = true;
> +    } else {
> +        trace_tolerate_cpreg_only_in_incoming_stream(name);
> +    }
>     return fail;
> }
>
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 2de0406f784..8502fb3265c 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -29,3 +29,5 @@ arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
>
> # machine.c
> cpu_post_load(uint32_t cpreg_vmstate_array_len, uint32_t cpreg_array_len) "cpreg_vmstate_array_len=%d cpreg_array_len=%d"
> +tolerate_cpreg_missing_in_incoming_stream(char *name) "%s is missing in incoming stream but this is explicitly tolerated"
> +tolerate_cpreg_only_in_incoming_stream(char *name) "%s is in incoming stream but not on destination but this is explicitly tolerated"
> -- 
> 2.53.0
>
>


