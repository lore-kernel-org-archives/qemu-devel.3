Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D40FD7878E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAAu-00056m-7r; Thu, 21 Nov 2024 11:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAAq-00056A-BG
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAAm-0004AV-Ci
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732207010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUDhr6WGbhD59rB7ZJpOHtV40J++Ep8jGGZi3tGGH8E=;
 b=cArmz5408mcte0OX6s07+WiXMmlKhtqf0VHdt6YOrs02VfnbQ2ZN2pqUiYvDzEYiMUhLZ1
 phiXsrAveZuLzgj8NgFnH/DQgSU223z9Sng9VyWnZLKslgCDLatWtbDCMBCdL7edaN9je/
 KLH5wPsi8d3UPMtQWhoGId4lul5/jOA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Ix2EX8YJPgqTVW5QxnFq_A-1; Thu, 21 Nov 2024 11:36:49 -0500
X-MC-Unique: Ix2EX8YJPgqTVW5QxnFq_A-1
X-Mimecast-MFC-AGG-ID: Ix2EX8YJPgqTVW5QxnFq_A
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d412384987so44055266d6.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732207008; x=1732811808;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUDhr6WGbhD59rB7ZJpOHtV40J++Ep8jGGZi3tGGH8E=;
 b=mLBh+Ng6NX+V1Nh6yiiZvrRxpx/U0jFjRnPm2QBu9INIl3bf+Sx/ahor3OECLyDqPn
 dei2LSQKIwzR9LAwnKNn1AcALHDzbNfzpeshNZQ0RY7iMlynrzhJ38RgRM8Zmqzhdk2k
 anfsjawWet26YwfksDo3GIdDNSyd5qlU3qfGeC+ee6HvOKePz58lqeJj3ByCOKIPbfKN
 2dcKoCeri0qoUb6w4Tqh+h4qdu3Z5y/wMjqPZH7Clj2HBDNm4C+AA+Yg5HFrhrTSTCKJ
 AdzUowzjCy5x3VCCaJdzInDcCXkN6DXY8hg5DwoF0u20Qqy78KTaf+KfsHzmSannEGAV
 yQUA==
X-Gm-Message-State: AOJu0Yy1gU+zFzJVt7Ot0i5H+6frkZ2AYnZ2fwBc9Rw2EhXgIKgJ/k1L
 peAVl6PnpfgGlo4WONBlqEOFOV6VwyHVsU4uckBkhi0/c3SuOOF7G5G7twzdZr/yyixtiBoQ78A
 LBdGALd4I1qzS7tBo7tiE8d90Ps4+H3fwYAdYNLt0Rg4pP6+1OI1wZhyhI0P9
X-Gm-Gg: ASbGncvUkpbpzRmc00ifqrpROwry3rQYcvDQt2wn7A8toQez+47LiX+va8iWZKp+zBF
 WohjDe6sW3DfO8QAUZNsWL4seuNoM0qhUoibxf7koHW5BjBEsi6PgFWJQ8gkideDCU9GOEyWUW5
 6LiMx4XwGEVDdj3UWTYS/AYnCWMvulqrI5rSM8ISUdaYM6Dl0QvpRwGcaUgBmO/IhucRZq7bvQD
 2T5BVXQg0ZQ281uMOaK4T/MvoA6BIQOKsWOafoG+NpU6aRbysctgQLJS6URDGZxkRNeMA1vEvZM
 OFt2lRWvGo8=
X-Received: by 2002:ad4:5cce:0:b0:6d4:cec:2ffd with SMTP id
 6a1803df08f44-6d4424446a3mr68250596d6.15.1732207008349; 
 Thu, 21 Nov 2024 08:36:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPv2yJv8KWTIrvLqwanMLfRiMyCw5klep5tF1ivGlDUuh7Xykrm04Ryt1g7pXAqOhGeBR9fw==
X-Received: by 2002:ad4:5cce:0:b0:6d4:cec:2ffd with SMTP id
 6a1803df08f44-6d4424446a3mr68250176d6.15.1732207008063; 
 Thu, 21 Nov 2024 08:36:48 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b479d84913sm228631685a.52.2024.11.21.08.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:36:47 -0800 (PST)
Date: Thu, 21 Nov 2024 11:36:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 06/12] hw/ppc: Explicitly create the drc container
Message-ID: <Zz9hnEj3xQnOoM0c@x1n>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-7-peterx@redhat.com>
 <66301003-f2cd-4a0a-8951-cbfdcb1c398b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66301003-f2cd-4a0a-8951-cbfdcb1c398b@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 21, 2024 at 10:35:39AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Peter,
> 
> On 20/11/24 22:56, Peter Xu wrote:
> > QEMU will start to not rely on implicit creations of containers soon.  Make
> > PPC drc devices follow by explicitly create the container whenever a drc
> > device is realized, dropping container_get() calls.
> > 
> > No functional change intended.
> > 
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Cc: qemu-ppc@nongnu.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   hw/ppc/spapr_drc.c | 40 ++++++++++++++++++++++++++++++----------
> >   1 file changed, 30 insertions(+), 10 deletions(-)
> 
> 
> > +static GOnce drc_container_created = G_ONCE_INIT;
> > +
> > +static gpointer drc_container_create(gpointer unused G_GNUC_UNUSED)
> > +{
> > +    container_create(object_get_root(), DRC_CONTAINER_PATH);
> > +    return NULL;
> > +}
> > +
> > +static Object *drc_container_get(void)
> > +{
> > +    return object_resolve_path_component(
> > +        object_get_root(), DRC_CONTAINER_PATH);
> > +}
> > +
> > +/* TODO: create the container in an ppc init function */
> > +static void drc_container_create_once(void)
> > +{
> > +    g_once(&drc_container_created, drc_container_create, NULL);
> > +}
> > +
> >   static void drc_realize(DeviceState *d, Error **errp)
> >   {
> >       SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
> > @@ -521,6 +541,9 @@ static void drc_realize(DeviceState *d, Error **errp)
> >       Object *root_container;
> >       const char *child_name;
> > +    /* Whenever a DRC device is realized, create the container */
> > +    drc_container_create_once();
> 
> Can't we just create it once in spapr_dr_connector_class_init(),
> removing the G_ONCE_INIT need?

IIUC it's a matter of whether there's case where we have this file compiled
in, but never create any DRC device.  When that happens, the patch can
change the QEMU qom-tree slightly, in that there'll be an empty drc
container while we used to not have it.

I'm trying to be on the safe side in case something would detect the
container's existance to know whether drc devices are present.  lazy create
it in realize() is the safest way to behave 100% identical like before,
considering my ppc knowledge is merely zero (even if I have drc tests
covered in ppc64's qtest..).

However I also doubt whether it matters much.  It'll be great if I can get
an ACK from anyone familiar with this device (Phil, are you?), then I can
move it over.

> 
> >       trace_spapr_drc_realize(spapr_drc_index(drc));
> >       /* NOTE: we do this as part of realize/unrealize due to the fact
> >        * that the guest will communicate with the DRC via RTAS calls
> > @@ -529,7 +552,7 @@ static void drc_realize(DeviceState *d, Error **errp)
> >        * inaccessible by the guest, since lookups rely on this path
> >        * existing in the composition tree
> >        */
> > -    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
> > +    root_container = drc_container_get();
> >       child_name = object_get_canonical_path_component(OBJECT(drc));
> >       trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
> >       object_property_add_alias(root_container, link_name,
> 

-- 
Peter Xu


