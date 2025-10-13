Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74623CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 11:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8GYH-00050b-Ic; Mon, 13 Oct 2025 07:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8GYE-0004yO-Ey
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:17:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8GY8-0004Ni-FP
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:17:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so1172705e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 04:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760354225; x=1760959025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfom9lIGK8B5LzNP84cHo2tdWvudesEHr5zm07ZX1zc=;
 b=IOHKeABYXD3G5cjOZTMHPr9Jvpb5bqIPjdOJc6UoA5U8reh+IWbtEDKLePSb8VBzCt
 J5AD/DSzfXVoze5Spr3dKYE0PcZCb8kDYQtY/9KtdAsq+KFH9oEtTtx9xnT24PgfnPYt
 WZIKQN8KHfH6X/yGu+xS9b64EYkJpSgexVas2/8wLUSz5hR4PvDcUqhllmvxIGFDLnIu
 P24nv+RtBkPzxWglnuh4kSBklp6kaAd8MawP+mEC/svqBjPbq5TBOFcMLf+nMh0sLQBc
 2uDfYTi/0zzeAyA7PKhp1VF2JDz+see3I1LJhtzz09guCLLsyjw6+Yo2AQ1PlY4eBHku
 vAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760354225; x=1760959025;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfom9lIGK8B5LzNP84cHo2tdWvudesEHr5zm07ZX1zc=;
 b=Ytf9oWCVA6geNEZd7TEOSIhwl36y3BC5RhfoPiMB6ZwqGCnwudkZl/bxYy8aidukVZ
 m96pU7+02MGPh1RxW+wycDyOgVi1zIvb9aG4SugE+7DZ92CgDzS50vt05hPJjbTjo9YG
 lLL/W7fnsnVi4ozymIggNQzXRpjzk95sG1FuPa9ZZTfgw3lGhngjsem2cmRly9EapeaB
 y7wfVTlSpKN8y1jg/ddu9KHgtSDB6uIrQ5K8p0RrBEoR/P+fT46MdV95rM2TCb4Xvg0e
 zB8Kbhc28zyuWAYHxNtyDq4PVoNKnAAXRNM9nDpZjVoBW0TtwcD/k+Fyfwaq1AzmPQdL
 efTg==
X-Gm-Message-State: AOJu0YwSVp8EIXIGdPLJz0Q0ziuh8cvscMmfYvxt/+ClhezoR09Sl07f
 AL0nCmCf93Yp3KKA0Q9COAx399hTPZ6MrpZfi7hUXgZ0MgLfegTRiiIx
X-Gm-Gg: ASbGncs4Dkw2QcVlfFeLHRozi9ht4vW5rLA0J7uvITIJg/XsWoNDnmfQkvnxQYmc27n
 eQ87oSpai+/GHPBnIg4WUDio6l02ToGUtzp2rIJyGgF12IM/Ee0ejJZ3E+wBWrnn/E/HISbtQ9/
 2tlntdL1/OFw19wmYCcrpvhBnhksjbtGlmJuKKSIzPKnOaxBGwGN4b38czXpoqVr3H+dbMTkpJ8
 pVHfcyAqe+zRvEvy5Zxl7oDnm/v83XyrJH/q4ICgj8j+z2ZtXWnbt7WCKqseBjZk1OoJemmoxoH
 igJWSIRZaD1XX20+6WP2s3DpVKd6LpXw3MpUb+ydJmrBHpTeCNMNpmuDVmH+xIBO/5xvI5EIFVf
 +MQrFuF9KhVk9JQ5dhjepGKuMmVQ/K4VhkBs+o118Z7BNAvd3+caaktFIJRaffNfeYND2Mwc+7U
 Km0smtkPjIi6vFuyn6lO/HgPtpTVvOx4gBRArCJyV4W6lC4siN
X-Google-Smtp-Source: AGHT+IHsQ8yGCphHfIpI2hI91cvbXyTtAaY0V+rzP1LGt+AQxn2scdKT/VoLtCnWXMRLxBWW0Ykiqw==
X-Received: by 2002:a05:600c:4fc9:b0:46c:7097:6363 with SMTP id
 5b1f17b1804b1-46fa9aa4620mr125759665e9.13.1760354225225; 
 Mon, 13 Oct 2025 04:17:05 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400a0afdc243fcb5392.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:a0af:dc24:3fcb:5392])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3d7df4sm133343415e9.1.2025.10.13.04.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 04:17:04 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:17:01 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_docs/system/security=3A_Restrict?=
 =?US-ASCII?Q?_=22virtualization_use_case=22_to_specific_machines?=
In-Reply-To: <aL7xrilR-gyByKEM@redhat.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <aL7xrilR-gyByKEM@redhat.com>
Message-ID: <73575243-9E58-4DEA-89ED-24E2340A4112@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 8=2E September 2025 15:09:34 UTC schrieb "Daniel P=2E Berrang=C3=A9" <b=
errange@redhat=2Ecom>:
>On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
>> Currently our security policy defines a "virtualization use case"
>> where we consider bugs to be security issues, and a
>> "non-virtualization use case" where we do not make any security
>> guarantees and don't consider bugs to be security issues=2E
>>=20
>> The rationale for this split is that much code in QEMU is older and
>> was not written with malicious guests in mind, and we don't have the
>> resources to audit, fix and defend it=2E  So instead we inform users
>> about what the can in practice rely on as a security barrier, and
>> what they can't=2E
>>=20
>> We don't currently restrict the "virtualization use case" to any
>> particular set of machine types=2E  This means that we have effectively
>> barred ourselves from adding KVM support to any machine type that we
>> don't want to put into the "bugs are security issues" category, even
>> if it would be useful for users to be able to get better performance
>> with a trusted guest by enabling KVM=2E This seems an unnecessary
>> restriction, and in practice the set of machine types it makes
>> sense to use for untrusted-guest virtualization is quite small=2E
>>=20
>> Specifically, we would like to be able to enable the use of
>> KVM with the imx8 development board machine types, but we don't
>> want to commit ourselves to having to support those SoC models
>> and device models as part of QEMU's security boundary:
>> https://lore=2Ekernel=2Eorg/qemu-devel/20250629204851=2E1778-3-shentey@=
gmail=2Ecom/
>>=20
>> This patch updates the security policy to explicitly list the
>> machine types we consider to be useful for the "virtualization
>> use case"=2E
>>=20
>> This is an RFC partly to see if we have consensus that this change
>> makes sense, and partly because I was only able to identify the
>> machine types we want to cover for some of our target architectures=2E
>> If maintainers for the other architectures could clarify which
>> machine types work with KVM that would be helpful=2E
>
>The split of "virtualization" vs "non-virtualization" use case
>in the docs was always as rather a crude hack=2E
>
>"Virtualization uses cases" was more or less a code phrase to
>mean "the subset of QEMU that we traditionally shipped in RHEL"
>as that is approximately what we have reasonable confidence
>about=2E
>
>Personally I wouldn't assign strict equivalence between "machine
>can use KVM" and  "virtualization use case"=2E

Yeah, that's exactly the knot this RFC attempts to untangle and which was =
the motivation for the RFC in the first place=2E

>
>Case in point - the "isapc" machine type can use KVM but I would
>not consider that to be a virtualization use case, and would likely
>reject a security report if it /only/ affected isapc, and not 'pc'
>/ 'q35'=2E
>
>We didn't want to undertake the work to annotate every QOM/QDev
>impl in QEMU with info about whether we considered it in scope
>for security fixes or not, which is what we really ought to do
>at some point=2E The main challenge is someone having the time
>to do the audit & annotation work=2E
>
>> diff --git a/docs/system/security=2Erst b/docs/system/security=2Erst
>> index f2092c8768b=2E=2E395c2d7fb88 100644
>> --- a/docs/system/security=2Erst
>> +++ b/docs/system/security=2Erst
>> @@ -35,6 +35,34 @@ malicious:
>>  Bugs affecting these entities are evaluated on whether they can cause =
damage in
>>  real-world use cases and treated as security bugs if this is the case=
=2E
>> =20
>> +To be covered by this security support policy you must:
>> +
>> +- use a virtualization accelerator like KVM or HVF
>> +- use one of the machine types listed below
>> +
>> +It may be possible to use other machine types with a virtualization
>> +accelerator to provide improved performance with a trusted guest
>> +workload, but any machine type not listed here should not be
>> +considered to be providing guest isolation or security guarantees,
>> +and falls under the "non-virtualization use case"=2E
>> +
>> +Supported machine types for the virtualization use case, by target arc=
hitecture:
>> +
>> +aarch64
>> +  ``virt``
>> +i386, x86_64
>> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``is=
apc``
>> +s390x
>> +  ``s390-ccw-virtio``
>> +loongarch64:
>> +  ``virt``
>> +ppc, ppc64:
>> +  TODO
>> +mips, mips64:
>> +  TODO
>> +riscv32, riscv64:
>> +  TODO
>
>Currently 'virtualization use case' is reasonably vague such that we can
>bend its scope as we desire, at the time it is questioned in a possible
>security report=2E
>
>Machine types are only one aspect of this=2E Devices are the other, and
>the area where it gets significantly more fuzzy and difficult because
>essentially any device can be used with KVM, and where we draw the
>line is fairly arbitrary=2E

I agree that pluggable devices are much more fuzzy=2E That's why this RFC =
makes a start in spelling out the machines where certain guarantees are mad=
e, and leaves pluggable devices untouched=2E This should allow for KVM to b=
e usable in more machines, where these guarantees are too much of a burden=
=2E

Certainly there is more work to do on pluggable devices=2E And as you stat=
ed above, somebody has to have the time to work on it=2E

What is missing for your R-b, Daniel?

Best regards,
Bernhard

>
>
>
>With regards,
>Daniel

