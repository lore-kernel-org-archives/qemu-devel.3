Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B073ECD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV2Js-00056l-VY; Thu, 04 Jun 2026 03:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wV2Jp-00056L-Jz; Thu, 04 Jun 2026 03:16:46 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wV2Jn-0002i5-Pm; Thu, 04 Jun 2026 03:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780554430; bh=I5JCem6ReI09Y6M6i3h/53O1GGEcPnif8Nvqy6HgzwE=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:References:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=ngPmGFGJvL7jRkMCnCRC4UkNw+2po1vjBganVL9GrDpB1Yf+ivWU1gDYSt6755jk9
 uS/uT/s5FpLrLO0N7d9VvR9TAkswL9fVW5krVcYYWAi6agSLclUY23f1Eof9A32ugm
 tiAE20VWxusxMmup6g9nLbd/0sr2NRwAsN8nS+mU=
Received: by be1-1.in.mailobj.net [192.168.91.11] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Thu,  4 Jun 2026 08:26:55 +0200 (CEST)
X-EA-Auth: yGRVpfFkQkmgIXjOEi9j/nsbc8QMt21cHnmIKyoL4Am++zD/X2o63ye8hzBuqR09g47cgzw6GXyB02Rg7kO6iSROXvjqSuAv
Message-ID: <a081403b-54e3-4f17-ac20-d2580ab23ed1@mailo.com>
Date: Thu, 4 Jun 2026 08:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is
 called only once per bus
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, skolothumtho@nvidia.com, nicolinc@nvidia.com,
 nathanc@nvidia.com
References: <20260603124415.1120808-1-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603124415.1120808-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/6/26 14:44, Eric Auger wrote:
> Currently it is possible to attach several arm-smmuv3 devices to the
> same bus although it is a wrong setup.
> 
> Change the prototype of pci_setup_iommu_per_bus to pass an error
> handle. This latter is set when iommu_per_bus is already set and
> used by the single caller (smmu_base_realize) to report a useful
> error to the end-user.
> 
> While at it document pci_setup_iommu_per_bus callback in the header.
> 
> Fixes: 66d2f665e163 ("hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> ---
> 
> v1 -> v2:
> - in smmu_base_realize, return if pci_setup_iommu_per_bus returns false
>    (Philippe)
> ---
>   include/hw/pci/pci.h | 16 +++++++++++++++-
>   hw/arm/smmu-common.c |  4 +++-
>   hw/pci/pci.c         |  9 +++++++--
>   3 files changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>


