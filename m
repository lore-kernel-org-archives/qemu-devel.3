Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CD3CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMoNY-0003R1-6m; Tue, 12 May 2026 10:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wMoNS-0003PK-I2
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wMoNP-0000Do-5U
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778597180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sz1D8FB0DY7piXNhjmP858LGUGVUSa94FPd7NONQZg=;
 b=CAJaxq0Pkyx+t2X1N3kGMvXfqh84wMTirNij+gjExbM6d8WrTp7y0NssxrFA5Sgu5mVcZi
 lPQR7avKTjQaDDM3zpDO3FjM7PnWuWMY2DPIYMkdXsaqZ3ktUg+J3ri1oSn0KDEN4gPhLV
 0K2nMwtBVuW+q1xNh8nX7DOlOS3p0eA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-FPq5QuNHO8-Fz9-SSsIylg-1; Tue, 12 May 2026 10:46:17 -0400
X-MC-Unique: FPq5QuNHO8-Fz9-SSsIylg-1
X-Mimecast-MFC-AGG-ID: FPq5QuNHO8-Fz9-SSsIylg_1778597176
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f6b984b3aso2940866b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778597176; x=1779201976; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sz1D8FB0DY7piXNhjmP858LGUGVUSa94FPd7NONQZg=;
 b=iERaYv7yjZF7uBpQ/QZYnGcetm8LEb76WP1kqi3ZgsWZ57DYCAfqhRR8h4OGFkP/yC
 m1WKNBH9vKhC00ICWs08DqnkAlJhYaBGsNaiijucCEB+mGPDjCxztEx/zeqE8nZPyASh
 0CneNP0RLuBvpQfFBM3XyiHwSO3GZouXJqrPalf7RGd/c01pCBL/VT/aEIa5+scZ6NhI
 qQYwDpOIoLp83PHy5gKB4C1NsMzzNRaWv+IXwsMy2M4ZFfzegvIQJA1I3HZFZCR6ERLi
 xehkzPuAEJiyJOM3+aO8wG94sBGOUFRGoUOhLHdHPegmgcOm8heFZdECEvxcWMagc/vz
 i9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778597176; x=1779201976;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+sz1D8FB0DY7piXNhjmP858LGUGVUSa94FPd7NONQZg=;
 b=hNKtWBAhkQ3XA6wVJrqgMhqIImhaFQ4ebxOD/D24goEq5gJTQ9WKrHwrwWxR8h/yG8
 tCb5fnRdbPk46zEDxsQtme8bAnN6WVd+kcuAJks7kO7vt5wP/2XVKl5N1ejxy2Z+GIRE
 oO99ziGYLiiXlR0DfHz1/DPYeKrP6AcPRF/se/VRnse3kk9f1mlKkShFmb++Zesm1WtQ
 QR0pwLgxwZj1UFkV9qFkNh17rSSVniSKUStbWg2Fh0YFMoMtQIEC0r3QREWJOuTi+vNd
 uneZ1PtiieAri+bOJmOgbGSQLDe19omeAZZQ15PFYErJxrkBtLhPkj7k7bFw4Pe/VhG9
 qNcA==
X-Gm-Message-State: AOJu0YyG0CxXbW8ES7uMj8cIagkoIGx7Qda7D7iib882V8fh6bDy8EZ7
 x9j8xJ0n5zWZRcTw2ZM66wcYlXY0TQNjqEIqa58kjGTbGJZIQXspNa+BAfCUQoxNvOEUhw4BBNF
 PAFOYpFm7oPnf3F4VV/Y2hnZ5xSWHzsml8iYXYQan+Kp7zAfJpbB4/X0M
X-Gm-Gg: Acq92OGMkFSFSDbl4tDu7YtoEvml4Pk9dhPyTtNuSO62Wn9PnlKFJPrS+RZKkI3/qz3
 NOerFX5XqI+/rke3daTE5LlmK2inLR+qZT212h5ntxQfCwv/GqI22OvrdikM7jaKL6R14EBI83K
 0+3FZemwdCsaRVJwKNuNf+bA0G6xx5u8zgMdw+42txMac2JHF2uxj2sYiJZX0JMrSb9IlktLfG3
 XLG6HZ1XduczxTxcEaWtDdIRzTndpoJiVzYS34iMurvpbAMRRFKHYloEMAhLJomGahPoHlila6b
 Wp/YbVYlaom9kHY0w7my6F1m72X3YHp6SIHcIRxbDhoROoRNKTE5Kojl/CDhKegmz50lqMlu0z9
 aOVyZ6UkHGzc5bN4qh+QKET1U6GT2JZZSzf3NYdQ5SzHLfMYcD4fCdpTdK8IASXTthDKVrDp5c4
 A=
X-Received: by 2002:a05:6a00:2e83:b0:83b:b0c2:17ea with SMTP id
 d2e1a72fcca58-83eebd6e52cmr3692392b3a.37.1778597176280; 
 Tue, 12 May 2026 07:46:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e83:b0:83b:b0c2:17ea with SMTP id
 d2e1a72fcca58-83eebd6e52cmr3692350b3a.37.1778597175763; 
 Tue, 12 May 2026 07:46:15 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8396563f03bsm24450070b3a.9.2026.05.12.07.46.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 May 2026 07:46:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 00/21] Introduce ACPI watchdog for Q35 and arm/virt
 boards
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260512153057.1a353c3e@imammedo>
Date: Tue, 12 May 2026 20:15:59 +0530
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E96C22B-D035-4CA8-8127-96D8A8E5E4AA@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260428161215.49cc1c0f@imammedo> <20260512153057.1a353c3e@imammedo>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 12 May 2026, at 7:00=E2=80=AFPM, Igor Mammedov =
<imammedo@redhat.com> wrote:
>=20
> On Tue, 28 Apr 2026 16:12:15 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
>> On Tue,  3 Mar 2026 10:25:11 +0100
>> Igor Mammedov <imammedo@redhat.com> wrote:
>>=20
>>> Changelog:
>>>  v2:
>>>     * ditch generic '-machine acpi-watchdog' option in favor of
>>>       board specific variants:
>>>           x86/q35:  -machine wdat=3D{on|off}
>>>           arm/virt: -device sbsa_gwdt,wdat=3D{on|off}
>>>     * arm/virt: add FDT and GTDT ACPI entries for GWDT when it's =
present
>>>       and hide GDTD one when WDAT is enabled.
>>>     * arm/virt: add test case for GTDT=20
>>>     * [18-21] optional GWDT cleanup/fixes in handling WCV register =
update,
>>>       make QEMU behave according to spec (at least the way I read it =
and
>>>       it appears MS also read it that way). It fixes Windows 11 =
reboots when
>>>       GWDT is present (without WDAT). With that fixed it's up to MS =
to fix
>>>       their driver to set sane timeout as with the current one =
wdatchdog
>>>       will never trigger. =20
>>=20
>> given merge window should be open by now,
>> gentle ping
>=20
> 2 weeks later,
> yet another ping

I have this in my queue for review.



