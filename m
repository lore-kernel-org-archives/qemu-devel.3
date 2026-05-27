Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20FACD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 09:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSAt8-0003jf-C0; Wed, 27 May 2026 05:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wSAt4-0003gj-Tl
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:49:19 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wSAt3-000237-1f
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779875356; x=1811411356;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=KIZpIO3E1LSg3vIlTDuhfNG7G374I1SodgLS2izX+Zo=;
 b=gyD9YKpTFS2JSG1lEBhOOWtJD5YoKx75cKX2BrZGvJ12boBK9l7cVy9t
 oDUmQzIyNl5fdFIPmgC3PPEnEKxCgEvypfLuyjUnoj3jgelpSaX8v19b7
 3VAJVGxGJ1dQtwpgV4VdOGRqE1mZN2ymq/LjeINct2W/1fmzNh9g8KIfc
 3HXP7qwNI4VqxBwhL2O2FdQby6qHjTHAfHHQbZHXOlubyiuBN88X6Klgj
 5l3wZwyEJoPqWVj5LLc+cvqypfJUSsOBlHUzQenH5NTypUEpxOfU3F52r
 IlYXMW8yqt4QEwMq01/ogsYLSFOO8rhVDJTZlQueGnzDQGFpXaNylQY/q w==;
X-CSE-ConnectionGUID: TkwF3sm3SKKnwt+CS6UDLg==
X-CSE-MsgGUID: vPZJSTVzTBSD5F82OtsBSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="98275931"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="98275931"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:49:15 -0700
X-CSE-ConnectionGUID: PW/kkMU4Tg+Kvq6kiiFVKA==
X-CSE-MsgGUID: kNKadCt3SUeD7OeT/W/WUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="239584729"
Received: from unknown (HELO [10.239.158.45]) ([10.239.158.45])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:49:15 -0700
Message-ID: <f44e5bb0-c4d7-428f-aef9-999a591263c3@intel.com>
Date: Wed, 27 May 2026 17:49:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] system/physmem: make ram_block_discard_range()
 handle guest_memfd
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-11-bdf61e57c1e1@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260504-rdm5-v4-11-bdf61e57c1e1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5/4/2026 8:30 PM, Marc-André Lureau wrote:
> Most callers of ram_block_discard_range() want to discard both the
> shared and guest_memfd backing. Only kvm_convert_memory() intentionally
> discards a single plane during private/shared conversions.
> 
> Rename the current implementation to ram_block_discard_shared_range()
> and make ram_block_discard_range() a composite that also discards
> guest_memfd when present (rb->guest_memfd >= 0). This ensures callers
> like virtio-mem, virtio-balloon, hv-balloon, migration.. reclaim
> private pages on discard.
> 
> Update kvm_convert_memory() to use the plane-specific
> ram_block_discard_shared_range() since it only needs to discard
> the shared backing when converting to private.
> 
> Likewise, after TDVF image copy, use ram_block_discard_shared_range().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

