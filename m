Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E159D65C69
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 10:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBWfa-0006eD-2e; Thu, 14 Nov 2024 05:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tBWfU-0006dM-7p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:01:40 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tBWfR-0005S2-Ds
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:01:38 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1731578490; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=d0TNEZ89iRWS4G3yo6TP1KCxtAlZUB6AcWdaVjdpkkItPJp46/HXuHiSNSJHT+oh7wcjpfls1FfeTEq/rhu8N3pf+vPmZ7MugC3+Mmrfg/N6V2xbKgh4CEI1NAhto+ZHLBu835sX+WxlmYdjOV1qnk+NL0nfdLjfnLIHCxpOO70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731578490;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DuV8RbNI2RXYYu/CwWaWdEB/RJHQieRVXRVHwDiJYDM=; 
 b=b1LfwgCl/8rkkhvwh2TJBj2gUg62X9CXrIEe23cg3aCsi1Aevaq2oqclrfRv+/Z/sdN+MyTqAxr1zR1NLcWqFJVu0mZ/AiEtXVutoLGc4y2RfAz2oRh8IJ+lTz3hGNTOB5jTzzgq75/WJGFdixGzpxhdNjIo+ne9MiVnglaXZ24=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731578490; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DuV8RbNI2RXYYu/CwWaWdEB/RJHQieRVXRVHwDiJYDM=;
 b=eJb8Vi5sECT+l7QC+qY0BUqELYb5DF01sftD1rk3cglZ7sTX+GHCSjiLrJZCK/cB
 9joFzm5cnUdotVKp7BAbgmeh3kQ7r7wEQ5pkbjME0SB9fb4MJ5kvXToa/4y33I722UX
 fiOSio8XgQLGEiIkSvUiOg3zilE7kaVMBhz+4w8Q=
Received: by mx.zohomail.com with SMTPS id 1731578489572222.92794326616377;
 Thu, 14 Nov 2024 02:01:29 -0800 (PST)
Message-ID: <820863ab-1f6e-4f67-966c-0add90ef30b3@collabora.com>
Date: Thu, 14 Nov 2024 13:01:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/display: check frame buffer can hold blob
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20241111230040.68470-1-alex.bennee@linaro.org>
 <20241111230040.68470-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20241111230040.68470-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/12/24 02:00, Alex Bennée wrote:
> Coverity reports (CID 1564769, 1564770) that we potentially overflow
> by doing some 32x32 multiplies for something that ends up in a 64 bit
> value. Fix this by first using stride for all lines and casting input
> to uint64_t to ensure a 64 bit multiply is used.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

