Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E9D2C549
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3EHZ-00010u-EL; Tue, 22 Oct 2024 08:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t3EHM-0000z5-Em
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t3EHG-0002XQ-UM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729601180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WksX4dUUQlL2DwwITWesbO6ox1MaaXAPmQQ4CE7uCXY=;
 b=HjfSkT7vLPELOVBqV06sEt1uaLxH5upGuiKFrtdAPFB715zD4MOwUClyM+4LgyPF88biRW
 KjVjqcYTfDCEZoK0h17xwWhNz4eVrwuZHkXvzCjPlk/VLdzgPWhuJxeWTIGlb6E7GrwaZz
 1DUh14OBuAj+FORb2glV/5tqNCXBWM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-OamtNeZJONKoEqTuX5qblA-1; Tue, 22 Oct 2024 08:46:19 -0400
X-MC-Unique: OamtNeZJONKoEqTuX5qblA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43159c07193so50167245e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 05:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729601178; x=1730205978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WksX4dUUQlL2DwwITWesbO6ox1MaaXAPmQQ4CE7uCXY=;
 b=Ch1JdT1ICYfiioT+3hOEx/PJ3tZ274OHLb7rcwCvoGNzY6ARUczQzHAMMwZcWkDxBE
 jJtzqCFlnlw/MT95zh6IrR0gfrTiCsxdmD/+iRaKExHPm5N2d5crXjpIcUmNShnqal0Q
 9Jnc+t/7EGJVXTTdf70zoil+cksFXKi5b38LhMhoYUXHl5EsYO/p6j9OA1KNVGY0hyKk
 YV0FmwcysM/rRJhFkbgtW/mN6HGi8Ps4N4SYs01yT1AcUJ7CB/pL7pwErgyPw1O6ODgZ
 Upnd1R6UFlWJrk4g7QEiEpsPmIw/2mGuyt/Yyti/4ScVcpcvSl8c0kTLO89sDowWCrVI
 iMIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+3XzqfulY63sUu4gjkfPnGp6Uxk+jcQ1npx+Px1q08bCW+v4q5jE92LJ8OwUwYEcHST9YJOxk8icq@nongnu.org
X-Gm-Message-State: AOJu0YxLtwesy1vmLWk50h1PB7C9HUtIxj5iDwECDf3+w1kWzMTKigAR
 plAWe16JNiYjfsFwcxj4iGzvYgJnunPWw2iXoWF5/SzOK9VqYbBLoWEFtdoX/iUjftjfyMYAMPn
 q9JttsGawMJYfOn2gd4iiS33XQUbq1KRxXoKJ5xPW2K+zIgUqP3bH
X-Received: by 2002:a05:600c:3151:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-43161685fedmr167576675e9.24.1729601177965; 
 Tue, 22 Oct 2024 05:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu3ajiF5M16Osq3j2SNaPDaa27FJhGXWYrCMfGA8nBFi6JFO0n2E5H1Rf9k+T1nXHGTsgHcg==
X-Received: by 2002:a05:600c:3151:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-43161685fedmr167576345e9.24.1729601177436; 
 Tue, 22 Oct 2024 05:46:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57ff39sm88504785e9.19.2024.10.22.05.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:46:16 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:46:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, vchundur@redhat.com,
 rjarry@redhat.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZxJbtkMO1QcoiqVn@redhat.com>
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 18 Oct 2024 13:59:34 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Oct 18, 2024 at 02:25:26PM +0200, Igor Mammedov wrote:
> > On Wed, 16 Oct 2024 14:56:39 +0200
> > "Anthony Harivel" <aharivel@redhat.com> wrote:
[...]

> >=20
> > This also leads to a question, if we should account for
> > not VCPU threads at all. Looking at real hardware, those
> > MSRs return power usage of CPUs only, and they do not
> > return consumption from auxiliary system components
> > (io/memory/...). One can consider non VCPU threads in QEMU
> > as auxiliary components, so we probably should not to
> > account for them at all when modeling the same hw feature.
> > (aka be consistent with what real hw does). =20
>=20
> I understand your POV, but I think that would be a mistake,
> and would undermine the usefulness of the feature.
>=20
> The deployment model has a cluster of hosts and guests, all
> belonging to the same user. The user goal is to measure host
> power consumption imposed by the guest, and dynamically adjust
> guest workloads in order to minimize power consumption of the
> host.

For cloud use-case, host side is likely in a better position
to accomplish the task of saving power by migrating VM to
another socket/host to compact idle load. (I've found at least 1
kubernetis tool[1], which does energy monitoring). Perhaps there
are schedulers out there that do that using its data.

> The guest workloads can impose non-negligble power consumption
> loads on non-vCPU threads in QEMU. Without that accounted for,
> any adjustments will be working from (sometimes very) inaccurate
> data.

Perhaps adding one or several energy sensors (ex: some i2c ones),
would let us provide auxiliary threads consumption to guest, and
even make it more granular if necessary (incl. vhost user/out of
process device models or pass-through devices if they have PMU).
It would be better than further muddling vCPUs consumption
estimates with something that doesn't belong there.

> IOW, I think it is right to include non-vCPU threads usage in
> the reported info, as it is still fundamentally part of the
> load that the guest imposes on host pCPUs it is permitted to
> run on.


=46rom what I've read, process energy usage done via RAPL is not
exactly accurate. But there are monitoring tools out there that
use RAPL and other sources to make energy consumption monitoring
more reliable.

Reinventing that wheel and pulling all of the nuances of process
power monitoring inside of QEMU process, needlessly complicates it.
Maybe we should reuse one of existing tools and channel its data
through appropriate QEMU channels (RAPL/emulated PMU counters/...).

Implementing RAPL in pure form though looks fine to me,
so the same tools could use it the same way as on the host
if needed without VM specific quirks.

1) https://github.com/sustainable-computing-io/kepler

> With regards,
> Daniel


