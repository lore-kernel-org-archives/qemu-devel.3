Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BA606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z1nRtpMF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUPYZ-0003sY-Cu; Fri, 20 Nov 2026 09:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xUPYX-0003rP-7u; Fri, 20 Nov 2026 09:25:37 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xUPYV-0002Ma-Hl; Fri, 20 Nov 2026 09:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795184736; x=1826720736;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EefFb8ASchTKj58/+zHayDxohZkIqeeZhPY3tyC3SDU=;
 b=Z1nRtpMFdL8+w9Vc/m55f0X6uLX/k/eXDDgv5E1XW2vguzkMyQFu2nW6
 bHpgsNJx7mBOX4a/BTV/eGcR9CL2flv7W4Tsak4tpZZkTefz1Moh7WhyQ
 zsPVZLIvOPnwPs/kA/l1SVjcTHf9x+kIT4ek+hY0aFH4ffFxx8p1yt0O2
 ZJAdnJAjumByEil+vyZTuMSHqXI+acxwAD2RBDKreF3hLg2xRBnK0Dr0d
 fBuAtTuU4AcMofKKRer7IHnvbHtV+RmfadEJLuzHA1/Ydnu0BMebMd+65
 hqjufW4Ac2/hQvPIwPxRMaXex8YVi6OIa+Kp3WCvpwKWji/fvh3Y+F605 g==;
X-CSE-ConnectionGUID: 3d4qAjPiRcuf6qZ6p1hipA==
X-CSE-MsgGUID: xUIij+MzQOejV8jSHgQdWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4094895"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4094895"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 06:25:27 -0800
X-CSE-ConnectionGUID: DY2aMGnqSVeo0zKywDJLQQ==
X-CSE-MsgGUID: boomZ4/wRUerTg/HtsyCjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="10720407"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by orviesa002.jf.intel.com with ESMTP; 20 Nov 2026 06:25:25 -0800
Date: Fri, 20 Nov 2026 22:25:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH for-12.0 5/6] rust: Replace vmstate_validate with post_load
Message-ID: <awBYUwFhba1AYpZb@intel.com>
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-6-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120124923.1656220-6-peterx@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On Fri, Nov 20, 2026 at 07:49:22AM -0500, Peter Xu wrote:
> Date: Fri, 20 Nov 2026 07:49:22 -0500
> From: Peter Xu <peterx@redhat.com>
> Subject: [PATCH for-12.0 5/6] rust: Replace vmstate_validate with post_load
> X-Mailer: git-send-email 2.56.0
> 
> We dropped all of that in C, drop that in Rust too.

but rust is using the different way to address this case :)

> The goal is to remove
> the VMSTATE_VALIDATE() together with VMS_MUST_EXIST.
> 
> Use post_load instead for the check.

...

>  // HPETRegistersMigration is generated by ToMigrationState macro.
>  impl_vmstate_struct!(
>      HPETRegistersMigration,
> @@ -1109,7 +1111,6 @@ fn restore_migrated_state(
>          .fields(vmstate_fields! {
>              vmstate_of!(HPETState, regs),
>              vmstate_of!(HPETState, num_timers_save),
> -            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
>              vmstate_of!(HPETState, timers[0 .. num_timers_save], HPETState::validate_num_timers).with_version_id(0),
                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Before this patch, the test method didn't work since vmstate_validate!
has already done the check. But, IIUC, when vmstate_validate! goes away,
this test seems necessary for rust side since it can help avoid overflow
caused by num_timers_save (maybe it can be greater than HPET_MAX_TIMERS?
before the commit 7be175e65f07).

>          })

So LGTM for the change in rust hpet,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


And I find C side (in patch 3) handles this differently via using the local
"num_timers".

In this case, I think we still have the option to keep the logic
consistent between C and Rust :). We can add VMSTATE_STRUCT_VARRAY_TEST
for C side:

#define VMSTATE_STRUCT_VARRAY_TEST(_field, _state, _field_num, _test,\
                                   _version, _vmsd, _type) {\
    .name         = (stringify(_field)),\
    .num_indirect = vmstate_field_offset(_state, _field_num),\
    .version_id   = (_version),\
    .field_exists = (_test),\
    .vmsd         = &(_vmsd),\
    .size         = sizeof(_type),\
    .flags        = VMS_STRUCT | VMS_VARRAY,\
    .offset       = vmstate_offset_varray(_state, _field, _type),\
}

and make C hpet use this:

        VMSTATE_STRUCT_VARRAY_TEST(timer, HPETState, num_timers_save,
                                   hpet_validate_num_timers, 0,
                                   vmstate_hpet_timer, HPETTimer),

Alternatively, we can also have Rust use num_timers (as u8) for timers
array VMState, but this will bring back the conversion issue between u8
and usize, which is the commit b3bf86b8936d & 6e85cfe44c0e want to fix...

Thanks,
Zhao


