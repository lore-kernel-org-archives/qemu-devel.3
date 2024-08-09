Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3425CC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 13:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scPeE-0003HC-3c; Fri, 09 Aug 2024 09:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1scPdx-0003Ew-RX
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 09:27:01 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1scPdt-0000z5-Oa
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 09:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1723209981; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OEEz/RU8Fer2Abp/nDaVpq6T7RsB039LQ+xoO+Qy0h2zt0Hzhft46RfQv+5RLo/wW13OB/cRngcd3ni+o0l9orRIIMfMCqrVhx11U42VOPlTaIZt3p8p/vOo8h0yPKUqOtBQqzT0LWZPC6Ml59lhzSev0en3+7LhBOcbi3sXzKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1723209981;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iPtrO35Ur1EFDKDHPZAgXYQNTpo8DIPfiiAr10jrfyc=; 
 b=VbfH49ZUy/tell5DUlQ0HxtKWlv8+ALKuIfE+eYvW5v0B7QxGXoYVPHIHAIHCyo2lCKN9bvstzDd9xIPlIpHeqWtWfC0440Oc/cWLJsGbq2qMgp6yhW1vtIpbWcBmxTh2iSFd6Ajva3Gw6iBgAHvT0/KxyGpJX/vEcng/2zyFmE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723209981; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=iPtrO35Ur1EFDKDHPZAgXYQNTpo8DIPfiiAr10jrfyc=;
 b=No12TXVCGh7trkcAiDIixEGxSETtW5j4uK4h4UPZ4MMXVcDgeT/rdRnX6Iv6F40l
 Sr1Ui0NperW+ulckSCKmhWAhBjuC3Hlq/3+gcXvZxOsGAxxJ1B+vqZjXnHxXUX+SUQS
 +RqjBjPQ8HGy/ZHDMobR5Lr4tGnsNNNn3ThKEex8=
Received: by mx.zohomail.com with SMTPS id 172320998051543.63093870979651;
 Fri, 9 Aug 2024 06:26:20 -0700 (PDT)
Message-ID: <a4bdb370-1639-4068-b3c8-85f3da870dfe@collabora.com>
Date: Fri, 9 Aug 2024 16:26:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: Correct virgl_renderer_resource_get_info()
 error check
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Helge Konetzka <hk@zapateado.de>,
 Ganapathi Kamath <hgkamath@hotmail.com>
References: <20240129073921.446869-1-dmitry.osipenko@collabora.com>
 <e7c65f33-2438-4c9b-89f9-b1749868e11e@linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <e7c65f33-2438-4c9b-89f9-b1749868e11e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.12;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/9/24 12:16, Philippe Mathieu-Daudé wrote:
> Hi Dmitry,
> 
> On 29/1/24 08:39, Dmitry Osipenko wrote:
>> virgl_renderer_resource_get_info() returns errno and not -1 on error.
> 
> So basically we were ignoring all errors...
> 
> Could some errors just be safely ignored? Because apparently
> this patch now gives troubles, see:
> https://gitlab.com/qemu-project/qemu/-/issues/2490
> Can you help us there?

Hi, Philippe. Replied on the gitlab.

-- 
Best regards,
Dmitry


