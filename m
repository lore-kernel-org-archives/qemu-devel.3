Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1690CC25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 08:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBs6C-0006uF-Vg; Tue, 28 May 2024 04:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBs6A-0006s3-Py
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:22:22 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBs68-0002Fx-M1
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716884541; x=1748420541;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=f3svJEEuwU8zXQTsSySTUzD86Ayyx1BToP+oN07MDVY=;
 b=AZLWlcjIJclYEFcsVu0BNeJvLMm+NM/7FiqZd4cciekiR8RBhtxFiNNu
 JnzoXkADKWRQO7lsQ6Se2mbi8S829qWGcb+fhGmKXDk1yOYge68jETI5b
 4kzrdNtIC4yGnEFZxosuc2AtbGmupQDzROe4F9+9ZpWzT5eROchDrUfgk
 P4RbLe5J/jCOzd3OTsimjs5+FyXrNQjPk44SWPbMf2oLlajuqTGp+keih
 e5zELQ55BDpcAL6dwFnpqB4M/IR24RHXTWJi8ieUla0MmxMGjRPh4vZVp
 4D3MmtUsGOMueHxEd7AjItWX/zSicdlE9kPMmCxYmyc20CGTs5hgtxIT8 Q==;
X-CSE-ConnectionGUID: 9YcfnTaXSM6YjbDttE/jyQ==
X-CSE-MsgGUID: ZSgeo0iaR+CaQrpHjicRYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24627370"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="24627370"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 01:22:19 -0700
X-CSE-ConnectionGUID: xvDVnYjpQziWiPsEbfiIDg==
X-CSE-MsgGUID: 9ESX5TKGTj6IPR/hnkRUIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="39806405"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 01:22:16 -0700
Date: Tue, 28 May 2024 16:37:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 3/6] scripts/simpletrace-rust: Add helpers to parse trace
 file
Message-ID: <ZlWX00EGcPdBezpy@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-4-zhao1.liu@intel.com>
 <20240527203938.GD913874@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527203938.GD913874@fedora.redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> > +    fn read_type(mut fobj: &File) -> Result<RecordType>
> > +    {
> > +        let mut tbuf = [0u8; 8];
> > +        if let Err(e) = fobj.read_exact(&mut tbuf) {
> > +            if e.kind() == ErrorKind::UnexpectedEof {
> > +                return Ok(RecordType::Empty);
> > +            } else {
> > +                return Err(Error::ReadFile(e));
> > +            }
> > +        }
> > +
> > +        /*
> > +         * Safe because the layout of the trace record requires us to parse
> > +         * the type first, and then there is a check on the validity of the
> > +         * record type.
> > +         */
> > +        let raw_t =
> > +            unsafe { std::mem::transmute::<[u8; 8], RecordRawType>(tbuf) };
> 
> A safe alternative: https://doc.rust-lang.org/std/primitive.u64.html#method.from_ne_bytes?

Thanks! Will use it.

> > +        match raw_t.rtype {
> > +            RECORD_TYPE_MAPPING => Ok(RecordType::Mapping),
> > +            RECORD_TYPE_EVENT => Ok(RecordType::Event),
> > +            _ => Err(Error::UnknownRecType(raw_t.rtype)),
> > +        }
> > +    }
> > +}

[snip]

> > +{
> > +    fn read_header(mut fobj: &File) -> Result<Self>
> > +    {
> > +        let mut raw_hdr = [0u8; 24];
> > +        fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
> > +
> > +        /*
> > +         * Safe because the size of log header (struct LogHeader)
> > +         * is 24 bytes, which is ensured by simple trace backend.
> > +         */
> > +        let hdr =
> > +            unsafe { std::mem::transmute::<[u8; 24], LogHeader>(raw_hdr) };
> 
> Or u64::from_ne_bytes() for each field.

Will do.

> > +        Ok(hdr)
> > +    }
> > +}

[snip]

> > +impl ReadHeader for RecordHeader
> > +{
> > +    fn read_header(mut fobj: &File) -> Result<Self>
> > +    {
> > +        let mut raw_hdr = [0u8; 24];
> > +        fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
> > +
> > +        /*
> > +         * Safe because the size of record header (struct RecordHeader)
> > +         * is 24 bytes, which is ensured by simple trace backend.
> > +         */
> > +        let hdr: RecordHeader =
> > +            unsafe { std::mem::transmute::<[u8; 24], RecordHeader>(raw_hdr) };
> 
> Or u64::from_ne_bytes() and u32::from_ne_bytes() for all fields.

Will do.

Thanks,
Zhao


