Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A634DC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 18:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tafrw-00083D-Go; Wed, 22 Jan 2025 13:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tafru-00082q-Tf
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 13:54:26 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tafrs-0000A2-PY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 13:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=I+RAdl0lp02P8jaykezfpnKsSPN/r/k2e2HK4p3vaEo=; b=Cjw8tg6xuzTPRyz9U49f8q7uEZ
 2V+A7Cn9N0Dc0KPe7nenb5PkLQBrUxENP+PDqY9iaHOhVnXqQ1SNXiAKAwjsCRhOaGo+GAQkgb8Bv
 Twq303Rus9Fy/c6Ys79gQBD2JoF/dn4aJPlpEGnhlZN+fD5V9dReQtx/+BPn+1WK/X5xkojMvds4I
 3zOerSgu/6KAl8xs3HMfScZnRGecRG6B/GS7gKFaJcLAJVZonCYEBRBU8t15IVPkW66StqpeKPo6C
 Ll+T5X2mJawMT/w1mNc4DXhhjWfhUpgAV/vwzrgIuuL1kFrVUuJCYDhnb8rSUFZUkVroqDlbn2KP0
 06pVwcrDLglotMqepOWlffsh4+mhS4l+rGINbYBMatFUtnTkeFMS0VGqjaFPaNhLaNQmRu5vey22C
 VcipQZYM3il7vzz4fyiwx0SJ49ZobqT839qFihiYvhqf4E312e9k03dQIdaCmMp+kYieWlJmpBEKf
 b4brMUvDd7icIsYEw9dJnQ5pV6ahqb35nAnEmdudPJDRkCgHUY7BbgULxq+uTTQI7JCOLxbRgRNA7
 qv19XK3lP6gnG3b9OKfnMFa2TZlrYoAxMMRsldjXY+IMgKybF+ldrAfJxY8w7+na0bQALFb/6WQYL
 6GppXz+IpQqVVS+Pi45HbAwcR3+NEAhikO1Drgk9Y=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 3/3] coreaudio: Initialize the buffer for device change
Date: Wed, 22 Jan 2025 19:54:16 +0100
Message-ID: <2508753.NHzG6lTPJn@silver>
In-Reply-To: <20250117-coreaudio-v4-3-f8d4fa4cb5f4@daynix.com>
References: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
 <20250117-coreaudio-v4-3-f8d4fa4cb5f4@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, January 17, 2025 7:47:02 AM CET Akihiko Odaki wrote:
> Reallocate buffers when the active device change as the required buffer
> size may differ.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

OTOH it also re-allocates the buffer when the size did not change, but Ok.

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

> ---
>  audio/coreaudio.m | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index b9e1a952ed37..72a6df0f75ee 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -466,6 +466,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>      core->outputDeviceID = deviceID;
>      core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
>      core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
> +    audio_generic_initialize_buffer_out(&core->hw);
>      core->ioprocid = ioprocid;
>  
>      return 0;
> 
> 



