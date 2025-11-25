Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B46FD0EE04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvcI-0003it-DI; Tue, 25 Nov 2025 11:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vNvcB-0003gb-3Q
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:10:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vNvc3-0003zQ-PY
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764086990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wTIv6dREnPMvXS5uJbknCLqCPpIYBaF9/FWh3NHuOks=;
 b=XLZAqGuBFnCqzjp/XSWnMWmwe8Sukt+4Sd2c/NuF6fJvam61Bopzq3TQTnWDhUlPR1YTmb
 CzkHtjhMopgjxM5MatESykcizVqO55Vhp6U5cg6r3JFrnRm03w6VBA02YaNBWB7qSSCdlD
 GPcu2kFSpEJAhIKywt7ZOqP32Uv4yAM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-EO9jCkBeOlq1IirmuN3SWw-1; Tue,
 25 Nov 2025 11:09:46 -0500
X-MC-Unique: EO9jCkBeOlq1IirmuN3SWw-1
X-Mimecast-MFC-AGG-ID: EO9jCkBeOlq1IirmuN3SWw_1764086984
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C10419560B1; Tue, 25 Nov 2025 16:09:44 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A71F1956056; Tue, 25 Nov 2025 16:09:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Eric Auger
 <eric.auger@redhat.com>
Subject: Re: [PATCH for-11.0] arm: add DCZID_EL0 to idregs array
In-Reply-To: <CAFEAcA8r7_6fbEFtkEL4vi-wqABewcPU3P73RWh08RRQnQ5Baw@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251119134414.2892640-1-cohuck@redhat.com>
 <CAFEAcA8r7_6fbEFtkEL4vi-wqABewcPU3P73RWh08RRQnQ5Baw@mail.gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 25 Nov 2025 17:09:41 +0100
Message-ID: <87see2ozzu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 24 2025, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 19 Nov 2025 at 13:44, Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> This requires a bit of care, since we still have to handle the EL
>> specific part (DCZID_EL0.DZP). Callers can set/access dcz_blocksize
>> via a wrapper working on DCZID_EL.BS.
>>
>> KVM currently does not support DCZID_EL0 via ONE_REG, and actually
>> does not need to work with it, so provide a dummy value for now.
>
> That seems like an odd (unintended?) omission -- is it worth
> adding? (We would need to handle older kernels that don't
> expose it anyway, of course.)

I'm not sure whether there's actually a usecase for KVM exposing this to
the VMM - AFAICS, KVM doesn't do anything special for DC ZVA and
friends, and doesn't tweak HCR_EL2.TDZ which would change behaviour.


