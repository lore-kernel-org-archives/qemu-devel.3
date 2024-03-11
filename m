Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA3CC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 05:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjXsG-00031q-Ti; Mon, 11 Mar 2024 01:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjXs8-00031X-1V
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 01:06:50 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjXs2-0003P5-Rb
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 01:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710133603; x=1741669603;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=tXDb09cw6/obna1Ci/hHdn8ULd2D7Jv1KQsOEXj4WaM=;
 b=ZnyPoN3eYWBTAx0fJT5gLbOn1qsrIpTer82SEZNP/nRc5boopkZv/+3r
 m4D0kZweCEh2Re+cvqsWiv9v032aVY/SEVk9Re0jM/Em8WmlcPfAmdFZx
 OiZnSwWI6pM1adkh+FA5y+UEGoa3F4+wrO6lUXcQdc//YYFqRrXgymuz/
 NAy38Z6NZT3w3kK9t5m2EJ3zsUX7KLie6Mqn9Ui4/pDcmXoSHvdwV26Fn
 unwianvGZei3qjZxiaL8kFlsuxZMRWcahi7pgI/TmRTK8VcbA7UOp8MIx
 d3lX2qvxe6h6e18y1QeYAAUxQMk1QphxL9ap5h8krMi/sCqQj+v4mw14e A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="5375573"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="5375573"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 22:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="11484682"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 10 Mar 2024 22:06:35 -0700
Date: Mon, 11 Mar 2024 13:20:24 +0800
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
Message-ID: <Ze6UmDoFD5Qd8AC/@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
 <c2bd5503-7ab1-41b7-af81-2f5bf5992ad3@redhat.com>
 <Zesv4W8DKteGeE/a@intel.com>
 <CAE8KmOxHNTGkE-8Xd+RXOuHNmyHqPwU4HcYRO6qHBGVAy6nAew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8KmOxHNTGkE-8Xd+RXOuHNmyHqPwU4HcYRO6qHBGVAy6nAew@mail.gmail.com>
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
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

Hi Prasad (and also welcome folks correct me),

> On Fri, 8 Mar 2024 at 20:50, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> > On Fri, Mar 08, 2024 at 02:20:45PM +0100, Thomas Huth wrote:
> > > Can we always rely on that? ... or is this just by luck due to the current
> > > implementation? In the latter case, I'd maybe rather drop this patch again.
> >
> > Thanks for the correction, I revisited and referenced more similar use
> > cases, and indeed, only if the flag "has_*" is true, its corresponding
> > field should be considered reliable.
> 
> * Is this because 'SMPConfiguration config'  fields are not always
> initialized with default values?

SMPConfiguration is created and set in machine_set_smp().

Firstly, it is created by g_autoptr(), and then it is initialized by
visit_type_SMPConfiguration().

The visit_type_SMPConfiguration() is generated by
gen_visit_object_members() in scripts/qapi/visit.py.

The g_autoptr() requires user to initialize:

  You must initialise the variable in some way — either by use of an
  initialiser or by ensuring that it is assigned to unconditionally
  before it goes out of scope.

This means if user doesn't initialize some field, the the value should
be considerred as unreliable. And I guess for int, the default
initialization value is the same as if we had declared a regular integer
variable. But anyway, fields that are not explicitly initialized should
not be accessed.

IIUC, in visit_type_SMPConfiguration() (let's have a look at
gen_visit_object_members()), there's no explicit initialization of
SMPConfiguration() (i.e., the parameter named "%(c_name)s *obj" in
gen_visit_object_members()). For int type, has_* means that the field is
set.

Therefore, we shouldn't rely on the uninitialized fields and should
check the has_*.

> Is that a bug?

It's not a bug, and it could be a simplification of the automatic code
generation.

> Having 'SMPConfiguration' fields initialised to known default values could
> help to unify/simplify code which uses those fields.

I realized that keeping the check for has_* here would help improve code
readability; after all, it's more of a pain to go back and check
scripts.

> > Keeping explicit checking on has_* and explicit initialization of these
> > topology variables makes the code more readable.
> >
> > This patch is over-optimized and I would drop it.
> 
> * Could we then simplify it in the following if <expression>
> ===
>       if ((config->has_cpus && config->cpus == 0) ||
>           ... ||
>           (config->has_maxcpus && config->maxcpus == 0))
> 
> could be
> 
>       if (!cpus || !drawers || ... || !maxcpus) { ... }
> ===
>

This doesn't work since the above check is used to identify if user sets
parameters as 0 explicitly, which needs to check both has_* and the
specific field value.

(Communicating with you also helped me to understand the QAPI related
parts.)

Thanks,
Zhao



