Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E0BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 13:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzcQa-0002C3-6P; Wed, 24 Apr 2024 09:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzcQY-0002Bd-Iw
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzcQW-0003WY-Gd
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713964362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnUi2cVgHWx3MxzJaTxsxopOnKpBzB2N1qs3enmhQg8=;
 b=fqRICaiJ8Xf02A+bXH3tdAr/O/NnVbcdsgwKnZQZhDEen33ActWKd8WtJH1q5GaQnH3LmQ
 c9IQ/dwMnYpROyLcwhV99rDN/5ANRA6gE3NLU53TIq985iUM2eAd+nD1oOolKIbVfVM6mL
 0NgVafdLfLALRrbFxL6bO0fsSeSYaa0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-_flngu1WPLanKjmZSWkVnA-1; Wed, 24 Apr 2024 09:12:36 -0400
X-MC-Unique: _flngu1WPLanKjmZSWkVnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CDA118065AA;
 Wed, 24 Apr 2024 13:12:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69EB840C122D;
 Wed, 24 Apr 2024 13:12:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E46921E66C8; Wed, 24 Apr 2024 15:12:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: fan <nifan.cxl@gmail.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org,  gregory.price@memverge.com,
 ira.weiny@intel.com,  dan.j.williams@intel.com,
 a.manzanares@samsung.com,  dave@stgolabs.net,  nmtadam.samsung@gmail.com,
 jim.harris@samsung.com,  Jorgen.Hansen@wdc.com,  wj28.lee@gmail.com,  Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
In-Reply-To: <ZedTEa8aktb-kKwt@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 5 Mar 2024 17:14:57 +0000")
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-14-nifan.cxl@gmail.com>
 <20240305160908.000010c5@Huawei.com> <ZedFIp5gK4aXsqD-@redhat.com>
 <ZedRsZee2WhTi_Nd@debian> <ZedTEa8aktb-kKwt@redhat.com>
Date: Wed, 24 Apr 2024 15:12:34 +0200
Message-ID: <8734ravr99.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Tue, Mar 05, 2024 at 09:09:05AM -0800, fan wrote:
>> On Tue, Mar 05, 2024 at 04:15:30PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> > On Tue, Mar 05, 2024 at 04:09:08PM +0000, Jonathan Cameron via wrote:
>> > > On Mon,  4 Mar 2024 11:34:08 -0800
>> > > nifan.cxl@gmail.com wrote:
>> > >=20
>> > > > From: Fan Ni <fan.ni@samsung.com>
>> > > >=20
>> > > > With the change, we add the following two QMP interfaces to print =
out
>> > > > extents information in the device,
>> > > > 1. cxl-display-accepted-dc-extents: print out the accepted DC exte=
nts in
>> > > >    the device;
>> > > > 2. cxl-display-pending-to-add-dc-extents: print out the pending-to=
-add
>> > > >    DC extents in the device;
>> > > > The output is appended to a file passed to the command and by defa=
ult
>> > > > it is /tmp/dc-extent.txt.
>> > > Hi Fan,
>> > >=20
>> > > Is there precedence for this sort of logging to a file from a qmp
>> > > command?  I can see something like this being useful.
>> >=20
>> > This is pretty unusual.
>>=20
>> Yeah. I cannot find anything similar in existing code, my initial plan
>> was to print out to the screen directly, however, cannot find out how to
>> do it nicely, so decided to go with a file.=20
>>=20
>> Is there a reason why we do not want to go with this approach?
>>=20
>> >=20
>> > For runtime debugging information our strong preference is to integrate
>> > 'trace' probes throughout the code:
>> >=20
>> >   https://www.qemu.org/docs/master/devel/tracing.html#tracing
>>=20
>> I am not familiar with the trace mechanism. However, I think the
>> approach in this patch may be useful not only for debugging purpose.
>> Although not tried yet, maybe we can also use the approach to set
>> some parameters at runtime like what procfs does?
>
> Please don't invent something new unless you can show why QEMU's existing
> tracing system isn't sufficiently good for the problem. QEMU's tracing
> can dump to the terminal directly, or integrate with a variety of other
> backends, and data can be turned off/on at runtime per-trace point.

Seconded.


