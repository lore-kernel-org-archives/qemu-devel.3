Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC14C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI6w-0003HH-Qc; Thu, 20 Mar 2025 11:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tvI6i-00034I-Pj
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tvI6a-0007iN-S0
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742485606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HslmlnQwOo6JvynSQuem06I4JILJtTZsP+BQG1VIez0=;
 b=EC6/M2KXACynkFhOT5s34h56/8EYUSikAs/LCV5amxpmFRN0C9Date+rEIbj+3a02SieXB
 zY4QfwLlPapQ1d7fHYXWixyjhb5VoWynqvs1cJHHJ7f7LvtZYaGFLlx+yjufYOovhTIKti
 IGTZfzDAOiA7EiuwU69nzc3eGKcCFr8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-0sLO84QlMWaDihrdVfKvXQ-1; Thu, 20 Mar 2025 11:46:42 -0400
X-MC-Unique: 0sLO84QlMWaDihrdVfKvXQ-1
X-Mimecast-MFC-AGG-ID: 0sLO84QlMWaDihrdVfKvXQ_1742485601
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so6110135e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485601; x=1743090401;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HslmlnQwOo6JvynSQuem06I4JILJtTZsP+BQG1VIez0=;
 b=pa1INIKi1faI9n8tOQ18oAXpmJ++HpmjP32PaxBQ1W+uh0lcOGyMrC56Zs0XT8JADM
 xwlsJcgFGPoOAtLnsQG04pJan7nFDBNpYJy2ltPeaDZpic231Qbg8jAf3rtN5QE5qgam
 D/qPRg9W8IU3kkHZqRdd1LSo7Ensw8ZveZ8WU7sIP5fCUdh/5bERRnegM7TFpd4BK132
 1nPQIzMjipbEdjpjTx+wR4C+lhgLyx6vd4WHW70bpAfBIdiHDWeJL0JB8px6kcVf12le
 bye1MyMfWoFvphEtjUm7Wz0X905zINjCxzBLuSGzxSzv6IDLDCFwxKEh77UFMdrZlMRc
 WRFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjebGa9kWuPs91G+V9SwdQHoJKhD2MKhuEb8SS4hIwHglNCRWitLh+VqQ2RIjvODCScZNYy4+wBkEa@nongnu.org
X-Gm-Message-State: AOJu0YwyThHidrB65fg3RA/wWFBnwWmahFcRa/MoVofQ53/ek5JnKc1I
 3BntsiAwysq76UigVQvaeYdn9wI08GwpT9Etln13QRH8cx0YkswT8sX8GlwB6eA+e2Vp6HXX3V0
 t9NIxZkP8AvGrK6dcdPmV3lr2F5LyPI47ndEn9TYM+TWotqQqI3eY
X-Gm-Gg: ASbGncu//3pQ1hwf9A6ytslFnMMg8tN7vrD6sACwJsQ/bPwwTLliv8zGsvaDhE3FfC3
 s0bu2uyef1vKhnYbUdTNYqnx6Mj9paH/XcduD2fbVipEBYR3WCclq+GvvXFUjlAB0Zx8Teov7Q4
 4kfnQgo1PmYRamHcezgl1RUM0Ge0GGh/cIBbCnMHf+8oOKuO2+Ey7G1RurkKGbX1prsYfajFjzg
 jkrZhpNzEOm8I2+OXSn7lUQQ8z+n8NT9MsXh8n+ZZYhTTpHwyJYjWKWgndwE1Y04R8IczUrH8Pf
 BK3Foi5XxXNUzjY/8XzvjKGJ5vQBHRLqq6NG5e74fO6aC6L206slYNC5eqissAAt
X-Received: by 2002:a5d:59a2:0:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-3997f8fc43dmr8312f8f.15.1742485600666; 
 Thu, 20 Mar 2025 08:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyD4EROmupcYNNL7YZI2NHMAKFdzHsbAxlqkXUrS/wvbgf5i9Cb+Ap3R4Xgsi1yDbHIZ7g3Q==
X-Received: by 2002:a5d:59a2:0:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-3997f8fc43dmr8278f8f.15.1742485600138; 
 Thu, 20 Mar 2025 08:46:40 -0700 (PDT)
Received: from rh (p200300f6af11ec00f9928575aec32536.dip0.t-ipconnect.de.
 [2003:f6:af11:ec00:f992:8575:aec3:2536])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c4f9d59dsm24220135f8f.0.2025.03.20.08.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 08:46:39 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:46:38 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, shameerali.kolothum.thodi@huawei.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, agraf@csgraf.de, shahuang@redhat.com, 
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 00/14] arm: rework id register storage
In-Reply-To: <20250311162824.199721-1-cohuck@redhat.com>
Message-ID: <acb05338-1256-aefd-0283-9bf801256d82@redhat.com>
References: <20250311162824.199721-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 11 Mar 2025, Cornelia Huck wrote:
> Yet another update of the id register series, less changes this time
> around.
>
> Changed from v2:
> - changed generation of the various register defines via the "DEF"
>  magic suggested by Richard
> - some kvm-only code moved to kvm.c; some code potentially useful to
>  non-kvm code stayed out of there (the cpu model code will make use
>  of it, and that one should be extendable outside of kvm -- a
>  revised version of those patches is still in the works, but I'll be
>  off for a few days and rather wanted to get this one out first)
>
> Also available at
> https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v3
>
> <v2 cover letter>
>
> Changed from v1:
> - Noticed that we missed the hvf code. Converted, compiled, but not tested
>  as I'm lacking an environment for testing.
> - Hopefully incorporated most of the suggested changes -- if I missed
>  something, it was unintentional unless mentioned below.
>  - fixed repeated inclusion of definitions
>  - hopefully made macros more robust
>  - removed distinction between reading 32/64 values, which was mostly
>    adding churn for little value
>  - postponed generating property definitions to the cpu model patches,
>    where they are actually used
>  - juggled hunks and moved them to the right patches
>  - fixed some typos
> - rebased to a more recent code base
>
> NOT changed from v1:
> - definitions are still generated from the Linux sysregs file
>  - I still think updating the generated files on demand (so that we can
>    double check the result) is the right thing to do
>  - I'm open to changing the source of the definitions from the sysregs
>    file to the JSON definitions published by Arm; however, I first wanted
>    to get the code using it right -- we can switch out the code generating
>    the file to use a different source easily later on, and I'd also like
>    to steal parts of the script from Linux once integrated (which I think
>    hasn't happened yet?)
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
>  (I have a series including that on top of this one)
> - change how we store the list of ID registers, and access them
>  basically, use an enum for indexing, and an enum doing encodings in a
>  pattern similar to cpregs
> - move some hunks to different patches
> - update the scripts to generate the register descriptions, and run
>  them against a recent Linux sysregs file
>
> What I've kept:
> - generating the register descriptions from the Linux sysregs file
>  I think that file is still our best bet to generate the descriptions
>  easily, and updating the definitions is a manual step that can be checked
>  for unintended changes
> - most of the hard work that Eric had been doing; all new bugs in there
>  are my own :)
>
> </v1 cover letter>
> </v2 cover letter>
>
> Cornelia Huck (2):
>  arm/kvm: add accessors for storing host features into idregs
>  arm/cpu: switch to a generated cpu-sysregs.h.inc
>
> Eric Auger (12):
>  arm/cpu: Add sysreg definitions in cpu-sysregs.h
>  arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays
>  arm/cpu: Store aa64isar1/2 into the idregs array
>  arm/cpu: Store aa64pfr0/1 into the idregs array
>  arm/cpu: Store aa64mmfr0-3 into the idregs array
>  arm/cpu: Store aa64dfr0/1 into the idregs array
>  arm/cpu: Store aa64smfr0 into the idregs array
>  arm/cpu: Store id_isar0-7 into the idregs array
>  arm/cpu: Store id_pfr0/1/2 into the idregs array
>  arm/cpu: Store id_dfr0/1 into the idregs array
>  arm/cpu: Store id_mmfr0-5 into the idregs array
>  arm/cpu: Add sysreg generation scripts
>
> hw/intc/armv7m_nvic.c                 |  27 +-
> scripts/gen-cpu-sysregs-header.awk    |  39 +++
> scripts/update-aarch64-sysreg-code.sh |  25 ++
> target/arm/cpu-features.h             | 317 +++++++++---------
> target/arm/cpu-sysregs.h              |  41 +++
> target/arm/cpu-sysregs.h.inc          | 170 ++++++++++
> target/arm/cpu.c                      | 111 +++----
> target/arm/cpu.h                      |  80 +++--
> target/arm/cpu64.c                    | 128 +++----
> target/arm/helper.c                   |  68 ++--
> target/arm/hvf/hvf.c                  |  36 +-
> target/arm/internals.h                |   6 +-
> target/arm/kvm.c                      | 129 ++++----
> target/arm/ptw.c                      |   6 +-
> target/arm/tcg/cpu-v7m.c              | 174 +++++-----
> target/arm/tcg/cpu32.c                | 320 +++++++++---------
> target/arm/tcg/cpu64.c                | 460 +++++++++++++-------------
> 17 files changed, 1218 insertions(+), 919 deletions(-)
> create mode 100755 scripts/gen-cpu-sysregs-header.awk
> create mode 100755 scripts/update-aarch64-sysreg-code.sh
> create mode 100644 target/arm/cpu-sysregs.h
> create mode 100644 target/arm/cpu-sysregs.h.inc
>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


