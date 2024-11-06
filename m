Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FDFD29FB1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 07:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8aen-0000mY-Lk; Wed, 06 Nov 2024 02:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chorn@redhat.com>) id 1t8WWB-000125-KY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 22:15:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chorn@redhat.com>) id 1t8WW8-0001UW-Bu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 22:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730862934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/KipcbBRT4XOBxzAS4ftSgnTLWDa+d9I1ht3Jhr9NY=;
 b=ZoVwKLr/ecmysQXx8jGLbnHxPiVG0/RVrqTvAJwlrTMpcwspfqUZxBjaHTFHYiibd0lNGh
 2c0cU4DFufLwGcsAnD59ltPxzSK4fg7qKMFhDm+vV8jgjkXFH12dO8n86brkXgE7ro3jjZ
 2laT1EWabg/1hP4UEKbA5Fz/78URsLA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-uGHUeRyhMniJbzfGqJgG_w-1; Tue,
 05 Nov 2024 22:14:20 -0500
X-MC-Unique: uGHUeRyhMniJbzfGqJgG_w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 351081956046; Wed,  6 Nov 2024 03:14:19 +0000 (UTC)
Received: from localhost (unknown [10.64.240.58])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFF19300018D; Wed,  6 Nov 2024 03:14:16 +0000 (UTC)
Date: Wed, 6 Nov 2024 12:14:14 +0900
From: Christian Horn <chorn@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com, rjarry@redhat.com, nathans@redhat.com,
 kenj@kenj.id.au, sunyanan.choochotkaew1@ibm.com, vibhu.sharma2929@gmail.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <ZyrfBnnFpTbKTubw@asahi.local>
References: <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
 <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
 <ZxelgDeuZaia-Vqf@redhat.com>
 <D52ED9BSZU9P.32LYD3328YTTN@redhat.com>
 <20241101160934.42d46c9f@imammedo.users.ipa.redhat.com>
 <D5BL7KCTSON6.36X2ZEWWQUIQ1@redhat.com>
 <20241104104900.1a2a0193@imammedo.users.ipa.redhat.com>
 <ZynFEr2vSeApNGG-@fluxcoil.net>
 <20241105131927.5a038d3f@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241105131927.5a038d3f@imammedo.users.ipa.redhat.com>
X-Organization: Red Hat K.K.
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=chorn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Nov 2024 02:40:42 -0500
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

* Igor Mammedov =E3=81=95=E3=82=93=E3=81=8C=E6=9B=B8=E3=81=8D=E3=81=BE=E3=
=81=97=E3=81=9F:
> On Tue, 5 Nov 2024 08:11:14 +0100
> Christian Horn <chorn@fluxcoil.net> wrote:
>=20
> > - For reading the metrics in the guest, I was tempted to suggest PCP wi=
th
> >   pmda-denki to cover RAPL, but it's right now just reading /sysfs, not
> >   MSR's.  pmda-lmsensors for further sensors offered on various systems,
> For NVF usecase, I also was eyeing pmda-denki.
>=20
> How hard it would be to add MSR based sampling to denki?
> Can we borrow Anthony's MSR sampling from
> qemu-vmsr-helper, to reduce amount of work needed.

Should be possible.  Also for /sysfs we do a detection of domains, and
based on that register metrics and instances with pmcd.  For rapl-msr,
that could be done in a similiar way, i.e. as denki.rapl-msr,
or separating into denki.rapl.sysfs and denki.rapl.msr .

As for the actual doing, I'm not part of the engineering org but
support, so it's a spare time activity, when I get to it.  PCP
engineering has people on the project, a Jira would be a first step.
Direct pull requests to upstream are also a good start of course.  When
developing that, one would in cycles modify src/pmdas/denki/denki.c,
compile it, get pmcd to use the modified pmda-denki, look at debug
output and metrics.


> Also, for guest per vCPU accounting, we would need per thread
> accounting (which I haven't noticed from a quick look at denki).
> So some effort would be needed to add it there. =20

I think we have these metrics in pmcd already from pmda-linux, i.e. we
can see them with this:
# pmrep -1gU -t 5 -J 3 proc.hog.cpu [..]
[ 1] - proc.hog.cpu["083377 /usr/lib64/firefox/firefox"]
[ 2] - proc.hog.cpu["084634 /usr/lib64/firefox/firefox"]
[ 3] - proc.hog.cpu["085225 md5sum"]
         1         2         3
     0.001     0.003    16.304
=3D> Top 3 consumers, process 3 is heaviest.
This uses derived metrics, computes from others, defined here:
$ cat /etc/pcp/derived/proc.conf
[..]
proc.hog.cpu =3D 100 * (rate(proc.psinfo.utime) + rate(proc.psinfo.stime)) =
/ (kernel.all.uptime - proc.psinfo.start_time)
proc.hog.cpu(oneline) =3D average percentage CPU utilization of each process
[..]

I was brainstorming with Nathan about this in the past, but we did
not quickly get to something and lost track. =20
Following the PCP approach, a client would query the required metrics
=66rom pmcd (i.e. "process md5sum is right now using most cpu cycles"),
and together with "the overall VM or bare-metal-system consumes right
now 100W", one could attribute.  We might get away with derived=20
metrics as per above.  If the computation is not doable with that, we
might also use own client code (i.e. C, or python) which gets the
metrics and computes the accounting per thread.
Last resort would be to collect the required process metrics in=20
pmda-denki for computation there.

We might want to take this one out and discuss on PCP upstream,
i.e. pcp@groups.io .


> I didn't know about pmda-lmsensors, I guess we should be able to use
> it out of box with 'acpi power meter' sensor, if QEMU were to provide suc=
h.
> I've also seen denki supporting battery power sensor, we can abuse that
> and make QEMU provide that, but I'd rather add 'acpi power meter' sensor
> to denki (which to some degree intersects with battery power sensor
> functionality).

On this aarch64/Asahi macbook here, recent kernels made=20
/sys/class/hwmon/hwmon1 available, and 'sensors' offers:
[chris@asahi sensors]$ sensors
[..]
Total System Power:       7.71 W
AC Input Power:           9.99 W
3.8 V Rail Power:         0.00 W
Heatpipe Power:           2.46 W
[..]

I'm still wondering how these fit into a picture like this one:
https://htmlpreview.github.io/?https://github.com/christianhorn/smallhelper=
s/blob/main/pmda-denki-handbook/denki.html#_hardware_requirements_new_versi=
on
So with these also overall system consumption is available while AC
powered - of course, just that hardware right now.

> PS:
> In this series Anthony uses custom protocol to get data from
> privileged MSR helper to QEMU. Would it be acceptable?

The only request would be that implementing that is "an optional ontop
source", so not preventing MSR access from bare metal hosts not having
it.  I guess that's given.  So then it's an abstracted channel we
provide into the guest.

> Or is there a preferred way for PCP to do inter-process comms?

Hm.. I thought this was here used to communicate between host and guest?

On the good side, if we get the per-thread-attribution done, we can
illustrate attribution up into guests with what mermaid calls sankey:
https://mermaid.js.org/syntax/sankey.html  :)

cheers,
--=20
Christian Horn
AMC Technical Account Manager, Red Hat K.K.
pgp fprint ADA6 C79C AF2E 973E 3F70  73C5 9373 49E7 347B 904F


