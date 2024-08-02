Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA23C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtG2-0005eB-Rq; Fri, 02 Aug 2024 10:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZtG1-0005TZ-FA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZtFz-00078u-Tt
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722608867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AF836Ndnqh+hwBkZ5YXfF8VJZkH/V2VUoPsaRxoRbo=;
 b=BeAGCcPPj1I2FGe234tYtT/GAw8ItBoe4jvIj0tBTORPGMDTm2NrPcKBrSWYZWgZ+JQsHn
 iEOZ7kA2ILEgDJBTRpls9FKKJpVd8/M1Zm7c55wzXua1csVYtGXLnDdcWEhWoEqQXJyAum
 851Fv0KeeiU03aUeYrnZ/ALm1lSnEww=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-XWO4I8cYMCuIDar7bdZhBw-1; Fri,
 02 Aug 2024 10:27:43 -0400
X-MC-Unique: XWO4I8cYMCuIDar7bdZhBw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28AEC1955F3B; Fri,  2 Aug 2024 14:27:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9187300018D; Fri,  2 Aug 2024 14:27:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B5E1B21E668F; Fri,  2 Aug 2024 16:27:23 +0200 (CEST)
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
 kvm@vger.kernel.org
Subject: Re: [PATCH 11/18] qapi/crypto: Rename QCryptoHashAlgorithm to
 *Algo, and drop prefix
In-Reply-To: <ZqoIDEjiUqK2dZx4@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 31 Jul 2024 10:46:52 +0100")
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-12-armbru@redhat.com>
 <Zqir1y4qyp-lwyuz@redhat.com> <8734nrgj5i.fsf@pond.sub.org>
 <ZqoIDEjiUqK2dZx4@redhat.com>
Date: Fri, 02 Aug 2024 16:27:23 +0200
Message-ID: <87le1fxano.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Tue, Jul 30, 2024 at 02:26:49PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Jul 30, 2024 at 10:10:25AM +0200, Markus Armbruster wrote:
>> >> QAPI's 'prefix' feature can make the connection between enumeration
>> >> type and its constants less than obvious.  It's best used with
>> >> restraint.
>> >>=20
>> >> QCryptoHashAlgorithm has a 'prefix' that overrides the generated
>> >> enumeration constants' prefix to QCRYPTO_HASH_ALG.
>> >>=20
>> >> We could simply drop 'prefix', but then the prefix becomes
>> >> QCRYPTO_HASH_ALGORITHM, which is rather long.
>> >>=20
>> >> We could additionally rename the type to QCryptoHashAlg, but I think
>> >> the abbreviation "alg" is less than clear.
>> >
>> > I would have gone with this, but it is a bit of a bike shed colouring
>> > debate so I'm not fussed
>>=20
>> Either solution seems okay, so I went with my personal preference.  Do
>> feel free to state yours and ask me to respin!
>
> After reviewing the patches that follow, I'd observe that picking
> Algo has made the following patches much larger than if it had
> stuck with Alg. Basically changing both the types & constants,
> instead of only having to change the types.=20

Yes.  Worth the more obvious names to me, but again, feel free to ask me
to respin for less churn.


