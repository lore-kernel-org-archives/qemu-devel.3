Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F5ACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 04:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8WSG-0006sy-Im; Tue, 14 Oct 2025 00:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8WSE-0006sc-Gr
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:16:06 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8WS9-0005MX-GL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:16:06 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59E4FcP2017409
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 14 Oct 2025 13:15:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZtSgFfbM/8eIvj2un+pdAt65morwwPoDEp20Jn/BIHk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760415338; v=1;
 b=pZRd33/jF28KfW4KvPV9mF4oIllmcPvDUjDoqzZQSfNoAQC5hIMN1HGM5RS6PYCW
 8SvmYl76PljS/7nTE+5nYWlwuMJWzDaT7Z22sLIqYYWS+L9MYLCA79Cu8rmPlM6y
 RZlyyOX32J5kNLnhoLAROZosbFcf+7bhfYZ6wNRHF5Eh+ykteC5jd7Ejv0/oi53I
 LIeusqyS4ax6FciSHf6Nva5yb4KaowqcnZGHi4283ITHqekHgZKXBdDP8o6Ly61y
 bV287BnqhTl80BKFRm5xDVe5yz/TRdn9VFQ8iUtFcjte1rxsmud4lhoTpsWtqNCP
 Qgwqf9Mv9oRibyFnnLhSow==
Message-ID: <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 14 Oct 2025 13:15:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-3-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/13 15:54, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify blob
>> resources
>>
>> On 2025/10/04 8:35, Vivek Kasireddy wrote:
>>> The res->blob pointer may not be valid (non-NULL) for some blobs
>>> where the backing storage is not memfd based. Therefore, we cannot
>>> use it to determine if a resource is a blob or not. Instead, we
>>> could use res->blob_size to make this determination as it is
>>> non-zero for blob resources regardless of where their backing
>>> storage is located.
>>
>> I think this patch is no longer necessary since now you add code to
>> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-udmabuf: Create
>> dmabuf for blobs associated with VFIO devices".
> Right, but given that mmap() can still fail for various reasons and this
> use-case can work as long as dmabuf creation succeeds, I think it makes
> sense to not rely on res->blob to determine if a resource is blob or not.

I think the code will be simpler by making resource creation fail when 
mmap() fails, and I am concerned that the guest may mulfunction with 
such an incomplete resource.

To motivate the proposed patch, there should be a use-case that requires 
to have a resource without mmap(), not one that "can work" a resource 
without mmap(). It is extraneous complexity otherwise.

Such a use case should be explained in the patch message and perhaps 
also with a comment in the code. The current patch message needs an 
update as it sounds like it is unnecessary when theere is code to mmap() 
VFIO-based backing storage, which this series has already gained.

Regards,
Akihiko Odaki

