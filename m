Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693CECDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 14:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stpQC-0003ou-Rn; Thu, 26 Sep 2024 10:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stpQ4-0003LK-Mj; Thu, 26 Sep 2024 10:24:37 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stpQ2-000610-VC; Thu, 26 Sep 2024 10:24:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 361605C0F77;
 Thu, 26 Sep 2024 14:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F98C4CEC5;
 Thu, 26 Sep 2024 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727360672;
 bh=LWxaj5iNhhP3rDS/oE3mjCOoegafoGUrmfRPy36bfEE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=m42N0InC24vU1kYEW9SHebL1etq04DumO5tIs2og2uYEi+d8943XM3bmsudtIy48T
 DxUIrAPjVhyU8WYVWpPR45oEnXiXKeBct1f5AxjhMDBpTWELMuXxw8UaWB//3T9py2
 mUzdTU8hNYSyYxtnqKtLIU4QyRxeZSGmsTt4COYoWbiUvWe6UOPamskbqB8kFd1rvE
 4MPE06HQQeuJZdXXxWAdotAIKS8DMYOAS3bZOVOFrf7O+SESBSoKCynsM6JiBZWTEY
 xOIpiyCfVUCU2+l76g6nE0lHEJ4A92axQrtAXXVzKcS1El5OgxD0R3r+AXxL8sAKgN
 jiR6gFQQaWUsw==
Date: Thu, 26 Sep 2024 16:24:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 12/15] acpi/ghes: don't crash QEMU if ghes GED is not found
Message-ID: <20240926162428.4ecb16d8@foz.lan>
In-Reply-To: <20240926130909.00006135@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
 <dc61673f18e44b0c169762a084b77acb6a76c738.1727236561.git.mchehab+huawei@kernel.org>
 <20240926130909.00006135@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Thu, 26 Sep 2024 13:09:09 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:17 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Instead, produce an error and continue working
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Make sense as defense in depth. Can we actually hit this for existing
> systems, or is the injection stuff disabled if the ged isn't configured?

What happens is that:

- with memory errors, this logic at acpi_ghes_memory_errors() will
  report the error, just like error_report():

	    if (errp) {
	        error_report_err(errp);
	        return -1;
	    }

  so, no practical changes.

- for injections via script, this will return the error via QMP
  interface, preventing the guest crash.

The script can then handle it the way it wants (right now, it just
prints the error).

Thanks,
Mauro

