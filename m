Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF56F9D0C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCc1S-0001X5-7I; Tue, 14 Apr 2026 07:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wCc1Q-0001WJ-3Z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wCc1O-0005WC-FC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776166412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYGCQP3LEboU00ZnsL8lHLudaj7xBod+k/td90B2G8s=;
 b=UtCEUIi/TGZsEcfySm0+xmBuLawJH8JVrq6TDhyyz5NMkL56PVPZ7nZ9Hg5f6nvD1V8cpt
 RebOi9+U2dscP68VRaKcZ92UrRt0EgydtanykLNtX+Nc+ws5qL5tAzwesr4/NVt1NE5n1e
 VRYCFiDr0giJ8LR+mmWUHcnI3EpbTQo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-bOU_TqFHPnygWcnzogi2yw-1; Tue,
 14 Apr 2026 07:33:29 -0400
X-MC-Unique: bOU_TqFHPnygWcnzogi2yw-1
X-Mimecast-MFC-AGG-ID: bOU_TqFHPnygWcnzogi2yw_1776166407
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12D8618002C0; Tue, 14 Apr 2026 11:33:27 +0000 (UTC)
Received: from localhost (dhcp-192-192.str.redhat.com [10.33.192.192])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01A8818002A6; Tue, 14 Apr 2026 11:33:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>, Eric Farman
 <farman@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Halil Pasic
 <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, David Hildenbrand
 <david@kernel.org>
Subject: Re: [PATCH 0/5] target/s390x: Forbid to use legacy ldst_phys() API
In-Reply-To: <640ddcc2-f373-4738-8e66-50effe56de4e@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260319185203.11799-1-philmd@linaro.org>
 <f0965bf8-b736-4e53-b809-374945f0f48e@linux.ibm.com>
 <63ddd321-067b-4c44-99e1-9c6c0ac60003@linaro.org>
 <640ddcc2-f373-4738-8e66-50effe56de4e@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Tue, 14 Apr 2026 13:33:23 +0200
Message-ID: <87tstdbwu4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 14 2026, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 21/3/26 16:26, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 20/3/26 20:28, Matthew Rosato wrote:
>>> On 3/19/26 2:51 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Replace legacy ld/st_phys() by address_space_ld/st()
>>>> then lock the target again further legacy API uses.
>>>>
>>>> Philippe Mathieu-Daud=C3=A9 (5):
>>>> =C2=A0=C2=A0 target/s390x: Replace legacy ld/st_phys -> address_space_=
ld/st (cpu)
>>>> =C2=A0=C2=A0 target/s390x: Replace legacy ld/st_phys -> address_space_=
ld/st (mmu)
>>>> =C2=A0=C2=A0 target/s390x: Replace legacy ld/st_phys -> address_space_=
ld/st (tcg)
>>>> =C2=A0=C2=A0 target/s390x: Replace legacy ld/st_phys -> address_space_=
ld/st (kvm)
>>>> =C2=A0=C2=A0 configs/targets: Restrict the legacy ldst_phys() API on s=
390x target
>>>
>>> For the series:
>>>
>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>
>>> For good measure I also ran some s390x kvm regression tests, took a=20
>>> less comprehensive spin with a tcg s390x guest (on s390 host), and=20
>>> forced a few of these codepaths as a sanity check.
>
> Does that mean we can also add:
>
>    Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
> ?

I was planning to pick this via s390-next, I can add T-b if desired.


