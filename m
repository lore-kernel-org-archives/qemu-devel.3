Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144F7D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3k9-0008Ri-2l; Mon, 01 Dec 2025 08:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3k6-0008OC-7Y
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:15:02 -0500
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([63.178.132.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3k4-0006wd-AT
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764594900; x=1796130900;
 h=message-id:date:mime-version:to:cc:references:from:
 in-reply-to:content-transfer-encoding:subject;
 bh=+AIf40NNtHyvJ9r1L27kk0sQDl1WVhJi9nM8Ar0sOg0=;
 b=jmM8EGehUPBQUQIFMPRbo5Jio8DzrhuNpw+GBQKvcrSyBy/z4w1n0A1Z
 /NunuO7unYC/bnKgVLONFACmZ8N8dtdpVA4hzeXG9fWJ0xXWLaK/GQ7xa
 co8/HWeAZ39t6VeuVk0VEVQ65AhyxTXDDytEL/ZnEgKD6Cus926E5Ve4M
 /3O61MYlkh/aYdN2wSVb2setEtitIoJhAPmsnyrsRoxopv1prfHm3CvDu
 dOGaFoUaZPId7AsH1NdIZOrgWOKkvkDOWm0EvPjMqGZC+P8EnrEcmculB
 RZDtrkZcz8TJdMWaTFSCpNJwFUN25rJzYLRB8Idl6v1Q+xvM8/05++fgt w==;
X-CSE-ConnectionGUID: rvClp81iSly/vZdFIB099A==
X-CSE-MsgGUID: TmL5nczTSRiyIX8DWPtkwg==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; d="scan'208,217";a="5950605"
Subject: Re: [RFC PATCH 2/4] hw/acpi: add new fields in VMClock ABI
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
 by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:11:51 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:30436]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.247:2525]
 with esmtp (Farcaster)
 id b0a5c08e-298f-4ae7-8ee9-20cf36ade27d; Mon, 1 Dec 2025 13:11:51 +0000 (UTC)
X-Farcaster-Flow-ID: b0a5c08e-298f-4ae7-8ee9-20cf36ade27d
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 13:11:43 +0000
Received: from [0.0.0.0] (10.13.181.70) by EX19D012EUA001.ant.amazon.com
 (10.252.50.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 13:11:39 +0000
Message-ID: <cb2e2892-3e11-4e1e-b0e4-7191a78cc497@amazon.es>
Date: Mon, 1 Dec 2025 14:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>, <bchalios@amazon.es>
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-4-bchalios@amazon.es> <87qztenykd.fsf@redhat.com>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
In-Reply-To: <87qztenykd.fsf@redhat.com>
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.13.181.70]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D012EUA001.ant.amazon.com (10.252.50.122)
Received-SPF: pass client-ip=63.178.132.221;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_HTML_ONLY=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-cite-prefix">On 12/1/25 14:04, Cornelia Huck wrote:<span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite" cite="mid:87qztenykd.fsf@redhat.com">
      <pre wrap="" class="moz-quote-pre">
On Mon, Dec 01 2025, "Chalios, Babis" <a class="moz-txt-link-rfc2396E" href="mailto:bchalios@amazon.es">&lt;bchalios@amazon.es&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">VMClock now supports a vm_generation_counter field in the struct it
exposes to userspace. The field signals a disruption that happened due
to a guest loaded from a snapshot.

Moreover, VMClock now optionally supports device notifications when the
seq_count changes to a new even value.

Signed-off-by: Babis Chalios <a class="moz-txt-link-rfc2396E" href="mailto:bchalios@amazon.es">&lt;bchalios@amazon.es&gt;</a>
---
 include/standard-headers/linux/vmclock-abi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please either do a full linux-headers update against a specific Linux
kernel version, or mark this as a placeholder patch if the code is not
yet merged.

</pre>
    </blockquote>
    <br>
    Indeed, that's a placeholder. What's the process to mark this as a
    placeholder?<br>
    <br>
    Cheers,<br>
    Babis
  </body>
  <lt-container></lt-container>
</html>

