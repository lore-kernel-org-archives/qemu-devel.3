Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2C4CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcMg-0001nR-60; Tue, 28 Oct 2025 01:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDcMd-0001ma-SG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDcMX-0000zN-B9
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761629715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zJ7T3RKNfHufyXopZ2Sxa0jpKLqQ1SrDFQNYVVEtFY4=;
 b=Pkq7NrKmVUbL05w1wHGR276zHShW+Oc6b4hsxNb+BGfl7LbzKNmWG531IJCnuywRAc886b
 +TWLQCGKIqGjd0jOEyT6U0YuZwxobSylUsaYeq11KopK8OlaWp3/wP49oVAQZm3Jn4BvgG
 Lz7WCIDbkD4n5nk1WD2Nh1YGgm2K4Ic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-XPD8MZItM7Sl49YjKnQrag-1; Tue,
 28 Oct 2025 01:35:09 -0400
X-MC-Unique: XPD8MZItM7Sl49YjKnQrag-1
X-Mimecast-MFC-AGG-ID: XPD8MZItM7Sl49YjKnQrag_1761629708
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81524180A222; Tue, 28 Oct 2025 05:35:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D639D18004D4; Tue, 28 Oct 2025 05:35:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2538C21E6A27; Tue, 28 Oct 2025 06:35:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: eric.auger@redhat.com,  Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,  nicolinc@nvidia.com,  nathanc@nvidia.com,
 mochs@nvidia.com,  jonathan.cameron@huawei.com
Subject: Re: [PATCH v2] docs/system/arm/virt: Document user-creatable SMMUv3
In-Reply-To: <5e897607-2c33-46f2-b2ab-579a2f4b6385@redhat.com> (Donald
 Dutile's message of "Mon, 27 Oct 2025 22:13:11 -0400")
References: <20251024084350.252702-1-skolothumtho@nvidia.com>
 <CAFEAcA8SAQO0frmN-rK6zp_-fEGXLefAXAxHmT=LASqEL-UU5g@mail.gmail.com>
 <c21641fd-1a35-4b47-a361-bfc2daf7dbd7@redhat.com>
 <5e897607-2c33-46f2-b2ab-579a2f4b6385@redhat.com>
Date: Tue, 28 Oct 2025 06:35:04 +0100
Message-ID: <87v7jzk2rb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Donald Dutile <ddutile@redhat.com> writes:

> On 10/27/25 10:13 AM, Eric Auger wrote:

[...]

>> Looks good to me as well
>> Fell free to add my R-b
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Thanks!
>> Eric
>> 
> +1; looks good; can add my r-b if another is desired/needed.
> - Don

When you put in the review work, claim the review credit!  Suggest you
spell out your R-by.


