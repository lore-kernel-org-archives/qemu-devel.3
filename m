Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C33CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 15:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCK1d-0006UT-W0; Fri, 24 Oct 2025 11:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vCK1c-0006UH-HW
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vCK1Z-00042v-ET
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761320895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LF781Yxe/gZhmHOdp6xowU5YohbDfxxiI3wbmRaev3I=;
 b=XhtoK15/4I8qbMnWXhfqEyqBU0lzmYNfssn09+QMaT+WdmZ4OW+tlvSB1JXsAPgO+c9cPm
 /sHnnisdr/XVdJvdYiJOGe9czvS2Fq1xvtPFeiIBl3hVIKQteaRqnggBgDcQ5mA7akn8B7
 cwlewWpliKJcBvmUgloRDxWPpBQ5T20=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-QA1YHA3UPheTZHUUvkoBuA-1; Fri, 24 Oct 2025 11:48:14 -0400
X-MC-Unique: QA1YHA3UPheTZHUUvkoBuA-1
X-Mimecast-MFC-AGG-ID: QA1YHA3UPheTZHUUvkoBuA_1761320894
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e892acc0b3so63136301cf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 08:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761320894; x=1761925694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LF781Yxe/gZhmHOdp6xowU5YohbDfxxiI3wbmRaev3I=;
 b=BtvV0Sk2PmgqTGMOloUk0NwCGJqWhP6K9+MNWbHAolH4USCNtw6qqW9UwrgLnVBO4v
 4bK0UxvjL8eNdJ4lWq/UauDhg7123PNOk58G4RvzpomMhVNsMz3EehjBaqvwo1HBiABh
 sj7Zv0TJMbHR3Bl+tfd6f/uGz8HyVJnPZ1zvU6aaJnE8msZaxTywC2Rl3Py/jptI/pFi
 bRIszztsaU5z6ULsG0t8bcutHqan6pfzeTitqq345JEWYgm25Ne0hAIS6KlrR9fGg6Ol
 tDyvmxgdKUt4i66i3tNx/lExfT41DlRkjH5JIlZlXn7XRVsri11HMAlmKWAe+vNWJHuh
 kMLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTLwftmQxWc6vhb2dzfGjpMcnmriG5aLVUst2Ng5E/wQ04xzPKYZsst/xCPks22ZdACm3oRu8qI8Gj@nongnu.org
X-Gm-Message-State: AOJu0YxnnUbchne3VxpHQvlGmUmnGrW44B1intP8I4BvqpnGRO/GEQzV
 6hzzQacvh2tXynxq4DzjSs5UpWvcBBCfIkRJNT8ZQ7hnJfnkiAHbRCgSPSZzxVgkCPqVXLEuzpR
 GKjdIPLR+rshiqgl2/B7Em13DHJtyzt9YcXFfK/9DdRWdqkPF2P8E4Tkn
X-Gm-Gg: ASbGncuTdfWgqJ2mSh0czBa/3tClGjzH0nSYegwLNRkDxI5TCe5VZYk3fQoyCTCT3Ok
 RzzIla3Du8iTnrnekOztqw80V1X6Gf1vDS9vxCF09nzLo/Ta48hahHw3vhCP+lgzHzBx6Rv4Ml1
 3szOsqptMaIa/BsBpJd0UlYrPstzw/TJj1t4AUH+QdBFrqJUbNIc9E7Q69f2a9snPQ7YsllJTf7
 2XLPnGbRp5Y2f0hHEHiKJ7En4FMk5JfK5cFss5osXIm4bxdIUgdj41Nfoye0OYV46MRrEXPnr1B
 0/aJZzA9r9wxxgHaLTyrPRSv7nfWafqfcgd45k0C4eDYqoueVJsFggvk5ltcQNN4JJI=
X-Received: by 2002:ac8:57c2:0:b0:4b5:f6c5:cfc with SMTP id
 d75a77b69052e-4e89d274b1dmr349293071cf.19.1761320893797; 
 Fri, 24 Oct 2025 08:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2i9ToaEP5sHyYUnXGVpo/+t3KD11l2O2gW7I5hvH1EaOYGP4v0rmRXoIDMjFcIgu38aualw==
X-Received: by 2002:ac8:57c2:0:b0:4b5:f6c5:cfc with SMTP id
 d75a77b69052e-4e89d274b1dmr349292731cf.19.1761320893298; 
 Fri, 24 Oct 2025 08:48:13 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb80804d81sm36948991cf.19.2025.10.24.08.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 08:48:12 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:48:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aPufu9WHdaL60bFv@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
 <aPex9SsQOup69DRI@x1.local>
 <aPqjQspKFCZoqAm8@armenon-kvm.bengluru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPqjQspKFCZoqAm8@armenon-kvm.bengluru.csb>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 24, 2025 at 03:20:58AM +0530, Arun Menon wrote:
> Hi Peter,
> 
> On Tue, Oct 21, 2025 at 12:16:53PM -0400, Peter Xu wrote:
> > On Tue, Oct 21, 2025 at 04:43:52PM +0100, Peter Maydell wrote:
> > > On Fri, 3 Oct 2025 at 16:39, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > From: Arun Menon <armenon@redhat.com>
> > > >
> > > > This is an incremental step in converting vmstate loading
> > > > code to report error via Error objects instead of directly
> > > > printing it to console/monitor.
> > > > It is ensured that vmstate_load_state() must report an error
> > > > in errp, in case of failure.
> > > >
> > > > The errors are temporarily reported using error_report_err().
> > > > This is removed in the subsequent patches in this series,
> > > > when we are actually able to propagate the error to the calling
> > > > function using errp. Whereas, if we want the function to exit on
> > > > error, then error_fatal is passed.
> > > 
> > > > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > > > index de35902213..e61585aa61 100644
> > > > --- a/hw/display/virtio-gpu.c
> > > > +++ b/hw/display/virtio-gpu.c
> > > > @@ -1347,7 +1347,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> > > >      }
> > > >
> > > >      /* load & apply scanout state */
> > > > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> > > > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
> > > 
> > > This is in a migration VMState .get function -- shouldn't we
> > > be passing failure up to the caller, rather than exiting
> > > with error_fatal here ?
> > > 
> > > The commit message says some of this is fixed in subsequent
> > > patches, but as of today this is still the code in git.
> > > The other callsites which pass error_fatal to vmstate_load_state()
> > > also look wrong:
> > > 
> > > hw/s390x/virtio-ccw.c:    return vmstate_load_state(f,
> > > &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> > > hw/virtio/virtio-mmio.c:    return vmstate_load_state(f,
> > > &vmstate_virtio_mmio, proxy, 1, &error_fatal);
> > > hw/virtio/virtio-pci.c:    return vmstate_load_state(f,
> > > &vmstate_virtio_pci, proxy, 1, &error_fatal);
> > > 
> > > as they are written to return an error value that they'll
> > > never see because of the use of error_fatal here.
> > 
> > Indeed a fair question to ask.
> > 
> > > 
> > > Do you have plans for further cleanup/extension of the
> > > use of Error here that would let these functions pass
> > > the Error back up the chain ?
> > 
> > It would be non-trivial though as we'll need to change VMStateInfo.get()
> > API and that'll be another lot of churns.
> > 
> > Arun, should we pass NULL for above three occurances, so that we will still
> > not brute force quit when error happens?  Do you want to send a patch?
> 
> Sorry, I missed the email.
> I am wondering if we should pass an Error *err, and in case of failure,
> warn_report_err(err) and return a negative integer.
> 
> There is no return value check after vmstate_load_state() or vmstate_save_state()
> calls. Previosuly, if something failed during vmstate_load_state(), the
> function used to report error using error_report(). To be consistent we might have
> to keep reporting. This is not possible if we pass NULL.

Yes, dumping the errors should be better.

The other thing is even if virtio_gpu_load() ignored vmstate_load_state()'s
retval, I think it should..  If you agree you can also fix that together.
In general, likely we should never use error_abort in vmstate_load_state().

Thanks,

-- 
Peter Xu


