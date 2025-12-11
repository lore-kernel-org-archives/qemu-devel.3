Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B93ED41C20
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTesh-0001XS-6r; Thu, 11 Dec 2025 06:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vTese-0001X4-5V
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vTesb-0005QL-OQ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765452640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Y9tFuYInlA47P9eA2ojGAB9FoYr24JbofHha9k42B4=;
 b=MB9ju0Zbr2ZYpdXjKDknh/6iDVTvOnXKU4H6Eam/DLAJnFT/sEIIL/HdHCAn41SOz6FcjU
 uSIHVIy7YWyMlpuaH7bouWwot7pQlepGAJ0zlIuyQbJinpqEVx9PaQA/mANr7pkHPaJg0Z
 f/WMrT1F7fep0GSRTwbIbpSK3dR6OBY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-m8Ge4QqMNtGS-kycE-4TQw-1; Thu, 11 Dec 2025 06:30:39 -0500
X-MC-Unique: m8Ge4QqMNtGS-kycE-4TQw-1
X-Mimecast-MFC-AGG-ID: m8Ge4QqMNtGS-kycE-4TQw_1765452638
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4788112ec09so4879415e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 03:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765452638; x=1766057438; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Y9tFuYInlA47P9eA2ojGAB9FoYr24JbofHha9k42B4=;
 b=II9qa3xvsZM/n/krs03k73xByEAyL0ffm9kmnDQ8bBaPkTnjHMnwdvttEUABXD1i0D
 aSAgTgpWDpP9sESfQzWPc9EdKnQ4TYCtrQukCx/mqae01Pqq9b00ybOA0EwdDiGbt6+e
 B9BBphgnvz/nvGKbLRI1p3puNijFHqU9SJ4lliHKqkAxgUch0nz3LtdyKyrnXGrdUGLI
 QMDYfMx0cBkMedj3GxTr2BhQI+lEG/bQGHqtYR0ix58MoG8dREmNIEzsAuOUU3xBKHT9
 0+fS0dPV+bG9Q0ZdGOp2T0lSoMr1IeYMag9c6/beBjuryxPSbmuhOs06G6xx2m7gi5JJ
 F2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765452638; x=1766057438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Y9tFuYInlA47P9eA2ojGAB9FoYr24JbofHha9k42B4=;
 b=TVQzaGMpewZ5i5PcCxXkJq4k2E+d38IAG+nPPJGSm3W87EgGg+7m9CFEuQTPDDhKpv
 h/qjytQs/0OzzBuO4WG79C//iZcj+O8xtqDyZjrohP1ma8b9ERKqGdczHcGiESQXXMVA
 qMQ7buGWF4+QITSuxg1UCmY6mfLjvl0P9w/HgZuCam0JdFibmbK2h5mZS2MKV96izJpp
 Uy6xXYtdzjFjJs+UJDbKgg3mWJMx4d+FryAE+O9GJ1mPzaP9i0pk+I//ALE14DY2afQn
 90rM2Ne65wrdPAU6DYZP+g52DEUSpRTWqyKBZUAh1CXZdGG66WGWsZFNmXrTg+heOFwK
 Nm5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9/nueNtX/Q/pELQYB4PP9olfF7pTMdRr58Wf/m06USdvEcLXHK1bxaGxug91Q66iXds/8I8aBl0pq@nongnu.org
X-Gm-Message-State: AOJu0Ywlt2khcArx+eADB4xnj2Md5EP7JCyESHiblbeQQ83vb1GwbLe9
 5BSLRbd4Vu2Eiu6cL9btVYTC9Ey1qzsrZ1bpJtbrqi0uuXkYXXyZyuTcRWhyBsdxhL/LTm9OAO0
 6CxABA5C4ZhmtIe9IYu7a+y+KM7pw+Wgm1j7gDRMNLGHNdzXzKEm5PA59
X-Gm-Gg: AY/fxX4AgiBVcrSfzfNEJ0vrTX31j7smSS1JlN4+OqnkraFxFyZwPm4r1T+zTYQks83
 ROlbZGL64RblvQJrxhQ3dhx6iT2g//PL6bQ7Jd4bXXVJEp8pEC0BlYlappMz3Ql9l7UyeJyxIkb
 49kudCNQjBZvVI+84+k9XlSJSbjbp9fk7tdNhstbheL+9AdtUPGiCq3GXHYOmcwq2BvWUYOXvfo
 rHssrBVJLL4WSrylHyWx9Gh8coEZ4B25TkK0pPTDP1ytkUZgDPvuCDybPBlqHQeYkRNx5R8l5wQ
 l5ffO0ZLhF/sDdZ7cQQnlg8BTRCDPcqoTeFCS4KSkMZuqayalLZMVD2AmM29TjJ0zxlME3LFtLA
 ujfGtaiWabpGqPxw=
X-Received: by 2002:a05:600c:1547:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-47a8377e3acmr64056155e9.12.1765452638196; 
 Thu, 11 Dec 2025 03:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/aiXL+VTKlK1niB/7QmaAPq43l5P7go4y7nUlbotyg4bvN63JqE547R5x2lkCEjuHSy9bZw==
X-Received: by 2002:a05:600c:1547:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-47a8377e3acmr64055775e9.12.1765452637793; 
 Thu, 11 Dec 2025 03:30:37 -0800 (PST)
Received: from leonardi-redhat ([151.29.156.207])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89d1149dsm13006925e9.0.2025.12.11.03.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 03:30:37 -0800 (PST)
Date: Thu, 11 Dec 2025 12:30:34 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Oliver Steffen <osteffen@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 3/3] igvm: Fill MADT IGVM parameter field
Message-ID: <wcqcwrshe6nmz3lb5bz2ucdydwgsfxlxbua5jfaly677zsgy4h@dy3nypkedwhi>
References: <20251211103136.1578463-1-osteffen@redhat.com>
 <20251211103136.1578463-4-osteffen@redhat.com>
 <h4256m67shwdq4aouxpqadb2zozhq2f5dfeo74c5jnet5f26kz@a3av5xjfyfow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <h4256m67shwdq4aouxpqadb2zozhq2f5dfeo74c5jnet5f26kz@a3av5xjfyfow>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

On Thu, Dec 11, 2025 at 12:15:59PM +0100, Gerd Hoffmann wrote:
>  Hi,
>
>> +static int qigvm_initialization_madt(QIgvm *ctx,
>> +                                     const uint8_t *header_data, Error **errp)
>> +{
>> +    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>> +    QIgvmParameterData *param_entry;
>> +
>> +    if (ctx->madt == NULL) {
>> +        return 0;
>> +    }
>> +
>> +    /* Find the parameter area that should hold the device tree */
>
>cut+paste error in the comment.
>
>> +    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
>> +    {
>> +        if (param_entry->index == param->parameter_area_index) {
>
>Hmm, that is a pattern repeated a number of times already in the igvm
>code.  Should we factor that out into a helper function?

+1

>
>>  static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>>  {
>>      int32_t header_count;
>> @@ -892,7 +925,7 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
>>  }
>>
>>  int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>> -                       bool onlyVpContext, Error **errp)
>> +                       bool onlyVpContext, GArray *madt, Error **errp)
>
>I'd like to see less parameters for this function, not more.
>
>I think sensible options here are:
>
>  (a) store the madt pointer in IgvmCfg, or
>  (b) pass MachineState instead of ConfidentialGuestSupport, so
>      we can use the MachineState here to generate the madt.
>
>Luigi, any opinion?  I think device tree support will need access to
>MachineState too, and I think both madt and dt should take the same
>approach here.

I have a slight preference over MachineState as it's more generic and we 
don't need to add more fields in IgvmCfg for new features.

Luigi


