Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B903CCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 05:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIK0a-0004fs-HC; Mon, 10 Nov 2025 00:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIK07-0004dL-0Z
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 23:59:41 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIK04-0001n5-Lc
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 23:59:34 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AA4xTI2097452
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Nov 2025 13:59:29 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=g0cM+CmKM+gW8ylYSeAr1xKLS1DY6nWjKtPsU5ISil8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762750769; v=1;
 b=RO6kEiYVCCciISJrRDy2mAq79tUk4kH4ASaNOlhbdPKas3Iqmhk5B1hnninghUxS
 zI+ipvrsLSmSeAArkd4SUBbtR7lrlU9PS1JyKDxh7oqo2OIJHy6DhBrO/uFPgSMo
 OgOzjpIlvpve7OPO+JdCxgzjDY8TBG0XI+s4CoGnOoyuhnaL2QWnGxDdLghlcsKr
 IIvyazFqz9Frq5bSesX0ZTiYXSYcRx/Ve64vW61A+D+p+x1shLqT+aJx8dBHuPLN
 75SZue0XaFJj/MDkWl2eGGlP34L4wRUim2Qf+Dj/06lTj+jcrCkAjZMKBB1ijjDI
 lN144ZQ9zuV8ebC2XnlPHg==
Message-ID: <b7faa80f-8455-4b30-b850-4df78a8c9f5d@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 10 Nov 2025 13:59:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] virtio-gpu: Recreate the resource's dmabuf if
 new backing is attached
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-2-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251109053801.2267149-2-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/09 14:33, Vivek Kasireddy wrote:
> There are cases when a blob resource's backing might get detached
> and re-attached again such as when the underlying object is getting
> migrated in the Guest. In these situations, we need to obtain a new
> dmabuf fd, which can be done by calling virtio_gpu_init_udmabuf().
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

