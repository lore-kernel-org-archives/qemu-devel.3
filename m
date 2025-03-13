Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61032C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsgkT-0003aC-Eh; Thu, 13 Mar 2025 07:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tsgkO-0003YW-Nk
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:29:09 -0400
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tsgkH-0003O6-Na
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:29:08 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 391EF458D2;
 Thu, 13 Mar 2025 12:28:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1741865339;
 bh=qZCSWQnDPpbMbnY7tIoeApE56R9FBiDgXUZ6ssndan8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T1CVmN53G76aBPcei9kWSlCiwqcXHlBfkJDuEWZp5tx9qti/0Uqsv6G9dhnAnFd/D
 sQi2l4FxRLouNrwXwXrNBEEyMpRU/jYl0wtlJntevTGedjoyb8dDBvjmMuWtvM2xne
 XWsdoU09+qiCkub8m5Z7DqytAEUY0D2aksLcM/Cd4JsmYeA3P0RINf+iNl5J3wR8Q3
 Z2BX4fvAGHnUFFZ+LeyUWaK+2eTZ1f4IAqb3wcZuHRJV0+82vEYKd3Mz3K8K1a9/r4
 V5NnS8saDE+7VG1vNgOZZ9f1rQq2+QmMsQKwMoTdTZnpCnqwy6qs4OtaacA5D/2k4G
 24YMes/Awflhw==
Date: Thu, 13 Mar 2025 12:28:58 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <Z9LBesd3k8OlC7eN@8bytes.org>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
 <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
 <Z9K6nrGwnyob9tED@8bytes.org>
 <CAK3XEhNDnX1+W9jZ_MZaSYKHBwS-dCUbjhPVav7Q1OxaAzJ73Q@mail.gmail.com>
 <Z9LBD_FnO2Gi2vMK@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9LBD_FnO2Gi2vMK@8bytes.org>
Received-SPF: pass client-ip=85.214.250.239; envelope-from=joro@8bytes.org;
 helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 13, 2025 at 12:27:13PM +0100, Jörg Rödel wrote:
> Fine with me. Just note that supporting the current non-IGVM process for
> confidential guests still causes the implicit ABI issue I mentioned
> before. But not being a KVM/QEMU maintainer I can live with that :)

Small addition: Note that IGVM allows for defining multiple platform
targets in one image, among them non-confidential VMs. So IGVM can be
used for those as well.

