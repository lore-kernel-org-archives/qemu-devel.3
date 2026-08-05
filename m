Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D5DC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrbaA-000718-Ri; Wed, 05 Aug 2026 09:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wrba7-00070J-NB
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 09:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wrba5-0005U1-GC
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 09:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785936167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wi3XW+KFj9sTieUCiS9bErMSb8fpwD3DcBAKWHUuRY=;
 b=MegJQ9tYmqWDDb4rmLlMMh9JKA5y2tfruPro1QslIPoR9q4RIBPrTl0g7aYASmb7fqsu+g
 D2RBai9mjZ2gU43NyBl/S98wqwZt5Ljw81zRETRQrpsteXkSnj7DUBKRhyAkxa1VbH2Hd2
 8tDl8tQWVgnnoA4iETJ7cijdHV/v2PQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-jOKzqmDKNdSHZfzPXwKmpA-1; Wed,
 05 Aug 2026 09:22:44 -0400
X-MC-Unique: jOKzqmDKNdSHZfzPXwKmpA-1
X-Mimecast-MFC-AGG-ID: jOKzqmDKNdSHZfzPXwKmpA_1785936162
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1F731800646; Wed,  5 Aug 2026 13:22:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C1551956041; Wed,  5 Aug 2026 13:22:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01FCF21E6920; Wed, 05 Aug 2026 15:22:37 +0200 (CEST)
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
In-Reply-To: <5F6481F1-B5E1-4B30-A4D1-481D9C0731AC@nutanix.com> (Khushit
 Shah's message of "Wed, 5 Aug 2026 07:32:10 +0000")
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-17-khushit.shah@nutanix.com>
 <87y0f5u78t.fsf@pond.sub.org>
 <6AA3BD42-9596-476B-9F64-AB09372821B9@nutanix.com>
 <87tspa5skn.fsf@pond.sub.org>
 <FD805FA0-9323-450C-9D79-319C0883F05E@nutanix.com>
 <FDD5760F-94E6-46F4-AC62-AB0DC98322FD@nutanix.com>
 <8733wu5qfs.fsf@pond.sub.org>
 <08DA9B28-D5BD-4EC3-8182-FEE212F0C2A0@nutanix.com>
 <871pcd12bf.fsf@pond.sub.org>
 <5F6481F1-B5E1-4B30-A4D1-481D9C0731AC@nutanix.com>
Date: Wed, 05 Aug 2026 15:22:37 +0200
Message-ID: <87o6fgzopu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

>> On 5 Aug 2026, at 12:28=E2=80=AFPM, Markus Armbruster <armbru@redhat.com=
> wrote:
>>=20
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>=20
>> |-------------------------------------------------------------------!
>>=20
>> Khushit Shah <khushit.shah@nutanix.com> writes:
>>=20
>>>> On 4 Aug 2026, at 12:21=E2=80=AFPM, Markus Armbruster <armbru@redhat.c=
om> wrote:
>>>>=20
>>>> !-------------------------------------------------------------------|
>>>> CAUTION: External Email
>>>>=20
>>>> |-------------------------------------------------------------------!
>>>>=20
>>>> Khushit Shah <khushit.shah@nutanix.com> writes:
>>>>=20
>>>> [...]
>>>>=20
>>>>> Stub file was missing on arm user builds.=20
>>>>>=20
>>>>> I have fixed this on the private branch if you want to take a look.
>>>>=20
>>>> I'm willing to pull an update to v3, assuming it's a small fix.
>>>=20
>>> It is a small fix :)
>>=20
>> Please tell me what to pull.  When you're ready, of course.
>
> It=E2=80=99s on the same private branch: https://github.com/khushit-shah-=
nx/qemu/tree/upstream-rfc-v3-fixups

Builds, but fails "make check" on my box *sigh*.

tests/qtest/qmp-cmd-test.c needs an update.


