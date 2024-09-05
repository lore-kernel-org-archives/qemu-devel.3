Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607DFCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 06:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm5Wu-000334-Ac; Thu, 05 Sep 2024 01:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sm5Wt-00031c-9J
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 01:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sm5Wr-0005WW-MH
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 01:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725515975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6reZ1veDRgjADNo0UCSOVYrtvbXoke99y6rq2zpHqqE=;
 b=OwU5auxIrmzcaWkeEgNRCFiKnsThh+iOtAJZNKZbWguMulEDlOPBNehMJyU6CG8FPJDbjR
 0cg7C0nUe89fuM3IX7uKUqE8QSvGq5R2mmt8TPJvLpLS/FZrdEygjiAIauGPfhR98qJ6ci
 DZ2CHnl5Jjz7iOEHYaDU5J4y1JIL/Qw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-ZRVVieJlOqmc7_FmfFlFbA-1; Thu,
 05 Sep 2024 01:59:32 -0400
X-MC-Unique: ZRVVieJlOqmc7_FmfFlFbA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A45AA19560B0; Thu,  5 Sep 2024 05:59:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 954071956048; Thu,  5 Sep 2024 05:59:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9218221E6A28; Thu,  5 Sep 2024 07:59:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  alex.williamson@redhat.com,
 andrew@codeconstruct.com.au,  andrew@daynix.com,
 arei.gonglei@huawei.com,  berto@igalia.com,  borntraeger@linux.ibm.com,
 clg@kaod.org,  david@redhat.com,  den@openvz.org,  eblake@redhat.com,
 eduardo@habkost.net,  farman@linux.ibm.com,  farosas@suse.de,
 hreitz@redhat.com,  idryomov@gmail.com,  iii@linux.ibm.com,
 jamin_lin@aspeedtech.com,  jasowang@redhat.com,  joel@jms.id.au,
 jsnow@redhat.com,  kwolf@redhat.com,  leetroy@gmail.com,
 marcandre.lureau@redhat.com,  marcel.apfelbaum@gmail.com,
 michael.roth@amd.com,  mst@redhat.com,  mtosatti@redhat.com,
 nsg@linux.ibm.com,  pasic@linux.ibm.com,  pbonzini@redhat.com,
 peter.maydell@linaro.org,  peterx@redhat.com,  philmd@linaro.org,
 pizhenwei@bytedance.com,  pl@dlhnet.de,  richard.henderson@linaro.org,
 stefanha@redhat.com,  steven_lee@aspeedtech.com,  thuth@redhat.com,
 vsementsov@yandex-team.ru,  wangyanan55@huawei.com,
 yuri.benditovich@daynix.com,  zhao1.liu@intel.com,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  qemu-s390x@nongnu.org,
 kvm@vger.kernel.org,  avihaih@nvidia.com
Subject: Re: [PATCH v2 01/19] qapi: Smarter camel_to_upper() to reduce need
 for 'prefix'
In-Reply-To: <ZthQAr7Mpd0utBD9@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 4 Sep 2024 13:18:10 +0100")
References: <20240904111836.3273842-1-armbru@redhat.com>
 <20240904111836.3273842-2-armbru@redhat.com>
 <ZthQAr7Mpd0utBD9@redhat.com>
Date: Thu, 05 Sep 2024 07:59:13 +0200
Message-ID: <87o75263pq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Sep 04, 2024 at 01:18:18PM +0200, Markus Armbruster wrote:
>> camel_to_upper() converts its argument from camel case to upper case
>> with '_' between words.  Used for generated enumeration constant
>> prefixes.
>
>
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Daniel P. Berrang?? <berrange@redhat.com>
>
> The accent in my name is getting mangled in this series.

Uh-oh!

Checking...  Hmm.  It's correct in git, correct in output of
git-format-patch, correct in the copy I got from git-send-email --bcc
armbru via localhost MTA, and the copy I got from --to
qemu-devel@nongnu.org, correct in lore.kernel.org[*], correct in an mbox
downloaded from patchew.

Could the culprit be on your side?

> IIRC your mail client (git send-email ?) needs to be explicitly
> setting a chardset eg
>
>   Content-type: text/plain; charset=3Dutf8
>
> so that mail clients & intermediate servers know how to interpret
> the 8bit data.
>
> With regards,
> Daniel


[*] https://lore.kernel.org/qemu-devel/ZthQAr7Mpd0utBD9@redhat.com/T/#m4a76=
25a47ce94c30ca2ae6d94acd2901e0d0d176


