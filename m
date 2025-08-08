Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4300BC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 14:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukOMF-0002qK-RB; Fri, 08 Aug 2025 10:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukOLm-0002Dg-So
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukOLj-00062h-Pp
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754664338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SP/h4Ob0Ps+XHGpdfUUQaMAp347i7H67GY8IGHrCihg=;
 b=DTASiIJFuDibYcZbSzMrOGYNT9U3SS3w/WVhv1G62t7UmL9o8DwCivpZV+FpgmJUSHcTLg
 TK6b4sRcXolUAWZhuhfVUQnf1/c6z9O7n3s2YGngI+sWp76sxlMwGEdwGhrpkAY1mhDq5q
 Xmps7XANm9jdV/aauwZR41TPgnd+r+4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-LOM7i8UdN2Cb03EivVS2Qw-1; Fri,
 08 Aug 2025 10:45:33 -0400
X-MC-Unique: LOM7i8UdN2Cb03EivVS2Qw-1
X-Mimecast-MFC-AGG-ID: LOM7i8UdN2Cb03EivVS2Qw_1754664332
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 234D019560AD; Fri,  8 Aug 2025 14:45:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 864F93001453; Fri,  8 Aug 2025 14:45:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1CBF21E6A27; Fri, 08 Aug 2025 16:45:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 12/12] error: Kill @error_warn
In-Reply-To: <7c4d300a-3f61-42d9-90a9-f0781db024e7@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 Aug 2025 16:02:38
 +0200")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-13-armbru@redhat.com>
 <7c4d300a-3f61-42d9-90a9-f0781db024e7@linaro.org>
Date: Fri, 08 Aug 2025 16:45:28 +0200
Message-ID: <874iuhdg8n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 8/8/25 10:08, Markus Armbruster wrote:
>> We added @error_warn some two years ago in commit 3ffef1a55ca (error:
>> add global &error_warn destination).  It has multiple issues:
>>=20
>> * error.h's big comment was not updated for it.
>>=20
>> * Function contracts were not updated for it.
>>=20
>> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>>    error_prepend() and such.  These crash on @error_warn, as pointed
>>    out by Akihiko Odaki.
>>=20
>> All fixable.  However, after more than two years, we had just of 15
>> uses, of which the last few patches removed eight as unclean or
>> otherwise undesirable.  I didn't look closely enough at the remaining
>> seven to decide whether they are desirable or not.
>
> Is it a call for help? If so, better to split this patch per
> maintained areas, and finally kill @error_warn.

The patch does kill &error_warn.  It's simple and small.  I don't
splitting it makes review any easier.

>> I don't think this feature earns its keep.  Drop it.
>>=20
>> Thanks-to: Akihiko  Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qapi/error.h           |  6 ------
>>   hw/display/virtio-gpu.c        |  8 ++++++--
>>   hw/net/virtio-net.c            |  8 +++++++-
>>   tests/unit/test-error-report.c | 17 -----------------
>>   ui/gtk.c                       |  6 +++++-
>>   util/error.c                   |  5 +----
>>   6 files changed, 19 insertions(+), 31 deletions(-)


