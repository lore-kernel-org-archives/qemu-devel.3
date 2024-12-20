Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909FBE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfUd-0002kA-Mi; Fri, 20 Dec 2024 11:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tOfUY-0002jV-8V
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tOfUV-0002aZ-Fs
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734710676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zg7ccD/W/XlqMMpPf1cKO8U1jMkrmDqjiLXSn0kHDWA=;
 b=dZ2ie3eNuzpxF9rmHMUGx7QeaYelUIowgcWEyHIu+DTrKTwOmd51eYqVpG/rw2cy83QbPj
 1fD6yxMGw7YpxYodkhMAmu7IIUpRU6fg+T7w904RaY0DWtk+xyT36RzMksUZpIlebQ4CKP
 8xlHMl3khQT0MxfGR8i5PC7jk1nH+yc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-oIlcAF56MTS_mgkSjF_NPg-1; Fri,
 20 Dec 2024 11:04:33 -0500
X-MC-Unique: oIlcAF56MTS_mgkSjF_NPg-1
X-Mimecast-MFC-AGG-ID: oIlcAF56MTS_mgkSjF_NPg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD3FB1956088; Fri, 20 Dec 2024 16:04:30 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17819195608A; Fri, 20 Dec 2024 16:04:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Marc
 Zyngier <maz@kernel.org>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64
 KVM host model
In-Reply-To: <Z2RdMJHydsvPpmdH@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241206112213.88394-1-cohuck@redhat.com>
 <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
 <Z1qoa8yXscTSAJ9e@redhat.com> <8734it1bv6.fsf@redhat.com>
 <1fea79e4-7a31-4592-8495-7b18cd82d02b@redhat.com>
 <Z2QE9AqZnpGM5sWD@gezellig> <8634ijrh8q.wl-maz@kernel.org>
 <Z2Q2rWj9cV0W_XVq@gezellig> <86zfkrptmj.wl-maz@kernel.org>
 <Z2RdMJHydsvPpmdH@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 20 Dec 2024 17:04:25 +0100
Message-ID: <87frmibat2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 19 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, Dec 19, 2024 at 03:41:56PM +0000, Marc Zyngier wrote:
>> On Thu, 19 Dec 2024 15:07:25 +0000,
>> Kashyap Chamarthy <kchamart@redhat.com> wrote:
>> >=20
>> > On Thu, Dec 19, 2024 at 12:26:29PM +0000, Marc Zyngier wrote:
>> > > On Thu, 19 Dec 2024 11:35:16 +0000,
>> > > Kashyap Chamarthy <kchamart@redhat.com> wrote:
>> >=20
>> > [...]
>> >=20
>> > > > Consider this:
>> > > >=20
>> > > > Say, there's a serious security issue in a released ARM CPU.  As p=
art of
>> > > > the fix, two new CPU flags need to be exposed to the guest OS, cal=
l them
>> > > > "secflag1" and "secflag2".  Here, the user is configuring a baseli=
ne
>> > > > model + two extra CPU flags, not to get close to some other CPU mo=
del
>> > > > but to mitigate itself against a serious security flaw.
>> > >=20
>> > > If there's such a security issue, that the hypervisor's job to do so,
>> > > not userspace.=20
>> >=20
>> > I don't disagree.  Probably that has always been the case on ARM.  I
>> > asked the above based on how QEMU on x86 handles it today.
>> >=20
>> > > See what KVM does for CSV3, for example (and all the
>> > > rest of the side-channel stuff).
>> >=20
>> > Noted.  From a quick look in the kernel tree, I assume you're referring
>> > to these commits[1].
>> >=20
>> > > You can't rely on userspace for security, that'd be completely
>> > > ludicrous.
>> >=20
>> > As Dan Berrang=C3=A9 points out, it's the bog-standard way QEMU deals =
with
>> > some of the CPU-related issues on x86 today.  See this "important CPU
>> > flags"[2] section in the QEMU docs.
>>=20
>> I had a look, and we do things quite differently. For example, the
>> spec-ctrl equivalent in implemented in FW and in KVM, and is exposed
>> by default if the HW is vulnerable. Userspace could hide that the
>> mitigation is there, but that's the extent of the configurability.
>
> Whether it is enabled by default or disabled by default isn't a
> totally fatal problem. If QEMU can toggle it to the opposite value,
> we have the same level of configurability in both cases.

I don't think "hiding" is the same thing as "disabling"? The underlying
behaviour will still have changed, the main question is whether that is
a problem.

>
> It does, however, have implications for QEMU as if KVM gained support
> for exposing the new feature by default and QEMU didn't know about
> it, then the guest ABI would have changed without QEMU realizing it.
>
> IOW, it would imply a requirement for timely QEMU updates to match
> the kernel, which is something we wouldn't need in x86 world where
> the feature is disabled by default. Disable by default is a more
> stable approach from QEMU's POV.

It implies that QEMU (or generally the VMM) needs to actively disable
everything it does not know about (i.e. setting everything in any
writable id reg to zero if it has no idea what it is about) to provide a
stable guest interface across different kernels. Just tweaking some
known values is only sufficient for a stable interface across two
systems with the same kernel.

(...)

>> That's why I don't see CPU models as a viable thing in terms of ABI.
>> They are an approximation of what you could have, but the ABI is
>> elsewhere.
>
> Right, this makes life quite challenging for QEMU. The premise of named
> CPU models (as opposed to -host), is to facilitate the migration of VMs
> between heterogenous hardware platforms. That assumes it is possible to
> downgrade the CPU on both src + dst, to the common baseline you desire.
>
> If we were to define a named CPU model, for that to be usable, QEMU
> would have to be able to query the "maxmimum" architectural features,
> and validate that the delta between the host maximum, and the named
> CPU model is possible to downgrade. Is arm providing sufficient info
> to let QEMU do that ?

Not sure if I understand what you mean, but "give me the contents of all
id registers, and which registers are writable" should probably do the
trick?


