Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0376CCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UYi-0000Kk-DA; Wed, 08 Oct 2025 09:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1v6UYg-0000KN-Uy
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1v6UYR-0000F9-CO
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759931400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8a3V2/oAkOr5SqGpLfT6+i/CK1PWmVL6ZJNWhtRPVw=;
 b=Kg/HL+9R+QcrisGu0gLFOpAdF8YWC03EBuTshDF9kmUYOFIyCmVbnBcxatxlYd2xFQSScl
 uSS3kwGfzZxVtHCKuRqHxlUR2AevPSaazH+xkCtEYK2f7N2ftLqBsRZThosXRgXodWAI5z
 6mxCWJl++lznikwWrPwq1VJFeA7yd0Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-tv0z0eWnPmCtml_TaplnYw-1; Wed,
 08 Oct 2025 09:49:56 -0400
X-MC-Unique: tv0z0eWnPmCtml_TaplnYw-1
X-Mimecast-MFC-AGG-ID: tv0z0eWnPmCtml_TaplnYw_1759931395
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0311C1955F40; Wed,  8 Oct 2025 13:49:55 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16174180035E; Wed,  8 Oct 2025 13:49:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, Sebastian Ott <sebott@redhat.com>, Shameer
 Kolothum <skolothumtho@nvidia.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 gshan@redhat.com
Subject: Re: [RFC 1/3] target/arm/cpu: Add new CPU property for KVM regs to
 hide
In-Reply-To: <b2ae3dc0-9bf0-4e89-a995-b97410d57861@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250911134324.3702720-1-eric.auger@redhat.com>
 <20250911134324.3702720-2-eric.auger@redhat.com>
 <0f05a0ec-8b98-a9b7-6e3a-9ef73d0c34e7@redhat.com>
 <b2ae3dc0-9bf0-4e89-a995-b97410d57861@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 08 Oct 2025 15:49:51 +0200
Message-ID: <87ikgpv6yo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 03 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Hi Sebastian,
>
> On 9/18/25 6:16 PM, Sebastian Ott wrote:
>> On Thu, 11 Sep 2025, Eric Auger wrote:
>>> New kernels sometimes expose new registers in an unconditionnal
>>> manner.=C2=A0 This situation breaks backward migration as qemu notices
>>> there are more registers to store on guest than supported in the
>>> destination kerenl. This leads to a "failed to load
>>> cpu:cpreg_vmstate_array_len" error.
>>>
>>> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
>>> pseudo FW register in v6.16 by commit C0000e58c74e (=E2=80=9CKVM: arm64:
>>> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2=E2=80=9D). Trying to do backward
>>> migration from a host kernel which features the commit to a destination
>>> host that doesn't fail.
>>>
>>> Currently QEMU is not using that feature so ignoring this latter
>>> is not a problem. An easy way to fix the migration issue is to teach
>>> qemu we don't care about that register and we can simply ignore it,
>>> including its state migration.
>>>
>>> This patch introduces a CPU property, under the form of an array of
>>> reg indices which indicates which registers can be ignored.
>>>
>>> The goal then is to set this property in machine type compats such
>>> as:
>>> static GlobalProperty arm_virt_kernel_compat_10_1[] =3D {
>>> =C2=A0=C2=A0 /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>>> =C2=A0=C2=A0 { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
>>> }
>>
>> One thing worth noting - once this series lands:
>> https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothu=
m@gmail.com/
>>
>> we might need to add a bit more logic here. Either using the kvm
>> interfaces (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2 when the register
>> value is 0) or qemu knowledge (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2
>> when the impl-cpu property is not used).
>
> Effectively if we "hide" KVM_REG_ARM_VENDOR_HYP_BMAP_2 on save/restore
> we must enforce the reg is not used by userspace.
>
> One way would be to test whether KVM_REG_ARM_VENDOR_HYP_BMAP_2 is hidden
> in kvm_arm_target_impl_cpus_supported() and if it is, report false.
> However for every new functionality in qemu it does not sound sensible
> to check whether new KVM regs being used are anonymously hidden.
>
> Another way could be to fail kvm_set_one_reg/kvm_get_one_reg in case the
> register is hidden. That way in Shameer's series, kvm_arch_init_vcpu()
> would fail if BMAP_2 is hidden, ie. in our example for all machines
> types before 10.2. By the way adding Shameer.

I think tying this to the state of the reg (hidden or not) is less
error-prone (I'd assume we'd have different ways of detecting whether
something is used for future cases, and "is the reg hidden?" would work
in all cases.) We'd need to tie migration to matching machine versions
anyway, I think.


