Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46194C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wobYK-0006UG-Jj; Tue, 28 Jul 2026 02:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobYJ-0006U3-1E; Tue, 28 Jul 2026 02:44:35 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobYF-0001rY-VD; Tue, 28 Jul 2026 02:44:34 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S6he3b021283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jul 2026 15:43:40 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=LzBvc4QFC8CxCqpPgeLUIT+5t6SXNYVeTUkmA0K0p6Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785221021; v=1;
 b=q7uocdtwCcoAT/zxfuxXSZqRJynUoTZdYmTNCMBVMpw/uB6uR26FkaaTz5Hd4+DW
 Y+AC7WvK202li+NkKtv5jskowBANnNTQabrc5S1Cc9Nr3aDz0nommTdFKUs0ZxpP
 Ozd1vV0TK1XlusEyFLK8ZyFIGrnSZK1pelvWl5OB6Sb2zYEhgBEOpS8pufjfOxO5
 Ddv1pWX2F+pLGN8jd3mbNla9b7V7X1j9n0+Op8a2jXUC61w1C36mb5wMFu4vSuDc
 QJQ/+Y01cFdQeOKFgCIUfi2sKKobzj6rwMAFwqtPuY7N+g1zo/TKUJ8IGphh1Tah
 X+TdvEO7SzcuHbuddOaA/Q==
Message-ID: <7540f97d-8538-47cc-b075-48b4ff4d8d56@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 15:43:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/i3c: fix default return value of d2_i3c_send()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
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
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-6-d0c4831ed7ea@redhat.com>
 <0206544e-1d58-4040-9cd1-f36c917d88cc@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0206544e-1d58-4040-9cd1-f36c917d88cc@oss.qualcomm.com>
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

On 2026/07/27 16:40, Philippe Mathieu-Daudé wrote:
> On 26/7/26 22:44, Marc-AndrÃ© Lureau wrote:
>> Fixes: 208772a189f9 ("hw/i3c/dw-i3c: Add data TX and RX")
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/i3c/dw-i3c.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
>> index 6386499dd9fc..7b887fbd60cb 100644
>> --- a/hw/i3c/dw-i3c.c
>> +++ b/hw/i3c/dw-i3c.c
>> @@ -430,7 +430,7 @@ static int dw_i3c_send_start(DWI3C *s, uint8_t 
>> addr, bool is_recv, bool is_i2c)
>>   static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t 
>> num_to_send,
>>                          uint32_t *num_sent, bool is_i2c)
>>   {
>> -    int ret;
>> +    int ret = 0;
> 
> So IIUC the issue is being called with num_to_send=0.
> Can that happen? Apparently no. Could we assert it is
> non-zero?

I kind of prefer to apply the same logic I suggested for walk_gpt():
https://lore.kernel.org/qemu-devel/d9c4321c-ed39-4da6-926b-bae4b1491a52@rsg.ci.i.u-tokyo.ac.jp/

i.e., if num_to_send == 0, there is no work to do, so the default value 
should tell that no error happened. ret = 0 does that.

Regards,
Akihiko Odaki

