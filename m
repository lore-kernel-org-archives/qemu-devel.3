Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057D9CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUP6A-000344-7o; Tue, 02 Jun 2026 09:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1wUNHA-0006tt-Nq
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 07:27:17 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1wUNH8-0005sG-9e
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 07:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780399634; x=1811935634;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vFe0YHJbZeLES+sUauMUh5hZ46dD8ew9Ej6lDFLoT9Q=;
 b=gNuzrgBUdLVsiR0/V8cqwB0xcmNqp6PPtYnEsfNj+/zuUMhu7TY3ykxb
 XB6SYVPANIwy/tAQBML2N2RgtTq16RmgI9cCZUFCODvOCCl74bwkjmRTt
 FRw0k0dEJTsfm7CoUFb7IGNpRptvVyKpMLWGEO6l+rBmpCkeN2qXfgM43
 AqjQ49V6z+KFGEHiUfxG7ZVqyhrWxH7U4qv2vtZXu6uT6ttqHHc3nc8Ub
 kddF31RuqMWNXsv4RXrVyQwP/lJrDD5OoedS8Bgd2kFyaDIhJYrHF7IoT
 jqUohJ0pL7XFeTPxZpk6FmDjYrrooYtlwq6w7gks5onRfESHxu2z/KgSE A==;
X-CSE-ConnectionGUID: u5Q6Y+fDS4u7QV7xlGKHPQ==
X-CSE-MsgGUID: nqYCOQUbRty4FtMXNH+kcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84805008"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="84805008"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 04:27:08 -0700
X-CSE-ConnectionGUID: 57WJuzJhQk+bJIT4F8AZnw==
X-CSE-MsgGUID: InV+5AxmRSKrEz4WoNh7bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="240879149"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 04:26:48 -0700
Date: Tue, 2 Jun 2026 14:26:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org,
 Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>,
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, qemu-devel@nongnu.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's
 page buffer
Message-ID: <ah699hwLxIIOZ0-7@ashevche-desk.local>
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-1-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521133326.2465264-1-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=andriy.shevchenko@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2026 09:23:59 -0400
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

On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> 
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.

...

> +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);

get_free_page() (or how it is called)?

> +	if (!elem_buf)
> +		return -ENOMEM;
> +
>  	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> -		/* Replace \n with comma */
> -		if (i)
> -			buffer[off - 1] = ',';
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get(buffer + off, &p);
> +		ret = arr->ops->get(elem_buf, &p);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
> +		ret = min(ret, (int)(PAGE_SIZE - 1 - off));

It's usually discouraged to use castings in min/max/clamp. Can we make ret long
or do something different here?

> +		if (!ret)
> +			break;

> +		/* Replace the previous element's trailing newline with a comma. */
> +		if (i)
> +			buffer[off - 1] = ',';

Can't we do this after with help of strreplace()?

> +		memcpy(buffer + off, elem_buf, ret);
>  		off += ret;
> +		if (off == PAGE_SIZE - 1)
> +			break;
>  	}
>  	buffer[off] = '\0';
> -	return off;
> +	ret = off;
> +out:
> +	kfree(elem_buf);
> +	return ret;

-- 
With Best Regards,
Andy Shevchenko



