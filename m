Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BBBC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4y2s-00004t-Fp; Wed, 16 Apr 2025 04:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u4xxW-0002aq-T6
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 04:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u4xxU-00060d-4s
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 04:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744791439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+prEyTRWGZcBrE/AIyoW4nEtdjv1GtfBf5zu6/qquhE=;
 b=gRE1aTffVbp9f/QYuauyLmvYwC5w4kghfZqKmmfTB9PI/skm3XcSvY44Jmr59kmGE0UnOc
 tsiJhkTl7xFxNN6SZskLTSCOKAoxdNm13IGbNwrxLOC/m9clxjXhMQk7IPRhKX5PuA7yck
 ulQAx6VSESSehAi19Lx7L2s2HfovyAM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-QmzrYM3kNo6d5vwj2mc6gQ-1; Wed,
 16 Apr 2025 04:17:14 -0400
X-MC-Unique: QmzrYM3kNo6d5vwj2mc6gQ-1
X-Mimecast-MFC-AGG-ID: QmzrYM3kNo6d5vwj2mc6gQ_1744791433
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AD2A1800570; Wed, 16 Apr 2025 08:17:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E5141800367; Wed, 16 Apr 2025 08:17:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D569121E66C3; Wed, 16 Apr 2025 10:17:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric
 Auger <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
In-Reply-To: <Z/i3+l3uQ3dTjnHT@intel.com> (Zhao Liu's message of "Fri, 11 Apr
 2025 14:34:34 +0800")
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
 <878qo8yu5u.fsf@pond.sub.org> <Z/iUiEXZj52CbduB@intel.com>
 <87frifxqgk.fsf@pond.sub.org> <Z/i3+l3uQ3dTjnHT@intel.com>
Date: Wed, 16 Apr 2025 10:17:08 +0200
Message-ID: <87fri8o70b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> On Fri, Apr 11, 2025 at 06:38:35AM +0200, Markus Armbruster wrote:
>> Date: Fri, 11 Apr 2025 06:38:35 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
>>=20
>> Zhao Liu <zhao1.liu@intel.com> writes:
>>=20
>> > Hi Markus
>> >
>> > On Thu, Apr 10, 2025 at 04:21:01PM +0200, Markus Armbruster wrote:
>> >> Date: Thu, 10 Apr 2025 16:21:01 +0200
>> >> From: Markus Armbruster <armbru@redhat.com>
>> >> Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
>> >>=20
>> >> Zhao Liu <zhao1.liu@intel.com> writes:
>> >>=20
>> >> > Introduce the kvm-pmu-filter object and support the PMU event with =
raw
>> >> > format.
>> >>=20
>> >> Remind me, what does the kvm-pmu-filter object do, and why would we
>> >> want to use it?
>> >
>> > KVM PMU filter allows user space to set PMU event whitelist / blacklist
>> > for Guest. Both ARM and x86's KVMs accept a list of PMU events, and x86
>> > also accpets other formats & fixed counter field.
>>=20
>> But what does the system *do* with these event lists?
>
> This is for security purposes, and can restrict Guest users from
> accessing certain sensitive hardware information on the Host via perf or
> PMU counter.
>
> When a PMU event is blocked by KVM, Guest users can't get the
> corresponding event count via perf/PMU counter.
>
> EMM, if =E2=80=98system=E2=80=99 refers to the QEMU part, then QEMU is re=
sponsible
> for checking the format and passing the list to KVM.
>
> Thanks,
> Zhao

This helped some, thanks.  To make sure I got it:

KVM can restrict the guest's access to the PMU.  This is either a
whitelist (guest can access exactly what's on this list), or a blacklist
(guest can access exactly what's not this list).

QEMU's kvm-pmu-filter object provides an interface to this KVM feature.

KVM takes "raw" list entries: an entry is a number, and the number's
meaning depends on the architecture.  The kvm-pmu-filter object can take
such entries, and passes them to straight to KVM.

On x86, we commonly use two slightly higher level formats: select &
umask, and masked.  The kvm-pmu-filter object can take entries in either
format, and maps them to "raw".

Correct?


