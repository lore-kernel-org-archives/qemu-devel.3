Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E70EB3624
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx9Sn-0000nv-Nr; Mon, 02 Mar 2026 15:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9SK-0000kW-Dk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9SI-0005j2-MB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772481684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFvQ6MCkWgD5qJHfcpLP8lHqGinSTnsJ8oSfzPlF5XM=;
 b=LTXukdsuefl3XxpDKhPSBlVLVkH3kaf/bbbjXF6xRFDR6HCSAI75A4Ve0y5iMtXk7MZZHi
 2lmeZHZ+0fG5zIO3Q2DtU4c5TQVJ0oAgVnsSy7UH1RkaXRmzlBd0+8YFc0cM7MLBexDp4Q
 c39u4ocTcb1jYFXJVfHoCA3Unpu0yRk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-NZc2qCDOMSaP5lBgzj98mg-1; Mon, 02 Mar 2026 15:01:23 -0500
X-MC-Unique: NZc2qCDOMSaP5lBgzj98mg-1
X-Mimecast-MFC-AGG-ID: NZc2qCDOMSaP5lBgzj98mg_1772481683
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-506bfa0441aso778433161cf.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 12:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772481683; x=1773086483; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OFvQ6MCkWgD5qJHfcpLP8lHqGinSTnsJ8oSfzPlF5XM=;
 b=ozeLRvTI/hVnNVqMXVgkH3WxDf3tb0ugP5Voem+QoRae3XWyhFLodn1og0UtcYfrFX
 1gYp6mfQrAnSlj5gkByCMn+nBhjBQ3lN4HPmCfrAgZ7tEvPPkmf5D/smSJWS5QxDSWo7
 XXp268VZdE7m4DUTkLHWti2qcqsBAhhvwxASivc6C8+jv84QAN74K7BHQPapg4b6IPum
 S4XYw0XaD8Z91a1KTaneLSBV+KhywTZJaF3mR/Mujt6WPTPP7LtP3MufAp+0khJYE5O7
 i0fMcjtx58hBdiw8LC9kRdVqGlnl58XSWPb2TmxHZn6g+zz4a2WQB1ql1AxaeioQ7IS1
 Cbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772481683; x=1773086483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFvQ6MCkWgD5qJHfcpLP8lHqGinSTnsJ8oSfzPlF5XM=;
 b=nxTxM6dH8Q1fokmpOUj5bnSDtT3efx4EX7VStYhAsRTrMN6Dit7y9N05U0Lb0lkPhV
 xEdz8lRUnP6wW/secahyX4SG+QiUwFHd21zqzD+qbll5iN9u1pOA4hPLPjcz2/p45T2E
 cRM9lwk6LUtitpSE3lq0aWakOGwuEbCf6geHuCa/1rbGxbnzXunC/UtNuVzmfELRXxzC
 lISheODTLS9j8mhZOiGpWQmBEIVYDTEKrRUWyQDIwtOsPNxSB9S3mA+BLtTD7AOUY22G
 mTMlttDVo6X0NaFfy/ijXCZqwpu7wOWlPAwauTH2qsXSyku4EAw4Uovy0Ax4x0bLnijR
 zMEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrzDeW4vuyllN5Y8Fk8FmBX8qWSaTv4c1kj8Yl0qYyI0rU23KxTSCPnOMukJtDKK4B59dJ83C146JQ@nongnu.org
X-Gm-Message-State: AOJu0Ywk8HdERCJhnayO088WI1L2m/bn70wguqGsc7xOA+4XiDAP8FH0
 4p5M1kWsgRiNUC6MxnDLdc6r1gukCrLtuv693Y9XFr4yVTBcxXNsV3yz24DHRQ49DO7QP0N5OSw
 3kIFi/4oXoV9Jzu2oT8yEuKJb6WPRStF33pnD5mFgIAOIoNh/J12KmVEH
X-Gm-Gg: ATEYQzwW/naP++qzZzqGIYWZ/fvYS+gRhxfKW9YcScluMeI1zGdKBi27p0PjlB4jdhg
 a1NVHsSsXfWUUGw/41uCGDPQi4fHSUfEQXa/iOrmUPTWU1mjBHslgUnN+U+j0baIaJer5KHS4aJ
 7AJKOON36fI8yeCm7Y/icIfCiGgHS+Qw3iwrjVNEnQmGjiufFyBhSHjsdOq22R/jFsiqU8rrN1r
 qZXZBDww7jkNnmhh50xSSjqEKPqiS9Fu0n2vtOJ2xPsvh27E49Vszn3dG+wXYvCawFb3hHKCZX4
 DmhQusqdnal6DKisVFcy6l+/0Ybq2HWVJfhD2gshdzboia4ZEsSWwNeDNfWBzJW8By7btGIQUZO
 ljrt+/K3QmzzgcW7x7OCjVBuYL/FQ5XQ0eD7EWR+K9GEzMF7fXXIgUPfDVBTB0SE4cEhuX/0MaO
 LnYdjkxA==
X-Received: by 2002:ac8:7f0a:0:b0:507:340b:251b with SMTP id
 d75a77b69052e-50752783579mr168610041cf.28.1772481682523; 
 Mon, 02 Mar 2026 12:01:22 -0800 (PST)
X-Received: by 2002:ac8:7f0a:0:b0:507:340b:251b with SMTP id
 d75a77b69052e-50752783579mr168608751cf.28.1772481681449; 
 Mon, 02 Mar 2026 12:01:21 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50751256df4sm89982281cf.16.2026.03.02.12.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 12:01:20 -0800 (PST)
Date: Mon, 2 Mar 2026 15:01:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
Message-ID: <aaXsj5osdbUNbttY@x1.local>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
 <aZ8xlrL2xQtoN9MI@x1.local>
 <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
 <aaBFxY6PUsNrAYft@x1.local>
 <83E69A6D-EDC8-4380-8C4E-6F77D1E2F078@redhat.com>
 <CAE8KmOzmk195FKCK-J6qVnj=wcDp5HC6+xhbNhturYo-Ls0egw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzmk195FKCK-J6qVnj=wcDp5HC6+xhbNhturYo-Ls0egw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

On Mon, Mar 02, 2026 at 04:58:50PM +0530, Prasad Pandit wrote:
> Hello all,
> 
> On Thu, 26 Feb 2026 at 21:46, Ani Sinha <anisinha@redhat.com> wrote:
> > >>> On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
> > >>>> Currently the code that adds a migration blocker does not check if the same
> > >>>> blocker already exists. Return an EEXIST error code if there is an attempt to
> > >>>> add the same migration blocker again. This way the same migration blocker will
> > >>>> not get added twice.
> > >>>
> > >>> Could you help explain why it will inject two identical errors in the first
> > >>> place, and why the caller cannot make sure it won't be injected twice?
> > >>
> > >> Likely due to a bug in the code. For example if the init function that
> > >> adds the blocker is called again and the caller does not handle the
> > >> second init call properly.  This came up as a part of the coco reset work
> > >> where migration blockers are added in init methods. They need not be
> > >> added again when init methods are again called during the reset
> > >> process. The caller can handle it of course but adding a check further
> > >> down the call stack makes things more robust.
> > >
> > > IMHO if we want to make it more robust, we shouldn't return an error
> > > because the caller may not always check for errors.
> > >
> > > Would assertion suites more here?  Because migration blockers are not
> > > something the user can manipulate, so it's a solid bug to fix when
> > > triggered.
> >
> > If Prasad agrees, I will send something.
> 
> * The majority of the places I see constructs like:
> ===
>         if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
> OR
>         ret = migrate_add_blocker(&hv_no_nonarch_cs_mig_blocker, &local_err);
>         if (ret < 0) {
>             error_report_err(local_err);
> ===
> 
> * So setting **errp and returning a negative value is consistent with
> that. Aborting (assert(3)) for trying to add a duplicate blocker
> object seems like a harsh punishment, considering that'll happen at
> run time and the user won't be able to do much then.

If it's a programming error, then it shouldn't happen at runtime.  The
current paths to fail this API was not for programming errors.

If this patch isn't required, IMHO we can at least drop it in this series
and make it separate.

Thanks,

-- 
Peter Xu


