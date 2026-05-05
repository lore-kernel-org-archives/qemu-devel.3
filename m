Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33F8FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIsw-0004Ur-Q0; Tue, 05 May 2026 12:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKIss-0004Ty-VG
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKIsq-0001Pv-K7
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777999471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MnCw9cVFVMuMTZxCeS+JTdl2scEdPhiAHSuNO0ASkLA=;
 b=O00RHYZAS9NfUT0Hn/dodtsThZl9tHfknlFe1tNgd4JLifxHSS1GZzJphuJfgXREiVUvIL
 9jvZ5S+ZEwfDyKR8SUsoBncCwIJZP/ld7sLVg3yy0hgFHAWDSAsuA0Ul0C2Gw/fMO9960Q
 4LjoDmY+X2g2Lw2vLo606vcBnjrTCMQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-pcqHVjBUNay6LD54ctdVhw-1; Tue, 05 May 2026 12:44:28 -0400
X-MC-Unique: pcqHVjBUNay6LD54ctdVhw-1
X-Mimecast-MFC-AGG-ID: pcqHVjBUNay6LD54ctdVhw_1777999468
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514551d5f2aso10479021cf.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777999468; x=1778604268; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MnCw9cVFVMuMTZxCeS+JTdl2scEdPhiAHSuNO0ASkLA=;
 b=GRsFszipcroyyTNrxBB7EJM5UR496Y1e9WPzY24EQqVSvWmuno7gjSElyfDhCZluZI
 +LymUmqw0SCK4sNVddjNCW1xobPMDsEl98lqGm5RHw/vePq3Mt/ld7Vr9Ar92SElfDhE
 +ICaxDhXZzzFnbFINh6hK2iZDdzascMMS7YK3Ysk9IJ/F9/CiVzYQNKSlYNhLcMv4kgP
 cNgleLJQl/0LZ4CTd5K/41N2+yo2LXHZWBCFxpjPTBEAdY5GzK+iOStRBHrn92U5BTXg
 M6n9+/PhXoRwc9m5BJiMHqTjYGLOrMDC9fyMY79m4/0e1ScKVZOUEJXXc4U/tOyaRjGL
 X7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777999468; x=1778604268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnCw9cVFVMuMTZxCeS+JTdl2scEdPhiAHSuNO0ASkLA=;
 b=hCUJN1nNKS2YoVzyapAXRa3CJT2nDKeSVucryJAA4txfTLB/e6FMYU+GFazOTuQMKV
 kNYOE6ed82EBwh86ey/N8LE18AuJZGD+C1p32SfcZpZ/4+R8DDA+Fc/MAVjmO6S8D+mg
 geFVRoNSOGB5MefpXyVUsBHfgS+KllIBIBoEPYyj2fg2YBGgggKYVHTmUVC3JH7pO1ZQ
 PwWGoPmS1dJ2+lNYHC4f8f3YWZmUn1AOrBHWG03+RIIRf0DJ8UChyWLWgyErnNkfgCi/
 7bmx0X4gswe81uWJmbwObfDGsrh3yn2B9plBNHzkiQl+nVAVdQ77/lVPD/8xX1Q/vDlG
 ubYg==
X-Gm-Message-State: AOJu0YxoJjbHwuluYdYHnv3xK7J1CXlga6c/CwZ6vAQXP5vr2jBB3Vrw
 YiYX+JZL6oM9CARhKvKG1nNnGS/k2r0Q/ow3KNSb3ri3OHQq4eVwbz2JpWhoUIOORFYxSYj+O83
 DEIW5sTJrgZpMi7zRY0S7eg3aTZvy2Qaz6DT69i8mOn9Ky2+hzc4q2D0A
X-Gm-Gg: AeBDiesxFs+czpqgNYrZVpdJSd80zRxXql58cJmSoGuP+jhxgVu/bx+P1144k9POj8I
 XHPdIXxzTMNRsVso+Q8Kf0IDo6gDROf+28M7walt0dIxEQkV5eZzGsHQ+edlNLADEnGN6ZtxwzO
 XOSJI3PKRSZs6Iz9k8nGXHd/dQyIZUU/ipTdNwEd0DTLYrDaJcYP2KbBp1XSSC06zQHhlNEfgKX
 xa4Tgn2XNS2ffLGFTW3ScbQkjVac+1A66kVhUP0XW214581mVw+CQbh3tn7UCBYQdbCzCi2KZ2d
 Q11fcxdHpaY71+puUr7DIQgmCTv4xh89OISDFSBsolkYFgRRC+q7CbOlkRoXgbNhInHnRsMxwTL
 GOvsD001XwWD9UoWn7Jq1ZZT9bJlDZmHqTCnG3awUKjIw2AhamcDrdSlXTA==
X-Received: by 2002:a05:622a:c:b0:509:1dc8:e9e5 with SMTP id
 d75a77b69052e-51306a53c38mr56395021cf.34.1777999467491; 
 Tue, 05 May 2026 09:44:27 -0700 (PDT)
X-Received: by 2002:a05:622a:c:b0:509:1dc8:e9e5 with SMTP id
 d75a77b69052e-51306a53c38mr56394391cf.34.1777999466897; 
 Tue, 05 May 2026 09:44:26 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b538b1d761sm155320566d6.9.2026.05.05.09.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 09:44:26 -0700 (PDT)
Date: Tue, 5 May 2026 12:44:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v1] tests/qtest/migration: Fix A-B file build
Message-ID: <afoeaRAxWSMO_gK5@x1.local>
References: <20260429231025.30818-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429231025.30818-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 29, 2026 at 08:10:25PM -0300, Fabiano Rosas wrote:
> diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
> index 96e784b163..0ce5b34433 100644
> --- a/tests/qtest/migration/bootfile.h
> +++ b/tests/qtest/migration/bootfile.h
> @@ -8,6 +8,15 @@
>  #ifndef BOOTFILE_H
>  #define BOOTFILE_H
>  
> +/*
> + * This file is included from qtest, but also from the assembly code
> + * that generates the header file containing the guest workload. Don't
> + * expose the function declarations and non-standard types to it.
> + */
> +#ifdef __ASSEMBLER__
> +#define MIGRATION_GUEST_CODE
> +#endif

Just to mention: this triggers a checkpatch warning (I only notice this
when running checkpatch locally; CI is fine with warnings), which seems to
be false positive.

But still, I wonder whether we need this at all. IIUC we can also put those
into a separate smaller header and include that here, then use that one for
arch a-b-bios builds.

Even if it will work, we can leave it for later.

> +
>  /* Common */
>  #define TEST_MEM_PAGE_SIZE 4096
>  
> @@ -33,8 +42,10 @@
>   */
>  #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
>  
> +#ifndef MIGRATION_GUEST_CODE
>  void bootfile_delete(void);
>  char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
>  char *bootfile_get(void);
> +#endif

-- 
Peter Xu


