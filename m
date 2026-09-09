Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DA7C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4MRN-00077w-OF; Wed, 09 Sep 2026 13:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4MRL-00077g-Hh
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:50:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4MRH-0003jU-Pe
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:50:31 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 689HoAYe098874
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 10 Sep 2026 02:50:10 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Zw/AHerNq0kVPdh2DudZxRRbavDO/pesHmAyQxA7h9I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788976210; v=1;
 b=Yl7nBju7jeXHKapiNKe4AvR9znLBYIal3EuFQKYUTSHFG3GcGJ3irx3K87qsAyjq
 E0ovaNuw/ZLGt3SaJ9x0q0G2+aeZJxl6GcPCnTMgG7bqQm9JkGN1Mg6rymV7pC9x
 1muPBEKkI+E87nYB9w8EqaZ3I50cZsDPybf63SHQwSa/4EZM/QV4H5kYkVXqZB4f
 ZHIVMB/vNOK1AUiFmuP69BfuwhmLEUyvF7iQ0j32v78VVdyKFHilydwknswcOvjf
 0OrL41RzbuuLCYBCOjjr5DVOC0xTle9kbb/A4aV132oXtxIQWPGJp67cuf7sK3qD
 h6BpCodpgCQDFgGVzcCQWA==
Message-ID: <c7d44ebf-3e02-435f-afa5-c9a2b378e853@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 10 Sep 2026 02:50:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/24] virtio-gpu: clear res->blob on mapping cleanup
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 swing <swing@mail.exp.sh>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
 <20260909-virtio-gpu-cleanup-v3-2-99266590e79d@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-2-99266590e79d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/09/09 20:03, Marc-André Lureau wrote:
> d3c2da174ca6 ("hw/display/virtio-gpu: Check cursor data presence")
> already prevents the use-after-free on blob cursor after detach.
> 
> Clear res->blob in virtio_gpu_destroy_udmabuf() to keep init/fini
> symmetric, and add LOG_GUEST_ERROR messages in
> virtio_gpu_update_cursor_data() for missing or undersized blobs.
> 
> Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3881
> Reported-by: 章鱼哥@aipy (www.aipyaipy.com)
> Reported-by: swing <swing@mail.exp.sh>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

