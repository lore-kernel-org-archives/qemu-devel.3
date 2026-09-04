Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F135FC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Omt-0001Gp-Qr; Fri, 04 Sep 2026 03:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2Omt-0001Gg-4w
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 03:56:39 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2Omr-0005LZ-H9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 03:56:38 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so547142a91.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788508596; x=1789113396; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hY6Ergdlpxyre9E9Lm5SEKbkPTMzytnQhnGeCLpki1M=;
 b=Gg+bwfu5uKce9z4bx0nl/yXdJhE8TNKEUlCMo3UmABkjACNWwfrw9aZK+zVgbdFFRX
 1jHkN97sQ/H5nilL+ELyKY1xSTCNOIaXX6EDHXKhXqvJEN9n7aSbrYYP+yvFpt7OxpNI
 T/me7GPXHgYQRHhksjLdh+dgX+OJAFoWWiHm4FF5cR9suGwcIXLkO2v/ohGNsX2D4fuu
 lmDrmJOO2uA0l5oVPuiyTJP/9UWh7cF3a8Im78s82Zsu8Agvt13P4OQ8jHEoVAA4thp6
 9vRpoxGPOGllbjLfzBrFhgfkjTPjogcsLC6qrSQ7BwB+3woWvoSRurQUEf725wcVLBMy
 75pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788508596; x=1789113396;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hY6Ergdlpxyre9E9Lm5SEKbkPTMzytnQhnGeCLpki1M=;
 b=W5WF8AzYkTHJLlDwrfaxvcodF4ZQ2LFpqhYbCP4BU6pfPM9F70dEh32NObxejLgfaD
 nPWHpl2GBMJwYGT+wYY0l4uE9QFi1ahyvBwnEfg2mNk7KeWFSfE9k+Gg4Zm3+RP6i/CS
 blOZM4bTUajIyNcUag8cX3TF+tDOF2OTWWzlcS2nevYDgxTRg71k8Q9JzDAVWuVeYrA9
 mAEw71MKmY9Df+UwF/TpI3nskL313NnT67n63jzpIFzupANj2KgcPqabgZod5TGcnvpA
 b9gsBe/ApEgnMWZVZBZtarBXUPVhM3b3XDfCyxQLMo0XQjeXdwuussU3EZ6CMMFf6w7L
 rXdw==
X-Gm-Message-State: AFuF++nc0SPZzKahOyENM8RqH6QU8EWAVRTrhOIwQZvJeI7S2A+Vy5Zj
 1JV91CNjMavbxj1OXt6gb7a1AoMpOPfAKQvSWsFU0rbW8t2GkF9Pzzuod+BhVN3/q6Y=
X-Gm-Gg: AYBFou39lZlqGK7SholhXlsAPUJAO61P0zuLLdnIM1sMEp3ZipoPcn2p8GTSuQbsIKa
 0WAZPuu9hGqNAGJaIgFPU/5F/uCElhxqLm7gs7qE2gTKFOo9J9O2fOFq5bqZe5l8b2VSK8xojcA
 DBeyqgxuURoo2Aaf9ULY08BEWTkv5viXvmom0uoohYjQ1/lak2nbxZ5ayh7k5VhZNJFI+r9d51U
 hHYyE9cWjga6LCufxrDKil4BEI0WkbkWAlmffzoNDqEf7ohnKFv44S11PUuCOldsIexd8uaeOBf
 AUpLjglLIZIFTejNqMtksyrHvM5jetcSVbTBQsMDTNtF8Y73/bAZYNfvEXFkPNspYt94PGmRAhD
 u9HxKDT40A9OoPAgWs+bHyoTnw7MfEiKhv0HW3or4ocC/Ixz2iKXejB2frrA2nQmDGyMqLnME/H
 9ZkVm2ukwdjnXXtKHMIpS2I/oe5lOPmr4G832SurFVE89aK+8wm1MMJoD5HrrE00TA1AnQQsVm6
 Pi5MQ1tLBUL6hwCCf0IO0+BQqBoMK8h5w==
X-Received: by 2002:a17:90b:5243:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-39b2614df1emr7538788a91.5.1788508595676; 
 Fri, 04 Sep 2026 00:56:35 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c397b1sm9357635a91.8.2026.09.04.00.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:56:35 -0700 (PDT)
Date: Fri, 4 Sep 2026 15:56:32 +0800
From: Max Chou <max.chou@sifive.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] tcg/riscv64: Validate AUIPC relocation range
Message-ID: <app5b9gztbby1e0s@sifive.com>
References: <20260903170405.3632015-1-max.chou@sifive.com>
 <20260903170405.3632015-2-max.chou@sifive.com>
 <8e3baf27-9e44-4481-b60a-06e33678d473@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e3baf27-9e44-4481-b60a-06e33678d473@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1030.google.com
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

On 2026-09-03 19:31, Philippe Mathieu-Daudé wrote:
> > +static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
> > +{
> > +    intptr_t hi, lo;
> > -    if (offset == hi + lo) {
> > +    if (split_auipc_offset(src_rw, target, &hi, &lo)) {
> >           src_rw[0] |= encode_uimm20(hi);
> >           src_rw[1] |= encode_imm12(lo);
> 
> I'm a bit confused by these encode_*imm() taking uint32_t arguments,
> otherwise your change LGTM:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


Hi Philippe,

Thanks for the feedback.
I’ll address that data type mismatch and send out a v2.

rnax

