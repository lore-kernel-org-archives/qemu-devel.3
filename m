Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3ACEE20AA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMsj-0004gY-Ix; Fri, 06 Feb 2026 09:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voMsT-0004eZ-Hm
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:32:09 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voMsR-0003Wa-Ny
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:32:09 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-790b7b3e594so24107587b3.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 06:32:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770388326; cv=none;
 d=google.com; s=arc-20240605;
 b=f3STA0blhlhk1aEptO6c6xtjVXP8Ggpo5+L1Ab1xyKiL2ER0tEY8ini7n2pwjVt/Sd
 bTXmp0PvI0YjNs/UDNN6PsjI3TQDVazqIHl9hyGJ1sFwrmRYMMzzL+vztDIBNFLqCmu6
 oGkK4xsrxedZewmDtNiJDHrWVIQntQ9UNVuHL5PjY/robuhEq01V7OUBVuMe1CnF1t0Q
 MpGi82ol68tH7MupC8t12RiEZK8/Snyb5VYemK/KXhmSZ/ekzHVSkbrDU47Md0qc6zOO
 4srZ0/ENMUzQuEIOHGzTE/AiBwqlp/xHvWhRLZkDnvYMES+TRMrFUD7fGqUbfaT7o8VN
 nK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3c4cqJf+Jqq89aF7aXU+qGYsMH4oDK0uvPrEZwt7xhQ=;
 fh=dYVx1wWizTvsS2S9UJJGOuWZsg4ThjGWihGlI6CuPg8=;
 b=PKg1Owp5zzmiNXfe68B2YWDaW8jMiw+c1VwrjXaohz//KCbQmUlO2NPr2XFDYCaSeH
 xJUjbAR3rmt83himK4PViSosKi1OlPPPScvjN4Vvu+eiGdWnCTkk47tlZY0TrcuZsbl3
 bQNTwlcLGLISwXXy9S6A+VDnbTH+Cn0Ldl6pKqwc6GQtzcAaRpMksYQZVctNWaiMejqI
 v2ZjMnO0YnvpzFyMwx5yZbQXKZUF0GMM5dajGUF0TMT/j0fIanT4b7v0nMTrE0SZU5st
 /aU5r4mVmxz4w54nlGv6SxV/W8RDj0Cn68BLodm7YCaB2A6OKas/NA4PJGuXpi0/94/H
 2blA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770388326; x=1770993126; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3c4cqJf+Jqq89aF7aXU+qGYsMH4oDK0uvPrEZwt7xhQ=;
 b=pjDVInh9977wuF+zuuKoNOe1XgH33ZiND53dPjycAK2HEbNDhJDhGFwBHxO8Qj1/6G
 soF96Zp/F9IGzAEhQGJIVG1SJCfX9h9a7FnUzVhiYLisTQEQDT1M9ZcfUzBrjcE9aRX+
 6OXOfP2FFUd8tDcXJaFBreukH4gZk4wmcNEdZ8jpwpk1NEg2nCowN09ynnggCLdmgKNL
 +YXwnF8BytCJuGVddO7Miw0CAf3Y26AxxZUROIuFXr7iXulX3Nxrx4Je3VYcXEtZBA9D
 gGtc4mb9JorHQjdQjgQcGc6krde7bdd7X251umMgTdIQu9e+N3FxY1mfTAsMdghY40Aw
 ThEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770388326; x=1770993126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3c4cqJf+Jqq89aF7aXU+qGYsMH4oDK0uvPrEZwt7xhQ=;
 b=SL9JMwK/Alt3cFSB0r2dZHQI/dKWl3TDWHtGxSuIlSNJ8ClYV90umta0uvqz06v5AT
 AoEtd6bZvbLg6m+uDb2/eNWPzmdWjjhnFrF1WIGL7FfVEiWlC0FxfA+4LBWnBWwGTn3X
 ESdtGTNzGqv+RhVvvqgibJKItwsWcohTdmQmqenGpICYKpS3e5MDseEmpqyJ4yBns2Gc
 xz7+rH4g+T1zgKeZc/bZ+EAEFU5I1WP31wCP9ukPh5jBwlfpr9NGr9GKCH8pQBMhQ6p0
 aKWZqL6P8p+fcjjCMBX0qgFIjqPNglFInE194qgeIPiwQcoUJP67KF6qjo+bHRS+NaIE
 owCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8TcK8/5XTnVs6jmdwTPFLFmI0k1UH8hn32Zj7pQfrIpwnGJFaB0VJGJdjh1iHqI13S0h2YlusslIQ@nongnu.org
X-Gm-Message-State: AOJu0YzVNLbWJFUQnaSA+fvaywlned5yr/zQ9Udun2RqSQ1DZmrTJ84w
 lmHdmMfCPdr0rmeRyEXH6uauVMDAFNSRjosmSYkhP+PjwNGcjOX8lYhM7wo/oSmBdwJlQx9Y6me
 XgYD8solTk6j95DP4w0tFiM1xIE/5hEKUpUMUSmvJ2w==
X-Gm-Gg: AZuq6aKxlTH9tTJbebDtKcLMwmQuzrMr6jMuQObcL4WscJmXajxPlMEVEVRvNTDTwSg
 Ju1rYkr4Fk0a9p5O4hZkD+fxNq0GTPGgF6YblDPvK1ZEAsXE9YxoE9POD8HX4gMgWuYNzxzIrRF
 qjBfEjUUwF7XQ2qjXxqR0SXsv/2Q84Dy2OdW7VGNIoZP+gPC6HExNoxXJsNCN/Qdl0elpDTJ+TL
 cAQNUb+hYSEbS1B99yM/9IoY553S4I9LCgSunEzkkVDBdPsoo/BvXGhhgqgN4o6gF2ARlx9Iorn
 lR+h/2MEUd5kK7s8TpjDx6K8DG40Q9JkZKtcHpODwpDYg/jNPNLuZog=
X-Received: by 2002:a05:690c:e3cd:b0:794:d0b5:eb1d with SMTP id
 00721157ae682-7952ab28c1bmr30396717b3.38.1770388325795; Fri, 06 Feb 2026
 06:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-3-eric.auger@redhat.com>
In-Reply-To: <20260126165445.3033335-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 14:31:43 +0000
X-Gm-Features: AZwV_Qid22u4ndtGlycMMLE5Xbum__hbxHsBRjfco78PYHHyOhqBVkyr1ArhgK0
Message-ID: <CAFEAcA8dVLEa9gJ6y=hP94ZZtcNQemRawpfyWo1kLusBdy25kw@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] target/arm/machine: Improve traces on register
 mismatch during migration
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, 
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 26 Jan 2026 at 16:55, Eric Auger <eric.auger@redhat.com> wrote:
>
> Currently when the number of KVM registers exposed by the source is
> larger than the one exposed on the destination, the migration fails
> with: "failed to load cpu:cpreg_vmstate_array_len"
>
> This gives no information about which registers are causing the trouble.
>
> This patch reworks the target/arm/machine code so that it becomes
> able to handle an input stream with a larger set of registers than
> the destination and print useful information about which registers
> are causing the trouble. The migration outcome is unchanged:
> - unexpected registers still will fail the migration
> - missing ones are printed but will not fail the migration, as done today.

Improving the diagnostics here is a great idea.

> The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
> registers compared to what exists on the target.
>
> If there are more registers we will still hit the previous
> "load cpu:cpreg_vmstate_array_len" error.
>
> At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
> and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are printed.
>
> Example:
>
> qemu-system-aarch64: kvm_arm_cpu_post_load Missing register in input stream: 0 0x6030000000160003 fw feat reg 3
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 0 0x603000000013c103 op0:3 op1:0 crn:2 crm:0 op2:3
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 1 0x603000000013c512 op0:3 op1:0 crn:10 crm:2 op2:2
> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 2 0x603000000013c513 op0:3 op1:0 crn:10 crm:2 op2:3
> qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
> qemu-system-aarch64: load of migration failed: Operation not permitted
>
> With TCG there is no user friendly formatting of the faulting
> register indexes as with KVM. However the 2 added trace points
> help to identify the culprit indexes.

Could we move kvm_print_register_name() out of kvm.c and into
somewhere that the TCG code can use it? (I did think when I
was reviewing the patch that added that that we might want it
for TCG too eventually.)

> @@ -990,7 +991,13 @@ static int cpu_pre_load(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
>      CPUARMState *env = &cpu->env;
> +    int arraylen = cpu->cpreg_vmstate_array_len + MAX_CPREG_VMSTATE_ANOMALIES;
>
> +    cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
> +                                         arraylen);
> +    cpu->cpreg_vmstate_values = g_renew(uint64_t, cpu->cpreg_vmstate_values,
> +                                        arraylen);
> +    cpu->cpreg_vmstate_array_len = arraylen;

It seems a bit odd to extend these on cpu_pre_load, especially
since it means we'll do so on every cpu_pre_load call, which I
think can happen if you try an inbound migration, it fails, and
then you retry it.

I think it ought to be possible to both avoid this reallocation
and the problem noted in the commit message where more than 10
extra registers results in an unhelpful message, if we can
convert the vmstate fields from VMSTATE_VARRAY_INT32 to
VMSTATE_VARRAY_INT32_ALLOC. (That latter doesn't exist yet but
will be the INT32 equivalent of VMSTATE_VARRAY_UINT32_ALLOC.)

If I have read the code correctly, these should work by
having the inbound migration code allocate the buffer for the
array data instead of expecting it to be pre-allocated -- that
means our post_load function can look at all the data it got
without imposing a length limitation.

I think (but we should check :-)) that the data in the migration
stream is the same in both cases, so this will not be a compat break.

(Some existing code will need adjustment to avoid a memory leak,
e.g. g_free any existing array in pre_load.)

thanks
-- PMM

