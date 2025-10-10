Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F50CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 04:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v74bn-0005R7-9z; Fri, 10 Oct 2025 00:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v74bk-0005Qx-QP
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:19:56 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v74bY-0007M6-Fx
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:19:56 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59A4JLCc096751
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Oct 2025 13:19:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wPc72Ut1qAzINkQDAP8REZMegejF3ZIeskMVXsy7BH0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:From:Subject:To;
 s=rs20250326; t=1760069961; v=1;
 b=eAHLcgTFm7Ukx9H09bSlaRcn0iCXSElbXSAUrhTg6Rrfe5PM+HUca7JnJSJr6Sja
 /oYdvdZU7ox6BkK6uS1u3lz9xEXRkDuQh6EuplQ0UKUAepTV8OjvK42wsNfwcCEL
 92402NqdBzCKSAfOmI7kiYtPdIr+dNR36wer4OfRDUaxfrBWAFwC5wwfep+ZMlTs
 wQYPXvgaMN+hnLoP0VGCgcJLZbmhr2oO5M9FFUHmdIIW2NUlgwdBF50LqgzEduPa
 T9UIXhGBIe0ZYYFzl4pt0TGWBV0phGtP2weBeEgAfk2jiQCaVAFshOMLuMscqt+S
 bcyQ+GhhShgBFRX9rzd3hQ==
Message-ID: <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 10 Oct 2025 13:19:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-3-vivek.kasireddy@intel.com>
Content-Language: en-US
In-Reply-To: <20251003234138.85820-3-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/10/04 8:35, Vivek Kasireddy wrote:
> The res->blob pointer may not be valid (non-NULL) for some blobs
> where the backing storage is not memfd based. Therefore, we cannot
> use it to determine if a resource is a blob or not. Instead, we
> could use res->blob_size to make this determination as it is
> non-zero for blob resources regardless of where their backing
> storage is located.

I think this patch is no longer necessary since now you add code to 
mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-udmabuf: Create 
dmabuf for blobs associated with VFIO devices".

