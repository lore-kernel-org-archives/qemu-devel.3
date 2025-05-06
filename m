Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D63C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKOK-00042Y-OQ; Tue, 06 May 2025 11:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCKOJ-00042K-R9
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCKOD-0003Q7-8M
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgAbqy6WJ9z3W5UzzUNbeU0qsJG1COSaqX+7g6Erm2I=;
 b=CDnhLulUQN3GQswVHGMO1NHNdoJfAOHOaemX6EFLULQCdRvWthmG08ruDqJKYb48lu3n8T
 f4LTrRsqiz/W0jHSr9YYAPvoRVJl3fUUBLUPRjKfnEqWx1NJydBC8q4QhcxYwgKfeiUkkJ
 eEx6kSD5TAcxGdQsxNoXIdXZDe+RjVc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-anUd5ch6N4W1H3-ouxLLyg-1; Tue,
 06 May 2025 11:39:20 -0400
X-MC-Unique: anUd5ch6N4W1H3-ouxLLyg-1
X-Mimecast-MFC-AGG-ID: anUd5ch6N4W1H3-ouxLLyg_1746545958
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BA4D1955D67; Tue,  6 May 2025 15:39:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4720919560B2; Tue,  6 May 2025 15:39:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B04CD21E66C2; Tue, 06 May 2025 17:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "Michael S.
 Tsirkin"
 <mst@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Dmitry Fleytman
 <dmitry.fleytman@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,  Vincenzo Maffione
 <v.maffione@gmail.com>,  Andrew Melnychenko <andrew@daynix.com>,  Yuri
 Benditovich <yuri.benditovich@daynix.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Michael
 Roth <michael.roth@amd.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org,  devel@daynix.com
Subject: Re: [PATCH v6 0/4] virtio: Convert feature properties to OnOffAuto
In-Reply-To: <db08fab9-682c-491c-bafc-9a701bbc73ee@daynix.com> (Akihiko
 Odaki's message of "Mon, 5 May 2025 15:44:43 +0900")
References: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
 <20250425081234-mutt-send-email-mst@kernel.org>
 <aAt-HPZB7ifgZqmd@redhat.com> <87r01gb7of.fsf@pond.sub.org>
 <db08fab9-682c-491c-bafc-9a701bbc73ee@daynix.com>
Date: Tue, 06 May 2025 17:39:12 +0200
Message-ID: <87msbprbof.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/04/26 0:08, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>>> On Fri, Apr 25, 2025 at 08:14:13AM -0400, Michael S. Tsirkin wrote:
>>>> On Thu, Mar 06, 2025 at 03:16:26PM +0900, Akihiko Odaki wrote:
>>>>> This series was spun off from:
>>>>> "[PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto"
>>>>> (https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/)
>>>>>
>>>>> Some features are not always available with vhost. Legacy features are
>>>>> not available with vp_vdpa in particular. virtio devices used to disa=
ble
>>>>> them when not available even if the corresponding properties were
>>>>> explicitly set to "on".
>>>>>
>>>>> QEMU already has OnOffAuto type, which includes the "auto" value to l=
et
>>>>> it automatically decide the effective value. Convert feature properti=
es
>>>>> to OnOffAuto and set them "auto" by default to utilize it. This allows
>>>>> QEMU to report an error if they are set "on" and the corresponding
>>>>> features are not available.
>>>>>
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>
>>>>
>>>> Marcus, Paolo, Daniel, Eduardo, any feedback on the QOM bits?
>>>
>>> I've said on every previous version that I don't think we should be
>>> changing OnOffAuto to secretly accept bool values. That is bypassing
>>> QAPI schema definitions with a special code hack.
>>=20
>> I also objected to v4.  Thread starts at
>>      Message-ID: <87cyfwxveo.fsf@pond.sub.org>
>>      https://lore.kernel.org/qemu-devel/87cyfwxveo.fsf@pond.sub.org/
>> I could be persuaded to accept a patch that changes exactly the
>> properties that need to be changed to tri-state, with suitable
>> rationale.  This patch changes a bunch of unrelated properties, too.
>
> I replied to the thread as I found that I haven't replied to the last mes=
sage in the thread and the newer versions of the series do not address its =
discussion points either.

I just reiterated and clarified my objection in said thread, and tried
to point towards possible solutions I could accept.


