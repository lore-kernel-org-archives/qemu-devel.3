Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0458108E1E7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3B8k-0002kV-De; Thu, 19 Mar 2026 07:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3B8h-0002k7-0V
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3B8a-0002Kz-Rh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773918115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6d8TiPLlECBALGOWAGr3SgiSWNx5fswnH7v4qjIEdh8=;
 b=SOiRBKlZrur/JjE2Px9ticYg8ky5KDeWvRYJL9B2ZcgWTnJ9hnKMy7rtN3vPK/JhWM5l/C
 An76mPjkDumN0/CinYdgINBY1ku078KDEX6dvmu/Nh1HxHEJJi0N5fcOLpOaSS1i6yZlj4
 UAFgVWGd21um3V3SjpPRdxZ+xZOTVsE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-P7FwLFCGPTCEb7s-uq418A-1; Thu, 19 Mar 2026 07:01:54 -0400
X-MC-Unique: P7FwLFCGPTCEb7s-uq418A-1
X-Mimecast-MFC-AGG-ID: P7FwLFCGPTCEb7s-uq418A_1773918113
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35a0998a441so4174802a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773918113; x=1774522913; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6d8TiPLlECBALGOWAGr3SgiSWNx5fswnH7v4qjIEdh8=;
 b=EPiceOLicTDZIOFVbkWgDUWuiOh+kHp6kBc1/O0tJylKr6JUp5rYWWW3PekF4xRiTp
 h479qudR5BhluEbigWEfXs0a5yhzvOhYsUPPprr70qx/nSCo0dIdg01wMLySi1f2qC6B
 RCFCkiBDsAbsIvzc3KdA8RaE+cYF9MqeLVt/ORao1l1HCtGK3mpiajc9Qbj1ZYQZ+Lo3
 ls1mwtKD/V042NGSuLHkb4Qw7jOSC0qbJpMgqHqJA7gX52/tFQzfJWC6X+3OygvKyH9O
 kOGx5+drUpA/KY0es6h9OyiNWOEHQe/YR/GakKnBTKnFcpkeQJo6tCPu9VuQ+iwKOv6R
 i13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773918113; x=1774522913;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6d8TiPLlECBALGOWAGr3SgiSWNx5fswnH7v4qjIEdh8=;
 b=p0jUXTqIP0ekrtnesaT2ly3uZXq+5lqajn4C7zQ7vq5raCvsPQ7T+lTI4uEor7ZDTv
 pUGkSYQIDq9UDSkgUggOg+pMnvKZO2faofkcS9XHM/ZxyXI3hHyGLV4IxJy+SQ0wTMf0
 DBO2/1yKPcn3R3HbB32eSDWYKQL1x7QHLth9iG0lu+14RnpWiGsoDCxGyMuhLlH3ChjD
 yauIMnKFNQuDUZi0WtJCK9oCXcORIq7B3bR0rGiDv/cTmfslLESK7RBpYsJmC9aUJoeX
 x/9zabbi/yCv2ufaPX1F88XNXhnEhbd9afLy2pvLbJO0SuXkv3wNQ7FgwZ4zMvprRJCI
 IRTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+2Smh5YmK6OcWBF2tP+Q2q4B1dgBLKAxHuzgEfSoHUrXv8WKwCUvIycL+lHJbntffkpZDg2JMlsnz@nongnu.org
X-Gm-Message-State: AOJu0YzUdZ5Gys8gehLL9KYmM4QG3ZlfBza2TCPQ7QTaUPB1KTbkKW5h
 nsuUV7Ki7BQQRIZQRxQMI9rptoXBMPuK7L+IeqYmV6l3Kq8d0H3yDQCsUyMcOPSsC6K0cTxeI+I
 9XVbgFb4jKJcKcRqWgyI96EZw/CCF1OWP6vzE6G6ekVLJtX6/kQ5MALei
X-Gm-Gg: ATEYQzwl+Vhn0w87CreRb4F7tn6wUO/Er125U2RX/gYqY7lTOCFbTmoDCoRCV6Mffnd
 NN4XwkPpUZZhF1q46jc3HCLYu5RErSlcH1y9aAQi5sXTHhRuw8AbIro7LKDtEYxHsF7O5QCXsdp
 daE8s7+CUWanDp5mUIXaX8CYZjcOvqNraU471hYd33/q583eQKVt+8hOjdi2X2Gv4Tl5XaJExau
 NaQQNAVg4C82I6Es8EsENLLHYIsrONGsIEgp+UZMrgEePh34B04Q7uYWmW0fqqSGx9RNnwIKbiR
 tS5GqA8vnMFjgo9bRFlFcg3eoT5MiaTNurCwheC1z95PXs+KkFf+GyBUlm80etVgg2v0ZtGDCYz
 dhJpYZv6TO+jVlCOM7MG+rmOmwXhRx8VKf1/NlWkNbkmNUulR8rHoJ1OkVb3GKE1kKic0yg==
X-Received: by 2002:a17:90b:2687:b0:35b:9a4b:24e7 with SMTP id
 98e67ed59e1d1-35bb9eac31dmr5855823a91.14.1773918113205; 
 Thu, 19 Mar 2026 04:01:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:35b:9a4b:24e7 with SMTP id
 98e67ed59e1d1-35bb9eac31dmr5855808a91.14.1773918112699; 
 Thu, 19 Mar 2026 04:01:52 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bc6017492sm2489936a91.5.2026.03.19.04.01.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Mar 2026 04:01:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH for-11.0 2/2] i386/hyperv: add stubs for synic enablement
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <d616ab91-3cfc-4a77-83db-23ef16a00d49@linaro.org>
Date: Thu, 19 Mar 2026 16:31:37 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Michale Tokarev <mjt@tls.msk.ru>, kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <72E4CA7A-4362-4C5C-AE5F-3D0C3E129002@redhat.com>
References: <20260319101128.116301-1-anisinha@redhat.com>
 <20260319101128.116301-3-anisinha@redhat.com>
 <d616ab91-3cfc-4a77-83db-23ef16a00d49@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



> On 19 Mar 2026, at 4:23=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Ani,
>=20
> On 19/3/26 11:11, Ani Sinha wrote:
>> Add a new call hyperv_enable_synic() that can be called whether or =
not
>> CONFIG_HYPERV is enabled. This way genetic code in i396/kvm.c can =
call this
>> function to enable synic for hyperv. For non-hyperv cases, the stub =
will
>> be a noop.
>> Reported-by: Michale Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  target/i386/kvm/hyperv-stub.c |  5 +++++
>>  target/i386/kvm/hyperv.c      |  9 +++++++++
>>  target/i386/kvm/hyperv.h      |  1 +
>>  target/i386/kvm/kvm.c         | 12 +++++-------
>>  4 files changed, 20 insertions(+), 7 deletions(-)
>> diff --git a/target/i386/kvm/hyperv-stub.c =
b/target/i386/kvm/hyperv-stub.c
>> index 5836f53c23..767a4c7e1a 100644
>> --- a/target/i386/kvm/hyperv-stub.c
>> +++ b/target/i386/kvm/hyperv-stub.c
>> @@ -61,3 +61,8 @@ uint64_t hyperv_syndbg_query_options(void)
>>  {
>>      return 0;
>>  }
>> +
>> +int hyperv_enable_synic(X86CPU *cpu)
>> +{
>> +    return 0;
>> +}
>> diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
>> index f7a81bd270..bd3c26d02b 100644
>> --- a/target/i386/kvm/hyperv.c
>> +++ b/target/i386/kvm/hyperv.c
>> @@ -24,6 +24,15 @@ int hyperv_x86_synic_add(X86CPU *cpu)
>>      return 0;
>>  }
>>  +int hyperv_enable_synic(X86CPU *cpu)
>> +{
>> +    int ret =3D 0;
>> +    if (!hyperv_is_synic_enabled()) {
>> +        ret =3D hyperv_x86_synic_add(cpu);
>> +    }
>> +    return ret;
>> +}
>> +
>>  /*
>>   * All devices possibly using SynIC have to be reset before calling =
this to let
>>   * them remove their SINT routes first.
>> diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
>> index e45a4512fe..a393a5d428 100644
>> --- a/target/i386/kvm/hyperv.h
>> +++ b/target/i386/kvm/hyperv.h
>> @@ -23,6 +23,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct =
kvm_hyperv_exit *exit);
>>  #endif
>>    int hyperv_x86_synic_add(X86CPU *cpu);
>> +int hyperv_enable_synic(X86CPU *cpu);
>>  void hyperv_x86_synic_reset(X86CPU *cpu);
>>  void hyperv_x86_synic_update(X86CPU *cpu);
>>  diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index a29f757c16..9e352882c8 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -1754,13 +1754,11 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>>              return ret;
>>          }
>>  -        if (!hyperv_is_synic_enabled()) {
>> -            ret =3D hyperv_x86_synic_add(cpu);
>> -            if (ret < 0) {
>> -                error_report("failed to create HyperV SynIC: %s",
>> -                             strerror(-ret));
>> -                return ret;
>> -            }
>> +        ret =3D hyperv_enable_synic(cpu);
>> +        if (ret < 0) {
>> +            error_report("failed to create HyperV SynIC: %s",
>> +                         strerror(-ret));
>> +            return ret;
>>          }
>>      }
>> =20
>=20
> Why not simply add a hyperv_is_synic_enabled() stub?

That would be wrong unless I assert in hyperv_is_synic_enabled() stub =
function which would break minimal microvms?
The other reason is I do not like hyperv_x86_synic_add() returning =
-ENOSYS. If hyperv is not enabled we do not need to call those functions =
at all.




