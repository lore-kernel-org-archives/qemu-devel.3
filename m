Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B2CC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 04:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woD9h-00045C-QG; Mon, 27 Jul 2026 00:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woD9e-00044O-I9; Mon, 27 Jul 2026 00:41:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woD9b-00055G-R8; Mon, 27 Jul 2026 00:41:30 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66R4emMA047169
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jul 2026 13:40:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=P+n2yqHAEB0fjUEbDZnBYZx+mrptb5uxVUai3KjbmFE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785127249; v=1;
 b=jWs6yonOxfPbIhMbYHVnuGXwNjRQ9IqlE6c3Dvt1RLbedYcO4UbMKkx8Io8gqnmW
 tz3lVexA0oI5/0nyL66+yk436BwN91514TRY2GdFQ8b4pre+KfenWUDVgwHuLUwU
 vf29CMT/0j+0Yk4iKSIL0s0WiZjQqNEX7MRGjAWms44hXIV6nYs8lUcRzNjpVRjD
 20BR9+RVtrkEdgBDEzqkEmeo3+A2MfpRzjuEWs2CLraYT0wP0LrKPHh8LbujfW6S
 jAe7XYJzuLjdpX1qtYl0ToPi03WTAHSHP822MsT0IsS9geXpx8M1NnWYUv74/+W/
 CFBrLZwLC0RZxqhJYIE3Iw==
Message-ID: <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Jul 2026 13:40:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
 <20260726164738-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
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

On 2026/07/27 6:09, Marc-André Lureau wrote:
> On Mon, Jul 27, 2026 at 12:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
>>> Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Not commit log really?
> 
> SSIA, but I can make it longer if it helps.

I agree the subject is sufficient so:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

That said, we can quote docs/devel/style.rst if desired:

 > * Variables declared with g_auto* MUST always be initialized,
 >   otherwise the cleanup function will use uninitialized stack memory

Regards,
Akihiko Odaki

> 
>>
>>> ---
>>>   hw/cxl/cxl-host.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
>>> index 7e744312f1d8..eba13c9e7cba 100644
>>> --- a/hw/cxl/cxl-host.c
>>> +++ b/hw/cxl/cxl-host.c
>>> @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
>>>       MemoryRegion *mr = NULL;
>>>       uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
>>>       MemoryRegion *direct_mr;
>>> -    g_autofree char *direct_mr_name;
>>> +    g_autofree char *direct_mr_name = NULL;
>>>       unsigned int idx = state->hdm_decoder_idx;
>>>
>>>       if (ct3d->hostvmem) {
>>>
>>> --
>>> 2.55.0
>>
>>


