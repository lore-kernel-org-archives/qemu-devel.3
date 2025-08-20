Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10554CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 17:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uomit-0004pL-4l; Wed, 20 Aug 2025 13:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomio-0004oO-72
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomim-00082J-7w
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755711335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Beiu4fcsuBvTkOp5NbslBUYEZ0WZ/Y91TwPuRE1FisI=;
 b=WqYLBusBX1WUWJA8UGTi3f6vCOHHoMFLGNahjyhm1v71T85TuJPTHP4H1S7cTGKyDoef2+
 MFVWGL3ABv17OiKNJ/qMfcutuXOYDrxyCQVTCsR4CY9phdpLPnTeml4PXxtSCvZrZ0H9rF
 7gqqr3gf1F3bKt1BJbcOwyQ4gt9Jd9M=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-KsvDQERIPZCHHRijNNzhhw-1; Wed, 20 Aug 2025 13:35:34 -0400
X-MC-Unique: KsvDQERIPZCHHRijNNzhhw-1
X-Mimecast-MFC-AGG-ID: KsvDQERIPZCHHRijNNzhhw_1755711324
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-76e2eab5baaso148126b3a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 10:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755711324; x=1756316124;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Beiu4fcsuBvTkOp5NbslBUYEZ0WZ/Y91TwPuRE1FisI=;
 b=e9Z+RiZyii3khwIfxHoMOj2TOHWyXwWKmZ6Q/iNE8ZkaEQQhlVDuLJLjFD5jRXcMID
 mEemgEidxkQ/8k7mtSroZn+kWokrhmX0cBUHJmwmZsT8Bp4FOfHnTXQF30G4OsmWSCMv
 777JYdbfHZr0JOTnR/L0W1DeG4v6ZZfUKC8y0gme5k/UvHCyuHHHGbf6g4YsEGQ1bZSK
 jzOaqluY6XLDSiBVMYexkYKs4j2vSzQ4FnpkU2HzjCRfZrGmCIfNwsTTIgihtewYCiZO
 x21tm1k/yo5QNj99PKO+GZT7HSObDjEw3XahWNHLguYW8j8fDen4+abUZ7zLkjPdXzWb
 QQEA==
X-Gm-Message-State: AOJu0YwxQR+GXfOOFIo2fUabul7jXeX3HpaN4mfXvdScs01PInOzk5Q/
 a2tyQrqLD5/yDdbZ7a6kjNvBMBlLWDIZBavvWHk7xL86nGZk4RxloCmtw/Z/Z+RNoxZDwVTYEyw
 Wn3PJmEpfysGhW8oZ7advvcA3D+x63n/ixI7f08LYWCiaht6sTQ1YVAzn
X-Gm-Gg: ASbGnctXIMzNbSUiezot2WsfXE6NVCQHmxeXR6Q8hFp4Z5J0unRlz5+vPJYE90C++Rl
 jm/lj9J++T3KX13VMWRXR326qNvglUaCdrxhC4VcMHr+MLQrbmERiG6VxYkqOontpUTrpx5RbNl
 7DZAkEGm+czotwnhYD9jVwxls2yTusJQkQfcMkdh5aszuPKJTg7r4aQ+v1Q7K96yGQvsnNP4DJL
 b1W4kFqiIKYJslw3iyUNkjJZEU14/TPP5Y747NbzBigQa4ji3naChF6Y1otWfMtVrsrKqF5MNiz
 1hmruVmQqG4UPh7Ymn6FIIxPHFoE/yo4EFUZ8KUvk7E0WMR/VaO/
X-Received: by 2002:a05:6a20:4311:b0:240:167:9c3f with SMTP id
 adf61e73a8af0-2431b828f47mr6567986637.14.1755711324449; 
 Wed, 20 Aug 2025 10:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDeoZ5Vw42CgB3/p+0/EtneUrH1q6I/KCCgDvOCLOqDycJo2OiTios+HAt4vEjdQavbzot7A==
X-Received: by 2002:a05:6a20:4311:b0:240:167:9c3f with SMTP id
 adf61e73a8af0-2431b828f47mr6567933637.14.1755711323997; 
 Wed, 20 Aug 2025 10:35:23 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-324d31b83dcsm3224271a91.2.2025.08.20.10.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 10:35:23 -0700 (PDT)
Date: Wed, 20 Aug 2025 23:05:11 +0530
From: Arun Menon <armenon@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v11 10/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
Message-ID: <aKYHT1Ua0yt-jYh3@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-10-b470a374b42d@redhat.com>
 <871ppcz8lu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871ppcz8lu.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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

Hi Fabiano,
Thanks for the review.
On Fri, Aug 15, 2025 at 04:29:49PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_section_start_full() must report an error
> > in errp, in case of failure.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/savevm.c | 38 ++++++++++++++++++++------------------
> >  1 file changed, 20 insertions(+), 18 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 9ec07892cd6ea666431410657c840b6325377d97..77408347c1f1ca7eb3a04f8f130c20a5a81f6db2 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2724,21 +2724,21 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
> >  }
> >  
> >  static int
> > -qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> > +qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
> >      uint32_t instance_id, version_id, section_id;
> >      int64_t start_ts, end_ts;
> >      SaveStateEntry *se;
> >      char idstr[256];
> >      int ret;
> > -    Error *local_err = NULL;
> >  
> >      /* Read section start */
> >      section_id = qemu_get_be32(f);
> >      if (!qemu_get_counted_string(f, idstr)) {
> > -        error_report("Unable to read ID string for section %u",
> > -                     section_id);
> > +        error_setg(errp, "Unable to read ID string for section %u",
> > +                   section_id);
> >          return -EINVAL;
> >      }
> >      instance_id = qemu_get_be32(f);
> > @@ -2746,8 +2746,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >  
> >      ret = qemu_file_get_error(f);
> >      if (ret) {
> > -        error_report("%s: Failed to read instance/version ID: %d",
> > -                     __func__, ret);
> > +        error_setg(errp, "Failed to read instance/version ID: %d", ret);
> >          return ret;
> >      }
> >  
> > @@ -2756,17 +2755,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >      /* Find savevm section */
> >      se = find_se(idstr, instance_id);
> >      if (se == NULL) {
> > -        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
> > -                     "Make sure that your current VM setup matches your "
> > -                     "saved VM setup, including any hotplugged devices",
> > -                     idstr, instance_id);
> > +        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu32". "
> 
> Drop the "savevm" please.
yes. Thanks.
> 
> > +                   "Make sure that your current VM setup matches your "
> > +                   "saved VM setup, including any hotplugged devices",
> > +                   idstr, instance_id);
> >          return -EINVAL;
> >      }
> >  
> >      /* Validate version */
> >      if (version_id > se->version_id) {
> > -        error_report("savevm: unsupported version %d for '%s' v%d",
> > -                     version_id, idstr, se->version_id);
> > +        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",
> 
> Same.
yes
> 
> > +                   version_id, idstr, se->version_id);
> >          return -EINVAL;
> >      }
> >      se->load_version_id = version_id;
> > @@ -2774,7 +2773,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >  
> >      /* Validate if it is a device's state */
> >      if (xen_enabled() && se->is_ram) {
> > -        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
> > +        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
> >          return -EINVAL;
> >      }
> >  
> > @@ -2782,11 +2781,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >          start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
> >      }
> >  
> > -    ret = vmstate_load(f, se, &local_err);
> > +    ret = vmstate_load(f, se, errp);
> >      if (ret < 0) {
> > -        error_report("error while loading state for instance 0x%"PRIx32" of"
> > -                     " device '%s'", instance_id, idstr);
> > -        warn_report_err(local_err);
> > +        error_prepend(errp,
> > +                      "error while loading state for instance 0x%"PRIx32" of"
> > +                      " device '%s': ", instance_id, idstr);
> >          return ret;
> >      }
> >  
> > @@ -2797,6 +2796,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> >      }
> >  
> >      if (!check_section_footer(f, se)) {
> > +        error_setg(errp, "Reading footer section of instance "
> > +                   "0x%"PRIx32" of device '%s' for version_id: %d failed",
> > +                   instance_id, idstr, version_id);
> 
> check_section_footer() already has messages saying something went wrong
> with the footer. Make sure you're not duplicating information. If
> necessary, trim it either here or there.
yes. The function indeed reports error. I needed to set errp though.
I will trim the message.
> 
> >          return -EINVAL;
> >      }
> >  
> > @@ -3103,7 +3105,7 @@ retry:
> >          switch (section_type) {
> >          case QEMU_VM_SECTION_START:
> >          case QEMU_VM_SECTION_FULL:
> > -            ret = qemu_loadvm_section_start_full(f, section_type);
> > +            ret = qemu_loadvm_section_start_full(f, section_type, errp);
> >              if (ret < 0) {
> >                  goto out;
> >              }
> 

Regards,
Arun


