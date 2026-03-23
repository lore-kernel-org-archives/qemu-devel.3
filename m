Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A2CF46139
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4hLY-0001ml-VE; Mon, 23 Mar 2026 11:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4hLW-0001mY-P3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4hLU-0004k0-Pz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774280254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1+kb50vlbRyclo23V2H0nq9MyEDP7+agIC4NW2QiPM=;
 b=Z690Yho31+RG+s/6O1H4M81Me7ppYDMqFUVeyTvksrJgJEaTcLXyQvgYaV+6ymCrfzeE+Z
 PA6UzcLIm0HwgdjOnM8p4ovBjQAHIXRSJ8iKhwkzr2LakEmu9ihGJRWbt9uLbsIuIspTSp
 wiMROSQ5MO2gEquP2w4en1kNA+muz6A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-iJaAgp-rMjmlMcaj5GCayQ-1; Mon,
 23 Mar 2026 11:37:30 -0400
X-MC-Unique: iJaAgp-rMjmlMcaj5GCayQ-1
X-Mimecast-MFC-AGG-ID: iJaAgp-rMjmlMcaj5GCayQ_1774280248
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F02F218002EF; Mon, 23 Mar 2026 15:37:27 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.184])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CA7319560B7; Mon, 23 Mar 2026 15:37:22 +0000 (UTC)
Date: Mon, 23 Mar 2026 16:37:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <acFeMO4CX6iqikZL@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <877bricy97.fsf@pond.sub.org> <abFqwbCCf7rNDEWs@redhat.com>
 <87tsufpyo5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsufpyo5.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 16.03.2026 um 16:43 hat Markus Armbruster geschrieben:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> > For -object / object_add  we introduced formal QAPI modelling of
> > all Object subclasses which implement the UserCreatable interface.
> > IIUC, that gives us the desired separation between internal and
> > external views, as only properties declared in qapi/qom.json are
> > publically settable.
> 
> Correct.  Kevin Wolf's work.
> 
> > This work did not apply to the Device classes because the historical
> > baggage with qdev being grafted onto qom, means we don't have that
> > working via the UserCreatable inteface or -object/object_add.
> >
> > Can we bring Device into the same world though ?
> 
> Kevin Wolf took a stab at it.  I had a hard time understanding it back
> then.  Various pennies finally dropped when he patiently explained it to
> me in person.  I disliked certain aspects of its design, and wanted to
> explore a bit more.  Never found the time.  Perhaps we should just take
> it despite my design misgivings.
> 
> > Adding 1000 device types to QAPI is a huge job, so it would need to
> > be a long incremental job, unless perhaps we auto-generate QAPI
> > descriptions for everything that already exists ?

Doing things incrementally was my idea when I did the patch series to
prepare it (which really only completed the converstion for -object,
getting rid of some of the duplication between QOM and QAPI definitions
that we currently have - but the same things would probably also be the
prerequisite for starting to convert devices).

Even if you could automate the conversion, doing thousands of devices
with different maintainers in a single series seems completely
unmanageable.

> Interesting idea.
> 
> QAPI is declarative: types and their properties are declared in a
> schema.
> 
> QOM is imperative: we execute C code to create types and their
> properties.
> 
> Extracting a QAPI schema from the C code is impossible in the completely
> general case (halting problem), and merely impractical (I believe) in
> the special cases we have.
> 
> We could start with QOM introspection instead: qom-list-types and
> qom-list-properties.  These are only mostly complete, but should be good
> enough.
> 
> Mapping QOM types to QAPI types would involve guesswork, because QOM
> doesn't have a type system, it has strings and bailing wire.

QOM itself is typed, only the QemuOpts it normally takes as input isn't.
You just have to find the right visitor call in the code and then you
can pretty much copy the type into the QAPI schema (sometimes it's more
complex than that because visitor calls are made conditionally or in a
loop or whatever, but it's not guesswork anyway).

> Schema documentation would be placeholders at best.  We could try to
> extract documentation from -device T,help.  Most properties have
> nothing there, and the remainder likely needs to be rewritten
> completely to be fit for purpose.

FWIW, writing documentation was the real work in converting -object.
Automating everything else can possibly be a minor convenience
improvement, but in comparison to documenting stuff it's trivial enough
anyway.

> > More generally anything we can do to bring qdev & qom closer together
> > feels desirable. I dream of a future where -device/device_add are
> > obsolete....
> 
> That would be lovely.

If you decide to finally stop blocking it, let me know. Maybe I can find
some time to resurrect something, though having to rebase after four(?)
years doesn't sound like fun.

Kevin


