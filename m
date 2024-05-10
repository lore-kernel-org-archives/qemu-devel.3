Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9D1C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 16:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5TBr-0000el-EG; Fri, 10 May 2024 12:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5TBo-0000eD-NW
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:33:44 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5TBn-0008Lf-4o
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715358821;
 bh=kgNkRdrKGceZKPHJlaYesI/PTtma1hbVJAK9t6KdqUs=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=H2MPiGAiwcE/HIhCHhw/wBvNUsvOeiHB9ph4+Z1pyNu5Syv6Cd9obJQlgAKX4R6y3
 L3O2gKVk1sRHcj7UW96ejN3k/PwWcFSydqoWeZX0yA5eFwksaTxyRSJgJIsIIh6YXy
 fCX/UTn0GZT3tzI5v+s82qE3Glj8Kza85+dRvQXhDlY7WT86hG0/00swkREt4z8GDt
 CdFjdfYkufDuADGISnnEggxnLUVZjss8LPWBeczgeZQqdiT6TpSdSQbQfPWwjWrBDJ
 slP37miFnn+piDuAcToY8Z/2I+US/Wy/+pTx7tVeBqjh6a+2cJ5Dm2iJvV9OAU1aPI
 wXnyrCEG8QNpw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 24A963782009;
 Fri, 10 May 2024 16:33:39 +0000 (UTC)
Message-ID: <bb84b9f3-4889-4acb-949f-f794522eb7a8@collabora.com>
Date: Fri, 10 May 2024 19:33:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/11] virtio-gpu: Support suspension of commands
 processing
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-8-dmitry.osipenko@collabora.com>
 <8a153bf1-f86c-46c8-a29a-08e9a0197dc3@daynix.com>
 <4c6b3ca0-4813-48f4-87f8-a94e911c02d3@collabora.com>
 <10337ba0-70ce-436c-9cac-398851ebdfc9@daynix.com>
 <5b240c8a-f1c5-487f-a528-cbb4f440094f@collabora.com>
 <0360512c-eb25-4c93-adb3-7f43395ae699@daynix.com>
 <8007338d-72ea-4896-89d3-ff98c66f979e@collabora.com>
 <e4c9c32d-31ad-414c-8713-9faee92f81e9@daynix.com>
 <d7e9d5e6-f4d3-402f-b803-7ef6b74c8039@collabora.com>
Content-Language: en-US
In-Reply-To: <d7e9d5e6-f4d3-402f-b803-7ef6b74c8039@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/10/24 19:12, Dmitry Osipenko wrote:
> On 5/10/24 13:56, Akihiko Odaki wrote:
>> On 2024/05/09 21:39, Dmitry Osipenko wrote:
>>> On 5/5/24 09:37, Akihiko Odaki wrote:
>>>> On 2024/05/02 4:02, Dmitry Osipenko wrote:
>>>>> On 4/27/24 08:48, Akihiko Odaki wrote:
>>>>>>>
>>>>>>> The VIRTIO_GPU_FILL_CMD() macro returns void and this macro is
>>>>>>> used by
>>>>>>> every function processing commands. Changing process_cmd() to return
>>>>>>> bool will require to change all those functions. Not worthwhile to
>>>>>>> change it, IMO. >
>>>>>>> The flag reflects the exact command status. The !finished +
>>>>>>> !suspended
>>>>>>> means that command is fenced, i.e. these flags don't have exactly
>>>>>>> same
>>>>>>> meaning.
>>>>>>
>>>>>> It is not necessary to change the signature of process_cmd(). You can
>>>>>> just refer to !finished. No need to have the suspended flag.
>>>>>
>>>>> Not sure what you're meaning. The !finished says that cmd is fenced,
>>>>> this fenced command is added to the polling list and the fence is
>>>>> checked periodically by the fence_poll timer, meanwhile next virgl
>>>>> commands are executed in the same time.
>>>>>
>>>>> This is completely different from the suspension where whole cmd
>>>>> processing is blocked until command is resumed.
>>>>>
>>>>
>>>> !finished means you have not sent a response with
>>>> virtio_gpu_ctrl_response(). Currently such a situation only happens when
>>>> a fence is requested and virtio_gpu_process_cmdq() exploits the fact,
>>>> but we are adding a new case without a fence.
>>>>
>>>> So we need to add code to check if we are fencing or not in
>>>> virtio_gpu_process_cmdq(). This can be achieved by evaluating the
>>>> following expression as done in virtio_gpu_virgl_process_cmd():
>>>> cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE
>>>
>>> This works, but then I'll add back the res->async_unmap_in_progress
>>> because we need to know whether unmapping has been started.
>>>
>>
>> Isn't the command processing paused when an unmapping operation is in
>> progress?
> 
> The virtio_gpu_process_cmdq() continues to be invoked periodically while
> unmapping is paused. Should be console doing that, see
> virtio_gpu_handle_gl_flushed().

Though, we're now blocking the render, and thus,
virtio_gpu_process_cmdq() won't do anything while cmd is paused. I'll
check that nothing else is missed and then won't add
`async_unmap_in_progress` in v11, thanks!

-- 
Best regards,
Dmitry


