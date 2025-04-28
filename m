Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D6BC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9RaY-0005Qn-JN; Mon, 28 Apr 2025 12:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9RaV-0005Q3-Mk
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9RaN-0006OR-5k
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745858639;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT9szaBMS1wuwJ4Sk2MNJGIE71RFervjbyhX/iYXJP0=;
 b=cOoqh/sfu951+eUV41T8/4GlEM53Od0j1ugfoQhS50VWoZLk+KTFDc9GiOkhUuF4R/Vlef
 wFgSx1Oba58njbDdVtXRidGLja0eIcr7SQJ1HB7H4iOdZgqG5wKjSQvQo/9oxuATHYh/ND
 GSgL2qtfCtImu8QG6Jig9gHeUV+s7O4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-E39l7rcGPxSrUDKjOxMiuw-1; Mon, 28 Apr 2025 12:43:54 -0400
X-MC-Unique: E39l7rcGPxSrUDKjOxMiuw-1
X-Mimecast-MFC-AGG-ID: E39l7rcGPxSrUDKjOxMiuw_1745858633
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so26061345e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745858633; x=1746463433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hT9szaBMS1wuwJ4Sk2MNJGIE71RFervjbyhX/iYXJP0=;
 b=m82uqyZO1+m4kLMSwRxlL0/KZAHPxsjiSxOzoywnPbZkJBAedbB/kSx2l35HBtDD9K
 wCAnrfbiINUQdwkl92iQGe4aKe1nJZTpAJIWzCkkiL6RHWA94E1ydQVbauK/wc9E4VDq
 BUUlDaAf0iN22L0ZZ/SrdzdxWXq6oD3xuNINgeuTFPdpLmNjWPzFw0XToYcDdzwCScU5
 cutJI2o/33Hz+tEBmWNfzpjtcgbxztHEgcrjOT1jSGzmAHc/40u5OQl+82672pN4OlY5
 3ta0GvOEIFHKBx+IrLyjx/okFr7q/Hmy8L3ouI5CNwjQk+9XSAs8CREBvmKaYFeZwkFz
 TsJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDsoqAevLYqqd/A23M0PxOwJj0Tx+YlTJ5aciv6Ug5ej2fsxAsIJsP+DzISZ9Qk1x67vrZgay2EmYw@nongnu.org
X-Gm-Message-State: AOJu0YxGsBKnvwd37Hatlnik5vhKpinM/kaJlN5+cx9lUjqOwGQeNRLN
 YdnP1FXE9YBqdCBECi5YtAB4s/yKvblKzUtmOOb/SMqVrY69EhC6i+ggBbj2bHgiU1k4sUQtBHq
 F1J30SiyrRpVd94pglo69tGIthKOX00v3s9N6z6cVdgOV9Pv8McA3
X-Gm-Gg: ASbGncv+LCyJyJ+Y2plVGIngbvbAKEbo9DGiupz25/rVI1yBk3oNFouRPs0XMcT9bNE
 OO9AocZQJhVbCAftmP6UF7U6KeYzNNV433COk6A3itq7nTuYQp1CAUTKVo3yt8yo7arwCK/rAEQ
 idy/f5pRSr2UOMMaqP1RcBlg1DPIXn/eW53pWeGskCDVgzRuASyXFKWLSyhRIy3USBgnXm9hsCq
 tHMecOMvpzvD6TOZ7wirkXQsyrMfH0aF2Mmoaxt0D7Lc1JOAv/dm3MoJjUid4hbxzCmRkksM9Q7
 b+4imw4I98A4fgB4aY38f/ZgdhZmU5H4BRdrATrRIf0xktFMwOUVrStNdTA=
X-Received: by 2002:a05:600c:3d0b:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-441ac859010mr273635e9.14.1745858633345; 
 Mon, 28 Apr 2025 09:43:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLoqim8nFsSahRim40TfQnTSHnj1tPFhatyQmqpgUa6XY03VLvomjulc/lu48GhOOcB6i9mA==
X-Received: by 2002:a05:600c:3d0b:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-441ac859010mr273125e9.14.1745858632764; 
 Mon, 28 Apr 2025 09:43:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53108f2sm128676115e9.19.2025.04.28.09.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:43:52 -0700 (PDT)
Message-ID: <4cbaa46b-2114-49b3-8d59-e92a4967665b@redhat.com>
Date: Mon, 28 Apr 2025 18:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v5 00/13] arm: rework id register storage
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250409144304.912325-1-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250409144304.912325-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 4/9/25 4:42 PM, Cornelia Huck wrote:
> Just a quick respin to fix a missed conversion in hvf.c.
>
> Also available at
> https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v5

I reviewed it again - I can't send any R-b through since I am co-author
;-) - and I spotted few conversion mistakes (I am most probably the one
to blame here sorry)

Once those fixed, I think we should be good.

Eric
>
> <v4 cover letter>
> Next iteration of the id register patches; only small changes.
>
> Changed from v3:
> - added R-bs (thanks!)
> - added missing SPDX header
> - merged patch introducing accessors for kvm to the first user
> - skip over sysregs outside of the id register range when generating
>   register definitions again
>
> Also available at
> https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v4
>
> <v3 cover letter>
> Yet another update of the id register series, less changes this time
> around.
>
> Changed from v2:
> - changed generation of the various register defines via the "DEF"
>   magic suggested by Richard
> - some kvm-only code moved to kvm.c; some code potentially useful to
>   non-kvm code stayed out of there (the cpu model code will make use
>   of it, and that one should be extendable outside of kvm -- a
>   revised version of those patches is still in the works, but I'll be
>   off for a few days and rather wanted to get this one out first)
>
> Also available at
> https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v3
>
> <v2 cover letter>
>
> Changed from v1:
> - Noticed that we missed the hvf code. Converted, compiled, but not tested
>   as I'm lacking an environment for testing.
> - Hopefully incorporated most of the suggested changes -- if I missed
>   something, it was unintentional unless mentioned below.
>   - fixed repeated inclusion of definitions
>   - hopefully made macros more robust
>   - removed distinction between reading 32/64 values, which was mostly
>     adding churn for little value
>   - postponed generating property definitions to the cpu model patches,
>     where they are actually used
>   - juggled hunks and moved them to the right patches
>   - fixed some typos
> - rebased to a more recent code base
>
> NOT changed from v1:
> - definitions are still generated from the Linux sysregs file
>   - I still think updating the generated files on demand (so that we can
>     double check the result) is the right thing to do
>   - I'm open to changing the source of the definitions from the sysregs
>     file to the JSON definitions published by Arm; however, I first wanted
>     to get the code using it right -- we can switch out the code generating
>     the file to use a different source easily later on, and I'd also like
>     to steal parts of the script from Linux once integrated (which I think
>     hasn't happened yet?)
>
> <v1 cover letter>
>
> [Note: I've kept the cc list from the last round of cpu model patches;
> so if you're confused as to why you're cc:ed here, take it as a
> heads-up that a new cpu model series will come along soon]
>
> This patch series contains patches extracted from the larger cpu model
> series (RFC v2 last posted at
> https://lore.kernel.org/qemu-devel/20241206112213.88394-1-cohuck@redhat.com/)
> and aims at providing a base upon which we can continue with building
> support for cpu models, but which is hopefully already an improvement
> on its own.
>
> Main changes from the patches in that series include:
> - post-pone the changes to handle KVM writable ID registers for cpu models
>   (I have a series including that on top of this one)
> - change how we store the list of ID registers, and access them
>   basically, use an enum for indexing, and an enum doing encodings in a
>   pattern similar to cpregs
> - move some hunks to different patches
> - update the scripts to generate the register descriptions, and run
>   them against a recent Linux sysregs file
>
> What I've kept:
> - generating the register descriptions from the Linux sysregs file
>   I think that file is still our best bet to generate the descriptions
>   easily, and updating the definitions is a manual step that can be checked
>   for unintended changes
> - most of the hard work that Eric had been doing; all new bugs in there
>   are my own :)
>
> </v1 cover letter>
> </v2 cover letter>
> </v3 cover letter>
> </v4 cover letter>
>
> Cornelia Huck (1):
>   arm/cpu: switch to a generated cpu-sysregs.h.inc
>
> Eric Auger (12):
>   arm/cpu: Add sysreg definitions in cpu-sysregs.h
>   arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays
>   arm/cpu: Store aa64isar1/2 into the idregs array
>   arm/cpu: Store aa64pfr0/1 into the idregs array
>   arm/cpu: Store aa64mmfr0-3 into the idregs array
>   arm/cpu: Store aa64dfr0/1 into the idregs array
>   arm/cpu: Store aa64smfr0 into the idregs array
>   arm/cpu: Store id_isar0-7 into the idregs array
>   arm/cpu: Store id_pfr0/1/2 into the idregs array
>   arm/cpu: Store id_dfr0/1 into the idregs array
>   arm/cpu: Store id_mmfr0-5 into the idregs array
>   arm/cpu: Add sysreg generation scripts
>
>  hw/intc/armv7m_nvic.c                 |  27 +-
>  scripts/gen-cpu-sysregs-header.awk    |  35 ++
>  scripts/update-aarch64-sysreg-code.sh |  25 ++
>  target/arm/cpu-features.h             | 317 +++++++++---------
>  target/arm/cpu-sysregs.h              |  46 +++
>  target/arm/cpu-sysregs.h.inc          |  52 +++
>  target/arm/cpu.c                      | 111 +++----
>  target/arm/cpu.h                      |  80 +++--
>  target/arm/cpu64.c                    | 128 +++----
>  target/arm/helper.c                   |  68 ++--
>  target/arm/hvf/hvf.c                  |  39 ++-
>  target/arm/internals.h                |   6 +-
>  target/arm/kvm.c                      | 129 ++++----
>  target/arm/ptw.c                      |   6 +-
>  target/arm/tcg/cpu-v7m.c              | 174 +++++-----
>  target/arm/tcg/cpu32.c                | 320 +++++++++---------
>  target/arm/tcg/cpu64.c                | 460 +++++++++++++-------------
>  17 files changed, 1103 insertions(+), 920 deletions(-)
>  create mode 100755 scripts/gen-cpu-sysregs-header.awk
>  create mode 100755 scripts/update-aarch64-sysreg-code.sh
>  create mode 100644 target/arm/cpu-sysregs.h
>  create mode 100644 target/arm/cpu-sysregs.h.inc
>


