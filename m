Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA80E7317E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmuPh-0005Zx-UO; Mon, 02 Feb 2026 08:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vmuPU-0005YO-Qo
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vmuPJ-0006x7-MJ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770040560;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jZn8VCSwicWA8obY6Sxj2wz4io16SjMIGagj/r0FQA=;
 b=Wi95699klQXF7HmciiYjUinaOjy3uoFBMh7jQxwsmyPwM2xblxDE15xhDnfnzdPNlDMAgo
 LScDKYmE9tc7WcjgJYPi0IATh/xB+mbaFa8k8S/H5qjTaGXA0WHZxF5BDeB97iVO2h/Q2z
 Jdnc+dY0MInlc/j9YjQSXm3hUujYHEc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-44xdOn2PNYCS1hTE28XioA-1; Mon, 02 Feb 2026 08:55:58 -0500
X-MC-Unique: 44xdOn2PNYCS1hTE28XioA-1
X-Mimecast-MFC-AGG-ID: 44xdOn2PNYCS1hTE28XioA_1770040557
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42fb1c2c403so3643479f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770040557; x=1770645357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jZn8VCSwicWA8obY6Sxj2wz4io16SjMIGagj/r0FQA=;
 b=D4UjUGCio0l3yRsr30eBqAxyT9P6REuSFbVSUs/NBTxal2MwmPkBCjd8mqXWuGs8Ez
 btunMsSplX5F095J3mvvnF0UwmNBfD5zlQIqMzG/9DbSNtask0QTQNCF+ySyrHoF1EY5
 TWpqiS5afkSe7E/gJeOQoR6S1BLWf3TebnzyPqrelbD2aGIutm/gRtEdlhtoclatIn+Q
 7UQYwxKcBauHbCbFpB/M8NHmZL7LVRJ/mX/SuSddL97onxoju2GCUZOLqZ/to5kLjIao
 rJAkC4NYg+1eF3AnIb51MqhvZUnAFBZk1vZyJ/+HtSuakseTb8BBi6WwybUAtbqBPYCE
 DG6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSCWpePMSQuxNn3nADT9IfFLlj0Dc2RhFyNHPN0XjTyZzNjsp8TSSui4EMvH5QqOnk8NVMpOCQBSI0@nongnu.org
X-Gm-Message-State: AOJu0Yw4eBB7UE1kS7uRtT0iw4eRXrp8aavVjpkjY68kmj+iQjDGjT0m
 pzYcvja25tpBDQK4quAxXtW43brlDHZMKu/9bKlvdim1qKA2PaLz7a7mbqpZDs02cOBRbZEwlYB
 CmqfFS141LHTcBnbObsMm0DWdDuoy6618kNZx1ZuuAf7o/goDdt1G+1Zt
X-Gm-Gg: AZuq6aL/k2eigdXQ0d9ZsWq2BRK4XMm/BrJUlAK++Ytnh+DUHeaJmJ+25GEAWfFeCZ/
 o5Q4FBSkFyoxrGS3zD+N6W4SmBuuVgs79HZuS+irY0+8Er8UOFnYYOOZBXDZChNbDrb2OtofHdr
 x2N3NEjHh4F9PB0/Ccher08zq2h0qtXi3y672zbFglZ2D9WCOZUY9KbpcF8gxN7rtydwbjdolg7
 LYWhXtGGFywGCjvJw4hlHrY/iA1LH2d6eYR4pAmcj/8pTIaktWHN078aGUI/d2aEm8dTaTs4XmQ
 wx6u1geVzpn59WgzNCAoAN6iTIfgbTwJ+MWHrLcWh8v8XrHXX3W4GnfI2VCLyOR1Va2T5hA67mf
 W+/OOWIgUxFhNbNYJbeW8WkMwAtzw1DBTFyxvPwm8rJozIgc174Nn8R94YA==
X-Received: by 2002:a05:6000:2689:b0:430:fa9a:74d with SMTP id
 ffacd0b85a97d-435f3a7bb17mr18085283f8f.24.1770040556620; 
 Mon, 02 Feb 2026 05:55:56 -0800 (PST)
X-Received: by 2002:a05:6000:2689:b0:430:fa9a:74d with SMTP id
 ffacd0b85a97d-435f3a7bb17mr18085214f8f.24.1770040556092; 
 Mon, 02 Feb 2026 05:55:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354d43sm48184643f8f.43.2026.02.02.05.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 05:55:55 -0800 (PST)
Message-ID: <706ef306-9735-42e2-8307-3c1ac536b61b@redhat.com>
Date: Mon, 2 Feb 2026 14:55:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community call (3/2/26) agenda items?
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 demiobenour@gmail.com, dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, felipe@nutanix.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, wei.w.wang@intel.com, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Sebastian Ott <sebott@redhat.com>
References: <875x8fpa0x.fsf@draig.linaro.org>
 <2946621b-3d00-40dd-a80f-3f301a2e9564@redhat.com>
 <CAFEAcA8rsJc_+JZY=TT96NAt0yskvwatvvMSHgwT+Zf5Y4=Daw@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA8rsJc_+JZY=TT96NAt0yskvwatvvMSHgwT+Zf5Y4=Daw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 2/2/26 2:49 PM, Peter Maydell wrote:
> On Mon, 2 Feb 2026 at 13:29, Eric Auger <eric.auger@redhat.com> wrote:
>> Hi Alex,
>> On 2/2/26 2:09 PM, Alex Bennée wrote:
>>> Hi,
>>>
>>> The KVM/QEMU community call is at:
>>>
>>> https://meet.jit.si/kvmcallmeeting
>>> @
>>> 03/02/2026 14:00 UTC
>>>
>>> Are there any agenda items for the sync-up?
>>>
>> I would be interested in discussing RH aarch64 cross kernel migration
>> issues.
>>
>> [PATCH v6 00/11] Mitigation of "failed to load
>> cpu:cpreg_vmstate_array_len" migration failures <https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.com/#r>
>> (https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.com/)
>> and
>> [PATCH v4 0/2] arm: add kvm-psci-version vcpu property <https://lore.kernel.org/all/20251202160853.22560-1-sebott@redhat.com/#r>
>> (https://lore.kernel.org/all/20251202160853.22560-1-sebott@redhat.com/)
> FWIW, that set of patches are in some sense on my to-review queue,
> but the area is complex enough that I have not yet made time to
> try to understand it and have enough of an opinion to review them.

I understand. This call can be an opportunity to discuss about the
problematic and tentative solution but if you judge this is too early to
discuss, we can wait for next call. Just let me know

Thanks

Eric 
>
> thanks
> -- PMM
>


