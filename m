Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA28E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6Xb-0002qY-11; Fri, 13 Dec 2024 09:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tM6XZ-0002qH-Pe
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:21:13 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tM6XX-00025K-Fx
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:21:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so21780495e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734099669; x=1734704469; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CvAkTEd2t0N78KnkaFY7J8Ykhsjgz8VYz8UpFQcFSoQ=;
 b=upc4hK6uuB1LYMQ5dcQCWhNpB6jEvTEbGbN9TWiLzGuDceJsoyFKSvcj3SlWvd8JLA
 pNQXJ3zu1xIQZmsXQUApTuqcSnY7SRKsEsjedtsKLoRKZIfIg97umhgN3R0Wiu1RsFHq
 Og+25wqnJ5S0LrA1nkMEttcUmcT13hBmW80FJhuYIehqlK8fpXsq95SyS5Mhfws0u0eX
 LdctSqmZoP03Bye9mAarYM8rLlOkxbKPIhgJtTv5zIu0AbDKjd+mJH4WtD20lVjq+zci
 Mf2FJypXM/6XrpGW9s8+pjb//GIn3F73kRVivRK5eHes3X6lSwTOIVLO5TU3wBogFeDW
 SpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734099669; x=1734704469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvAkTEd2t0N78KnkaFY7J8Ykhsjgz8VYz8UpFQcFSoQ=;
 b=fAxp5dPwjXCKZBEbVuhUM0J6YuLvAICjeDWlbKHqXqmcAtukupt/sZStezDsUgwZ8J
 ON3mAeVdfsXU2eyO4SMBOjqf1F8//zVcQu4KI3+0yB9xiKrPcCnrP1JRWQqB4BQxhwYP
 7AZL7+LjyysRp/rIfCWjw8Oy7Chu/7aBJNijbnU/td3D0zLOrRX9BzU0yaHGR1BgEtiz
 fX0r70vJ/zzusphRJnUcPQ10LO2PS80/lWk8QJ+Vv/afyRZIBTKVsU9EXklhaTszyVk0
 j7vEMatjmzBpGpK5CMyws10wCC5RNAZMR+qfmNbm8ADO55G3noQfGuNwoBMq65oHiDga
 C2XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7AuX8hxyK6InZqJlQEBuUekMAve8fMtIYS8ZGxqAqbH/q9e5k9nEPqI5bLvGEu/RzZyC+wwArn7wZ@nongnu.org
X-Gm-Message-State: AOJu0Yziytw7VhxfyDbvAWd+nX97BjexHLw8ZgLfzi1vdUUkc53HUScI
 ngO5EGS34hkcnFxFPeqPeLPriTi1/haAf6yfOuCwRXnNFz6BKJdvwjc8dlEGW8s=
X-Gm-Gg: ASbGncttX8/gJR6QKNmwPkJXR0lajG39L4XNBCWkV9vm+r/Dwi7hthRSM6PuggVnQRp
 VZae3xViK9S5EvToGDslZDiekbMEJYMR/KgTGg7AlyvuPZqm0C+M881BfitiQJk9ez+ZjUGu9Cs
 VQJThvGPWQYjHALP11mlBTH8+Ft2WCA2rvE7e9D0DZ3SUuhlXMDffnIAonwDKv6vS1GFoXFxAzg
 zN0ARE48LOQx88Qwyr8YfeANUeE/7bsm4tqAC0y8vfsO5Ul6GduQ0A=
X-Google-Smtp-Source: AGHT+IFN/FsRYRGHjcAYYYKeXIveLecauk0OkpjXoob7/5bS6to2uBs27rIfd9QSYXv/8+ECb6hSDA==
X-Received: by 2002:a05:600c:a089:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-4362aaa652emr24683755e9.32.1734099669132; 
 Fri, 13 Dec 2024 06:21:09 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625553234sm52018665e9.3.2024.12.13.06.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:21:08 -0800 (PST)
Date: Fri, 13 Dec 2024 14:21:33 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
Message-ID: <20241213142133.GC2962236@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
 <bf154441-1e0a-4029-946a-727621395e25@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf154441-1e0a-4029-946a-727621395e25@linux.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Mon, Dec 09, 2024 at 05:08:37PM -0500, Stefan Berger wrote:
> >   typedef struct {
> >       hwaddr base;
> >       hwaddr size;
> > +    uint8_t *data;
> > +    RmeLogFiletype *filetype;
> >   } RmeRamRegion;
> > +typedef struct {
> > +    char        signature[16];
> > +    char        name[32];
> > +    char        version[40];
> > +    uint64_t    ram_size;
> > +    uint32_t    num_cpus;
> > +    uint64_t    flags;
> > +} EventLogVmmVersion;
> > +
> > +typedef struct {
> > +    uint32_t    id;
> > +    uint32_t    data_size;
> > +    uint8_t     data[];
> > +} EventLogTagged;
> > +
> 
> 
> > +#define EVENT_LOG_TAG_REALM_CREATE  1
> > +#define EVENT_LOG_TAG_INIT_RIPAS    2
> > +#define EVENT_LOG_TAG_REC_CREATE    3
> > +
> If these are ARM-related structures and constants from a document you may
> want to mention the document you got them from.

Agreed. At the moment they're just numbers and structures I made up [1].
I'm not certain in which standard they should go. TCG would seem
appropriate, or IETF is also used for protocols related to confidential
computing attestation. Or maybe it could live in the reference verifier
documentation. QEMU docs wouldn't be the best place because VMMs might
been reluctant to adopt it because they don't consider it a standard (like
cloud-hv and fw_cfg)

When researching this I found TCG event types and payloads that only seem
to be documented in their respective project:
* efistub [2] with
  * EV_EVENT_TAG, id=0x8F3B22EC, data="Linux initrd",
  * EV_EVENT_TAG, id=0x8F3B22ED, data="LOADED_IMAGE::LoadOptions"
* grub [3] with a few EV_IPL
* systemd [4] with various EV_EVENT_TAG and EV_IPL

I'm wondering if we could create a common registry somewhere for these,
like IANA or somewhere informal.


[1] https://github.com/veraison/cca-realm-measurements/blob/main/docs/measurement-log.md#rim-log
[2] https://lore.kernel.org/all/20211119114745.1560453-1-ilias.apalodimas@linaro.org/
[3] https://www.gnu.org/software/grub/manual/grub/html_node/Measured-Boot.html
[4] https://systemd.io/TPM2_PCR_MEASUREMENTS/


> > +/* Log VM type and Realm Descriptor create */
> > +static int rme_log_realm_create(Error **errp)
> > +{
> > +    int ret;
> > +    ARMCPU *cpu;
> > +    EventLogVmmVersion vmm_version = {
> > +        .signature = "VM VERSION",
> > +        .name = "QEMU",
> > +        .version = "9.1", /* TODO: dynamic */
> 
> $ grep -r QEMU_VERSION_M build/
> build/config-host.h:#define QEMU_VERSION_MAJOR 9
> build/config-host.h:#define QEMU_VERSION_MICRO 93
> build/config-host.h:#define QEMU_VERSION_MINOR 1
> 
> $ cat VERSION
> 9.1.93

Ah yes that would work, thank you

> > +static int rme_log_rec(uint64_t flags, uint64_t pc, uint64_t gprs[8], Error **errp)
> > +{
> 
> $ ./scripts/checkpatch.pl ./tmp/*.patch
> [...]
> Checking ./tmp/0002-target-arm-kvm-rme-Add-measurement-log.patch...
> WARNING: line over 80 characters
> #353: FILE: target/arm/kvm-rme.c:303:
> +static int rme_log_rec(uint64_t flags, uint64_t pc, uint64_t gprs[8], Error
> **errp)
> 
> May want to run this on all patches.
> 
> Rest LGTM.

Thank you!

Jean

