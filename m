Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC9CC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpuB-0001Ut-3l; Fri, 01 Aug 2025 09:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhpo0-0007bW-3u
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhpnw-0007dx-11
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754054890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xUe3ZT21aPz5tLmD6L1dQ+sF3s3PX9LhcARLquqwxLw=;
 b=b6cK7xAYaCDVSp+IDGQMetl3ZyjPi3FCH/yvKwmeMkH+s6hfrIAziGOeQikJ2nlsSW5xev
 ndzMVZcnaS+4HbB/Nl+J3KVD2Erj8fPFWNd8HLWlgstKzptCNA4mRPgUobVRC5bZ8AA4tp
 YxKMBD3veFFxgF40sCTXzZXnnSBoPkQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-UUIGT6AqNY6vc9YjwTTopQ-1; Fri, 01 Aug 2025 09:28:09 -0400
X-MC-Unique: UUIGT6AqNY6vc9YjwTTopQ-1
X-Mimecast-MFC-AGG-ID: UUIGT6AqNY6vc9YjwTTopQ_1754054888
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31332dc2b59so2245083a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754054888; x=1754659688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUe3ZT21aPz5tLmD6L1dQ+sF3s3PX9LhcARLquqwxLw=;
 b=NvTb6gAQTnJkDZEOkghkixFbQw5JHJqYqftHj9YQ6muwwOnKmXeOLkLtHtEy5Dtuq+
 BA0/fF8U6hDmaD908kIe5KxnGmLwRBo0GJXhcKUlg3+l62WfDgWrU4XRUaS/dI09YhjS
 aMyHghCFQ4DqKBbQY9h/W8AZ8UGsMi5i46DxKHNBOLb5sGkKjI0T1Etj2OdA2eM9aA7p
 3RTtJiXoTesGLcMgRfUPadn34J1/ioctWaenVPMNXslXf9YOZMlLG6rydtf1GGwLA9u+
 I4sSDrLTfdV9iGaf7jGynwjvv7mIuDiilovSZlgD4JnOHqk3ERZILgTXKrS7+ghWJ86c
 8Jlw==
X-Gm-Message-State: AOJu0YzvuZkFpGnVk4ZU7p0aex5GIots7N7EN3Kype+NpxOBMn0j/KPA
 dccRp5gqIrumhoBQ2EaG81FEWAcB3YUxpk0EHddo2GvjQatmS0Om7vX6cDMG8pjw76B+d3tqDC2
 X4kXMyKtR9gGOEde8KljuIbJPk2qLQezeMFcZGPLztLT97h82rCOh+d3Q
X-Gm-Gg: ASbGnctPX2iIAPjYoefkB4LWwnC1KhxFVlbzft0B32WzKuyd2Y6TONPkIxj0WdHEcsD
 btCY+Fss2Dsy27Q2nQ/Y3NPEwbyFp38yWI442ElGafhZ4rIk0Z+RNDEFmFdQndFRUiUWZEuhDQE
 HFV/9Nrv96W6wGJA0tXCVNTb43VCkIDGBbhZPDdESxP7DMYYR8zVRWbiyj8Foo6QyZeelGJ3lVI
 /kuYiOSmgQWMXnAeetpD9UTcd/dw5f41pXJSQTE8qrCrzdX2PtSA5Bhn+lWCv4Yho5mtB0RIr+4
 AMIzQ2eqGcx2MbB5dcy9DyXkjxkQg9Gm1oS9Dk16yFI/j0tLdO8m2g==
X-Received: by 2002:a17:90b:3d06:b0:31f:4a91:4e94 with SMTP id
 98e67ed59e1d1-31f5de63c1dmr16269555a91.30.1754054887573; 
 Fri, 01 Aug 2025 06:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzHT93NjhTK0R6H/GrcYhdYU3nVtCmOa17ypP23AUpsi772QnpQuCtveGzuQ7+t9/RgUYQgg==
X-Received: by 2002:a17:90b:3d06:b0:31f:4a91:4e94 with SMTP id
 98e67ed59e1d1-31f5de63c1dmr16269488a91.30.1754054887058; 
 Fri, 01 Aug 2025 06:28:07 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.171])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32102a559bdsm907529a91.1.2025.08.01.06.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:28:06 -0700 (PDT)
Date: Fri, 1 Aug 2025 18:57:53 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v8 05/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
Message-ID: <aIzA2aIUwXKKGNqR@armenon-kvm.bengluru.csb>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
 <20250731-propagate_tpm_error-v8-5-28fd82fdfdb2@redhat.com>
 <75e91cbc-9116-4265-af47-ce72e87fb2cd@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e91cbc-9116-4265-af47-ce72e87fb2cd@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Akihiko,

Thanks for the review.

On Fri, Aug 01, 2025 at 04:12:34PM +0900, Akihiko Odaki wrote:
> On 2025/07/31 22:20, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_section_start_full() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/savevm.c | 36 ++++++++++++++++++++----------------
> >   1 file changed, 20 insertions(+), 16 deletions(-)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 736410be867a29efa24d749528c9bc203a3e8131..59751677c1bb7c893b4ba61cbfe1f55ade6ad598 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2690,8 +2690,9 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
> >   }
> >   static int
> > -qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> > +qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
> >       uint32_t instance_id, version_id, section_id;
> >       int64_t start_ts, end_ts;
> > @@ -2702,8 +2703,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >       /* Read section start */
> >       section_id = qemu_get_be32(f);
> >       if (!qemu_get_counted_string(f, idstr)) {
> > -        error_report("Unable to read ID string for section %u",
> > -                     section_id);
> > +        error_setg(errp, "Unable to read ID string for section %u",
> > +                   section_id);
> >           return -EINVAL;
> >       }
> >       instance_id = qemu_get_be32(f);
> > @@ -2711,8 +2712,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >       ret = qemu_file_get_error(f);
> >       if (ret) {
> > -        error_report("%s: Failed to read instance/version ID: %d",
> > -                     __func__, ret);
> > +        error_setg(errp, "Failed to read instance/version ID: %d", ret);
> >           return ret;
> >       }
> > @@ -2721,17 +2721,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >       /* Find savevm section */
> >       se = find_se(idstr, instance_id);
> >       if (se == NULL) {
> > -        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
> > -                     "Make sure that your current VM setup matches your "
> > -                     "saved VM setup, including any hotplugged devices",
> > -                     idstr, instance_id);
> > +        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu32". "
> > +                   "Make sure that your current VM setup matches your "
> > +                   "saved VM setup, including any hotplugged devices",
> > +                   idstr, instance_id);
> >           return -EINVAL;
> >       }
> >       /* Validate version */
> >       if (version_id > se->version_id) {
> > -        error_report("savevm: unsupported version %d for '%s' v%d",
> > -                     version_id, idstr, se->version_id);
> > +        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",
> > +                   version_id, idstr, se->version_id);
> >           return -EINVAL;
> >       }
> >       se->load_version_id = version_id;
> > @@ -2739,7 +2739,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >       /* Validate if it is a device's state */
> >       if (xen_enabled() && se->is_ram) {
> > -        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
> > +        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
> >           return -EINVAL;
> >       }
> > @@ -2747,10 +2747,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >           start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
> >       }
> > -    ret = vmstate_load(f, se, NULL);
> > +    ret = vmstate_load(f, se, errp);
> >       if (ret < 0) {
> > -        error_report("error while loading state for instance 0x%"PRIx32" of"
> > -                     " device '%s'", instance_id, idstr);
> > +        error_prepend(errp,
> > +                      "error while loading state for instance 0x%"PRIx32" of"
> > +                      " device '%s': ", instance_id, idstr);
> >           return ret;
> >       }
> > @@ -2761,6 +2762,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >       }
> >       if (!check_section_footer(f, se)) {
> > +        error_setg(errp, "Reading footer section of instance "
> > +                   "0x%"PRIx32" of device '%s' for version_id:'%d' failed",
> > +                   instance_id, idstr, version_id);
> >           return -EINVAL;
> >       }
> > @@ -3063,7 +3067,7 @@ retry:
> >           switch (section_type) {
> >           case QEMU_VM_SECTION_START:
> >           case QEMU_VM_SECTION_FULL:
> > -            ret = qemu_loadvm_section_start_full(f, section_type);
> > +            ret = qemu_loadvm_section_start_full(f, section_type, NULL);
> 
> The converted error_report() calls are temporarily dismissed. This can be
> fixed by moving "[PATCH v8 19/27] migration: push Error **errp into
> qemu_loadvm_state_main()" and changes for its caller earlier than this.
> 
> qemu_loadvm_state_main() can have some code to fill errp until all the
> functions its calls get converted. It will not make the patch bigger thanks
> to the unified error handling path with "goto out" and the removal of code
> changes to replace NULL with errp.

I see your point.
There is a cyclic dependency between few functions.
For example, qemu_loadvm_state_main() calls -> loadvm_process_command() 
				      calls -> loadvm_handle_cmd_packaged() 
				      calls -> qemu_loadvm_state_main()
That is why I passed NULL temporarily and then change that in the subsequent
patches. However, I see that this will cause problems for reviewing and bisection.
I can introduce a local_err in the caller, and when errp is available, I can pass that.
That way I will be reporting local_err after it returns. That way the individual
patches will report the error.

> 
> >               if (ret < 0) {
> >                   goto out;
> >               }
> > 
> 

Regards,
Arun


