Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5C0C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 06:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thk9I-0007et-Kk; Tue, 11 Feb 2025 01:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thk9F-0007ej-Pd
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 01:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thk9C-0001kq-TD
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 01:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739256809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElnDZtjk16aFM+dw0Xc1cVCU86AqETu4dLsR6gwKCJw=;
 b=H6Chl3OK+twwnNGBUTgFRoEst+mW+91Q1PiMTNlpRN2VNcYn14CQY4juYEuLUk8cs61NqO
 AaDNKthRusbo6+j5yFS7A6Ib8qE2rQJK0AK2mNoYx+ug+TpbjSrOb1zUkiTG8k14rXeARQ
 JMrcVR1dWGQLSPYOFc0ZEl7+p4FavKE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-LdU9yH8aPb-Vu0HajmvlhA-1; Tue,
 11 Feb 2025 01:53:25 -0500
X-MC-Unique: LdU9yH8aPb-Vu0HajmvlhA-1
X-Mimecast-MFC-AGG-ID: LdU9yH8aPb-Vu0HajmvlhA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5747E1800878
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 06:53:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E8B419560A3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 06:53:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4CDD021E6A28; Tue, 11 Feb 2025 07:53:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 1/7] util/error: Introduce warn_report_err_once()
In-Reply-To: <c7ce5f30-ee52-46c8-b968-08ba01214a3e@redhat.com>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Mon, 10 Feb 2025 17:26:48 +0100")
References: <20250206131438.1505542-1-clg@redhat.com>
 <20250206131438.1505542-2-clg@redhat.com>
 <c7ce5f30-ee52-46c8-b968-08ba01214a3e@redhat.com>
Date: Tue, 11 Feb 2025 07:53:21 +0100
Message-ID: <87pljpyntq.fsf@pond.sub.org>
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
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 2/6/25 14:14, C=C3=A9dric Le Goater wrote:
>> Depending on the configuration of the host and VM, a passthrough
>> device may generate recurring DMA mapping errors at runtime. In such
>> cases, reporting the issue once is sufficient.
>>
>> We have already the warn/error_report_once() routines taking a format
>> and arguments. Using the same design pattern, add a new warning
>> variant taking an 'Error *' parameter.
>>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>> ---
>>   include/qapi/error.h | 12 ++++++++++++
>>   util/error.c         | 11 +++++++++++
>>   2 files changed, 23 insertions(+)
>
> Hello Markus,
>
> Are you ok with this change ? Should we take it through the vfio queue ?

Yes, please.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


