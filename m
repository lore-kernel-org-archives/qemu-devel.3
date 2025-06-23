Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F334AC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdOH-0006G8-EP; Mon, 23 Jun 2025 05:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTdOC-0006BB-42
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTdOA-0008NI-JF
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750670573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1KXzJpOuSAyUhLyD/nxSRKG7fsnQJrcNpgC/Mkhpco=;
 b=TR3tpAXatihJBJR9Xu/L3PDmuxUYDV5bmLVmfaIjujBmtgg+T5JKYNFqQlRlyeAiKJeUwa
 3+pUhfMeO+K0yJun4m2bGvI7hLsng5GAGapzKPXLVOoGuO6V2luZ+CQdLo3Sj0kzFvrwMj
 BfSVrdqBlHR9s3RDfO+p/uXz+d/aSz4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-MxTAxiTuNFuT9fA5K4RcUQ-1; Mon,
 23 Jun 2025 05:22:44 -0400
X-MC-Unique: MxTAxiTuNFuT9fA5K4RcUQ-1
X-Mimecast-MFC-AGG-ID: MxTAxiTuNFuT9fA5K4RcUQ_1750670562
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09919189C322; Mon, 23 Jun 2025 09:22:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E1E51956066; Mon, 23 Jun 2025 09:22:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D0C921E6A27; Mon, 23 Jun 2025 11:22:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>,  thuth@redhat.com,
 richard.henderson@linaro.org,  david@redhat.com,  pbonzini@redhat.com,
 walling@linux.ibm.com,  jjherne@linux.ibm.com,  jrossi@linux.ibm.com,
 pasic@linux.ibm.com,  borntraeger@linux.ibm.com,  farman@linux.ibm.com,
 iii@linux.ibm.com,  eblake@redhat.com,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 02/28] crypto/x509-utils: Add helper functions for
 certificate store
In-Reply-To: <aFkJszNVDFYwHDSU@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 23 Jun 2025 09:00:51 +0100")
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-3-zycai@linux.ibm.com>
 <87sejyskgj.fsf@pond.sub.org>
 <41e788ad-77e2-46d2-a384-2c8f524391c2@linux.ibm.com>
 <87wm99r3rh.fsf@pond.sub.org>
 <935581ef-1cb2-4e2f-9c3f-23203b556ca8@linux.ibm.com>
 <87ikkndlvv.fsf@pond.sub.org> <aFkJszNVDFYwHDSU@redhat.com>
Date: Mon, 23 Jun 2025 11:22:31 +0200
Message-ID: <87pleulsmg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jun 23, 2025 at 08:15:16AM +0200, Markus Armbruster wrote:

[...]

>> Use plain C enums when practical.
>>=20
>> Reasons for making a type a QAPI type include:
>>=20
>> * Some QAPI command or event needs it.
>>=20
>> * Something (typically QOM property accessors) needs the generated
>>   visitor.
>>=20
>> * For enums: something could use the generated QEnumLookup / ENUM_str()
>>   macro.
>
> Any time a method only accepts a subset of enum values, and needs to repo=
rt
> an error message, it should always use ENUM_str in the error message, rat=
her
> than the raw int value, to make the error message human friendly and inva=
riant
> to enum ordering.  IOW, ENUM_str should be relatively frequently used/nee=
ded.

Unless the enum exists at the user interface, such an error message is
almost certainly sub-par.


