Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CF9C0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQYN-0001ZO-FW; Fri, 07 Feb 2025 10:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgQYI-0001Y7-Qa
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgQYF-0001Rm-6t
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738943149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDfq/b9NJB3SnEsKYqDfREsImxMuOj2V1wZz1GVd1jM=;
 b=V4Zn2Cb+vq5mLrbe12hZHdk/1wWKVTKuJ4O0Ih4KRVoNfm6ijOkc/lPp9ySbbb30HZ/1YQ
 t0CJ1mPmuayvxGaBShqH15pbhDb/SfdYJmNT1pzxwVj+RC2eWGMhiDQsUf7ZrMNR9ahGuQ
 RGNNhGKzghpPhO4f10tDgUNI9q6dFTA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-kbDbJwHMOdG_5HqY3Rugyw-1; Fri, 07 Feb 2025 10:45:48 -0500
X-MC-Unique: kbDbJwHMOdG_5HqY3Rugyw-1
X-Mimecast-MFC-AGG-ID: kbDbJwHMOdG_5HqY3Rugyw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dab928a84so904661f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943147; x=1739547947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDfq/b9NJB3SnEsKYqDfREsImxMuOj2V1wZz1GVd1jM=;
 b=fvu7qBCTym5STymzliMfVDXF53fknOAptddya3fF3VzO7VPTophydTlOfmE4091gtH
 YUUHrZ0H6dHp2sufpvHPyAC4MVxnhYF8E5RwuLkxs871gW036OqLk31iPxjKdF/L4Mq6
 6pTgqVLH1k3uOIJ/nFgLl06cvgA4+k0aUl0SKzs/qq0QZnlc3qOflAzbSLHD53rCn1OR
 GnsMtVyAaQ30nDvGWEg0KyAG/1tPXCJY5GqdxRQAXqjDMJ15j1aXHJOzRDO9DttCiYEo
 ZmqPmwI4ceUHAFAExSdam8Cx2lCbLcpz+ZzlsbzqQQpX7a4POg2JMLcCDoQ3SoTzGMA8
 YXDw==
X-Gm-Message-State: AOJu0Yy/yoMOIyo7xGIJpSwtK1VW7si2XsLqDEgj4BlNFuhI//j2OzBc
 4D7sEduwgA47lBoBZVQH/cAkvyyVsF7CH3JxVI/vdXaosk7KFuN10Q8S34/++1VnlLJzjmAJXcA
 RWB5rRpxiRfps0SCgqY0vq3lduWGNWDcQzOFciIfYFFV5Gug5SAZ1
X-Gm-Gg: ASbGncuCQVEZaMCU8/KUEcgrVa6Y0VNOFTEyqQX13b6xRkDKJkWBLzKadLrpSPaW+ms
 Oox5n8/dUWIJ1i9l2GbhBBYpQ6gA/CtF1NDqWTIrSu313sTGBHEHvnN9CqLDQXc45YxLDVMPi/t
 rZKtiLIZOqi4DgDvAr49T0mbSr837o5R4NIqsXU2WKqygn1sgUtW3X57iLqFjdNEat7yxLuUxxf
 ldbO90mB/IK8RNezxF8v+NO0eJcbpNgEd36mVl0ADQQuOfwHFTT7Qv/bCPlxnF6sEWs2PseZolw
 +68sChyyhsdPMqmaP8Tk2SUynQuSfNyR8HdVSVp7fyqTgH6V+npL
X-Received: by 2002:a5d:5f94:0:b0:38d:b9c5:7988 with SMTP id
 ffacd0b85a97d-38dc937324fmr2309354f8f.50.1738943147275; 
 Fri, 07 Feb 2025 07:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgSOlpazfMjNWp2Qc+p7N5nHYSVTYYn3A3MdIORDwNn8Y6nZFZLyNtakfYKleLqE/vWlMAxw==
X-Received: by 2002:a5d:5f94:0:b0:38d:b9c5:7988 with SMTP id
 ffacd0b85a97d-38dc937324fmr2309238f8f.50.1738943144359; 
 Fri, 07 Feb 2025 07:45:44 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbf6e4a4bsm4477509f8f.92.2025.02.07.07.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:45:43 -0800 (PST)
Date: Fri, 7 Feb 2025 16:45:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Yanan
 Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org, Zhao Liu
 <zhao1.liu@intel.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 0/9] accel: Only include qdev-realized vCPUs in
 global &cpus_queue
Message-ID: <20250207164540.0f9ac1d7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, 28 Jan 2025 15:21:43 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi,
>=20
> The goal of this series is to expose vCPUs in a stable state
> to the accelerators, in particular the QDev 'REALIZED' step.

I'll take some of your patches (with Richard's feedback fixed),
and respin series focusing mostly on realize part.
(and drop wire/unwire parts, reshuffling cpu code instead)

>=20
> To do so we split the QTAILQ_INSERT/REMOVE calls from
> cpu_list_add() / cpu_list_remove(), by moving them to the
> DeviceClass::[un]wire() handlers, guaranty to be called just
> before a vCPU is exposed to the guest, as "realized".
>=20
> First we have to modify how &first_cpu is used in TCG round
> robin implementation, and ensure we invalidate the TB jmpcache
> with &qemu_cpu_list locked.
>=20
> I'm really out of my comfort zone here, so posting as RFC. At
> least all test suite is passing...
>=20
> I expect these changes to allow CPUState::cpu_index clarifications
> and simplifications, but this will be addressed (and commented) in
> a separate series.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (9):
>   accel/tcg: Simplify use of &first_cpu in rr_cpu_thread_fn()
>   accel/tcg: Invalidate TB jump cache with global vCPU queue locked
>   cpus: Remove cpu from global queue after UNREALIZE completed
>   hw/qdev: Introduce DeviceClass::[un]wire() handlers
>   cpus: Add DeviceClass::[un]wire() stubs
>   cpus: Call hotplug handlers in DeviceWire()
>   cpus: Only expose REALIZED vCPUs to global &cpus_queue
>   accel/kvm: Assert vCPU is created when calling kvm_dirty_ring_reap*()
>   accel/kvm: Remove unreachable assertion in kvm_dirty_ring_reap*()
>=20
>  include/hw/qdev-core.h       |  7 +++++++
>  accel/kvm/kvm-all.c          |  9 ---------
>  accel/tcg/tb-maint.c         |  2 ++
>  accel/tcg/tcg-accel-ops-rr.c | 15 ++++++++-------
>  cpu-common.c                 |  2 --
>  cpu-target.c                 |  7 ++-----
>  hw/core/cpu-common.c         | 18 +++++++++++++++++-
>  hw/core/qdev.c               | 20 +++++++++++++++++++-
>  8 files changed, 55 insertions(+), 25 deletions(-)
>=20


