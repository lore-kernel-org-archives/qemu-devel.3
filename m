Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A481FC9ECA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 05:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vykEZ-0002JG-Pm; Sat, 07 Mar 2026 00:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vykEW-0002Is-Uw
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 00:29:49 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vykES-00026B-9B
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 00:29:46 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6275TJmU061539
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Mar 2026 14:29:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8wjVO4GWeRHE64ThAd5zjI57iADAPSmfWcG2KV13YL8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772861363; v=1;
 b=I8EAvNMgB7Pskd6HfiDxQv2j7lpSMEmyr9I4sOXwqzqi/xC42Iedn1wk93YURx1j
 hI5+1ctHZFO2cSFLz6zKzi935xc+QumbRjaLueWfx5PftbfZcPjffk5ygBJUGLBZ
 EXjHt7n7haRzPDFsEBuJ/6RoKK0fuASLtBMWFhLI/00JWoCrNY57tnk5AtX702IJ
 s0OBnTTedcsjGPlzAUKy3Z7MzjoXHXdyxIEXMoGEQGdcMlHaT7a4Y8OCOtY/Q/dI
 jth+Ln6cQmjiBsBYBt7cHt5ieNOo1xnOac2KqEaLAg88/yhXkqMGWUTi0+/E6cIM
 wa9k2soLuzpxv8VeQrKmKA==
Message-ID: <61e7f8dc-07c3-4300-b22e-15037c3ba10f@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Mar 2026 14:29:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] coreaudio: Initialize the buffer for device change
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-6-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <1921566.atdPhlSkOF@weasel>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <1921566.atdPhlSkOF@weasel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/04 20:39, Christian Schoenebeck wrote:
> On Wednesday, 4 March 2026 07:16:59 CET Akihiko Odaki wrote:
>> Reallocate buffers when the active device change as the required buffer
>> size may differ.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>> ---
>>   audio/coreaudio.m | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>> index 23c3d1f80ac5..e4ec1df971c8 100644
>> --- a/audio/coreaudio.m
>> +++ b/audio/coreaudio.m
>> @@ -471,6 +471,7 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
>> core->device_id = device_id;
>>       core->device_frame_size = device_frame_size;
>>       core->hw.samples = core->buffer_count * core->device_frame_size;
>> +    audio_generic_initialize_buffer_out(&core->hw);
>>       core->ioprocid = ioprocid;
>>
>>       return 0;
> 
> There is no specific reason to insert that call between the struct
> initializers here, or is there? I mean the device is suspended at this point,
> so it should not matter. Just looks a bit weird.

I will move it after core->ioprocid = ioprocid.

Regards,
Akihiko Odaki

> 
> But in general, LGTM:
> 
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> 
> 
> 


