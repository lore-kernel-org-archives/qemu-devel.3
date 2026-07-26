Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B43BC531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 07:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wntQN-0002lv-2s; Sun, 26 Jul 2026 03:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wntQL-0002lY-Fv; Sun, 26 Jul 2026 03:37:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wntQJ-0003wp-Nv; Sun, 26 Jul 2026 03:37:25 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q7asJp017140
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 26 Jul 2026 16:36:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6BJYXjq4E/mraJBzuA/SBz5lQcftOsixHYEkg4LE2BI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785051415; v=1;
 b=DymS5woP9pjja5iVcgJijDg2BORXKSyfZq6OCjrGoTvcs7fLUamp5pRqz08YwE0+
 rkgmbQNdywjWZTOT8Yd8/DUqPEI3b3S7SLojXokNZMraTrQinmClpF9e79V4yPvE
 jpbv7B57KZ2JFV2+tpST8ZydZ+fZ/EGfpix1PMlV4Vr2Dk70IpmMCQ8KUzAq7MT6
 B4NLZVMeGOJDtqI6NT3QR9GucNrGurV/uGvWBKT2S65B/YYxI8DxVI5RQtqkym8o
 A+Bt/SbnUwrUomP+OahbGhr5R+rmzPconhMhPg5oqjrNIuMou94J57WOpkDrO5Xa
 Ho8KQrkN8jvuwJ+fJe8Zxg==
Message-ID: <c1bcbefe-d2fb-4db5-a1ed-afebd0c74213@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 16:36:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] block/blkio: fix error return value on getlength()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-2-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-2-5c9a6ce7b96a@redhat.com>
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

On 2026/07/25 23:00, Marc-André Lureau wrote:
> Negative values should be return for errors.

Nit: s/return/returned/

> 
> It also helps with GCC false-positives:
> ../block/blkio.c: In function ‘blkio_co_getlength’:
> ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>    943 |     if (ret < 0) {
>        |        ^
> 
> Fixes: fd66dbd424 ("blkio: add libblkio block driver")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/blkio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index fb8bec27d71a..d2ba2a4d58dc 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -935,13 +935,13 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
>   {
>       BDRVBlkioState *s = bs->opaque;
>       uint64_t capacity;
> -    int ret;
> +    int ret = -1;

Initializing a variable with a dummy value can suppress a useful 
warning. Replacing WITH_QEMU_LOCK_GUARD() with QEMU_LOCK_GUARD() will 
fix it without introducing a dummy value and also result in a bit 
simpler code.

Regards,
Akihiko Odaki

>   
>       WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>           ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
>       }
>       if (ret < 0) {
> -        return -ret;
> +        return ret;
>       }
>   
>       return capacity;
> 


