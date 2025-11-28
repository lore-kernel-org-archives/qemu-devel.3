Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B140CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 10:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOvG8-0000Nk-IK; Fri, 28 Nov 2025 04:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOvG5-0000LK-Lz
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:59:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOvG3-000213-JE
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764323955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h87pkFVd+0s7AhEzN3co3SmPiyFvW6/bf3+ECD38zA4=;
 b=PDY9QvgJ8bsC3MypQ+KAocEb1a7dC4FGg7VlRs3IBwqFDou21wnqxg70QjvRPtf1W86Td9
 wGKN+/QXpN0dB8nQC5wobvodtcRtAaiuJmPmQQpCKfek7j1dlpgM7zm6S1pfFgK2DBkYTQ
 vT0J2qcyx74oj98JAeHfZqUc9LVFwtw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-1V1oZ5S_P3a6oDR3KTzKrQ-1; Fri,
 28 Nov 2025 04:59:13 -0500
X-MC-Unique: 1V1oZ5S_P3a6oDR3KTzKrQ-1
X-Mimecast-MFC-AGG-ID: 1V1oZ5S_P3a6oDR3KTzKrQ_1764323952
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EBE219560B3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 09:59:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0803B18002A6
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 09:59:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4603B21E6A27; Fri, 28 Nov 2025 10:59:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com
Subject: Re: [PATCH] scripts/device-crash-test: ERROR_RULE_LIST garbage
 collection
In-Reply-To: <7ba134db-bf51-491b-91a1-588e4495b387@redhat.com> (Thomas Huth's
 message of "Thu, 27 Nov 2025 16:29:07 +0100")
References: <20251127144954.3023865-1-armbru@redhat.com>
 <7ba134db-bf51-491b-91a1-588e4495b387@redhat.com>
Date: Fri, 28 Nov 2025 10:59:09 +0100
Message-ID: <877bva32c2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 27/11/2025 15.49, Markus Armbruster wrote:
>> Device 'nand' was dropped in commit commit e86c1f967a3.
>> Device 'vfio-amd-xgbe' was dropped in commit aeb1a50d4a7.
>> Device 'vfio-calxeda-xgmac' was dropped in commit 8ebc416ac17.
>> The last error messages matching r"images* must be given with the
>> 'pflash' parameter" was dropped in commit a2ccff4d2bc.
>> The error message matching r"Option '-device [\w.,-]+' cannot be
>> handled by this machine" was dropped in commit commit db78a605599.
>> As far as I can tell, we never had message matching r"Ignoring
>> smp_cpus value"
>
> This was a wrapped string, it has been changed in comnit f2ad5140fa521bda30b9c3c3db5b6913f6dda1ae ("hw/arm/exynos: Convert fprintf to qemu_log_mask/error_report") and finally been removed in commit
> 7264961934130df50d151def5eb415efa2e28ec5.
>
>> or r"MSI-X support is mandatory in the S390
>> architecture".
>
> This (split) string still exists in hw/s390x/s390-pci-bus.c:
>
> $ grep -r -A1 MSI-X.support.is.mandatory hw/
> hw/s390x/s390-pci-bus.c:            error_setg(errp, "MSI-X support is mandatory "
> hw/s390x/s390-pci-bus.c-                       "in the S390 architecture");

Watch me fail at grepping.

> So I think we should keep it.

Yes.

v2 coming.  Thanks!


