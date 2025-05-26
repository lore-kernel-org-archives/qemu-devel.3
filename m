Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A77EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 15:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZUK-0003dA-7e; Mon, 26 May 2025 11:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uJZUI-0003bI-AZ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:11:38 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uJZUG-00049K-6N
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:11:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748272273; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a3PeFozq2a+UE2W3GQxnsKvM8UE+zUlgocLFCVaKPsStoc2iD5A/do64vDI6Kug8yiLa5bDZWbegM7hdVy7alvE+V2Us3Pnsg7Q3r51Len1MFOgIuT2ibZZzwnpgzHqlmANMjyant+dyv/A1KZIy0V+FtXnzr/blLBbUkRvAG70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748272273;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sFywvsH+FbU1GfGgUHGa4FRs0PlNtjWljaacFJHVYss=; 
 b=TfZ5tYzyVqaSiiR1ttAcwNflPx7ecO9qNArDgyckrQeIxZGTBLSOeffeH6eFX1aN7j9pNOT618nQAdQEijK1oJSjhClaZ8i3Ri1LQ5Ql9Ueu8rvhI8l8JDyVENr0h0DJLfVj7BpL5PchdhuzYkPeViKnUlsnmbT4aA8bceVHJgU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748272273; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=sFywvsH+FbU1GfGgUHGa4FRs0PlNtjWljaacFJHVYss=;
 b=Zu25hUpGYbcPi0h+fgWTzDmUfP29jsL0iy7nV04Hwu0wCguSpZXH0mXbOeeP11yw
 1HT7JTWrK79ZkQP+cZYn8Kptg9/KvJcAcHro40IIyVIp5P1ATFj6eKvOX2XPned/RvT
 qdhZFsKMkgqaaHny4bawE5gv9QcNaZxq/PeMojBg=
Received: by mx.zohomail.com with SMTPS id 1748272269462331.2828269970603;
 Mon, 26 May 2025 08:11:09 -0700 (PDT)
Message-ID: <284cd0dd-86f3-4659-ae0d-73e17e328bd8@collabora.com>
Date: Mon, 26 May 2025 18:11:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/10] virtio-gpu: Handle virgl fence creation errors
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250523233305.433424-1-dmitry.osipenko@collabora.com>
 <20250523233305.433424-4-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250523233305.433424-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
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

On 5/24/25 02:32, Dmitry Osipenko wrote:
> @@ -872,6 +872,8 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cmd)
>  {
>      bool cmd_suspended = false;
> +    uint32_t flags;

Realized I re-introduced the build warning with older virglrenderer.
Will fix in v13.

-- 
Best regards,
Dmitry

