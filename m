Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEA4CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 08:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slOTv-0007Qx-2V; Tue, 03 Sep 2024 04:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slOT6-0006xV-6t
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 04:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slOT4-0004Vk-8e
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 04:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725350448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQgES2SHE5kJKblMfzziYGbwwaww6AKxF4Mqvc0CMjU=;
 b=Hsdx1eo30iE1ncNNV9bB0TxE8b0V+Q9o0iwunQ9tVn/z2kZkBzqvkuzjs7zR25omGDAnjc
 87FXf7BkY2I+uFMH00ppIvwXdRjqiMz6DGOKA4fQAzpCSaVbp/6npk7I80w4dAk7tfOC65
 xk54NRHOQ97MqFFkgDBY0crKcYIRfRI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621--ZRYfZFbPwS-ilZQCNw_FQ-1; Tue, 03 Sep 2024 04:00:47 -0400
X-MC-Unique: -ZRYfZFbPwS-ilZQCNw_FQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2056364914eso15979955ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 01:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725350446; x=1725955246;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQgES2SHE5kJKblMfzziYGbwwaww6AKxF4Mqvc0CMjU=;
 b=uhZhELCKbEYSI9odNeBLoVIQtsqOGVoBy/G8G4895p9uIx9OyzvM+cmVrXmSJUkkYm
 wTZ87RRhiOldlCzxxRX1A5l/Iv522nCWWKDU/O16kSz5KfSbV2TCjXJxGIpipWgJimN4
 HzW20bmkI5IopOV7fAGyqWvxlJ4qluRZ1d+lA/z340dGDsfpOj+FD5FP4ZdjD+vjGCbO
 47sKoXOdIxhCZ60GxHGnbQXztVubCFRAUCBLIadOgFOjuNaGleEpcdkvsG2zbIOGt9W2
 tXKnGzggTXTSqyMrOzYUIyn6fHLVq/7qtdkWqwXDh4Cl1vq6kUYMd0lZlpi9uEahQcCb
 lTrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5fObPQURKja+S7/1g3iKrIIxPfyq8AEcfvf2WEqfv/g5oUJaZBWfiS0yQXiojPNAa7sWB6dNwViQy@nongnu.org
X-Gm-Message-State: AOJu0Yx4J8pV2y/UewVQZvd+hxMX2ONH5h0FiD2qfOnMQkpcYFfOP5X7
 x3262cZhKRZ2l8b/BzeUY85SFL2JHU2++WVmx8h6waJYgmMWPl006wtsqgsPpbEO+NJEYKwB+yN
 jpotZbDEu+Oxo+uv69w+6NxaTJQQeQ2Ol+CfMGX4qCuLwYu8f753L
X-Received: by 2002:a17:902:f650:b0:205:5de3:b964 with SMTP id
 d9443c01a7336-2055de3bbe9mr48274395ad.5.1725350444988; 
 Tue, 03 Sep 2024 01:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE45T9KeHgvKqCeFSvDtKlTMmyS8e/LokVC/OmwOZsaymL1yoXxJHhvPGWygRz6isjqiTrYRA==
X-Received: by 2002:a17:902:f650:b0:205:5de3:b964 with SMTP id
 d9443c01a7336-2055de3bbe9mr48274095ad.5.1725350444454; 
 Tue, 03 Sep 2024 01:00:44 -0700 (PDT)
Received: from smtpclient.apple ([115.96.207.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20515537813sm76088755ad.156.2024.09.03.01.00.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2024 01:00:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] kvm/i386: fix a check that ensures we are running on host
 intel CPU
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <32332f54-0c20-434c-be43-e4e00bcebe29@redhat.com>
Date: Tue, 3 Sep 2024 13:30:30 +0530
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9CFEBF6-A926-442F-96F4-1F1345D8E921@redhat.com>
References: <20240903071942.32058-1-anisinha@redhat.com>
 <32332f54-0c20-434c-be43-e4e00bcebe29@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 3 Sep 2024, at 1:13=E2=80=AFPM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 9/3/24 09:19, Ani Sinha wrote:
>> is_host_cpu_intel() returns TRUE if the host cpu in Intel based. RAPL =
needs
>> Intel host cpus. If the host CPU is not Intel baseed, we should =
report error.
>> Fix the check accordingly.
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> It's the function that is returning the incorrect value too; so your =
patch is breaking the feature: this line in is_host_cpu_intel()
>=20
> return strcmp(vendor, CPUID_VENDOR_INTEL);
>=20
> needs to be changed to use g_str_equal.

Ah that is why it got unnoticed as programatically it was not broken. I =
will send a v2.

>=20
> Paolo
>=20
>> ---
>>  target/i386/kvm/kvm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 11c7619bfd..503e8d956e 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2898,7 +2898,7 @@ static int kvm_msr_energy_thread_init(KVMState =
*s, MachineState *ms)
>>       * 1. Host cpu must be Intel cpu
>>       * 2. RAPL must be enabled on the Host
>>       */
>> -    if (is_host_cpu_intel()) {
>> +    if (!is_host_cpu_intel()) {
>>          error_report("The RAPL feature can only be enabled on hosts\
>>                        with Intel CPU models");
>>          ret =3D 1;
>=20


