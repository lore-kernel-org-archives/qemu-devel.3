Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7918C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 04:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmQQW-0005A0-B0; Sun, 23 Feb 2025 23:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tmQQS-00059e-Ku
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 23:50:41 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tmQQQ-0004S8-4B
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 23:50:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1740372627; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LnuUiLYuX2A6t6pcqaqOGijciNx/Egi7Aa4msYxk8dw0mg5dZhoFKZhs2W+cFZMY4A3j8VOGo/Ubs0pOSul8ZZ+zUgDFJUtnrjBryYvncnXjDt8DoTbSM7btW+PAK3PDPL6KDsVpdSw7iZphf2XrNZo2wbrDFhxTkRqmjFCEXeo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1740372627;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=o7Dnn7pA1ekE7jybvzLMCywUC0IrLOl07KsU5y3rGnw=; 
 b=VSoNE1e+KfeEfsLdoOxR/vx0MTCyFQCbqZilT8Jto2nraEQfs8XoQ85wEzrjSImSQEI/HpJJShPbsIynOcNBQr5Ui3JXJHJ7KhmBXC88KpOEuyIBCFbFh4v9xqtmqYfSBSsBxgJ0S9qpLlkDXt2m3zqZlCp8MTfMrHCyh+LY+sM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740372627; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=o7Dnn7pA1ekE7jybvzLMCywUC0IrLOl07KsU5y3rGnw=;
 b=GW51DYeqaLWD1CWwfDPvKKFZ74lNL002ez0fLwSmhr8g2F0YCzYqMHuPFTHC8dCO
 3YegRlUaPkd3SzGy3uBZb7CaqOUHx6eYZkX0j9CQ9ommUXjwPc72YGhXyN4b6BZI1ew
 RdGw95P0LL9nvU8jOEGUdmLLVeeK9/MrD4wI3PYs=
Received: by mx.zohomail.com with SMTPS id 1740372625845196.12598924053236;
 Sun, 23 Feb 2025 20:50:25 -0800 (PST)
Message-ID: <f0a9a074-66d4-47d1-8ea2-58bbffa18f6d@collabora.com>
Date: Mon, 24 Feb 2025 07:50:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/display: add blocklist for known bad drivers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250221160101.2318357-1-alex.bennee@linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250221160101.2318357-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 2/21/25 19:01, Alex Bennée wrote:
...
> diff --git a/stubs/host-gpu.c b/stubs/host-gpu.c
> new file mode 100644
> index 0000000000..7bf76ee4f6
> --- /dev/null
> +++ b/stubs/host-gpu.c

Looks okay

Nit: host-gpu is a too generic name, IMO. Name should reflect Vulkan
dedication, like host-vk-gpu.c for example.

-- 
Best regards,
Dmitry

