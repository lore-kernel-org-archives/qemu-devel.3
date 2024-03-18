Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15538C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7nx-0002uU-AJ; Mon, 18 Mar 2024 03:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rm7nn-0002u2-W4
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:01 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rm7nj-0008U8-Lc
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710748376; x=1742284376;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WQn8QPeV+2aIGgkNJLr2LGepKhFCY7X2ShJr+Wuilng=;
 b=KLMINBr6dnygcyJA1Qe/W1hogOtBEj2tqsYCRk/KOaDJbAB6L2eOOyWV
 KzOQG2TbQAwcNhPOlN6rE3W2El8Ur5Mgcmh7ic+nH2ug5qN15Z33e6fls
 J2oLRUz3Em2a/YRazGll73kNmd7fZOAJ9r8fVUSKU7xYv4cuel7rn/CvS
 cjRUQATcC8roJLTT0QkSWyRHtUw8hRfhRC2dy0RfVU18PbGnil27yt8Nd
 0/zEvhfuGTZq8vS1D1ugDC0i9TqMNMOqg4VWGVtQN0tErfdL6XiVPX+46
 YacoQYgA4pmS0rdzSO269DD8fHzjeVd4usDwlGYPr22sUgh88qXQhpxaO w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16944784"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="16944784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 00:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="50827487"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 18 Mar 2024 00:52:47 -0700
Date: Mon, 18 Mar 2024 16:06:38 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 03/14] hw/core/machine-smp: Simplify variables'
 initialization in machine_parse_smp_config()
Message-ID: <Zff2DgJa+eHPBhgJ@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
 <c2bd5503-7ab1-41b7-af81-2f5bf5992ad3@redhat.com>
 <Zesv4W8DKteGeE/a@intel.com>
 <CAE8KmOxHNTGkE-8Xd+RXOuHNmyHqPwU4HcYRO6qHBGVAy6nAew@mail.gmail.com>
 <Ze6UmDoFD5Qd8AC/@intel.com>
 <CAE8KmOzwrLY5ag_FKvX-ovAopfPeYSqFHc3-sdQj_zt_28tH5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOzwrLY5ag_FKvX-ovAopfPeYSqFHc3-sdQj_zt_28tH5A@mail.gmail.com>
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Wed, Mar 13, 2024 at 04:22:30PM +0530, Prasad Pandit wrote:
> Date: Wed, 13 Mar 2024 16:22:30 +0530
> From: Prasad Pandit <ppandit@redhat.com>
> Subject: Re: [PATCH 03/14] hw/core/machine-smp: Simplify variables'
>  initialization in machine_parse_smp_config()
> 
> Hello Zhao,
> 
> > (Communicating with you also helped me to understand the QAPI related parts.)
> 
> * I'm also visiting QAPI code parts for the first time. Thanks to you. :)
> 
> On Mon, 11 Mar 2024 at 10:36, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> > SMPConfiguration is created and set in machine_set_smp().
> > Firstly, it is created by g_autoptr(), and then it is initialized by
> > visit_type_SMPConfiguration().
> >
> > The visit_type_SMPConfiguration() is generated by
> > gen_visit_object_members() in scripts/qapi/visit.py.
> >
> > IIUC, in visit_type_SMPConfiguration() (let's have a look at
> > gen_visit_object_members()), there's no explicit initialization of
> > SMPConfiguration() (i.e., the parameter named "%(c_name)s *obj" in
> > gen_visit_object_members()). For int type, has_* means that the field is
> > set.
> >
> 
> * Thank you for the above details, appreciate it. I added few
> fprintf() calls to visit_type_SMPConfiguration() to see what user
> values it receives
> ===
> $ ./qemu-system-x86_64 -smp cores=2,maxcpus=2,cpus=1,sockets=2
> visit_type_SMPConfiguration: name: smp
>         has_cpus: 1:1
>  has_drawvers: 0:0
>       has_books: 0:0
>   has_sockets: 1:2
>         has_dies: 0:0
>  has_clusters: 0:0
>      has_cores: 1:2
>   has_threads: 0:0
> has_maxcpus: 1:2
> qemu-system-x86_64: Invalid CPU topology: product of the hierarchy
> must match maxcpus: sockets (2) * dies (1) * cores (2) * threads (0)
> != maxcpus (2)
> ===
> * As seen above, undefined -smp fields (both has_xxxx and xxxx) are
> set to zero(0).
> 
> ===
> main
>  qemu_init
>   qemu_apply_machine_options
>    object_set_properties_from_keyval
>     object_set_properties_from_qdict
>      object_property_set
>       machine_set_smp
>        visit_type_SMPConfiguration
>         visit_start_struct
> (gdb) p v->start_struct
> $4 = ... 0x5555570248e4 <qobject_input_start_struct>
> (gdb)
> (gdb)
>  qobject_input_start_struct
>    if (obj) {
>         *obj = g_malloc0(size);
>     }
> ===
> * Stepping through function calls in gdb(1) revealed above call
> sequence which leads to  'SMPConfiguration **'  objects allocation by
> g_malloc0.

Thanks! I misunderstood, it turns out that the initialization is done here.

> 
> > This means if user doesn't initialize some field, the the value should
> > be considerred as unreliable. And I guess for int, the default
> > initialization value is the same as if we had declared a regular integer
> > variable. But anyway, fields that are not explicitly initialized should
> > not be accessed.
> 
> * g_malloc0() allocating 'SMPConfiguration **' object above assures us
> that undefined -smp fields shall always be zero(0).
> 
> * 'obj->has_xxxx' field is set only if the user has supplied the
> variable value, otherwise it remains set to zero(0).
>    visit_type_SMPConfiguration_members
>      ->visit_optional
>        ->v->optional
>         -> qobject_input_optional

Yes, you're right!

> 
> * Overall, I think there is scope to simplify the
> 'machine_parse_smp_config()' function by using SMPConfiguration
> field(s) ones.

Indeed, as you say, these items are initialized to 0 by default.

I think, however, that the initialization is so far away from where the
smp is currently parsed that one can't easily confirm it (thanks for
your confirmation!).

From a code readability view, the fact that we're explicitly
initializing to 0 again here brings little overhead, but makes the code
more readable as well as easier to maintain. I think the small redundancy
here is worth it.

Also, in other use cases people always relies on fields marked by has_*,
and there is no (or less?) precedent for direct access to places where
has_* is not set. I understand that this is also a habit, i.e., fields
with a has_* of False by default are unreliable and avoid going directly
to them.

Regards,
Zhao


