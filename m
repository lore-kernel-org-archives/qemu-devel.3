Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5114EB1052
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzvds-0005FG-Nj; Tue, 10 Mar 2026 07:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzvdj-0005Ed-I4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzvdh-0001h1-NR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773143560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z1wZhdknnAMZbqWthtVmRMki4CyPmY1HK5asoqlizIY=;
 b=S55KSdYwqtulpwHC/+sdXDLZt6jOdt4Mu8/C7js6uXbO7yac9ff0+oFdUBsKuqszi7EhSQ
 xCOlcOtZ+c+fvSpvwm2HkQHRuZFHF6cQCkK41j22+sxQGHw8tFGrwb5gb5eGgJbdvDPd1W
 RZloqJMyLY3pm+bTPq/3nlepPL5ZGuc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-7L_1kw3YNtKPbAXFDrDNAA-1; Tue,
 10 Mar 2026 07:52:39 -0400
X-MC-Unique: 7L_1kw3YNtKPbAXFDrDNAA-1
X-Mimecast-MFC-AGG-ID: 7L_1kw3YNtKPbAXFDrDNAA_1773143558
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0644F18005B4; Tue, 10 Mar 2026 11:52:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1C2619560A6; Tue, 10 Mar 2026 11:52:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 185F721E681B; Tue, 10 Mar 2026 12:52:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alessandro
 Ratti <alessandro@0x65c.net>,  alessandro.ratti@gmail.com,
 alex.bennee@linaro.org,  mst@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3] virtio: improve virtqueue mapping error messages
In-Reply-To: <CAFEAcA85zD1d=4xkXKFyefYjsj14DqpBDXrPbtfSfa0ry8raKw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 10 Mar 2026 11:09:01 +0000")
References: <aNLIHOwcGB47qbUY@redhat.com>
 <20250924093138.559872-1-alessandro@0x65c.net>
 <20250924093138.559872-2-alessandro@0x65c.net>
 <aNO7J7Y6wsk1-wyw@redhat.com>
 <CAFEAcA9oKbFi7hBvKcz_v_xWtHaPz4n3Q_cVEai1F1kZnr5PiA@mail.gmail.com>
 <87a4wgc5gh.fsf@pond.sub.org>
 <CAFEAcA85zD1d=4xkXKFyefYjsj14DqpBDXrPbtfSfa0ry8raKw@mail.gmail.com>
Date: Tue, 10 Mar 2026 12:52:35 +0100
Message-ID: <874imnc35o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 10 Mar 2026 at 11:03, Markus Armbruster <armbru@redhat.com> wrote:
>> Neither function is ideal.  But in their current state, I *strongly*
>> prefer qdev_get_human_name(), because I hate having to decipher a QOM
>> path less than having to guess what kind of device this might be, then
>> figure out what format its .get_dev_path() uses.
>>
>> If someone posts a patch to fix the shortcomings of
>> qdev_get_printable_name() I outlined above, we can talk.
>
> How do you feel about the proposed unification of the two
> functions done in this patch?
>
> https://lore.kernel.org/qemu-devel/20260308160040.354186-2-alessandro@0x65c.net/

Thanks for the pointer, I'll reply there.


