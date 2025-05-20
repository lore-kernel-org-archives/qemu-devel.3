Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8AAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHO99-0005CG-5x; Tue, 20 May 2025 10:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHO95-0005BM-A9
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHO92-0005zg-IB
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747752039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olzendEO1KVkWoJH7CUvhbzVaHfoPsboH03R7MrNBoE=;
 b=LWsXIK0UX/Y36s621FJbzM2YD+/1aYdyY0ElpA9CGLIDrg3jvmyw8B7MVHh+BlItEEin+X
 BfsQmvCzICgRXWmar+C7abZ8IeuJFOmKFggdrxDkL6ruHtn0Ho7l87J6Ufr4R2jTtZ9lCA
 NIpq6g1CjS8OLEzO/chW/h+g007SpfM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-SC1zdslYMiqouVRug1S0Ww-1; Tue, 20 May 2025 10:40:37 -0400
X-MC-Unique: SC1zdslYMiqouVRug1S0Ww-1
X-Mimecast-MFC-AGG-ID: SC1zdslYMiqouVRug1S0Ww_1747752036
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a362dcc86fso1625499f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747752036; x=1748356836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olzendEO1KVkWoJH7CUvhbzVaHfoPsboH03R7MrNBoE=;
 b=KELIaJLXtm8kSMUox2PiAVXEOdr4pRLM0Jhrn79dpxhUXo0uoMjULR8WbPmE81zNv8
 YFdFHp6YM29JIWNo6mjOQy1rwr7M5nexA0FQHT40pnjTbjTAJwkVqwpVAD+/cGsuIR5O
 bS6yHHz4gXRV7xVFe5gpl8IM1z2sLYfKlQ2OUt71dN91UMJhtHZOY4WGJdwatwiBuFXl
 nxU2ep9IdxgM7VF6dnybk6w0DC5O9/HO2LYxGWi8l3jcsk1Ln4UTJOEAsI57hgsBiQF2
 4Tc8SigNirrAAxroDzhxfS5yIjtT9/89NW+HPa1iHrUCVOU5I6GPVY268fhPwk3Gp8vm
 onEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8gntA3KKeQFgrJv49V72JORUcRTDV/Fq2L5V9LvbxJ78LARI4J1hf5QITeKeJuxBt7dsUQWtxAMke@nongnu.org
X-Gm-Message-State: AOJu0YxdL2t3WD0pGdIAWOHQUKoYhNy3y6g4c9F6Lefxls3JXBqn1xmN
 GYH66tgGytn9njvZCiIyrxdqtoR5pTGkhzOozndTBSKghvB3IkhA9i4gKfQNag9Rbd90/EGENtf
 8Qv2ImmlBLnAFyvqLucziB8VHXpmiYdZddE6con9fdYQ+P1FD67BhYK1+2gq7xMLr2ayrwG09iK
 mYi0zlHD1QwNklarT/IYquMK+5Ps1d6+Q=
X-Gm-Gg: ASbGncvmIXL+DLw2hylAbnyURNcdENfkylRGzm+WzOR/tYuuja+vL+sJmsbPndo68XW
 xfZ9023ipcqcBoWYhuIu2mvdQyIBRPolyhMfp15u7SrxYXN6CSYnBjaO+SspT5Xxbcgk=
X-Received: by 2002:a05:6000:2903:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3a36e62db92mr8106049f8f.55.1747752036510; 
 Tue, 20 May 2025 07:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrkn8HHCOglcv/wyO4kl0v0OKRkMVQ3N70QJQhen+oVYudjXrCMkQ7kjcpx/qXRlPotT++4PfMTA+Xmx0DiQk=
X-Received: by 2002:a05:6000:2903:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3a36e62db92mr8106023f8f.55.1747752036139; Tue, 20 May 2025
 07:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250516122319.4100121-1-alexghiti@rivosinc.com>
 <87y0usiz22.fsf@all.your.base.are.belong.to.us>
 <51356014-b645-4e86-b338-0d097bf80260@redhat.com>
 <1e170923-9bb3-4327-a6ff-75c53bb2830f@ventanamicro.com>
In-Reply-To: <1e170923-9bb3-4327-a6ff-75c53bb2830f@ventanamicro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 May 2025 16:40:24 +0200
X-Gm-Features: AX0GCFsZmhMan_ntxExw6BkawFET-7UyCaIwPot1bxeIn0YAX5GjinuRCryd8QU
Message-ID: <CABgObfZR8NgEiFm9xuehhm4JU7y2W5HNbmdbQ5VOSGRifSdExw@mail.gmail.com>
Subject: Re: [PATCH RFC] target: riscv: Fix satp mode initialization based on
 profile
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 1:33=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
> > In general a lot (if not all) of the profile code should be moved out
> > of tcg-cpu.c and into riscv_cpu_class_base_init().  I didn't do that
> > because I didn't want to balloon an already-large series, but it's a
> > pretty obvious extension of the RISCVCPUDef concept to include all
> > profile features.
>
> Note that KVM RISC-V does not have the same profile support as TCG - I'm =
not
> sure if KVM RISC-V has RVA22 support, let alone RVA23. If we move the pro=
file
> logic to cpu.c we need to be careful with TCG assumptions affecting KVM C=
PUs.

Yes, but then that's even more of a reason to move code to cpu.c. It
means that "-cpu rva22s64 --enable-kvm" will print the appropriate
warning or errors.

Paolo


