Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28116C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh65D-00082B-6v; Tue, 07 Jul 2026 09:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wh652-00080j-QN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wh64z-0005om-Ql
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783431796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+AP2Bm/KV11DUs15IzsvpLWxdtHsphxK+eU9hcRwp0=;
 b=BKiAeE1TLt/7A22LDkyIZSG/hOAMezp8O2kkYN3hP8ICsK2p76Tt4nrrPwV3w7a4OfPLLv
 lfeMERjnesdBvAjq43XfXC71S9hjFbq7b/Q+uNTUfJ24/f9Fp9HWxp7k6XOXHjQQo1Zu2B
 l0IeM4/MlTJlqssqQu79KaVriSSAtaU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-D20D5zjuMvOf9KXME3PuHQ-1; Tue, 07 Jul 2026 09:43:13 -0400
X-MC-Unique: D20D5zjuMvOf9KXME3PuHQ-1
X-Mimecast-MFC-AGG-ID: D20D5zjuMvOf9KXME3PuHQ_1783431793
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c07d22d503fso293367866b.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783431792; x=1784036592; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9+AP2Bm/KV11DUs15IzsvpLWxdtHsphxK+eU9hcRwp0=;
 b=tr46XlSjeKowX6Y4Fp0d9Xdqj1WWQjKHXhYVuuUSjEonSLGAIQJ41MuzZY1mO8iSDX
 3rXBMLAGeYizDsJj8n1fx1wFP8yEK/LjIyNO1udY44M9HedXwJrf5qSieZgHZlTLFcCz
 2f6giuZgeOUjQJ7PMPhIj6TJy2GQsyf8N4BhBQ2naiXseFrWPdi6XEN3XHZGN3EFOqxd
 47Jfwy1qyji9SBt7L+Xi8DxIlCt63Qh1soNHH97I/tuMyk2if2PiqhKHvjjoJCCBY/ii
 Vp/JF8pd2XSC84tKGwjaTr7SGQKvwhv+0p/Jnz0FZbGPGgLLbNgJ1ecCTSehhkpaGdxv
 rd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783431792; x=1784036592;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9+AP2Bm/KV11DUs15IzsvpLWxdtHsphxK+eU9hcRwp0=;
 b=afYy3XAG061lEU/gMSje6hAwi2DsX//v5s6LQUIG+UuEtJeVlm7tzTGv4AqJZH+LU6
 0OBdBD1N2ogFxdLrwzYm3sxPmvBDHzLXpPQI5fdKvFE8Sgm6P8UCU4wNE6jKXwHlaWfq
 6ULdYtcARb4S4b37SLhObN8UQwEqm51n32XDmR6WW1KtQqtMsFqKBSiXLqKuwdMU4Ed2
 HV4VGncmG6+pHbKH6aGDa6w93oMyI4jithtK6TTA1ngJ/f+xxXgGfjYb99vHc0PbB416
 auAsjPVx2yZGTvILfL2A160BwH4LBhYrwnvamCjsP7UA9pdq2LSosgBmzx4Fx0Ec4iwO
 6hwg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2q8mItvCjbxjFvolPIl9HA1zoaLFcqCsEzLZcN4Kn9/K7lkKsf5pH5jVpFZ15mAEK4nAHypEX+xl8@nongnu.org
X-Gm-Message-State: AOJu0YxuA/QedQIXK4qr1HYrD00vfS3z/lFi3yWl0RpNeeNmlCYGPiMu
 60NtXxYb0M8Z6LkhNRRgovq/fjU2gfJT8dEwoh8qmyLNkVvBq5g17ifhEbgag+8PGZEULU/vbFD
 GMIKIOFovqV7F/B4Nf1fJyhqE2qHvYUMBPc0mvUiLNBByEFt4oYEKeRE2
X-Gm-Gg: AfdE7cnE3SM+hwkgrQO16KMn2HNG8UAwV1Y4BlRKPMJQCfGGn5NIPF73r+7IFLKSxZ/
 mp7MfjepA/7JRhGt596ma3Mj1wbHoJb1M2goDSVwsPI/xoFXIA0t5xgO0vUDsqeXlklGBEJ2Tx/
 HD1f1ch2ib8Ysl90hbGhk3j4M6i08wNm6h4QHRiSLt6DP4PBzy9YPXb9xVnsYTFsB6OaWvct3uy
 bDMVHBv0XU4zA040/ODqeB/tqVIE5tHfRtNUJg6fwOn8fLY3GaYGPfqvVXMQSJCTSu74vRK+/kA
 HKRTJEnfwkFn9kPPsHk8YxaMtNo8CQ5j8ledQW49bNrHMjXDXk5McCjDrClVV2d7NLz53xYiAfT
 74BgOYmRFGKh8PngoYLYVBx58jo3J5n+H
X-Received: by 2002:a17:907:25c2:b0:c12:a961:7a7 with SMTP id
 a640c23a62f3a-c15a6799231mr296424966b.20.1783431792499; 
 Tue, 07 Jul 2026 06:43:12 -0700 (PDT)
X-Received: by 2002:a17:907:25c2:b0:c12:a961:7a7 with SMTP id
 a640c23a62f3a-c15a6799231mr296421366b.20.1783431791738; 
 Tue, 07 Jul 2026 06:43:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15bc428775sm42837366b.6.2026.07.07.06.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 06:43:11 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:43:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <20260707094203-mutt-send-email-mst@kernel.org>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 07, 2026 at 04:43:43PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jul 7, 2026 at 2:59 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Beyond the overall virt/non-virt use case classification, there are
> > a number of scenarios which we have decided will not be treated as
> > security issues. Start to document some of these to give consistency
> > in our treatemnt of incoming disclosures.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >
> > Mauro / Michael: please suggest any other rules which we have applied
> > historically on qemu-security disclosures that we should capture here.
> >
> > The vfio-user/vhost-user addition is a new one based on discussions
> > in some GitLab issues today/yesterday
> >
> >  docs/system/security.rst | 63 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >
> > diff --git a/docs/system/security.rst b/docs/system/security.rst
> > index 53992048e6..fbbca50f95 100644
> > --- a/docs/system/security.rst
> > +++ b/docs/system/security.rst
> > @@ -75,6 +75,69 @@ Bugs affecting the non-virtualization use case are not considered security
> >  bugs at this time.  Users with non-virtualization use cases must not rely on
> >  QEMU to provide guest isolation or any security guarantees.
> >
> > +Security boundary scope
> > +'''''''''''''''''''''''
> > +
> > +Even where a flaw affects the virtualization use case described above,
> > +not all scenarios will be considered in scope. The following guidelines
> > +are used to evaluate whether to apply the full security process, or treat
> > +an issue as a normal bug.
> > +
> > +* **assert** / **abort**. If triggering the code path requires kernel
> > +  privileges (or root account access) in the guest, asserts/aborts in
> > +  QEMU are a self inflicted denial of service. These will **not** be
> > +  treated as security flaws, at most hardening bugs. If triggering the
> > +  code path can be done by an unprivileged guest OS account, this
> > +  **may** justify handling as a security bug.
> > +
> > +* **vhost-user/vfio-user backends**. The backend processes have
> > +  shared memory regions co-mapped with the QEMU process. The intent
> > +  of the process separation is operational resilience & flexibility
> > +  and allowing for independent software suppliers. There is not
> > +  considered to be security boundary between QEMU and the vhost-user
> > +  & vfio-user backends. Thus flaws in the backends which can cause
> > +  crashes / undesirable behaviour in QEMU will **not** be treated as
> > +  security flaws, but should be fixed as hardening bugs.
> > +
> > +* **memory allocation bounds**. There are many ways in which a QEMU
> > +  process can legitimately consume an amount of memory that is
> > +  significantly larger than the assigned guest RAM. QEMU's worst
> > +  case memory usage should be considered effectively unbounded. As
> > +  such the QEMU deployment on the host should account for the
> > +  possibility of large memory peaks and apply countermeasures to
> > +  provide continuity of host operations. It is typical for the Linux
> > +  OOM killer to reap the process triggering host memory overcommit
> > +  in the case of exccessive usage, offering a degree of protection.
> > +  As such, bugs which can lead to excessive/unbounded memory allocations
> > +  will usually not be classified as security flaws, but should be
> > +  fixed as hardening bugs.
> > +
> > +* **degraded guest behaviour**. There are a set of bugs which can
> > +  lead guest hardware devices to misbehave. For example, a flawed
> > +  virtual IOMMU operation may not offer the guest device isolation
> > +  that would otherwise be expected. If a guest triggered exploit
> > +  requires kernel privileges (or root account access), and leads
> > +  to sub-optimal behaviour of the virtual device this is considered
> > +  a self inflicted service degradation. These will **not** be
> > +  treated as security flaws, at most hardening bugs. If triggernig
> > +  the code path can be done by an unprivileged guest OS account,
> > +  this may justify handling as a security bug.
> > +
> > +* **nested virtualization**. The scope for nested virtualization
> > +  is to prevent a level 2 guest from breaking out into a level
> > +  1 guest. As noted above, a number of scenarios exclude security
> > +  handling for flaws only exploitable by the guest kernel / root
> > +  account with affect the guest's own service/availability. In the
> > +  context of nested virtualization with PCI device assignment, it
> > +  may may be possible for a level 2 guest kernel to trigger flaws
> > +  that affect the level 0 QEMU process. While these bugs should be
> > +  fixed, they will not be triaged as security flaws at this time.
> > +
> > +* **low severity impact**. As a catch all rule, issues which
> > +  are judged to have a "low" severity impact on the system will
> > +  usually not justify handling as security bugs, nor assignment
> > +  of CVEs. They will be fixed as routine bugs when time allows.
> 
> Should we have a section about management-plane protocols? (migration,
> QMP, monitor), since they already require trusted network access?


Yes please. But this can be a patch on top.  For this one:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> > +
> >  Architecture
> >  ------------
> >
> > --
> > 2.55.0
> >


