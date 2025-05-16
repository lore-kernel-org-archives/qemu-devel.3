Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A33C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwGW-0006ar-3X; Fri, 16 May 2025 10:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uFwGT-0006a4-MF
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uFwGR-0001g1-6w
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747406536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sD306+wR2Yr1QYUWd0Nza6XnFdZAYxmZP8qIvKeNGlI=;
 b=X+R2E+sLClwfvN7IDTdNzWDSc1aV8sG0jt1VB1NLFEj3EmxjDKP+lmlQ9nRJUnZsZrtnbn
 npK9ZY3noTkKGy91nRuRYvANqiAOcy4+C8SF3QdlMo364saRjVvrvLArtEb84YoYc8wKsd
 cTnbcm3NoHaQfxGz9rIzySt82XOhfS8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-0LuNbzh8McSoZzd5gePpdA-1; Fri,
 16 May 2025 10:42:11 -0400
X-MC-Unique: 0LuNbzh8McSoZzd5gePpdA-1
X-Mimecast-MFC-AGG-ID: 0LuNbzh8McSoZzd5gePpdA_1747406529
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C6811956094; Fri, 16 May 2025 14:42:08 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 389DB30075D5; Fri, 16 May 2025 14:42:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, agraf@csgraf.de,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH v3 08/10] arm/cpu: more customization for the kvm host
 cpu model
In-Reply-To: <aCNrtM2U7OBKsnjQ@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-9-cohuck@redhat.com> <aCNrtM2U7OBKsnjQ@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 16 May 2025 16:42:03 +0200
Message-ID: <87y0uwbosk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Tue, May 13 2025, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Apr 14, 2025 at 06:38:47PM +0200, Cornelia Huck wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>=20
>> If the interface for writable ID registers is available, expose uint64
>> SYSREG properties for writable ID reg fields exposed by the host
>> kernel. Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
>> being those used  in linux arch/arm64/tools/sysreg. This done by
>> matching the writable fields retrieved from the host kernel against the
>> generated description of sysregs.
>>=20
>> An example of invocation is:
>> -cpu host,SYSREG_ID_AA64ISAR0_EL1_DP=3D0x0
>> which sets DP field of ID_AA64ISAR0_EL1 to 0.
>
> Functionally this works, but stylewise it is rather too verbose
> IMHO. I understand this aims to mtch the arm feature names, but
> we can at least drop the SYSREG_ prefix here which IMHO doesn't
> add much value. The <REG> component only has a small number of
> possible prefixes, so it seems pretty unlikely we would get a
> name clash between these and some other QOM property.

The main reason for the SYSREG_ prefix was to make implementation of the
query interface easier; I'll see if we can implement it differently. (We
might want to think about how we handle it differently anyway.)

>
> Also could we stick with lowercase, rather than uppercase. I
> appreciate the spec uses uppercase, but that doesn't concern
> itself with end user usage. If we just plain transform everything
> to lowercase, there's still a clear mapping to the spec that
> people will understand [1].

Did you forget to include [1]? :)

I agree that a lowercase conversion wouldn't make things too hard to
find in the docuementation.

>
> This example uses '-cpu host', but does this also work
> with '-cpu max'  ?
>
> Conceptually '-cpu max' is supposed to be functionally identical
> to '-cpu host' when KVM is enabled. Obviously you'd ned to
> exclude it from '-cpu max' with TCG or other non-KVM accels.

For KVM, this works with -cpu max as well, as it falls through to -cpu
host implicitly. aarch64_host_initfn() is basically split into KVM and
HVF parts, so HVF will already do the right thing (i.e. not support it),
as will tcg (which uses a separate init function.)

>
>
>> +/*
>> + * decode_idreg_writemap: Generate props for writable fields
>> + *
>> + * @obj: CPU object
>> + * @index: index of the sysreg
>> + * @map: writable map for the sysreg
>> + * @reg: description of the sysreg
>> + */
>> +static int
>> +decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg=
 *reg)
>> +{
>> +    int i =3D ctz64(map);
>> +    int nb_sysreg_props =3D 0;
>> +
>> +    while (map) {
>> +
>> +        ARM64SysRegField *field =3D get_field(i, reg);
>> +        int lower, upper;
>> +        uint64_t mask;
>> +        char *prop_name;
>> +
>> +        if (!field) {
>> +            /* the field cannot be matched to any know id named field */
>> +            warn_report("%s bit %d of %s is writable but cannot be matc=
hed",
>> +                        __func__, i, reg->name);
>> +            warn_report("%s is cpu-sysreg-properties.c up to date?", __=
func__);
>
> What scenario triggers this warning ? Is this in relation to QEMU
> auto-detecting host CPU features, as opposed to user -cpu input ?

The kernel making something writable, but we haven't updated
cpu-sysreg-properties.c via the script. As I'd expect regs/fields to be
added to sysreg much earlier than KVM making them writable, we'll
probably not see much of this warning in practice (only if you run a
really old QEMU version with a cutting-edge kernel.) This has mostly
triggered for me when I had messed up something while writing the code
:)

This is not user-input triggered, so maybe we should log it differently,
as the user can't really fix this themself?


