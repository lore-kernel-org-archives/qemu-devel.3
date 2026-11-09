Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E0606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fIGzMVgC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQCQ-00015O-Iv; Mon, 09 Nov 2026 09:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQQCH-000134-Ut
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:18:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQQCF-000280-8A
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794233884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJJq7R86vXkP0TX1mEDDrCe3hS00ZcKQt/SgqJcMIuE=;
 b=fIGzMVgC2chkcyodtHc/Q7iekEbs4/5/w6Rp+Lb5l2wiGWoD/h7W05l/MLseZw7BZiEydO
 KXh8H6v2weKS2ibJ8K1WxUHZ6xTPk1yR77yCul83ubYVnOhlFBqb4BVdfNpCUhIRS78a6w
 n5mixYoU8hPp6D/23SfBLPeMXd9FwxA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-A7heg-ZEM16Xd1X0DOxXrA-1; Mon,
 09 Nov 2026 09:18:01 -0500
X-MC-Unique: A7heg-ZEM16Xd1X0DOxXrA-1
X-Mimecast-MFC-AGG-ID: A7heg-ZEM16Xd1X0DOxXrA_1794233879
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82BC51800557; Mon,  9 Nov 2026 14:17:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC3A930001A2; Mon,  9 Nov 2026 14:17:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47C3521E6A04; Mon, 09 Nov 2026 15:17:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,  qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com,  milesg@linux.ibm.com,  qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 4/8] hw/gpio/pca9554: New abstract base "pca9554-base"
In-Reply-To: <280ce4a2-5902-5268-71cd-40e44a0e2e73@eik.bme.hu> (BALATON
 Zoltan's message of "Mon, 9 Nov 2026 14:52:59 +0100 (CET)")
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-5-armbru@redhat.com>
 <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com>
 <87ld725mkm.fsf@pond.sub.org>
 <280ce4a2-5902-5268-71cd-40e44a0e2e73@eik.bme.hu>
Date: Mon, 09 Nov 2026 15:17:56 +0100
Message-ID: <871p8u3x7v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 9 Nov 2026, Markus Armbruster wrote:
>> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
>>
>>> On 06/11/2026 11:04, Markus Armbruster wrote:
>>>
>>>> Commit 5eceb48bbe86 (hw/gpio: pca9554: add PCA9536 support) made type
>>>> "pca9535" a child of concrete type "pca9555".  This is inconvenient
>>>> for the next commit.  Make them both children of new abstract type
>>>> "pca9554-base".
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

[...]

>>> The basic change looks good to me, however I found it tricky to follow
>>> given that PCA9554Class is now related to PCA9554_BASE_CLASS() and
>>> PCA9554State is now related to PCA9554_BASE().
>>>
>>> Would it make sense to rename PCA9554Class to PCA9554BaseClass and
>>> PCA9554State to PCA9554BaseState here? I think it would help make the
>>> hierarchy easier to follow.
>>
>> I considered it when I wrote this patch, then decided not to, to
>> minimize churn and keep the identifiers short.  I'm fine either way.
>
> How about calling the base class PCA95xx or similar to keep it both short and show it belongs to both child classes?

Existing types in this area:

* Abstract "pca955x" with concrete subtypes "pca9552", "pca9535",
  "pca9555".

* Abstract type whose name we're debating with concrete subtypes
  "pca9554" and "pca9536".

I fear naming it "pca95xx" would be confusing.


