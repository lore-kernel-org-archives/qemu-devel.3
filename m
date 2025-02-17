Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CF8C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 17:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk59I-0002y6-Nc; Mon, 17 Feb 2025 12:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk59H-0002xX-28
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk59E-00029c-LQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739814190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kbj9ZpABHxzJoglYG0rKlqkNfqUb/eFtc0o/zMlWoRY=;
 b=hgk4i0UQ9zJBlarh7PiEbTuIaX4AjXrMOp64OtcN3COPNiKVWMCDQGmD/CJrpQGaYF5tfS
 CdFiG2Iy29dkVZUbpU3mMF7e6/cpWO6p/K7treRcvf8KG9IPDeILHcRXbVAhCydtRrcHk6
 igx+H/zaDKKA8wZLLQewQ9GqMM95+G4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Fwktr7nkMTis7imihixaYQ-1; Mon, 17 Feb 2025 12:43:09 -0500
X-MC-Unique: Fwktr7nkMTis7imihixaYQ-1
X-Mimecast-MFC-AGG-ID: Fwktr7nkMTis7imihixaYQ_1739814188
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38ddf4fa345so3286762f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 09:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739814188; x=1740418988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kbj9ZpABHxzJoglYG0rKlqkNfqUb/eFtc0o/zMlWoRY=;
 b=OpyV6SF7jysj/DfZMdCMuC8k8OKsmYSJZEktlz2XVn/RHqLXN5KvAf0OBnKR5gGYsv
 zwCDe33zt73MCM+lXw0v24PEWnN/fADBkSMCbTvN18iWaSLcV3HOflqmyfevw/MVrdgd
 pQ/8GGNrBeLMqxCMLGMKF2ltg9qP33dmgdJ0AVA9BborUTjUYfo/3eDpQ8EcLRoF7H2h
 pK+Ej4waDJTh4lUE7ukqjBj2UtHGVsrjGFvHgWuIoOVwAOkKhIci/LQYVPJqrLVrLPt3
 i/cq0ATiJdkBER67Anyrrs8x8JcAqn0eBA/lbsV5B559sYftB0baO9w47WzULxw0wJtw
 mZqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPCUzATJQdGK+Y0ZJjCwnQ8WNT+faN0b19K77EU4RykJ29qZqn+CSU4wVhUCOEWU+IpIPonr2bSA/x@nongnu.org
X-Gm-Message-State: AOJu0YxC7DXIbmjsZ96fkVewfUhKGUMpdQ/qYdlhzHNWb+jZgeeJFc3n
 uT3s1lBJxbkD2whbc06qrNf4XdgKIeLT+zYmILcadd2dqE5F191HgBXAorNIVj6SxYOtqy6q8Zo
 IKidlDgXKDNV4KxSHhHXIz/rvByhh9daCa6Jg53iq3S10+4NrhbFy
X-Gm-Gg: ASbGncvyvwzNxB3IB4kTzkm9UnK4qSM8HKr1z3ZCQ/rW+E1sGeRqa6tJYFcy/qoO9kA
 EUf8DtO1N+8+Qfh8tW8bMJycx2Xmxny6I7InikXduEJHgch4zvDzmQtm/MOewb8Ft4UHE29b4kH
 U+csqsfh+Yw7CBb5Un5fB/4Z7BG5hoXpW2UDKBsdVTbTDVteit7Yfw9heYbYmbn49sN8VfUI+D2
 q+OI7P5lgKCA6Hz2L8tqMWs2bqoZm9194S3HGggnqKZMHpbAI1zKATjXkm8tcyvlvLIZFHZsPG2
 MDyoOri2p+HGDTk0YuDJzsbldz/saHIpCIICgOvwMs3wNjYeF0M3
X-Received: by 2002:a5d:44d1:0:b0:38f:2176:45a0 with SMTP id
 ffacd0b85a97d-38f33f511edmr8659842f8f.33.1739814187844; 
 Mon, 17 Feb 2025 09:43:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZOz8M7HvrvJ9GfUM1EUfwUeeVYkqcULc0SmmwFuZWcjIYYQgIiHcXccGO5318pB988Uxe5Q==
X-Received: by 2002:a5d:44d1:0:b0:38f:2176:45a0 with SMTP id
 ffacd0b85a97d-38f33f511edmr8659813f8f.33.1739814187445; 
 Mon, 17 Feb 2025 09:43:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5b40sm12967828f8f.68.2025.02.17.09.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 09:43:06 -0800 (PST)
Message-ID: <ff481ffd-545f-4d0c-b53a-3cf9e0f8f388@redhat.com>
Date: Mon, 17 Feb 2025 18:43:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
Content-Language: en-US
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, sebott@redhat.com, maz@kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-3-kchamart@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250217163732.3718617-3-kchamart@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Kashyap,


On 2/17/25 5:37 PM, Kashyap Chamarthy wrote:
> PAuth (Pointer Authentication), a security feature in software, is
> relevant for both KVM and QEMU.  Relect this fact into the docs:
>
>   - For KVM, `pauth` is a binary, "on" vs "off" option.  The host CPU
>     will choose the cryptographic algorithm.
>
>   - For TCG, however, along with `pauth`, a couple of properties can be
>     controlled -- they're are related to cryptographic algorithm choice.
>
> Thanks to Peter Maydell and Marc Zyngier for explaining more about PAuth
> on IRC (#qemu, OFTC).
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> v2: address Marc Zyngier's comments:
>     https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg03451.html
> ---
>  docs/system/arm/cpu-features.rst | 46 +++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index a596316384..94d260b573 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -204,11 +204,49 @@ the list of KVM vCPU features and their descriptions.
>    the guest scheduler behavior and/or be exposed to the guest
>    userspace.
>  
> -TCG vCPU Features
> -=================
> +"PAuth" (Pointer Authentication)
> +================================
> +
> +PAuth (Pointer Authentication) is a security feature in software that
> +was introduced in Armv8.3-A.  It aims to protect against ROP
> +(return-oriented programming) attacks.
> +
> +KVM
> +---
> +
> +``pauth``
> +
> +  Enable or disable ``FEAT_Pauth``.  No other properties can be
> +  controlled.
> +
> +  The host CPU will define the PAC (pointer authentication
> +  code) cryptographic algorithm.
> +
> +  There are different "levels" of PAuth support.  The host CPU
> +  definition will define that level (e.g. PAuth, EPAC, PAuth2, FPAC,
> +  FPACCOMBINE, etc).  Refer to the Arm architecture extension documents
> +  for details about the description of these features.
> +
> +Live migration and PAuth
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The level of PAuth support depends on which Arm architecture a given CPU
> +supports (e.g. Armv8.3 vs. Armv8.6).  This gradation in PAuth support
> +has implications for live migration.  For example, to be able to
> +live-migrate from host-A (with Armv8.3) to host-B (with Arm v8.6):
> +
> +  - the source and destination hosts must "agree" on (a) the PAC
> +    signature algorithm, and (b) all the sub-features of PAuth; or
> +
> +  - the alternative (and less desirable) option is to turn off PAuth
> +    off on both source and destination — this is generally not
> +    recommended, as PAuth is a security feature.
> +
> +TCG
> +---
>  
> -TCG vCPU features are CPU features that are specific to TCG.
> -Below is the list of TCG vCPU features and their descriptions.

The resulting header layout seems weird to me.
Initially we had at top level (assuming ===):

KVM vCPU Features
TCG vCPU Features
SVE CPU Properties
SME CPU Properties
RME CPU Properties

and now

TCG vCPU Features has somehow disappeared giving the impression that
there are none.

SME and RME and TCG only if am not wrong while PAUTH and SVE are both
KVM and TCG

Maybe we shall
- rename KVM vCPU Features -> KVM only vCPU Features
- Add a TCG only vCPU features including both SME and RME ones
- introduce a top level KVM and TCG vCPU features with below:
PAUTH, SVE, detailing potential different semantic for both KVM and TCG mode

Also while we are at it, we may use vCPU everywhere instead of CPU (SVE
CPU Properties) and just skip CPU if it lays within the KVM and TCG vCPU
Features

Thanks

Eric




> +For TCG, along with ``pauth``, it is possible to control a few other
> +properties of PAuth:
>  
>  ``pauth``
>    Enable or disable ``FEAT_Pauth`` entirely.


