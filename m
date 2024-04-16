Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD83C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwkZT-0005oa-Jq; Tue, 16 Apr 2024 11:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rwkZP-0005o3-GO
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rwkZN-0007p9-3p
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713280679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPtRVTsXis21eVmAj2j9npZRV3GxwQ/AaRJo8gVEatg=;
 b=FfTmTon9WAn8JAkwFKVmbBGIHKsgnxMu8hVg2v4iC7hdApd+x9O19mfcEmhcbJKtLVpwDG
 to934dnDQP32eb/dq4JmCPcSTR15kI25s09FuzRgby+Lksb0KN1wvMq8nA6SxN/6xUJs41
 H6lQaytpeeWLlTq0G1HP/vBXDYnydEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Gxm3JAxfNWyzzrw3LARPug-1; Tue, 16 Apr 2024 11:17:56 -0400
X-MC-Unique: Gxm3JAxfNWyzzrw3LARPug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6AC7104B507;
 Tue, 16 Apr 2024 15:17:55 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 597DB2026D1F;
 Tue, 16 Apr 2024 15:17:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 qemu-arm@nongnu.org
Cc: Eric Auger <eauger@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
In-Reply-To: <227c96c8-4f17-4f79-9378-a15c9dce8d46@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240409024940.180107-1-shahuang@redhat.com>
 <d1a76e23-e361-46a9-9baf-6ab51db5d7ba@redhat.com>
 <47e0c03b-0a6f-4a58-8dd7-6f1b85bcf71c@redhat.com>
 <227c96c8-4f17-4f79-9378-a15c9dce8d46@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 16 Apr 2024 17:17:54 +0200
Message-ID: <875xwhjpzx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 10 2024, Thomas Huth <thuth@redhat.com> wrote:

> On 09/04/2024 09.47, Shaoqin Huang wrote:
>> Hi Thmoas,
>>=20
>> On 4/9/24 13:33, Thomas Huth wrote:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert_has_feature(qts, "h=
ost", "kvm-pmu-filter");
>>>
>>> So you assert here that the feature is available ...
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert_has_feat=
ure(qts, "host", "kvm-steal-time");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert_has_feat=
ure(qts, "host", "sve");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resp =3D do_que=
ry_no_props(qts, "host");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_supports_pmu_filter =
=3D resp_get_feature_str(resp,=20
>>>> "kvm-pmu-filter");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_supports_st=
eal_time =3D resp_get_feature(resp,=20
>>>> "kvm-steal-time");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_supports_sv=
e =3D resp_get_feature(resp, "sve");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vls =3D resp_ge=
t_sve_vls(resp);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qobject_unref(r=
esp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_supports_pmu_filte=
r) { >
>>> ... why do you then need to check for its availability here again?
>>> I either don't understand this part of the code, or you could drop the=
=20
>>> kvm_supports_pmu_filter variable and simply always execute the code bel=
ow.
>>=20
>> Thanks for your reviewing. I did so because all other feature like=20
>> "kvm-steal-time" check its availability again. I don't know the original=
=20
>> reason why they did that. I just followed it.
>>=20
>> Do you think we should delete all the checking?
>
> resp_get_feature() seems to return a boolean value, so though these featu=
re=20
> could be there, they still could be disabled, I assume? Thus we likely ne=
ed=20
> to keep the check for those.

This had confused me as well when I looked at it the last time -- one
thing is to check whether we have a certain prop in the cpu model, the
other one whether we actually support it. Maybe this needs some
comments?


