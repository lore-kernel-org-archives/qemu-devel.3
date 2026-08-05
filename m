Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C96C55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrVZL-0005i2-Fd; Wed, 05 Aug 2026 02:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wrVZJ-0005hf-G4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 02:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wrVZD-00089J-Li
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 02:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785913050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0f55kWXGzhUOHYJn9EhmFr9fQk3z2XBSDL/0HeJN2Eo=;
 b=PZFRJuPfFbTm9Db5/rZy0c4wqngbr+bOsaKm5QlcEiv+msAiXD80xjBapEdhI1F3tiNnc0
 ZC6rd3PXmJ+tu1z+c8TlBRqt/Lv1CKZ0/pB7cnhuHvJvjNUJDL00MGPj+ZMNqyV8fHJ4XT
 /rMf/+frN6iVNHTbb2CY1WQTqM9tsq0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-XnzXpwKLNGmgUgnka3LzkA-1; Wed,
 05 Aug 2026 02:57:27 -0400
X-MC-Unique: XnzXpwKLNGmgUgnka3LzkA-1
X-Mimecast-MFC-AGG-ID: XnzXpwKLNGmgUgnka3LzkA_1785913045
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E49801956095; Wed,  5 Aug 2026 06:57:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C914E18005A7; Wed,  5 Aug 2026 06:57:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DC5C21E6920; Wed, 05 Aug 2026 08:57:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>,  "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,  "cohuck@redhat.com"
 <cohuck@redhat.com>,  "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>,  "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,  "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,  "berrange@redhat.com"
 <berrange@redhat.com>,  "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>,  "gshan@redhat.com"
 <gshan@redhat.com>,  "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "sebott@redhat.com" <sebott@redhat.com>,  "philmd@linaro.org"
 <philmd@linaro.org>,  "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,  Mark Cave-Ayland
 <mark.caveayland@nutanix.com>,  Prerna Saxena <prerna.saxena@nutanix.com>
Subject: Re: [RFC PATCH v3 16/19] qmp: add query-cpu-props-info command
In-Reply-To: <3099C064-6051-4B93-BE0F-C54B7FD91D82@nutanix.com> (Khushit
 Shah's message of "Wed, 5 Aug 2026 06:47:52 +0000")
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-17-khushit.shah@nutanix.com>
 <878q6m5qox.fsf@pond.sub.org>
 <3099C064-6051-4B93-BE0F-C54B7FD91D82@nutanix.com>
Date: Wed, 05 Aug 2026 08:57:20 +0200
Message-ID: <875x1p12cv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 127.0.0.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Khushit Shah <khushit.shah@nutanix.com> writes:

>> On 4 Aug 2026, at 12:15=E2=80=AFPM, Markus Armbruster <armbru@redhat.com=
> wrote:
>>=20
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>=20
>> |-------------------------------------------------------------------!
>>=20
>> Khushit Shah <khushit.shah@nutanix.com> writes:
>>=20
>>> Introduce the 'query-cpu-props-info' QMP command. For CPU model
>>> properties it reports the type (boolean or number) and the set of values
>>> supported under the active accelerator and host.
>>>=20
>>> For numbers the supported values are expressed as a list of inclusive
>>> {min, max} ranges; for booleans as the list of allowed true/false
>>> values.
>>>=20
>>> The command and its return types (CpuPropertyType, CpuPropertyInfo and
>>> friends) are defined in qapi/machine.json rather than an Arm-specific
>>> schema, since the concept applies to other targets (e.g. x86, riscv)
>>> too. Target that do not implement it return an error.
>>>=20
>>> The Arm/KVM implementation spins up a scratch "host" vCPU object,
>>> walks its QOM properties: SYSREG_ ID-register fields become 'number'
>>> properties whose ranges come from arm_field_get_supported_values(),
>>> and the advertised feature toggles become 'boolean' properties.
>>>=20
>>> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>>=20
>> This explains what the command does and how it's implemented.  It's
>> silent on the most important aspect: why do we want the command?  What
>> is its intended purpose?
>
> Will add something like:
>
> This helps the management stack to discover which values are supported
> for a given CPU property. This is especially important for non-boolean
> properties, where knowing that the host has value 'x' does not inherently
> reveal the full range of valid values supported on the host.

Better.  Perhaps throw in an example if you can come up with a simple
one.


